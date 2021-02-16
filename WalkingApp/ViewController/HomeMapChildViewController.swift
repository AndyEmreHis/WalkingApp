//
//  HomeMapChildViewController.swift
//  WalkingApp
//
//  Created by Andy Emre Kocak on 2/1/21.
//

import UIKit
import GoogleMaps
import Firebase
import MapKit
class HomeMapChildViewController: UIViewController{
    
    /*let db = Firestore.firestore()
    
    public var emailName = ""
    
    var emailHere = false
    
    var userLat = 0.0
    
    var userLon = 0.0
    
    func ChangeLabel(labelToChange : String){

        self.emailName = labelToChange
        
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        /*let group = DispatchGroup()
        group.enter()
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            
            NotificationCenter.default.addObserver(self, selector: #selector(self.emailChanged), name: Notification.Name("EmailAdded"), object: nil)
            
            NotificationCenter.default.addObserver(self, selector: #selector(self.markerChanged), name: Notification.Name("ChangeMarker"), object: nil)
            
               group.leave()
           }
        
        group.wait()
        
        
 
        let camera = GMSCameraPosition.camera(withLatitude: userLat, longitude: userLon, zoom: 5.0)
        let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        self.view.addSubview(mapView)

                // Creates a marker in the center of the map.
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: self.userLat, longitude: self.userLon)
        marker.title = "Current"
        marker.snippet = "Turkey"
        marker.map = mapView
        
        let endMarker = GMSMarker()
        endMarker.position = CLLocationCoordinate2D(latitude: 41.28, longitude: 36.3)
        endMarker.title = "Samsun"
        endMarker.snippet = "Turkey"
        endMarker.map = mapView
        
        /*let path = GMSMutablePath()
        path.add(CLLocationCoordinate2D(latitude: self.userLat , longitude: self.userLon))
        path.add(CLLocationCoordinate2D(latitude: 41.28, longitude: 36.33))

        let rectangle = GMSPolyline(path: path)
        rectangle.map = mapView*/
        
        
        
        //print(emailName)
        
        
        
    }
    
    @objc func emailChanged(){
        print(emailName)
        NotificationCenter.default.post(name: Notification.Name("ChangeMarker"), object: nil)
        //self.emailHere = true
    }
    
    
    
    @objc func markerChanged(){
        
        let docRef = db.collection("users").document(emailName)

            docRef.getDocument(source: .cache) { (document, error) in
                if let document = document {
                    self.userLat = document.get("currentLat") as! Double
                    print(self.userLat)
                    self.userLon = document.get("currentLon") as! Double
                    print(self.userLon)
                }
                    
            }
        
        
        //self.mapView.clear()
        
    }
    
    func getRoute(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D) {
        
        let source = MKMapItem(placemark: MKPlacemark(coordinate: from))
        let destination = MKMapItem(placemark: MKPlacemark(coordinate: to))

        let request = MKDirections.Request()
        request.source = source
        request.destination = destination
        request.requestsAlternateRoutes = false

        let directions = MKDirections(request: request)

        directions.calculate(completionHandler: { (response, error) in
            if let res = response {
                //the function to convert the result and show
                self.show(polyline: self.googlePolylines(from: res))
            }
        })
    }
    
    private func googlePolylines(from response: MKDirections.Response) -> GMSPolyline {

        let route = response.routes[0]
        var coordinates = [CLLocationCoordinate2D](
            repeating: kCLLocationCoordinate2DInvalid,
            count: route.polyline.pointCount)

        route.polyline.getCoordinates(
            &coordinates,
            range: NSRange(location: 0, length: route.polyline.pointCount))

        let polyline = Polyline(coordinates: coordinates)
        let encodedPolyline: String = polyline.encodedPolyline
        let path = GMSPath(fromEncodedPath: encodedPolyline)
        return GMSPolyline(path: path)
        
    }
    
    func show(polyline: GMSPolyline) {

        //add style to polyline
        polyline.strokeColor = UIColor.red
        polyline.strokeWidth = 3
        
        //add to map
        polyline.map = mapView
    }*/
    
    

}
