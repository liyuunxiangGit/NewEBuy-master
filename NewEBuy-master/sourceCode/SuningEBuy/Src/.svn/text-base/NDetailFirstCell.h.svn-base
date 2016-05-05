//
//  NDetailFirstCell.h
//  SuningEBuy
//
//  Created by xmy on 2/1/14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataProductBasic.h"
@class NDetailFirstCell;
@protocol NDetailFirstCellDelegate <NSObject>

- (void)addToFavorite;

@end


@interface NDetailFirstCell : UITableViewCell

@property (nonatomic, assign)id<NDetailFirstCellDelegate>delegate;

@property (nonatomic, retain)UILabel *productNameLbl;//商品名

@property (nonatomic, retain)UIButton *collectBtn; //   收藏按钮

@property (nonatomic, strong) UIButton  *shareBtn; // 分享按钮

@property (nonatomic, retain)UIImageView *proNameBackView;

//type 1为普通 2为抢购 3为团购
- (void)setNDetailFirstCell:(DataProductBasic*)dto WithCollectFlag:(NSString*)collectFlag WithType:(int)type;

//+ (CGFloat)NDetailFirstCelllHeight:(DataProductBasic*)dataDto;

@end
