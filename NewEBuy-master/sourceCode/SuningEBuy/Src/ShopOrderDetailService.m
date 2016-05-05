//
//  ShopOrderDetailService.m
//  SuningEBuy
//
//  Created by xmy on 2/1/14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "ShopOrderDetailService.h"
#import "PasswdUtil.h"
#import "SNSwitch.h"
#import "ShopDetailDto.h"

@implementation ShopOrderDetailService

- (void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(_ShopOrderDetailMsg);
}

- (void)sendShopOrderDetailRequestWithOmsOrderId:(NSString *)omsOrderId
                WithOmsOrderItemId:(NSString*)omsOrderItemId
             WithorderSourceSystem:(NSString*)orderSourceSystem
                         WithCustNum:(NSString *)custNum
{
    
//http://10.19.112.182:8080/suning-web-mobile/order/queryOrderInfoByOrderID.do
    
    
    NSString *url = nil;
    
    if([SNSwitch isPassportLogin])
    {
//        url = [NSString stringWithFormat:@"%@",@"http://mobtspre.cnsuning.com/suning-web-mobile/order/private/queryOrderInfoByOrderIDNew.do"];
        
        //url = [NSString stringWithFormat:@"%@/%@",kHostSuningWebMobileShopList,@"order/private/queryOrderInfoByOrderIDNew.do"];
        url = [NSString stringWithFormat:@"%@%@",KNewHomeAPIURL,@"myorder/private/queryOrderInfoByOrderID.html"];
    }
    
    //全部订单查询门店订单
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc]init];
    
    //系统来源，如1：客户端，2：B2C
    [postDataDic setObject:orderSourceSystem?orderSourceSystem:@"1" forKey:@"orderSourceSystem"];
    
    //订单号
    [postDataDic setObject:omsOrderId?omsOrderId:@"" forKey:@"omsOrderId"];
    
    
    if([SNSwitch isPassportLogin])
    {
        
    }
    else
    {
        //会员编号
        
        NSString *encodeStr = [PasswdUtil encryptString:custNum
                                                 forKey:@"SNMTLogon"
                                                   salt:@"sn201209"];
        [postDataDic setObject:encodeStr forKey:@"custNum"];
    }
    
    //订单行号
    [postDataDic setObject:omsOrderItemId?omsOrderItemId:@"" forKey:@"omsOrderItemId"];
    
    HTTPMSG_RELEASE_SAFELY(_ShopOrderDetailMsg);

    _ShopOrderDetailMsg = [[HttpMessage alloc]initWithDelegate:self
                                                    requestUrl:url
                                                   postDataDic:postDataDic
                                                       cmdCode:CC_ShopOrderDetail];
    
    [self.httpMsgCtrl sendHttpMsg:_ShopOrderDetailMsg];

}

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    [self getShopDetail:NO];

}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    NSDictionary *items = receiveMsg.jasonItems;
    
    DLog(@"_ShopOrderDetailMsg1111********* %@",items);

    if (!items) {
        self.errorMsg = kHttpResponseJSONValueFailError;
        [self getShopDetail:NO];
    }
    else
    {
//        self.errorMsg = receiveMsg.errorCode;
        NSMutableArray *retArray = [[NSMutableArray alloc] init];

//        for(NSDictionary *dic in items)
//        {
            ShopDetailDto *dto = [[ShopDetailDto alloc] init];
            
            [dto encodeFromDictionary:items];
            
            [retArray addObject:dto];

//        }
        
        self.detailList = retArray;
        
        [self getShopDetail:YES];
    }
}

- (void)getShopDetail:(BOOL)isSuccess
{
    if(_delegate && [_delegate respondsToSelector:@selector(getShopOrderDetail:success:WithErrorMsg:)])
    {
        [self.delegate getShopOrderDetail:self success:isSuccess WithErrorMsg:self.errorMsg];
    }
}

- (NSMutableArray*)detailList
{
    if(!_detailList)
    {
        _detailList = [[NSMutableArray alloc] init];
    }
    
    return _detailList;
}

@end
