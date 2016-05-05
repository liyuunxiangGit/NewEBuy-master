//
//  SpecialSubjectService.m
//  SuningEBuy
//
//  Created by  on 12-10-30.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "SpecialSubjectService.h"

@interface SpecialSubjectService(){

    BOOL isloading;
}


- (void)parseSpecialSubjectItem:(NSDictionary *)items;

@end

/*********************************************************************/

@implementation SpecialSubjectService

@synthesize delegate = _delegate;

- (void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(getSpecialSubjectHttpMsg);
}

- (void)beginGetSpecialSubjectsRequest:(NSString *)appType withPomAreaId:(NSString *)areaId
{
    if (isloading) {
        return;
    }else{
        isloading = YES;
    
        NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] initWithCapacity:3];
        
        [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
        
        //分应用分渠道
        [postDataDic setObject:@"2" forKey:@"terminal"];
        [postDataDic setObject:IsStrEmpty(appType)?@"":appType forKey:@"appType"];
        if (!IsStrEmpty(areaId))
        {
            [postDataDic setObject:areaId forKey:@"promAreaId"];
        }
        NSString *url = [NSString stringWithFormat:@"%@/%@", kHostAddressForHttps, @"SNMobilePromAreaListView"];
        
        HTTPMSG_RELEASE_SAFELY(getSpecialSubjectHttpMsg);
        
        getSpecialSubjectHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                              requestUrl:url
                                                             postDataDic:postDataDic
                                                                 cmdCode:CC_SpecialSubject];
        TT_RELEASE_SAFELY(postDataDic);
        getSpecialSubjectHttpMsg.requestMethod =RequestMethodGet;
        [self.httpMsgCtrl sendHttpMsg:getSpecialSubjectHttpMsg];
    }
}

#pragma mark -
#pragma mark finaly

- (void)getSpecialSubjectsOk:(BOOL)isSuccess list:(NSArray *)list
{
    isloading = NO;
    
    if (_delegate && [_delegate respondsToSelector:@selector(getSpecialSubjectsCompletionWithResult:
                                                             errorMsg:
                                                             subjectList:)]) {
        [_delegate getSpecialSubjectsCompletionWithResult:isSuccess
                                                 errorMsg:self.errorMsg
                                              subjectList:list];
    }
}

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    [self getSpecialSubjectsOk:NO list:nil];
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    NSDictionary *items = receiveMsg.jasonItems;
    
    if (items) {
        [self parseSpecialSubjectItem:items];
    }else{
        self.errorMsg = kHttpResponseJSONValueFailError;
        [self getSpecialSubjectsOk:NO list:nil];
    }
}

- (void)parseSpecialSubjectItem:(NSDictionary *)items
{    
   // DLog(@"parseSpecialSubjectItem : %@", [items JSONRepresentation]);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @autoreleasepool {
            NSArray *array = [items objectForKey:@"areaList"];
            NSMutableArray *retArray = 0x00;
            
            if(NotNilAndNull(array) && [array count] > 0)
            {
                retArray = [[NSMutableArray alloc] initWithCapacity:[array count]];
                for(NSDictionary *dic in array)
                {
                    SNSpecialSubjectDTO *dto = [[SNSpecialSubjectDTO alloc] init];
                    [dto encodeFromDictionary:dic];
                    [retArray addObject:dto];
                    
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self getSpecialSubjectsOk:YES list:retArray];
            });

        } 
    });
}

@end
