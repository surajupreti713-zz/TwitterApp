//
//  TweetDetailsViewController.swift
//  TwitterApp
//
//  Created by Suraj Upreti on 3/5/17.
//  Copyright © 2017 Suraj Upreti. All rights reserved.
//

import UIKit

//protocol TweetDetailsViewControllerDelegate: class {
//    func backToHome()
//    func replyTheTweet()
//}

class TweetDetailsViewController: UIViewController {
    
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var TextLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var favoriteLabel: UILabel!
    
    @IBOutlet weak var retweetOutlet: UIButton!
    
    @IBOutlet weak var favoriteOutlet: UIButton!
    
    //weak var delegate: TweetDetailsViewControllerDelegate?
    var tweet: Tweet?
    var coun = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hello there")
        nameLabel.text = tweet?.name
        ImageView.setImageWith(tweet?.imageUrl as URL!)
        usernameLabel.text = "@"+(tweet?.username)!
        TextLabel.text = tweet?.text as String?
        retweetLabel.text = "\(tweet!.retweetCount)"
        favoriteLabel.text = "\(tweet!.favoritesCount)"
    }
    
    @IBAction func reply(_ sender: Any) {
        
    }
    
    @IBAction func retweet(_ sender: Any) {
        if (tweet?.retweet!)! {
            TwitterClient.sharedInstance?.unretweet(tweet: tweet!, success: { (tweet: Tweet) -> () in
                TwitterClient.sharedInstance?.homeTimeLine(count: self.coun, success: { (tweets: [Tweet]) -> () in
                    //self.tweets = tweets
                    //self.tableView.reloadData()
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
                    //self.tweets = tweets
                    //self.tableView.reloadData()
                }, failure: { (error: Error) -> () in
                    print(error.localizedDescription)
                })
                print("retweeted")
                self.retweetOutlet.setImage(UIImage(named: "retweet-icon-green"), for: .normal)
                self.retweetLabel.text = "\(tweet.retweetCount)"
            }, failure: { (error: Error) -> () in
                print(error.localizedDescription)
            })
        }
    }
    
    
    @IBAction func favorite(_ sender: Any) {
        if (tweet?.favorite!)! {
            TwitterClient.sharedInstance?.unfavorite(tweet: tweet!, success: { (tweet: Tweet) -> () in
                TwitterClient.sharedInstance?.homeTimeLine(count: self.coun, success: { (tweets: [Tweet]) -> () in
                    //self.tweets = tweets
                    //self.tableView.reloadData()
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
                    //self.tweets = tweets
                    //self.tableView.reloadData()
                }, failure: { (error: Error) -> () in
                    print(error.localizedDescription)
                })
                print("favorited")
                self.favoriteOutlet.setImage(UIImage(named: "favor-icon-1"), for: .normal)
                self.favoriteLabel.text = "\(tweet.favoritesCount)"
            }, failure: { (error: Error) -> () in
                print(error.localizedDescription)
            })
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "replySegue" {
            let tweetDetailsNC = segue.destination as? UINavigationController
            let tweetVC = tweetDetailsNC?.topViewController as? ReplyViewController
            tweetVC?.tweet = self.tweet
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}
