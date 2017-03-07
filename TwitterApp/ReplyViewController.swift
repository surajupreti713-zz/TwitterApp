//
//  ReplyViewController.swift
//  TwitterApp
//
//  Created by Suraj Upreti on 3/7/17.
//  Copyright © 2017 Suraj Upreti. All rights reserved.
//

import UIKit

class ReplyViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var charsLeftLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView! {
        didSet {
            self.profileImageView.clipsToBounds = true
            self.profileImageView.layer.cornerRadius = 4.0
            self.profileImageView.isUserInteractionEnabled = true
        }
    }
    
    @IBOutlet weak var replyTextView: UITextView!
    
    var tweet: Tweet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.replyTextView.delegate = self
        self.updateCharacterCount()
        
        self.replyTextView.becomeFirstResponder()
        self.profileImageView.setImageWith((User.currentUser?.profileUrl!)! as URL)
        self.nameLabel.text = User.currentUser?.name as String?
        self.screenNameLabel.text = User.currentUser?.screenname as String?
        //self.replyTextView.text = "@" + (tweet?.user.screenname!)!
        
    }
    func updateCharacterCount() {
        self.charsLeftLabel.text = "\(Int(140-(self.replyTextView.text?.characters.count)!))"
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.updateCharacterCount()
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tweet(_ sender: Any) {
        print("replied")
        dismiss(animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
