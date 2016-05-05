//
//  AssociationalWordService.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-8-22.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "AssociationalWordService.h"
#import "AssociationWordDTO.h"

@interface AssociationalWordService()
- (void)requestDidFinished:(BOOL)isSuccess;

- (void)parseResultData:(NSDictionary *)items;

@end

/*********************************************************************/

@implementation AssociationalWordService

@synthesize delegate = _delegate;
@synthesize wordList = _wordList;

- (void)dealloc {
    TT_RELEASE_SAFELY(_wordList);
}

- (void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(associationalHttpMsg);
}

#pragma mark -
#pragma mark operation

- (void)beginGetAssociationalWordWithKeyword:(NSString *)keyword associationalWordType:(AssociationalWordType)type
{
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] initWithCapacity:2];
    NSString *coreStr = (type == AssociationalWordMixType) ? @"electric" : @"book";
    [postDataDic setObject:coreStr forKey:@"core"];
    [postDataDic setObject:keyword?keyword:@"" forKey:@"keyword"];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@", kSearchHostAddressForHttp, kHttpRequestMobileAssocialWords];
    
    HTTPMSG_RELEASE_SAFELY(associationalHttpMsg);
    
    associationalHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                      requestUrl:url
                                                     postDataDic:postDataDic
                                                         cmdCode:CC_AssociationalWord];
    [self.httpMsgCtrl sendHttpMsg:associationalHttpMsg];
    
    TT_RELEASE_SAFELY(postDataDic);
}

#pragma mark -
#pragma mark delegate

- (void)requestDidFinished:(BOOL)isSuccess
{
    if (_delegate && [_delegate respondsToSelector:@selector(getAssociationalWordsCompletedWithResult:errorMsg:)]) {
        [_delegate getAssociationalWordsCompletedWithResult:isSuccess errorMsg:self.errorMsg];
    }
}

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    [self requestDidFinished:NO];
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    if (NotNilAndNull(receiveMsg))
    {
        if (NotNilAndNull(receiveMsg.jasonItems) && [receiveMsg.jasonItems isKindOfClass:[NSDictionary class]])
        {
            [self parseResultData:receiveMsg.jasonItems];
        }
    }else{
        [self requestDidFinished:NO];
    }
}

- (void)parseResultData:(NSDictionary *)items
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @autoreleasepool {
            NSArray *list = [items objectForKey:@"associateWords"];
            if ([list isKindOfClass:[NSArray class]] && list) {
                NSUInteger count = [list count] > 10 ? 10 : [list count];
                
                if (count > 0)
                {
                    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:count];
                    for (int i = 0; i < count; i++)
                    {
                        NSDictionary *dic = [list objectAtIndex:i];
                        NSString *__keyName = [dic objectForKey:@"keyword"];
                        
                        if (NotNilAndNull(__keyName)) {
                            
                            [array addObject:__keyName];
                        }
                    }
                    self.wordList = array;
                }else{
                    self.wordList = nil;
                }
                
                NSArray *typesList = [items objectForKey:@"associateTypes"];
                if (NotNilAndNull(typesList) && [typesList isKindOfClass:[NSArray class]]) {
                    NSUInteger count2 = [typesList count] > 10 ? 10 : [typesList count];
                    if (count2 > 0)
                    {
                        NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:count2];
                        for (int i = 0; i < count2; i++)
                        {
                            NSDictionary *dic = [typesList objectAtIndex:i];
                            AssociationWordDTO *dto = [[AssociationWordDTO alloc] init];
                            [dto encodeFromTypesDictionary:dic];
                            [array addObject:dto];
                        }
                        self.typesList = array;
                    }else{
                        self.typesList = nil;
                    }
                }
                
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self requestDidFinished:YES];
            });

        } 
    });
}

@end
