//
//  StoreInfoService.m
//  SuningEBuy
//
//  Created by  on 12-10-7.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "StoreInfoService.h"

// 门店自提
#define kShopStoreInfo          @"shop"

#define kShopInfoCityCode		@"cityCode"

#define kShopInfoDistrictCode	@"districtCode"

#define kShopInfoShopCode		@"shopCode"

#define kShopInfoShopName		@"shopName"

@implementation StoreInfoService

@synthesize delegate = _delegate;

- (void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(getShopsHttpMsg);
}

- (void)beginGetShopListRequest:(NSString *)cityId distrist:(NSString *)districtId
{
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] initWithCapacity:3];
    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
    [postDataDic setObject:cityId?cityId:@"" forKey:kShopInfoCityCode];
    [postDataDic setObject:districtId?districtId:@"" forKey:kShopInfoDistrictCode];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttp,kHttpRequestShopInfo];
    
    HTTPMSG_RELEASE_SAFELY(getShopsHttpMsg);
    
    getShopsHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                 requestUrl:url
                                                postDataDic:postDataDic
                                                    cmdCode:CC_GetShops];
    getShopsHttpMsg.requestMethod = RequestMethodGet;
    [self.httpMsgCtrl sendHttpMsg:getShopsHttpMsg];
    
    TT_RELEASE_SAFELY(postDataDic);
}

#pragma mark -
#pragma mark final

- (void)getShopsOk:(BOOL)isSuccess shopList:(NSArray *)list
{
    if (_delegate && [_delegate respondsToSelector:@selector(getShopListCompletionWithResult:
                                                             errorMsg:
                                                             shopList:)]) {
        [_delegate getShopListCompletionWithResult:isSuccess errorMsg:self.errorMsg shopList:list];
    }
}

- (void)parseShopList:(NSDictionary *)items
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @autoreleasepool {
            
            NSArray *storeArr = [items objectForKey:kShopStoreInfo];
            
            NSMutableArray *array = nil;
            
            if(NotNilAndNull(storeArr) && [storeArr count] > 0)
            {
                array = 
                [[NSMutableArray alloc] initWithCapacity:[storeArr count]];
                
                for(NSDictionary *dic in storeArr)
                {
                    StoreInfoDto *dto = [[StoreInfoDto alloc] init];
                    
                    [dto encodeFromDictionary:dic];
                    
                    [array addObject:dto];
                    
                    TT_RELEASE_SAFELY(dto);
                }
                
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self getShopsOk:YES shopList:array];
            });

        } 
    });
}

#pragma mark -
#pragma mark delegate

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    [self getShopsOk:NO shopList:nil];
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    NSDictionary *items = receiveMsg.jasonItems;
    
    if (!items) {
        self.errorMsg = kHttpResponseJSONValueFailError;
        [self getShopsOk:NO shopList:nil];
    }else if ([receiveMsg.errorCode isEqualToString:@""]){
        [self parseShopList:items];
    }else{
        self.errorMsg = L(@"GetStoreInforFail");
        [self getShopsOk:NO shopList:nil];
    }
}

@end
