//
//  TipsdropDetailViewController.swift
//  tipsntrips
//
//  Created by Billy Chen on 6/16/16.
//  Copyright © 2016 iTech Ultimate. All rights reserved.
//

import UIKit
import Spring

class TipsdropDetailViewController: UIViewController {

    @IBOutlet weak var authorImageView: DesignableImageView!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var coverImgView: UIImageView!
    
    @IBOutlet weak var tipsdropTitle: UILabel!
    @IBOutlet weak var tipsdropContent: UITextView!
    
    @IBOutlet weak var commentCounter: UILabel!
    @IBOutlet weak var likeCounter: UILabel!
    
    var TDTitle: String = ""
    var content:String = ""
    var coverImg:UIImageView = UIImageView()
    
    var authorName:String = ""
    var authorImg: UIImageView = UIImageView()
    
    var commentCount:Int = 0
    var likeCount:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Navigation Bar Settings
        let logo = UIImage(named: "Logo.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView

        
        self.tipsdropTitle.text = TDTitle
        self.tipsdropContent.text = content
        self.coverImgView.image = coverImg.image
        
        self.authorImageView.image = authorImg.image
        self.authorNameLabel.text = authorName
        
        self.commentCounter.text = String(commentCount)
        self.likeCounter.text = String(likeCount)
        
        
        initProfileImage()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func initProfileImage()
    {
        self.authorImageView.cornerRadius = self.authorImageView.frame.size.height / 2
        self.authorImageView.clipsToBounds = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
