//
//  EventTabViewController.swift
//  CampusThread
//
//  Created by Lalith on 06/02/20.
//  Copyright © 2020 NANI. All rights reserved.
//

import UIKit
import Firebase
class EventTabViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var event = [events]()
    let db = Firestore.firestore()
    let storage = Storage.storage()


    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.register(UINib(nibName: "EventViewCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        
        loadevents()
        // Do any additional setup after loading the view.
    }
    func loadevents(){
        db.collection("EventDetails").order(by: "eventregisteredDate",descending: true).addSnapshotListener { (querySnapshot, error) in
            
            self.event = []
            if error != nil{
                print(error ?? "error")
            }
            else{
                if let snapshotDocuments = querySnapshot?.documents{
                    for doc in snapshotDocuments{
                        let data = doc.data()
                        if let eventName = data["eventName"] as? String,
                            let regLink = data["eventreglink"] as? String,
                            let docid = data["docid"] as? String{
                            let newEvent = events(eventName: eventName, eventLink: regLink, docid: docid)
                            self.event.append(newEvent)
                            DispatchQueue.main.async {
                                _ = IndexPath(row: self.event.count - 1, section: 0)
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return event.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let events = event[indexPath.row]
        let docid = events.docid
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! EventViewCell
//        cell = tableView.
        let finalImageRef = storage.reference().child("posters").child("\(docid).jpg")
        finalImageRef.getData(maxSize: 1 * 1024 * 1024) { (data, err) in
            if err != nil{
                print(err ?? "error")
            }
            else{
                cell.eventPosterImageView.image = UIImage(data: data!)
                print("image loaded successfully")
            }
        }
        
        cell.eventNameLabel.text = events.eventName
        return cell
    }

}
