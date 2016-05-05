//
//  ProductAppraisalDTO.m
//  SuningEBuy
//
//  Created by 正来 崔 on 12-9-18.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "ProductAppraisalDTO.h"

@implementation ProductAppraisalDTO

@synthesize contents=_contents;
@synthesize person  =_person;
@synthesize time    =_time;
@synthesize stars   =_stars;
@synthesize title = _title;

-(void)encodeFromDictionary:(NSDictionary *)dic
{
    
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    if(NotNilAndNull([dic objectForKey:kHttpResponseEvaluationContents])){
        self.contents=[dic objectForKey:kHttpResponseEvaluationContents ];
    }
    if(NotNilAndNull([dic objectForKey:kHttpResponseEvaluationPerson ])){
        self.person=[dic objectForKey:kHttpResponseEvaluationPerson];
    }
    if(NotNilAndNull([dic objectForKey:kHttpResponseEvaluationTime])){
        self.time=[dic objectForKey:kHttpResponseEvaluationTime];
    }
    if(NotNilAndNull([dic objectForKey:kHttpResponseEvaluationTitle])){
        self.title=[dic objectForKey:kHttpResponseEvaluationTitle];
    }
    if(NotNilAndNull([dic objectForKey:kHttpResponseEvaluationStars])){
        self.stars=[dic objectForKey:kHttpResponseEvaluationStars];
    }
    
}


@end
