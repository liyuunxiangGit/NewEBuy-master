//
//  JPService.m
//  SuningEBuy
//
//  Created by  liukun on 13-1-25.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "JPService.h"

@interface JPService()



@end

/*********************************************************************/

@implementation JPService

@synthesize delegate = _delegate;

@synthesize isLoaded = _isLoaded;

- (void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(chouJiangHttpMsg);
}

#pragma mark -
#pragma mark service life

- (void)beginChouJiang
{
    //NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@", kHostAddressForHttps, @"SNGetDrawResultView"];
    
    HTTPMSG_RELEASE_SAFELY(chouJiangHttpMsg);
    chouJiangHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                  requestUrl:url
                                                 postDataDic:nil
                                                     cmdCode:CC_ChouJiang];
    [self.httpMsgCtrl sendHttpMsg:chouJiangHttpMsg];
    
    //[postDataDic release];
}

#pragma mark -
#pragma mark final

- (void)chouJiangOk:(BOOL)isSuccess
          errorCode:(NSString *)errorCode
             JPList:(NSArray *)list
             ZJInfo:(JPInfoDTO *)dto
{
    if ([_delegate respondsToSelector:@selector(chouJiangCompleteWithResult:errorCode:errorMsg:JPList:ZJInfo:)]) {
        [_delegate chouJiangCompleteWithResult:isSuccess
                                     errorCode:errorCode
                                      errorMsg:self.errorMsg
                                        JPList:list
                                        ZJInfo:dto];
    }
}

#pragma mark -
#pragma mark http message delegate

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    [self chouJiangOk:NO errorCode:nil JPList:nil ZJInfo:nil];
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    NSDictionary *items = receiveMsg.jasonItems;
    NSString *errorCode = receiveMsg.errorCode;
    
    if ([errorCode isEqualToString:@""])
    {
        _isLoaded = YES;
        
        JPInfoDTO *zjInfo = nil;
        NSMutableArray *jpList = nil;
        
        BOOL isZJ = [[items objectForKey:@"isZJ"] isEqualToString:@"1"];
        NSString *ZJID = [items objectForKey:@"ZJID"];
        NSArray *__JPList = [items objectForKey:@"JPList"];
        
        if (NotNilAndNull(__JPList) && [__JPList count] > 0)
        {
            jpList = [NSMutableArray arrayWithCapacity:[__JPList count]];
            for (int i = 1; i <= [__JPList count]; i++)
            {
                NSDictionary *dic = [__JPList objectAtIndex:i-1];
                JPInfoDTO *dto = [[JPInfoDTO alloc] init];
                [dto encodeFromDictionary:dic];
                //按顺序排奖项
                [jpList addObject:dto];
                
                if (isZJ && !IsStrEmpty(ZJID) && [ZJID isEqualToString:dto.jpId])
                {                    
                    zjInfo = dto;
                }
                
            }
        }
        
        [self chouJiangOk:YES errorCode:errorCode JPList:jpList ZJInfo:zjInfo];
        
    }
    else
    {
        if (!items) {
            self.errorMsg = kHttpResponseJSONValueFailError;
        }else{
            NSString *errorMsg = [items objectForKey:@"errorMsg"];
            self.errorMsg = NotNilAndNull(errorMsg)?errorMsg:kHttpResponseJSONValueFailError;
        }
        
        
        [self chouJiangOk:NO errorCode:errorCode JPList:nil ZJInfo:nil];
    }
}

#pragma mark -
#pragma mark parse data

@end
