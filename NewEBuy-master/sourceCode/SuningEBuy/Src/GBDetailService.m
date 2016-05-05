//
//  GBDetailService.m
//  SuningEBuy
//
//  Created by  zhang jian on 13-2-26.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "GBDetailService.h"

@implementation GBDetailService

@synthesize gbDelegate                  = _gbDelegate;
@synthesize gbGoodsDetailDTO            = _gbGoodsDetailDTO;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_gbGoodsDetailDTO);
}

-(void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(gbDetailHttpMsg);
}

- (void)beginGetGBGoodsDetail:(NSString *)groupType withSnProId:(NSString *)snProId
{
    
    NSString *url=[NSString stringWithFormat:@"%@/%@",kHostGroupBuyAddressForHttp,@"getGroupBuyDetail.htm"];
    
    NSMutableDictionary *postData = [[NSMutableDictionary alloc] initWithCapacity:2];
    
    [postData setValue:groupType?groupType:@"" forKey:@"tuanGouType"];
    [postData setValue:snProId?snProId:@"" forKey:@"snProId"];
    
    NSString *sendString = [@"" queryStringNoEncodeFromDictionary:postData];
    
    NSString *encodeStr = [PasswdUtil encryptString:sendString
                                             forKey:@"SuningTG"
                                               salt:@"SuningTG"];
    
    NSDictionary *sendDic =[[NSDictionary alloc] initWithObjectsAndKeys:encodeStr,@"data", nil];
    
    HTTPMSG_RELEASE_SAFELY(gbDetailHttpMsg);
    
    gbDetailHttpMsg = [[HttpMessage alloc]initWithDelegate:self
                                                    requestUrl:url
                                                   postDataDic:sendDic
                                                       cmdCode:CC_GBGoodsDetail];
    
    [self.httpMsgCtrl sendHttpMsg:gbDetailHttpMsg];

    
}

- (void)receiveDataFinished:(HttpMessage *)recieveMsg Data:(NSDictionary *)dataDic Result:(BOOL)isSuccess
{
    if (isSuccess) {
        if (!_gbGoodsDetailDTO) {
            _gbGoodsDetailDTO = [[GBGoodsDetailDTO alloc] init];
        }
        [_gbGoodsDetailDTO encodeFromDictionary:dataDic];
        [self getGBGoodsDetailComplete:YES CMDCode:recieveMsg.cmdCode];
    }else{
        
        [self getGBGoodsDetailComplete:NO CMDCode:recieveMsg.cmdCode];
    }
}

- (void)getGBGoodsDetailComplete:(BOOL)isSuccess CMDCode:(E_CMDCODE)cmdCode{
    if ([self.gbDelegate respondsToSelector:@selector(getGBGoodsDetailComplete:Result:)]) {
        [self.gbDelegate getGBGoodsDetailComplete:self Result:isSuccess];
    }
}


@end
