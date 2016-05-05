//
//  GBGoodsAddressViewController.h
//  SuningEBuy
//
//  Created by  zhang jian on 13-2-27.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GBShopsListDTO.h"

@interface GBGoodsAddressViewController : CommonViewController<UIActionSheetDelegate>

@property (nonatomic, copy) NSString   *tuanType;  //区分是否酒店
@property (nonatomic, strong) NSArray                           *gbShopsList;


@end
