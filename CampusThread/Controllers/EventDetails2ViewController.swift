//
//  EventDetails2ViewController.swift
//  CampusThread
//
//  Created by Lalith on 04/02/20.
//  Copyright © 2020 NANI. All rights reserved.
//

import UIKit
import Firebase
class EventDetails2ViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    var newEvent = [events]()
    var eventName: String = ""
    var eventType: [String] = []
    var eventStartDate: Date!
    var eventEndDate: Date!
    var regFees: String!
    
    let picker = UIImagePickerController()
    let db = Firestore.firestore()
    let poster = UIImageView()
    let storage = Storage.storage()
    
    @IBOutlet weak var eventVenueCollege: UITextField!
    @IBOutlet weak var eventVenueBuildingTextField: UITextField!
    @IBOutlet weak var eventPosterTextField: UITextField!
    
    @IBOutlet weak var eventVenueCountry: UITextField!
    @IBOutlet weak var eventVenueState: UITextField!
    @IBOutlet weak var eventRegLinkTextField: UITextField!
    
    
    @IBOutlet weak var eventDescTextArea: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        eventPosterTextField.delegate = self
        
        print(eventName)
        print(eventType)
        print(eventStartDate!)
        print(eventEndDate!)
        print(regFees!)
    }
    
    @IBAction func uploadPosterButtonPressed(_ sender: UIButton) {
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            eventPosterTextField.text = image.accessibilityIdentifier
            self.poster.image = image
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        
        if let eventcollege = eventVenueCollege.text,
            let eventBuilding = eventVenueBuildingTextField.text,
            let eventcountry = eventVenueCountry.text,
            let eventVenueState = eventVenueState.text,
            let eventlink = eventRegLinkTextField.text,
            let uid = Auth.auth().currentUser?.uid{
            
            let ref = self.db.collection("EventDetails").document()
            
            let docid = ref.documentID
            ref.setData(["eventName" : eventName,
                         "eventType": eventType,
                         "startDate": eventStartDate!,
                         "endDate": eventEndDate!,
                         "regfees": regFees!,
                         "eventCollege": eventcollege,
                         "eventBuilding": eventBuilding,
                         "eventCountry": eventcountry,
                         "eventState": eventVenueState,
                         "uid": uid,
                         "docid": docid,
                         "eventreglink":eventlink,
                         "eventregisteredDate": Date().timeIntervalSince1970]) { (err) in
                            if err != nil{
                                print(err!)
                            }
                            else{
                                print("success")
                                DispatchQueue.main.async {
//                                    self.performSegue(withIdentifier: "EventDetailsToEventHome", sender: self)
//                                    self.dismiss(animated: true) {
//                                        print("succ")
//                                    }
                                    self.navigationController?.popViewController(animated: true)
                                    self.navigationController?.popViewController(animated: true)
                                }
                                
                            }
            }
            
            //saving poster
            
            
            let storageRef = storage.reference()
            let imagesRef = storageRef.child("posters")
            let userUid = Auth.auth().currentUser?.uid
            let finalImageRef = imagesRef.child("\(docid).jpg")
            let data = poster.image?.jpegData(compressionQuality: 0.5)
            finalImageRef.putData(data!, metadata: nil) { (metadata, err) in
                if err != nil{
                    print(err ?? "ERR")
                }
                else{
                    finalImageRef.downloadURL { (urll, err) in
                        if err != nil{
                            print(err ?? "error")
                        }
                        else{
                            let picurl = urll
                            print(picurl)
                            self.db.collection("users").whereField("uid", isEqualTo: userUid).getDocuments { (querySnapshot, err) in
                                if err != nil{
                                    print(err ?? "error")
                                }
                                else{
                                    if let snapshotDocuments = querySnapshot?.documents{
                                        for doc in snapshotDocuments{
                                            var data = doc.data()
                                            data.updateValue(picurl, forKey: "profilePic")
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
        }
    }
    
    
}
