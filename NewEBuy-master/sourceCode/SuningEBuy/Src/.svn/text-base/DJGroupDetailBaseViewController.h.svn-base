//
//  DJGroupDetailBaseViewController.h
//  SuningEBuy
//
//  Created by xie wei on 13-7-11.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "PageRefreshTableViewController.h"
#import <UIKit/UIKit.h>
#import "SNShareKit.h"
#import "DJGroupDetailSegmentView.h"
#import "DJGroupDetailIntroduceView.h"
#import "AuthManagerNavViewController.h"
#import "ProductCommandDelegate.h"

@interface DJGroupDetailBaseViewController : PageRefreshTableViewController <DJGroupDetailSegmentViewDelegate,IntroduceViewDelegate,ProductCommandDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) SNShareKit *shareKit;  //分享控制器
@property (nonatomic, strong) DJGroupDetailSegmentView *segmentView;
@property (nonatomic, strong) DJGroupDetailIntroduceView *introduceView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *introduceContentView;
@property (nonatomic, strong) UIView *appraisalContentView;
@property (nonatomic, strong) UITableView *appraisalTableView;
@property (nonatomic, strong) UIScrollView *backScrollView;


- (CGRect)getContentFrame;
@end
