//
//  DiscoverDetailViewController.swift
//  Microduino
//
//  Created by harvey on 16/3/21.
//  Copyright © 2016年 harvey. All rights reserved.
//

import UIKit
import SwiftDDP
import MJRefresh
import SnapKit
class DiscoverDetailViewController: YHBaseController,UIScrollViewDelegate{

    var card_Id:NSString?
    var card_Type:NSString?
    
    var lastContentOffset:CGFloat?
    var oldOffset:CGFloat?
    var keyboardHeight:CGFloat?
    
    var commentCell:DiscoverCommentViewCell?
    
    private var articleModel:ArticleModel?
    private var commentModel : CommentViewModel?
    var dismissFrame = CGRectMake(0, 0, 0, 0)
    var navBar = UIView()
    override func viewDidLoad() {
 
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(errorBtnDidClick), name: NOTIFY_ERRORBTNCLICK, object: nil)
        
      
        self.view.backgroundColor = UIColor.whiteColor()
        
        let navBut = UIButton(type: UIButtonType.System)
        let navTitle = UILabel()
        navBar.frame=CGRectMake(0, 0, self.view.bounds.width, 64)
        navBut.frame=CGRectMake(0, 16, 45, 45)
        navTitle.frame=CGRectMake(55 , 20, self.view.bounds.width-50, 30)
        
        navBar.backgroundColor = UIColor(rgba:"#673ab7")
        navBut.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        navBut.tintColor=UIColor.whiteColor()
        navBut.setImage(UIImage(named: "back")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate), forState: UIControlState.Normal)
        navBut.addTarget(self, action: "dismiss", forControlEvents: UIControlEvents.TouchUpInside)
        navTitle.textColor=UIColor.whiteColor()
        navTitle.font=UIFont(name: "Roboto-Medium", size: 20)
        navTitle.text="Detail Page"
        
        navBar.addSubview(navBut)
        navBar.addSubview(navTitle)
        view.addSubview(navBar)


        createUI()
        createCommentView()
       
       
    }
   
    override func viewWillAppear(animated: Bool) {
        
        reloadWebData()
    }
    

    func createUI(){
    
      
        self.view.addSubview(bottomView)
      
        self.bottomView.snp_makeConstraints { (make) -> Void in
            make.left.right.bottom.equalTo(self.view)
            make.height.equalTo(40)
        }
        commentModel = CommentViewModel(commentTable:tableview)
      
    }
    
    func  createCommentView(){
        
        self.view.addSubview(messageView)
        self.view.sendSubviewToBack(messageView)

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillAppear), name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillDisappear), name:UIKeyboardWillHideNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(notiOfTextViewContentSizeHeightChangedActionHeigher), name:NotiOfTextViewContentSizeHeightChangedHeigher, object: nil)
    
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(notiOfTextViewContentSizeHeightChangedActionLower), name:NotiOfTextViewContentSizeHeightChangedLower, object: nil)
    
        
    }
    
    
    // MARK: 控件懒加载
  
    //文章
    private lazy var articleWebView:UIWebView = {
    
        let articleWebView:UIWebView = UIWebView(frame:CGRectMake(0,0,SCREEN_WIDTH,1))
        articleWebView.scrollView.showsHorizontalScrollIndicator = false
        articleWebView.scrollView.scrollEnabled = false
        articleWebView.scrollView.bounces = false
        articleWebView.delegate = self
        return articleWebView
    }()

    // 评论栏
    private lazy var bottomView : DiscoverDetailCommentView = {
        let bottomView : DiscoverDetailCommentView = DiscoverDetailCommentView()
        bottomView.delegate = self
        return bottomView
    }()
    
    // 评论窗口
    private lazy var messageView:YHMessageView = {
    
        let messageView:YHMessageView = YHMessageView(frame:CGRectMake(0,SCREEN_HEIGHT,SCREEN_WIDTH, CGFloat(MessageViewDefaultHeight)))
        messageView.delegate = self
        return messageView
    }()

    // 列表
    private lazy var tableview:UITableView = {
    
        let tableview:UITableView = UITableView(frame:CGRectMake(0,64,SCREEN_WIDTH,SCREEN_HEIGHT),style:UITableViewStyle.Grouped)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.registerClass(DiscoverCommentViewCell.self, forCellReuseIdentifier:"cellIdentifier")
        return tableview
    
    }()
    
    

}

// MARK: 数据加载

extension DiscoverDetailViewController{

    
    func reloadWebData(){
        
        self.showProgress()
        
        Meteor.call(ServerAPI.articleComments, params:[self.card_Id!], callback: { (result, error) in
     
            if((error) != nil||result == nil){
                
                self.bottomView.hidden = true
                
            }else{
                
                self.commentModel?.initCommentData(NSMutableArray(array:result as! NSArray))
                
            }
            
        })
        
        Meteor.call(ServerAPI.articleShow, params:[self.card_Id!], callback: { (result, error) in
           
            if((error) != nil||result == nil){
                self.showNetWorkErrorView()
                self.hiddenProgress()
                self.bottomView.hidden = true
                
            }else{
               
              
                self.articleModel =  ArticleModel(dict:result! as! NSDictionary)
                var htmlString = self.articleModel!.content!
                htmlString.appendContentsOf(HTML_CONSTRAINT)
                self.articleWebView.loadHTMLString(htmlString, baseURL:nil)
                
            }})
    }
    
    
    func errorBtnDidClick() {
        
        reloadWebData()
        
    }
    
    func returnBtnDidClick() {
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}

// MARK: 文章内容加载

extension DiscoverDetailViewController:UIWebViewDelegate{


    
    func webViewDidFinishLoad(webView: UIWebView) {
        hiddenProgress()
        self.view.addSubview(tableview)
        if(!webView.loading){
        let height =  webView.stringByEvaluatingJavaScriptFromString("document.body.offsetHeight")! as NSString
        articleWebView.stringByEvaluatingJavaScriptFromString(FOUND_IMG)
        articleWebView.stringByEvaluatingJavaScriptFromString("addImgClickEvent();")
        articleWebView.frame = CGRectMake((articleWebView.frame.origin.x),(articleWebView.frame.origin.y),SCREEN_WIDTH,CGFloat(height.floatValue)+20);
        self.view.bringSubviewToFront(bottomView)
     
        }
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        let scheme = "hyb-image-preview:"
        if ((request.URL?.scheme.hasPrefix(scheme)) != nil) {
            let src = request.URL?.absoluteString.stringByReplacingOccurrencesOfString(scheme, withString: "")
            
            if let imageUrl = src {
                
                if(((imageUrl != "about:blank"))&&(imageUrl.containsString("jpg")))||(((imageUrl != "about:blank"))&&(imageUrl.containsString("png"))||((imageUrl != "about:blank"))&&(imageUrl.containsString("JPG"))){
                let ImageViewer: imagePreview = imagePreview(imageURLs:[imageUrl], index: 0)
                ImageViewer.show()
                
                }else if(navigationType == UIWebViewNavigationType.LinkClicked&&imageUrl.containsString("http")){
                    
                    let tabVC = YHWebViewController(url:imageUrl)
                    self.navigationController!.pushViewController(tabVC, animated: true)
                    
                }
            }

        
        }
        
        return true
    }
    
    
    func dismiss(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

// MARK: 文章＋评论列表

extension DiscoverDetailViewController:UITableViewDelegate,UITableViewDataSource{

    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
    if(section == 1){
        let view = UILabel(frame:CGRectMake(0,0,SCREEN_WIDTH,30))
        view.text = "  评论  \((self.commentModel?.newDataSource.count)! as Int)"
        view.backgroundColor = UIColor(rgba:"#C8CECD")
        view.textColor = UIColor.blackColor()
        return view
    }else{
        
        let followView = FollowAuthorView(frame:CGRectMake(0,0,SCREEN_WIDTH,55))
        followView.delegate = self
        followView.model = articleModel
        bottomView.model = articleModel
        return followView
    }}

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == 0){
       
            return 55
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
            if self.commentModel != nil {
                return (self.commentModel?.newDataSource.count)!
            }
            else{
                return 0
            }
        
        }

    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if(indexPath.section == 0){
        
              return (articleWebView.size.height)
        }
  
       else if((commentCell) != nil){
            
            return (commentCell?.frame.height)!
            
        }else{
            
          return 120
        }

    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        if indexPath.section == 0{
            let tableCell = UITableViewCell(style:UITableViewCellStyle.Subtitle, reuseIdentifier:"cell")
            tableCell.selectionStyle = UITableViewCellSelectionStyle.None
            tableCell.contentView.addSubview(articleWebView)
            return tableCell
        }else{
            
            let cellIndentifier :String = "cellIdentifier";
            commentCell = tableView.dequeueReusableCellWithIdentifier(cellIndentifier) as? DiscoverCommentViewCell
            commentCell!.selectionStyle = UITableViewCellSelectionStyle.None
            commentCell?.model = self.commentModel?.newDataSource[indexPath.row]
            return commentCell!
            }
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        self.view.endEditing(true)
    }
    

    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        lastContentOffset = scrollView.contentOffset.y
    }

    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if (scrollView.dragging) {
            if scrollView.contentOffset.y - lastContentOffset! > 5.0 {
    
                bottomView.snp_updateConstraints(closure: { (make) in
                    make.bottom.equalTo(44)
                })
                UIView.animateWithDuration(0.25, animations: {
                    self.view.layoutIfNeeded()
                })
            } else if lastContentOffset! - scrollView.contentOffset.y > 5.0 {
      
                bottomView.snp_updateConstraints(closure: { (make) in
                    make.bottom.equalTo(0)
                })
                UIView.animateWithDuration(0.25, animations: {
                    self.view.layoutIfNeeded()
                })
            }
            
        }
    }

    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        if case let space = scrollView.contentOffset.y + SCREEN_HEIGHT - scrollView.contentSize.height where space > -5 && space < 5 {
            bottomView.snp_updateConstraints(closure: { (make) in
                make.bottom.equalTo(0)
            })
            UIView.animateWithDuration(0.25, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }


}
// MARK: 底部工具条

extension DiscoverDetailViewController:DiscoverCommentViewDelegate{

    func DiscoverCommentBtnClick() {

        self.view.bringSubviewToFront(messageView)
        messageView.textView!.becomeFirstResponder()
        
    }

    func DiscoverPriaseBtnClick(tag: Int) {
   
        Meteor.call(ServerAPI.articleFavorite, params:[card_Id!], callback: { (result, error) in
            if(error != nil){
                
                YHAlertController.alert("ERROR", message:"点赞失败")
            }else{
                self.bottomView.favcount.text = "\(result as! Int)"
            }
        })
    }
    
    func DiscoverShareBtnClick()
    
    {
//        let shareWdn = ShareWindow.shareInstance
//        shareWdn.delegate = self
//        shareWdn.showShareView()
//
       UMSocialSnsService.presentSnsIconSheetView(self, appKey:"56f8d516e0f55af048001f43", shareText:"推荐@\(articleModel!.author_name!)的文章\(articleModel!.article_shareUrl!)   (分享自@Microduino)", shareImage:nil, shareToSnsNames:[UMShareToSina,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToFacebook,UMShareToTwitter,UMShareToInstagram], delegate:self)
        
   }
    
    
    
    func keyboardWillAppear(notification: NSNotification) {
        articleWebView.userInteractionEnabled = false
        if let userInfo = notification.userInfo {
            
            if let keyboardSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue() {
                keyboardHeight = keyboardSize.size.height
                var messageViewNewY = SCREEN_HEIGHT - (keyboardHeight!+104)
                
                if((self.navigationController) != nil){
                    if self.navigationController!.navigationBarHidden{
                        
                        messageViewNewY = SCREEN_HEIGHT - (keyboardHeight!+40)

                    }
                    }
          
                
                UIView.animateWithDuration(0.333) {
                    self.messageView.frame = CGRectMake(self.messageView.frame.origin.x, messageViewNewY, self.messageView.frame.size.width, self.messageView.frame.size.height)
                }
                
                
            }}
        
    }
    
    func keyboardWillDisappear(notification:NSNotification){
         articleWebView.userInteractionEnabled = true
        if let userInfo = notification.userInfo {
            if let keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
                keyboardHeight = keyboardSize.height
            }}

    }

    
    func notiOfTextViewContentSizeHeightChangedActionHeigher(notification: NSNotification){
    
        let height = notification.object as! CGFloat
        messageView.frame = CGRectMake(self.messageView.frame.origin.x,self.messageView.frame.origin.y - height, self.messageView.frame.size.width, self.messageView.frame.size.height + height)
        self.messageView.textView!.frame = CGRectMake(CGFloat(TextViewLeadingMargin),5, self.messageView.bounds.size.width - CGFloat(TextViewLeadingMargin+TextViewTrailingMargin+SendBtnWidth+SendBtnTrailingMargin), self.messageView.bounds.size.height-10);
    
    }
  
    func notiOfTextViewContentSizeHeightChangedActionLower(notification: NSNotification){
        
        
        let height = notification.object as! CGFloat
        self.messageView.frame = CGRectMake(self.messageView.frame.origin.x, self.messageView.frame.origin.y + height, self.messageView.frame.size.width, self.messageView.frame.size.height - height);
        self.messageView.textView!.frame = CGRectMake(CGFloat(TextViewLeadingMargin),5, self.messageView.bounds.size.width - CGFloat(TextViewLeadingMargin+TextViewTrailingMargin+SendBtnWidth+SendBtnTrailingMargin), self.messageView.bounds.size.height-10);
        }
}

// MARK: 链接分享

extension DiscoverDetailViewController:UMSocialUIDelegate{

    func didFinishGetUMSocialDataInViewController(response: UMSocialResponseEntity!) {
        
        if(response.responseCode == UMSResponseCodeSuccess)
        {
          
        }
   
    }

}
// MARK: 作者关注

extension DiscoverDetailViewController:FollowAuthorViewDelegate{

    func FollowBtnClick(sender: UIButton) {
        if(sender.tag == 0){

            Meteor.call(ServerAPI.friendFollow, params:[(articleModel?.author_id)!], callback: { (result, error) in
                if(result != nil){
                sender.backgroundColor = UIColor.clearColor()
                sender.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
                sender.setTitle("已关注", forState: UIControlState.Normal)
                sender.tag = 1
                }
            })

            
        }
        else{
            Meteor.call(ServerAPI.friendunFollow, params:[(articleModel?.author_id)!], callback: { (result, error) in
                if(result != nil){
                sender.backgroundColor = UIColor(rgba:"#1D1D1D")
                sender.setTitle("关注", forState: UIControlState.Normal)
                sender.setTitleColor(UIColor(rgba:"#AAFF18"), forState: UIControlState.Normal)
                sender.tag = 0
            }
            })
        }
        
    }
}
// MARK: 评论内容发送

extension DiscoverDetailViewController:YHMessageViewDelegate{

    func sendComment(comment:String){
        
        let dict: [String: AnyObject] = ["linkedObjectId":card_Id!,"comment":comment.convertToUTF8()]

            Meteor.call(ServerAPI.commentAdd, params:[dict], callback: { (result, error) in
      
                self.reloadWebData()
                
                
            })
        }
  
  
    func asSendBtnAction(sender: UIButton) {
        messageView.textView!.resignFirstResponder()
        
        if(messageView.textView!.text.length != 0){
            
            sendComment(messageView.textView!.text)
        }else{
        
            YHAlertController.alert("评论不能为空")
        }
        
    }

    func asTextViewDidBeginEditing(textView: UITextView) {
        
        
    }
   
    func asTextViewDidEndEditing(textView: UITextView) {
      
        let messageViewNewY = self.messageView.frame.origin.y + keyboardHeight!
        UIView.animateWithDuration(0.333) {
        self.messageView.frame = CGRectMake(self.messageView.frame.origin.x, messageViewNewY, self.messageView.frame.size.width, self.messageView.frame.size.height);
        }
        self.view.sendSubviewToBack(messageView)
        keyboardHeight = 0
    }
}
