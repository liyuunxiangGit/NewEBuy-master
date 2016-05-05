//
//  BookAppraisalDTO.h
//  SuningEBuy
//
//  Created by lanfeng on 12-5-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseHttpDTO.h"

@interface BookAppraisalDTO : BaseHttpDTO{

    NSString        *_evaluationPerson;
    
    NSString        *_evaluationTitle;
    
    NSString        *_evaluationTime;

    NSString        *_evaluationContents;
    
    NSString        *_score;

}

@property(nonatomic,copy) NSString *evaluationPerson;
@property(nonatomic,copy) NSString *evaluationTitle;
@property(nonatomic,copy) NSString *evaluationTime;
@property(nonatomic,copy) NSString *evaluationContents;
@property(nonatomic,copy) NSString *score;

- (void)encodeFromDictionary:(NSDictionary *)dic;

@end
