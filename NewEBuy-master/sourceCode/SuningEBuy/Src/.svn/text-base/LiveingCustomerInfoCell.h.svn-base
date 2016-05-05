//
//  LiveingCustomerInfoCell.h
//  SuningEBuy
//
//  Created by robin wang on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BusinessOrderDetailDTO.h"

@interface LiveingCustomerInfoCell : UITableViewCell
{
    CGFloat offsetForLblY;
}

@property (nonatomic, strong) UILabel *liveEarliestTimerLbl;

@property (nonatomic, strong) UILabel *liveLatestTimerLbl;


@property (nonatomic, strong) BusinessOrderDetailDTO *merchItemDTO;

+ (CGFloat)height:(BusinessOrderDetailDTO *)item;

- (id) initWithReuseIdentifier:(NSString *)reuseIdentifier;

@end
