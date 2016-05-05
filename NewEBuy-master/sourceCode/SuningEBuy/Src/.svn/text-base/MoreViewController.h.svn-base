//
//  MoreViewController.h
//  SuningEBuy
//
//  Created by 刘坤 on 12-8-28.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "MoreView.h"
#import "ToolBarCell.h"
#import "AddressInfoPickerView.h"
#import "SNShareKit.h"
#import "ChooseShareWayView.h"

@protocol MoreViewControllerDelegate <NSObject>
@optional
- (void)delegate_moreViewController_logout; // 退出登录

@end


@interface MoreViewController : CommonViewController<ToolBarCellDelegate, AddressInfoPickerViewDelegate,ChooseShareWayViewDelegate>
{
    MoreView *_moreView;
    
    ImageQuailty quailtyType;
}

@property (nonatomic, strong)               MoreView                *moreView;
@property (nonatomic, strong)               UIView                  *footView;
@property (nonatomic, strong)               UIButton                *logoutBtn;
@property (nonatomic, strong)               UIImageView             *selectMark;
@property (nonatomic, strong)               SNShareKit              *shareKit;

@property (nonatomic, strong) ChooseShareWayView    *chooseShareWayView; //分享方式

@property (nonatomic,weak) id<MoreViewControllerDelegate> delegate;

- (void)soundControl:(id)sender;
- (void)clearImageMemory:(id)sender;

- (void)share;
@end
