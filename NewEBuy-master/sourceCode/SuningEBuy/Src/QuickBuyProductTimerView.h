//
//  QuickBuyProductTimerView.h
//  SuningEBuy
//
//  Created by shasha on 12-1-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupProductColockView.h"
#import "PurchaseConstant.h"
#import "PanicPurchaseDTO.h"

@interface QuickBuyProductTimerView : UIView{

    PanicPurchaseDTO *panicDTO_;
    
    UILabel      *calenderTip_;

    UILabel      *subCount_;
}

@property(nonatomic, strong) PanicPurchaseDTO     *panicDTO;
@property(nonatomic, strong) UILabel       *calenderTip;
@property(nonatomic, strong) UILabel       *subCount;

@property (nonatomic, strong) GroupProductColockView *colockView;

- (void)setItem:(PanicPurchaseDTO *)panic;

- (void)setTime:(NSTimeInterval)seconds;


- (void)reloadView;

@end
