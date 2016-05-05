//
//  NBNearbyTableCell.h
//  suningNearby
//
//  Created by suning on 14-7-29.
//  Copyright (c) 2014年 suning. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NBYStickItemDTO;

@protocol NBNearbyTableCellDelegate <NSObject>
@optional
// 1评论，2打赏，3举报
- (void)delegate_NBNearbyTableCell_operetion:(int)operation
                                        item:(NBYStickItemDTO *)itemDto;
@end

@interface NBNearbyTableCell : UITableViewCell

@property (nonatomic,assign) BOOL bInit;

@property (nonatomic,weak) id<NBNearbyTableCellDelegate> delegate;

@property (nonatomic,strong) NBYStickItemDTO *dto;


// 0 == templateType,height = 320.0f 图集 晒单
// 1 == templateType,height = 280.0f 商家(活动、促销)

+ (NBNearbyTableCell *)cellWithTemplate:(int)templateType;

@end
