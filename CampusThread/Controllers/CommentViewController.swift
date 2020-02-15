//
//  CommentViewController.swift
//  CampusThread
//
//  Created by Lalith on 30/01/20.
//  Copyright © 2020 NANI. All rights reserved.
//

import UIKit

class CommentViewController: UIViewController,UITextFieldDelegate {
    
    
    @IBOutlet weak var commentTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        commentTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendButtonPressed(_ sender: UIButton) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
