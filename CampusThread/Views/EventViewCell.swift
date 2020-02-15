//
//  EventViewCell.swift
//  CampusThread
//
//  Created by Lalith on 06/02/20.
//  Copyright © 2020 NANI. All rights reserved.
//

import UIKit

class EventViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var eventNameLabel: UILabel!
    
    
    @IBOutlet weak var eventPosterImageView: UIImageView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
    }
}
