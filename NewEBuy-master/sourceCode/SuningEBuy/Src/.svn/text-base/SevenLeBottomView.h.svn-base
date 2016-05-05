//
//  SevenLeBottomView.h
//  SuningLottery
//
//  Created by yang yulin on 13-4-7.
//  Copyright (c) 2013年 suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OHAttributedLabel.h"

@protocol SevenLeBottomViewDelegate;

@interface SevenLeBottomView : UIView<OHAttributedLabelDelegate>
{
    //注数
    NSInteger   count;
    
    NSString     *resultStr_;
    
    
    
}

@property (nonatomic,weak)id  <SevenLeBottomViewDelegate>bottomDelegate;
@property (nonatomic,strong)UIButton            *garbageButton;
@property (nonatomic,strong)OHAttributedLabel   *selectedNumsLabel;
@property (nonatomic,strong)OHAttributedLabel   *priceLabel;
@property (nonatomic,strong)UIButton            *doneButton;
@property (nonatomic,strong)UIImageView         *backgroundImageView;



- (void)setResultChoice:(NSMutableArray *)ballArr  multiNo:(int)mutiNo periods:(int)periods;

- (NSInteger)getReseultCout:(NSString *)resultString;


@end

@protocol SevenLeBottomViewDelegate <NSObject>

- (void)submit:(NSString *)resultStr;

- (void)reChoose;

@end
