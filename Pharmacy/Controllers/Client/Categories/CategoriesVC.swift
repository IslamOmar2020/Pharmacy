//
//  CategoriesVC.swift
//  Pharmacy
//
//  Created by Islam Omar on 8/27/20.
//  Copyright © 2020 Islam Omar. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import SDWebImage
import FirebaseStorage
class CategoriesVC: UIViewController {
    
    @IBOutlet weak var categoriesnameTF: UITextField!
    
    @IBOutlet weak var categoriesimage: UIImageView!
    @IBOutlet weak var categoriesTV: UITableView!
    let imagePicker = UIImagePickerController()
    
  var categories = [Category]()
    let ref = Firestore.firestore()
    var parameters = [String:Any]()
    override func viewDidLoad() {
        super.viewDidLoad()
        getallCategories()
        initltable()
        categoriesimage.isUserInteractionEnabled = true
        categoriesimage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(initPicker)))
    }
    
    
    func userlist(completion: @escaping (Bool, [User]) -> ()){
        
        //        ref.collection("users").getDocuments() { (querySnapshot, err) in
        //            if let err = err {
        //                print("Error getting documents: \(err)")
        //                completion(false, users)
        //            } else {
        //                for document in querySnapshot!.documents {
        //                    print("\(document.documentID) => \(document.data())")
        //                }
        //                completion(true, users)
        //            }
        //        }
    }
    
   @IBAction func addCategories(_ sender: Any) {
    if categoriesnameTF.text!.isEmpty ||  categoriesimage!.image == nil  {
            print("Pleaase Fill all Fields")
        }else{
            
            uploadImage(image: categoriesimage.image!) { (url) in
                if url == nil {
                    print("Error fetching docs:")
                } else {
                    let image = url!
        self.parameters["categoriesname"] = self.categoriesnameTF.text!
                   
        self.parameters["categoriesimage"] = image.absoluteString
                    do{
                        let categoriesref = self.ref.collection("Categories")
                        
                        try? categoriesref.addDocument(data: self.parameters, completion: { err in
                            if let error = err {
                                print(error.localizedDescription)
                                self.showAlertMessage(title: "error", message: "\(error.localizedDescription)")
                                
                            }
                            print("sccussfly")
                            self.categoriesnameTF.text = ""
                         
                            self.categoriesimage.image = nil
                            
                        })
                    }
                    catch let error {
                        self.showAlertMessage(title: "error", message: "\(error.localizedDescription)")
                    }
                    
                }
            }
        }
        
    }
     func getallCategories() {
        let userReference = Firestore.firestore().collection("Categories")
        userReference.getDocuments { (snapshot, error) in
            if let err = error {
                print("Error fetching docs: \(err)")
            } else {
                guard let snap = snapshot else {return}
                
                for document in snap.documents {
                    
                    let data =  document.data()
                    let name = data["categoriesname"] as? String ?? ""
                    let image = data["categoriesimage"] as? String ?? ""

                    print(data)
                    
                    let    comedata = Category(categoryname: name, categoryimage: image)
                    
                    self.categories.append(comedata)
                //print(comedata)
                }
               
                
                self.categoriesTV.reloadData()
                
            }
            }
       
    }
}

extension CategoriesVC : UITableViewDataSource , UITableViewDelegate {
    
    func initltable(){
        categoriesTV.dataSource = self
        categoriesTV.delegate = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = categoriesTV.dequeueReusableCell(withIdentifier: "CategoriesTVC",
                                                  for: indexPath) as! CategoriesTVC
        let category = categories[indexPath.row]
        let image = category.categoryimage
        cell.categoriesnameLbl?.text = category.categoryname
        let imageUrl = URL(string: image!)
        cell.categoriesimage.sd_setImage(with: imageUrl, completed: nil)
      
        return cell
    }
    
}





extension CategoriesVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
        categoriesimage.image = image
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

