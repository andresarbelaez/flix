//
//  MoviesViewController.swift
//  flix
//
//  Created by Andrés Arbeláez on 6/15/16.
//  Copyright © 2016 Andrés Arbeláez. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD

class MoviesViewController: UIViewController , UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var introView: UIView!
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    
    var movies: [NSDictionary]?
    
    let data = ["New York, NY", "Los Angeles, CA", "Chicago, IL", "Houston, TX",
                "Philadelphia, PA", "Phoenix, AZ", "San Diego, CA", "San Antonio, TX",
                "Dallas, TX", "Detroit, MI", "San Jose, CA", "Indianapolis, IN",
                "Jacksonville, FL", "San Francisco, CA", "Columbus, OH", "Austin, TX",
                "Memphis, TN", "Baltimore, MD", "Charlotte, ND", "Fort Worth, TX"]
    
    var filteredData: [String]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.barStyle = UIBarStyle.Black
        searchBar.translucent = true
        
        
        navigationItem.title = "Flix"
        
        self.introView.alpha = 1
        
        UIView.animateWithDuration(5.0, animations: {
            self.introView.alpha = 0
            
            
        })
        
        
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        
        filteredData = data
        
        
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        
        
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        
        
        let url = NSURL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")
        
        
        let request = NSURLRequest(
            URL: url!,
            cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData,
            timeoutInterval: 10)
        
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate: nil,
            delegateQueue: NSOperationQueue.mainQueue()
        )
        
        
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(request,
completionHandler: { (dataOrNil, response, error) in
    
        MBProgressHUD.hideHUDForView(self.view, animated: true)
    
    if let data = dataOrNil {
            if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(data, options:[]) as? NSDictionary {
                print("response: \(responseDictionary)")
                
                    self.movies = responseDictionary["results"] as! [NSDictionary]
                    self.tableView.reloadData()
                }
            }
    
    
        })
        task.resume()
        
        
    }
    
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")
        let request = NSURLRequest(
            URL: url!,
            cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData,
            timeoutInterval: 10)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate: nil,
            delegateQueue: NSOperationQueue.mainQueue()
        )
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: { (dataOrNil, response, error) in
                                                                        
            MBProgressHUD.hideHUDForView(self.view, animated: true)
                                                                        
            if let data = dataOrNil {
            if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(data, options:[]) as? NSDictionary {
                print("response: \(responseDictionary)")
                                                                                
                self.movies = responseDictionary["results"] as! [NSDictionary]
                self.tableView.reloadData()
                refreshControl.endRefreshing()
            }
        }
            
                                                                        
                                                                        
        })
        task.resume()
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let movies = movies{
            return movies.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath) as! MovieCell
        
         let movie = movies![indexPath.row]
        
        let title = movie["title"] as! String
        
        let rating = movie["vote_average"] as! Double
        
        let overview = movie["overview"] as! String
        
        let baseUrl = "http://image.tmdb.org/t/p/w500"
        
        let posterPath = movie["poster_path"] as! String
        
        let imageUrl = NSURL(string: baseUrl + posterPath)
        
        let imageRequest = NSURLRequest(URL: imageUrl!)
        
        cell.posterView.setImageWithURLRequest(
            imageRequest,
            placeholderImage: nil,
            success: { (imageRequest, imageResponse, image) -> Void in
                
                // imageResponse will be nil if the image is cached
                if imageResponse != nil {
                    print("Image was NOT cached, fade in image")
                    cell.posterView.alpha = 0.0
                    cell.posterView.image = image
                    UIView.animateWithDuration(0.5, animations: { () -> Void in
                        cell.posterView.alpha = 1.0
                    })
                } else {
                    print("Image was cached so just update the image")
                    cell.posterView.image = image
                }
            },
            failure: { (imageRequest, imageResponse, error) -> Void in
                // do something for the failure condition
        })
        
        cell.titleLabel.text = title
        
        cell.overviewLabel.text = overview
        
        cell.ratingLabel.text = "\(rating)"
        
        
        cell.ratingView.layer.cornerRadius = 0
        
        
        let backgroundGreenColor = UIColor(red: 0.3137, green: 0.7882, blue: 0.4392, alpha: 1) //#50c970
        
        let backgroundRedColor = UIColor(red: 0.9098, green: 0.3804, blue: 0.3608, alpha: 1)//#e8615c
        
        if rating > 5 {
            cell.ratingView.backgroundColor = backgroundGreenColor
        } else {
            cell.ratingView.backgroundColor = backgroundRedColor
        }
        
        let backgroundView = UIView()
        
        backgroundView.backgroundColor = backgroundGreenColor
        cell.selectedBackgroundView = backgroundView
        
        
    
        return cell
    }
    
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        if searchText.isEmpty {
            filteredData = data
        } else {
            filteredData = data.filter({(dataItem: String) -> Bool in
                // If dataItem matches the searchText, return true to include it
                if dataItem.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil {
                    return true
                } else {
                    return false
                }
            })
        }
        tableView.reloadData()
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!){
        
        
        let detailViewController = segue.destinationViewController as! DetailViewController
        
        let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
        
        
        let movie = movies![indexPath!.row]
        
        detailViewController.movie = movie
        
        let baseUrl = "http://image.tmdb.org/t/p/w500"
        
        let posterPath = movie["poster_path"] as! String
        
        let imageUrl = NSURL(string: baseUrl + posterPath)
    
        detailViewController.imageURL = imageUrl
        
        
    
        
    }
    
    
    
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
