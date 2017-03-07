//
//  CreateTweetViewController.swift
//  TwitterApp
//
//  Created by Suraj Upreti on 3/7/17.
//  Copyright © 2017 Suraj Upreti. All rights reserved.
//

import UIKit

class CreateTweetViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var screenNameLabel: UILabel!
    
    @IBOutlet weak var charsLeftLabel: UILabel!
    
    @IBOutlet weak var composeTextView: UITextView!
    
    @IBOutlet weak var profileImageView: UIImageView! {
        didSet {
            self.profileImageView.layer.cornerRadius = 4
            self.profileImageView.clipsToBounds = true
            self.profileImageView.isUserInteractionEnabled = true
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.composeTextView.delegate = self
        self.updateCharacterCount()
        
        self.composeTextView.becomeFirstResponder()
        self.profileImageView.setImageWith((User.currentUser?.profileUrl!)! as URL)
        self.nameLabel.text = User.currentUser?.name as String?
        self.screenNameLabel.text = User.currentUser?.screenname as String?

    }
    
    @IBAction func tweet(_ sender: Any) {
        if let text = self.composeTextView.text {
            TwitterClient.sharedInstance?.createTweet(text: text, callBack: { (tweet, error) in
                DispatchQueue.main.async {
                    self.view.endEditing(true)
                    self.dismiss(animated: true, completion: nil)
                }
            })
        }
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func updateCharacterCount() {
        self.charsLeftLabel.text = "\(Int(140-(self.composeTextView.text?.characters.count)!))"
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.updateCharacterCount()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
