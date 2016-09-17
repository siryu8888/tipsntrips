//
//  TabMenuCollectionViewCell.swift
//  Tips n Trips
//
//  Created by Billy Chen on 2/25/16.
//  Copyright © 2016 iTech Ultimate. All rights reserved.
//

import UIKit

class TabMenuCollectionViewCell: UICollectionViewCell {


    let tripsLogKey = "com.itechultimate.tipsntrips.tripslogkey"
    let tripsSpotKey = "com.itechultimate.tipsntrips.tripsspotkey"
    let tipsDropKey = "com.itechultimate.tipsntrips.tipsdropkey"
    let gridMode = "com.itechultimate.tipsntrips.gridMode"
    let stackMode = "com.itechultimate.tipsntrips.stackMode"
    
    @IBOutlet weak var gridModeBtn: UIButton!
    @IBOutlet weak var stackModeBtn: UIButton!
    
    @IBOutlet weak var tripsLogBtn: UIButton!
    @IBOutlet weak var tripSpotBtn: UIButton!
    @IBOutlet weak var tipsDropBtn: UIButton!
    
    @IBAction func tipsDropClicked(_ sender: AnyObject) {
        gridModeBtn.isHidden = true
        gridModeBtn.setImage(UIImage(named: "gridIcon"), for: UIControlState())
        stackModeBtn.setImage(UIImage(named: "stackIconSelected"), for: UIControlState())
        tripsLogBtn.tintColor = UIColor.gray
        tripSpotBtn.tintColor = UIColor.gray
        tipsDropBtn.tintColor = UIColor.black
        NotificationCenter.default.post(name: Notification.Name(rawValue: tipsDropKey), object: nil)

    }
    
    @IBAction func tripSpotClicked(_ sender: AnyObject) {
        gridModeBtn.isHidden = false
        tripsLogBtn.tintColor = UIColor.gray
        tripSpotBtn.tintColor = UIColor.black
        tipsDropBtn.tintColor = UIColor.gray
        NotificationCenter.default.post(name: Notification.Name(rawValue: tripsSpotKey), object: nil)
    }
    
    @IBAction func tripsLogClicked(_ sender: AnyObject) {
        gridModeBtn.isHidden = false
        tripsLogBtn.tintColor = UIColor.black
        tripSpotBtn.tintColor = UIColor.gray
        tipsDropBtn.tintColor = UIColor.gray
        NotificationCenter.default.post(name: Notification.Name(rawValue: tripsLogKey), object: nil)
    }
    
    @IBAction func gridMode(_ sender: AnyObject) {
        gridModeBtn.setImage(UIImage(named: "gridIconSelected"), for: UIControlState())
        stackModeBtn.setImage(UIImage(named: "stackIcon"), for: UIControlState())
        NotificationCenter.default.post(name: Notification.Name(rawValue: gridMode), object: nil)
    }
    
    @IBAction func stackMode(_ sender: AnyObject) {
        gridModeBtn.setImage(UIImage(named: "gridIcon"), for: UIControlState())
        stackModeBtn.setImage(UIImage(named: "stackIconSelected"), for: UIControlState())
        NotificationCenter.default.post(name: Notification.Name(rawValue: stackMode), object: nil)
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
//        segmentedControl.selectedSegmentIndex = 0
        stackModeBtn.setImage(UIImage(named: "stackIconSelected"), for: UIControlState())
        tripsLogBtn.tintColor = UIColor.black
        tripSpotBtn.tintColor = UIColor.gray
        tipsDropBtn.tintColor = UIColor.gray

    }
    
}
