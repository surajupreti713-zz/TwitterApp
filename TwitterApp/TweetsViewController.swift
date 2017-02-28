//
//  TweetsViewController.swift
//  TwitterApp
//
//  Created by Suraj Upreti on 2/28/17.
//  Copyright © 2017 Suraj Upreti. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController {

    var tweets: [Tweet]!
    var count = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TwitterClient.sharedInstance?.homeTimeLine(success: { (tweets: [Tweet]) -> () in
            self.tweets = tweets
            for tweet in tweets{
                print(tweet.text)
                //self.tableView.reloadData()
            }
        }, failure: { (error: NSError) in
            print(error.localizedDescription)
        })
    }

    @IBAction func onLogoutButton(_ sender: Any) {
        TwitterClient.sharedInstance?.logout()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
