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

class AddPharmacyVC: UIViewController {
    @Published var pharmacies =  [Pharmacy]()
    @IBOutlet weak var pharmacyaddressTF: UITextField!
    @IBOutlet weak var pharmacyImage: UIImageView!
    @IBOutlet weak var pharmacyTV: UITableView!
  
    @IBOutlet weak var pharmacynameTF: UITextField!
    let ref = Firestore.firestore()
    var parameters = [String:Any]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initltable()
        pharmacyImage.isUserInteractionEnabled = true
        pharmacyImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(initPicker)))
    }
    override func viewWillAppear(_ animated: Bool) {
        getPharmacies()
    }
    func validateFields() -> String? {
    if pharmacyaddressTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        pharmacynameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
        }
        
        self.showAlertMessage(title: "", message: "Please fill in all fields")
         return "Please fill in all fields"
    }
    @IBAction func addPharmacyAction() {
        let error = validateFields()
        if error != nil {
            print(error!)
        }else {
            if pharmacyImage.image != nil {
                uploadImage(image: pharmacyImage.image!) { (url) in
                    if let err = error {
                        print("Error fetching docs: \(err)")
                    } else {
                        
                        self.parameters["pharmacyname"] = self.pharmacynameTF.text!
                        self.parameters["pharmacyaddress"] = self.pharmacyaddressTF.text!
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
                  
                  }
                }}else {
                    showAlertMessage(message: "Please pick an Image")
                }
        }}
    func getPharmacies(){
        //            self.ref.collection("Pharmacy").addSnapshotListener { (documentSnapshot, error) in
        //                guard let document = documentSnapshot?.documents else {
        //                print("NO document: \(error!)")
        //                return
        //              }
        //                self.pharmacies = document.compactMap{(QueryDocumentSnapshot) -> Pharmacy? in
        //            return  try? QueryDocumentSnapshot.data(as: Pharmacy.self)
        //            }}
        
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
                
                print(data)
             let    comedata = Pharmacy(pharmacyname: name, pharmacyaddress: adress)
                
                self.pharmacies.append(comedata)
            }
            print(self.pharmacies)
            
             self.pharmacyTV.reloadData()
            
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
        
                   
    }
  
    
    func updatePharmacy(){
        //let userReference = Firestore.firestore().collection("users").document("Provider")
        //userReference.documentID().se
    }
    func deletePharmacy(){
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = pharmacyTV.dequeueReusableCell(withIdentifier: "AddPharmacyTVC",
                                                  for: indexPath) as! AddPharmacyTVC
        let pharmacy = pharmacies[indexPath.row]
        cell.nameLbl?.text = pharmacy.pharmacyname
        cell.adressLbl?.text = pharmacy.pharmacyaddress
       // cell.pharmacyimage?.image = pharmacy.
        
        
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
    guard var image = info[.originalImage] as? UIImage  else { return
          }
        picker.dismiss(animated: true, completion: nil)
        pharmacyImage.image = image
         // uploadImage(image: image)
        }
      

    
    func uploadImage(image :UIImage ,comlition: ((URL)->Void)?){
        
        guard let data = image.jpegData(compressionQuality: 0.2) else { return  }
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        let ref = Storage.storage().reference(withPath: "images").child("logo.jpg")
        ref.putData(data, metadata: nil) { (_, error) in
            if error != nil{
                print(error?.localizedDescription)
                return
        }
            ref.downloadURL { (url, error) in
                 if error != nil{
            print(error?.localizedDescription)
                               return
            }
                comlition?(url!)
                print(url)
        }
            print("upload succesful")
        }
    }
}
