//
//  ArrangeBottomView.h
//  SuningLottery
//
//  Created by yangbo on 4/6/13.
//  Copyright (c) 2013 suning. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ArrangeSelectBottomViewDelegate <NSObject>

//确定投注
- (void)submit;

//清空号码
- (void)clear;

@end


@interface ArrangeSelectBottomView : UIView
{
    UILabel *_numberLabel;      //显示号码label
    
    UILabel *_moneyLabel;        //显示投注金额label
    
    id <ArrangeSelectBottomViewDelegate> __weak _delegate;
}

@property (nonatomic, weak) id <ArrangeSelectBottomViewDelegate> delegate;

/*
 bet: 注数  multiple:倍数 periods:追号期数 price:每注价格 number:投注号码
 */
- (void)setBets:(int)bet
       multiple:(int)multiple
        periods:(int)periods
          price:(int)price
   numberString:(NSString *)number;

@end
