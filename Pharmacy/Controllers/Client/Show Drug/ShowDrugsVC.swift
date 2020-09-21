//
//  ShowDrugsVC.swift
//  Pharmacy
//
//  Created by Islam Omar on 8/18/20.
//  Copyright © 2020 Islam Omar. All rights reserved.
//
import UIKit
import Firebase
import FirebaseFirestore
import SDWebImage
import FirebaseStorage

class ShowDrugsVC: UIViewController {
    var drugsarray = [Drug]()
 
 @IBOutlet weak var showDrugTV: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
       initltable()
        getallDrugs()
    }
 
    func getallDrugs() {
    let userReference = Firestore.firestore().collection("Drug")
    userReference.getDocuments { (snapshot, error) in
        if let err = error {
            print("Error fetching docs: \(err)")
        } else {
            guard let snap = snapshot else {return}
            
            for document in snap.documents {
                
                let data =  document.data()
                let name = data["drugname"] as? String ?? ""
                let count = data["drugcount"] as? Int ?? 0
                let aboutdrug = data["aboutdrug"] as? String ?? ""
                let image = data["image"] as? String ?? ""
                 let docid = data["id"] as? String ?? ""
              //  print(data)`
                
                let    comedata = Drug(drugname: name, drugcount: count, aboutdrug: aboutdrug, drugImage: image, id: docid)
               
                
                self.drugsarray.append(comedata)
            //print(comedata)
            }
            print(self.drugsarray)
            
            self.showDrugTV.reloadData()
            
        }
        }
   
}
    @IBAction func showLocationAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "PharmacyMapVC") as! PharmacyMapVC
               self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


extension ShowDrugsVC : UITableViewDataSource , UITableViewDelegate {
    
    func initltable(){
        showDrugTV.delegate = self
        showDrugTV.dataSource = self
    }
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let labletitle = UILabel()
//        labletitle.text = categories.
//               cell.showcategoriesnameLbl?.text = category.categoryname
//    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drugsarray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = showDrugTV.dequeueReusableCell(withIdentifier: "ShowDrugsTVCell",for: indexPath) as! ShowDrugsTVCell
        cell.name.text = drugsarray[indexPath.row].drugname
        cell.count.text = String(drugsarray[indexPath.row].drugcount!)
        let image = drugsarray[indexPath.row].drugImage
        let imageUrl = URL(string: image!)
        cell.imagedrug.sd_setImage(with: imageUrl, completed: nil)
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
