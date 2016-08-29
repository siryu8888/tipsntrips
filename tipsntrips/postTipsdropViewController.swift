//
//  postTipsdropViewController.swift
//  tipsntrips
//
//  Created by Billy Chen on 6/10/16.
//  Copyright © 2016 iTech Ultimate. All rights reserved.
//

import UIKit
import Alamofire
import Spring
import CZPicker

class postTipsdropViewController: UIViewController,AdobeUXImageEditorViewControllerDelegate ,
UIImagePickerControllerDelegate, UINavigationControllerDelegate,CZPickerViewDataSource, CZPickerViewDelegate  {

    let ClientSecret = Constants.sharedInstance.ADOBE_CLIENT_SECRET
    let ClientID = Constants.sharedInstance.ADOBE_CLIENT_ID
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var addCoverImgButton: UIButton!
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var contentTv: UITextView!
    @IBOutlet weak var titleTf: DesignableTextField!
    var img :UIImage = UIImage()
    var imgPicker = UIImagePickerController()
    
    var categoryName = ""
    var categoryActiveImgUrl = ""
    var categoryInactiveImgUrl=""

    override func viewDidLoad() {
        super.viewDidLoad()

        let logo = UIImage(named: "Logo.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView

        
        imgPicker.delegate = self
//        categoryLabel.text = Categories.sharedInstance.category[0].categoryName
//        categoryImage.image = Categories.sharedInstance.category[0].categoryImage.image
        self.navigationController?.showProgress()
        self.navigationController?.setPrimaryColor(UIColor.flatYellowColorDark())
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(postTipsdropViewController.imageTapped(_:)))
        coverImageView.userInteractionEnabled = true
        coverImageView.addGestureRecognizer(tapGestureRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelBtnClicked(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func postBtnClicked(sender: AnyObject) {
        
        if contentTv.text == ""{
            let alert = AlertManager.sharedInstance.alertOKOnly("Content Required", msg: "Please fill the content")
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else if titleTf.text == ""{
            let alert = AlertManager.sharedInstance.alertOKOnly("Title Required", msg: "Please fill the title")
            self.presentViewController(alert, animated: true, completion: nil)
        }else{
            retry(3, task: startUploading,
                  success: {
                    print("Succeeded")
                },
                  failure: { err in
                    print("Failed: \(err)")
            })
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func pickingCategory(sender: AnyObject) {
        let picker = CZPickerView(headerTitle: "Pick Category", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
        picker.headerBackgroundColor = UIColor.flatGrayColorDark()
        picker.confirmButtonBackgroundColor = UIColor.flatGrayColorDark()
        picker.delegate = self
        picker.dataSource = self
        picker.needFooterView = true
        picker.show()
    }
    func numberOfRowsInPickerView(pickerView: CZPickerView!) -> Int {
        return Categories.sharedInstance.category.count
    }
    
    func czpickerView(pickerView: CZPickerView!, imageForRow row: Int) -> UIImage! {
        
        let img = Categories.sharedInstance.category[row].categoryImage.image
        return img
    }
    
    func czpickerView(pickerView: CZPickerView!, titleForRow row: Int) -> String! {
        return Categories.sharedInstance.category[row].categoryName
    }
    
    func czpickerView(pickerView: CZPickerView!, didConfirmWithItemAtRow row: Int){
        categoryImage.image = Categories.sharedInstance.category[row].categoryImage.image
        categoryLabel.text = Categories.sharedInstance.category[row].categoryName
        self.categoryName = Categories.sharedInstance.category[row].categoryName
        self.categoryActiveImgUrl = Categories.sharedInstance.category[row].icon_active_url
        self.categoryInactiveImgUrl = Categories.sharedInstance.category[row].icon_inactive_url
    }

    func imageTapped(img: AnyObject)
    {
        let alert = UIAlertController(title: "Please choose source", message: nil, preferredStyle:
            .ActionSheet) // Can also set to .Alert if you prefer
        
        let cameraAction = UIAlertAction(title: "Camera", style: .Default) { (action) -> Void in
            self.showPhotoPicker(.Camera)
        }
        
        alert.addAction(cameraAction)
        let libraryAction = UIAlertAction(title: "Library", style: .Default) { (action) -> Void in
            self.showPhotoPicker(.PhotoLibrary)
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: {
            (alertAction: UIAlertAction!) in
            alert.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        alert.addAction(libraryAction)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            img = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
        photoEditorShow()
    }
    
    
    func showPhotoPicker(source: UIImagePickerControllerSourceType) {
        imgPicker.sourceType = source
        presentViewController(imgPicker, animated: true, completion: nil )
    }
    
    
    func photoEditorShow()
    {
        AdobeUXAuthManager.sharedManager().setAuthenticationParametersWithClientID(ClientID, clientSecret: ClientSecret, enableSignUp: false)
        
        //        AdobeImageEditorCustomization.setToolOrder([kAdobeImageEditorCrop])
        
        let editorController = AdobeUXImageEditorViewController.init(image: self.img)
        
        editorController.delegate = self
        self.presentViewController(editorController, animated: true,completion: nil)
        
    }
    
    func photoEditor(editor: AdobeUXImageEditorViewController, finishedWithImage image: UIImage?) {
        coverImageView.image = image
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func photoEditorCanceled(editor: AdobeUXImageEditorViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    
    func startUploading(success: Void -> Void, failure: ErrorType -> Void) {
        let image = coverImageView.image
        let timestamp: String = "\(NSDate().timeIntervalSince1970 * 1000)"

        // Begin upload
        Alamofire.upload(.POST,
                         "http://tipsntrip.16mb.com/index.php/Welcome/tipsdrop_upload_image",
                         // define your headers here
            //            headers: ["Authorization": "auth_token"],
            multipartFormData: { multipartFormData in
                // import image to request
                if let imageData = UIImageJPEGRepresentation(image!, 1) {
                    multipartFormData.appendBodyPart(data: imageData, name: "file", fileName: "\(timestamp).jpg", mimeType: "image/jpeg")
                }
            }, // you can customise Threshold if you wish. This is the alamofire's default value
            encodingMemoryThreshold: Manager.MultipartFormDataEncodingMemoryThreshold,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .Success(let upload, _, _):
                    upload.responseJSON { response in
                        self.navigationController?.finishProgress()
                        
                        if let photo = response.result.value{
                            
                            let params = [
                                "title": "\(self.titleTf.text!)",
                                "content":"\(self.contentTv.text!)",
                                "cover_photo_url":  "\(photo)",
                                "like_counter" : "0",
                                "comment_counter":"0",
                                "category_name":"\(self.categoryName)",
                                "category_icon_active":"\(self.categoryActiveImgUrl)",
                                "category_icon_inactive":"\(self.categoryInactiveImgUrl)",
                                "timestamp":"\(timestamp)"
                            ]
                            
                            
                            let alertController = UIAlertController(title: "Upload Success", message: "TipsDrop Posted!", preferredStyle: .Alert)
                            let defaultAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) {
                                UIAlertAction in
                                let post = DataService.sharedInstance.getMyTipsdropRef().child(UserProfile.sharedInstance.uid).childByAutoId()
                                post.updateChildValues(params)
                                print("Key = \(post.key)")
                                DataService.sharedInstance.getUserRef().child(UserProfile.sharedInstance.uid).child("mytipsdrop").updateChildValues(["\(post.key)":"true"])
                                self.dismissViewControllerAnimated(true, completion: nil)
                            }
                            alertController.addAction(defaultAction)
                            self.presentViewController(alertController, animated: true, completion: nil)
                        }
                    }
                    upload.progress { _, totalBytesRead, totalBytesExpectedToRead in
                        let progress = Float(totalBytesRead)/Float(totalBytesExpectedToRead)
                        dispatch_async(dispatch_get_main_queue()) {
                            self.navigationController?.setProgress(CGFloat(progress), animated: true)
                        }
                    }
                case .Failure(let encodingError):
                    print(encodingError)
                    failure(encodingError)
                    self.navigationController?.cancelProgress()
                }
        })
        
        
    }
    
    func retry(numberOfTimes: Int, task: (success: Void -> Void, failure: ErrorType -> Void) -> Void, success: Void -> Void, failure: ErrorType -> Void) {
        task(success: success,
             failure: { error in
                // do we have retries left? if yes, call retry again
                // if not, report error
                if numberOfTimes > 1 {
                    self.retry(numberOfTimes - 1, task: task, success: success, failure: failure)
                    print("Retry = \(numberOfTimes)")
                } else {
                    failure(error)
                }
        })
    }
    
    
    
}
