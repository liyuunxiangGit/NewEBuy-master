//
//  TicketListCell.h
//  SuningEBuy
//
//  Created by shasha on 12-5-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PFOrderBasicDTO;

@protocol TicketListCellDelegate <NSObject>

- (void)cancelOrder:(PFOrderBasicDTO *)dto;
- (void)repayOrder:(PFOrderBasicDTO *)dto;

@end


@interface TicketListCell : UITableViewCell

@property (nonatomic, weak) id  <TicketListCellDelegate>delegate;


- (void)setItem:(PFOrderBasicDTO *)dto;

+ (CGFloat)height:(PFOrderBasicDTO *)dto;

@end
