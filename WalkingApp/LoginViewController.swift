//
//  LoginViewController.swift
//  WalkingApp
//
//  Created by Andy Emre Kocak on 12/22/20.
//

import UIKit
import FirebaseAuth
class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func LoginCancel(_ sender: Any) {
        performSegue(withIdentifier: "ExitLoginSegue", sender: self)
    }
    
    @IBOutlet weak var LoginUsernameField: UITextField!
    
    @IBOutlet weak var LoginPasswordField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    func transtitionToHome(){
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
    @IBAction func LoginButtonPressed(_ sender: Any) {
        
        let email = LoginUsernameField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = LoginPasswordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                    
                    if error != nil {
                        // Couldn't sign in
                        self.errorLabel.text = error!.localizedDescription
                        self.errorLabel.alpha = 1
                    }
                    else {
                        
                        self.transtitionToHome()
                        
                    }
        
        }
    }
    
    
    
    /*
// MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
    
