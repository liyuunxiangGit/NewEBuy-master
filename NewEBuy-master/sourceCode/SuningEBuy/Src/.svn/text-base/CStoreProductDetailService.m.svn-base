//
//  CStoreProductDetailService.m
//  SuningEBuy
//
//  Created by xmy on 15/10/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CStoreProductDetailService.h"

@implementation CStoreProductDetailService


- (void)dealloc {
    HTTPMSG_RELEASE_SAFELY(getCStoreProDetailHttpMsg);
}

- (void)sendCStoreProductDetailRequest
{
//    NSURL *url = [NSURL URLWithString:@"http://b2csit.cnsuning.com/webapp/wcs/stores/servlet/SNiPhoneAppShopProductDispaly?storeId=10052&productId=2653382&cityCode=9173&xsection=11366&platform=1&shopCode=0018214321"];
    
    NSMutableDictionary *postDic = [[NSMutableDictionary alloc] init];
    
    [postDic setObject:@"10052" forKey:@"storeId"];
    
    [postDic setObject:@"2653382" forKey:@"productId"];

    [postDic setObject:@"9173" forKey:@"cityCode"];

    [postDic setObject:@"11366" forKey:@"xsection"];
    
    [postDic setObject:@"1" forKey:@"platform"];

    [postDic setObject:@"0018214321" forKey:@"shopCode"];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@", kHostAddressForHttp, @"SNiPhoneAppShopProductDispaly"];

    HTTPMSG_RELEASE_SAFELY(getCStoreProDetailHttpMsg);
    getCStoreProDetailHttpMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:url postDataDic:postDic cmdCode:CC_CStoreProDetail];
    
    [self.httpMsgCtrl sendHttpMsg:getCStoreProDetailHttpMsg];
    
}


#pragma mark -
#pragma mark service back delegate

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    if (receiveMsg.cmdCode == CC_CStoreProDetail) {
        
      
    }else{
        
    }
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    if (receiveMsg.cmdCode == CC_CStoreProDetail) {
        
    }else{
        
        
    }
}



@end
