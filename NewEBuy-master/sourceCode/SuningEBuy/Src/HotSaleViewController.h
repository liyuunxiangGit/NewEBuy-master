//
//  HotSaleViewController.h
//  SuningEBuy
//
//  Created by 漫 王 on 12-8-28.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "CommonViewController.h"

#import "InterestProductService.h"

@interface HotSaleViewController : CommonViewController<InterestProductServiceDelegate>
{
    BOOL                _isShowThumbnails;
    
    InterestProductService  *service;
    
    BOOL                isHotSaleLoaded;
    
}

@end
