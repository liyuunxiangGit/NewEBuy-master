//
//  AddCouponViewController.h
//  SuningEBuy
//
//  Created by  liukun on 13-12-24.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CommonViewController.h"

@class AddCouponViewController;
@protocol AddCouponDelegate <NSObject>

@optional
- (void)addCouponDidOk:(AddCouponViewController *)vc;

@end

@interface AddCouponViewController : CommonViewController

@property (nonatomic, assign) id<AddCouponDelegate> delegate;

@end
