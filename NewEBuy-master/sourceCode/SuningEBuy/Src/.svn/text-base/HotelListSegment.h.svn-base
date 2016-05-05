//
//  HotelListSegment.h
//  SuningEBuy
//
//  Created by Qin on 14-2-8.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomSegment.h"

@protocol HotelListSegmentDelegate <NSObject>

- (void)SearchHotelSortType:(NSString *)sortType sort:(BOOL)sort;

@end




@interface HotelListSegment : UIView<CustomSegmentDelegate>

@property (nonatomic,strong)CustomSegment* segment;
@property (nonatomic,strong)UIImageView* priceDownUpImg;
@property (nonatomic,strong)UIImageView* starDownUpImg;

@property (nonatomic,assign)BOOL priceDownUp;//yes:价格从低到高  no：价格从高到低 【默认：yes】
@property (nonatomic,assign)BOOL starDownUp; //yes： 星级从低到高  no：星级从高到低  【默认 ：yes】

@property (nonatomic, weak) id<HotelListSegmentDelegate> delegate;

@property (nonatomic, copy)   NSString  *sortType;
@property (nonatomic, assign) BOOL      sort;

@end

