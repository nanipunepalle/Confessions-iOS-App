//
//  EventDetails1ViewController.swift
//  CampusThread
//
//  Created by Lalith on 04/02/20.
//  Copyright © 2020 NANI. All rights reserved.
//

import UIKit

class EventDetails1ViewController: UIViewController,UITableViewDataSource,UITextFieldDelegate,UIScrollViewDelegate,UITableViewDelegate{
    var eventTypes = [eventtypes]()
    
    var eventtype: [String] = []
    @IBOutlet weak var eventStartDateField: UITextField!
    @IBOutlet weak var eventDateEndField: UITextField!
    @IBOutlet weak var eventNameField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var eventTypeTableView: UITableView!
    @IBOutlet weak var eventRegFees: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventTypeTableView.dataSource = self
        eventTypeTableView.delegate = self
        eventStartDateField.delegate = self
        eventDateEndField.delegate = self
        eventStartDateField.tag = 2
        eventDateEndField.tag = 3
        let eventType1 = eventtypes(eventTypeName: "Technical", eventTypeSelected: false)
        let eventType2 = eventtypes(eventTypeName: "cultural", eventTypeSelected: false)
        let eventType3 = eventtypes(eventTypeName: "Management", eventTypeSelected: false)
        self.eventTypes.append(eventType1)
        eventTypes.append(eventType2)
        eventTypes.append(eventType3)
        eventTypes.append(eventType3)
        eventTypes.append(eventType3)
        eventTypes.append(eventType3)
        eventTypes.append(eventType3)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventTypes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let event = eventTypes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventTypeCell", for: indexPath)
        cell.textLabel?.text = event.eventTypeName
        cell.accessoryType = event.eventTypeSelected ? .checkmark : .none
        if event.eventTypeSelected{
            eventtype.append(event.eventTypeName)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        eventTypes[indexPath.row].eventTypeSelected = !eventTypes[indexPath.row].eventTypeSelected
        tableView.deselectRow(at: indexPath, animated: true)
        eventtype = []
        tableView.reloadData()
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        eventStartDateField.inputView = datePicker
        eventDateEndField.inputView = datePicker
        if textField.tag == 2{
            datePicker.addTarget(self, action: #selector(handleDatePicker1(sender:)), for: .valueChanged)
        }
        if textField.tag == 3{
             datePicker.addTarget(self, action: #selector(handleDatePicker2(sender:)), for: .valueChanged)
        }
    }
    
    @objc func handleDatePicker1(sender: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MMM/yyyy'T'HH:mm"
        eventStartDateField.text = dateFormatter.string(from: sender.date)
        print(eventStartDateField.text)
    }
    @objc func handleDatePicker2(sender: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MMM/yyyy'T'HH:mm"
        eventDateEndField.text = dateFormatter.string(from: sender.date)
        print(eventDateEndField.text)
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "EventDetails1To2", sender: self )
//        print(eventtype)
//        print(eventStartDateField.text)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondvc = segue.destination as! EventDetails2ViewController
        secondvc.eventName = eventNameField.text!
        secondvc.eventType = eventtype
        secondvc.eventStartDate = stringtodate(date: eventStartDateField.text!)
        secondvc.eventEndDate = stringtodate(date: eventDateEndField.text!)
        secondvc.regFees = eventRegFees.text
    }
    
    func stringtodate(date: String) -> Date {
        let dateFormatter = DateFormatter()
        print(date)
        //        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "dd/MMM/yyyy'T'HH:mm"
        let datefinal = dateFormatter.date(from:date)!
        return datefinal
    }
    
    

}


