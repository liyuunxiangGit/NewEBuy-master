//
//  InvalidProductViewController.h
//  SuningEBuy
//
//  Created by 孔斌 on 14-5-27.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "InvalidProductItemCell.h"
#import "ShopCartV2DTO.h"
#import "ShopCartLogic.h"
#import "ProductDetailService.h"
#import "ShopCartSyncManager.h"

@protocol InvalidProductViewDelegate;

@interface InvalidProductViewController : CommonViewController<ProductDetailServiceDelegate,InvalidProductItemCellDelegate>

//包含了数据和一些逻辑属性
@property (nonatomic, strong) ShopCartLogic *logic;
@property (nonatomic, strong) ShopCartSyncManager *syncManager;

@property (nonatomic, strong) ProductDetailService *pDetailService;

@property (nonatomic, strong) UIButton  *deleteBtn;

@property (nonatomic, strong) UIButton  *allCheckedBtn;

- (instancetype)initWithLogic:(ShopCartLogic *)logic syncManager:(ShopCartSyncManager *)manager;

@end

