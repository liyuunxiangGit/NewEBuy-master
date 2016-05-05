//
//  SecondPageViewController.h
//  SuningEBuy
//
//  Created by zhangbeibei on 14-9-28.
//  Copyright (c) 2014年 Suning. All rights reserved.
//  页面集，数据和首页一样，都是一些楼层信息

#import "CommonViewController.h"
#import "HomePageService244.h"
#import "HomeFloorTableViewCell.h"
#import "BrandRecommend244.h"
#import "ShopRecommend244.h"    
#import "EightBannerView244.h"
#import "Floor12View.h"
#import "SalePromotionViewController.h"
#import "PruductList244ViewController.h"
#import "LianBanZhuanTiViewController.h"

@interface SecondPageViewController : CommonViewController <HomePageService244Delegate, EightBannerViewDelegate, HomeFloorTableViewCellDelegate> {
    
    //楼层数据列表
    NSMutableArray          *floorDataArray;
}

@property (nonatomic, strong) HomePageService244     *homePageService;

//页面集ID
@property (nonatomic, copy)  NSString       *pageID;

@end
