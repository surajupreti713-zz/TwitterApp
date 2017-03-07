//
//  TweetDetailViewCell.swift
//  TwitterApp
//
//  Created by Suraj Upreti on 3/5/17.
//  Copyright © 2017 Suraj Upreti. All rights reserved.
//

import UIKit

class ProfileTimelineCell: UITableViewCell {
    
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var TextLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var favoriteLabel: UILabel!
    
    var tweet: Tweet!{
        didSet{
            nameLabel.text = tweet.name
            ImageView.setImageWith(tweet.imageUrl as URL!)
            usernameLabel.text = "@"+tweet.username
            TextLabel.text = tweet.text as String?
            if let timestamp = tweet.timestamp {
                timeLabel.text = TwitterClient.timeElapsed(timestamp: timestamp as Date)
            }
            //retweetLabel.text = String(tweet.retweetCount)
            //favoriteLabel.text = String(tweet.favoritesCount)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
