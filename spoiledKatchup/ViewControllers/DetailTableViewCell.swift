//
//  DetailTableViewCell.swift
//  spoiledKatchup
//
//  Created by Yale Thomas on 4/20/15.
//  Copyright (c) 2015 Yale Thomas. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var peopleLabel: UILabel!
    @IBOutlet weak var criticsLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillObjects(title: String, descrip: String, criticScore: Int, peopleScore: Int) {
        
        titleLabel.text = title
        descriptionText.text = descrip
        descriptionText.textColor = UIColor.whiteColor()
        
        criticsLabel.text = "Critics: " + String(criticScore) + "%"
        peopleLabel.text = "People: " + String(peopleScore) + "%"
        
        
    }

}
