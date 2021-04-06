//
//  SelectSportViewController.swift
//  WalkingApp
//
//  Created by Andy Emre Kocak on 2/17/21.
//

import UIKit

class SelectSportViewController: UIViewController {
    
    var activity = ""
    
    var emailName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is AddActivityViewController {
            let vc = segue.destination as? AddActivityViewController
            vc?.activityChosen = activity
            vc?.emailName = emailName
        }
    }
    
    @IBAction func TennisButton(_ sender: Any) {
        activity = "tennis"
        performSegue(withIdentifier: "ActivityChosenSegue", sender: self)
    }
    
    @IBAction func BasketballButton(_ sender: Any) {
        activity = "basketball"
        performSegue(withIdentifier: "ActivityChosenSegue", sender: self)
    }
    
    @IBAction func WalkingButton(_ sender: Any) {
        activity = "walking"
        performSegue(withIdentifier: "ActivityChosenSegue", sender: self)
    }
    
    @IBAction func SwimmingButton(_ sender: Any) {
        activity = "swimming"
        performSegue(withIdentifier: "ActivityChosenSegue", sender: self)
    }
    
    @IBAction func FootballButton(_ sender: Any) {
        activity = "football"
        performSegue(withIdentifier: "ActivityChosenSegue", sender: self)
    }
    
    @IBAction func GolfButton(_ sender: Any) {
        activity = "golf"
        performSegue(withIdentifier: "ActivityChosenSegue", sender: self)
    }
    
    @IBAction func VolleyballButton(_ sender: Any) {
        activity = "volleyball"
        performSegue(withIdentifier: "ActivityChosenSegue", sender: self)
    }
    
    @IBAction func SelectCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
