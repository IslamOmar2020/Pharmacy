//
//  PharmacyHomeVC.swift
//  Pharmacy
//
//  Created by Islam Omar on 8/19/20.
//  Copyright © 2020 Islam Omar. All rights reserved.
//
import AVKit
import UIKit
import Firebase
import FirebaseFirestore
import SDWebImage
import FirebaseStorage

class PharmacyHomeVC: UIViewController {
    var videoPlayer : AVPlayer?
    var videoPlayerlayer : AVPlayerLayer?
    var arraydata = [Information]()
    var drugarray = [Drug]()
    @IBOutlet weak var showdrugCV: UICollectionView!
    @IBOutlet weak var homeCV: UICollectionView!
    @IBOutlet weak var myview: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initCollectionVC()
        getallData()
        setUpVideo()
        getallDrugs()
        
       // view?.backgroundColor = UIColor(white: 1, alpha: 0.5)
        homeCV.backgroundColor?.withAlphaComponent(0.5)
        homeCV.layer.cornerRadius = 40
        showdrugCV.layer.cornerRadius = 40
     
    }
    func setUpVideo(){
        // Get the path to the resource in the bundle
        let bundlePath = Bundle.main.path(forResource: "loginbg", ofType: "mp4")
        
        guard bundlePath != nil else {
            return
        }
        
        // Create a URL from it
        let url = URL(fileURLWithPath: bundlePath!)
        
        // Create the video player item
        let item = AVPlayerItem(url: url)
        
        // Create the player
        videoPlayer = AVPlayer(playerItem: item)
        
        // Create the layer
        videoPlayerlayer = AVPlayerLayer(player: videoPlayer!)
        
        // Adjust the size and frame
        videoPlayerlayer?.frame = CGRect(x: -self.view.frame.size.width*1.5, y: 0, width: self.view.frame.size.width*4, height: self.view.frame.size.height)
        
        self.myview.layer.insertSublayer(videoPlayerlayer!, at: 0)
        
        // Add it to the view and play it
        videoPlayer?.playImmediately(atRate: 0.3)
        
    }
    
    
    func getallData() {
        let userReference = Firestore.firestore().collection("Information")
        userReference.getDocuments { (snapshot, error) in
            if let err = error {
                print("Error fetching docs: \(err)")
            } else {
                guard let snap = snapshot else {return}
                
                for document in snap.documents {
                    
                    let data =  document.data()
                    let name = data["title"] as? String ?? ""
                    let image = data["image"] as? String ?? ""
                    let detalis = data["body"] as? String ?? ""
                    // print(data)
                    
                    let    comedata = Information(infotitle: name, infoimage: image, infodetalis: detalis)
                    
                    self.arraydata.append(comedata)
                    //print(comedata)
                }
                
                
                self.homeCV.reloadData()
                
            }
        }}
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
                    let image = data["image"] as? String ?? ""
                    let about = data["aboutdrugTF"] as? String ?? ""
                    let count = Int(data["drugcount"] as? String ?? "") ?? 0
                    let id = data["id"] as? String ?? ""
                    // print(data)
                    
                    let    comedata = Drug(drugname: name, drugcount: count, aboutdrug: about, drugImage: image, id: id)
                    
                    
                    self.drugarray.append(comedata)
                    //print(comedata)
                }
                
                
                self.showdrugCV.reloadData()
                
            }
        }}
}


extension PharmacyHomeVC: UICollectionViewDelegate,UICollectionViewDataSource{
    
    func initCollectionVC(){
        homeCV.delegate = self
        homeCV.dataSource = self
        showdrugCV.delegate = self
        showdrugCV.dataSource = self
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == homeCV {
            return self.arraydata.count
        }
        else if collectionView == showdrugCV{
            return self.drugarray.count
        }
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == homeCV {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PharmacyHomeCVC", for: indexPath) as! PharmacyHomeCVC
            //    let image = arraydata[indexPath.row].dataimage
            //    let imageUrl = URL(string: image!)
            cell.title.text = arraydata[indexPath.row].infotitle
            cell.image.sd_setImage(with: URL(string: arraydata[indexPath.row].infoimage ?? "")!, completed: nil)
            
            //    cell.image.sd_setImage(with: imageUrl, completed: nil)
            return cell}
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeshowDrugCVCell", for: indexPath) as! HomeshowDrugCVCell
            cell.image.sd_setImage(with: URL(string: drugarray[indexPath.row].drugImage ?? "")!, completed: nil)
            return cell
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == homeCV {
        let infoDetails :InformationVC = self.storyboard?.instantiateViewController(identifier: "InformationVC") as! InformationVC
        infoDetails.infoVCobject = arraydata[indexPath.row]
        
            self.navigationController?.pushViewController(infoDetails, animated: true)}
        else {
            let drugdetails :DrugDetailsVC = self.storyboard?.instantiateViewController(identifier: "DrugDetailsVC") as! DrugDetailsVC
            drugdetails.drugobject = drugarray[indexPath.row]
                   
                       self.navigationController?.pushViewController(drugdetails, animated: true)
        }
        
        
        
        
    }
    
}
