//
//  ClientPageVC.swift
//  Pharmacy
//
//  Created by Islam Omar on 8/17/20.
//  Copyright © 2020 Islam Omar. All rights reserved.
//

import UIKit
import FirebaseFirestore
class ClientVC: UIViewController {
  
    @IBOutlet weak var showcategoryBtn: UIButton!
    @IBOutlet weak var finfdrugBtn: UIButton!
    @IBOutlet weak var findpharmacy: UIButton!
    var detalisObj : CategoryDetails!
    var categories = [Category]()
    @IBOutlet var clientpageview: UIView!
    @IBOutlet weak var categoriescv: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initCollectionVC()
        setUpelements()
        getallCategories()
        clientpageview.showSpinner(onView: self.view)
    }
    func setUpelements(){
        Utilities.styleFilledButton(findpharmacy)
       Utilities.styleFilledButton(showcategoryBtn)
        Utilities.styleFilledButton(finfdrugBtn)
        
    }
    @IBAction func showpahrmacyAction(_ sender: Any) {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "ListofAllpharmaciesVC")
                self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func finddrugsAction(_ sender: Any) {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "ShowDrugsVC")
               self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func showCategoryAction(_ sender: Any) {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "ShowCategoriesVC")
        self.navigationController?.pushViewController(vc, animated: true)
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
                    
                //    print(data)
                    
                    let    comedata = Category(categoryname: name, categoryimage: image)
                    
                    self.categories.append(comedata)
                    //print(comedata)
                }
                
                
                self.categoriescv.reloadData()
                self.clientpageview.removeSpinner()
            }
        }
        
    }
    
 

}




extension ClientVC: UICollectionViewDelegate,UICollectionViewDataSource{
  
func initCollectionVC(){
    categoriescv.delegate = self
    categoriescv.dataSource = self

}


func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
  
    return categories.count
    }
 
func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ClientPageCVC", for: indexPath) as! ClientPageCVC
  //  let image = categories[indexPath.row].categoryimage
    
  //  let imageUrl = URL(string: image!)
  //  Cell.image.sd_setImage(with: imageUrl, completed: nil)
    cell.nameLbl.text = categories[indexPath.row].categoryname
    cell.image.image = UIImage(named : categories[indexPath.row].categoryimage!)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (categoriescv.frame.size.width - space) / 2.0
        return CGSize(width: size, height: size)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
   
      
    }

//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//              
//    var categoreyDetails :CategoreyDetailsVC = (storyboard!.instantiateVC())!
//        categoreyDetails.detalisObj =  categories[indexPath.row]
//              
//    self.navigationController?.pushViewController(categoreyDetails, animated: true)
//              
//              
//              
//          }
    }

