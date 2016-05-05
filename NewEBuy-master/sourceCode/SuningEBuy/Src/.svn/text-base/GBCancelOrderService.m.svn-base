//
//  GBCancelOrderService.m
//  SuningEBuy
//
//  Created by li xiaokai on 13-6-15.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "GBCancelOrderService.h"
#import "GBVoucherSingleInfoDTO.h"

@implementation ReFundInfoDto


@end

@implementation GBCancelOrderService

- (void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(_cancelOrderHttpMsg);
    HTTPMSG_RELEASE_SAFELY(_refundHttpMsg);

}
-(void)beginRefund:(ReFundInfoDto*)dto{
    
    NSString *url=[NSString stringWithFormat:@"%@/%@",kHostGroupBuyAddressForHttp,@"getOrderRefund.htm"];
    
    NSMutableDictionary *postData = [[NSMutableDictionary alloc] initWithCapacity:6];
    
    
    
    [postData setValue:dto.tuanGouType?dto.tuanGouType:@"" forKey:@"tuanGouType"];
    [postData setValue:dto.orderId?dto.orderId:@"" forKey:@"orderId"];
    [postData setValue:dto.userId?dto.userId:@"" forKey:@"userId"];
    [postData setValue:dto.refundReason?dto.refundReason:@"" forKey:@"refundReason"];
    [postData setValue:dto.vouncherType?dto.vouncherType:@"" forKey:@"vouncherType"];
    
    if (![@"2" isEqualToString:dto.vouncherType]) {
        
        NSString *orderItemIdsStr = @"";
        for (GBVoucherSingleInfoDTO *obj in dto.orderItemIdArray) {
            
            if (0 == [orderItemIdsStr length]) {
                
                orderItemIdsStr = obj.orderItemId;
            }
            else{
                
                orderItemIdsStr = [NSString stringWithFormat:@"%@,%@",orderItemIdsStr,obj.orderItemId];
            }
        }
        
        [postData setValue:orderItemIdsStr?orderItemIdsStr:@"" forKey:@"orderItemIds"];
    }
    else{
        
        [postData setValue:dto.refundCount?dto.refundCount:@"1" forKey:@"refundCount"];
    }
    
    
    NSString *sendString = [@"" queryStringNoEncodeFromDictionary:postData];
    
    NSString *encodeStr = [PasswdUtil encryptString:sendString
                                             forKey:@"SuningTG"
                                               salt:@"SuningTG"];
    NSDictionary *sendDic =[[NSDictionary alloc] initWithObjectsAndKeys:encodeStr,@"data", nil];
    
    
    HTTPMSG_RELEASE_SAFELY(_refundHttpMsg);
    
    _refundHttpMsg = [[HttpMessage alloc]initWithDelegate:self
                                                    requestUrl:url
                                                   postDataDic:sendDic
                                                       cmdCode:CC_GBRefund];
    
    [self.httpMsgCtrl sendHttpMsg:_refundHttpMsg];
    

}
-(void)beginCancelOrder:(NSString *)orderid
                isHotel:(NSString*)isHotel
                   user:(NSString *)userId
{
    NSString *url=[NSString stringWithFormat:@"%@/%@",kHostGroupBuyAddressForHttp,@"getOrderCancel.htm"];
    
    NSMutableDictionary *postData = [[NSMutableDictionary alloc] initWithCapacity:3];
    [postData setValue:isHotel?isHotel:@"" forKey:@"tuanGouType"];
    [postData setValue:orderid?orderid:@"" forKey:@"orderId"];
    [postData setValue:userId?userId:@"" forKey:@"userId"];
    
    NSString *sendString = [@"" queryStringNoEncodeFromDictionary:postData];
    
    NSString *encodeStr = [PasswdUtil encryptString:sendString
                                             forKey:@"SuningTG"
                                               salt:@"SuningTG"];
    NSDictionary *sendDic =[[NSDictionary alloc] initWithObjectsAndKeys:encodeStr,@"data", nil];
    
    
    HTTPMSG_RELEASE_SAFELY(_cancelOrderHttpMsg);
    
    _cancelOrderHttpMsg = [[HttpMessage alloc]initWithDelegate:self
                                                     requestUrl:url
                                                    postDataDic:sendDic
                                                        cmdCode:CC_GBCancelOrder];
    
    [self.httpMsgCtrl sendHttpMsg:_cancelOrderHttpMsg];
    
}
- (void)receiveDataFinished:(HttpMessage *)recieveMsg Data:(NSDictionary *)dataDic Result:(BOOL)isSuccess
{
    
    switch (recieveMsg.cmdCode) {
        case CC_GBCancelOrder:{
    
            NSDictionary *item = nil;
            if (isSuccess) {
                item = [recieveMsg.jasonItems objectForKey:@"data"];
            }
            if (_myDelagate && [_myDelagate conformsToProtocol:@protocol(GBCancelOrderDelegate) ]) {
                if ([_myDelagate respondsToSelector:@selector(cancelOrder:info:Result:)]) {
                    [_myDelagate cancelOrder:self info:item Result:isSuccess];
                }
            }
        }
            break;
        case CC_GBRefund:{
            
            NSDictionary *item = nil;
            if (isSuccess) {
                item = [recieveMsg.jasonItems objectForKey:@"data"];
            }
            if (_myDelagate && [_myDelagate conformsToProtocol:@protocol(GBCancelOrderDelegate) ]) {
                if ([_myDelagate respondsToSelector:@selector(refund:info:Result:)]) {
                    [_myDelagate refund:self info:item Result:isSuccess];
                }
            }
        }
            break;
        default:
            break;
    }
}

@end
