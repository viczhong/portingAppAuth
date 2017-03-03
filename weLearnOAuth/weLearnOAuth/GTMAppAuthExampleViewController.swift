//
//  GTMAppAuthExampleViewController.swift
//  weLearnOAuth
//
//  Created by Karen Fuentes on 2/28/17.
//  Copyright © 2017 Karen Fuentes. All rights reserved.
//

import UIKit
import GTMAppAuth
import GTMSessionFetcher
import AppAuth

class GTMAppAuthExampleViewController: UIViewController{
   @IBOutlet weak var authAutoButton: UIButton!
    @IBOutlet weak var userInfoButton: UIButton!
    @IBOutlet weak var clearAuthStateButton: UIButton!
    @IBOutlet weak var logTextView: UITextView!
    
    let KIssuer = "https://accounts.google.com"
    let KClientID = "604789679531-8h7t8auhndvjqqu00kalmuouefgmsc4g.apps.googleusercontent.com"
    let KRedirectURI = "com.googleusercontent.apps.604789679531-8h7t8auhndvjqqu00kalmuouefgmsc4g:/oauthredirect"
    let KExampleAuthorizerKey = "authorization"
  
    
    var authorization = GTMAppAuthFetcherAuthorization()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func authWithAutoCodeExchange(_sender: UIButton) {
        
    }
    
    @IBAction func userInfo(_sender: UIButton) {
        
    }
    
    @IBAction func clearAuthState(_sender: UIButton) {
        
    }
    
    
    @IBAction func clearLog(_sender: UIButton) {
        
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
    
    func setGtmAuthorization(of auth: GTMAppAuthFetcherAuthorization?) {
        if auth == authorization {
            return
        }
      authorization = auth!
       // self.stateChanged ()
    }
    
    func updateUI() {
       userInfoButton.isEnabled = authorization.canAuthorize()
       clearAuthStateButton.isEnabled = authorization.canAuthorize()
        if !authorization.canAuthorize() {
            authAutoButton.setTitle("Authorize", for: .normal)
            authAutoButton.setTitle("Authorize", for: .highlighted)
        }
        else {
            authAutoButton.setTitle("Re-authorize", for: .normal)
            authAutoButton.setTitle("Re-authorize", for: .highlighted)
        }
        
    }
    
    func stateChanged() {
        self.saveState()
        self.updateUI()
    }
    

    func didChangeState(state: OIDAuthState) {
        self.stateChanged()
    }
    
    func authState(state: OIDAuthState, error: Error) {
        self.logTextView.text = ("Received authorization error:, \(error)")
    }
    @IBAction func authWithAutoCodeExchange(sender: UIButton) {
       let issuer = URL(string: KIssuer)!
       let redirectURI = URL(string: KRedirectURI)
        self.logTextView.text = "fetching congfiguration for issuer \(issuer)"
      OIDAuthorizationService.discoverConfiguration(forIssuer: issuer) { (configuration, error) in
        if configuration == nil {
            self.logTextView.text = "error retrieving discovery document,\(error?.localizedDescription)"
           self.setGtmAuthorization(of: nil)
        }
        self.logTextView.text = "Got configuration \(configuration)"
        
        let request = OIDAuthorizationRequest.init(configuration: configuration!, clientId: self.KClientID, scopes: [OIDScopeOpenID, OIDScopeProfile], redirectURL: redirectURI!, responseType: OIDResponseTypeCode, additionalParameters: nil)
        //let appdelegate =

        
        }
      
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
