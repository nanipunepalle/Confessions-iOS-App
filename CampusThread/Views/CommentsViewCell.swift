//
//  CommentsViewCell.swift
//  CampusThread
//
//  Created by NANI on 30/01/20.
//  Copyright © 2020 NANI. All rights reserved.
//

import UIKit

class CommentsViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var commentContent: UILabel!
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
