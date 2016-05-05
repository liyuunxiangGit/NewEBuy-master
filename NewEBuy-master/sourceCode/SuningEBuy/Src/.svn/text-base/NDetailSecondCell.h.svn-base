//
//  NDetailSecondCell.h
//  SuningEBuy
//
//  Created by xmy on 13/12/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RuleCopyTextView.h"
#import "DataProductBasic.h"
@class NDetailSecondCell;

@protocol NDetailSecondCellDelegate <NSObject>

- (void)foldBtnActionDetagete:(BOOL)isFold;

@end


@interface NDetailSecondCell : UITableViewCell
{
    BOOL _isFold;//是否展开
}
@property (nonatomic,assign)id<NDetailSecondCellDelegate>delegate;

@property (nonatomic,retain)DataProductBasic *dataDTO;

@property (nonatomic,retain)RuleCopyTextView *sellerPointText;

@property (nonatomic,retain)UIButton *foldBtn;

@property (nonatomic,retain)UIImageView *singleLineImg;

- (void)setNDetailSeconfCellInfo:(DataProductBasic*)dto;

+ (CGFloat)NDetailSecondCellHeight:(DataProductBasic *)dto WithBool:(BOOL)isFold;

@end
