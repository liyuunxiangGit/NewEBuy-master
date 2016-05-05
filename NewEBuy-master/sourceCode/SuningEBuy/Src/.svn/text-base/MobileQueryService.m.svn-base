//
//  MobileQueryService.m
//  SuningEBuy
//
//  Created by  liukun on 13-2-1.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "MobileQueryService.h"

@interface MobileQueryService()



@end

/*********************************************************************/

@implementation MobileQueryService

@synthesize delegate = _delegate;

- (void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(mobilePayOrderListHttpMsg);
}

#pragma mark -
#pragma mark service life

- (void)requestMobileOrderWithPage:(NSInteger)page
{
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] initWithCapacity:5];
    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
    [postDataDic setObject:@"SN_IPHONE" forKey:@"partner"];
    
    UserInfoDTO *user = [UserCenter defaultCenter].userInfoDTO;
    [postDataDic setObject:POST_VALUE(user.accountNo) forKey:@"accountNO"];
    [postDataDic setObject:[NSString stringWithFormat:@"%d", page] forKey:@"currentPage"];
    [postDataDic setObject:@"10" forKey:@"pageNum"];

    NSString *url = [NSString stringWithFormat:@"%@/%@", kHostAddressForHttp, [@"SNMTMobileOrderQuery" passport]];
    
    HTTPMSG_RELEASE_SAFELY(mobilePayOrderListHttpMsg);
    
    mobilePayOrderListHttpMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:url postDataDic:postDataDic cmdCode:CC_MobilepayOrderList];
    mobilePayOrderListHttpMsg.requestMethod =RequestMethodGet;
    TT_RELEASE_SAFELY(postDataDic);
    
    [self.httpMsgCtrl sendHttpMsg:mobilePayOrderListHttpMsg];
}

#pragma mark -
#pragma mark final

- (void)getOrderListOk:(BOOL)isSuccess retList:(NSArray *)list page:(SNPageInfo)page
{
    if ([_delegate respondsToSelector:@selector(requestMobileOrderComplete:errorMsg:orderList:page:)])
    {
        [_delegate requestMobileOrderComplete:isSuccess
                                     errorMsg:self.errorMsg
                                    orderList:list
                                         page:page];
    }
}

#pragma mark -
#pragma mark http message delegate

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    [self getOrderListOk:NO retList:nil page:SNPageInfoZero];
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{    
    NSDictionary *items = receiveMsg.jasonItems;
    NSString *errorCode = receiveMsg.errorCode;
    
    if (!items)
    {
        self.errorMsg = kHttpResponseJSONValueFailError;
        [self getOrderListOk:NO retList:nil page:SNPageInfoZero];
    }
    else if ([errorCode isEqualToString:@""])
    {
        [self parseOrderListData:items];
    }
    else
    {
        NSString *errorDesc = [items objectForKey:@"errorDesc"];
        self.errorMsg = errorDesc?errorDesc:kHttpResponseJSONValueFailError;
        [self getOrderListOk:NO retList:nil page:SNPageInfoZero];
    }
    
}

#pragma mark -
#pragma mark parse data

- (void)parseOrderListData:(NSDictionary *)items
{
    Background_Begin
    
    NSMutableArray *retArray = nil;
    
    NSArray *accountInfoArr = [items objectForKey:@"accountInfo"];
    if ([accountInfoArr count] > 0)
    {
        retArray = [NSMutableArray arrayWithCapacity:[accountInfoArr count]];
        for (NSDictionary *dic in accountInfoArr)
        {
            MobileQueryDTO *dto = [[MobileQueryDTO alloc] init];
            [dto encodeFromDictionary:dic];
            [retArray addObject:dto];
        }
    }
    
    NSInteger currentPage = [[items objectForKey:@"currentPage"] integerValue];
    NSInteger totalPage = [[items objectForKey:@"totalPages"] integerValue];
    NSInteger pageNum = [[items objectForKey:@"pageNum"] integerValue];

    SNPageInfo pageInfo = SNPageInfoMake(currentPage, totalPage, pageNum);

    Foreground_Begin
    [self getOrderListOk:YES retList:retArray page:pageInfo];
    Foreground_End
    
    Background_End
}

@end
