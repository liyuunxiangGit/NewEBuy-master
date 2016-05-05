//
//  GBOrderDetailInfoService.m
//  SuningEBuy
//
//  Created by 王 漫 on 13-2-27.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "GBOrderDetailInfoService.h"

@implementation GBOrderDetailInfoService
@synthesize orderInfoDTO = _orderInfoDTO;
@synthesize delegate = _delegate;

-(id)init{
    
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)dealloc{
    
    
    TT_RELEASE_SAFELY(_orderInfoDTO);
}

-(void)httpMsgRelease{
    
    [super httpMsgRelease];
    
    HTTPMSG_RELEASE_SAFELY(orderDetailInfoHttpMsg);
}

- (void)sendOrderDetailInfoHttpRequest:(GBOrderInfoDTO *)dto{
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostGroupBuyAddressForHttp,@"getOrderDetail.htm"];
    
    NSString *userId = [UserCenter defaultCenter].userInfoDTO.userId;
    
    if (IsStrEmpty(userId))
    {
        return;
    }
    
    NSMutableDictionary *postData = [[NSMutableDictionary alloc] initWithCapacity:3];
    
    [postData setValue:userId forKey:@"userId"];
    [postData setValue:dto.orderId forKey:@"orderId"];
    [postData setValue:[NSString stringWithFormat:@"%d",dto.gbType] forKey:@"tuanGouType"];
    
    
    NSString *sendString = [@"" queryStringNoEncodeFromDictionary:postData];
    
    NSString *encodeStr = [PasswdUtil encryptString:sendString
                                             forKey:@"SuningTG"
                                               salt:@"SuningTG"];
    
    NSDictionary *sendDic =[[NSDictionary alloc] initWithObjectsAndKeys:encodeStr,@"data", nil];
    
    HTTPMSG_RELEASE_SAFELY(orderDetailInfoHttpMsg);
    
    orderDetailInfoHttpMsg = [[HttpMessage alloc]initWithDelegate:self requestUrl:url postDataDic:sendDic cmdCode:CC_GBOrderDetail];
    
    [self.httpMsgCtrl sendHttpMsg:orderDetailInfoHttpMsg];
    
    TT_RELEASE_SAFELY(sendDic);
}

- (void)receiveDataFinished:(HttpMessage *)recieveMsg Data:(NSDictionary *)dataDic Result:(BOOL)isSuccess{
    
    if (recieveMsg.cmdCode == CC_GBOrderDetail) {
        
        if (isSuccess) {
            
            if (dataDic) {
                [self parseDatas:dataDic];
                [self getOrderDetailInfoFinished:YES];
                
            }else{
                self.errorMsg = (@"load_failed");
                [self getOrderDetailInfoFinished:NO];
            }
            
        }else{
            
            self.errorMsg = (@"load_failed");
            [self getOrderDetailInfoFinished:NO];
            
        }
    }
}

- (void)parseDatas:(NSDictionary *)datas{
    GBOrderInfoDTO *dto = [[GBOrderInfoDTO alloc]init];
    [dto encodeOrderDetailFromDic:datas];
    self.orderInfoDTO = dto;
    TT_RELEASE_SAFELY(dto);
}

- (void)getOrderDetailInfoFinished:(BOOL)isSuccess{
    
    if (isSuccess) {
        if (_delegate &&[_delegate respondsToSelector:@selector(getOrderDetailInfoCopleted:orderDetailInfoDTO:errorMsg:)]) {
            
            [_delegate getOrderDetailInfoCopleted:YES orderDetailInfoDTO:self.orderInfoDTO errorMsg:self.errorMsg];
        }
    }else{
        if (_delegate &&[_delegate respondsToSelector:@selector(getOrderDetailInfoCopleted:orderDetailInfoDTO:errorMsg:)]) {
            
            [_delegate getOrderDetailInfoCopleted:NO orderDetailInfoDTO:nil errorMsg:self.errorMsg];
        }
        
    }
}
@end
