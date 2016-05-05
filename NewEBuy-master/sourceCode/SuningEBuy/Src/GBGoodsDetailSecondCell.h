//
//  GBGoodsDetailSecondCell.h
//  SuningEBuy
//
//  Created by  zhang jian on 13-2-26.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GBGoodsDetailDTO.h"

@interface GBGoodsDetailSecondCell : UITableViewCell

@property (nonatomic, strong) GBGoodsDetailDTO          *gbGoodsDetailDto;

+ (CGFloat)height:(NSString *)textString;

@end
