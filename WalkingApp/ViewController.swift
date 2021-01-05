//
//  ViewController.swift
//  WalkingApp
//
//  Created by Andy Emre Kocak on 12/15/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func SignUpMainMenu(_ sender: Any) {
        performSegue(withIdentifier: "SignUpSegue", sender: self)
    }
    
    @IBAction func LoginMainMenu(_ sender: Any) {
        performSegue(withIdentifier: "LoginSegue", sender: self)
    }
    
    
    
}

