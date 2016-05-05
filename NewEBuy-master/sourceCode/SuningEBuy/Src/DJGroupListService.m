//
//  DJGroupListService.m
//  SuningEBuy
//
//  Created by xie wei on 13-7-8.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "DJGroupListService.h"
#import "DJGroupListItemDTO.h"
#import "SNSwitch.h"

@implementation DJGroupListService

@synthesize groupListArray = _groupListArray;
@synthesize delegate = _delegate;
@synthesize netWorkErro = _netWorkErro;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_groupListArray);
    TT_RELEASE_SAFELY(_netWorkErro);
    HTTPMSG_RELEASE_SAFELY(__DJListMsg);

}

- (void)beginSendDJListRequest:(DJGroupListInputDTO *)dto{
    
    NSMutableDictionary *postDic = [[NSMutableDictionary alloc] init];
    
    [postDic setObject:@"10052" forKey:@"storeId"];
    
    if (!IsStrEmpty(dto.pageType)) {
        [postDic setObject:dto.pageType forKey:@"pageType"];
    }
    
    if (!IsStrEmpty(dto.channel)) {
        [postDic setObject:dto.channel forKey:@"channel"];
    }
    
    // 渠道维护
//    [postDic setObject:@"1" forKey:@"channel"];
    
    if (!IsStrEmpty(dto.numLimit)) {
        [postDic setObject:dto.numLimit forKey:@"numLimit"];
    }
    
    if (!IsStrEmpty(dto.cityId)) {
        [postDic setObject:dto.cityId forKey:@"cityId"];
    }
    
    if ([[SNSwitch groupbuyMyChannelOnly] isEqualToString:@"1"]) {
        [postDic setObject:@"1" forKey:@"isPage"];
    }else{
        [postDic setObject:@"0" forKey:@"isPage"];
    }
    
    if (!IsStrEmpty(dto.myChannelOnly)) {
        [postDic setObject:dto.myChannelOnly forKey:@"myChannelOnly"];
    }
    
    if (!IsStrEmpty(dto.currentPage)) {
        [postDic setObject:dto.currentPage forKey:@"currentPage"];
    }
    
    if (!IsStrEmpty(dto.pageSize)) {
        [postDic setObject:dto.pageSize forKey:@"pageSize"];
    }
    if (!IsStrEmpty(dto.displayArea)) {
        [postDic setObject:dto.displayArea forKey:@"displayArea"];
    }
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttp, @"SNMTTuanListView"];
    
    HTTPMSG_RELEASE_SAFELY(__DJListMsg);
    
    __DJListMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:url postDataDic:postDic cmdCode:CC_DJGroupList];
    __DJListMsg.requestMethod =RequestMethodGet;
    TT_RELEASE_SAFELY(postDic);
    
    [self.httpMsgCtrl sendHttpMsg:__DJListMsg];
}

#pragma mark -
#pragma mark http message delegate

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    if (receiveMsg.cmdCode == CC_DJGroupList) {
        self.netWorkErro = L(@"NWFailTryLater");
        [self getGroupListFinish:NO];
    }
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    NSDictionary *items = receiveMsg.jasonItems ;
    
    if (receiveMsg.cmdCode == CC_DJGroupList) {
        if (!items) {
            [self getGroupListFinish:NO];
        }else{
            self.pageCount = [[items objectForKey:@"maxPage"] integerValue];
            [self parsePanicData:items];
        }
    }
}

- (void)parsePanicData:(NSDictionary *)items
{
    NSArray *groupBuyList;
    if ([[items objectForKey:@"groupBuyList"] isKindOfClass:[NSArray class]]) {
        groupBuyList = [items objectForKey:@"groupBuyList"];
    }
    
    if (!IsArrEmpty(groupBuyList)) {
        NSMutableArray *tempArr = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in groupBuyList) {
            DJGroupListItemDTO *dto = [[DJGroupListItemDTO alloc] init];
            [dto encodeFromDictionary:dic];
            [tempArr addObject:dto];
            TT_RELEASE_SAFELY(dto);
        }
        self.groupListArray = (NSArray *)tempArr;
    }else{
        self.groupListArray = nil;
    }

    [self getGroupListFinish:YES];
}

- (void)getGroupListFinish:(BOOL)isSuccess
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (_delegate && [_delegate respondsToSelector:@selector(didSendDJListRequestComplete:Result:)]) {
            [_delegate didSendDJListRequestComplete:self Result:isSuccess];
        }
    });
}


@end
