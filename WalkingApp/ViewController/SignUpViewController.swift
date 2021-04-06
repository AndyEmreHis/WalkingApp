//
//  SignUpViewController.swift
//  WalkingApp
//
//  Created by Andy Emre Kocak on 12/22/20.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {
    
    weak var delegate: EmailDelegate?
    
    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func SignUpCancel(_ sender: Any) {
        performSegue(withIdentifier: "ExitSignUpSegue", sender: self)
    }
    
    @IBOutlet weak var SignUpUsernameField: UITextField!
    
    @IBOutlet weak var SignUpEmailField: UITextField!
    
    @IBOutlet weak var SignUpPassword: UITextField!
    
    @IBOutlet weak var ErrorLabel: UILabel!
    
    func validateFields() -> String? {
        
        if SignUpUsernameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || SignUpEmailField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || SignUpPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            
            return "Please fill all fields"
            
        }
        
        let cleanedPassword = SignUpPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let cleanedEmail = SignUpEmailField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false{
            return "Please make sure you have two uppercase, one special case letter, two digits, and lenght of 8 characters"
        }
        
        if Utilities.isEmailValid(cleanedEmail) == false{
            return "Please make sure you have entered a valid email adress"
        }
        
        return nil
        
    }
    
    func transtitionToHome(emailName: String){
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        homeViewController?.emailName = emailName
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
    
    @IBAction func SignUpPressed(_ sender: Any) {
        
        let error = validateFields()
        
        if error != nil{
            ErrorLabel.text = error!
            ErrorLabel.alpha = 1
        }
        else{
            
            let username = SignUpUsernameField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = SignUpPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = SignUpEmailField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                if  err != nil{
                    self.ErrorLabel.text = "Error creating user."
                    self.ErrorLabel.alpha = 1
                }
                
                else{
                    
                    self.db.collection("users").document(email).setData(["name": username, "email": email, "password": password, "uid": result!.user.uid, "currentLat": 41.28, "currentLon": 28.9, "steps": 0, "targetLat": 41.28, "targetLon": 36.3, "distToTarget": 740, "distTravelled": 0]) { (error) in
                        
                        if error != nil{
                            self.ErrorLabel.text = "Error saving user data."
                            self.ErrorLabel.alpha = 1
                        }
                        
                    }
                    
                    print("LOLOLOLOLOLOLOLOLOLOL")
                    
                    let docRef = self.db.collection("users").document(email)

                    docRef.getDocument { (document, error) in
                        if let document = document, document.exists {
                            let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                            print("Document data: \(dataDescription)")
                     }
                }
                            
                    //self.completionHandler?(email)
                    //self.delegate?.EmailChosen(email)// Eror is here
                    
                    self.transtitionToHome(emailName: email)
                    
                }
            }
            
        }
        
    }

}
    


