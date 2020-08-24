//
//  AddDrugVC.swift
//  Pharmacy
//
//  Created by Islam Omar on 7/26/20.
//  Copyright © 2020 Islam Omar. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import SDWebImage
import FirebaseStorage
class AddDrugVC: UIViewController {
    let imagePicker = UIImagePickerController()
    @IBOutlet weak var drugimage: UIImageView!
    @IBOutlet weak var drugcountTF: UITextField!
    @IBOutlet weak var pharmacynameTF: UITextField!
    @IBOutlet weak var aboutdrugTF: UITextField!
    @IBOutlet weak var drugnameTF: UITextField!
    
    let ref = Firestore.firestore()
    var parameters = [String:Any]()
    //    let query  : QuerySnapshot?
    //  let doucmentid = ref.collection("Pharmacy").id
    override func viewDidLoad() {
        super.viewDidLoad()
        drugimage.isUserInteractionEnabled = true
            drugimage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(initPicker)))
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
    func validateFields() -> Bool{
        let drugname = drugnameTF.text
        let drugcount = drugcountTF.text
        let aboutdrug = aboutdrugTF.text
        
        
        if drugname!.isEmpty || aboutdrug!.isEmpty || drugcount!.isEmpty || drugimage!.image == nil  {
            // myTextField is not empty here
            self.showAlertMessage(title: "", message: "Please fill in all fields")
            return false
        } else {
            return true
        }
        
    }
    @IBAction func adddrugAction(_ sender: Any) {
        if !validateFields() {
            print("someing error")
        }else{
            
            uploadImage(image: drugimage.image!) { (url) in
                if url == nil {
                    print("Error fetching docs:")
                } else {
                    let image = url!
                    self.parameters["aboutdrugTF"] = self.aboutdrugTF.text!
                    self.parameters["drugcount"] = self.drugcountTF.text!
                    self.parameters["drugname"] = self.drugnameTF.text!
                    self.parameters["image"] = image.absoluteString
                    do{
                        let drugref = self.ref.collection("Drug")
    
                        try? drugref.addDocument(data: self.parameters, completion: { err in
                            if let error = err {
                                print(error.localizedDescription)
                                self.showAlertMessage(title: "error", message: "\(error.localizedDescription)")
                                
                            }
                            print("sccussfly")
                            self.drugcountTF.text = ""
                            self.aboutdrugTF.text = ""
                            self.drugnameTF.text = ""
                            self.drugimage.image = nil
                            
                        })
                    }
                    catch let error {
                        self.showAlertMessage(title: "error", message: "\(error.localizedDescription)")
                    }
                    
                }
            }
        }
        
    }}





extension AddDrugVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
        drugimage.image = image
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

