//
//  ReturnGoodsListViewController.h
//  SuningEBuy
//
//  Created by 漫 王 on 12-9-29.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "PageRefreshTableViewController.h"
#import "ReturnGoodsListService.h"
#import "ReturnGoodsApplicationService.h"
#import "ReturnGoodsPrepareDTO.h"
#import "CShopReturnApplicationService.h"
#import "CShopReturngoodsSegementView.h"
#import "CustomSegment.h"
#import "ReturnGoodsQueryViewController.h"

@interface ReturnGoodsListViewController : PageRefreshTableViewController
<ReturnGoodsListServiceDelegate,ReturnGoodsApplicationServiceDelegate,CShopReturnGoodsApplicationServiceDelegate,CShopReturngoodsSegementViewDelegate,CustomSegmentDelegate>
{    
    NSMutableArray        *_returnGoodsList;
    
    BOOL                  isRequestOK;
    
    UILabel               *_emptyLabel;
    
    ReturnGoodsListService *_service;
    
    ReturnGoodsApplicationService *_applianceService;
    CShopReturnApplicationService *_cShopApplianceService;
        
    ReturnGoodsPrepareDTO      *_prepareDto;
    
    NSArray                    *_reasonList;
}

@property  (nonatomic, strong) NSMutableArray *returnGoodsList;

@property  (nonatomic ,strong) UILabel        *emptyLabel;

@property  (nonatomic, strong) ReturnGoodsPrepareDTO      *prepareDto;

@property  (nonatomic, strong) NSArray                    *reasonList;


@property (nonatomic, strong) ReturnGoodsListService *service;
@property (nonatomic, strong) ReturnGoodsApplicationService *applianceService;
@property (nonatomic, strong) ReturnGoodsQueryViewController   *hotKeywordsController;    
@property (nonatomic, strong) CShopReturnApplicationService *cShopApplianceService;
//@property (nonatomic, strong) CustomSegment *segment;
//@property(nonatomic,strong) CShopReturngoodsSegementView *topSortView;

@property(nonatomic)     NSInteger     checkRow;
@property(nonatomic)     NSString     *proCode;
@property(nonatomic)     NSString     *proPrice;
@property(nonatomic)     NSInteger     returnRow;

@property  (nonatomic, strong) NSMutableArray                    *proList;
@property  (nonatomic, strong) NSArray                    *headList;
@property (nonatomic, strong)NSString *payWay;
@property (nonatomic, assign) BOOL             isCShopProduct;//传值
@property (nonatomic, strong) NSString    *taxType;//发票类型
@property (nonatomic, strong) NSString    *shopAddress;//自提门店地址
@property (nonatomic, strong) NSString    *distribution;//配送方式

- (void)updateTable;

@end
