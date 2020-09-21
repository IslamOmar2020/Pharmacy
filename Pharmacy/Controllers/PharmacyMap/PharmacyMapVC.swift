//
//  PharmacyMapVC.swift
//  Pharmacy
//
//  Created by Islam Omar on 8/20/20.
//  Copyright © 2020 Islam Omar. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

let DEFAULT_LOCATION = CLLocation(latitude: 31.9522, longitude: 35.2332)
let coordinate = CLLocationCoordinate2D(latitude: 31.9520, longitude: 35.2330)
class PharmacyMapVC: UIViewController ,MKMapViewDelegate, UITextFieldDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var aMap: MKMapView!
        @IBOutlet weak var distanceLabel: UILabel!
        @IBOutlet weak var distanceSlider: UISlider!
        @IBOutlet weak var locationTxt: UITextField!

        var distance = 50.0
        var location = CLLocation()
        var locationManager: CLLocationManager!
        var mapIsSatellite = false

        override func viewDidLoad() {
            super.viewDidLoad()
            // Setup the mapView's delegate and type
            aMap.mapType = .standard
            aMap.delegate = self
           let pin = MKPointAnnotation()
            pin.coordinate = coordinate
            aMap.addAnnotation(pin)
        
            // Set initial default distance around the MapView's Pin
            let formattedDistance = String(format: "%.0f", distance)
            distanceLabel.text = "\(formattedDistance) Km around your location"
            
            // Set the value of the distance Slider accordingly
            distanceSlider.value = Float(distance)
            
            // Get current Location
            currentLocationButt(self)
          
        }
       
        // ------------------------------------------------
        // MARK: - SEARCH FOR A LOCATION BY ADDRESS OR CITY
        // ------------------------------------------------
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            
            if textField.text != "" {
                // Get the address string you've typed in the TextField
                let address = textField.text!
                textField.resignFirstResponder()
                print("ADDRESS: \(address)")
                
                // Launch Geocoder to retrieve GPS coordinates form the address string
                let geocoder = CLGeocoder()
                geocoder.geocodeAddressString(address, completionHandler: { (placemarks, error) in
                    if let placemark = placemarks?.first {
                        let coords = placemark.location!.coordinate
                        
                        // Set Location
                        self.location = CLLocation(latitude: coords.latitude, longitude: coords.longitude)
                        self.addPinOnMap(self.location)
                        
                    } else { self.simpleAlert("Location not found. Try a new search.") }
                })
                
            } else { simpleAlert("Please type somehting!") }
            
            return true
        }
        
        @IBAction func currentLocationButt(_ sender: Any) {
            locationManager = CLLocationManager()
                   locationManager.delegate = self
                   locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
                   if locationManager.responds(to: #selector(CLLocationManager.requestWhenInUseAuthorization)) {
                       locationManager.requestAlwaysAuthorization()
                   }
                   locationManager.startUpdatingLocation()
                   
                   // Reset the locationTxt
                   locationTxt.text = ""
        }
        
        
        
        
        // ------------------------------------------------
           // MARK: - CORE LOCATION DELEGATES
           // ------------------------------------------------
           func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
               simpleAlert("Failed to get your location. Please go into Settings and enable Location service for this app.")
               
               // Set the default currentLocation
               location = DEFAULT_LOCATION
               
               // Add pin on the map
               addPinOnMap(location)
           }
           
           
           func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
               locationManager.stopUpdatingLocation()
               
               location = locations.last!
               locationManager = nil
               
               // Add pin on the map
               addPinOnMap(location)
           }
           
           
           
           
           
           
           // ------------------------------------------------
           // MARK: - ADD A PIN ON THE MAPVIEW
           // ------------------------------------------------
           func addPinOnMap(_ location: CLLocation) {
               aMap.delegate = self
               aMap.removeOverlays(aMap.overlays)
               
               if aMap.annotations.count != 0 {
                   let annotation = aMap.annotations[0]
                   aMap.removeAnnotation(annotation)
               }
               
               // Add PointAnnonation text and a Pin to the Map
               let pointAnnotation = MKPointAnnotation()
               
               // Set pin title and subtitle
               pointAnnotation.title = "Hey, I'm here!"
               pointAnnotation.subtitle = "Such a cool place"
               
               pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude,
                                                                   longitude:location.coordinate.longitude)
               let pinView = MKPinAnnotationView(annotation: pointAnnotation, reuseIdentifier: nil)
               
               aMap.centerCoordinate = pointAnnotation.coordinate
               aMap.addAnnotation(pinView.annotation!)
               
               // Zoom the Map to the location
               let region = MKCoordinateRegion.init(center: pointAnnotation.coordinate, latitudinalMeters: distance*4000, longitudinalMeters: distance*4000);
               aMap.setRegion(region, animated: true)
               aMap.regionThatFits(region)
               aMap.reloadInputViews()
               
               
               // Add a circle around the location
               addRadiusCircle(location)
           }
           
           
           
           
           // ------------------------------------------------
           // MARK: - ADD A CIRCLE AROUND THE AREA
           // ------------------------------------------------
           func addRadiusCircle(_ location: CLLocation) {
               let circle = MKCircle(center: location.coordinate, radius: distance*1609 as CLLocationDistance)
               aMap.addOverlay(circle)
           }
           
           func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
               if overlay is MKCircle {
                   let circle = MKCircleRenderer(overlay: overlay)
                   circle.strokeColor = UIColor.yellow
                   circle.fillColor = UIColor(red: 255, green: 255, blue: 0, alpha: 0.1)
                   circle.lineWidth = 1
                   return circle
               }
               
               return MKOverlayRenderer()
           }
           
           
           
           
           
           // ------------------------------------------------
           // MARK: - CUSTOMIZE PIN ANNOTATION
           // ------------------------------------------------
           func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
               if annotation.isKind(of: MKPointAnnotation.self) {
                   
                   // Try to dequeue an existing pin view first.
                   let reuseID = "CustomPinAnnotationView"
                   var annotView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseID)
                   
                   if annotView == nil {
                       annotView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
                       annotView!.canShowCallout = true
                       
                       // Custom Pin image
                       let imageView = UIImageView(frame: CGRect(x:0, y:0, width:44, height: 44))
                       imageView.image =  UIImage(named: "map_pin")
                       imageView.center = annotView!.center
                       imageView.contentMode = .scaleAspectFill
                       annotView!.addSubview(imageView)
                       
                       // RIGHT Callout Accessory
                       let rightButton = UIButton(type: .custom)
                       rightButton.frame = CGRect(x:0, y:0, width:32, height: 32)
                       rightButton.layer.cornerRadius = rightButton.bounds.size.width/2
                       rightButton.clipsToBounds = true
                       rightButton.setImage(UIImage(named: "directions_butt"), for: .normal)
                       annotView!.rightCalloutAccessoryView = rightButton
                   }
                   return annotView
                   
               }
               return nil
           }
           
           
           
           // ------------------------------------------------
           // MARK: - OPEN THE NATIVE iOS MAPS APP
           // ------------------------------------------------
           func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
               let annotation = view.annotation!
               let coordinate = annotation.coordinate
               let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: nil)
               let mapitem = MKMapItem(placemark: placemark)
               mapitem.name = annotation.title!
               mapitem.openInMaps(launchOptions: nil)
           }
           
        
        @IBAction func setLocationButt(_ sender: Any) {
             if location.coordinate.latitude != 0.0 {
                       let geoCoder = CLGeocoder()
                       geoCoder.reverseGeocodeLocation(location) { (placemarks, error) in
                           if error == nil {
                               let placeArray:[CLPlacemark] = placemarks!
                               var placemark: CLPlacemark!
                               placemark = placeArray[0]
                               
                               // Address data
                               let street = placemark.addressDictionary?["Name"] as? String ?? ""
                               let city = placemark.addressDictionary?["City"] as? String ?? ""
                           //    let zip = placemark.addressDictionary?["ZIP"] as? String ?? ""
                               let country = placemark.addressDictionary?["Country"] as? String ?? ""
                             //  let state = placemark.addressDictionary?["State"] as? String ?? ""
                               
                               // Get Address
                               let address = "ADDRESS:\n\(street) - , \(city) - \(country)"
                               
                               // Show info to the next screen
//                               let vc = self.storyboard?.instantiateViewController(withIdentifier: "PaymentVC") as! PaymentVC
//                               vc.address = address
//                               vc.location = self.location
//                               self.navigationController?.pushViewController(vc, animated: true)
                               
                               
                               // error
                           } else { self.simpleAlert("Geolocation not found! Try a new search.") }
                           
                       }// ./ geoCoder
                   }// ./ If
        }
           
           
           

        @IBAction func distanceChanged(_ sender: UISlider) {
            distance = Double(sender.value)
            let formattedDistance = String(format: "%.0f", distance)
            distanceLabel.text = "\(formattedDistance) Km around your location"
        }
        @IBAction func sliderEndDrag(_ sender: UISlider) {
            // Refresh the MapView
            addPinOnMap(location)
        }
        @IBAction func satelliteButt(_ sender: Any) {
            mapIsSatellite = !mapIsSatellite
                   
                   if mapIsSatellite { aMap.mapType = .satellite
                   } else { aMap.mapType = .standard }
        }
        
        
         // ------------------------------------------------
         // MARK: - SHOW SIMPLE ALERT CONTROLLER
         // ------------------------------------------------
         func simpleAlert(_ mess:String) {
             let alert = UIAlertController(title: "Custom Map",
                 message: mess, preferredStyle: .alert)
             let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in })
             alert.addAction(ok)
             present(alert, animated: true, completion: nil)
         }
         
        

    }

