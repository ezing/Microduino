//
//  DiscoverCenterView.swift
//  Microduino
//
//  Created by harvey on 16/4/5.
//  Copyright © 2016年 harvey. All rights reserved.
//

import UIKit
protocol XMHomeDetailCenterViewDelegate  {
    func homeDetailCenterView(centerView : DiscoverCenterView ,returnButtonDidClick returnButton : UIButton)
    func homeDetailCenterViewBottomShareDidClick(centerView : DiscoverCenterView)
    
}

class DiscoverCenterView: UIScrollView {

    private var contentY : CGFloat = 64
    // 代理
    var centerDelegate : XMHomeDetailCenterViewDelegate?
    var model : NSString! {
        willSet {
            self.model = newValue
        }
        didSet {
            
            self.setupOtherData()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        // 添加centerView
        centerView.frame = self.bounds;
        self.addSubview(centerView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- private Methods
    private func setupOtherData() {

        // 添加http文段
        let _ = XMLParserUtil(content: model! as String) { [unowned self](array) -> Void in
            // 拿到解析完的数组后添加控件
            for contentModel in array {
             
                if contentModel.contentType == XMLContentType.XMLContentTypeH2 {
                    // 标题
                    self.contentY += UI_MARGIN_10
                    let h2TitlLabel = self.createH2TitleLabel()
                    h2TitlLabel.text = contentModel.content
                    h2TitlLabel.frame = CGRect(x: UI_MARGIN_10, y: self.contentY, width: SCREEN_WIDTH-2*UI_MARGIN_10, height: 20)
                    self.centerView.addSubview(h2TitlLabel)
                    self.contentY += h2TitlLabel.height + UI_MARGIN_10
                } else if contentModel.contentType == XMLContentType.XMLContentTypeP {
                    // 描述
                    let pTitleLabel = self.createPTitleLabel()
                    pTitleLabel.frame = CGRect(x: UI_MARGIN_10, y: self.contentY, width: SCREEN_WIDTH-2*UI_MARGIN_10, height: 20)
                    let pTitleSize = self.calculateTextHeight(contentModel.content, label: pTitleLabel)
                    self.centerView.addSubview(pTitleLabel)
                    self.contentY += pTitleSize.height + UI_MARGIN_10
                } else if contentModel.contentType == XMLContentType.XMLContentTypeA {
                    // 点击下载
                    let aTitleBtn = self.createATitleButton()
                    aTitleBtn.frame = CGRect(x: UI_MARGIN_10, y: self.contentY, width: 60, height: 20)
                    self.centerView.addSubview(aTitleBtn)
                    self.contentY += aTitleBtn.height + UI_MARGIN_10
                } else if contentModel.contentType == XMLContentType.XMLContentTypeImg {
                    
                
                    // 获取 _ 的位置
                    let imgView : UIImageView = self.createImgView()
                    imgView.frame = CGRectMake(UI_MARGIN_10, self.contentY,300,230)
                    imgView.center.x = SCREEN_WIDTH*0.5
                    imgView.xm_setBlurImageWithURL(NSURL(string:contentModel.content), placeholderImage: UIImage(named: "home_logo_pressed"))
                    self.centerView.addSubview(imgView)
                    self.contentY += 230 + UI_MARGIN_10
                }
            }
        }

         self.contentSize = CGSizeMake(0, contentY)
    
    }
    
    // 根据文字计算高度
    private func calculateTextHeight (text : String, label : YYLabel) -> CGSize {
        // 设置文字样式
        let attributString : NSMutableAttributedString = NSMutableAttributedString(string: text)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5.0
        attributString.yy_font = UI_FONT_16
        attributString.yy_color = UIColor.darkGrayColor()
        attributString.addAttribute(NSParagraphStyleAttributeName , value: paragraphStyle, range: NSMakeRange(0, text.length))
        let textLayout = YYTextLayout(containerSize: CGSize(width: SCREEN_WIDTH-2*UI_MARGIN_10, height: CGFloat.max), text: attributString)
        label.attributedText = attributString
        // 设置样式
        label.size = textLayout!.textBoundingSize
        label.textLayout = textLayout
        
        return textLayout!.textBoundingSize
    }
    
    // MARK:1-CenterView Delegate
    func homeDetailCenterView(centerView: DiscoverCenterView, returnButtonDidClick returnButton: UIButton) {
       
    }
    
    //MARK: - Action Event
    
    //MARK: - getter or setter
    // 内容
    private lazy var centerView : UIView = {
        let centerView : UIView = UIView()
        return centerView
    }()
    
    // 顶部图片
    private lazy var headerImgView : UIImageView = {
        let headerImgView : UIImageView = UIImageView(image: UIImage(named: "home_logo_pressed"))
        headerImgView.contentMode = .ScaleAspectFill
        return headerImgView
    }()
    
    // appIcon
    private lazy var appIconView : UIImageView = {
        let appIconView : UIImageView = UIImageView(image: UIImage(named: "ic_launcher"))
        //        appIconView.contentMode = .ScaleAspectFit
        appIconView.layer.cornerRadius = UI_MARGIN_10
        appIconView.layer.masksToBounds = true
        return appIconView
    }()
    
    // app大标题
    private lazy var appTitleLabel : UILabel = {
        let appTitleLabel : UILabel = UILabel()
        appTitleLabel.font = UI_FONT_20
        appTitleLabel.textColor = UIColor.blackColor()
        return appTitleLabel
    }()
    
    // app 详情
    private lazy var appDetailLabel : UILabel = {
        let appDetailLabel : UILabel = UILabel()
        appDetailLabel.font = UI_FONT_14
        appDetailLabel.textColor = UIColor.darkGrayColor()
        return appDetailLabel
    }()
    
    private func createTitleViwe(title : String) -> UILabel {
        let label : UILabel = UILabel()
        label.font = UIFont.systemFontOfSize(15)
        label.text = title
        label.textColor = UIColor.blackColor()
        self.centerView.addSubview(label)
        return label
    }
    private func createTitleSeparatLine() -> UIView {
        let line : UIView = UIView()
        line.backgroundColor = UIColor.lightGrayColor()
        self.centerView.addSubview(line)
        return line
    }
    // 标题(h2)
    private func createH2TitleLabel() -> UILabel {
        let h2TitleLabel = UILabel()
        h2TitleLabel.textColor = UIColor.blackColor()
        h2TitleLabel.font = UI_FONT_16
        return h2TitleLabel
    }
    
    // 描述(p)
    private func createPTitleLabel() -> YYLabel {
        let contentLabel : YYLabel = YYLabel()
        contentLabel.displaysAsynchronously = true
        contentLabel.font = UI_FONT_16
        contentLabel.textColor = UIColor.darkGrayColor()
        contentLabel.numberOfLines = 0
        return contentLabel
    }
    
    
    // 图片(Img)
    private func createImgView() -> UIImageView {
        let imgView : UIImageView = UIImageView()
        imgView.layer.cornerRadius = 3
        imgView.contentMode = .ScaleAspectFit
        return imgView
    }
    
    // 下载(a)
    private func createATitleButton() -> UIButton {
        let btn : UIButton = UIButton()
        btn.titleLabel?.textAlignment = NSTextAlignment.Left
        btn.titleLabel?.font = UI_FONT_14
        btn.setTitle("点击下载", forState: .Normal)
        btn.setTitleColor(UI_COLOR_APPNORMAL, forState: .Normal)
        return btn
    }


}
