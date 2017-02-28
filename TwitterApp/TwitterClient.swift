//
//  TwitterClient.swift
//  TwitterApp
//
//  Created by Suraj Upreti on 2/28/17.
//  Copyright © 2017 Suraj Upreti. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com")! as URL!, consumerKey: "ZaVMaIwP0L2NHNuukpuGCK27j", consumerSecret: "147HztnlTzfvXffsVx35TqR2FVWVMlxC6CoMem2hL7fIIHdMCP")
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((NSError) -> ())?
    
    
    func currentAccount(success: @escaping (User) -> (), failure: @escaping (NSError) -> ()) {
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            //print("account: \(response)")
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
            
            success(user)
            
            print("name: \(user.name)")
            print("screenname: \(user.screenname)")
            print("profile url: \(user.profileUrl)")
            print("description: \(user.tagline)")
            
        }, failure: { (task: URLSessionDataTask?, error: Error) in    /////////////////////////
            failure(error as NSError)
        })
    }
    
    func login(success: @escaping () -> (), failure: @escaping (NSError) -> ()) {
        self.loginSuccess = success
        loginFailure = failure
        
        let twitterClient = TwitterClient.sharedInstance
        
        twitterClient?.deauthorize()
        
        twitterClient?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: NSURL(string: "mytwitterapp://oauth") as URL!, scope: nil, success: { (requestToken: BDBOAuth1Credential?) in
            //print("I got a token")
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken!.token!)")!
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }, failure: { (Error) in
            print("error: \(Error?.localizedDescription)")
            self.loginFailure?(Error as! NSError)
        })
    }
    
    func handleOpenUrl(url: NSURL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential?) in
            //print("I got the access token")
            
            self.currentAccount(success: { (user) in
                User.currentUser = user
                self.loginSuccess?()
            }, failure: { (error) in
                self.loginFailure?(error as! NSError)
            })
            
        }, failure: { (Error) in
            print("error: \(Error?.localizedDescription)")
            self.loginFailure?(Error as! NSError)
        })

    }
    
    func homeTimeLine(success: @escaping ([Tweet]) -> (), failure: @escaping (NSError) -> ()) {
        
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            let dictionaries = response as! [NSDictionary]
            
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
            success(tweets)
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            failure(error as NSError)
        })
    }
}
