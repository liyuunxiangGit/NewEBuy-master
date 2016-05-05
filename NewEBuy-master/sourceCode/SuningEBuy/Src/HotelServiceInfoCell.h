//
//  HotelServiceInfoCell.h
//  SuningEBuy
//
//  Created by robin wang on 7/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HotelDetailImageListDTO.h"

@interface HotelServiceInfoCell : UITableViewCell
{

}

@property (nonatomic, strong) UILabel *nameLbl;

@property (nonatomic, strong) UILabel *discribLbl;

@property (nonatomic, strong) HotelDetailImageListDTO *merchItemDTO;

@property (nonatomic, strong) UIImageView *separatorLine;

+ (CGFloat) height:(HotelDetailImageListDTO *)item;

- (id) initWithReuseIdentifier:(NSString *)reuseIdentifier;

@end
