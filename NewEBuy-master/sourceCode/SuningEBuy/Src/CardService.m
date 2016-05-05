//
//  CardService.m
//  SuningEBuy
//
//  Created by YANG on 14-3-12.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "CardService.h"
#import "SNCache.h"
@interface CardService()
{
    CFAbsoluteTime  startTime;
    CFAbsoluteTime  endTime;
}
@end
@implementation CardService

-(void)dealloc
{
    _delegate = nil;
    
}

-(void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(cardMsg);
    HTTPMSG_RELEASE_SAFELY(subscribMsg);
    
}

- (void)beginGetCardInfo:(NSString *)custNum WithName:(NSString *)nickName
{
    startTime = CFDateGetAbsoluteTime((CFDateRef)[NSDate date]);
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    
    [dic setObject:IsStrEmpty(custNum)?@"":custNum forKey:@"custNum"];

    NSString *url = [NSString stringWithFormat:@"%@%@",KNewHomeAPIURL,@"mts-web/appbuy/social/querySocialityInfo.do"];
    
    HTTPMSG_RELEASE_SAFELY(cardMsg);
    
    cardMsg = [[HttpMessage alloc] initWithDelegate:self
                                         requestUrl:url
                                        postDataDic:dic
                                            cmdCode:CC_ChangeUserImage];
    
    [self.httpMsgCtrl sendHttpMsg:cardMsg];
    
    TT_RELEASE_SAFELY(dic);
}

#pragma mark -
#pragma mark -- httpMessage delegate

-(void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    if (receiveMsg.cmdCode == CC_ChangeUserImage)
    {
        if (KPerformance)
        {
            PerformanceStatisticsHttp* temp = [[PerformanceStatisticsHttp alloc] init];
            temp.startTime = [NSDate date];
            temp.functionId = @"4";
            temp.interfaceId = @"406";
            temp.errorType = @"02";
            temp.errorCode = [NSString stringWithFormat:@"%@",receiveMsg.errorCode];
            [[PerformanceStatistics sharePerformanceStatistics]sendCustomNetData:temp];
        }

        if (_delegate && [_delegate respondsToSelector:@selector(getCardInfoCompletedWithResult:infoDto:errorMsg:)])
        {
            [_delegate getCardInfoCompletedWithResult:NO
                                              infoDto:nil
                                             errorMsg:self.errorMsg];
        }
    }
}


-(void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    if (receiveMsg.cmdCode == CC_ChangeUserImage)
    {
        NSDictionary *dic = [receiveMsg jasonItems];
        
        if (dic == nil)
        {
            self.errorMsg = kHttpResponseJSONValueFailError;
            
            if (_delegate && [_delegate respondsToSelector:@selector(getCardInfoCompletedWithResult:infoDto:errorMsg:)])
            {
                [_delegate getCardInfoCompletedWithResult:NO
                                                  infoDto:nil
                                                 errorMsg:self.errorMsg];
            }
        }
        
        NSString *successFlg = [dic objectForKey:@"successFlg"];
        
        self.errorMsg = [dic objectForKey:@"errorMsg"];
        
        if ([successFlg isEqualToString:@"COMPLETE"])
        {
            [self parseLogisticsList:dic];
        }
        else
        {
            
            if (_delegate && [_delegate respondsToSelector:@selector(getCardInfoCompletedWithResult:infoDto:errorMsg:)])
            {
                [_delegate getCardInfoCompletedWithResult:NO
                                                  infoDto:nil
                                                 errorMsg:self.errorMsg];
            }
        }
        
    }
}

-(void)parseLogisticsList:(NSDictionary *)dic
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @autoreleasepool
        {
            
            CardDTO *dto = [[CardDTO alloc] init];
            
            [dto encodeFromDictionary:dic];
            
            if ([dto.custNum isEqualToString:[UserCenter defaultCenter].userInfoDTO.custNum]) {
                NSData *jsonData = [[dic JSONRepresentation] dataUsingEncoding:NSUTF8StringEncoding];
                [[SNFileCache defaultCache] saveData:jsonData forKey:@"sn.wb.myCardInfo" cacheAge:kSNCacheAgeForever];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (_delegate && [_delegate respondsToSelector:@selector(getCardInfoCompletedWithResult:infoDto:errorMsg:)])
                {
                    endTime = CFDateGetAbsoluteTime((CFDateRef)[NSDate date]);
                    //                    DLog(@"startTime = %f",startTime);
                    //                    DLog(@"endTime = %f",endTime);
                    //                    DLog(@"ssssss = %f",endTime - startTime);
                    [_delegate getCardInfoCompletedWithResult:YES
                                                      infoDto:dto
                                                     errorMsg:nil];
                }
            });
        }
    });
}



@end
