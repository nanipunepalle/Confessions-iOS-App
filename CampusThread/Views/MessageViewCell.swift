//
//  MessageViewCell.swift
//  CampusThread
//
//  Created by NANI on 25/01/20.
//  Copyright © 2020 NANI. All rights reserved.
//

import UIKit
import Firebase

class MessageViewCell: UITableViewCell {
    
    //    var onClickCallback: (() -> Void)?
    let db = Firestore.firestore()
    var message = [mainmessage]()
    
    var onClickCallback: (() -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ananumousLogo.layer.cornerRadius = ananumousLogo.frame.size.width/2
    }
    
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var laelMessage: UILabel!
    @IBOutlet weak var ananumousLogo: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func likeButtonPressed(_ sender: UIButton) {

        onClickCallback?()
    }
        
        
    }

