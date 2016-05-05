//
//  PlaneOrderInfoCell.h
//  SuningEBuy
//
//  Created by david on 14-2-17.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PFOrderDetailDTO.h"

@interface PlaneOrderInfoCell : UITableViewCell

+(CGFloat)height;

-(void)refreshCell:(PFOrderDetailDTO *)dto;

@end
