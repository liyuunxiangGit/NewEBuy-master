//
//  ZhuanTiService244.m
//  SuningEBuy
//
//  Created by zhangbeibei on 14-9-19.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "ZhuanTiService244.h"

#import "TopADInfoDTO.h"
#import "HomeModuleDTO.h"
#import "LianBanFloorDTO.h"
#import "HomeProductDTO.h"

@implementation ZhuanTiService244


- (void)dealloc {
    
    HTTPMSG_RELEASE_SAFELY(cuXiaoHttpMsg);
    HTTPMSG_RELEASE_SAFELY(lianBanHttpMsg);
    HTTPMSG_RELEASE_SAFELY(productListHttpMsg);
}

- (void)queryCuXiaoZhuanTiWithID:(NSString *)cuxiaoID {
    
    if (IsStrEmpty(cuxiaoID)) {
        return;
    }
    
//    NSString *url = @"http://mpre.cnsuning.com/wapdata/promotion/get_S1057.html";
    NSString *url = [NSString stringWithFormat:@"%@wapdata/promotion/get_%@.html", KNewHomeAPIURL, cuxiaoID];
    
    HTTPMSG_RELEASE_SAFELY(cuXiaoHttpMsg);
    
    cuXiaoHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                 requestUrl:url
                                                postDataDic:nil
                                                    cmdCode:CC_CuXiaoZhuanTi];
    cuXiaoHttpMsg.requestMethod = RequestMethodGet;
    
    [self.httpMsgCtrl sendHttpMsg:cuXiaoHttpMsg];
}


- (void)queryLianBanZhuanTiWithID:(NSString *)broadcastID {
    
    if (IsStrEmpty(broadcastID)) {
        return;
    }
    
//    NSString *url = @"http://mpre.cnsuning.com/wapdata/broadcast/get_S1012.html";
    NSString *url = [NSString stringWithFormat:@"%@wapdata/broadcast/get_%@.html", KNewHomeAPIURL, broadcastID];
    
    HTTPMSG_RELEASE_SAFELY(lianBanHttpMsg);
    
    lianBanHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                               requestUrl:url
                                              postDataDic:nil
                                                  cmdCode:CC_LianBanZhuanTi];
    lianBanHttpMsg.requestMethod = RequestMethodGet;
    
    [self.httpMsgCtrl sendHttpMsg:lianBanHttpMsg];
}


- (void)queryProductListWithModuleID:(NSString *)moduleID pageNum:(int )pageNum pageSize:(int )pageSize {
    
    if (IsStrEmpty(moduleID)) {
        return;
    }
    
//    NSString *url = @"http://api.mpre.cnsuning.com/wapdata/product/get_S2342_1.html";
    NSString *url = [NSString stringWithFormat:@"%@wapdata/product/get_%@_%d.html", KNewHomeAPIURL, moduleID, pageNum > 0 ? pageNum : 1];
    
    HTTPMSG_RELEASE_SAFELY(productListHttpMsg);
    
    productListHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                requestUrl:url
                                               postDataDic:nil
                                                   cmdCode:CC_ShangPinLieBiao];
    productListHttpMsg.requestMethod = RequestMethodGet;
    
    [self.httpMsgCtrl sendHttpMsg:productListHttpMsg];
}


#pragma mark -HttpMessageDelegate
- (void)receiveDidFailed:(HttpMessage *)receiveMsg {
    
    if (receiveMsg.responseStatusCode == 0) {
        self.errorMsg = L(@"NWFailTryLater");
    }
    else if (receiveMsg.responseStatusCode > 400) {
        self.errorMsg = L(@"NWBusyTryLater");
    }
    
    [self parseResultDTO:nil isSuccess:NO];
    
//    switch (receiveMsg.cmdCode) {
//        case CC_CuXiaoZhuanTi: {
//            [self parseCuXiaoResultDTO:nil isSuccess:NO];
//            break;
//        }
//        case CC_LianBanZhuanTi: {
//            [self parseLianBanResultDTO:nil isSuccess:NO];
//            break;
//        }
//        case CC_ShangPinLieBiao: {
//            [self parseProductListResultDTO:nil isSuccess:NO];
//            break;
//        }
//        default:
//            break;
//    }
}


- (void)receiveDidFinished:(HttpMessage *)receiveMsg {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        switch (receiveMsg.cmdCode) {
            case CC_CuXiaoZhuanTi: {
                [self parseCuXiaoMessage:receiveMsg];
                break;
            }
            case CC_LianBanZhuanTi: {
                [self parseLianBanMessage:receiveMsg];
                break;
            }
            case CC_ShangPinLieBiao: {
                [self parseProductListMessage:receiveMsg];
                break;
            }
            default:
                break;
        }
    });
}

- (void)parseProductListMessage:(HttpMessage *)receiveMsg {
    
    NSDictionary *jsonObject = receiveMsg.jasonItems;
    if (NotNilAndNull(jsonObject)) {
        
        NSString *resultCode = [receiveMsg.jasonItems objectForKey:@"code"];
        if ([resultCode isEqualToString:@"0"]) {
            //成功
            NSDictionary *data = (NSDictionary *)[receiveMsg.jasonItems objectForKey:@"data"];
            if (NotNilAndNull(data)) {
                ZhuanTiDTO *dto = [[ZhuanTiDTO alloc] init];
                dto.subjectName = EncodeStringFromDic(data, @"subjectname");
                dto.templateID = EncodeStringFromDic(data, @"templateid");
                
                NSDictionary *adInfo = (NSDictionary *)[data objectForKey:@"topadinfo"];
                
                if (NotNilAndNull(adInfo)) {
                    TopADInfoDTO *adDTO = [[TopADInfoDTO alloc] init];
                    [adDTO parseFromDict:adInfo];
                    adDTO.activityInfo = EncodeStringFromDic(adInfo, @"adcontent");
                    dto.topAD = adDTO;
                }
                
                //处理分页
                NSString *page = (NSString *)[data objectForKey:@"totalpagenum"];
                if (!IsStrEmpty(page)) {
                    dto.totalPageNum = page;
                }
                
                NSMutableArray *productList = (NSMutableArray *)[data objectForKey:@"productlist"];
                if (!IsArrEmpty(productList)) {
                    NSMutableArray *productResultArray = [[NSMutableArray alloc] initWithCapacity:[productList count]];
                    
                    @autoreleasepool {
                        for (int i = 0; i < [productList count]; i++) {
                            HomeProductDTO *dto = [[HomeProductDTO alloc] init];
                            [dto parseFromDict:(NSDictionary *)[productList objectAtIndex:i]];
                            
                            [productResultArray addObject:dto];
                        }
                    }
                    
                    dto.dataArray = productResultArray;
                }
                
                //解析结束
                [self parseResultDTO:dto isSuccess:YES];
            }
            else {
                //异常情况
                @throw L(@"TopicsDataNull");
                self.errorMsg = L(@"PVErrorOccur");
                [self parseResultDTO:nil isSuccess:NO];
            }
        }
        else {
            //错误码
            NSString *errorMsg = (NSString *)[receiveMsg.jasonItems objectForKey:@"msg"];
            self.errorMsg = NotNilAndNull(errorMsg) ? errorMsg : L(@"PVErrorOccur");
            [self parseResultDTO:nil isSuccess:NO];
        }
        
    }
    else {
        //异常情况
        @throw L(@"ProductListJsonNull");
        self.errorMsg = L(@"PVErrorOccur");
        [self parseResultDTO:nil isSuccess:NO];
    }

}

- (void)parseLianBanMessage:(HttpMessage *)receiveMsg {
    
    NSDictionary *jsonObject = receiveMsg.jasonItems;
    if (NotNilAndNull(jsonObject)) {
        
        NSString *resultCode = [receiveMsg.jasonItems objectForKey:@"code"];
        if ([resultCode isEqualToString:@"0"]) {
            //成功
            NSDictionary *data = (NSDictionary *)[receiveMsg.jasonItems objectForKey:@"data"];
            if (NotNilAndNull(data)) {
                ZhuanTiDTO *dto = [[ZhuanTiDTO alloc] init];
                dto.subjectName = EncodeStringFromDic(data, @"subjectname");
                dto.templateID = EncodeStringFromDic(data, @"templateid");
                
                NSDictionary *adInfo = (NSDictionary *)[data objectForKey:@"topadinfo"];
                
                if (NotNilAndNull(adInfo)) {
                    TopADInfoDTO *adDTO = [[TopADInfoDTO alloc] init];
                    [adDTO parseFromDict:adInfo];
                    //add by zhangbeibei:20141021 连版专题的广告规则字段是activityintro,商品集、促销专题的接口返回的都不一样，需要单独处理。
                    adDTO.activityInfo = EncodeStringFromDic(adInfo, @"activityintro");
                    
                    dto.topAD = adDTO;
                }
                
                NSMutableArray *floorList = (NSMutableArray *)[data objectForKey:@"floorlist"];
                if (!IsArrEmpty(floorList)) {
                    NSMutableArray *floorResultArray = [[NSMutableArray alloc] initWithCapacity:[floorList count]];
                    
                    for (int i = 0; i < [floorList count]; i++) {
                        LianBanFloorDTO *dto = [[LianBanFloorDTO alloc] init];
                        [dto parseFromDict:(NSDictionary *)[floorList objectAtIndex:i]];
                        
                        [floorResultArray addObject:dto];
                    }
                    
                    dto.dataArray = floorResultArray;
                }
                
                //解析结束
                [self parseResultDTO:dto isSuccess:YES];
            }
            else {
                //异常情况
                @throw L(@"TopicsDataNull");
                self.errorMsg = L(@"PVErrorOccur");
                [self parseResultDTO:nil isSuccess:NO];
            }
        }
        else {
            //错误码
            NSString *errorMsg = (NSString *)[receiveMsg.jasonItems objectForKey:@"msg"];
            self.errorMsg = NotNilAndNull(errorMsg) ? errorMsg : L(@"PVErrorOccur");
            [self parseResultDTO:nil isSuccess:NO];
        }
        
    }
    else {
        //异常情况
        @throw L(@"TopicsJsonNull");
        self.errorMsg = L(@"PVErrorOccur");
        [self parseResultDTO:nil isSuccess:NO];
    }
}

- (void)parseCuXiaoMessage:(HttpMessage *)receiveMsg {
    
    NSDictionary *jsonObject = receiveMsg.jasonItems;
    if (NotNilAndNull(jsonObject)) {
        
        NSString *resultCode = [receiveMsg.jasonItems objectForKey:@"code"];
        if ([resultCode isEqualToString:@"0"]) {
            //成功
            NSDictionary *data = (NSDictionary *)[receiveMsg.jasonItems objectForKey:@"data"];
            if (NotNilAndNull(data)) {
                ZhuanTiDTO *dto = [[ZhuanTiDTO alloc] init];
                dto.subjectName = EncodeStringFromDic(data, @"subjectname");
                dto.templateID = EncodeStringFromDic(data, @"templateid");
                
                NSDictionary *adInfo = (NSDictionary *)[data objectForKey:@"topadinfo"];

                if (NotNilAndNull(adInfo)) {
                    TopADInfoDTO *adDTO = [[TopADInfoDTO alloc] init];
                    [adDTO parseFromDict:adInfo];
                    
                    dto.topAD = adDTO;
                }
                
                NSMutableArray *moduleList = (NSMutableArray *)[data objectForKey:@"modulelist"];
                if (!IsArrEmpty(moduleList)) {
                    NSMutableArray *moduleResultArray = [[NSMutableArray alloc] initWithCapacity:[moduleList count]];
                    @autoreleasepool {
                        for (int i = 0; i < [moduleList count]; i++) {
                            HomeModuleDTO *module = [[HomeModuleDTO alloc] init];
                            [module parseFromDict:(NSDictionary *)[moduleList objectAtIndex:i]];
                            
                            [moduleResultArray addObject:module];
                        }
                    }
                    dto.dataArray = moduleResultArray;
                }
                
                //解析结束
                [self parseResultDTO:dto isSuccess:YES];
            }
            else {
                //异常情况
                @throw L(@"PromotionTopicsDataNull");
                self.errorMsg = L(@"PVErrorOccur");
                [self parseResultDTO:nil isSuccess:NO];
            }
        }
        else {
            //错误码
            NSString *errorMsg = (NSString *)[receiveMsg.jasonItems objectForKey:@"msg"];
            self.errorMsg = NotNilAndNull(errorMsg) ? errorMsg : L(@"PVErrorOccur");
            [self parseResultDTO:nil isSuccess:NO];
        }

    }
    else {
        //异常情况
        @throw L(@"PromotionTopicsJsonNull");
        self.errorMsg = L(@"PVErrorOccur");
        [self parseResultDTO:nil isSuccess:NO];
    }
}

- (void)parseResultDTO:(ZhuanTiDTO *)dto isSuccess:(BOOL)flag {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (_delegate && [_delegate respondsToSelector:@selector(zhuanTiServiceCompleted:isSuccess:errorMsg:)]) {
            [_delegate zhuanTiServiceCompleted:dto isSuccess:flag errorMsg:self.errorMsg];
        }
    });
}


#pragma mark - CancelRequest
- (void)cancelCuxiaoRequestAndDelegate {
    [cuXiaoHttpMsg cancelDelegateAndCancel];
}


- (void)cancelLianBanRequestAdnDelegate {
    [lianBanHttpMsg cancelDelegateAndCancel];
}


- (void)cancelProductListRequestAndDelegate {
    [productListHttpMsg cancelDelegateAndCancel];
}

//- (void)parseLianBanResultDTO:(ZhuanTiDTO *)dto isSuccess:(BOOL)flag {
//    
//}
//
//
//- (void)parseProductListResultDTO:(ZhuanTiDTO *)dto isSuccess:(BOOL)flag  {
//    
//}

@end
