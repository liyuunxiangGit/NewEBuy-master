//
//  PruductList244ViewController.h
//  SuningEBuy
//
//  Created by zhangbeibei on 14-9-25.
//  Copyright (c) 2014年 Suning. All rights reserved.
//  商品列表页

#import "PageRefreshTableViewController.h"
#import "ZhuanTiService244.h"
#import "ZhuanTiDTO.h"
#import "AdActiveRuleCell.h"
#import "AdModel4Cell.h"
#import "SolrProductCell.h"
#import "AdModel6Cell.h"
#import "AdModel3Cell.h"
#import "SNWebViewController.h"

@interface PruductList244ViewController : PageRefreshTableViewController <ZhuanTiServiceDelegate, AdActiveRuleCellDelegate, Model4Delegate, Model6Delegate, Model3Delegate> {
    
    //商品列表
    NSMutableArray *tableDataArray;
    
    //当前页数
    int pageIndex;
    
    //此商品集的总页数
    int pageTotalCount;
    
    //是否有广告图片
    BOOL    hasAdImageView;
    
    //是否有广告文字
    BOOL    hasAdDescription;
    
    //是否已经收集过pageTitle
    BOOL    haveColloctedPageTitle;
}

//商品集ID
@property (nonatomic, copy) NSString *targetModuleID;
@property (nonatomic, strong) ZhuanTiService244      *zhuanTiService;
@property (nonatomic, strong) ZhuanTiDTO    *dataDTO;

//广告文字的高度
@property (nonatomic, assign) CGFloat            AdActiveRuleCellHeight;

@property (nonatomic, assign) SNRouteSource          whereFrom;

//接口返回的，当前此商品集的页面模板类型
@property (nonatomic, assign)  int templateID;

@end
