//
//  ViewController.swift
//  Favorite Restaurants
//
//  Created by jbergandino on 3/23/16.
//  Copyright © 2016 gotrackingtechnologies. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    var manager:CLLocationManager!
    
//    @IBOutlet var latitudeLabel: UILabel!
//    @IBOutlet var longitudeLabel: UILabel!
//    @IBOutlet var courseLabel: UILabel!
//    @IBOutlet var speedLabel: UILabel!
//    @IBOutlet var altitudeLabel: UILabel!
//    @IBOutlet var addressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy - kCLLocationAccuracyBest
        
        if activePlace == -1 {
            manager.requestWhenInUseAuthorization()
            manager.startUpdatingLocation()
        } else {
            
            //Get the coordinates of what was tapped
            
            //Need a double so convert this to a NSString then use the doubleValue method
            let latitude = NSString(string: places[activePlace]["lat"]!).doubleValue
            let longitude = NSString(string: places[activePlace]["lon"]!).doubleValue
            //Everything else as usual for coordinates
            var latDelta : CLLocationDegrees = 0.04
            var longDelta : CLLocationDegrees = 0.04
            var span : MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
            var location : CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            var region : MKCoordinateRegion = MKCoordinateRegionMake(location, span)
            //Set to map
            self.map.setRegion(region, animated: true)
            
            //Add an annotation just like below
            var annotation = MKPointAnnotation()
            //Set the annotation coordinates to what was just grabbed
            annotation.coordinate = location
            //Set a title to the marker
            annotation.title = places[activePlace]["name"]
            //annotation.subtitle = "Subtitle Here"
            //Add marker to map
            self.map.addAnnotation(annotation)


        }


        //Define long press recognizer (action func defined below)
        var uilpgr = UILongPressGestureRecognizer(target: self, action: "action:")
        //Add long press recognizer to map
        map.addGestureRecognizer(uilpgr)
    }
    
    //Long press function that is ran upon loading
    func action (gestureRecognizer : UIGestureRecognizer) {
    
        //Make sure only 1 long press is recognized
        if gestureRecognizer.state == UIGestureRecognizerState.Began {
        
            //Grab screen location (in view, doesn't add coordinates)
            var touchPoint = gestureRecognizer.locationInView(self.map)
            //Convert that screen location to actual coordinates for a marker
            var newLocation = self.map.convertPoint(touchPoint, toCoordinateFromView: self.map)
            
            //Need to convert newLocation to a type of CLLocation, do that by defining a new variable
            var newCLLocation = CLLocation(latitude: newLocation.latitude, longitude: newLocation.longitude)
            

            
            //Get Nearest Address
            CLGeocoder().reverseGeocodeLocation(newCLLocation, completionHandler: { (placemarks, error) -> Void in
                
                //Define a marker title variable
                var markerTitle = ""
                
                if (error == nil) {
                
                    if let p = placemarks?[0] {
                    
                        //Make sure to define these with ! after String 
                        var subThoroughfare : String! = ""
                        var thoroughfare : String! = ""
                        
                        if p.subThoroughfare != nil {
                            
                            subThoroughfare = p.subThoroughfare
                        }
                        if p.thoroughfare != nil {
                            
                            thoroughfare = p.thoroughfare
                        }
                        markerTitle = "\(subThoroughfare) \(thoroughfare)"
                    }
                }
                
                if markerTitle == "" {
                
                    markerTitle = "Added \(NSDate())"
                }
                
                places.append(["name":markerTitle, "lat":"\(newLocation.latitude)", "lon":"\(newLocation.longitude)"] )
              
                //Creating a marker object
                var annotation = MKPointAnnotation()
                //Set the annotation coordinates to what was just grabbed
                annotation.coordinate = newLocation
                //Set a title to the marker
                annotation.title = markerTitle
                //annotation.subtitle = "Subtitle Here"
                //Add marker to map
                self.map.addAnnotation(annotation)
            })
            
        }
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print(locations)
        
        //For userLocation - there is no need for casting, because we are now using CLLocation object
        //Set the first known location to a variable
        var userLocation : CLLocation = locations[0]
        //Extract Latitude/Longitude and build a location object as usual
        var latitude = userLocation.coordinate.latitude
        var longitude = userLocation.coordinate.longitude
        //var speed = userLocation.speed
        //var course = userLocation.course
        var latDelta : CLLocationDegrees = 0.04
        var longDelta : CLLocationDegrees = 0.04
        var span : MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        var location : CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        var region : MKCoordinateRegion = MKCoordinateRegionMake(location, span)

        
//        self.latitudeLabel.text = "\(userLocation.coordinate.latitude)"
//        
//        self.longitudeLabel.text = "\(userLocation.coordinate.longitude)"
//        
//        self.courseLabel.text = "\(userLocation.course)"
//        
//        self.speedLabel.text = "\(userLocation.speed)"
//        
//        self.altitudeLabel.text = "\(userLocation.altitude)"
        

        
        //set to map
        self.map.setRegion(region, animated: true)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}