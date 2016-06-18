//
//  DetailViewController.swift
//  flix
//
//  Created by Andrés Arbeláez on 6/16/16.
//  Copyright © 2016 Andrés Arbeláez. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var infoView: UIView!
    
    @IBOutlet weak var photoImage: UIImageView!
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var releaseLabel: UILabel!
    
    var movie: NSDictionary!
    
    @IBOutlet weak var fandangoButton: UIButton!
    
    var imageURL: NSURL!
    
    var movieTitle: String?
    
    var blurImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoImage.setImageWithURL(imageURL)
        
        navigationItem.title = "Details"
        
        fandangoButton.layer.cornerRadius = 10
        
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: infoView.frame.origin.y + infoView.frame.size.height)
        
        movieTitle = movie["title"] as! String
        
        titleLabel.text = movieTitle
        
        titleLabel.sizeToFit()
        
        let overview = movie["overview"] as! String
        
        overviewLabel.text = overview
        
        overviewLabel.sizeToFit()
        
        let releaseDate = movie["release_date"] as! String
        releaseLabel.text = releaseDate

        infoView.layer.cornerRadius = 20
        
        
        UIView.animateWithDuration(0.5, delay: 1.0, options: [], animations: {
            self.infoView.frame.origin.y -= 75
            }, completion: nil)
        
        
        UIView.animateWithDuration(0.5, delay: 1.7, options: [], animations: {
            self.infoView.frame.origin.y += 75
            }, completion: nil)
        

        

        
        photoImage.layer.cornerRadius = 20
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!){
        
        let webViewController = segue.destinationViewController as! WebViewController
        

        
        webViewController.movieURL = NSURL(string: "http://www.fandango.com/search?q=warcraft")!
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
