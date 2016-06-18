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
    
    var filteredMovies: [NSDictionary]?
    
    
    var endpoint: String!
    

    
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
        
        
        
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        
        
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        
        
        let url = NSURL(string: "https://api.themoviedb.org/3/movie/\(endpoint)?api_key=\(apiKey)")
        
        
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
                
                    self.movies = responseDictionary["results"] as? [NSDictionary]
                    self.filteredMovies = self.movies
                    self.tableView.reloadData()
                }
            }
    
    
        })
        
        task.resume()
        
        
    }
    
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string: "https://api.themoviedb.org/3/movie/\(endpoint)?api_key=\(apiKey)")
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
                                                                                
                self.movies = responseDictionary["results"] as? [NSDictionary]
                self.tableView.reloadData()
                refreshControl.endRefreshing()
            }
        }
            
                                                                        
                                                                        
        })
        task.resume()
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        
        if let filteredMovies = filteredMovies{
            return filteredMovies.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath) as! MovieCell
        
        let filteredMovie = filteredMovies![indexPath.row]
        
        let title = filteredMovie["title"] as! String
        
        let rating = filteredMovie["vote_average"] as! Double
        
        let baseUrl = "http://image.tmdb.org/t/p/w500"
        
        let posterPath = filteredMovie["poster_path"] as! String
        
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
                    cell.titleLabel.alpha = 0.0
                    UIView.animateWithDuration(0.5, animations: { () -> Void in
                        cell.posterView.alpha = 1.0
                        cell.titleLabel.alpha = 1.0
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
        
        
        
        cell.ratingLabel.text = "\(rating)"
        
        
        cell.ratingView.layer.cornerRadius = 0
        
        
        let backgroundGreenColor = UIColor(red: 0.3137, green: 0.7882, blue: 0.4392, alpha: 1) //#50c970
        
        let backgroundRedColor = UIColor(red: 0.9098, green: 0.3804, blue: 0.3608, alpha: 1)//#e8615c
    
        
        let backgroundYellowColor = UIColor(red: 0.949, green: 0.9098, blue: 0.3765, alpha: 1)//#f2e860
        
        
        let backgroundView = UIView()
        
        if rating > 6 {
            cell.ratingView.backgroundColor = backgroundGreenColor
            backgroundView.backgroundColor = backgroundGreenColor
            cell.selectedBackgroundView = backgroundView
        } else if rating > 5 {
            cell.ratingView.backgroundColor = backgroundYellowColor
            backgroundView.backgroundColor = backgroundYellowColor
            cell.selectedBackgroundView = backgroundView
        } else {
            cell.ratingView.backgroundColor = backgroundRedColor
            backgroundView.backgroundColor = backgroundRedColor
            cell.selectedBackgroundView = backgroundView
        }
        return cell
    }
    
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        if searchText.isEmpty {
            filteredMovies = movies
        } else {
            filteredMovies = movies!.filter({(dataItem: NSDictionary) -> Bool in
                // If dataItem matches the searchText, return true to include it
                
                let title = dataItem["title"] as! String
                
                if title.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil {
                    return true
                } else {
                    return false
                }
            })
        }
        tableView.reloadData()
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!){
        
        
        let detailViewController = segue.destinationViewController as! DetailViewController
        
        let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
        
        
        let filteredMovie = movies![indexPath!.row]
        
        detailViewController.movie = filteredMovie
        
        let baseUrl = "http://image.tmdb.org/t/p/w500"
        
        let posterPath = filteredMovie["poster_path"] as! String
        
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
