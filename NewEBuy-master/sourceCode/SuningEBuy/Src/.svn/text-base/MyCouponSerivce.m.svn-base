//
//  MyCouponSerivce.m
//  SuningEBuy
//
//  Created by 正来 崔 on 12-9-11.
//  Copyright (c) 2012年 Suning. All rights reserved.
///Users/sv n/SuningEBuy_MVC/SuningEBuy/Src/MyCouponSerivce.m

#import "MyCouponSerivce.h"
#import "MYEbuyCoumonDTO.h"
#import "ExCouponDto.h"

@implementation MyCouponSerivce


@synthesize delegate=_delegate;

@synthesize currentPage = _currentPage;
@synthesize totalPage = _totalPage;
@synthesize ticketDataList = _ticketDataList;
@synthesize totalAmount = _totalAmount;

- (id)init {
    self = [super init];
    if (self) {
        _state=-1;
        
    }
    return self;
}

- (void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(_myCouponMsg);
    HTTPMSG_RELEASE_SAFELY(_myExCouponMsg);
    
    [super httpMsgRelease];
}

- (void)sendMyCouponHttpRequest:(NSInteger)currentPage state:(NSInteger)state
{
    if(_state==-1||_state!=state)
    {
        self.ticketDataList=nil;
        _state=state;
        
    }
    
	NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
    
    NSString *storeId = @"10052";
    
    NSString *catalogId = @"10051";
    
    /*
     “易购券状态”，分别未｛未使用 已使用 已过期｝，触发不同的按钮，发送不同的请求
     defaut 3
     */
    NSInteger tempState;
    if (state!=0) {
        tempState=state;
    }else{
        tempState=3;
    }
    NSString *stateString =  [NSString stringWithFormat:@"%d", tempState]; 
    //默认初始化加载5条记录
    NSString *listsize =  [NSString stringWithFormat:@"%d", 5];
    
    NSString *pageNumber = [NSString stringWithFormat: @"%d",currentPage];
    
    //封装请求数组
    [postDataDic setObject:storeId forKey:@"storeId"];
    [postDataDic setObject:catalogId forKey:@"catalogId"];
    [postDataDic setObject:stateString forKey:@"state"];
    [postDataDic setObject:pageNumber forKey:@"pageNumber"];
    [postDataDic setObject:listsize forKey:@"listsize"];
    
	HTTPMSG_RELEASE_SAFELY(_myCouponMsg);
    NSString *url = [kHostAddressForHttps stringByAppendingFormat:@"/%@",[@"SNiPhoneAppMyGiftTicket" passport]];
    
	_myCouponMsg =[[HttpMessage alloc]initWithDelegate:self 
                                                    requestUrl:url 
                                                   postDataDic:postDataDic 
                                                       cmdCode:CC_MyCoupon];    
    _myCouponMsg.requestMethod =RequestMethodGet;
	[self.httpMsgCtrl sendHttpMsg:_myCouponMsg];
    
	TT_RELEASE_SAFELY(postDataDic);
	
}

- (void)getMyGiftTicketFinish:(BOOL)isSuccess
{
    if (_delegate && [_delegate respondsToSelector:@selector(myCouponHttpRequestCompletedWithService:isSucess:errorCode:)]) {
        [_delegate myCouponHttpRequestCompletedWithService:self isSucess:isSuccess errorCode:self.errorMsg];
    }
}

- (void)receiveDidFailed:(HttpMessage *)receiveMsg{
    
    [super receiveDidFailed:receiveMsg];
    
    if(receiveMsg.cmdCode ==CC_MyCoupon){
        [self getMyGiftTicketFinish:NO];
        
    }else{
        [self getMyExCouponFinish:NO];
    }
    
}
- (void)parseTicketData:(NSDictionary *)items
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @autoreleasepool {
            self.currentPage = [[items objectForKey: @"resultCurrentPage"]intValue];
            self.totalPage = [[items objectForKey:@"totlePage"]intValue];
            
            //用ticketDataList接受字典中的账户易购券列表
            NSArray *ticketDataList = [items objectForKey: @"ticketDataList"];
            
            NSMutableArray *tempList = nil;
            
            if(ticketDataList && [ticketDataList count]>0){
                
                tempList =
                [[NSMutableArray alloc] initWithCapacity:[ticketDataList count]];
                
                for (NSDictionary *dic in ticketDataList) {
                    
                    if ([dic isKindOfClass:[NSDictionary class]])
                    {
                        MYEbuyCoumonDTO *dto = [[MYEbuyCoumonDTO alloc] init];
                        
                        [dto encodeFromDictionary:dic];
                        
                        [tempList addObject:dto];
                        
                        TT_RELEASE_SAFELY(dto);
                    }
                }
                                
            }
            self.ticketDataList = tempList;
            
            self.totalAmount = EncodeStringFromDic(items, @"totalAmount");
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self getMyGiftTicketFinish:YES]; 
            });
        }
        
    });
}


-(void)sendExMyCouponHttpRequest:(NSInteger)currentPage
{
    NSMutableDictionary *postDataDic=[[NSMutableDictionary alloc]init];
    
    NSString *storeId=@"10052";
    
    NSString *catalogId=@"10051";
    
    NSString *pageNumber=[NSString stringWithFormat:@"%d",currentPage];
    
    [postDataDic setObject:storeId forKey:@"storeId"];
    
    [postDataDic setObject:catalogId forKey:@"catalogId"];
    
    [postDataDic setObject:pageNumber forKey:@"pageNumber"];
    
    HTTPMSG_RELEASE_SAFELY(_myExCouponMsg);
    
    NSString *url = [kHostAddressForHttps stringByAppendingFormat:@"/%@",[@"SNiPhoneMyElectronTicket" passport]];
    
    _myExCouponMsg=[[HttpMessage alloc]initWithDelegate:self 
                                             requestUrl:url 
                                            postDataDic:postDataDic 
                                                cmdCode:CC_MyExCoupon];
    _myExCouponMsg.requestMethod = RequestMethodGet;
    [self.httpMsgCtrl sendHttpMsg:_myExCouponMsg];
    
    TT_RELEASE_SAFELY(postDataDic);
}

-(void)getMyExCouponFinish:(BOOL)isSuccess{
    if (self.delegate && [_delegate respondsToSelector:@selector(myExCouponHttpRequestCompletedWithService:isSucess:errorCode:)]) {
        
        [_delegate myExCouponHttpRequestCompletedWithService:self isSucess:isSuccess errorCode:self.errorMsg];
        
    }
    
}
- (void)parseMyExCouponData:(NSDictionary *)items
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @autoreleasepool {
            self.currentPage = [[items objectForKey: @"resultCurrentPage"]intValue];
            self.totalPage = [[items objectForKey:@"totlePage"]intValue];
            
            //用ticketDataList接受字典中的账户易购券列表
            NSArray *ticketDataList = [items objectForKey: @"ticketDataList"];
            
            NSMutableArray *tempList = nil;
            
            if(ticketDataList && [ticketDataList count]>0){
                
                tempList = [[NSMutableArray alloc]init];
                
                NSArray *tempArray = [items objectForKey:@"ticketDataList"];
                
                if (tempArray && [tempArray count]>0) {
                    
                    for (NSDictionary *dic in tempArray) {
                        
                        ExCouponDto *dto = [[ExCouponDto alloc]init];
                        
                        [dto encodeFromDictionary:dic];
                        
                        [tempList addObject:dto];
                        
                        TT_RELEASE_SAFELY(dto);
                    }
                }
                        
            }
            self.ticketDataList = tempList;
            
            self.totalAmount = EncodeStringFromDic(items, @"snTeck");
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self getMyExCouponFinish:YES]; 
            });
        }
        
    });
}



- (void)receiveDidFinished:(HttpMessage *)receiveMsg{
    
    NSDictionary *items = receiveMsg.jasonItems;
    
    if (receiveMsg.cmdCode == CC_MyCoupon) {

        if (!items) {
            self.errorMsg = kHttpResponseJSONValueFailError;
            [self getMyGiftTicketFinish:NO];
        }else{
            NSString *isSuccess = [items objectForKey: @"isSuccess"];

            if ( [isSuccess isEqualToString:@"1"]) 
            {
                [self parseTicketData:items];
            }else{
                self.errorMsg = [items objectForKey: @"errorMessage"];
                [self getMyGiftTicketFinish:NO];
            }
        }
            
    }
    else if(receiveMsg.cmdCode==CC_MyExCoupon){
        
        if(!items){
            
            self.errorMsg=kHttpResponseJSONValueFailError;
            [self getMyExCouponFinish:NO];

        }else{
            
            NSString *isSuccess=[items objectForKey:@"isSuccess"];
            
            if([isSuccess isEqualToString:@"1"]){
                [self parseMyExCouponData:items];
                
            }else{
                self.errorMsg=[items objectForKey:@"errorMessage"];
                [self getMyExCouponFinish:NO];
            }
        }
        
    }
    
}


@end
