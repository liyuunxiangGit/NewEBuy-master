//
//  VirtualProductSegementView.h
//  SuningEBuy
//
//  Created by xie wei on 13-5-16.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VirtualProductSegementViewDelegate;

typedef enum{
    //手机充值
    sortMobileRecharge = 1,
    //水电煤缴费
    sortWaterElectricityGas
    
} ButtonSort;

@interface VirtualProductSegementView : UIView
{
    id<VirtualProductSegementViewDelegate> __weak _delegate;
}

@property(nonatomic,weak) id<VirtualProductSegementViewDelegate> delegate;

@end

@protocol VirtualProductSegementViewDelegate <NSObject>

- (void)sortBtnPressed:(ButtonSort)btnIndex;

@end
