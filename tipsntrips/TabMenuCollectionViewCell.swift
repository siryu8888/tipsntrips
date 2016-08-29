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
    
    @IBAction func tipsDropClicked(sender: AnyObject) {
        gridModeBtn.hidden = true
        gridModeBtn.setImage(UIImage(named: "gridIcon"), forState: .Normal)
        stackModeBtn.setImage(UIImage(named: "stackIconSelected"), forState: .Normal)
        tripsLogBtn.tintColor = UIColor.grayColor()
        tripSpotBtn.tintColor = UIColor.grayColor()
        tipsDropBtn.tintColor = UIColor.blackColor()
        NSNotificationCenter.defaultCenter().postNotificationName(tipsDropKey, object: nil)

    }
    
    @IBAction func tripSpotClicked(sender: AnyObject) {
        gridModeBtn.hidden = false
        tripsLogBtn.tintColor = UIColor.grayColor()
        tripSpotBtn.tintColor = UIColor.blackColor()
        tipsDropBtn.tintColor = UIColor.grayColor()
        NSNotificationCenter.defaultCenter().postNotificationName(tripsSpotKey, object: nil)
    }
    
    @IBAction func tripsLogClicked(sender: AnyObject) {
        gridModeBtn.hidden = false
        tripsLogBtn.tintColor = UIColor.blackColor()
        tripSpotBtn.tintColor = UIColor.grayColor()
        tipsDropBtn.tintColor = UIColor.grayColor()
        NSNotificationCenter.defaultCenter().postNotificationName(tripsLogKey, object: nil)
    }
    
    @IBAction func gridMode(sender: AnyObject) {
        gridModeBtn.setImage(UIImage(named: "gridIconSelected"), forState: .Normal)
        stackModeBtn.setImage(UIImage(named: "stackIcon"), forState: .Normal)
        NSNotificationCenter.defaultCenter().postNotificationName(gridMode, object: nil)
    }
    
    @IBAction func stackMode(sender: AnyObject) {
        gridModeBtn.setImage(UIImage(named: "gridIcon"), forState: .Normal)
        stackModeBtn.setImage(UIImage(named: "stackIconSelected"), forState: .Normal)
        NSNotificationCenter.defaultCenter().postNotificationName(stackMode, object: nil)
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
//        segmentedControl.selectedSegmentIndex = 0
        stackModeBtn.setImage(UIImage(named: "stackIconSelected"), forState: .Normal)
        tripsLogBtn.tintColor = UIColor.blackColor()
        tripSpotBtn.tintColor = UIColor.grayColor()
        tipsDropBtn.tintColor = UIColor.grayColor()

    }
    
}
