//
//  SearchService.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-8-20.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "SearchService.h"
#import "SolrSearchHistoryDAO.h"


@interface SearchService()

- (void)getHotKeywordsDidFinish:(BOOL)isSuccess;

- (void)parseHotKeywordItem:(NSDictionary *)item;

@end

/*********************************************************************/

@implementation SearchService

@synthesize delegate = _delegate;
@synthesize hotKeywordList = _hotKeywordList;

- (void)dealloc {
    TT_RELEASE_SAFELY(_hotKeywordList);
}

- (void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(getHotKeywordsHttpMsg);
}

#pragma mark -
#pragma mark beginings

- (void)beginGetHotKeywords
{
    NSDictionary *postDataDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 @"3", @"channel", nil];
//    
//    NSString *url = [NSString stringWithFormat:@"%@/%@", 
//                     kSearchHostAddressForHttp, kHttpRequestMobileHotWords];
    
#ifdef kPreTest
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",
                     kHostSuningMts, kNewHotWordsAction];
    
    HTTPMSG_RELEASE_SAFELY(getHotKeywordsHttpMsg);

    
#elif kSitTest
    NSString *url = [NSString stringWithFormat:@"%@/%@",
                     kHostSuningMts, kNewHotWordsAction];
    
    HTTPMSG_RELEASE_SAFELY(getHotKeywordsHttpMsg);
#elif kReleaseH
    NSString *url = [NSString stringWithFormat:@"%@/%@",
                     kNewHotWordsServer, kNewHotWordsAction];
    
    HTTPMSG_RELEASE_SAFELY(getHotKeywordsHttpMsg);
#endif
    
    getHotKeywordsHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                       requestUrl:url
                                                      postDataDic:postDataDic
                                                          cmdCode:CC_HotKeyword];
    [self.httpMsgCtrl sendHttpMsg:getHotKeywordsHttpMsg];
    
    TT_RELEASE_SAFELY(postDataDic);
}

#pragma mark -
#pragma mark custom method

- (void)getHotKeywordsDidFinish:(BOOL)isSuccess
{
    if (_delegate && [_delegate respondsToSelector:@selector(getHotKeywordsCompleteWithService:
                                                             Result:
                                                             errorMsg:)]) {
        [_delegate getHotKeywordsCompleteWithService:self Result:isSuccess errorMsg:self.errorMsg];
    }
}

#pragma mark -
#pragma mark service delegate

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];

    switch (receiveMsg.cmdCode) {
        case CC_HotKeyword:
            if (KPerformance)
            {
                PerformanceStatisticsHttp* temp = [[PerformanceStatisticsHttp alloc] init];
                temp.startTime = [NSDate date];
                temp.functionId = @"7";
                temp.interfaceId = @"701";
                temp.errorType = @"02";
                temp.errorCode = [NSString stringWithFormat:@"%@",receiveMsg.errorCode];
                [[PerformanceStatistics sharePerformanceStatistics]sendCustomNetData:temp];
            }
            [self getHotKeywordsDidFinish:NO];
            break;
        default:
            break;
    }
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    switch (receiveMsg.cmdCode) {
        case CC_HotKeyword:
        {
            if (receiveMsg.jasonItems) {
                [self parseHotKeywordItem:receiveMsg.jasonItems];
            }else{
                self.errorMsg = kHttpResponseJSONValueFailError;
                [self getHotKeywordsDidFinish:NO];
            }
            break;
        }
        default:
            break;
    }
}

#pragma mark -
#pragma mark parse data

- (void)parseHotKeywordItem:(NSDictionary *)item
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @autoreleasepool {
            NSArray *hotWordList = [item objectForKey:@"hotWord"];
            if (NotNilAndNull(hotWordList) && [hotWordList count] > 0) {
                NSMutableArray *hotWords = [[NSMutableArray alloc] initWithCapacity:12];
                NSMutableArray *defaultWords = [NSMutableArray array];
                self.hotWordDtoList = [[NSMutableArray alloc] initWithCapacity:12];
                
                for (int i = 0; i < hotWordList.count; i++) {
                    NSDictionary *dic = [hotWordList objectAtIndex:i];
                    
                    //热词类型为1,默认关键词是2，需要过滤
                    NSString *type = [dic objectForKey:@"type"];
                    if ([type isEqualToString:@"1"])
                    {
                        NSString *keyword = [dic objectForKey:@"hotwords"];
                        if (NotNilAndNull(keyword)) {
                            [hotWords addObject:keyword];
                        }
                        
                        HotWordDTO *dto = [[HotWordDTO alloc] init];
                        dto.hotwordsStr = [dic objectForKey:@"hotwords"];
                        dto.urlStr = [dic objectForKey:@"url"];
                        
                        [self.hotWordDtoList addObject:dto];
                        
                    }
                    else if ([type isEqualToString:@"2"])
                    {
                        HotWordDTO *dto = [[HotWordDTO alloc] init];
                        dto.hotwordsStr = [dic objectForKey:@"hotwords"];
                        dto.urlStr = [dic objectForKey:@"url"];
                        
                        [defaultWords addObject:dto];
                       
                    }
                    
                }
                 [DefaultKeyWordManager defaultManager].hotWordDtoList = defaultWords;
                self.hotKeywordList = hotWords;
                
                TT_RELEASE_SAFELY(hotWords);
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self getHotKeywordsDidFinish:YES];
            });

        }
    });
}


#pragma mark -
#pragma mark history key db manager

- (void)getLatestTwentyKeywordsWithCompletionBlock:(void (^)(NSArray *))completionBlock
{
    SolrSearchHistoryDAO *dao = [[SolrSearchHistoryDAO alloc] init];
    NSArray *twentyKeywords = [dao getLastestTwentyKeywords];
    TT_RELEASE_SAFELY(dao);
    
    completionBlock(twentyKeywords);
}

- (void)addKeywordToDB:(NSString *)keyword
       completionBlock:(void (^)(NSArray *))completionBlock
{
    SolrSearchHistoryDAO *dao = [[SolrSearchHistoryDAO alloc] init];
    [dao addKeywordToDB:keyword];
    NSArray *twentyKeywords = [dao getLastestTwentyKeywords];
    TT_RELEASE_SAFELY(dao);
    
    completionBlock(twentyKeywords);
}

- (void)deleteKeywordFromDB:(NSString *)keyword
            completionBlock:(void (^)(NSArray *))completionBlock
{
    SolrSearchHistoryDAO *dao = [[SolrSearchHistoryDAO alloc] init];
    [dao deleteKeywordFromDB:keyword];
    NSArray *twentyKeywords = [dao getLastestTwentyKeywords];
    TT_RELEASE_SAFELY(dao);
    
    completionBlock(twentyKeywords);
}

- (void)deleteAllKeywordsFromDBWithCompletionBlock:(void (^)(NSArray *))completionBlock
{
    SolrSearchHistoryDAO *dao = [[SolrSearchHistoryDAO alloc] init];
    [dao deleteAllSearchKeywordsFromDB];
    NSArray *twentyKeywords = [dao getLastestTwentyKeywords];
    TT_RELEASE_SAFELY(dao);
    
    completionBlock(twentyKeywords);
}

@end
