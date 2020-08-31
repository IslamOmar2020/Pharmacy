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
    @IBOutlet var imagesSlide: ImageSlideshow!
    @IBOutlet weak var addcategoryBtn: UIButton!
    @IBOutlet weak var addpharamcyBtn: UIButton!
    @IBOutlet weak var adddrugbtn: UIButton!
    @IBOutlet weak var providercollectioview: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpelements()
        imageSlider()
        
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
    
}
