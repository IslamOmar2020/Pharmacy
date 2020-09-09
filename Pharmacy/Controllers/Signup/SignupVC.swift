//
//  SignupClientVC.swift
//  Pharmacy
//
//  Created by Islam Omar on 8/3/20.
//  Copyright © 2020 Islam Omar. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import SDWebImage
import FirebaseStorage
import FirebaseFirestore

class SignupVC: UIViewController {
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var userimage: UIImageView!
    @IBOutlet weak var providerorclientsegmant: UISegmentedControl!
    @IBOutlet weak var createacoutnBtn: UIButton!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var phonenumTF: UITextField!
    var usertype = UserType()
    let ref = Firestore.firestore()
    var handler : AuthStateDidChangeListenerHandle?
    var userdata = [String:Any]()
    var users : [User] = []
    // add UIActivity
    override func viewDidLoad() {
       
        super.viewDidLoad()
        setUpelements()
        userimage.setRounded()
        userimage.isUserInteractionEnabled = true
        userimage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(initPicker)))
        passwordTF.autocorrectionType = .no

    }
    //    override func viewWillDisappear(_ animated: Bool) {
    //        Auth.auth().removeStateDidChangeListener(handler!)
    //    }
    
    func setUpelements(){
        Utilities.styleTextField(nameTF)
        Utilities.styleTextField(passwordTF)
        Utilities.styleTextField(phonenumTF)
        Utilities.styleTextField(emailTF)
        Utilities.styleFilledButton(createacoutnBtn)
        
    }
    func validateFields() -> String? {
        if nameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            phonenumTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields"
        }
//        let cleanPassword = passwordTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
//        if Utilities.isPasswordValid(cleanPassword) == false {
//            return "Please make sure your password is at least 8 characters, contains a special character and a number "
//        }
//        //   check email here???
        return nil
    }
    
    @IBAction func createAcountAction(_ sender: Any) {
        //validate the fields
        let error = validateFields()
        if error != nil {
            print(error!)
        }else {
            let name = nameTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let phonenum = phonenumTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            
            //Create the user
            Auth.auth().createUser(withEmail: email, password: password  ){(result,err) in
                if let error = err as NSError? {
                    guard let errCode = AuthErrorCode(rawValue: error.code) else {
                        self.showAlertMessage(title: "Error", message: "UnKnow Error Creating the user")
                        return
                    }
                    //                    switch errCode {
                    //                    case .emailAlreadyInUse :
                    //                        self.showAlertMessage(title: "Error", message:"Email Already Taken")
                    //                    case .invalidEmail :
                    //                        self.showAlertMessage(title: "Error", message:"Email Already Taken")
                    //                    case .weakPassword :
                    //                        self.showAlertMessage(title: "Error", message: "Password is invalid")
                    //                    default:
                    //                        self.showAlertMessage(title: "Error", message: "User not Create \(err!.localizedDescription)")
                    //                    }
                    print(err)
                }
                else {
                    
                    let userid = result!.user.uid
                    self.saveuserDetails(UserID: userid)
                    
                    print("User Created")
                    // call add user
                    self.addUser()
                    // Transition to home screen
                    let vc = self.storyboard?.instantiateViewController(identifier: "HomeVC") as! HomeVC
                    self.present(vc,animated: true)
                }
            }
        }
        
        
    }
    func typeforuser() -> String  {
        switch providerorclientsegmant.selectedSegmentIndex
        {
        case 0:
            usertype.type! = "Provider"
        case 1:
            usertype.type! = "Client"
        default:
            break;
        }
        return usertype.type!
    }
        func addUser() {
    
            userdata["name"] = nameTF.text!
            userdata["userphone"] = phonenumTF.text!
            var  type1 = typeforuser()
            userdata["type"] = type1
            userdata["image"] = userimage.image
    
           let usersref = self.ref.collection("users")
    
            do{
    
                try? usersref.addDocument(data: userdata, completion: { err in
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
    
    func saveuserimage(){
        
    }
        func saveuserDetails(UserID:String){
            ref.collection("users").document(UserID).setData([
                "name" : nameTF.text!,
                "phonenum": phonenumTF.text!,
                "userimage": userimage.image!
            ]) { (error) in
                if error != nil {
                    self.showAlertMessage(title: "Error", message: "User Details where not added")
                }else{
                    self.showAlertMessage(title: "Error", message: "User Details where saved")
                }
            }
        }}
    
    
    
    extension SignupVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
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
            userimage.image = image
            uploadImage(image: image, comlition: nil)
        }
        
        
        
        func uploadImage(image :UIImage ,comlition: ((URL)->Void)?){
            
            guard let data = image.jpegData(compressionQuality: 0.2) else { return  }
            let imagename = UUID().uuidString
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpg"
            let ref = Storage.storage().reference(withPath: "images").child("imagename")
            ref.putData(data, metadata: nil) { (metadata, error) in
                if error != nil{
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
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true, completion: nil)
        }
}

