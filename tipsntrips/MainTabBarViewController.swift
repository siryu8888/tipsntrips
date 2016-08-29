//
//  MainTabBarViewController.swift
//  tipsntrips
//
//  Created by Billy Chen on 6/9/16.
//  Copyright © 2016 iTech Ultimate. All rights reserved.
//

import UIKit
import ReachabilitySwift
import Firebase
import DCPathButton

class MainTabBarViewController: UITabBarController , DCPathButtonDelegate{

    var reachability: Reachability?
    var dcPathButton:DCPathButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Navigation Bar Settings
        let logo = UIImage(named: "Logo.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        configureDCPathButton()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     * ===================
     * Check Connection
     * ===================
     **/
    override func viewWillAppear(animated: Bool) {
        do {
            reachability = try Reachability.reachabilityForInternetConnection()
        } catch {
            print("Unable to create Reachability")
            return
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MainTabBarViewController.reachabilityChanged(_:)),name: ReachabilityChangedNotification,object: reachability)
        do{
            try reachability?.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
    }
    
    func reachabilityChanged(note: NSNotification) {

        let reachability = note.object as! Reachability
        
        if reachability.isReachable() {
            if reachability.isReachableViaWiFi() {
                print("Reachable via WiFi")
            } else {
                print("Reachable via Cellular")
            }
            
//          Only Running on login phase
            if UserProfile.sharedInstance.uid == ""{
            
                let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .Alert)
                alert.view.tintColor = UIColor.blackColor()
                let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(10, 5, 50, 50)) as UIActivityIndicatorView
                loadingIndicator.hidesWhenStopped = true
                loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
                loadingIndicator.startAnimating();
                alert.view.addSubview(loadingIndicator)
                presentViewController(alert, animated: true, completion: nil)
            }
            
            DataService.sharedInstance.isLoggedIn({ (success, msg) in
                if(!success){
                    print(msg)
                    self.dismissViewControllerAnimated(true, completion: { 
                        self.performSegueWithIdentifier("loginModal", sender: self)
                    })
                }
                print("msg = \(msg)")
                self.dismissViewControllerAnimated(true, completion: nil)
                DataService.sharedInstance.initiateCategories()
                
            })
            
        } else {
            let alert = AlertManager.sharedInstance.alertOKOnly("No Internet Connection", msg: "Please check your internet connection")
            self.presentViewController(alert, animated: true, completion: nil)
            print("Network not reachable")
        }
    }
    
    
    /*
     * =====================
     * PATH BUTTON SETTINGS
     * =====================
     **/
    
    func configureDCPathButton() {        
        dcPathButton = DCPathButton(centerImage: UIImage(named: "centerpath-icon"), highlightedImage: UIImage(named: "centerpath-icon"))
        
        dcPathButton.delegate = self
        dcPathButton.dcButtonCenter = CGPointMake(self.view.bounds.width/2, self.view.bounds.height - 25.5)
        dcPathButton.allowSounds = true
        dcPathButton.allowCenterButtonRotation = true
        dcPathButton.bloomRadius = 90
        
        let itemButton_1 = DCPathItemButton(image: UIImage(named: "tripslog"), highlightedImage: UIImage(named: "tripslog-fade"), backgroundImage: UIImage(named: "chooser-moment-button"), backgroundHighlightedImage: UIImage(named: "chooser-moment-button-highlighted"))
        let itemButton_2 = DCPathItemButton(image: UIImage(named: "tripspot"), highlightedImage: UIImage(named: "tripspot-fade"), backgroundImage: UIImage(named: "chooser-moment-button"), backgroundHighlightedImage: UIImage(named: "chooser-moment-button-highlighted"))
        let itemButton_3 = DCPathItemButton(image: UIImage(named: "tipsdrop"), highlightedImage: UIImage(named: "tipsdrop-fade"), backgroundImage: UIImage(named: "chooser-moment-button"), backgroundHighlightedImage: UIImage(named: "chooser-moment-button-highlighted"))
        dcPathButton.addPathItems([itemButton_1, itemButton_2, itemButton_3, /*itemButton_4, itemButton_5*/])
        
        self.view.addSubview(dcPathButton)
        
    }
    func pathButton(dcPathButton: DCPathButton!, clickItemButtonAtIndex itemButtonIndex: UInt) {
        
        switch itemButtonIndex {
        case 0 :
            print("TripsLog Clicked")
            break
        case 1 :
            print("TripSpot Clicked")
            break
        default :
//            print("TipsDrop Clicked")
            performSegueWithIdentifier("postTipsdrop", sender: self)
        }
        
    }

}
