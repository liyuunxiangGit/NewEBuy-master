//
//  BusinessContactInfoCell.h
//  SuningEBuy
//
//  Created by robin wang on 7/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BusinessOrderDetailDTO.h"

@interface BusinessContactInfoCell : UITableViewCell
{

}

@property (nonatomic, strong) UILabel *nameLbl;

@property (nonatomic, strong) UILabel *phoneNumberLbl;


@property (nonatomic, strong) BusinessOrderDetailDTO *merchItemDTO;

+ (CGFloat)height:(BusinessOrderDetailDTO *)item;

- (id) initWithReuseIdentifier:(NSString *)reuseIdentifier;
@end
