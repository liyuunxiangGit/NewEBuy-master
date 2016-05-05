//
//  PromotionInfoViewController.h
//  SuningEBuy
//
//  Created by huangtf on 12-9-4.
//  Copyright (c) 2012年 Suning. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "PageRefreshTableViewController.h" 
#import "PromotionInfoService.h"


@interface PromotionInfoViewController : PageRefreshTableViewController<PromotionInfoServiceDelegate>
{
    PromotionInfoService *_promotionInfoService;

}


// 资讯是否已加载
@property(nonatomic,assign) BOOL            isInfoLoaded;
// 促销资讯列表
@property(nonatomic,strong) NSMutableArray  *promotionInfoList;

@property(nonatomic,strong) PromotionInfoService *promotionInfoService;

@property(nonatomic,copy) NSString *pageSize;


@end

