//
//  ViewController.swift
//  weLearnOAuth
//
//  Created by Karen Fuentes on 2/28/17.
//  Copyright © 2017 Karen Fuentes. All rights reserved.
//

import UIKit
import AppAuth
import GTMAppAuth
import GTMSessionFetcher

class ViewController: UIViewController /*OIDAuthStateChangeDelegate, OIDAuthStateErrorDelegate*/{
    
    let KIssuer = "https://accounts.google.com"
    let KClientID = "604789679531-8h7t8auhndvjqqu00kalmuouefgmsc4g.apps.googleusercontent.com"
    let KRedirectURI = "com.googleusercontent.apps.604789679531-8h7t8auhndvjqqu00kalmuouefgmsc4g:/oauthredirect"
    let KExampleAuthorizerKey = "authorization"
    var authorization = GTMAppAuthFetcherAuthorization()
    
    


    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    func saveState() {
        if authorization.canAuthorize() {
            GTMAppAuthFetcherAuthorization.save(authorization, toKeychainForName: KExampleAuthorizerKey)
        }
        else {
            GTMAppAuthFetcherAuthorization.removeFromKeychain(forName: KExampleAuthorizerKey)
        }
    }

    func loadState(){
    authorization = GTMAppAuthFetcherAuthorization(fromKeychainForName: KExampleAuthorizerKey)!
        self.setGtmAuthorization(of: authorization)
        
    }
    
    func setGtmAuthorization(of auth: GTMAppAuthFetcherAuthorization) {
        if auth == authorization {
            return
        }
//        authorization = auth {
//            //
//        }
    }
    
    func updateUI (){
    
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

