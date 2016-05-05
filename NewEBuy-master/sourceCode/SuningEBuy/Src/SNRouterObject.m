//
//  SNRouterObject.m
//  SuningEBuy
//
//  Created by liukun on 14-7-15.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "SNRouterObject.h"

@implementation SNRouterObject

- (instancetype)initWithURLString:(NSString *)url source:(SNRouteSource)source
{
    self = [super init];
    if (self) {
        self.originUrl = url;
        self.source = source;
        [self parseUrl:url];
    }
    return self;
}

- (instancetype)initWithAdTypeCode:(NSString *)typeCode
                              adId:(NSString *)adId
                            source:(SNRouteSource)source
{
    self = [super init];
    if (self) {
        self.adTypeCode = typeCode;
        self.adId = adId;
        self.allParams = @{@"adTypeCode": typeCode?typeCode:@"",
                              @"adId": adId?adId:@""};
        self.source = source;
    }
    return self;
}

- (instancetype)initWithAdTypeCode:(NSString *)typeCode
                              adId:(NSString *)adId
                            chanId:(NSString *)chanId
                           qiangId:(NSString *)qiangId
                            source:(SNRouteSource)source
{
    self = [super init];
    if (self) {
        self.adTypeCode = typeCode;
        self.adId = adId;
        
        self.allParams = @{@"adTypeCode": typeCode?typeCode:@"",
                              @"adId": adId?adId:@"",
                              @"chanId": chanId?chanId:@"",
                              @"qiangId": qiangId?qiangId:@""};
        self.source = source;
    }
    return self;
}

- (void)parseUrl:(NSString *)url
{
    url = url.trim; //去掉两端的空格
    
    //检验是否是正常的url
    NSRegularExpression *regularEx = [NSRegularExpression regularExpressionWithPattern:@"^http(s)?://" options:NSRegularExpressionCaseInsensitive error:NULL];
    BOOL isHTTPUrl = [regularEx numberOfMatchesInString:url options:NSMatchingReportCompletion range:NSMakeRange(0, url.length)];
    
    NSRegularExpression *regularShceme = [NSRegularExpression regularExpressionWithPattern:@"^com.suning.SuningEBuy://" options:NSRegularExpressionCaseInsensitive error:NULL];
    
    if (isHTTPUrl)
    {
        //判断参数中是否包含adTypeCode， 不包含默认为未知Url:
        //去除多余的空格
        url = [url stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        NSDictionary *paramDic;
        
        if (IsStrEmpty([[NSURL URLWithString:url] query]))
        {
            NSRange range = [url rangeOfString:@"?"];
            
            if (range.location == NSNotFound)
            {
                paramDic = nil;
                
            }else{
                
                url = [url substringFromIndex:range.location+1];
                
                paramDic = [url queryDictionaryUsingEncoding:NSUTF8StringEncoding];
            }
        }else{
            
            paramDic = [[[NSURL URLWithString:url] query] queryDictionaryUsingEncoding:NSUTF8StringEncoding];
        }
        
        self.allParams = paramDic;
        
        //adTypeCode可从"adTypeCode" 或 "utm_term" 中解析：
        NSString *adTypeCode = EncodeStringFromDic(paramDic, @"adTypeCode").trim;
        //如果没有，就查找utm_term
        if (!adTypeCode.length) {
            adTypeCode = EncodeStringFromDic(paramDic, @"utm_term").trim;
        }
        
        if (adTypeCode.length)
        {
            //获取adId
            NSString *adId = EncodeStringFromDic(paramDic, @"adId").trim;
            if (!adId.length) {
                adId = EncodeStringFromDic(paramDic, @"utm_content");
            }
            
            self.adTypeCode = adTypeCode;
            
            self.adId = adId;
            
            if (self.source == SNRouteSourceScan&&([adTypeCode intValue] == 1019||[adTypeCode intValue] == 1020||[adTypeCode intValue] == 1050))
            {
                NSString *mtsId = EncodeStringFromDic(paramDic, @"mtsid").trim;
                
                if (mtsId.length > 0)
                {
                    self.adId = mtsId;
                    
                }else{
                    
                    self.adTypeCode = @"1002";
                    
                    NSRange range = [self.originUrl rangeOfString:@"?"];
                    
                    if (range.location == NSNotFound)
                    {
                        self.adTypeCode = kRouterUnrecognizedTypeCode;
                        
                        return;
                    }else{
                        
                        self.adId = [self.originUrl substringToIndex:range.location];
                    }
                }
            }
        }
        //扫码登陆注册老逻辑
        else if ([url hasPrefix:@"http://mapp.suning.com/a.php?"])
        {
            self.adTypeCode = kRouterScanLoginRegistTypeCode;
        }
        else
        {
            self.adTypeCode = kRouterUnknownHttpUrlTypeCode;
        }
    }
    //通过OpenURL打开
    else if ([regularShceme numberOfMatchesInString:url options:NSMatchingReportCompletion range:NSMakeRange(0, url.length)])
    {
        self.source = SNRouteSourceOpenUrl;
        NSString *urlWithoutScheme = [url substringFromIndex:[kURLSchemeSuningEBuy length]];
        NSRange range = [urlWithoutScheme rangeOfString:@"?"];
        if (range.location == NSNotFound)
        {
            //do nothing
            self.adTypeCode = kRouterDoNothingTypeCode;
        }
        else
        {
            NSString *action = [urlWithoutScheme substringToIndex:range.location];
            NSString *result = [urlWithoutScheme substringFromIndex:range.location+1];
            NSDictionary *paramDic = [result queryDictionaryUsingEncoding:NSUTF8StringEncoding];
            self.allParams = paramDic;
            
            if ([action isEqualToString:@"wapToEbuy"]) //wap页到客户端对应页面
            {
                NSString *adTypeCode = paramDic[@"adTypeCode"];
                self.adTypeCode = adTypeCode;
                self.adId = paramDic[@"adId"];
            }
            else if ([action isEqualToString:@"DGFQ"])
            {
                self.adTypeCode = kRouterLotteryPayTypeCode;
                
                NSRange urlRange = [result rangeOfString:@"&"];
                
                if (urlRange.location != NSNotFound)
                {
                    result = [result stringByReplacingOccurrencesOfString:@"&" withString:@"?"];
                }
                
                self.adId = result;
            }
            else
            {
                self.adTypeCode = kRouterDoNothingTypeCode;
            }
        }
    }
    else
    {
        //未识别
        self.adTypeCode = kRouterUnrecognizedTypeCode;
    }
}

//保证不为空
- (NSDictionary *)allParams
{
    if (!_allParams) {
        _allParams = [[NSDictionary alloc] init];
    }
    return _allParams;
}

- (void)setParam:(NSObject *)obj forKey:(NSString *)key
{
    if (obj && key) {
        NSMutableDictionary *allParams = [self.allParams mutableCopy];
        [allParams setObject:obj forKey:@"cityCode"];
        self.allParams = [allParams copy];
    }
}

- (void)addParams:(NSDictionary *)params
{
    NSMutableDictionary *allParams = [self.allParams mutableCopy];
    [allParams addEntriesFromDictionary:params];
    self.allParams = [allParams copy];
}

- (BOOL)isErrorOrDoNothing
{
    return (self.errorMsg.length > 0 || [self.adTypeCode isEqualToString:kRouterDoNothingTypeCode]);
}

- (NSString *)description
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    if (self.originUrl) {
        [dic setObject:self.originUrl forKey:@"originUrl"];
    }
    [dic addEntriesFromDictionary:self.allParams];
    if (self.targetController) {
        [dic setObject:NSStringFromClass([self.targetController class]) forKey:@"targetVC"];
    }
    if (self.errorMsg.length) {
        [dic setObject:self.errorMsg forKey:@"error"];
    }
    return [dic description];
}

@end
