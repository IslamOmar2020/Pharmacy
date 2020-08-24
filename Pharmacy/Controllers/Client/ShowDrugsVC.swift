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
class ShowDrugsVC: UIViewController {
    var drugsarray = [Drug]()
 
    @IBOutlet weak var showdrugsCV: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initCollectionVC()
    }
    override func viewWillAppear(_ animated: Bool) {
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
                let image = data["drugimage"] as? String ?? ""

                print(data)
                
                let    comedata = Drug(drugname: name, drugcount: count, aboutdrug: aboutdrug, drugImage: image)
                
                self.drugsarray.append(comedata)
            print(comedata)
            }
            print(self.drugsarray)
            
            self.showdrugsCV.reloadData()
            
        }
        }
   
}
}


extension ShowDrugsVC: UICollectionViewDelegate,UICollectionViewDataSource{
  
func initCollectionVC(){
    showdrugsCV.delegate = self
    showdrugsCV.dataSource = self
    let nib = UINib(nibName: "ShowDrugsCVC", bundle: nil)
    showdrugsCV.register(nib, forCellWithReuseIdentifier: "ShowDrugsCVC")
}


func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
  
    return drugsarray.count
    }
 
func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
        let drugCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShowDrugsCVC", for: indexPath) as! ShowDrugsCVC
    let image = drugsarray[indexPath.row].drugImage
    let imageUrl = URL(string: image!)
    drugCell.drugimage.sd_setImage(with: imageUrl, completed: nil)
    drugCell.drugnameLbl.text = drugsarray[indexPath.row].drugname

        return drugCell
        
    }

        
    }



