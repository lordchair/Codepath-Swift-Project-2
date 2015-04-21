//
//  MoviesViewController.swift
//  spoiledKatchup
//
//  Created by Yale Thomas on 4/14/15.
//  Copyright (c) 2015 Yale Thomas. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableCell: MovieCell!
    @IBOutlet weak var errorView: UIView!
    var refreshControl: UIRefreshControl!
    var movies = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        errorView.hidden = true
        
        loadData()

        tableView.dataSource = self
        tableView.delegate = self

        
                // Do any additional setup after loading the view.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func loadData() {
        SVProgressHUD.show()
        let apiKey = "dagqdghwaq3e3mxyrp7kmmj5"
        let urlString = "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=" + apiKey + "&limit=50&country=US"
        print(urlString)
        let url = NSURL(string:urlString)
        let request = NSURLRequest(URL:url!)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{ (response, data, error) in
            var errorValue: NSError? = nil
            if (error == nil) {
                let dictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &errorValue) as! NSDictionary
                self.movies = dictionary["movies"] as! NSArray
                self.tableView.reloadData()
                SVProgressHUD.dismiss()
                self.errorView.hidden = true
                self.refreshControl.endRefreshing()
            } else {
                self.errorView.hidden = false
                self.refreshControl.endRefreshing()
                SVProgressHUD.dismiss()
            }

        })

    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("movieRow") as! MovieCell
        let myMovie = self.movies[indexPath.row] as! NSDictionary
        
        cell.titleLabel.text = myMovie.valueForKeyPath("title") as? String
        
        let criticsRating = myMovie.valueForKeyPath("ratings.critics_score") as! Int
        let peopleRating = myMovie.valueForKeyPath("ratings.audience_score") as! Int
        cell.setWidths(criticsRating, peopleScore: peopleRating)
        
        let urlString = myMovie.valueForKeyPath("posters.thumbnail") as! String
        let url = NSURL(string: urlString)
        cell.posterView.setImageWithURL(url)
        
        return cell
    }
    
    func onRefresh() {
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        println(segue.destinationViewController)
        if segue.identifier == "toDetailPush" {
            
            let detailVC = segue.destinationViewController as! MovieDetailViewController
            let cell = sender as! MovieCell
            let indexPath = tableView.indexPathForCell(cell) as NSIndexPath!
            let myMovie = self.movies[indexPath.row] as! NSDictionary
            
            
            var urlString:String = myMovie.valueForKeyPath("posters.original") as! String
            var range = urlString.rangeOfString(".*cloudfront.net/", options:
                .RegularExpressionSearch)
            
            if let range = range {
                urlString = urlString.stringByReplacingCharactersInRange(range, withString:
                    "https://content6.flixster.com/")
            }
            let url = NSURL(string: urlString)
            
            detailVC.posterURL = url
            
            detailVC.criticRating = myMovie.valueForKeyPath("ratings.critics_score") as! Int
            detailVC.peopleRating = myMovie.valueForKeyPath("ratings.audience_score") as! Int
            
            detailVC.descriptionText = myMovie.valueForKeyPath("synopsis") as? String
            detailVC.titleText = myMovie.valueForKeyPath("title") as? String
            detailVC.title = detailVC.titleText
        }



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
