//
//  DJGroupDetailService.m
//  SuningEBuy
//
//  Created by xie wei on 13-7-9.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "DJGroupDetailService.h"
#import "SNSwitch.h"

@implementation DJGroupDetailService

@synthesize detailDto = _detailDto;
@synthesize delegate = _delegate;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_detailDto);
    HTTPMSG_RELEASE_SAFELY(__DJDetailMsg);
}

- (void)beginSendDJListRequest:(NSString *)actId channelId:(NSString *)channelId{
    
    NSMutableDictionary *postDic = [[NSMutableDictionary alloc] init];
    
    [postDic setObject:@"10052" forKey:@"storeId"];
    [postDic setObject:@"5" forKey:@"pageType"];
    // 渠道维护
//    channelId = @"1",2013/8/16修改防止崩溃xunxiaodong;
    if (IsStrEmpty(channelId)) {
        NSString *chanId = [SNSwitch groupbuyChannel];
        [postDic setObject:chanId?chanId:@"1" forKey:@"channel"];
        
    }else {
        [postDic setObject:channelId forKey:@"channel"];
    }
    
    [postDic setObject:[Config currentConfig].defaultCity forKey:@"cityId"];
    
    if (!IsStrEmpty(actId)) {
        [postDic setObject:actId forKey:@"actId"];
    }
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttp, @"SNMTTuanDetailView"];
    
    HTTPMSG_RELEASE_SAFELY(__DJDetailMsg);
    
    __DJDetailMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:url postDataDic:postDic cmdCode:CC_DJGroupDetail];
    __DJDetailMsg.requestMethod=RequestMethodGet;
    TT_RELEASE_SAFELY(postDic);
    
    [self.httpMsgCtrl sendHttpMsg:__DJDetailMsg];
}

#pragma mark -
#pragma mark http message delegate

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    if (receiveMsg.cmdCode == CC_DJGroupDetail) {
        [self getGroupListFinish:NO];
    }
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    NSDictionary *items = receiveMsg.jasonItems ;
    
    if (receiveMsg.cmdCode == CC_DJGroupDetail) {
        if (!items) {
            [self getGroupListFinish:NO];
        }else{
            [self parsePanicData:items];
        }
    }
}

- (void)parsePanicData:(NSDictionary *)items
{
    DJGroupDetailDTO *dto = [[DJGroupDetailDTO alloc] init];
    [dto encodeFromDictionary:items];
    self.detailDto = dto;
    TT_RELEASE_SAFELY(dto);
    
    [self getGroupListFinish:YES];
}

- (void)getGroupListFinish:(BOOL)isSuccess
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (_delegate && [_delegate respondsToSelector:@selector(didSendDJDetailRequestComplete:Result:)]) {
            [_delegate didSendDJDetailRequestComplete:self Result:isSuccess];
        }
    });
}


@end

