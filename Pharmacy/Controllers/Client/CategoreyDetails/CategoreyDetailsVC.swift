//
//  CategoreyDetailsVC.swift
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

class CategoreyDetailsVC: UIViewController {
    var categoriesdetails = [CategoryDetails]()
    var parameters = [String:Any]()
    var categoriesdetailsV : UIView!
    @IBOutlet var categoriesdetailsCV: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initCollectionVC()
        getallCategories()
        categoriesdetailsV.showSpinner(onView: self.view)
    }
    func getallCategories() {
        let userReference = Firestore.firestore().collection("CategoriesDetalis")
        userReference.getDocuments { (snapshot, error) in
            if let err = error {
                print("Error fetching docs: \(err)")
            } else {
                guard let snap = snapshot else {return}
                
                for document in snap.documents {
                    
                    let data =  document.data()
                    let name = data["categoriesname"] as? String ?? ""
                    let image = data["categoriesimage"] as? String ?? ""
                    let count = data["itemcount"] as? String ?? ""
                    let price = data["itemprice"] as? String ?? ""
                //    print(data)
                    
                    let    comedata = CategoryDetails(itemname: name, itemimage: image , itemcount: Int(count)! ,itemprice: Int(price)!)
                    
                    self.categoriesdetails.append(comedata)
                    //print(comedata)
                }
                
                
                self.categoriesdetailsCV.reloadData()
                self.categoriesdetailsV.removeSpinner()
            }
        }
        
    }
}




extension CategoreyDetailsVC: UICollectionViewDelegate,UICollectionViewDataSource{
  
func initCollectionVC(){
    categoriesdetailsCV.delegate = self
    categoriesdetailsCV.dataSource = self
    
}


func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
  
    return categoriesdetails.count
    }
 
func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoreyDetailsCVC", for: indexPath) as! CategoreyDetailsCVC
    let image = categoriesdetails[indexPath.row].itemimage
    let imageUrl = URL(string: image!)
    cell.imageitem.sd_setImage(with: imageUrl, completed: nil)
    cell.namelbl.text = categoriesdetails[indexPath.row].itemname
    let mycount = categoriesdetails[indexPath.row].itemcount
    cell.countlbl.text = String(mycount!)
    let myprice = categoriesdetails[indexPath.row].itemprice
    cell.pricelbl.text = String(myprice!)
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let drugdetailsVC = self.storyboard!.instantiateViewController(identifier: "DrugDetailsVC") as! DrugDetailsVC
//     //   drugdetailsVC.aoutdrug.text = drugsarray[indexPath.row].aboutdrug
//        //drugdetailsVC.count.text = String( drugsarray[indexPath.row].drugcount)
//   //     drugdetailsVC.drugimage =
//        let name = categoriesdetails[indexPath.row].itemname
//        drugdetailsVC.name?.text = name
//      //  name.text = drugsarray[indexPath.row].drugname
//        self.navigationController?.pushViewController(drugdetailsVC, animated: true)
    }
        
    }
