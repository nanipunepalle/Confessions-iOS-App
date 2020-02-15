//
//  SignupViewController.swift
//  CampusThread
//
//  Created by NANI on 01/01/20.
//  Copyright © 2020 NANI. All rights reserved.
//
import Foundation
import UIKit
import FirebaseAuth
import FirebaseFirestore
import Firebase
class SignupViewController: UIViewController {
    
    
    //Initialising firebase data base
    let db = Firestore.firestore()
    
    
    let University = ["VIT University,Vellore","GITAM University","SRM University"]
    
    var selectedUniversity: String?
    
    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var universityTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUniversityPicker()
        createToolBar()
        // Do any additional setup after loading the view.
        //        overrideUserInterfaceStyle = .light
    }
    
    //Regular expression for strong password
    
    func isPasswordValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    //Validating fields in the form
    
    func validateFields() -> String?{
        if fullName.text == "" || email.text == "" || password.text == "" || universityTextField.text == "" {
            return  "Please fill in all fields"
        }
        let updatedPassword = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if isPasswordValid(updatedPassword) == false{
            return "Password must have 8 characters with atleast one Alphabet and one Password"
        }
        return nil
    }
    
    //signup button
    
    @IBAction func signupPressed(_ sender: UIButton) {
        
        //validation fields and displaying error
        let error = validateFields()
        if error != nil{
            let alert = UIAlertController(title: "Invalid Credintials", message: validateFields(), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style:.default, handler: nil))
            self.present(alert,animated: true, completion: nil)
        }
            
            //creating a user
            
        else{
            
            let fullname = fullName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let Email = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let Password = password.text!
            let college = universityTextField.text!
            Auth.auth().createUser(withEmail: Email, password: Password) { (result, err) in
                if err != nil{
                    print("error")
                }
                // adding data to database
                else{
                    self.performSegue(withIdentifier: "SignupToTab", sender: self )
                    self.db.collection("users").addDocument(data: ["fullname":fullname,"College/University":college,"Date":Date().timeIntervalSince1970,"uid":result!.user.uid]) { (error) in
                        if error != nil{
                            print(error ?? "error")
                        }
                        
                    }
                    
                    
                }
            }
            
        }
    }
    
    
    func createUniversityPicker(){
        let datePicker = UIPickerView()
        datePicker.delegate = self
        universityTextField.inputView = datePicker
    }
    
    func createToolBar(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(SignupViewController.dismissKeyboard))
        
        toolbar.setItems([doneButton], animated: true)
        toolbar.isUserInteractionEnabled = true
        
        universityTextField.inputAccessoryView = toolbar
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}

extension SignupViewController: UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return University.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return University[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedUniversity = University[row]
        
        universityTextField.text = selectedUniversity
    }
    
}
