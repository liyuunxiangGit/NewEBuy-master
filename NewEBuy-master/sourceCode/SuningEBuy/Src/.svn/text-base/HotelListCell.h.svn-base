//
//  HotelListCell.h
//  SuningEBuy
//
//  Created by jian  zhang on 12-7-2.
//  Copyright (c) 2012年 nanjing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotelListDTO.h"

#import "HotelStarView.h"
#import "OHAttributedLabel.h"

@interface HotelListCell : UITableViewCell<EGOImageViewDelegate,EGOImageViewExDelegate>

{
    
}

//@property (nonatomic, strong) EGOImageViewEx              *hotelImage;
@property(nonatomic,  strong) EGOImageButton    *hotelImage;     //酒店图片

@property (nonatomic, strong) UILabel                     *hotelName;
@property (nonatomic, strong) UILabel                     *hotelAdds;
@property (nonatomic, strong) OHAttributedLabel           *price;
@property (nonatomic, strong) HotelStarView               *evaluationView;
@property (nonatomic, strong) UIImageView                 *lineView;
@property (nonatomic, strong) UIImageView                 *arrowImgView;
@property (nonatomic, strong) HotelListDTO                *item;


- (void)setItem:(HotelListDTO *)aItem;

- (void)setDiscountAttrText:(NSString *)orderPrice;


@end
