//
//  ViewController.swift
//  CampusThread
//
//  Created by NANI on 01/01/20.
//  Copyright © 2020 NANI. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        overrideUserInterfaceStyle = .light
        navigationItem.hidesBackButton = true
    }
    
    @IBAction func signinPressed(_ sender: UIButton) {

        if let email = userName.text,let password = password.text
        {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error{
                    print(e.localizedDescription)
                    
                    let errorMessage = e.localizedDescription
                    let alert = UIAlertController(title: "Invalid Credintials", message: errorMessage, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style:.default, handler: nil))
                    self.present(alert,animated: true, completion: nil)
                }
                else{
                    self.performSegue(withIdentifier: "SigninToTab", sender: self)
                }
            }
        }
    }
    
    @IBAction func forgotPressed(_ sender: UIButton) {
    }
    @IBAction func signupPressed(_ sender: UIButton) {
    }
    
}

