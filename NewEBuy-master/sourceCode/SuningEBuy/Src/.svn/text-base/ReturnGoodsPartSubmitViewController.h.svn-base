//
//  ReturnGoodsPartSubmitViewController.h
//  SuningEBuy
//
//  Created by zl on 14-10-21.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "AllOrderDetailCommonViewController.h"
#import "ReturnPartPicViewCell.h"
#import "ReturnGoodsPicService.h"
#import "ReturnGoodsPicDTO.h"
#import "BMKLocationService.h"
#import "BMKGeoCodeSearch.h"
#import "AddressInfoDAO.h"
#import "NearStoreService.h"
#import "ReturnGoodsApplicationService.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import "ReturnGoodsNumberViewCell.h"


@interface ReturnGoodsPartSubmitViewController : AllOrderDetailCommonViewController<BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,NearStoreServiceDelegate,ReturnGoodsApplicationServiceDelegate,ReturnGoodsNumberCellDelegate>
{
    BOOL                    _isGetOnlineStatusOk;
    int                     _onlineStatus;
    UIWebView               *_callWebView;
}
@property (nonatomic, strong)NSArray                    *reasonList;
@property (nonatomic, strong)NSString                   *proPrice;
@property (nonatomic, strong)NSString                   *productCode;
@property (nonatomic, strong)NSArray                    *headList;
@property (nonatomic, strong)ReturnGoodsPrepareDTO      *prepareDto;
@property (nonatomic, assign)BOOL                       isCShopProduct;//传值
@property (nonatomic, strong)NSString    *distribution;//配送方式
@property (nonatomic, strong)NSString    *taxType;//发票类型
@property (nonatomic, strong)NSString    *shopAddress;//自提门店地址
@property (nonatomic, strong)NSString    *returnType;
@property (nonatomic, strong)NSString     *reasonDes;//退货原因
@property (nonatomic, strong)NSString     *reasonId;
@property (nonatomic, assign)ReturnGoodsAppraisal returnGoodsAppraisal;
@property (nonatomic, strong)ReturnGoodsPicService* picHttp;
@property (nonatomic, strong)BMKLocationService        *bmkLocationService;
@property (nonatomic, strong)BMKGeoCodeSearch          *bmkGeoCodeSearch;
@property (nonatomic, assign)CLLocationCoordinate2D            userLocation;
@property (nonatomic, strong) NearStoreService          *nearStoreService;
@property (nonatomic ,strong)ReturnGoodsApplicationService *service;
@end
