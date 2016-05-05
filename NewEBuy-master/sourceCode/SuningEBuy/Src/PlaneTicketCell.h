//
//  PlaneTicketCell.h
//  SuningEBuy
//
//  Created by david on 14-2-17.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TicketDetailDTO.h"

@interface PlaneTicketCell : UITableViewCell

+(CGFloat)height:(TicketDetailDTO *)dto;

-(void)refreshCell:(TicketDetailDTO *)dto;

@end
