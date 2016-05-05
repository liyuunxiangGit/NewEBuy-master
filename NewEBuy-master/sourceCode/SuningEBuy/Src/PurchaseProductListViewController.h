//
//  PurchaseProductListViewController.h
//  SuningEBuy
//
//  Created by cui zl on 13-6-15.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonViewController.h"
#import "PurchaseService.h"
#import "Calculagraph.h"
#import "PurchaseItemCell.h"
#import "PageRefreshTableViewController.h"
#import "CustomSegment.h"
#import "PurchaseTimeItemCell.h"

@interface PurchaseProductListViewController :PageRefreshTableViewController<PurchaseServiceDelegate,CustomSegmentDelegate>//,PurchaseItemCellDelegate>
{
//    BOOL isShowBigList;
//    BOOL isClik;
    int  listType;//1代表没有时间条，2代表有
}

@property (nonatomic, strong) PurchaseService *service;

@property (nonatomic, strong) NSMutableArray             *purchaseList;
@property (nonatomic, strong) Calculagraph               *calculagraph;
@property (nonatomic, strong) PanicPurchaseDTO           *selectPurchaseDto;

@property (nonatomic, strong) CustomSegment              *segment;

@property (nonatomic, strong) NSMutableArray                    *titleArr;
@property (nonatomic, strong) NSMutableArray                    *codeArr;


//@property (nonatomic, strong) UIButton                   *navItemButton;
//@property (nonatomic ,strong) UIImageView                *purchaseBackImage;
//@property (nonatomic, strong) UIImageView                *accessImg;
//@property (nonatomic, strong) UIButton                   *defaultNameButton;

@end
