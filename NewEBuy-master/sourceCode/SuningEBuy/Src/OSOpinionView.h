//
//  OSOpinionView.h
//  SuningEBuy
//
//  Created by  liukun on 13-12-18.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OSMsgDTO.h"

@class OSOpinionView;
@protocol OSOpinionViewDelegate <NSObject>

@optional
- (void)opinionView:(OSOpinionView *)view didOpinion:(OSOpinionScore)score;

@end

@interface OSOpinionView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UIControl *bgMask;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UILabel *tipLabel1;
@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) UIButton *button2;
@property (nonatomic, strong) UIButton *button3;
@property (nonatomic, strong) UIButton *button4;
@property (nonatomic, strong) UIButton *button5;

@property (nonatomic, strong) UIImageView *markView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) dispatch_block_t completeBlock;

//新增直接退出和继续评价按钮
@property (nonatomic, strong) UIButton *exitButton;
@property (nonatomic, strong) UIButton *continueButton;
@property (nonatomic, strong) UILabel  *tipLabel2;
@property (nonatomic, strong) UIImageView *headFillBar;

@property(nonatomic,assign)  id<OSOpinionViewDelegate>   delegate;

- (void)showInView:(UIView *)view withOption:(int)source;
- (dispatch_block_t)hide:(BOOL)complete;

@end
