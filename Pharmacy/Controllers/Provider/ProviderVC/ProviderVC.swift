//
//  ProviderVC.swift
//  Pharmacy
//
//  Created by Islam Omar on 8/19/20.
//  Copyright © 2020 Islam Omar. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import SDWebImage
import FirebaseStorage
import ImageSlideshow
import Alamofire

class ProviderVC: UIViewController , ImageSlideshowDelegate {
    var sliders = [String]()
    var pharmasies = [Pharmacy]()
    @IBOutlet var imagesSlide: ImageSlideshow!
    @IBOutlet weak var addcategoryBtn: UIButton!
    @IBOutlet weak var addpharamcyBtn: UIButton!
    @IBOutlet weak var adddrugbtn: UIButton!
    @IBOutlet weak var providercollectioview: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpelements()
        imageSlider()
        getallPharmacy()
    }
    @objc func didTap() {
    imagesSlide.presentFullScreenController(from: self)
    }
    func setUpelements(){
        Utilities.styleFilledButton(addpharamcyBtn)
       Utilities.styleFilledButton(adddrugbtn)
        Utilities.styleFilledButton(addcategoryBtn)
        
    }
    func initImageSlideShow(){
         
         imagesSlide.pageIndicatorPosition = .init(horizontal: .center, vertical: .customBottom(padding: 16))
         
         imagesSlide.slideshowInterval = 2.0
         
         imagesSlide.contentScaleMode = UIViewContentMode.scaleAspectFill
         
         imagesSlide.activityIndicator = DefaultActivityIndicator()
         
         let pageControl = UIPageControl()
         pageControl.currentPageIndicatorTintColor = UIColor.lightGray
         pageControl.pageIndicatorTintColor = UIColor.black
         imagesSlide.pageIndicator = pageControl

         let recognizer = UITapGestureRecognizer(target: self, action: #selector(didTap))
         
         imagesSlide.addGestureRecognizer(recognizer)
     }
    func imageSlider()  {
        
        imagesSlide.activityIndicator = DefaultActivityIndicator()
        imagesSlide.slideshowInterval = 2.0
        imagesSlide.pageIndicatorPosition = .init(horizontal: .center, vertical: .customBottom(padding: 18))
        imagesSlide.contentScaleMode = UIViewContentMode.scaleAspectFill
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = UIColor.lightGray
        pageControl.pageIndicatorTintColor = UIColor.black
        imagesSlide.pageIndicator = pageControl
       var imageSD = [SDWebImageSource]()
        let imageReference = Firestore.firestore().collection("ImageSlider")
        imageReference.getDocuments { (snapshot, error) in
            if let err = error {
                print("Error fetching docs: \(err)")
            } else {
            
                for document in snapshot!.documents {
                    let data =  document.get("imagesslider") as! [String]
                
                    self.sliders.append(contentsOf: data)
                    for url in self.sliders{
                        let imagesource = SDWebImageSource(urlString: url)
                        imageSD.append(imagesource!)
                    }
                    self.imagesSlide.setImageInputs(imageSD)
                }}}}
    
    @IBAction func AddCategoriesAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "AddCategoriesVC") as! AddCategoriesVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func addpharmacyAction(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(identifier: "AddPharmacyVC") as! AddPharmacyVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func AddDrugAction(_ sender: Any) {
         let vc = storyboard?.instantiateViewController(identifier: "AddDrugVC") as! AddDrugVC
         self.navigationController?.pushViewController(vc, animated: true)
     }
   
func getallPharmacy() {
        let userReference = Firestore.firestore().collection("Pharmacy")
        userReference.getDocuments { (snapshot, error) in
            if let err = error {
                print("Error fetching docs: \(err)")
            } else {
                guard let snap = snapshot else {return}
                
                for document in snap.documents {
                    
                    let data =  document.data()
                    let name = data["pharmacyname"] as? String ?? ""
                    let image = data["pharmacyImage"] as? String ?? ""
                    let address = data["pharmacyaddress"] as? String ?? ""
                //    print(data)
                    
                    let    comedata = Pharmacy(pharmacyname: name, pharmacyaddress: address, pharmacyImage: image)
                    
                    self.pharmasies.append(comedata)
                }
                
                
                self.providercollectioview.reloadData()
           //    self.clientpageview.removeSpinner()
            }
        }
        
    }
}
 





extension ProviderVC: UICollectionViewDelegate,UICollectionViewDataSource{
  
func initCollectionVC(){
    providercollectioview.delegate = self
    providercollectioview.dataSource = self

}


func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
  
    return pharmasies.count
    }
 
func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProviderCVCell", for: indexPath) as! ProviderCVCell
  //  let image = categories[indexPath.row].categoryimage
    
  //  let imageUrl = URL(string: image!)
  //  Cell.image.sd_setImage(with: imageUrl, completed: nil)
    cell.nameLbl.text = pharmasies[indexPath.row].pharmacyname
    cell.image.sd_setImage(with: URL(string: pharmasies[indexPath.row].pharmacy_Image!), completed: nil)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (providercollectioview.frame.size.width - space) / 2.0
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

