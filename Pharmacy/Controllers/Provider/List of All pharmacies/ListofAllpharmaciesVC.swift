//
//  ListofAllpharmaciesVC.swift
//  Pharmacy
//
//  Created by Islam Omar on 8/21/20.
//  Copyright © 2020 Islam Omar. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import SDWebImage
import FirebaseStorage

class ListofAllpharmaciesVC: UIViewController {
    var pharmasies = [Pharmacy]()
    @IBOutlet var getPharmasiesV: UIView!
       @IBOutlet weak var getPharmasiesTV: UITableView!
var parameters = [String:Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initltable()
          getPharmasies()
              getPharmasiesV.showSpinner(onView: self.view)

    }
    func getPharmasies(){
        let userReference = Firestore.firestore().collection("Pharmacy")
        userReference.getDocuments { (snapshot, error) in
            if let err = error {
                print("Error fetching docs: \(err)")
            } else {
                guard let snap = snapshot else {return}
                
                for document in snap.documents {
                    
                    let data =  document.data()
                    let name = data["pharmacyname"] as? String ?? ""
                    let address = data["pharmacyaddress"] as? String ?? ""
                    let image = data["pharmacyimage"] as? String ?? ""
                    
                   // print(data)
                    
                    let    comedata = Pharmacy(pharmacyname: name, pharmacyaddress: address, pharmacyImage: image)
                    
                    self.pharmasies.append(comedata)
                    //print(comedata)
                }
                
                
                self.getPharmasiesTV.reloadData()
                self.getPharmasiesV.removeSpinner()
            }
        }
        
    }


}


extension ListofAllpharmaciesVC : UITableViewDataSource , UITableViewDelegate {
    
    func initltable(){
        getPharmasiesTV.dataSource = self
        getPharmasiesTV.delegate = self
    }
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let labletitle = UILabel()
//        labletitle.text = categories.
//               cell.showcategoriesnameLbl?.text = category.categoryname
//    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pharmasies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = getPharmasiesTV.dequeueReusableCell(withIdentifier: "ListallpharmacyTVC",for: indexPath) as! ListallpharmacyTVC
        let pharmacy = pharmasies[indexPath.row]
        let image = pharmacy.pharmacyImage
        cell.pharmacynameLbl?.text = pharmacy.pharmacyname
        let imageUrl = URL(string: image!)
        cell.pharmacyimage.sd_setImage(with: imageUrl, completed: nil)
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
       {
           let verticalPadding: CGFloat = 16

           let maskLayer = CALayer()
           maskLayer.cornerRadius = 20    //if you want round edges
           maskLayer.backgroundColor = UIColor.black.cgColor
           maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 0, dy: verticalPadding/2)
           cell.layer.mask = maskLayer
       }
}
