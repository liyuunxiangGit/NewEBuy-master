//
//  GBOrderShopListViewController.h
//  SuningEBuy
//
//  Created by 王 漫 on 13-3-6.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonViewController.h"
#import "GBShopDTO.h"
#import "GBOrderShopInfoCell.h"
#import "AllOrderDetailCommonViewController.h"

@interface GBOrderShopListViewController : AllOrderDetailCommonViewController<UIActionSheetDelegate>
{
    NSMutableArray *_shopList;
}
@property (nonatomic,strong)NSMutableArray *shopList;
-(id)initWithShopList:(NSMutableArray *)shopList;
@end
