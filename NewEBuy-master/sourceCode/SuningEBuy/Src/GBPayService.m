//
//  GBPayService.m
//  SuningEBuy
//
//  Created by  zhang jian on 13-2-26.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "GBPayService.h"
#import "GBUPPayBackDTO.h"

@implementation GBPayService
@synthesize delegate = _delegate;
@synthesize efubaoDto = _efubaoDto;

- (void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(getReferOrderHttpMsg);
    HTTPMSG_RELEASE_SAFELY(payByEppChannelHttpMsg);
    HTTPMSG_RELEASE_SAFELY(payByMobileChannelHttpMsg);
    
    TT_RELEASE_SAFELY(_efubaoDto);
}

- (void)beginGetReferOrder:(NSString *)snProId saleCount:(NSString *)saleCount telePhone:(NSString *)telephone groupType:(NSString *)type
{
    NSString *url=[NSString stringWithFormat:@"%@/%@",kHostGroupBuyAddressForHttp,@"getReferOrder.htm"];
    
    NSMutableDictionary *postData = [[NSMutableDictionary alloc] initWithCapacity:8];
    [postData setValue:type?type:@"" forKey:@"tuanGouType"];
    [postData setValue:snProId?snProId:@"" forKey:@"snProId"];  //测试账号000000029520（一卷一用）    000000029521（一卷多用）
    [postData setValue:saleCount?saleCount:@"" forKey:@"saleCount"];
    [postData setValue:[UserCenter defaultCenter].userInfoDTO.userId?[UserCenter defaultCenter].userInfoDTO.userId:@"" forKey:@"userId"];
    [postData setValue:[UserCenter defaultCenter].userInfoDTO.logonId?[UserCenter defaultCenter].userInfoDTO.logonId:@"" forKey:@"userName"];
    [postData setValue:[UserCenter defaultCenter].userInfoDTO.memberCardNo?[UserCenter defaultCenter].userInfoDTO.memberCardNo:@"" forKey:@"outCard"];
    [postData setValue:[UserCenter defaultCenter].userInfoDTO.internalNum?[UserCenter defaultCenter].userInfoDTO.internalNum:@"" forKey:@"innerCard"];
    //    [postData setValue:@"6000001679" forKey:@"outCard"];
    //    [postData setValue:@"6000001679" forKey:@"innerCard"];
    [postData setValue:telephone?telephone:@"" forKey:@"telephone"];
    
    NSString *sendString = [@"" queryStringNoEncodeFromDictionary:postData];
    
    NSString *encodeStr = [PasswdUtil encryptString:sendString
                                             forKey:@"SuningTG"
                                               salt:@"SuningTG"];
    NSDictionary *sendDic =[[NSDictionary alloc] initWithObjectsAndKeys:encodeStr,@"data", nil];
    
    
    HTTPMSG_RELEASE_SAFELY(getReferOrderHttpMsg);
    
    getReferOrderHttpMsg = [[HttpMessage alloc]initWithDelegate:self
                                                     requestUrl:url
                                                    postDataDic:sendDic
                                                        cmdCode:CC_GBReferOrder];
    
    [self.httpMsgCtrl sendHttpMsg:getReferOrderHttpMsg];
    
}


- (void)beginPayByEppChannel:(GBSubmitDTO *)dto
{
    
    NSString *url=[NSString stringWithFormat:@"%@/%@",kHostGroupBuyAddressForHttp,@"payByEppChannle.htm"];
    
    NSMutableDictionary *postData = [[NSMutableDictionary alloc] initWithCapacity:7];
    
    [postData setValue:[UserCenter defaultCenter].userInfoDTO.userId?[UserCenter defaultCenter].userInfoDTO.userId:@"" forKey:@"userId"];
    [postData setValue:dto.orderId?dto.orderId:@"" forKey:@"orderId"];
    //    [postData setValue:@"6000001679" forKey:@"memberId"];
    [postData setValue:[UserCenter defaultCenter].userInfoDTO.memberCardNo?[UserCenter defaultCenter].userInfoDTO.memberCardNo:@"" forKey:@"memberId"];
    [postData setValue:dto.payAmount?dto.payAmount:@"" forKey:@"payAmount"];
    
    [postData setValue:dto.eppPassword?dto.eppPassword:@"" forKey:@"eppPassword"];
    //    [postData setValue:dto.validateMsg?dto.validateMsg:@"" forKey:@"validateMsg"];
    [postData setValue:dto.paymentType?dto.paymentType:@"" forKey:@"paymentType"];
    
    
    NSString *sendString = [@"" queryStringNoEncodeFromDictionary:postData];
    
    NSString *encodeStr = [PasswdUtil encryptString:sendString
                                             forKey:@"SuningTG"
                                               salt:@"SuningTG"];
    NSDictionary *sendDic =[[NSDictionary alloc] initWithObjectsAndKeys:encodeStr,@"data", nil];
    
    
    HTTPMSG_RELEASE_SAFELY(payByEppChannelHttpMsg);
    
    payByEppChannelHttpMsg = [[HttpMessage alloc]initWithDelegate:self
                                                       requestUrl:url
                                                      postDataDic:sendDic
                                                          cmdCode:CC_GBPayByEpp];
    
    [self.httpMsgCtrl sendHttpMsg:payByEppChannelHttpMsg];
    
    
}

- (void)beginPayByMobileChannel:(GBSubmitDTO *)dto;
{
    NSString *url=[NSString stringWithFormat:@"%@/%@",kHostGroupBuyAddressForHttp,@"payByMobileChannle.htm"];
    
    NSMutableDictionary *postData = [[NSMutableDictionary alloc] initWithCapacity:6];
    
    [postData setValue:dto.orderId?dto.orderId:@"" forKey:@"orderId"];
    [postData setValue:[UserCenter defaultCenter].userInfoDTO.userId?[UserCenter defaultCenter].userInfoDTO.userId:@"" forKey:@"userId"];
    [postData setValue:[UserCenter defaultCenter].userInfoDTO.memberCardNo?[UserCenter defaultCenter].userInfoDTO.memberCardNo:@"" forKey:@"memberId"];
    //    [postData setValue:@"6000001679" forKey:@"memberId"];
    [postData setValue:dto.payAmount?dto.payAmount:@"" forKey:@"payAmount"];
//    [postData setValue:@"0.01" forKey:@"payAmount"];
    [postData setValue:@"0" forKey:@"eppAmount"];
    [postData setValue:dto.paymentType?dto.paymentType:@"" forKey:@"paymentType"];
    
    NSString *sendString = [@"" queryStringNoEncodeFromDictionary:postData];
    
    NSString *encodeStr = [PasswdUtil encryptString:sendString
                                             forKey:@"SuningTG"
                                               salt:@"SuningTG"];
    NSDictionary *sendDic =[[NSDictionary alloc] initWithObjectsAndKeys:encodeStr,@"data", nil];
    
    
    HTTPMSG_RELEASE_SAFELY(payByMobileChannelHttpMsg);
    
    payByMobileChannelHttpMsg = [[HttpMessage alloc]initWithDelegate:self
                                                          requestUrl:url
                                                         postDataDic:sendDic
                                                             cmdCode:CC_GBPayByMobile];
    
    [self.httpMsgCtrl sendHttpMsg:payByMobileChannelHttpMsg];
    
}

- (void)receiveDataFinished:(HttpMessage *)recieveMsg Data:(NSDictionary *)dataDic Result:(BOOL)isSuccess
{
    if (isSuccess) {
        [self getPayServiceComplete:YES httpMessage:recieveMsg CMDCode:recieveMsg.cmdCode];
    }else{
        [self getPayServiceComplete:NO httpMessage:recieveMsg CMDCode:recieveMsg.cmdCode];
    }
}

- (void)getPayServiceComplete:(BOOL)isSuccess httpMessage:(HttpMessage *)message CMDCode:(E_CMDCODE)cmdCode{
    
    switch (cmdCode) {
        case CC_GBReferOrder:
        {
            GBSubmitBackDTO *backDto = [[GBSubmitBackDTO alloc] init];
            if (isSuccess) {
                NSDictionary *item = [message.jasonItems objectForKey:@"data"];
                [backDto encodeFromDictionary:item];
            }
            if (_delegate && [_delegate conformsToProtocol:@protocol(GBPayServiceDelegate) ]) {
                if ([_delegate respondsToSelector:@selector(getReferOrderComplete:Result:orderId:)]) {
                    [_delegate getReferOrderComplete:self Result:isSuccess orderId:backDto];
                }
            }
            TT_RELEASE_SAFELY(backDto);
        }
            break;
        case CC_GBPayByMobile:
        {
            NSString *xml = @"";
            GBUPPayBackDTO *payBckDto = [[GBUPPayBackDTO alloc] init];
            if (isSuccess) {
                NSDictionary *itemData = [message.jasonItems objectForKey:@"data"];
                NSDictionary *item = [itemData objectForKey:@"paymentConfirm"];
                [payBckDto encodeFromDictionary:item];
                xml = [itemData objectForKey:@"submitform"];
            }
            if (_delegate && [_delegate conformsToProtocol:@protocol(GBPayServiceDelegate) ]) {
                if ([_delegate respondsToSelector:@selector(payByMobileComplete:Result:withXml:)]) {
                    [_delegate payByMobileComplete:self Result:isSuccess withXml:xml];
                }
            }
            TT_RELEASE_SAFELY(payBckDto);
        }
            break;
        case CC_GBPayByEpp:
        {
            if (isSuccess) {
                NSDictionary *item = [message.jasonItems objectForKey:@"data"];
                [self.efubaoDto encodeFromDictionary:item];
                
                if (!IsStrEmpty(self.efubaoDto.passwordErrorTimes)) {
                    if (![self.efubaoDto.passwordErrorTimes isEqualToString:@"0"]) {
                        if ([self.efubaoDto.passwordErrorTimes isEqualToString:@"3"]) {
                            self.errorMsg = L(@"GBSecretCodeHasWrongForThreeTimes");
                        }else {
                            self.errorMsg = [NSString stringWithFormat:@"%@%@%@",L(@"GBWrongPartOne"),self.efubaoDto.passwordErrorTimes,L(@"GBWrongPartTwo")];
                        }
                    }
                }
            }
            else
            {
                NSString *errorTimes = [message.jasonItems objectForKey:@"passwordErrorTimes"];
                if (!IsStrEmpty(errorTimes)) {
                    if (![errorTimes isEqualToString:@"0"]) {
                        if ([errorTimes isEqualToString:@"3"]) {
                            self.errorMsg = L(@"GBSecretCodeHasWrongForThreeTimes");
                        }else {
                            self.errorMsg = [NSString stringWithFormat:@"%@%@%@",L(@"GBWrongPartOne"),errorTimes,L(@"GBWrongPartTwo")];
                        }
                    }
                }
            }
            
            if (_delegate && [_delegate conformsToProtocol:@protocol(GBPayServiceDelegate) ]) {
                if ([_delegate respondsToSelector:@selector(payByEppChannelComplete:Result:)]) {
                    [_delegate payByEppChannelComplete:self Result:isSuccess];
                }
            }
        }
            break;
        default:
            break;
    }
}

- (GBEfubaoDTO *)efubaoDto
{
    if (!_efubaoDto) {
        _efubaoDto = [[GBEfubaoDTO alloc] init];
    }
    return _efubaoDto;
}

@end
