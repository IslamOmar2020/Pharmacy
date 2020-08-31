//
//  AddCategoriesDetalisVC.swift
//  Pharmacy
//
//  Created by Islam Omar on 8/29/20.
//  Copyright © 2020 Islam Omar. All rights reserved.
//
import UIKit
import Firebase
import FirebaseFirestore
import SDWebImage
import FirebaseStorage

class AddCategoriesDetalisVC: UIViewController {
    
    @IBOutlet var addcategoriesdetalisV: UIView!
    @IBOutlet weak var addcategoriesdetalisTV: UITableView!
    @IBOutlet weak var itemimage: UIImageView!
    @IBOutlet weak var itemprice: UITextField!
    @IBOutlet weak var itemcount: UITextField!
    @IBOutlet weak var pharmacyaddress: UITextField!
    @IBOutlet weak var pharmacyname: UITextField!
    @IBOutlet weak var itemname: UITextField!
    let imagePicker = UIImagePickerController()
    
    var categoriesdetalies = [CategoryDetails]()
    let ref = Firestore.firestore()
    var parameters = [String:Any]()
    override func viewDidLoad() {
        super.viewDidLoad()
        getallCategoriesDetalis()
        addcategoriesdetalisV.showSpinner(onView: self.view)
        
        initltable()
        itemimage.isUserInteractionEnabled = true
        itemimage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(initPicker)))
    }
    
    
    func userlist(completion: @escaping (Bool, [User]) -> ()){
//
//                ref.collection("users").getDocuments() { (querySnapshot, err) in
//                    if let err = err {
//                        print("Error getting documents: \(err)")
//                        completion(false, users)
//                    } else {
//                        for document in querySnapshot!.documents {
//                            print("\(document.documentID) => \(document.data())")
//                        }
//                        completion(true, users)
//                    }
//                }
    }
    
    @IBAction func addCategoriesDetalis(_ sender: Any) {
        if itemname.text!.isEmpty || itemcount.text!.isEmpty || itemprice.text!.isEmpty || itemimage!.image == nil  {
            print("Pleaase Fill all Fields")
        }else{
            self.addcategoriesdetalisV.showSpinner(onView: self.view)
            uploadImage(image: itemimage.image!) { (url) in
                if url == nil {
                    print("Error fetching docs:")
                } else {
                    let image = url!
                    self.parameters["itemname"] = self.itemname.text!
                    self.parameters["itemcount"] = self.itemcount.text!
                    self.parameters["itemprice"] = self.itemprice.text!
                    self.parameters["itemimage"] = image.absoluteString
                    do{
                        let categoriesdetaleisref = self.ref.collection("CategoriesDetalis")
                        
                        try? categoriesdetaleisref.addDocument(data: self.parameters, completion: { err in
                            if let error = err {
                                print(error.localizedDescription)
                                self.showAlertMessage(title: "error", message: "\(error.localizedDescription)")
                                
                            }
                            print("sccussfly")
                            self.itemname.text = ""
                            self.itemcount.text = ""
                            self.itemprice.text = ""
                            // self.categoriesimage.image.
                            
                            self.addcategoriesdetalisTV.reloadData()
                            self.addcategoriesdetalisV.removeSpinner()
                            
                            
                        })
                    }
                    catch let error {
                        self.showAlertMessage(title: "error", message: "\(error.localizedDescription)")
                    }
                    
                }
            }
        }
        
    }
    func getallCategoriesDetalis() {
        let userReference = Firestore.firestore().collection("CategoriesDetalis")
        userReference.getDocuments { (snapshot, error) in
            if let err = error {
                print("Error fetching docs: \(err)")
            } else {
                guard let snap = snapshot else {return}
                
                for document in snap.documents {
                    
                    let data =  document.data()
                    let name = data["itemname"] as? String ?? ""
                    let image = data["itemimage"] as? String ?? ""
                    let count = data["itemcount"] as? String ?? ""
                    let price = data["itemprice"] as? String ?? ""
                    print(data)
                    
                    let    comedata = CategoryDetails(itemname: name, itemimage: image , itemcount: Int(count)! , itemprice: Int(price)!)
                    
                    self.categoriesdetalies.append(comedata)
                    //print(comedata)
                }
                
                self.addcategoriesdetalisTV.reloadData()
                self.addcategoriesdetalisV.removeSpinner()
            }
        }
        
    }
}

extension AddCategoriesDetalisVC : UITableViewDataSource , UITableViewDelegate {
    
    func initltable(){
        addcategoriesdetalisTV.dataSource = self
        addcategoriesdetalisTV.delegate = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesdetalies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = addcategoriesdetalisTV.dequeueReusableCell(withIdentifier: "AddCategoriesTVC",for: indexPath) as! AddCategoriesTVC
        let categoriesdetal = categoriesdetalies[indexPath.row]
        let image = categoriesdetal.itemimage
        cell.categoriesnameLbl?.text = categoriesdetal.itemname
        let imageUrl = URL(string: image!)
        cell.categoriesimage.sd_setImage(with: imageUrl, completed: nil)
        
        return cell
    }
    
}





extension AddCategoriesDetalisVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc  func initPicker(){
        let imagepickerV = UIImagePickerController()
        imagepickerV.delegate = self
        imagepickerV.allowsEditing = true
        imagepickerV.sourceType = .photoLibrary
        self.present(imagepickerV, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard var image = info[.originalImage] as? UIImage  else { return
        }
        picker.dismiss(animated: true, completion: nil)
        itemimage.image = image
        // uploadImage(image: image)
    }
    
    
    
    func uploadImage(image :UIImage ,comlition: ((URL?)->Void)?){
        
        guard let data = image.jpegData(compressionQuality: 0.2) else { return  }
        let imagename = UUID().uuidString
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        let ref = Storage.storage().reference(withPath: "images").child("imagename")
        ref.putData(data, metadata: nil) { (metadata, error) in
            if error != nil{
                comlition?(nil)
                print(error?.localizedDescription)
                return
            }
            ref.downloadURL { (url, error) in
                if error != nil{
                    print(error?.localizedDescription)
                    return }
                comlition?(url!)
                print(url)
            }
            print("upload Succesful")
            
        }}
    
}

