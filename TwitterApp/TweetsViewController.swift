//
//  TweetsViewController.swift
//  TwitterApp
//
//  Created by Suraj Upreti on 2/28/17.
//  Copyright © 2017 Suraj Upreti. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tweets: [Tweet]!
    var coun = 30
    
    var index = 0
    var user: User?
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        navigationItem.titleView?.backgroundColor = .blue
        
        TwitterClient.sharedInstance?.homeTimeLine(count: coun, success: { (tweets: [Tweet]) -> () in
            self.tweets = tweets
            for tweet in tweets{
                //print(tweet.text)
                self.tableView.reloadData()
            }
            //print(self.tweets[3].text)
        }, failure: { (error: NSError) in
            print(error.localizedDescription)
        })
        
        //working for the ProfileViewController
        TwitterClient.sharedInstance?.currentAccount(success: { (user: User) in
            self.user = user
        }, failure: { (error: NSError) in
            print(error.localizedDescription)
        })
    }
    
    
    @IBAction func onLogoutButton(_ sender: Any) {
        TwitterClient.sharedInstance?.logout()
    }
    
    @IBAction func retweet(_ sender: UIButton) {
        let buttonPosition:CGPoint = (sender as AnyObject).convert(CGPoint.zero, to: self.tableView)
        let indexPath = tableView.indexPathForRow(at: buttonPosition)
        let tweet = tweets?[(indexPath?.row)!]
        if (tweet?.retweet!)! {
            TwitterClient.sharedInstance?.unretweet(tweet: tweet!, success: { (tweet: Tweet) -> () in
                TwitterClient.sharedInstance?.homeTimeLine(count: self.coun, success: { (tweets: [Tweet]) -> () in
                    self.tweets = tweets
                    self.tableView.reloadData()
                }, failure: { (error: Error) -> () in
                    print(error.localizedDescription)
                })
                print("unretweeted")
            }, failure: { (error: Error) -> () in
                print(error.localizedDescription)
            })
        } else {
            TwitterClient.sharedInstance?.retweet(tweet: tweet!, success: { (tweet: Tweet) -> () in
                TwitterClient.sharedInstance?.homeTimeLine(count: self.coun, success: { (tweets: [Tweet]) -> () in
                    self.tweets = tweets
                    self.tableView.reloadData()
                }, failure: { (error: Error) -> () in
                    print(error.localizedDescription)
                })
                print("retweeted")
            }, failure: { (error: Error) -> () in
                print(error.localizedDescription)
            })
        }
    }
    
    @IBAction func favorite(_ sender: UIButton) {
        let buttonPosition:CGPoint = (sender as AnyObject).convert(CGPoint.zero, to: self.tableView)
        let indexPath = tableView.indexPathForRow(at: buttonPosition)
        let tweet = tweets?[(indexPath?.row)!]
        
        //let client = TwitterClient.sharedInstance
        
        if (tweet?.favorite!)! {
            TwitterClient.sharedInstance?.unfavorite(tweet: tweet!, success: { (tweet: Tweet) -> () in
                TwitterClient.sharedInstance?.homeTimeLine(count: self.coun, success: { (tweets: [Tweet]) -> () in
                    self.tweets = tweets
                    self.tableView.reloadData()
                }, failure: { (error: Error) -> () in
                    print(error.localizedDescription)
                })
                print("unfavorited")
            }, failure: { (error: Error) -> () in
                print(error.localizedDescription)
            })
        } else {
            TwitterClient.sharedInstance?.favorite(tweet: tweet!, success: { (tweet: Tweet) -> () in
                TwitterClient.sharedInstance?.homeTimeLine(count: self.coun, success: { (tweets: [Tweet]) -> () in
                    self.tweets = tweets
                    self.tableView.reloadData()
                }, failure: { (error: Error) -> () in
                    print(error.localizedDescription)
                })
                print("favorited")
            }, failure: { (error: Error) -> () in
                print(error.localizedDescription)
            })
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = tweets {
            return tweets.count
        } else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetViewCell
        cell.tweet = tweets?[indexPath.row]
        index = indexPath.row
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailsSegue" {
            let indexPath = tableView.indexPathForSelectedRow
            let index = indexPath?.row
            print(index)
            let viewController = segue.destination as! TweetDetailsViewController
            viewController.tweet = tweets![index!]
        }
        
        else if segue.identifier == "profileSegue" {
            let navigationController = segue.destination as! UINavigationController
            let viewcontroller = navigationController.topViewController as! ProfileViewController
            viewcontroller.user = self.user
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if self.tweets != nil {
            self.tableView.reloadData()
        }
    }
    
    func backToHome() {
        print("yes, I am back to home")
        dismiss(animated: true, completion: nil)
    }
    
    func replyTheTweet() {
        print("I will reply the tweet")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
