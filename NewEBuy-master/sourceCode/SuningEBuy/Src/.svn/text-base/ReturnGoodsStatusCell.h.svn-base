//
//  ReturnGoodsStatusCell.h
//  SuningEBuy
//
//  Created by 漫 王 on 12-9-29.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReturnGoodsStatusDTO.h"
#import "ReturnGoodsQueryDTO.h"
//退货详情
@interface ReturnGoodsStatusCell : UITableViewCell
{
    UILabel              *_time;
    
    UILabel              *_record;
    
    ReturnGoodsQueryDTO  *_item;    
}

@property (nonatomic ,strong) UILabel              *time;

@property (nonatomic ,strong) UILabel              *record;

@property (nonatomic ,strong) ReturnGoodsQueryDTO  *item; 

@property (nonatomic, strong) UIImageView          *statusLine;

@property (nonatomic, strong) UIImageView          *statusPoint;



+ (CGFloat)height:(ReturnGoodsStatusDTO *)dto;
- (void)setReturnTimeAndRecord:(ReturnGoodsStatusDTO *)dto1 WithRow:(int)row;

@end
