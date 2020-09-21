//
//  AddPharmacyVC.swift
//  Pharmacy
//
//  Created by Islam Omar on 8/4/20.
//  Copyright © 2020 Islam Omar. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage
import FirebaseFirestoreSwift
import SDWebImage
class AddPharmacyVC: UIViewController {
    var pharmacies =  [Pharmacy]()
    var pharmobject : Pharmacy!
    @IBOutlet weak var pharmacyaddressTF: UITextField!
    @IBOutlet weak var pharmacyImage: UIImageView!
    @IBOutlet weak var pharmacyTV: UITableView!
    
    @IBOutlet var addpharmacyview: UIView!
    @IBOutlet weak var addimage: UIImageView!
    @IBOutlet weak var pharmacynameTF: UITextField!
    let ref = Firestore.firestore()
    var parameters = [String:Any]()
    
    @IBOutlet weak var adddata: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        //     addpharmacyview.showSpinner(onView: self.view)
        addimage.setRounded()
        adddata.setRounded() 
        initltable()
        getPharmacies()
        pharmacyTV.showSpinner(onView: self.view)
        pharmacyImage.isUserInteractionEnabled = true
        pharmacyImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(initPicker)))
    }
    //    override func viewWillAppear(_ animated: Bool) {
    //        getPharmacies()
    //    }
    //    func validateFields() -> Bool{
    //        let pharmacyname = pharmacynameTF.text
    //        let pharmacyaddress = pharmacyaddressTF.text
    //
    //        if pharmacyname!.isEmpty || pharmacyaddress!.isEmpty || pharmacyImage!.image == nil  {
    //            // myTextField is not empty here
    //            self.showAlertMessage(title: "", message: "Please fill in all fields")
    //            return false
    //        } else {
    //            return true
    //        }
    
    //    }
    
    
    @IBAction func addPharmacyAction() {
        if pharmacynameTF.text!.isEmpty ||  pharmacyaddressTF.text!.isEmpty || pharmacyImage!.image == nil  {
            print("Pleaase Fill all Fields")
        }else{
            
            //  self.addpharmacyview.showSpinner(onView: self.view)
            self.uploadImage(image: pharmacyImage.image!) { (url) in
                if url == nil {
                    print("Error fetching docs:")
                } else {
                    let image = url
                 
                    let docid = self.ref.collection("Pharmacy").document().documentID
                    self.parameters["pharmacyname"] = self.pharmacynameTF.text!
                    self.parameters["pharmacyaddress"] = self.pharmacyaddressTF.text!
                    self.parameters["pharmacyImage"] = image
                    self.parameters["pharmacyId"] = docid
                    do{
                        let pharmacyref = self.ref.collection("Pharmacy")
                        
                        try? pharmacyref.addDocument(data: self.parameters, completion: { err in
                            if let error = err {
                                print(error.localizedDescription)
                                self.showAlertMessage(title: "error", message: "\(error.localizedDescription)")
                                
                            }
                            print("sccussfly")
                            
                        })
                    }
                    catch let error {
                        self.showAlertMessage(title: "error", message: "\(error.localizedDescription)")
                    }
                    self.pharmacyTV.reloadData()
                    self.addpharmacyview.removeSpinner()
                }
            }
        }
        
    }
    
    
    
    
    func getPharmacies(){
        let userReference = Firestore.firestore().collection("Pharmacy")
        userReference.getDocuments { (snapshot, error) in
            if let err = error {
                print("Error fetching docs: \(err)")
            } else {
                guard let snap = snapshot else {return}
                
                for document in snap.documents {
                    let data =  document.data()
                    let name = data["pharmacyname"] as? String ?? ""
                    let adress = data["pharmacyaddress"] as? String ?? ""
                    let image = data["pharmacyImage"] as? String ?? ""
                    
                    let    comedata = Pharmacy(pharmacyname: name, pharmacyaddress: adress,pharmacyImage: image)
                    
                    self.pharmacies.append(comedata)
                    //print(comedata)
                }
                
                
                self.pharmacyTV.reloadData()
                self.addpharmacyview.removeSpinner()
            }
        }
        
    }
    
    
    //                userReference.getDocuments(completion: <#T##FIRQuerySnapshotBlock##FIRQuerySnapshotBlock##(QuerySnapshot?, Error?) -> Void#>)
    //                    .getDocument { (document , error) in
    //                        if let document = document ,  document.exists {
    //                            let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
    //                            print("Document data:\(dataDescription)")}else {
    //                            print("Document does not exist")
    //                        }
    //
    //                }
    
    
    func updatePharmacy(){
        //let userReference = Firestore.firestore().collection("users").document("Provider")
        //userReference.documentID().se
    }
    func deletePharmacy(){
        //let documentid = pharmobject.id
        ref.collection("Pharmacy").document().delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
       
        
        //  reference(to: .Provider).
        //    userReference.documentID()
    }}



extension AddPharmacyVC : UITableViewDataSource , UITableViewDelegate {
    
    func initltable(){
        let nib = UINib(nibName: "AddPharmacyTVC", bundle: nil)
        pharmacyTV.register(nib, forCellReuseIdentifier: "AddPharmacyTVC")
        pharmacyTV.dataSource = self
        pharmacyTV.delegate = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pharmacies.count
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    
    return UISwipeActionsConfiguration(actions: [funcDeleteAction(forRowAt: indexPath)])
    }
  func funcDeleteAction(forRowAt indexPath: IndexPath) -> UIContextualAction {
    return UIContextualAction(style: .destructive, title: "Delete") { (action, swipeButtonView, completion) in
        print("is Delete")
    }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = pharmacyTV.dequeueReusableCell(withIdentifier: "AddPharmacyTVC",
                                                  for: indexPath) as! AddPharmacyTVC
        let pharmacy = pharmacies[indexPath.row]
        cell.nameLbl?.text = pharmacy.pharmacyname
        cell.adressLbl?.text = pharmacy.pharmacyaddress
        cell.pharmacyimage?.sd_setImage(with: URL(string: pharmacy.pharmacy_Image ?? ""), completed: nil)
        
        
        
        return cell
    }
    
}




extension AddPharmacyVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc  func initPicker(){
        let imagepickerV = UIImagePickerController()
        imagepickerV.delegate = self
        imagepickerV.allowsEditing = true
        imagepickerV.sourceType = .photoLibrary
        self.present(imagepickerV, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage  else { return
        }
        picker.dismiss(animated: true, completion: nil)
        pharmacyImage.image = image
        // uploadImage(image: image)
    }
    
    
    
    func uploadImage(image :UIImage ,comlition: ((URL)->Void)?){
        
        guard let data = image.jpegData(compressionQuality: 0.2) else { return  }
        // let imagename = UUID().uuidString
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        let ref = Storage.storage().reference(withPath: "images").child("imagename")
        ref.putData(data, metadata: nil) { (metadata, error) in
            if error != nil{
                print(error!.localizedDescription)
                return
            }
            ref.downloadURL { (url, error) in
                if error != nil{
                    print(error!.localizedDescription)
                    return }
                comlition?(url!)
                // print(url)
            }
            print("upload Succesful")
            
        }}
}

