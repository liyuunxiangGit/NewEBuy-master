//
//  ReturnGoodsQueryViewController.h
//  SuningEBuy
//
//  Created by 漫 王 on 12-9-28.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "PageRefreshTableViewController.h"
#import "AllOrderListViewController.h"

#import "ReturnGoodsQueryService.h"
#import "CShopChooseExpressListViewController.h"

@interface ReturnGoodsQueryViewController : AllOrderListViewController<ReturnGoodsQueryServiceDelegate>
{
    BOOL                  isRequestOK;
    
    NSMutableArray        *_returnGoodsQueryList;
    
    UILabel               *_emptyLabel;
    
    ReturnGoodsQueryService *service;
     NSArray                    *_expressList;
}

@property (nonatomic, strong)NSMutableArray      *returnGoodsQueryList;

@property (nonatomic,strong) UIImageView *alertImageV;

@property (nonatomic, strong)UILabel             *emptyLabel;
@property  (nonatomic, strong) NSArray           *expressList;

@property (nonatomic, strong)ReturnGoodsQueryDTO   *returnGoodsDto;


-(void)refreshData;
- (void)updateTable;
@end
