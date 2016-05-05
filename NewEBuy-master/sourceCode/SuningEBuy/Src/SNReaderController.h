//
//  SNReaderController.h
//  SuningEBuy
//
//  Created by 刘坤 on 12-8-27.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

/*!
 @header      SNReaderController
 @abstract    条码扫描的控制器
 @author      刘坤
 @version     v2.0  12-10-25
 @discussion  12-10-25 添加二维码搜索
 */

#import <Foundation/Foundation.h>
#import "ProductDetailService.h"
#import "SearchListService.h"
#import "EightBannerADService.h"
#import "NewManualInputViewController.h"
#import "SNRouter.h"
#import "PurchaseService.h"

@interface SNReaderController : NSObject
<ManualInputDelegate, SearchListServiceDelegate, ProductDetailServiceDelegate,
EightBannerADServiceDelegate,PurchaseServiceDelegate>
{
    UIViewController *__weak _contentController;
}

@property (nonatomic, weak) UIViewController *contentController;
@property (nonatomic, strong) SearchListService *isbnService;
@property (nonatomic, strong) ProductDetailService *productService;//商品详情;

/*!
 @method        initWithContentController:
 @abstract      初始化方法，必须使用该方法初始化
 @param         controller  调用的viewController
 */
- (id)initWithContentController:(UIViewController *)controller;


/*!
 @method        beginReader
 @abstract      开始条码或二维码扫描
 */
- (void)beginReader;

@end
