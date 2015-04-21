//
//  MovieDetailViewController.swift
//  spoiledKatchup
//
//  Created by Yale Thomas on 4/15/15.
//  Copyright (c) 2015 Yale Thomas. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    var posterURL: NSURL!
    var descriptionText: String!
    var titleText: String!
    var criticRating = 0
    var peopleRating = 0
    var rowHeight:CGFloat = 800
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

        self.title = titleText
        posterImage.setImageWithURL(posterURL)
        


        // Do any additional setup after loading the view.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("detail") as! DetailTableViewCell
        cell.fillObjects(titleText, descrip: descriptionText, criticScore: criticRating, peopleScore: peopleRating)
        cell.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.8)
        print(cell.descriptionText.bounds)
        self.rowHeight = cell.descriptionText.bounds.maxY + 10
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(self.rowHeight)
    }
    

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
