//
//  Tab2ViewController.swift
//  CampusThread
//
//  Created by NANI on 06/01/20.
//  Copyright © 2020 NANI. All rights reserved.
//

//import Foundation
import Firebase
import FirebaseAuth
import  UIKit


class Tab2ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let db = Firestore.firestore()
    let picker = UIImagePickerController()
    let storage = Storage.storage()
    
    let userUid = Auth.auth().currentUser?.uid
    @IBOutlet weak var profilePic: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        let finalImageRef = storage.reference().child("images").child("\(userUid!).jpg")
        finalImageRef.getData(maxSize: 1 * 1024 * 1024) { (data, err) in
            if err != nil{
                print(err ?? "error")
            }
            else{
                self.profilePic.image = UIImage(data: data!)
            }
        }
        
        finalImageRef.downloadURL { (url, errr) in
            if errr != nil{
                print(errr)
            }
//                guard let urll = url else { return }
            let uuu = url?.absoluteString
            
            print(uuu)
        }
        //        overrideUserInterfaceStyle = .light
    }
    
    @IBAction func editPicPressed(_ sender: UIButton) {
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.profilePic.image = image
            imageStoring()
        }
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func imageStoring(){
        
        let storageRef = storage.reference()
        let imagesRef = storageRef.child("images")
//        let userUid = Auth.auth().currentUser?.uid
        let finalImageRef = imagesRef.child("\(userUid!).jpg")
        let data = profilePic.image?.jpegData(compressionQuality: 0.5)
        let uploadTask = finalImageRef.putData(data!, metadata: nil) { (metadata, err) in
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
                        self.db.collection("users").whereField("uid", isEqualTo: self.userUid).getDocuments { (querySnapshot, err) in
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
        
        uploadTask.resume()
    }
    
    @IBAction func myConfessionsButtonPressed(_ sender: UIButton) {
    }
    @IBAction func manageProfilePressed(_ sender: UIButton) {
    }
    @IBAction func logoutpressed(_ sender: UIButton) {
        
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }

    }
    
}
