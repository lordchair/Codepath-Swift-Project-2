//
//  MovieCell.swift
//  spoiledKatchup
//
//  Created by Yale Thomas on 4/15/15.
//  Copyright (c) 2015 Yale Thomas. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    var peopleRating = 0
    var criticsRating = 0
    var criticBar: UIView!
    var peopleBar: UIView!
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    @IBOutlet weak var posterView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }


    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setWidths(criticScore: Int, peopleScore: Int) {
        if ((self.criticBar) != nil) {
            self.criticBar.removeFromSuperview()
            self.peopleBar.removeFromSuperview()
        }
        
        let peopleWidth = CGFloat(peopleScore) * (screenSize.width-47) / 100
        let criticWidth = CGFloat(criticScore) * (screenSize.width-47) / 100

        
        self.criticBar = UIView(frame: CGRectMake(47, 0, CGFloat(criticWidth), self.frame.height))
        self.criticBar.backgroundColor=UIColor.blueColor().colorWithAlphaComponent(0.04)
        self.addSubview(self.criticBar)
        self.peopleBar = UIView(frame: CGRectMake(47, 0, CGFloat(peopleWidth), self.frame.height))
        self.peopleBar.backgroundColor=UIColor.redColor().colorWithAlphaComponent(0.04)
        self.addSubview(self.peopleBar)
    }

}
