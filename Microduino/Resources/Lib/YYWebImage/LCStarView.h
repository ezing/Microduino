//
//  LCStarView.h
//  StarView
//
//  Created by bawn on 9/15/15.
//  Copyright (c) 2015 bawn. All rights reserved.
//

#import <UIKit/UIKit.h>

// 新建一个协议，协议的名字一般是由“类名+Delegate”
@protocol LCStarViewDelegate <NSObject>

// 代理传值方法
- (void)sendValue:(int)value;

@end

@interface LCStarView : UIView

// 委托代理人，代理一般需使用弱引用(weak)
@property (weak, nonatomic) id<LCStarViewDelegate> delegate;
@property (nonatomic, strong) UIImage *maskImage;
@property (nonatomic, strong) UIImage *borderImage;
@property (nonatomic, strong) UIColor *fillColor;

@end
