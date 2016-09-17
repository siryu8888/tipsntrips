//
//  MyProfileCollectionViewController.swift
//  tipsntrips
//
//  Created by Billy Chen on 6/9/16.
//  Copyright © 2016 iTech Ultimate. All rights reserved.
//

import UIKit
import Firebase
import SwiftyJSON

private let reuseIdentifier = "Cell"

class MyProfileCollectionViewController: UICollectionViewController {

    let myProfile   = "myprofileCell"
    let tabCell = "tabcell"
    
    let freeCustomer = "freeCustCell"
    let priorityCustomer = "priorityCustCell"
    
    
    var layout = UICollectionViewFlowLayout()
    fileprivate let leftAndRightPaddings : CGFloat = 1.0
    fileprivate let numberOfItemsPerRow : CGFloat = 3.0
    fileprivate let heightAdjustment : CGFloat  = 30
    var width:CGFloat = 0
    var startingIndex:UInt = 0
    
    var choosenIndexPath = 0
    var tipsdropID :[String] = [String]()
    var tipsdropIdx = 0
    
    override func viewDidAppear(_ animated: Bool) {
        print("UID = \(UserProfile.sharedInstance.uid)")
        if UserProfile.sharedInstance.uid != "" {
            
            DataService.sharedInstance.getUserRef().child(UserProfile.sharedInstance.uid).observe(.value, with: { (snapshot) in
                if(snapshot.value is NSNull){
                    print("not found")
                }
                else{
                    if let allProfile = snapshot.value as? [String:AnyObject]{
                        UserProfile.sharedInstance.name  = allProfile["display_name"] as! String
                        UserProfile.sharedInstance.email = allProfile["email"] as? String
                        if(allProfile["login_provider"] as! String == "FACEBOOK"){
                            UserProfile.sharedInstance.setPhotoUrl(URL(string: (allProfile["photo_url"] as? String)!)!)
                            print(UserProfile.sharedInstance.photo_url)
                        }
                    }
                    self.collectionView?.reloadData()
                }
            }){ (error) in
                print(error.localizedDescription)
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Navigation Bar Settings
        let logo = UIImage(named: "Logo.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        width = ((self.view.frame.width) - leftAndRightPaddings) / numberOfItemsPerRow
        
        // Do any additional setup after loading the view.
        var nib = UINib(nibName: "ProfileCollectionViewCell", bundle: nil)
        self.collectionView?.register(nib, forCellWithReuseIdentifier: myProfile)
        nib = UINib(nibName: "TabMenuCollectionViewCell", bundle: nil)
        self.collectionView?.register(nib, forCellWithReuseIdentifier: tabCell)
        
//      Register Tipsdrop NIB
        nib = UINib(nibName: "TipsDropStackCollectionViewCell", bundle: nil)
        self.collectionView?.register(nib, forCellWithReuseIdentifier: freeCustomer)
        nib = UINib(nibName: "TipsDropPriorityCustomerCollectionViewCell", bundle: nil)
        self.collectionView?.register(nib, forCellWithReuseIdentifier: priorityCustomer)

        
        
        self.collectionView?.backgroundColor = UIColor.white
        layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
        
//        DataService.sharedInstance.getMyTipsdrop()
        
        
        //Register Listener
        registerListenerTipsdrop { (result) in
            self.tipsdropIdx = 0
            print("Result = \(result)")
            DispatchQueue.main.async {
                self.loadTipsdropDetail()
                
            }
            
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return TipsDrops.sharedInstance.tipsDrop.count+2
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (indexPath as NSIndexPath).row == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: myProfile , for: indexPath) as! ProfileCollectionViewCell
            cell.profileName.text = UserProfile.sharedInstance.name
            if UserProfile.sharedInstance.photo_url != nil{
                cell.profilePhoto.kf_setImageWithURL(UserProfile.sharedInstance.getPhotoUrl())
            }
            return cell
            
        }else if (indexPath as NSIndexPath).row == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tabCell , for: indexPath) as! TabMenuCollectionViewCell
            return cell
        }else{
            
           
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: freeCustomer, for: indexPath) as! TipsDropStackCollectionViewCell
            cell.picture.kf_setImageWithURL(TipsDrops.sharedInstance.tipsDrop[(indexPath as NSIndexPath).row-2].tipsDropImgUrl)
            cell.titleLabel.text = TipsDrops.sharedInstance.tipsDrop[(indexPath as NSIndexPath).row-2].tipsDropTitle
            cell.categoryIcon.kf_setImageWithURL(TipsDrops.sharedInstance.tipsDrop[(indexPath as NSIndexPath).row - 2 ].tipsDropCategoryImgUrl)
            cell.commentCount.text = String(TipsDrops.sharedInstance.tipsDrop[(indexPath as NSIndexPath).row - 2].tipsDropComment)
            cell.likeCount.text = String(TipsDrops.sharedInstance.tipsDrop[(indexPath as NSIndexPath).row - 2].tipsDropLike)
            if(TipsDrops.sharedInstance.tipsDrop.count == (indexPath as NSIndexPath).row - 2)
            {
                startingIndex = UInt((indexPath as NSIndexPath).row-2)
            }
            
            return cell

        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        if((indexPath as NSIndexPath).row == 0)
        {
            return CGSize(width: self.view.frame.width, height: 250)
        }
        else if((indexPath as NSIndexPath).row == 1)
        {
            return CGSize(width: self.view.frame.width, height: 45)
        }
        else{
//          Tipsdrop Cell
            return CGSize(width: self.view.frame.width, height: 90)
        }
        return CGSize(width: self.view.frame.width, height: 250)
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if((indexPath as NSIndexPath).row > 1){
            self.choosenIndexPath = (indexPath as NSIndexPath).row-2
            self.performSegue(withIdentifier: "tipsdropDetail", sender: self)
        }
        
    }
    
    func loadTipsdropDetail( _ startIdx:Int = 0 ){
        print("Counted ID = \(self.tipsdropID.count)")
        print("Tipsdrop IDX = \(self.tipsdropIdx)")
        var endIndex = startIdx
        if(self.tipsdropID.count != 0 && self.tipsdropID.count == (tipsdropIdx+1)){
            
            if UserProfile.sharedInstance.uid != ""{
                let query = DataService.sharedInstance.getMyTipsdropRef()
                .child(UserProfile.sharedInstance.uid)
                .queryOrderedByKey()
                
                .queryStarting(atValue: self.tipsdropID[startIdx])
                if(self.tipsdropID.count > 10){
                    print("Load 10")
                    endIndex += 10
                    query.queryEnding(atValue: self.tipsdropID[endIndex])
                }else{
                    print("Masuk Last 10")
                    endIndex = (tipsdropID.count - 1)
                    query.queryEnding(atValue: self.tipsdropID[endIndex])
                }
                

                
//                print("Start Value = \(self.tipsdropID[0])")
//                print("End Value = \(self.tipsdropID[2])")
                query.observeSingleEvent(of: .value, with: {(snapshot) in
                    if snapshot.value is NSNull{
                        print("Not Found")
                        
                    }
                    else{
                        print("Key = \(snapshot.key)")
//                        print("Value = \(snapshot.value)")
                      
                        
                        if let value = snapshot.value as? [String:AnyObject]{
                            
                            for i in startIdx...endIndex {
                                print("Value = \(value[self.tipsdropID[i]])")
                                let dict:TipsDrop = TipsDrop()
                                dict.tipsDropID = snapshot.key
                                dict.timestamp  = value[self.tipsdropID[i]]!["timestamp"] as! String
                                dict.tipsDropTitle = value[self.tipsdropID[i]]!["title"] as! String
                                dict.tipsDropCategoryName = value[self.tipsdropID[i]]!["category_name"] as! String
                                dict.tipsDropLike = Int(value[self.tipsdropID[i]]!["like_counter"] as! String)!
                                dict.tipsDropComment = Int(value[self.tipsdropID[i]]!["comment_counter"]as!String)!
                                dict.tipsDropContent = value[self.tipsdropID[i]]!["content"] as! String
                                dict.tipsDropImgUrl = URL(string:value[self.tipsdropID[i]]!["cover_photo_url"] as! String)!
                                dict.tipsDropAuthorUID = UserProfile.sharedInstance.uid
                                dict.tipsDropAuthorName = UserProfile.sharedInstance.name
                                dict.tipsDropAuthorImgUrl = UserProfile.sharedInstance.photo_url
                                
                                TipsDrops.sharedInstance.tipsDrop.append(dict)

                            }
//                          Sorting Descending by timestamp
                            TipsDrops.sharedInstance.tipsDrop.sort(by: {$0.timestamp > $1.timestamp})
                            self.collectionView?.reloadData()
                        }
                    }
                })
            }
        }
        
        self.tipsdropIdx += 1
        
        
    }
    
    func registerListenerTipsdrop(_ completion: @escaping (_ result: String) -> Void){
        
        if UserProfile.sharedInstance.uid != ""{
           
            let query = DataService.sharedInstance.getUserRef()
                .child(UserProfile.sharedInstance.uid)
                .child("mytipsdrop")
                .queryOrderedByKey()
            query.observe(.childAdded, with: {(snapshot) in
                if snapshot.value is NSNull{
                    print("Not Found")
                }else{
                    print("val = \(snapshot.key)")
                    self.tipsdropID.append(snapshot.key as String)
                    if let value = snapshot.value as? [String:AnyObject]{
                        print("val = \(value)")
                        self.tipsdropID.append(String(describing: value))

                    }
                }
                completion("Looping")
            })
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "tipsdropDetail"){
            let vc : TipsdropDetailViewController  = segue.destination as! TipsdropDetailViewController
            vc.authorName = TipsDrops.sharedInstance.tipsDrop[choosenIndexPath].tipsDropAuthorName!
            vc.authorImg.kf_setImageWithURL(TipsDrops.sharedInstance.tipsDrop[choosenIndexPath].tipsDropAuthorImgUrl!)
            
            vc.TDTitle = TipsDrops.sharedInstance.tipsDrop[choosenIndexPath].tipsDropTitle
            vc.coverImg.kf_setImageWithURL(TipsDrops.sharedInstance.tipsDrop[choosenIndexPath].tipsDropImgUrl)
            
            vc.commentCount = TipsDrops.sharedInstance.tipsDrop[choosenIndexPath].tipsDropComment
            vc.likeCount = TipsDrops.sharedInstance.tipsDrop[choosenIndexPath].tipsDropLike
            
        }
    }

}
