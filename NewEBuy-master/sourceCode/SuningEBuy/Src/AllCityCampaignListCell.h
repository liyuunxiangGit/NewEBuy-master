//
//  AllCityCampaignCell.h
//  SuningEBuy
//
//  Created by JackyWu on 14-8-4.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "EGOImageViewEx.h"
#import "StoreCampaignDTO.h"

@interface AllCityCampaignListCell : UITableViewCell

@property (nonatomic, strong) SNUIImageView     *imgView;

@property (nonatomic, strong) UILabel           *label;

@property (nonatomic, strong) UILabel           *campaignNameLbl;

@property (nonatomic, strong) UIImageView       *topView;

@property (nonatomic, strong) UIImageView       *bottomView;

@property (nonatomic, strong) UIImageView       *centerView;

- (void)setItem:(StoreCampaignDTO *)dto;

+ (CGFloat)heightOfCell:(NSString *)campaignDescription;

@end
