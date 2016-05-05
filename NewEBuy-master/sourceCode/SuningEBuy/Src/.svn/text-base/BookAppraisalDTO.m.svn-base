//
//  BookAppraisalDTO.m
//  SuningEBuy
//
//  Created by lanfeng on 12-5-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BookAppraisalDTO.h"

@implementation BookAppraisalDTO


@synthesize evaluationPerson = _evaluationPerson;
@synthesize evaluationTitle = _evaluationTitle;
@synthesize evaluationContents = _evaluationContents;
@synthesize evaluationTime = _evaluationTime;
@synthesize score   = _score;

- (void)encodeFromDictionary:(NSDictionary *)dic{
    
    if (dic == nil) {
        return;
    }
    
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    NSString *str1 = [dic objectForKey:@"evaluationPerson"];
    NSString *str2 = [dic objectForKey:@"evaluationTitle"];
    NSString *str3 = [dic objectForKey:@"evaluationContents"];
    NSString *str4 = [dic objectForKey:@"evaluationTime"];
    NSString *str5 = [dic objectForKey:@"score"];
    
    if(NotNilAndNull(str1)){
        self.evaluationPerson=str1;
    }
    if(NotNilAndNull(str2)){
        self.evaluationTitle=str2;
    }
    if(NotNilAndNull(str3)){
        self.evaluationContents=str3;
    }
    if(NotNilAndNull(str4)){
        self.evaluationTime=str4;
    }
    if(NotNilAndNull(str5)){
        self.score=str5;
    }
//    
//    self.evaluationPerson = (str1 == nil?@"":str1);
//    self.evaluationTitle = (str2 == nil?@"":str2); 
//    self.evaluationContents = (str3 == nil?@"":str3);
//    self.evaluationTime = (str4 == nil ? @"":str4);
//    self.score = (str5 == nil?@"":str5);
}

- (void)dealloc {
    
    TT_RELEASE_SAFELY(_evaluationPerson);
    TT_RELEASE_SAFELY(_evaluationTitle);
    TT_RELEASE_SAFELY(_evaluationContents);
    TT_RELEASE_SAFELY(_evaluationTime);
    TT_RELEASE_SAFELY(_score);
    
}





@end
