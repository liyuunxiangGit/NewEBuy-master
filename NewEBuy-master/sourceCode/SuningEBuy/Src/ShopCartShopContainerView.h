//
//  ShopCartShopContainerView.h
//  SuningEBuy
//
//  Created by  liukun on 13-10-16.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopCartItemCell.h"
#import "ShopCartShopDTO.h"

@interface ShopCartShopContainerView : UITableView
<UITableViewDataSource, UITableViewDelegate, ShopCartItemCellDelegate>


@property (nonatomic, strong) ShopCartShopDTO *shopDTO;

+ (CGFloat)height:(ShopCartShopDTO *)shopDTO;

@end
