//
//  NProDetailSpotSupportCell.h
//  SuningEBuy
//
//  Created by Kristopher on 14-10-29.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NProDetailSpotSupportCell : UITableViewCell

@property (nonatomic, strong)   UIImageView     *arrowImageV;

@property (nonatomic, strong)   UILabel         *contentLabel;

@property (nonatomic, strong)   UIImageView     *showImageV;

+ (CGFloat)getCellHeight;

@end
