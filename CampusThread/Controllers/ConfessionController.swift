//
//  ConfessionController.swift
//  CampusThread
//
//  Created by NANI on 26/01/20.
//  Copyright © 2020 NANI. All rights reserved.
//

import UIKit
import Firebase
class ConfessionController: UIViewController,UITextViewDelegate {

    
    @IBOutlet weak var confessionTextView: UITextView!
    
    var message = [mainmessage]()
    let db = Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()
        confessionTextView.delegate = self
        confessionTextView.text = "Placeholder"
        confessionTextView.textColor = UIColor.lightGray
        // Do any additional setup after loading the view.
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    @IBAction func postPressed(_ sender: UIBarButtonItem) {
        
        if let confessionMessage = confessionTextView.text,let uid = Auth.auth().currentUser?.uid,let messageSender = Auth.auth().currentUser?.email{
            let likes = 0
            let liked: [String] = []
            var personName = db.collection("users").whereField("uid", isEqualTo: uid).getDocuments { (querySnapshot, err) in
                if err != nil{
                    print(err ?? "error")
                }
                else{
                    if let snapshotDocuments = querySnapshot?.documents{
                        for doc in snapshotDocuments
                        {
                            let authorName = doc.data()["fullname"]
                            let ref = self.db.collection("Confession").document()
                            let docid = ref.documentID
//                            print(docid)
                            ref.setData(["message":confessionMessage,
                                         "sender": messageSender,
                                         "date": Date().timeIntervalSince1970,"postid":docid,"uid":uid,
                                         "likes":likes,
                                         "author":authorName!,
                                         "likedPeople": liked]) { (error) in
                                if let e = error{
                                    print(e)
                                }
                                else{
                                    print("success")
                                    DispatchQueue.main.async {
                                        self.performSegue(withIdentifier: "ConfessToHome", sender: self)
                                        
                                    }
                                }
                            }
                        }
                    }
                    
                }
            }

            
//            self.db.collection("mainthread").addDocument(data: ["message":confessionMessage,"sender": messageSender,"date": Date().timeIntervalSince1970,"likes":0]) { (error) in
//                            if let e = error{
//                                print(e)
//                            }
//                            else{
//                                print("success")
//                                DispatchQueue.main.async {
//                                    self.performSegue(withIdentifier: "ConfessToHome", sender: self)
//
//                                }
//                            }
//
//                        }
                    }
        
        
    }
    
}
