//
//  MYEfubaoViewController.h
//  SuningEBuy
//
//  Created by shasha on 12-8-31.
//  Copyright (c) 2012年 Suning. All rights reserved.
//


/*!
 
 @header   MYEfubaoViewController.h
 @abstract 我的易付宝类，主要获取易付宝余额，提供子类的方法。
 @author   莎莎 
 @version  4.1.6  2012/8/31 Creation 
 */


#import <UIKit/UIKit.h>
#import "EfubaoAccountService.h"

@interface MYEfubaoViewController : CommonViewController<EfubaoAccountServiceDelegate>

@property (nonatomic, strong) UITableView  *myTableView;
//易付宝状态提示信息：1：未激活 2：激活
@property (nonatomic, copy)   NSString  *alertString;
@property (nonatomic, strong) UIView    *activeView;  
@property(nonatomic,strong) UILabel        *descLabel;
@property(nonatomic,strong) UIButton       *activateButton;
/*!
 @abstract      获取用户优惠信息的service。
 @discussion    包括易付宝余额、易购券、云钻等。 
 用户登出的时候设为nil。登录成功的时候，重新请求数据，刷新数据。
 */

@property (nonatomic, strong) EfubaoAccountService  *userDiscountService;


- (CGFloat)getDescHeight;

//子类实现的方法
- (void)initAlertInfo;
- (void)initActiveView;
- (void)updateViews;



@end
