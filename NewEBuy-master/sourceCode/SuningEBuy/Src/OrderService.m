//
//  LotteryOrderListService.m
//  SuningLottery
//
//  Created by MagicStudio on 12-7-30.
//  Copyright (c) 2012年 suning. All rights reserved.
//

#import "OrderService.h"
#import "LotteryOrderDto.h"

@interface OrderService ()

- (void)lotteryDealListHttpFinished:(BOOL)isSuccess;

- (void)lotteryDealsSerialNumberListHttpFinished:(BOOL)isSuccess;


@end

@implementation OrderService

@synthesize orderList = _orderList;
@synthesize pageCount = _pageCount;
@synthesize unLoginErrorCode;



-(void)dealloc
{
    TT_RELEASE_SAFELY(_pageCount);
    TT_RELEASE_SAFELY(_orderList);
    
    HTTPMSG_RELEASE_SAFELY(lotteryDealListMSG);
    HTTPMSG_RELEASE_SAFELY(lotteryDealsSerialNumberListMSG);
    
    TT_RELEASE_SAFELY(unLoginErrorCode);
    
}

- (id)init 
{
    self = [super init];
    if (self) 
    {
        self.pageCount = @"0";
        
        _isAddRightItem = YES;

        if (!_orderList) 
        {
            _orderList = [[NSMutableArray alloc] init];
        }
    }
    return self;
}

-(void)sendLotteryDealListHttpRequest:(NSDictionary *)postDic
{
    [self.orderList removeAllObjects];
    
    
//    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostLotteryTicketForHttps,@"user/queryMobile5.go"];
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostLotteryTicketForHttp,@"user/queryMobile5.go"];

    
    SERVICE_RELEASE_SAFELY(lotteryDealListMSG);
    
    lotteryDealListMSG = [[HttpMessage alloc] initWithDelegate:self
                                                    requestUrl:url
                                                   postDataDic:postDic
                                                       cmdCode:CC_DealsList];
    
    [self.httpMsgCtrl sendHttpMsg:lotteryDealListMSG];
    
}

-(void)sendLotteryDealsSerialNumberListHttpRequest:(NSDictionary *)postDic
{
    [self.orderList removeAllObjects];
    
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostLotteryTicketForHttp,KLotteryTicketOrderList];
    
    SERVICE_RELEASE_SAFELY(lotteryDealsSerialNumberListMSG);
    
    lotteryDealsSerialNumberListMSG = [[HttpMessage alloc] initWithDelegate:self
                                                                 requestUrl:url
                                                                postDataDic:postDic
                                                                    cmdCode:CC_DealsSerialNumberList];
    
    [self.httpMsgCtrl sendHttpMsg:lotteryDealsSerialNumberListMSG];
    
}

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    if (receiveMsg.cmdCode == CC_DealsList)
    {
        [self lotteryDealListHttpFinished:YES];
    }
    else if (receiveMsg.cmdCode == CC_DealsSerialNumberList)
    {
        [self lotteryDealsSerialNumberListHttpFinished:YES];
    }
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    self.errorMsg = @"";
    
    [self.orderList removeAllObjects];
    
    //订单列表请求
	if (receiveMsg.cmdCode == CC_DealsList)
    {
        NSDictionary *items = receiveMsg.jasonItems;
        
        //取session失效值
        NSDictionary *xml = [items objectForKey:@"xml"];
        
        self.unLoginErrorCode = [xml objectForKey:@"@errorCode"];
        
        if ([[items objectForKey:kHttpResponseCode]isEqualToString:@"0"])
        {
            NSDictionary *rowsDic = [items objectForKey:@"rows"];
            self.totalPages  = [[rowsDic objectForKey:@"@tp"] integerValue];
            
            if (rowsDic)
            {
                
                NSObject *obj = [rowsDic objectForKey:@"row"];
                
                if ([obj isKindOfClass:[NSArray class] ])
                {
                    
                    //当后台返回的数据多余1条时，[rowsDic objectForKey:@"row"]中的对象是数组
                    
                    NSArray *array = (NSArray *)obj;
                    
                    if (array && [array count]> 0)
                    {
                        
                        for (NSDictionary *tempDic in array)
                        {
                            
                            LotteryDealsDto *dto = [[LotteryDealsDto alloc]init];
                            
                            [dto encodeFromDictionary:tempDic];
                            
                            [self.orderList addObject:dto];
                            
                            TT_RELEASE_SAFELY(dto);
                        }
                    }
                    
                }
                else
                {
                    //当后台只返回一条数据时，[rowsDic objectForKey:@"row"]中的对象不是数组，而是字典
                    NSDictionary *rowDic = (NSDictionary *)obj;
                    
                    LotteryDealsDto *dto = [[LotteryDealsDto alloc]init];
                    
                    [dto encodeFromDictionary:rowDic];
                    
                    [self.orderList addObject:dto];
                    
                    TT_RELEASE_SAFELY(dto);
                }
                
                self.pageCount = [rowsDic objectForKey:@"@tp"];
                
            }
            [self lotteryDealListHttpFinished:YES];
        }
        else
        {
            self.errorMsg = @"";//[items objectForKey:kHttpResponseDesc];
            
            [self lotteryDealListHttpFinished:YES];
        }
        
    }else if (receiveMsg.cmdCode == CC_DealsSerialNumberList)
    {
        NSDictionary *items = receiveMsg.jasonItems;
        
        //取session失效值
        NSDictionary *xml = [items objectForKey:@"xml"];
        
        self.unLoginErrorCode= [xml objectForKey:@"@errorCode"];
        
        DLog(@"msg_sn:%@",items);
        if ([[items objectForKey:kHttpResponseCode]isEqualToString:@"0"])
        {
            
            NSDictionary *rowsDic = [items objectForKey:@"rows"];
            self.totalPages  = [[rowsDic objectForKey:@"@tp"] integerValue];
            
            if (rowsDic)
            {
                
                NSObject *obj = [rowsDic objectForKey:@"row"];
                
                if ([obj isKindOfClass:[NSArray class] ])
                {
                    
                    //当后台返回的数据多余1条时，[rowsDic objectForKey:@"row"]中的对象是数组
                    
                    NSArray *array = (NSArray *)obj;
                    
                    if (array && [array count]> 0)
                    {
                        
                        for (NSDictionary *tempDic in array)
                        {
                            
                            LotteryDealsSerialNumberDto *dto = [[LotteryDealsSerialNumberDto alloc]init];
                            
                            [dto encodeFromDictionary:tempDic];
                            
                            [self.orderList addObject:dto];
                            
                            TT_RELEASE_SAFELY(dto);
                        }
                    }
                    
                }
                else
                {
                    
                    //当后台只返回一条数据时，[rowsDic objectForKey:@"row"]中的对象不是数组，而是字典
                    NSDictionary *rowDic = (NSDictionary *)obj;
                    
                    LotteryDealsSerialNumberDto *dto = [[LotteryDealsSerialNumberDto alloc]init];
                    
                    [dto encodeFromDictionary:rowDic];
                    
                    [self.orderList addObject:dto];
                    
                    TT_RELEASE_SAFELY(dto);
                }
                
                self.pageCount = [rowsDic objectForKey:@"@tp"];
                
            }

            [self lotteryDealsSerialNumberListHttpFinished:YES];

        }else{
            
            self.errorMsg = @"";//[items objectForKey:kHttpResponseDesc];
            
            [self lotteryDealsSerialNumberListHttpFinished:YES];
        }
    }
    
}

- (void)lotteryDealListHttpFinished:(BOOL)isSuccess
{
    if (_delegate && [_delegate respondsToSelector:@selector(lotteryDealListHttpComplete:)]) {
        [_delegate lotteryDealListHttpComplete:isSuccess];
    }
}


- (void)lotteryDealsSerialNumberListHttpFinished:(BOOL)isSuccess
{
    if (_delegate && [_delegate respondsToSelector:@selector(lotteryDealsSerialNumberListHttpComplete:)]) {
        [_delegate lotteryDealsSerialNumberListHttpComplete:isSuccess];
    }
}


@end