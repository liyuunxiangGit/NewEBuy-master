//
//  ProductConsultantDTO.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-2-27.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "ProductConsultantDTO.h"

// 电器咨询
#define kHttpResponseApplianceConsultUser        @"consultant"
#define kHttpResponseApplianceConsultContent     @"consultantContent"
#define kHttpResponseApplianceConsultReply       @"consultantReply"
#define kHttpResponseApplianceConsultTime        @"consultantTime"

// 图书咨询
#define kHttpResponseBooksConsultUser            @"consultant"
#define kHttpResponseBooksConsultContent         @"consultantContent"
#define kHttpResponseBooksConsultReply           @"suningReply"
#define kHttpResponseBooksConsultTime            @"consultantTime"

@implementation ProductConsultantDTO

@synthesize consultant = _consultant;
@synthesize consultantContent = _consultantContent;
@synthesize consultantReply = _consultantReply;
@synthesize consultantTime = _consultantTime;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_consultant);
    TT_RELEASE_SAFELY(_consultantContent);
    TT_RELEASE_SAFELY(_consultantReply);
    TT_RELEASE_SAFELY(_consultantTime);
    
}

- (NSDateFormatter *)dateFormatterApplianceServer
{
    NSDateFormatter *_dateFormatter = [[NSDateFormatter alloc] init];
    
    [_dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    
    return _dateFormatter;
}

- (NSDateFormatter *)dateFormatterBooksServer
{
    NSDateFormatter *_dateFormatter = [[NSDateFormatter alloc] init];
    
    [_dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    return _dateFormatter;
}

- (NSDateFormatter *)dateFormatterClient
{
    NSDateFormatter *_dateFormatter = [[NSDateFormatter alloc] init];
    
    [_dateFormatter setDateFormat:[NSString stringWithFormat:@"yyyy%@MM%@dd%@HH:mm",L(@"Product_Year"),L(@"Product_Month"),L(@"Product_Day")]];
    
    return _dateFormatter;
}

- (void)encodeFromApplianceDictionary:(NSDictionary *)dic
{
    if (dic == nil || [dic isEqual:[NSNull null]])
    {
        return;
    }
    
    NSString *name = [dic objectForKey:kHttpResponseApplianceConsultUser];
    NSString *content = [dic objectForKey:kHttpResponseApplianceConsultContent];
    NSString *reply = [dic objectForKey:kHttpResponseApplianceConsultReply];
    NSString *time = [dic objectForKey:kHttpResponseApplianceConsultTime];
    
    if (NotNilAndNull(name))
    {
        self.consultant = name;
    }
    
    if (NotNilAndNull(content))
    {
        self.consultantContent = content;
    }
    
    if (NotNilAndNull(reply))
    {
        self.consultantReply = reply;
    }
    
    if (NotNilAndNull(time))
    {
        
        NSDate *consultantDate = [[self dateFormatterApplianceServer] dateFromString:time];
        self.consultantTime = [[self dateFormatterClient] stringFromDate:consultantDate];
        
    }
}

- (void)encodeFromBooksDictionary:(NSDictionary *)dic
{
    if (dic == nil || [dic isEqual:[NSNull null]])
    {
        return;
    }
    
    NSString *name = [dic objectForKey:kHttpResponseBooksConsultUser];
    NSString *content = [dic objectForKey:kHttpResponseBooksConsultContent];
    NSString *reply = [dic objectForKey:kHttpResponseBooksConsultReply];
    NSString *time = [dic objectForKey:kHttpResponseBooksConsultTime];
    
    if (NotNilAndNull(name))
    {
        self.consultant = name;
    }
    
    if (NotNilAndNull(content))
    {
        self.consultantContent = content;
    }
    
    if (NotNilAndNull(reply))
    {
        self.consultantReply = reply;
    }
    
    if (NotNilAndNull(time))
    {
        NSDate *consultantDate = [[self dateFormatterBooksServer] dateFromString:time];
        self.consultantTime = [[self dateFormatterClient] stringFromDate:consultantDate];
    }
}

@end
