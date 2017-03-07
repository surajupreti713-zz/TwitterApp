//
//  ProfileViewController.swift
//  TwitterApp
//
//  Created by Suraj Upreti on 3/6/17.
//  Copyright © 2017 Suraj Upreti. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var profileImageLabel: UIImageView!
    @IBOutlet weak var backgoundImageLabel: UIImageView!
    @IBOutlet weak var navBar: UINavigationItem!
    
    @IBOutlet weak var statusesLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
