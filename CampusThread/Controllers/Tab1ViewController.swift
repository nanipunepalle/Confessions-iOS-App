//
//  Tab1ViewController.swift
//  CampusThread
//
//  Created by NANI on 06/01/20.
//  Copyright © 2020 NANI. All rights reserved.
//

import Foundation
import FirebaseFirestore
import  UIKit
import FirebaseAuth


class Tab1ViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    var message = [mainmessage]()
    let db = Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        tableView.dataSource = self as UITableViewDataSource
        self.tableView.register(UINib(nibName: "MessageViewCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        loadmessages()
        tableView.allowsSelection = false
    }
    
    func loadmessages(){
        db.collection("Confession").order(by: "date",descending: true).addSnapshotListener { (querySnapshot, error) in
            
            self.message = []
            if error != nil{
                print(error ?? "error")
            }
            else{
                if let snapshotDocuments = querySnapshot?.documents{
                    for doc in snapshotDocuments{
                        let data = doc.data()
                        if let body = data["message"] as? String,
                            let sender = data["sender"] as? String,
                            let uid = data["uid"] as? String,
                            let postid = data["postid"] as? String,
                            let likes = data["likes"] as? NSNumber,
                            let likedpeople = data["likedPeople"] as? [String]{
                            let newThread = mainmessage(sender: sender, uid: uid , message: body,postid: postid,likes: Int(truncating: likes),likedpeople: likedpeople )
                    
                            self.message.append(newThread)
                            DispatchQueue.main.async {
                                _ = IndexPath(row: self.message.count - 1, section: 0)
                                self.tableView.reloadData()
                                //                                                                self.messages = []
                                //                                self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
                            }
                        }
                    }
                }
            }
        }
    }
    
}






extension Tab1ViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return message.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let messages = message[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! MessageViewCell
        cell.likeButton.alpha = 1.0
        cell.likeButton.setTitle("like", for: UIControl.State.normal)
        cell.laelMessage.text = messages.message
        cell.likesLabel.text = String(messages.likes)+" likes"
        for person in messages.likedpeople{
            if person == Auth.auth().currentUser?.uid
            {
                cell.likeButton.alpha = 1.0
                cell.likeButton.setTitle("liked", for: UIControl.State.normal)
                break
            }
            else
            {
                cell.likeButton.alpha = 0.65
                cell.likeButton.setTitle("like", for: UIControl.State.normal)
            }
        }
        cell.onClickCallback = {
            print("Buttonclicked")
            //            cell.likeButton.isEnabled = false
            let ref = self.db.collection("Confession").document(messages.postid)
            ref.addSnapshotListener { (snapshot, error) in
                if error != nil{
                    print(error ?? "error")
                }
                else{
                    ref.addSnapshotListener(includeMetadataChanges: false) { (documentSnapshot, err) in
                        if err != nil{
                            print(err ?? "error")
                        }
                        else{
                            if let post = documentSnapshot?.data() as [String: AnyObject]?{
                                let id = Auth.auth().currentUser?.uid
                                ref.updateData([
                                    "likedPeople": FieldValue.arrayUnion([id!])
                                ])
                            }
                            if let post = documentSnapshot?.data() as [String: AnyObject]?{
                                let likescount = post["likedPeople"]?.count
                                ref.updateData(["likes": likescount!]) { (err) in
                                    if err != nil{
                                        print(err ?? "error")
                                    }
                                    else{
                                        cell.likeButton.alpha = 1.0
                                        cell.likeButton.setTitle("liked", for: UIControl.State.normal)
                                        
                                    }
                                }
                            }
                            
                        }
                    }
                }
            }
            
        }
        
        
        return cell
        
    }
}


