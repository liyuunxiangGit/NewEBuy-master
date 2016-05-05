//
//  SNiPhoneTownViewDT.m
//  SNMobileHttpClient
//
//  Created by liukun on 14-5-19.
//  Copyright (c) 2014年 suning. All rights reserved.
//

#import "SNiPhoneTownViewDT.h"

@implementation SNiPhoneTownViewDT

- (void)executeOperation
{
    NSString *districtCode = self.attributes[@"districtCode"];
    
    if (!districtCode.length) {
        
        DDLogError(@"SNiPhoneTownViewDT require `districtCode` attribute");
        [self failWithError:kSNDataTaskParamError];
        return;
    }
    
    NSDictionary *postDataDic = @{kSuningStoreKey: kSuningStoreValue, @"distID": districtCode};
    
    NSString *url = [NSString stringWithFormat:@"%@/%@", commerceHost, @"SNiPhoneTownView"];

    @weakify(self);
    httpOperation = [SNHttpClient sendRequest:url requestMethod:@"POST" parameters:postDataDic shouldParseInBackground:YES success:^(id responseObject) {
        
        @strongify(self);
        
        self.resultTownList = EncodeArrayFromDicUsingParseBlock(responseObject, @"townList", ^id(NSDictionary *innerDic) {
            
            AddressInfoDTO *dto = [[AddressInfoDTO alloc] init];
            dto.town = EncodeStringFromDic(innerDic, @"townNo");
            dto.townContent = EncodeStringFromDic(innerDic, @"townName");
            return dto;
        });
        
        [self markAsFinished];
        
    } failure:^(NSUInteger statusCode, NSError *error) {
        
        @strongify(self);
        
        [self failWithError:error];
    }];
}

@end
