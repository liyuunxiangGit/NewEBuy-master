//
//  ConfirmAcceptService.m
//  SuningEBuy
//
//  Created by xmy on 4/5/14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "ConfirmAcceptService.h"

@implementation ConfirmAcceptService

- (void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(confirmHttpMsg);
    [super httpMsgRelease];
    
}
- (void)sendConfirmAcceptServiceRequest:(NSString*)orderId WithItemId:(NSString*)orderitemIds WithShopCode:(NSString*)cshopVendorCode
{
//    http://b2cpre.cnsuning.com/webapp/wcs/stores/servlet/SNiPhoneConfirmReceiptCmd?storeId=10052&catalogId=10051&orderId=2000240009&orderitemIds=&cshopVendorCode=
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttp,@"SNiPhoneConfirmReceipt"];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    [dic setObject:@"10052" forKey:@"storeId"];
    [dic setObject:@"10051" forKey:@"catalogId"];
    [dic setObject:orderId forKey:@"orderId"];
    [dic setObject:orderitemIds forKey:@"orderitemIds"];
    [dic setObject:cshopVendorCode forKey:@"cshopVendorCode"];

    HTTPMSG_RELEASE_SAFELY(confirmHttpMsg);
    confirmHttpMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:urlStr postDataDic:dic cmdCode:CC_OrderConfirmAccept];
    
    
    [self.httpMsgCtrl sendHttpMsg:confirmHttpMsg];
}


- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    NSDictionary *items = receiveMsg.jasonItems;
    
    if (IsNilOrNull(items)) {
        //json解析失败
        self.errorMsg = kHttpResponseJSONValueFailError;
        [self ConfirmAcceptService:NO];
        return;
    }
    
    NSString *strMsg = [items objectForKey:@"msg"];
    NSString *strResult = [items objectForKey:@"result"];
//    NSString *errorCode = [items objectForKey:@"errorCode"];

    if([strResult isEqualToString:@"0"])
    {
        [self ConfirmAcceptService:YES];
    }
//    else if([strResult isEqualToString:@"2"])
//    {
//        self.errorMsg = @"已有确认收货";
//        [self ConfirmAcceptService:NO];
//        
//    }
//    else if([strResult isEqualToString:@"0"])
    else{
        self.errorMsg = strMsg;
        [self ConfirmAcceptService:NO];
        
    }
}

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    [self ConfirmAcceptService:NO];
}

- (void)ConfirmAcceptService:(BOOL)isSuccess
{
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(ConfirmAcceptServiceComplete:WithIsSuccess:)])
    {
        [self.delegate ConfirmAcceptServiceComplete:self WithIsSuccess:isSuccess];
    }
}

@end
