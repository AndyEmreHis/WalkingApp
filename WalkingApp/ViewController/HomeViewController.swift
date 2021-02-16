//
//  HomeViewController.swift
//  WalkingApp
//
//  Created by Andy Emre Kocak on 12/29/20.
//

import UIKit
import GoogleMaps
import Firebase
import CoreData
import MapKit

class HomeViewController: UIViewController{
    
    @IBOutlet var mapView: GMSMapView!

    
    //var containerViewController: Container?
    
    public var emailName = ""
    
    var polyline: GMSPolyline? = nil
    
    var stepProperty = 0
    
    var userLat = 41.28

    var userLon = 28.9
    
    let db = Firestore.firestore()
    
    var distance = 0.0
    
    @IBOutlet weak var StepCountLabel: UILabel!
    
    var noSteps = 0
    
    public var completionHandler: ((String?) -> Void)?
    
    /*func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "MapSegue" {
            containerViewController = segue.destinationViewController as? Container
            //containerViewController!.containerToMaster = self
        }
    }*/
    
    /*func sendData(MyStringToSend : String) {
        let CVC = children.last as! HomeMapChildViewController
        CVC.ChangeLabel(labelToChange: MyStringToSend)
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print(emailName)
        
        let docRef = db.collection("users").document(emailName)

                docRef.getDocument(source: .cache) { (document, error) in
                    if let document = document {
                        self.stepProperty = document.get("steps") as! Int
                        print(self.stepProperty)
                        self.StepCountLabel.text = "Number Of Steps: " + String(self.stepProperty)
                    }
                
                }
        print(self.stepProperty)
        self.StepCountLabel.text = "Number Of Steps: " + String(self.stepProperty)
        
        
        /*sendData(MyStringToSend: emailName)
        
        NotificationCenter.default.post(name: Notification.Name("EmailAdded"), object: nil)*/
        
        let camera = GMSCameraPosition.camera(withLatitude: userLat, longitude: userLon, zoom: 5.0)
        
        self.mapView.camera = camera
        
        var favCoordinatesArray: [CLLocationCoordinate2D]  = [CLLocationCoordinate2D(latitude: self.userLat, longitude: self.userLon), CLLocationCoordinate2D(latitude: 41.28, longitude: 36.3)]
        
        setMapMarkersRoute(vLoc: favCoordinatesArray[0], toLoc: favCoordinatesArray[1])
        
        self.distance = getDistance(from: favCoordinatesArray[0], to: favCoordinatesArray[1])
        
       // let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        //self.view.addSubview(mapView)
        
        /*var points = GetPointsAtADistance(meters: 1000)
        var i = 0
        while i < points.count{
            var marker = GMSMarker.init(position: points[i].coordinate)
            marker.map = mapView
            i += 1
        }*/
        
        NotificationCenter.default.addObserver(self, selector: #selector(AddRoadMarkers), name: Notification.Name("PolylineAdded"), object: nil)
       
    }
    
    @objc func AddRoadMarkers(){
        var points = GetPointsAtADistance(meters: 1000)
        var i = 0
        while i < points.count{
            var marker = GMSMarker.init(position: points[i].coordinate)
            marker.map = mapView
            i += 1
        }
    }
    
    func setMapMarkersRoute(vLoc: CLLocationCoordinate2D, toLoc: CLLocationCoordinate2D) {

        //add the markers for the 2 locations
        let markerTo = GMSMarker.init(position: toLoc)
        markerTo.map = mapView
        let vMarker = GMSMarker.init(position: vLoc)
        vMarker.map = mapView

        //zoom the map to show the desired area
        var bounds = GMSCoordinateBounds()
        bounds = bounds.includingCoordinate(vLoc)
        bounds = bounds.includingCoordinate(toLoc)
        self.mapView.moveCamera(GMSCameraUpdate.fit(bounds))

        //finally get the route
        getRoute(from: vLoc, to: toLoc)

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
                self.polyline = self.googlePolylines(from: res)
                self.show(polyline: self.polyline!)
                NotificationCenter.default.post(name: Notification.Name("PolylineAdded"), object: nil)
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
        //print(polyline.path)
        //add to map
        polyline.map = mapView
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
        
        
        self.mapView.clear()
        
    }
    
    func GetPointsAtADistance(meters: Int) -> [CLLocation]{
        var next = meters
        var points: [CLLocation] = []
        var dist = 0
        var olddist = 0
        var i = 1
        while i < Int(self.distance) {
            olddist = dist
            var p3 = self.polyline!.path?.coordinate(at: UInt(i - 1))
            var p4 = self.polyline!.path?.coordinate(at: UInt(i))
            dist += Int(getDistance(from: p4!, to: p3!))
            while dist > next{
                var p1 = self.polyline!.path?.coordinate(at: UInt(i - 1))
                var p2 = self.polyline!.path?.coordinate(at: UInt(i))
                var dunno = p2?.latitude
                var m = (next - olddist) / (dist - olddist)
                points.append(CLLocation(latitude: p1!.latitude + (p2!.latitude - p1!.latitude) * Double(m), longitude: p1!.longitude + (p2!.longitude - p1!.longitude) * Double(m)))
                next += meters
            }
            
            i += 1
            
        }
        return points
    }
    
    func getDistance(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D) -> CLLocationDistance {
            let from = CLLocation(latitude: from.latitude, longitude: from.longitude)
            let to = CLLocation(latitude: to.latitude, longitude: to.longitude)
            return from.distance(from: to)
        }
    

}
