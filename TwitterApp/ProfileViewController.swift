//
//  ProfileViewController.swift
//  TwitterApp
//
//  Created by Suraj Upreti on 3/6/17.
//  Copyright © 2017 Suraj Upreti. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var profileImageLabel: UIImageView!
    @IBOutlet weak var backgoundImageLabel: UIImageView!
    @IBOutlet weak var navBar: UINavigationItem!
    
    @IBOutlet weak var statusesLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    
    @IBOutlet weak var retweetOutlet: UIButton!
    @IBOutlet weak var favoriteOutlet: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var coun = 30
    var user: User?
    
    var tweets: [Tweet]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        if user?.name == "Suraj Upreti" {
            navBar.title = "Profile"
        }
        else {
            navBar.title = user?.name as String?
        }
        nameLabel.text = user?.name as String?
        screenNameLabel.text = "@"+((user?.screenname)! as String)
        profileImageLabel.setImageWith((user?.profileUrl)! as URL)
        if (user?.backgroundImageURL) != nil {
            backgoundImageLabel.setImageWith((user?.backgroundImageURL)!)
        }
        statusesLabel.text = "\((user?.noOfStatuses)!)"
        followingLabel.text = "\((user?.following)!)"
        followersLabel.text = "\((user?.followers)!)"
        
        
        
        
        TwitterClient.sharedInstance?.timelineTweets(count: coun, success: { (tweets: [Tweet]) -> () in
            self.tweets = tweets
            for tweet in tweets{
                //print(tweet!.name,])
                self.tableView.reloadData()
            }
        }, failure: { (error: NSError) in
            print(error.localizedDescription)
        })
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "composeSegue" {
            print("composing tweet")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = tweets {
            return tweets.count
        } else {
            print("It is empty")
           return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath) as! ProfileTimelineCell
        cell.tweet = tweets?[indexPath.row]
        //index = indexPath.row
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
