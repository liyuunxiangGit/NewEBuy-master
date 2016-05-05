//
//  MyIntegerUnActiveViewController.h
//  SuningEBuy
//
//  Created by shasha on 12-11-8.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyIntegerUnActiveViewController : CommonViewController

@property (nonatomic, assign) BOOL  isBoundPhone;
@property (nonatomic, assign) BOOL  isEmailActivate;

@property (nonatomic, strong) UITableView  *myTableView;
//云钻状态提示信息：1：未激活 2：激活
@property (nonatomic, copy)   NSString  *alertString;
@property (nonatomic, strong) UIView    *activeView;  
@property(nonatomic,strong) UILabel        *descLabel;
@property(nonatomic,strong) UIButton       *activateButton;

@property (nonatomic, copy) NSString  *errorMsg;

- (CGFloat)getDescHeight;

//子类实现的方法
- (void)initAlertInfo;
- (void)initActiveView;
- (void)updateViews;

@end
