//
//  NearbySuningShopListCell.h
//  SuningEBuy
//
//  Created by Kristopher on 14-7-31.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NearbySpotStoreDTO.h"

@protocol NearbySpotStoreCellDelegate <NSObject>

- (void)gotoShopCartWithPickupStoreInfo:(NearbySpotStoreDTO *)store;

@end

@interface NearbySpotStoreCell : UITableViewCell

@property (nonatomic, strong) UILabel               *shopNameLbl;

@property (nonatomic, strong) UILabel               *addressLbl;

@property (nonatomic, strong) UILabel               *distanceLbl;

@property (nonatomic, strong) UIButton              *pickupBtn;

@property (nonatomic, strong) NearbySpotStoreDTO    *spotStoreDTO;

@property (nonatomic, strong) UIImageView           *positionImage;

@property (nonatomic, strong) UIImageView           *backView;

@property (nonatomic, weak) id<NearbySpotStoreCellDelegate> delegate;

- (void)setItem:(NearbySpotStoreDTO *)dto;

+ (CGFloat)heightOfCell:(NSString *)storeAddress;

@end

