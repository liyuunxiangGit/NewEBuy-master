//
//  GBOrderListService.m
//  SuningEBuy
//
//  Created by xingxuewei on 13-2-26.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "GBOrderListService.h"
#import "GBOrderInfoDTO.h"

@implementation GBOrderListService

@synthesize delegate = _delegate;

- (void)dealloc
{
    
    TT_RELEASE_SAFELY(page);
}

- (void)httpMsgRelease
{
    [super httpMsgRelease];
    HTTPMSG_RELEASE_SAFELY(_GBOrderListMsg);
    
    TT_RELEASE_SAFELY(page);
    
    TT_RELEASE_SAFELY(orderList);
}

- (id)init
{
    self = [super init];
    if (self) {
        
        page = [[NSMutableArray alloc]init];
        
        orderList = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)beginGetGBOrderList:(NSInteger )orderState withSearchTime:(NSString *)searchTime  withCurrentPage:(NSInteger)currentPage
{
    NSString *url=[NSString stringWithFormat:@"%@/%@",kHostGroupBuyAddressForHttp,@"getOrderList.htm"];
    
    NSString *userId = [UserCenter defaultCenter].userInfoDTO.userId;
    
    if (IsStrEmpty(userId))
    {
        return;
    }
    
    NSMutableDictionary *postData = [[NSMutableDictionary alloc] initWithCapacity:5];
    
    [postData setValue:userId forKey:@"userId"];
    [postData setValue:@"0" forKey:@"terminalSign"];
    if (orderState !=-1) {
        [postData setValue:[NSString stringWithFormat:@"%d" ,orderState] forKey:@"orderState"];
    }
    [postData setValue:@"0" forKey:@"searchTime"];
    [postData setValue:[NSString stringWithFormat:@"%d",currentPage] forKey:@"pageNumber"];
    [postData setValue:@"12" forKey:@"pageSize"];
    
    
    NSString *sendString = [@"" queryStringNoEncodeFromDictionary:postData];
    
    NSString *encodeStr = [PasswdUtil encryptString:sendString
                                             forKey:@"SuningTG"
                                               salt:@"SuningTG"];
    
    NSDictionary *sendDic =[[NSDictionary alloc] initWithObjectsAndKeys:encodeStr,@"data", nil];
    HTTPMSG_RELEASE_SAFELY(_GBOrderListMsg);
    
    _GBOrderListMsg = [[HttpMessage alloc]initWithDelegate:self
                                                requestUrl:url
                                               postDataDic:sendDic
                                                   cmdCode:CC_GBOrderList];
    
    [self.httpMsgCtrl sendHttpMsg:_GBOrderListMsg];
    TT_RELEASE_SAFELY(sendDic);
}

//-(void)receiveDidFailed:(HttpMessage *)receiveMsg{
//
//    [super receiveDidFailed:receiveMsg];
//
//    if (receiveMsg.cmdCode == CC_GBOrderList) {
//
//        self.errorMsg = @"load_failed";
//
//        [self getGBOrderListFinished:NO];
//    }
//}

- (void)receiveDataFinished:(HttpMessage *)recieveMsg Data:(NSDictionary *)dataDic Result:(BOOL)isSuccess{
    
    if (recieveMsg.cmdCode == CC_GBOrderList) {
        if (isSuccess) {
            [self parseItems:dataDic];
            [self getGBOrderListFinished:YES];
            
        }else{
            
            self.errorMsg = L(@"ASI_CONNECTION_FAILURE_ERROR");
            
            [self getGBOrderListFinished:NO];
        }
        
    }
}


//- (void)receiveDidFinished:(HttpMessage *)receiveMsg{
//
//    [super receiveDidFinished:receiveMsg];
//
//    NSDictionary *items  = receiveMsg.jasonItems;
//
//    if (receiveMsg.cmdCode == CC_GBOrderList) {
//
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//
//            @autoreleasepool {
//
//                [self parseItems:items];
//
//            }
//              dispatch_async(dispatch_get_main_queue(), ^{
//
//                  [self getGBOrderListFinished:YES];
//
//              });
//        });
//
//        }else{
//
//            self.errorMsg = (@"load_failed");
//
//            [self getGBOrderListFinished:NO];
//        }
//
//}


- (void)getGBOrderListFinished:(BOOL)isSuccess{
    
    if (isSuccess) {
        if (_delegate && [_delegate respondsToSelector:@selector(getGBOrderListCompleted:orderList:page:errorMsg:)]) {
            [_delegate  getGBOrderListCompleted:YES orderList: orderList page:page errorMsg:self.errorMsg];
        }
    }else{
        
        if (_delegate && [_delegate respondsToSelector:@selector(getGBOrderListCompleted:orderList:page:errorMsg:)]) {
            [_delegate  getGBOrderListCompleted:NO orderList: nil page:nil errorMsg:self.errorMsg];
        }
    }
}

- (void)parseItems:(NSDictionary *)items{
    
    NSString *isLastPage = @"0";
    
    NSString *totalDataCount = @"0";
    
    NSString *pageNumber = @"0";
    
    NSString *pageSize = @"0";
    
    NSString *pageCount= @"0";
    
    NSString *indexNumber= @"0";
    
    TT_RELEASE_SAFELY(page);
    TT_RELEASE_SAFELY(orderList);
    
    page = [[NSMutableArray alloc]init];
    
    orderList = [[NSMutableArray alloc]init];
    
    if (NotNilAndNull(items)) {
        
        if (NotNilAndNull([items objectForKey:@"isLastPage"])) {
            
            isLastPage = [items objectForKey:@"isLastPage"];
        }
        
        if (NotNilAndNull([items objectForKey:@"totalDataCount"])) {
            
            totalDataCount = [items objectForKey:@"totalDataCount"];
        }
        
        
        if (NotNilAndNull([items objectForKey:@"pageNumber"])) {
            
            pageNumber = [items objectForKey:@"pageNumber"];
        }
        
        if (NotNilAndNull([items objectForKey:@"pageSize"])) {
            
            pageSize = [items objectForKey:@"pageSize"];
        }
        
        if (NotNilAndNull([items objectForKey:@"pageCount"])) {
            
            pageCount = [items objectForKey:@"pageCount"];
        }
        
        if (NotNilAndNull([items objectForKey:@"indexNumber"])) {
            
            indexNumber = [items objectForKey:@"indexNumber"];
        }
    }
    
    [page addObject:isLastPage];
    [page addObject:totalDataCount];
    [page addObject:pageNumber];
    [page addObject:pageSize];
    [page addObject:pageCount];
    [page addObject:indexNumber];
    
    
    NSDictionary *orderListData = [items objectForKey:@"orderList"];
    
    [self parseOrderList:orderListData];
    
}

- (void)parseOrderList:(NSDictionary *)orderListData{
    
    if (IsNilOrNull(orderListData)) {
        
        self.errorMsg = L(@"GBNoOrderRecode");
        
    }else{
        
        for (NSDictionary *dic in orderListData) {
            
            GBOrderInfoDTO * dto = [[GBOrderInfoDTO alloc]init];
            
            [dto encodeOrderListFromDic:dic];
            
            [orderList addObject:dto];
            
            TT_RELEASE_SAFELY(dto);
        }
    }
    
    
    
}

@end
