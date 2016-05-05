//
//  DJGroupApplyService.m
//  SuningEBuy
//
//  Created by xie wei on 13-7-20.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "DJGroupApplyService.h"
#import "DJGroupApplyDTO.h"

@implementation DJGroupApplyService

@synthesize result = _result;
@synthesize delegate = _delegate;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_result);
    HTTPMSG_RELEASE_SAFELY(__DJGroupApplyMsg);
   
}

- (void)beginSendDJGroupApplyRequest:(DJGroupApplyDTO *)applyDto{
    
    DJGroupApplyDTO *dto = applyDto;
    
    NSMutableDictionary *postDic = [[NSMutableDictionary alloc] init];
    
    if (!IsStrEmpty(dto.storeId)) {
        [postDic setObject:dto.storeId forKey:@"storeId"];
    }
    
    if (!IsStrEmpty(dto.catalogId)) {
        [postDic setObject:dto.catalogId forKey:@"catalogId"];
    }
    
    if (!IsStrEmpty(dto.groupId)) {
        [postDic setObject:dto.groupId forKey:@"groupId"];
    }
    
    if (!IsStrEmpty(dto.catentryId)) {
        [postDic setObject:dto.catentryId forKey:@"catentryId"];
    }
    
    if (!IsStrEmpty(dto.amount)) {
        [postDic setObject:dto.amount forKey:@"amount"];
    }
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttp, [@"SNMTGroupBuyApply" passport]];
    
    HTTPMSG_RELEASE_SAFELY(__DJGroupApplyMsg);
    
    __DJGroupApplyMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:url postDataDic:postDic cmdCode:CC_DJGroupApply];
    [self.httpMsgCtrl sendHttpMsg:__DJGroupApplyMsg];
    
    TT_RELEASE_SAFELY(postDic);
    TT_RELEASE_SAFELY(dto);
}

#pragma mark -
#pragma mark http message delegate

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    if (receiveMsg.cmdCode == CC_DJGroupApply) {
        [self getGroupListFinish:NO];
    }
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    //xiewei
    if (receiveMsg.jasonItems && ![receiveMsg.jasonItems respondsToSelector:@selector(objectForKey:)]) {
        NSDictionary *dic = [NSDictionary dictionaryWithObject:[(NSArray *)receiveMsg.jasonItems objectAtIndex:0] forKey:@"result"];
        receiveMsg.jasonItems = dic;
    }
    else
    {
         [self getGroupListFinish:NO];
    }
    //xiewei
    
    NSDictionary *items = receiveMsg.jasonItems ;
    
    if (receiveMsg.cmdCode == CC_DJGroupApply) {
        if (!items) {
            [self getGroupListFinish:NO];
        }else{
            self.result = [NSString stringWithFormat:@"%@",[[items objectForKey:@"result"] objectForKey:@"result"]] ;
            [self getGroupListFinish:YES];
        }
    }
}

- (void)getGroupListFinish:(BOOL)isSuccess
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (_delegate && [_delegate respondsToSelector:@selector(didSendDJGroupApplyRequestComplete:Result:)]) {
            [_delegate didSendDJGroupApplyRequestComplete:self Result:isSuccess];
        }
    });
}


@end

