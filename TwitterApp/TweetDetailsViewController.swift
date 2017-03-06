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
    
    //weak var delegate: TweetDetailsViewControllerDelegate?
    var tweet: Tweet?
    
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
        
    }
    
    
    @IBAction func favorite(_ sender: Any) {
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}
