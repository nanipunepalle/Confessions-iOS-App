//
//  ResetPasswordViewController.swift
//  CampusThread
//
//  Created by NANI on 06/01/20.
//  Copyright © 2020 NANI. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class ResetPasswordViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailField.text = ""
        // Do any additional setup after loading the view.
    }
    
    @IBAction func resetButtonPressed(_ sender: Any) {
        
        
        // Password reset Authenciation
        
        if let email = emailField.text {
            Auth.auth().sendPasswordReset(withEmail: email) { (err) in
                if err != nil{
                    
                    //alert message for error
                    let alert = UIAlertController(title: "Invalid email", message: "Enter valid email address", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style:.default, handler: nil))
                    self.present(alert,animated: true, completion: nil)
                }
                else{
                    
                    //alert message for verification of email
                    
                    let alert = UIAlertController(title: "Success", message: "Check your email and continue with login", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Dismiss", style:.default, handler: nil))
                        self.present(alert,animated: true, completion: nil)
                    self.emailField.text = ""
                    }
                    
                }
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


