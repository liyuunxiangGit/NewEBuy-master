//
//  SellerInfoService.m
//  SuningEBuy
//
//  Created by xmy on 14/10/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//
#import "SellerInfoService.h"
#import "BrowsingHistoryDAO.h"

@interface SellerInfoService()

@end

/*********************************************************************/

@implementation SellerInfoService

@synthesize delegate = _delegate;
@synthesize shopList = _shopList;


- (void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(sellerHttpMessage);
}

#pragma mark -
#pragma mark service life cycle

- (void)requestSellerInfoWithProductId:(NSString *)productId productCode:(NSString *)productCode cityCode:(NSString *)cityCode
{
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] initWithCapacity:5];
    
    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
    [postDataDic setObject:kHttpRequestHomeCatalogIdValue forKey:kHttpRequestHomeCatalogIdKey];
    
    [postDataDic setObject:POST_VALUE(productId) forKey:@"productId"];
    [postDataDic setObject:POST_VALUE(productCode) forKey:@"productCode"];
    [postDataDic setObject:POST_VALUE(cityCode) forKey:@"cityCode"];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@", kHostAddressForHttp, @"SNiPhoneAppShopListInfoCmd"];
//    NSString *url = [NSString stringWithFormat:@"%@/snappcslp_%@_%@_%@_%@_%@_.html", kHostAddressForHttp,kHttpRequestHomeStoreValue,kHttpRequestHomeCatalogIdValue,POST_VALUE(productId),POST_VALUE(productCode),POST_VALUE(cityCode)];
    
    HTTPMSG_RELEASE_SAFELY(sellerHttpMessage);
    
    sellerHttpMessage = [[HttpMessage alloc] initWithDelegate:self
                                                   requestUrl:url
                                                  postDataDic:postDataDic
                                                      cmdCode:CC_AddShopListInfoCmd];
    sellerHttpMessage.requestMethod = RequestMethodGet;

    [self.httpMsgCtrl sendHttpMsg:sellerHttpMessage];
    
}

#pragma mark -
#pragma mark final method

- (void)getSellerComplete:(BOOL)isSuccess
{
    if (_delegate && [_delegate respondsToSelector:@selector(service:didGetSellerInfoComplete:)])
    {
        [_delegate service:self didGetSellerInfoComplete:isSuccess];
    }
}

#pragma mark -
#pragma mark service back delegate

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    [self getSellerComplete:NO];
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    NSDictionary *item = receiveMsg.jasonItems;
    if (!item) {
        self.errorMsg = kHttpResponseJSONValueFailError;
    }else{
        //判断是否成功
        NSString *errorCode = receiveMsg.errorCode;
        
        if ([errorCode isEqualToString:@""])
        {
            [self parseSellerList:item];
        }else{
            [self getSellerComplete:NO];
        }
    }
}

- (void)parseSellerList:(NSDictionary *)items
{
    self.shopList = EncodeArrayFromDicUsingParseBlock(items, @"shopList", ^id(NSDictionary *innerDic) {
        
        SellerListDTO *sellerDTO = [[SellerListDTO alloc] init];
        
        [sellerDTO encodeFromDictionary:innerDic];
        return sellerDTO;
    });
    
    [self getSellerComplete:YES];

}

#pragma -Mark
#pragma method


@end
