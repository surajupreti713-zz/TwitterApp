//
//  LoginViewController.swift
//  TwitterApp
//
//  Created by Suraj Upreti on 2/28/17.
//  Copyright © 2017 Suraj Upreti. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    @IBAction func onLoginButton(_ sender: Any) {
        TwitterClient.sharedInstance?.login(success: { () -> () in
            print("I've logged in!")
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
        }){ (error: NSError) -> () in
            print("Error:\(error.localizedDescription)")
        }
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
