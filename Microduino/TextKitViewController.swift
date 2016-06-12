//
//  TextKitViewController.swift
//  TextkitTest
//
//  Created by Thierry on 16/4/7.
//  Copyright © 2016年 Thierry. All rights reserved.
//

import UIKit
import KMPlaceholderTextView
import Photos
import AliyunOSSiOS
import SwiftDDP
import Fusuma
let OSSBucketName = "microduino"
let OSSEndPoint = "http://oss.microduino.cn"
let OSSCredentialProvider = OSSPlainTextAKSKPairCredentialProvider(plainTextAccessKey: "yHDeIMBwWoa64rTK", secretKey: "jXAskPzYov46RL6ih914VHclALt7hV")
let client = OSSClient(endpoint: OSSEndPoint, credentialProvider: OSSCredentialProvider)


class TextKitViewController: UIViewController, UITextViewDelegate  {
    
    let naviBarHeight: CGFloat = 64.0
    let textViewInset: CGFloat = 10.0
    let toolbarHeight: CGFloat = 40.0
    let singleLineHeight: CGFloat = 40.0
    let lineBreakStr:String = "\n\n"
    
    let scrollView:UIScrollView = UIScrollView.init(frame: CGRectZero)
    let textStorage:NSTextStorage = NSTextStorage()
    let layoutManger: NSLayoutManager = NSLayoutManager()
    let fontArribuates = [NSFontAttributeName: UIFont.systemFontOfSize(16)]
    var titleTextView: KMPlaceholderTextView = KMPlaceholderTextView(frame: CGRectZero)
    var contentTextView: KMPlaceholderTextView = KMPlaceholderTextView(frame: CGRectZero)
    var container: NSTextContainer = NSTextContainer(size: CGSize.zero)
    var textContent: NSMutableAttributedString = NSMutableAttributedString()
    var currentRange: NSRange = NSRange.init(location: 0, length: 0)
    var scrollViewContentHeight: CGFloat = 0.0
    
    var articleTitle:String = ""
    var articleContent:String = ""
    
    
    // MARK: Life Cycle
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "新文章"
        self.edgesForExtendedLayout = UIRectEdge.None
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named:"nav_bg"), forBarMetrics: .Default)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor(rgba:"#AAFF18")]
        let cancelItem = UIBarButtonItem(title:"关闭",style:.Plain,target:self,action:#selector(cancelAction))
        cancelItem.tintColor = UIColor(rgba:"#AAFF18")
        self.navigationItem.leftBarButtonItem = cancelItem
        
        let publihItem = UIBarButtonItem(title:"下一步",style:.Plain,target:self,action:#selector(publishArticle))
        publihItem.tintColor = UIColor(rgba:"#AAFF18")
        self.navigationItem.rightBarButtonItem = publihItem
 
        self.scrollView.frame = self.view.bounds
        self.scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.OnDrag
        self.scrollView.backgroundColor = UIColor.whiteColor()
        
        self.initKeyboardNotification()
        self.initTitleView()
        self.initTextView()
        self.initToolbar()
        self.scrollView.addSubview(lineLabel)
        
        self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.scrollView.bounds), self.scrollViewContentHeight)
        self.view.addSubview(self.scrollView)
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // MARK: 键盘通知
    func initKeyboardNotification(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardShow), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardHide), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func initTitleView(){
        self.titleTextView = KMPlaceholderTextView(frame: CGRectMake(15, 15,SCREEN_WIDTH - 30, 40))
        self.titleTextView.font = UIFont.systemFontOfSize(18)
        self.titleTextView.scrollEnabled = false
        self.titleTextView.tag = 1000
        self.titleTextView.placeholder = "请输入标题"
        self.titleTextView.becomeFirstResponder()
        self.scrollView.addSubview(self.titleTextView)
    }
    
    private lazy var lineLabel:UILabel = {
        
        let lineLabel = UILabel(frame:CGRectMake(10, 55, SCREEN_WIDTH - 20,1))
        lineLabel.backgroundColor = UIColor(rgba:"#CBCBCF")
        return lineLabel
        
        
    }()
    
    func initTextView(){
        self.container = NSTextContainer(size:CGSizeMake(SCREEN_WIDTH, CGFloat.max))
        self.container.widthTracksTextView = true
        self.container.heightTracksTextView = true
        self.layoutManger.addTextContainer(self.container)
        self.textStorage.addLayoutManager(self.layoutManger)
        self.textContent = NSMutableAttributedString(string:"",
                                                     attributes: fontArribuates)
        self.contentTextView = KMPlaceholderTextView(frame: CGRectMake(15, CGRectGetMaxY(self.titleTextView.frame) + 10, SCREEN_WIDTH-30,SCREEN_HEIGHT-60), textContainer: self.container)
        self.contentTextView.scrollEnabled = false
        self.contentTextView.placeholder = "请输入正文"
        self.contentTextView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.OnDrag;
        self.contentTextView.dataDetectorTypes = UIDataDetectorTypes.None
        self.contentTextView.tag = 2000
        self.contentTextView.delegate = self
        
        self.scrollView.addSubview(self.contentTextView)
        self.textStorage.setAttributedString(self.textContent)
        self.scrollViewContentHeight = self.titleTextView.frame.height + self.contentTextView.contentSize.height
    }
    
    func initToolbar(){
        let numberToolbar = UIToolbar(frame: CGRectMake(0, 0, self.view.frame.size.width, toolbarHeight))
        let pictureButton = UIButton(frame:CGRectMake(0, 0, 32, 32))
        pictureButton.setImage(UIImage(named:"picture"), forState: UIControlState.Normal)
        pictureButton.addTarget(self, action:#selector(addPicture), forControlEvents: UIControlEvents.TouchUpInside)
        let item = UIBarButtonItem(customView:pictureButton)
        
        let keyboardButton = UIButton(frame:CGRectMake(0, 0, 32, 32))
        keyboardButton.setImage(UIImage(named:"keyboard"), forState: UIControlState.Normal)
        keyboardButton.addTarget(self, action:#selector(endEdit), forControlEvents: UIControlEvents.TouchUpInside)
        let item1 = UIBarButtonItem(customView:keyboardButton)
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem:UIBarButtonSystemItem.FlexibleSpace,target: nil,action: nil)
            
     
        
        
        numberToolbar.items = [
           item,flexibleSpace,item1
        ]
        self.contentTextView.inputAccessoryView = numberToolbar
    }
    
    
    func addPicture(){
      
        
//        let fusuma = FusumaViewController()
//        fusuma.delegate = self
//        self.presentViewController(fusuma, animated: true, completion: nil)
        
        let photoPickerController = PhotoPickerController()
        photoPickerController.delegate = self
        photoPickerController.allowMultipleSelection = false
        self.presentViewController(photoPickerController, animated: true, completion: nil)
    }
    
    func endEdit(){
    
        self.view.endEditing(true)
    
    }
    
    //MARK: Toolbar function
    /**
     insert picture in textview
     */
    func insertPicture(image:UIImage,remoteUrl:String){
        self.contentTextView.resignFirstResponder()
        self.textStorage.beginEditing()
        
        let lineBreakAttributeString = NSMutableAttributedString(string: self.lineBreakStr, attributes: fontArribuates);
        let borderImage = image.imageWithTopAndBottomBorder()
        let imageWidth = SCREEN_WIDTH - 40
        let imgAttachment = NSTextAttachment(data: nil, ofType: nil)
        var imgAttachmentString: NSAttributedString
        
        borderImage.remoteUrl = remoteUrl
        imgAttachment.image = borderImage
        imgAttachment.bounds = CGRectMake(0, 0, imageWidth, borderImage.size.height*(imageWidth/borderImage.size.width))
        imgAttachmentString = NSAttributedString(attachment: imgAttachment)
        
        let textRange = self.locateCurrentTextRange()
        if textRange.location == 0 || textRange.location > textContent.length {
            self.textContent.appendAttributedString(imgAttachmentString)
            self.textContent.appendAttributedString(lineBreakAttributeString)
        }else{
            let index = textRange.location + textRange.length
            self.textContent.insertAttributedString(imgAttachmentString, atIndex: index)
            self.textContent.insertAttributedString(lineBreakAttributeString, atIndex: index + imgAttachmentString.length)
        }
        
        self.contentTextView.attributedText = self.textContent
        self.textStorage.setAttributedString(self.textContent)
        self.textStorage.endEditing()
        
        self.changeViewHeight()
        self.scrollToCursor(self.currentRange)
    }
    
    /**
     Export NSAttribute String to Plain Text
     */
    func exportPlainText()->String{
        let exportTextStorage = NSTextStorage()
        exportTextStorage.setAttributedString(self.textContent)
        exportTextStorage.enumerateAttribute(NSAttachmentAttributeName, inRange: NSMakeRange(0, self.textStorage.length), options:.LongestEffectiveRangeNotRequired) { (value, range, stop) in
            if (value != nil) {
                if value is NSTextAttachment{
                    let attachment = value as! NSTextAttachment
                    print("----------",attachment.fileType)
                    let imgTag = "<img src='http://oss.microduino.cn/picture/scaleCenter/Images/\(attachment.image!.remoteUrl)'/>"
                    exportTextStorage.replaceCharactersInRange(range, withString: imgTag)
                    stop.memory = true
                }
            }
        }
        NSLog("标题%@",titleTextView.text)
        NSLog("导出字符串%@", exportTextStorage.string)
        return exportTextStorage.string
      
    }
    /**
     Confrim if delete image
     
     - parameter range: image attachment range
     */
    func confirmDeleteImage(range:NSRange){
        self.contentTextView.resignFirstResponder()
        self.contentTextView.selectedRange = NSMakeRange(1, 0)
        let alertController = UIAlertController(title: "删除这张照片吗?", message:"", preferredStyle: .ActionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
        let okAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction!) in
            self.textStorage.beginEditing()
            self.textContent.deleteCharactersInRange(range)
            self.textStorage.setAttributedString(self.textContent)
            self.contentTextView.attributedText = self.textContent
            self.textStorage.endEditing()
            self.changeViewHeight()
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    /**
     Locate current text paragraph range,
     Make sure image always append after text instead of insert in selected text
     */
    func locateCurrentTextRange() -> NSRange{
        var textRange = NSMakeRange(0, 0)
        self.textStorage.enumerateAttributesInRange(NSMakeRange(0, textStorage.length), options: .LongestEffectiveRangeNotRequired) { (value, range, stop) in
            if NSLocationInRange(self.currentRange.location, range)
            {
                textRange = range
                stop.memory = true
            }
        }
        return textRange
    }
    
    /**
     根据字数设置滚动条的位置
     */
    func scrollToCursor(range:NSRange){
        let scrollHeight = CGRectGetMinY(self.contentTextView.frame) + self.caculateContentHeight(withRange: NSMakeRange(0, range.location))
        let finalRect = CGRectMake(1, scrollHeight, 1, 1);
        self.scrollView.scrollRectToVisible(finalRect, animated: true)
    }
    
    /**
    根据字数的位置返回高度
     */
    func caculateContentHeight(withRange range:NSRange) -> CGFloat{
        let contentSize:CGRect = self.contentTextView
            .attributedText.attributedSubstringFromRange(range)
            .boundingRectWithSize(CGSizeMake(self.contentTextView.frame.width, CGFloat.max)
                , options: NSStringDrawingOptions.UsesLineFragmentOrigin, context: nil)
        return contentSize.height +  singleLineHeight
    }
    
    /**
     修改TextView高度和ScrollView高度
     */
    func changeViewHeight(){
        let originFrame = self.contentTextView.frame
        let contentTextViewHeight = self.caculateContentHeight(withRange: NSMakeRange(0, self.textStorage.length))
        
        self.scrollViewContentHeight = CGRectGetMinY(originFrame) + contentTextViewHeight + naviBarHeight
        self.contentTextView.frame = CGRect(x: CGRectGetMinX(originFrame), y: CGRectGetMinY(originFrame), width: CGRectGetWidth(originFrame), height: contentTextViewHeight)
        self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.scrollView.frame), self.scrollViewContentHeight)
    }
    
    
    // MARK: UITextView Delegate
    func textViewDidChange(textView: UITextView) {

        self.textContent = textView.attributedText.mutableCopy() as! NSMutableAttributedString
        self.changeViewHeight()
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        return true;
    }
    
    func textViewDidChangeSelection(textView: UITextView) {
        self.currentRange = textView.selectedRange;
        self.scrollToCursor(self.currentRange)
        if(self.currentRange.location>0){
        if self.textStorage.length >= self.currentRange.location - 1{
            if let _:NSTextAttachment = self.textStorage.attribute(NSAttachmentAttributeName, atIndex: self.currentRange.location-1, effectiveRange: nil) as? NSTextAttachment{
                confirmDeleteImage(NSMakeRange(self.currentRange.location-1, 1))
            }
            }}
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if(textView.tag  == 1000){
            
            print("标题",textView.text)
        
        }else{
        
            print(textView.text)
        
        }
    }
    
    // MARK: Keyboard notification handler
    func keyboardShow(notification:NSNotification){
        let userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue()
        keyboardFrame = self.view.convertRect(keyboardFrame, fromView: nil)
        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + self.toolbarHeight + 20
        self.scrollView.contentInset = contentInset
    }
    
    func keyboardHide(noti:NSNotification){
        let contentInset:UIEdgeInsets = UIEdgeInsetsZero
        self.scrollView.contentInset = contentInset
    }
    
    func publishArticle(){
        
//        self.view.endEditing(true)
//        self.navigationController?.pushViewController(publishViewController(), animated:true)
        
        Meteor.call("mobile/article_new", params:[titleTextView.text,"111111111111",exportPlainText()], callback: { (result, error) in
            
            print("写文章结果\(result),错误原因\(error)")
        })
        
    }
    
    func cancelAction(){
    
        self.view.endEditing(true)
        
        self.dismissViewControllerAnimated(true) {}
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension TextKitViewController: PhotoPickerDelegate {
    func photoPickerControllerDidCancel(controller: PhotoPickerController) {
        navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func photoPickerController(controller: PhotoPickerController, didFinishPickingAssets assets: [PHAsset], needHighQualityImage: Bool) {
        navigationController?.dismissViewControllerAnimated(true, completion: { () -> Void in
        
            for asset in assets {
              
                let imageManager = PHImageManager()

                imageManager.requestImageForAsset(asset, targetSize:CGSizeMake(SCREEN_WIDTH,CGFloat(asset.pixelHeight)), contentMode: PHImageContentMode.AspectFill, options: nil, resultHandler: { (image, info) in
                    if(image?.size.width>60){
                       
                        let date = NSDate()
                        let timeInterval = date.timeIntervalSince1970 * 1000
                        
                        self.uploadTestFile(UIImagePNGRepresentation(image!)!, name:"\(Meteor.client.userId()!)_\(timeInterval).png")
                        print()
                        self.insertPicture(image!, remoteUrl:"\(Meteor.client.userId()!)_\(timeInterval).png")
                       
                    }
                    
                })
            }
        })
    }
}
extension TextKitViewController{

    func uploadTestFile(file:NSData,name:String) {
        
        let putRequest = OSSPutObjectRequest()
        putRequest.bucketName = OSSBucketName
        putRequest.objectKey = "picture/scaleCenter/Images/\(name)"
        putRequest.uploadingData = file
        
        putRequest.uploadProgress = { bytesSent, totalByteSent, totalBytesExpectedToSend in
            print("Bytes sent: \(bytesSent), Total bytes sent:\(totalByteSent), Expected total bytes sent: \(totalBytesExpectedToSend)")
            
        }
        
        let putTask = client.putObject(putRequest)
        putTask.continueWithBlock({ task in
            var result: String = ""
            if task.error == nil {
  
                result = "Completed uploading text: " + task.result.description.capitalizedString
                
            } else {
                result = "Failed to upload object. Error: " + task.error.localizedDescription
              
            }
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
            
                
                print(result)
                
            })
            
            return nil
        })
    }
    


}
extension TextKitViewController:FusumaDelegate{

    func fusumaImageSelected(image: UIImage) {
        
        let date = NSDate()
        let timeInterval = date.timeIntervalSince1970 * 1000
        
        self.uploadTestFile(UIImagePNGRepresentation(image)!, name:"\(Meteor.client.userId()!)_\(timeInterval).png")
        print()
        self.insertPicture(image, remoteUrl:"\(Meteor.client.userId()!)_\(timeInterval).png")
    }
    
    // When camera roll is not authorized, this method is called.
    func fusumaCameraRollUnauthorized() {
        
        print("Camera roll unauthorized")
    }
    
    // (Optional) Return the image but called after is dismissed.
    func fusumaDismissedWithImage(image: UIImage) {
        
        print("Called just after FusumaViewController is dismissed.")
    }
    
    // (Optional) Called when the close button is pressed.
    func fusumaClosed() {
        
        print("Called when the close button is pressed")
    }



}
