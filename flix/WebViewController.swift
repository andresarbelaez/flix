//
//  WebViewController.swift
//  flix
//
//  Created by Andrés Arbeláez on 6/17/16.
//  Copyright © 2016 Andrés Arbeláez. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    var movieTitle: String!
    
    var movieURL: NSURL!
    
    
    @IBOutlet weak var websiteView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        

        let requestObj = NSURLRequest(URL: movieURL);
        websiteView.loadRequest(requestObj);
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
