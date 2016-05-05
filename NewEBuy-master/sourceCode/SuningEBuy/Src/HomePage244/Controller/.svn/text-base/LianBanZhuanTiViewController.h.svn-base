//
//  LianBanZhuanTiViewController.h
//  SuningEBuy
//
//  Created by zhangbeibei on 14-9-17.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "ZhuanTiService244.h"
#import "AdActiveRuleCell.h"
#import "LianBanFloorDTO.h"
#import "LBZTTableHeaderView.h"
#import "AdModel6Cell.h"
#import "HomeProductDTO.h"
#import "ProductDetailViewController.h"
#import "SNWebViewController.h"

@interface LianBanZhuanTiViewController : CommonViewController <ZhuanTiServiceDelegate, AdActiveRuleCellDelegate, Model6Delegate> {
    
    //是否有广告图片
    BOOL hasAdImageView;
}

//目标模块ID
@property (nonatomic, copy) NSString *targetModuleID;
@property (nonatomic, strong) ZhuanTiService244      *zhuanTiService;
@property (nonatomic, strong) ZhuanTiDTO    *dataDTO;
@property (nonatomic, assign) SNRouteSource          whereFrom;

//广告文字的高度
@property (nonatomic, assign) CGFloat            AdActiveRuleCellHeight;

@end
