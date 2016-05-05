//
//  SecondKillListService.m
//  SuningEBuy
//
//  Created by cui zl on 13-2-26.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "SecondKillListService.h"

@implementation SecondKillListService

@synthesize delegate = _delegate;


-(id)init{
    
    self = [super init];
    
    if(self){
        
    }
    return self;
}


-(void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(secondKillListHttpMsg);
}

-(void)beginSecondKillList{
    
    NSString *cityId = [Config currentConfig].defaultCity;
    
    NSString *url=[NSString stringWithFormat:@"%@/rps-web/rp/rushPurActListForMT_%@_%@_%@.htm",kHostPanicPurchaseForHttp,kActChanID,kMtID,cityId];
    
    HTTPMSG_RELEASE_SAFELY(secondKillListHttpMsg);
    
    secondKillListHttpMsg=[[HttpMessage alloc]initWithDelegate:self
                                                requestUrl:url
                                               postDataDic:nil
                                                   cmdCode:CC_SecondKillList];
    
    [self.httpMsgCtrl sendHttpMsg:secondKillListHttpMsg];
    
}

-(void)parseSecondKillList:(NSDictionary*)items
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @autoreleasepool {
            NSArray *array = [items objectForKey:@"rpList"];
            
            NSMutableArray *purchases = nil;
            NSInteger count = 0;
            if (NotNilAndNull(array) && [array count] > 0) {
                purchases = [[NSMutableArray alloc] initWithCapacity:[array count]];
                for (NSDictionary *item in array)
                {
                    
                    PanicPurchaseDTO *itemDTO = [[PanicPurchaseDTO alloc] init];
                    
                    [itemDTO encodeRushForMobileFromDic:item];
                    
                    [purchases addObject:itemDTO];
                    
                    TT_RELEASE_SAFELY(itemDTO);
                    //只解析服务器返回的前7条数据
                    count++;
                    
                    if(count>= 7)break;
                    
                }
                
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self getSecondKillListFinish:YES list:purchases];
            });
            
        }
    });

}

-(void)getSecondKillListFinish:(BOOL)isSuccess list:(NSArray*)list
{
    if (_delegate && [_delegate respondsToSelector:@selector(getSecondKillListCompletionWithResult:errorMsg:secondKillList:)]) {
        [_delegate getSecondKillListCompletionWithResult:isSuccess errorMsg:self.errorMsg secondKillList:list];
    }
    
}

-(void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    if(receiveMsg.cmdCode == CC_SecondKillList)
    {
        
    }
}

-(void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    
    NSDictionary *items= receiveMsg.jasonItems;
    
    if(receiveMsg.cmdCode == CC_SecondKillList)
    {
        if (!items) {
            
             self.errorMsg = kHttpResponseJSONValueFailError;
            
            [self getSecondKillListFinish:NO list:nil];
            
        }else{
            
            [self parseSecondKillList:items];
        }
    }
}

@end
