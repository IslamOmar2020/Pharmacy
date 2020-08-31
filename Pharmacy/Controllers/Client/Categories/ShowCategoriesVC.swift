//
//  ShowCategoriesVC.swift
//  Pharmacy
//
//  Created by Islam Omar on 8/28/20.
//  Copyright © 2020 Islam Omar. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import SDWebImage
import FirebaseStorage
class ShowCategoriesVC: UIViewController {
    var categories = [Category]()
    
    @IBOutlet weak var showcategoriesTV: UITableView!
    var parameters = [String:Any]()
    @IBOutlet var showcategoriesV: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
     initltable()
    getallCategories()
        showcategoriesV.showSpinner(onView: self.view)
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
                    
                   // print(data)
                    
                    let    comedata = Category(categoryname: name, categoryimage: image)
                    
                    self.categories.append(comedata)
                    //print(comedata)
                }
                
                
                self.showcategoriesTV.reloadData()
                self.showcategoriesV.removeSpinner()
            }
        }
        
    }
}


extension ShowCategoriesVC : UITableViewDataSource , UITableViewDelegate {
    
    func initltable(){
        showcategoriesTV.dataSource = self
        showcategoriesTV.delegate = self
    }
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let labletitle = UILabel()
//        labletitle.text = categories.
//               cell.showcategoriesnameLbl?.text = category.categoryname
//    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = showcategoriesTV.dequeueReusableCell(withIdentifier: "ShowCategoriesTVC",for: indexPath) as! ShowCategoriesTVC
        let category = categories[indexPath.row]
        let image = category.categoryimage
        cell.showcategoriesnameLbl?.text = category.categoryname
        let imageUrl = URL(string: image!)
        cell.showcategoriesimage.sd_setImage(with: imageUrl, completed: nil)
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
