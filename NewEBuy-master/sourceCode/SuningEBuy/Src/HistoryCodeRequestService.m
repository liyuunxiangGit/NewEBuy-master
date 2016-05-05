//
//  HistoryCodeRequestService.m
//  SuningLottery
//
//  Created by yang yulin on 13-4-16.
//  Copyright (c) 2013年 suning. All rights reserved.
//

#import "HistoryCodeRequestService.h"
#import "HistoryCodeDto.h"

@interface HistoryCodeRequestService()
{
    
}

- (void)historyCodeRequestServiceFinished:(BOOL)isSuccess;

@end

@implementation HistoryCodeRequestService

- (void)dealloc
{
    TT_RELEASE_SAFELY(_lotteryId);

    HTTPMSG_RELEASE_SAFELY(_historyCodeMSG);

    TT_RELEASE_SAFELY(_historyCodeErrorMsg);

    TT_RELEASE_SAFELY(_historyCodeList);

}

- (void)sendHistoryCodeRequest:(NSString *)lotteryId
{

    NSString *url = [NSString stringWithFormat:@"%@/%@%@%@", kHostLotteryTicketForHttp, KLotteryHistoryCode, lotteryId, KLotteryHistoryCodeLast]; // 请求历史开奖号码接口

    HTTPMSG_RELEASE_SAFELY(_historyCodeMSG);
    
    _historyCodeMSG = [[HttpMessage alloc]initWithDelegate:self
                                                       requestUrl:url
                                                      postDataDic:nil
                                                          cmdCode:CC_NearbySuningSearch];
    
    [self.httpMsgCtrl sendHttpMsg:_historyCodeMSG];
    
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    NSDictionary *item = receiveMsg.jasonItems;
    
    _historyCodeList = [[NSMutableArray alloc]init];
    
    Background_Begin
    
    if ([[item objectForKey:kHttpResponseCode]isEqualToString:@"0"])
    {
        NSObject *obj = [item objectForKey:@"row"];
        
        if ([obj isKindOfClass:[NSArray class]])
        {
            // 当后台返回的数据多余1条时，[jsonDic objectForKey:@"row"]中的对象是数组
            
            NSArray *array = (NSArray *)obj;
            
            if (array && ([array count] > 0))
            {
                for (NSDictionary *tempDic in array)
                {
                    HistoryCodeDto *dto = [[HistoryCodeDto alloc]init];
                    
                    [dto decodeFromDictionary:tempDic];
                    
                    [self.historyCodeList addObject:dto];
                    
                    DLog(@"the arr === %@", self.historyCodeList);
                    
                    TT_RELEASE_SAFELY(dto);
                }
            }
        }
        else
        {
            // 当后台只返回一条数据时，[rowsDic objectForKey:@"row"]中的对象不是数组，而是字典
            NSDictionary *rowDic = (NSDictionary *)obj;
            
            HistoryCodeDto *dto = [[HistoryCodeDto alloc]init];
            
            [dto decodeFromDictionary:rowDic];
            
            [self.historyCodeList addObject:dto];
            
            TT_RELEASE_SAFELY(dto);
        }
        
        self.historyCodeErrorMsg = nil;
    
        Foreground_Begin

        [self historyCodeRequestServiceFinished:YES];

        Foreground_End
    }
    else
    {
        self.errorDesc = [item objectForKey:kHttpResponseDesc];
        
        self.errorCode = [item objectForKey:kHttpResponseCode];
        
        self.errorMsg = self.errorDesc;
        
        Foreground_Begin
        
        [self historyCodeRequestServiceFinished:NO];
        
        Foreground_End
    }
    Background_End
}


- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    [self historyCodeRequestServiceFinished:NO];
}

- (void)historyCodeRequestServiceFinished:(BOOL)isSuccess
{
    if (_delegate && [_delegate respondsToSelector:@selector(historyCodeRequestServiceComplete:isSuccess:)]) {
        [_delegate historyCodeRequestServiceComplete:self isSuccess:isSuccess];
    }
}

@end
