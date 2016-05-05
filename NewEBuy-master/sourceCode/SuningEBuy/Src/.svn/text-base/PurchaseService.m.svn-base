//
//  PurchaseService.m
//  SuningEBuy
//
//  Created by  on 12-9-17.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "PurchaseService.h"
#import "ProductUtil.h"
#import "SNSwitch.h"

@interface PurchaseService()
{
    int     currentPage;
}

- (void)getPanicListFinish:(BOOL)isSuccess list:(NSArray *)list;
- (void)getGroupListFinish:(BOOL)isSuccess list:(NSArray *)list;

- (void)getPanicDetailFinish:(BOOL)isSuccess 
      panicPurchaseDetailDTO:(PanicPurchaseDTO*)dto errorCode:(NSString *)errorCode ;

- (void)getHomePanicFinish:(BOOL)isSuccess panicPurchaseDetailDTO:(PanicPurchaseDTO*)dto;


- (void)getPanicLimitFinist:(BOOL)isSuccess 
                       flag:(NSString *)flag 
                  errorCode:(NSString *)errorCode
                   errorMsg:(NSString *)errorMsg
              rushProcessId:(NSString *)rushProcessId;

- (void)parsePanicData:(NSDictionary *)items;
- (void)parseGroupData:(NSDictionary *)items;
- (void)parsePanicDetailData:(NSDictionary *)items;
- (void)parsePanicLimitData:(NSDictionary *)items;

@end

/*********************************************************************/

@implementation PurchaseService

@synthesize delegate = _delegate;

- (id)init {
    self = [super init];
    if (self) {
        
        //根据开关决定抢购的类型
        //后台维护抢购渠道 1代表B2C抢购渠道，2代表客户端自主抢购渠道 （如果维护为一个无效的值，客户端默认调用1）
        NSString *chanId = [SNSwitch rushPurchaseChannel];
        if ([chanId isEqualToString:@"2"])
        {
            self.panicChannel = PanicChannelMobile;
        }
        else
        {
            self.panicChannel = PanicChannelB2C;
        }
    }
    return self;
}


- (void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(panicHttpMsg);
    HTTPMSG_RELEASE_SAFELY(groupHttpMsg);
    HTTPMSG_RELEASE_SAFELY(panicDetailHttpMsg);
    HTTPMSG_RELEASE_SAFELY(panicLimitHttpMsg);
    HTTPMSG_RELEASE_SAFELY(homeFloorHttpMsg);
}

#pragma mark -
#pragma mark service life cycle
//首页抢购
- (void)beginGetHomeFloorPanicProduct:(NSString *)cityId
{
    NSString *url = [NSString stringWithFormat:@"%@/rps-web/rp/rushPurActForMT_%d_%@_%@.htm",
           kHostPanicPurchaseForHttp,self.panicChannel,kMtID,cityId];

    HTTPMSG_RELEASE_SAFELY(homeFloorHttpMsg);

    homeFloorHttpMsg = [[HttpMessage alloc]initWithDelegate:self requestUrl:url postDataDic:nil cmdCode:CC_HomeFloorPanic];

    [self.httpMsgCtrl sendHttpMsg:homeFloorHttpMsg];
}


//新抢购
- (void)beginGetPanicPurchaseList:(NSString *)cityId actChanId:(NSString *)actChanId pageNumber:(int)pageNumber
{
    NSString *url = nil;
    currentPage = pageNumber;
    //主站渠道
    if (self.panicChannel == PanicChannelB2C)
    {
        url = [NSString stringWithFormat:@"%@/rps-web/rp/rushPurActListForMT_%@_%@_%@.htm?chanId=%d&pageNumber=%d&pageSize=10&verNo=2",
               kHostPanicPurchaseForHttp,IsStrEmpty(actChanId)?@"0":actChanId,kMtID,cityId,self.panicChannel,pageNumber];
    }
    //客户端或红孩子渠道
    else
    {
        url = [NSString stringWithFormat:@"%@/rps-web/rp/rushPurActListForMT_%@_%@_%@.htm?chanId=%d&pageNumber=%d&pageSize=10&verNo=2",
               kHostPanicPurchaseForHttp,IsStrEmpty(actChanId)?@"0":actChanId,kMtID,cityId,self.panicChannel,pageNumber];
    }
    
    HTTPMSG_RELEASE_SAFELY(groupHttpMsg);
    
    groupHttpMsg = [[HttpMessage alloc]initWithDelegate:self requestUrl:url postDataDic:nil cmdCode:CC_PanicPurchase];
    
    [self.httpMsgCtrl sendHttpMsg:groupHttpMsg];
}

- (void)beginGetPanicPurchaseDetailList:(NSString *)activityId cityId:(NSString *)cityId
{
    NSString *url = nil;

    //主站渠道
    if (self.panicChannel == PanicChannelB2C)
    {
        url = [NSString stringWithFormat:@"%@/rps-web/rp/showRushPurActForMobile_%@_%@_%@.htm",
               kHostPanicPurchaseForHttp,activityId,@"0",cityId];
    }
    //客户端渠道
    else
    {
        url = [NSString stringWithFormat:@"%@/rps-web/rp/showRushPurActForMT_%@_%@_%@_%@.htm?chanId=%d",
               kHostPanicPurchaseForHttp,activityId,kActChanID,kMtID,cityId, self.panicChannel];
    }
    
    
    HTTPMSG_RELEASE_SAFELY(panicDetailHttpMsg);
    
    panicDetailHttpMsg=[[HttpMessage alloc]initWithDelegate:self 
                                                 requestUrl:url 
                                                postDataDic:nil 
                                                    cmdCode:CC_PanicPurchaseDetail];
    
    [self.httpMsgCtrl sendHttpMsg:panicDetailHttpMsg];
    
}




- (void)beginGetPanicPurchaseLimitList:(NSString *)activityId
                                userId:(NSString *)userId
                                cityId:(NSString *)cityId
{
    NSString *url = nil;
    
    //主站渠道
    if (self.panicChannel == PanicChannelB2C)
    {
//        url = [NSString stringWithFormat:@"%@/rps-web/rp/doRushPurForMobile_%@_%@_%@_%@.htm",kHostPanicPurchaseForHttp,activityId,userId,@"0",cityId];
        url = [NSString stringWithFormat:@"%@/rps-web/rp/doRushPurForMT_%@_%@_%@_%@_%@.htm?chanId=%d",kHostPanicPurchaseForHttp,activityId,kActChanID,kMtID,userId,cityId,self.panicChannel];
    }
    //客户端渠道
    else
    {
        url = [NSString stringWithFormat:@"%@/rps-web/rp/doRushPurForMT_%@_%@_%@_%@_%@.htm?chanId=%d",kHostPanicPurchaseForHttp,activityId,kActChanID,kMtID,userId,cityId,self.panicChannel];
    }
    
    
    HTTPMSG_RELEASE_SAFELY(panicLimitHttpMsg);
    
    panicLimitHttpMsg=[[HttpMessage alloc]initWithDelegate:self 
                                                requestUrl:url 
                                               postDataDic:nil 
                                                   cmdCode:CC_PanicPurchaseLimit];
    
    [self.httpMsgCtrl sendHttpMsg:panicLimitHttpMsg];
    
}


- (void)beginGetGroupPurchaseList
{
    
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] initWithCapacity:2];
    
    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
    [postDataDic setObject:@"1" forKey:@"flag"];

    NSString *url = [NSString stringWithFormat:@"%@/%@", kHostAddressForHttp, kHttpRequestGroupPurchaseView];

    HTTPMSG_RELEASE_SAFELY(groupHttpMsg);
    
    groupHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                              requestUrl:url
                                             postDataDic:postDataDic
                                                 cmdCode:CC_GroupPurchase];
    groupHttpMsg.requestMethod =RequestMethodGet;
    [self.httpMsgCtrl sendHttpMsg:groupHttpMsg];
    
    TT_RELEASE_SAFELY(postDataDic);
    
}


#pragma mark -
#pragma mark http message delegate

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    if (receiveMsg.cmdCode == CC_PanicPurchase) {
        
        [self getPanicListFinish:NO list:nil];
        
    }else if(receiveMsg.cmdCode==CC_GroupPurchase){
        
        [self getGroupListFinish:NO list:nil];
        
    }else if(receiveMsg.cmdCode==CC_PanicPurchaseDetail){
        
        [self getPanicDetailFinish:NO panicPurchaseDetailDTO:nil  errorCode:nil] ;
        
    }else if(receiveMsg.cmdCode==CC_PanicPurchaseLimit){
        
        [self getPanicLimitFinist:NO flag:nil errorCode:nil errorMsg:self.errorMsg rushProcessId:nil];
    }else if (receiveMsg.cmdCode == CC_HomeFloorPanic){
        
        [self getHomePanicFinish:NO panicPurchaseDetailDTO:nil];
    }
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    NSDictionary *items = receiveMsg.jasonItems ;
    //接口没有errorCode， 故不做errorCode判断
    if (receiveMsg.cmdCode == CC_PanicPurchase) {
        if (!items) {
            self.errorMsg = kHttpResponseJSONValueFailError;
            [self getPanicListFinish:NO list:nil];
        }else{
            
            [self parsePanicData:items];
            
        }
        
    }
    else if(receiveMsg.cmdCode==CC_GroupPurchase){
        if (!items) {
            self.errorMsg = kHttpResponseJSONValueFailError;
            [self getGroupListFinish:NO list:nil];
        }else{
            [self parseGroupData:items];
        }
    }
    else if(receiveMsg.cmdCode==CC_PanicPurchaseDetail)
    {
        if (!items) {
            
            self.errorMsg = kHttpResponseJSONValueFailError;
            
            [self getPanicDetailFinish:NO panicPurchaseDetailDTO:nil errorCode:nil];
            
        }else{
            
            [self parsePanicDetailData:items];
        }
    }else if(receiveMsg.cmdCode==CC_PanicPurchaseLimit){
        
        if(!items){
            
            self.errorMsg=kHttpResponseJSONValueFailError;
            [self getPanicLimitFinist:NO flag:nil errorCode:nil errorMsg:self.errorMsg rushProcessId:nil];
        }else{
            [self parsePanicLimitData:items];
        }
    }else if (receiveMsg.cmdCode == CC_HomeFloorPanic){
        if(!items){            
            self.errorMsg=kHttpResponseJSONValueFailError;
            [self getHomePanicFinish:NO panicPurchaseDetailDTO:nil];
        }else{
            [self parseHomePanicData:items];
        }
    }
}



#pragma mark -
#pragma mark final and parse data

- (void)getPanicListFinish:(BOOL)isSuccess list:(NSArray *)list
{
    if (_delegate && [_delegate respondsToSelector:@selector(getPanicPurchaseListCompletionWithResult:errorMsg:panicList:)]) {
        [_delegate getPanicPurchaseListCompletionWithResult:isSuccess errorMsg:self.errorMsg panicList:list];
    }
}

- (void)getGroupListFinish:(BOOL)isSuccess list:(NSArray *)list
{
    if (_delegate && [_delegate respondsToSelector:@selector(getGroupPurchaseListCompletionWithResult:errorMsg:groupList:)]) {
        [_delegate getGroupPurchaseListCompletionWithResult:isSuccess errorMsg:self.errorMsg groupList:list];
    }
}

-(void)getPanicDetailFinish:(BOOL)isSuccess panicPurchaseDetailDTO:(PanicPurchaseDTO *)dto errorCode:(NSString *)errorCode
{
    if(_delegate &&[_delegate respondsToSelector:@selector(getPanicPurchaseDetailCompletionWithResult:errorMsg:panicPurchaseDetail: errorCode:)]){
        [_delegate getPanicPurchaseDetailCompletionWithResult:isSuccess errorMsg:self.errorMsg panicPurchaseDetail:dto errorCode:errorCode];
    }
}

- (void)getPanicLimitFinist:(BOOL)isSuccess flag:(NSString *)flag errorCode:(NSString *)errorCode errorMsg:(NSString *)errorMsg rushProcessId:(NSString *)rushProcessId
{
    if(_delegate &&[_delegate respondsToSelector:@selector(getPanicPurchaseLimitCompletionWithResult:errorCode:errorMsg:flag:rushProcessId:)]){
        [_delegate getPanicPurchaseLimitCompletionWithResult:isSuccess errorCode:errorCode errorMsg:self.errorMsg flag:flag rushProcessId:rushProcessId];
    }
}

- (void)parsePanicData:(NSDictionary *)items
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @autoreleasepool {
            
            NSArray *array = [items objectForKey:@"rpList"];
            int pageCount = [[items objectForKey:@"pageCount"] integerValue];
            
            if (currentPage < pageCount) {
                self.isLastPage = NO;
            }else{
                self.isLastPage = YES;
            }
            
            NSMutableArray *buyingList = nil;
            if (NotNilAndNull(array) && [array count] > 0) {
                
                buyingList = [[NSMutableArray alloc] initWithCapacity:[array count]];
                for (int i = 0; i < [array count]; i++) {
                    NSDictionary *item = [array objectAtIndex:i];
                    PanicPurchaseDTO *dto = [[PanicPurchaseDTO alloc] init];
                    [dto encodeRushForMobileFromDic:item];
                    [buyingList addObject:dto];
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self getPanicListFinish:YES list:buyingList];
            });

        } 
    });
}

- (void)parseGroupData:(NSDictionary *)items
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @autoreleasepool {
            NSArray *array = [items objectForKey:kHttpResponseGroupPurchaseGroupList];
            
            NSMutableArray *purchases = nil;
            if (NotNilAndNull(array) && [array count] > 0) {
                purchases = [[NSMutableArray alloc] initWithCapacity:[array count]];
                for (NSDictionary *item in array)
                {
                    GroupPurchaseDTO *itemDTO = [[GroupPurchaseDTO alloc] init];
                    
                    [itemDTO encodeFromDictionary:item];
                    
                    [purchases addObject:itemDTO];
                    
                    TT_RELEASE_SAFELY(itemDTO);
                }
                
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self getGroupListFinish:YES list:purchases];
            });

        } 
    });
}

- (void)parsePanicDetailData:(NSDictionary *)items
{
    PanicPurchaseDTO *dto = [[PanicPurchaseDTO alloc] init];
    
    if (self.panicChannel == PanicChannelB2C)
    {
        [dto encodeRushDetailForB2CFromDic:items];
    }
    else
    {
        [dto encodeRushForMobileFromDic:items];
    }

    self.errorMsg=[items objectForKey:@"errorMsg"];
    
    NSString *errorCode = [items objectForKey:@"errorCode"];
    
    [self getPanicDetailFinish:YES panicPurchaseDetailDTO:dto errorCode:errorCode];

}

- (void)parsePanicLimitData:(NSDictionary *)items
{
                
    NSString *flag=[items objectForKey:@"flag"];
    
    self.errorMsg=[items objectForKey:@"errorMsg"];
    
    NSString *errorCode = [items objectForKey:@"errorCode"];
    
    NSString *rushProcessId = [items objectForKey:@"rushProcessId"];
    
    [self getPanicLimitFinist:YES flag:flag errorCode: errorCode errorMsg:self.errorMsg rushProcessId:rushProcessId];
            

}

- (void)parseHomePanicData:(NSDictionary *)item
{
   NSArray *array = [item objectForKey:@"rpList"];
    PanicPurchaseDTO *dto = [[PanicPurchaseDTO alloc] init];
    if (NotNilAndNull(array) && [array count] > 0)
    {
        NSDictionary *item = [array objectAtIndex:0];
        [dto encodeRushForMobileFromDic:item];
    }

    [self getHomePanicFinish:YES panicPurchaseDetailDTO:dto];
}

- (void)getHomePanicFinish:(BOOL)isSuccess panicPurchaseDetailDTO:(PanicPurchaseDTO *)dto
{
    if (_delegate && [_delegate respondsToSelector:@selector(getHomeFloorPanicProduct:panicPurchaseDetail:)]) {
        [_delegate getHomeFloorPanicProduct:isSuccess panicPurchaseDetail:dto];
    }
}

@end
