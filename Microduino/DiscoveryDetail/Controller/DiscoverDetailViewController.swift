//
//  DiscoverDetailViewController.swift
//  Microduino
//
//  Created by harvey on 16/3/21.
//  Copyright © 2016年 harvey. All rights reserved.
//

import UIKit
import SwiftDDP
import Fuzi
import MJRefresh
class DiscoverDetailViewController: YHBaseController,UIScrollViewDelegate{

    var webview:UIWebView?
    var card_Id:NSString?
    var card_Type:NSString?
    var lastContentOffset:CGFloat?
    var commentTextView:UITextView?
    var commentCell:DiscoverCommentViewCell?
    private var viewModel : CommentViewModel?
    override func viewDidLoad() {
 
         NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(errorBtnDidClick), name: NOTIFY_ERRORBTNCLICK, object: nil)
        self.view.backgroundColor = UIColor(rgba:"#F2F2F6")
        self.automaticallyAdjustsScrollViewInsets = false

        toolBarView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height:64)
        toolBarView.backgroundColor = UIColor(rgba:"#F2F2F6")
        self.view.addSubview(toolBarView)
        
        returnBtn.frame = CGRect(x: 20, y: 27, width: 30, height: 30)
        self.view.addSubview(returnBtn)
    
        // 底部评论view
        self.view.addSubview(bottomView)
        self.bottomView.snp_makeConstraints { (make) -> Void in
            make.left.right.bottom.equalTo(self.view)
            make.height.equalTo(40)
        }
        tableview.registerClass(DiscoverCommentViewCell.self, forCellReuseIdentifier:"cellIdentifier")
        viewModel = CommentViewModel(commentTable:tableview)
        self.webview = UIWebView(frame:CGRectMake(0,0,SCREEN_WIDTH,1))
        self.webview!.scrollView.showsHorizontalScrollIndicator = false
        self.webview!.scrollView.scrollEnabled = false;
        self.webview!.scrollView.bounces = false;
        self.webview!.delegate = self
        
        
        createCommentView()
     
        reloadWebData()
    }
    
    
    func reloadWebData(){
        
        self.showProgress()
        
        Meteor.call("mobile/comments", params:[self.card_Id!], callback: { (result, error) in
            
            if((error) != nil||result == nil){
                
                
            }else{
                
                for comment in result as! NSArray{
                    
                    let dict = comment as! NSDictionary
                    
                    Meteor.call("mobile/comment_remove", params:[dict.objectForKey("_id")!], callback: { (result, error) in
                    })}
                
                self.viewModel?.initCommentData(NSMutableArray(array:result as! NSArray))
                
            }
            
        })
 
            Meteor.call("mobile/article_show", params:[self.card_Id!], callback: { (result, error) in
                
                if((error) != nil||result == nil){
                    self.showNetWorkErrorView()
                    self.hiddenProgress()
                     
                }else{
                    
                    let model =  ArticleModel(dict:result! as! NSDictionary)
                    var htmlString = model.content!
                    htmlString.appendContentsOf(HTML_CONSTRAINT)
                    self.webview!.loadHTMLString(htmlString, baseURL:nil)
                   
                }})
            
        
 
    }
 
    func textChange(notification:NSNotification){
    
    }
    
    func errorBtnDidClick() {
   
        reloadWebData()
       
    }

    //MARK:- CenterViewDelegate
    func returnBtnDidClick(sender:UIButton) {
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
   func  createCommentView(){
    
        commentTextView = UITextView(frame: CGRectMake(0,SCREEN_HEIGHT,SCREEN_WIDTH,80))
        commentTextView!.backgroundColor = UIColor.whiteColor()
        commentTextView?.layer.borderWidth = 10
        commentTextView?.contentOffset = CGPointMake(10,10)
        commentTextView?.layer.borderColor = UIColor(rgba:"#F2F2F6").CGColor
        commentTextView!.contentInset = UIEdgeInsetsMake(10.0,10.0, 10.0, 10.0)
        self.view.addSubview(commentTextView!)
    
        let keyboardDoneButtonView = UIView(frame:CGRectMake(0,0,SCREEN_WIDTH,40))
        keyboardDoneButtonView.backgroundColor = UIColor(rgba:"#F2F2F6")
        commentTextView!.inputAccessoryView = keyboardDoneButtonView;
    
        let sendCommentButton = UIButton(frame:CGRectMake(SCREEN_WIDTH-80,5,60,30))
        sendCommentButton.setTitle("发表评论", forState: UIControlState.Normal)
        sendCommentButton.titleLabel?.font = UI_FONT_10
        sendCommentButton.addTarget(self, action:#selector(sendComment), forControlEvents: UIControlEvents.TouchUpInside)
        sendCommentButton.backgroundColor = UIColor(rgba:"#6CE137")
        keyboardDoneButtonView.addSubview(sendCommentButton)
    
//    UIImage *maskImage = [UIImage imageNamed:@"btn_link_fill"];
//    UIImage *lineImage = [UIImage imageNamed:@"btn_link_line"];
    
    
    
        
    
    
    
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillAppear), name: UIKeyboardWillShowNotification, object: nil)
    
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillDisappear), name:UIKeyboardWillHideNotification, object: nil)
    
    }
    
  
    private lazy var toolBarView : DiscoverDetailToolView = {
        let toolBarView : DiscoverDetailToolView = DiscoverDetailToolView.toolView()
        toolBarView.delegate = self
        return toolBarView
    }()
    
   // 评论栏
    private lazy var bottomView : DiscoverDetailCommentView = {
        let bottomView : DiscoverDetailCommentView = DiscoverDetailCommentView()
        bottomView.delegate = self
        return bottomView
    }()
    
    private lazy var tableview:UITableView = {
    
        let tableview:UITableView = UITableView(frame:CGRectMake(0,64,SCREEN_WIDTH,SCREEN_HEIGHT-64),style:UITableViewStyle.Grouped)
        tableview.delegate = self
        tableview.dataSource = self
        return tableview
    
    }()
    
    // 返回按钮
    private lazy var returnBtn : UIButton = {
        let returnBtn : UIButton = UIButton()
        returnBtn.addTarget(self, action:#selector(returnBtnDidClick(_:)), forControlEvents: .TouchUpInside)
        returnBtn.setImage(UIImage(named: "detail_icon_back_normal"), forState: .Normal)
        returnBtn.setImage(UIImage(named: "detail_icon_back_pressed"), forState: .Highlighted)
        return returnBtn
    }()

    // 描述(p)
    private func createPTitleLabel() -> YYLabel {
        let contentLabel : YYLabel = YYLabel()
        contentLabel.displaysAsynchronously = true
        contentLabel.font = UI_FONT_16
        contentLabel.textColor = UIColor.darkGrayColor()
        contentLabel.numberOfLines = 0
        return contentLabel
    }
}

extension DiscoverDetailViewController:UIWebViewDelegate{


    func webViewDidFinishLoad(webView: UIWebView) {
        hiddenProgress()
        self.view.addSubview(tableview)
        if(!webView.loading){
        let height =  webView.stringByEvaluatingJavaScriptFromString("document.body.offsetHeight")! as NSString
        self.webview!.stringByEvaluatingJavaScriptFromString(FOUND_IMG)
        self.webview!.stringByEvaluatingJavaScriptFromString("addImgClickEvent();")
        self.webview?.frame = CGRectMake((self.webview?.frame.origin.x)!,(self.webview?.frame.origin.y)!,SCREEN_WIDTH,CGFloat(height.floatValue));
        self.view.bringSubviewToFront(bottomView)
        self.view.bringSubviewToFront(commentTextView!)
     
        }
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        let scheme = "hyb-image-preview:"
        if ((request.URL?.scheme.hasPrefix(scheme)) != nil) {
            let src = request.URL?.absoluteString.stringByReplacingOccurrencesOfString(scheme, withString: "")
            
            if let imageUrl = src {
                
                
                if(((imageUrl != "about:blank"))&&(imageUrl.containsString("jpg")))||(((imageUrl != "about:blank"))&&(imageUrl.containsString("png"))){
                
                let ImageViewer: imagePreview = imagePreview(imageURLs:[imageUrl], index: 0)
                ImageViewer.show()
                
                }
            }

        
        }
        
        return true
    }
}

extension DiscoverDetailViewController:XMFindAppDetailToolViewDelegate,XMHomeDetailCenterViewDelegate{


    func homeDetailCenterViewBottomShareDidClick(centerView: DiscoverCenterView) {
        
    }
    
    func homeDetailCenterView(centerView: DiscoverCenterView, returnButtonDidClick returnButton: UIButton) {
        
    }
    
    //MARK:- CenterViewDelegate
    func FindAppDetailCenterViewReturnBtnDidClick() {
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func XMFindAppDetailToolViewDownloadBtnClick() {
        
        
    }
    
    func XMFindAppDetailToolViewShareBtnClick() {
        
        
        
    }
   
    
}

extension DiscoverDetailViewController:UITableViewDelegate,UITableViewDataSource{

    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UILabel(frame:CGRectMake(0,0,SCREEN_WIDTH,30))
        if(section == 1){
        view.text = "  评论  \((self.viewModel?.newDataSource.count)! as Int)"
        view.backgroundColor = UIColor(rgba:"#F2F2F6")
        view.textColor = UIColor(rgba:"#C83C3A")
        }
        return view
        
    }

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == 0){
       
            return 0.5
        }else{
        
            return 30
        }
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
       
        return 0.5
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 2
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(section == 0){
        
            return 1
        
        }else{
            if self.viewModel != nil {
                return (self.viewModel?.newDataSource.count)!
            }
            else{
                return 0
            }
        
        }

    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if(indexPath.section == 0){
        
            if((webview) != nil){
            return (self.webview?.size.height)!
            }else{
            
                return 0
            }
        
        }
        else{
            
        if((commentCell) != nil){
            
            return (commentCell?.frame.height)!
            
        }else{
            
          return 100
        }
          
        
    }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        if indexPath.section == 0{
            let tableCell = UITableViewCell(style:UITableViewCellStyle.Subtitle, reuseIdentifier:"cell")
            tableCell.selectionStyle = UITableViewCellSelectionStyle.None
            if((webview) != nil){
            
                tableCell.contentView.addSubview(webview!)
            }
            
            return tableCell
        }else{
            
            let cellIndentifier :String = "cellIdentifier";
            commentCell = tableView.dequeueReusableCellWithIdentifier(cellIndentifier) as? DiscoverCommentViewCell
            commentCell!.selectionStyle = UITableViewCellSelectionStyle.None
            commentCell?.model = self.viewModel?.newDataSource[indexPath.row]
            return commentCell!
            }
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        UIApplication.sharedApplication().keyWindow?.endEditing(true)
    
        
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        
        lastContentOffset = scrollView.contentOffset.y
        
    }

    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if lastContentOffset >= scrollView.contentOffset.y{
            bottomView.hidden = false
        }
        else{
        
           bottomView.hidden = true
        }
    }
    
}
extension DiscoverDetailViewController:UITextViewDelegate{

   
    func  textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
        if(text == "\n"){
    
            textView.resignFirstResponder()
    
            return false
        
        }
        return true
    }
 
    func sendComment(){
    
       
        let dict: [String: AnyObject] = ["linkedObjectId":card_Id!,"comment":(commentTextView?.text)!.stringByAddingPercentEncodingWithAllowedCharacters( NSCharacterSet.URLQueryAllowedCharacterSet())!]
        Meteor.connect(HOST_NAME) {
            Meteor.call("mobile/comment_add", params:[dict], callback: { (result, error) in
          
                    self.reloadWebData()
                    self.commentTextView?.resignFirstResponder()
                    
                })
            }
    

    }
}
extension DiscoverDetailViewController:DiscoverCommentViewDelegate{

    func DiscoverCommentBtnClick() {
        
        commentTextView!.becomeFirstResponder()
    }

    func DiscoverPriaseBtnClick(tag: Int) {
   
        
      let  param = card_Type == "project" ? "product_favorite" : "article_favorite"
   
        Meteor.call("mobile/\(param)", params:[card_Id!], callback: { (result, error) in
        
        })
    }
    
    func DiscoverShareBtnClick() {
        
        UMSocialSnsService.presentSnsIconSheetView(self, appKey:"56f8d516e0f55af048001f43", shareText: "来自Microduino", shareImage:UIImage(named:"menu"), shareToSnsNames:[UMShareToSina,UMShareToQQ,UMShareToWechatTimeline,UMShareToFacebook,UMShareToTwitter,UMShareToInstagram], delegate:self)
        
   
        
        
        
    }
    

    func keyboardWillAppear(notification: NSNotification) {
        
        let keyboardinfo = notification.userInfo![UIKeyboardFrameEndUserInfoKey]
        let keyboardheight:CGFloat = (keyboardinfo?.CGRectValue.size.height)!
        commentTextView!.frame = CGRectMake(0,SCREEN_HEIGHT-keyboardheight-80,SCREEN_WIDTH,80)
        
    }
    
    func keyboardWillDisappear(notification:NSNotification){
        
       commentTextView!.frame =  CGRectMake(0,SCREEN_HEIGHT,SCREEN_WIDTH,80)
    }


}
extension DiscoverDetailViewController:UMSocialUIDelegate{


}

