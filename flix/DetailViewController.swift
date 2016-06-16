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
    
    
    var imageURL: NSURL!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoImage.setImageWithURL(imageURL)
        
        navigationItem.title = "Details"
        
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: infoView.frame.origin.y + infoView.frame.size.height)
        
        let title = movie["title"] as! String
        
        titleLabel.text = title
        
        titleLabel.sizeToFit()
        
        let overview = movie["overview"] as! String
        
        overviewLabel.text = overview
        
        overviewLabel.sizeToFit()
        
        let releaseDate = movie["release_date"] as! String
        releaseLabel.text = releaseDate

        // Do any additional setup after loading the view.
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
