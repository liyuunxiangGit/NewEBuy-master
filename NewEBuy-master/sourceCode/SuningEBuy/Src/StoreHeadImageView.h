//
//  StoreHeadImageView.h
//  SuningEBuy
//
//  Created by xingxianping on 14-2-13.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreDetailInfoDTO.h"


@interface StoreHeadImageView : UIView

@property (nonatomic, strong) EGOImageView *storeImage;

@property (nonatomic, strong) UIView       *backView;

@property (nonatomic, strong) UILabel      *nameLabel;

@property (nonatomic, strong) StoreDetailInfoDTO  *dto;

- (id)initWithDTO:(StoreDetailInfoDTO *)dto;

@end
