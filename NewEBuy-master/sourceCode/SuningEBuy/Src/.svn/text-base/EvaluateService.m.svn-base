//
//  NewEvaluateService.m
//  SuningEBuy
//
//  Created by 正来 崔 on 12-9-24.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "EvaluateService.h"

@implementation EvaluateService

@synthesize delegate=_delegate;
@synthesize errorDescMsg=_errorDescMsg;

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(_sendProductEvaluateMsg);
    
    [super httpMsgRelease];
}

- (void)sendProductEvaluateHttpRequest:(NSString *)productId 
                                rating:(NSString *)rating 
                              cityCode:(NSString *)cityCode 
                                 title:(NSString *)title 
                               content:(NSString *)content 
                                isBook:(BOOL)isBook

{
    
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
    
    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
    
    [postDataDic setObject:kHttpRequestHomeCatalogIdValue forKey:kHttpRequestHomeCatalogIdKey];
    
    [postDataDic setObject:productId ? productId : @"" forKey:KHttpRequestProductId];
    
    [postDataDic setObject:rating ? rating : @"" forKey:kHttpRequestScoreKey];
    
    [postDataDic setObject:cityCode ? cityCode : [Config currentConfig].defaultCity forKey:kHttpRequestCurrCityKey];
    
    [postDataDic setObject:title ? title : @"" forKey:kHttpRequestTitleKey];
    
    [postDataDic setObject:content ? content : @"" forKey:kHttpRequestContentKey];
    
    NSString *url = nil;
    if (isBook == YES) {
        [postDataDic setObject:@"22" forKey:kHttpRequestModelTypeKey];
        [postDataDic setObject:@"0" forKey:@"artType"];
        
        url = [NSString stringWithFormat:@"%@/%@", kHostAddressForHttps, [@"SNiPhonePublishBookArticle" passport]];
    } else
    {
        [postDataDic setObject:@"26" forKey:kHttpRequestModelTypeKey];
        
        url = [NSString stringWithFormat:@"%@/%@", kHostAddressForHttps, kHttpRequestGetPublishArticleKey];
    }
    
    
    HTTPMSG_RELEASE_SAFELY(_sendProductEvaluateMsg);
    
    _sendProductEvaluateMsg=[[HttpMessage alloc]initWithDelegate:self 
                                                      requestUrl:url 
                                                     postDataDic:postDataDic 
                                                         cmdCode:CC_Evaluate];
    
    [self.httpMsgCtrl sendHttpMsg:_sendProductEvaluateMsg];
    

    TT_RELEASE_SAFELY(postDataDic);

}


-(void)getEvaluateFinished:(BOOL)isSuccess
{
    if(self.delegate&&[_delegate respondsToSelector:@selector(NewEvaluateHttpRequestCompletedWithService:isSuccess:errorDescMsg:)]){
        
        [_delegate NewEvaluateHttpRequestCompletedWithService:self isSuccess:isSuccess errorDescMsg:self.errorDescMsg]; 
        
    }
}


-(void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    NSDictionary *items=receiveMsg.jasonItems;
    
    if(receiveMsg.cmdCode==CC_Evaluate)
    {
        NSString *errorCode = [items objectForKey:@"isSuccess"];
        
        if(items&&[errorCode isEqualToString:@"1"]){
            
            [self getEvaluateFinished:YES];
            
        }else{
            
            self.errorDescMsg = [items objectForKey:@"errorDesc"];
            
            if (self.errorDescMsg == nil || [self.errorDescMsg isEqualToString:@""])
            {
                self.errorDescMsg = @"Evaluate failed";
            }
            [self getEvaluateFinished:NO];
            
        }
    }
    
}


@end
