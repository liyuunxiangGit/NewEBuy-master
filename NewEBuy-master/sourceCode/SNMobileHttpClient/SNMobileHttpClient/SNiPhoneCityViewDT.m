//
//  SNiPhoneCityViewDT.m
//  SNMobileHttpClient
//
//  Created by liukun on 14-5-19.
//  Copyright (c) 2014年 suning. All rights reserved.
//

#import "SNiPhoneCityViewDT.h"

@implementation SNiPhoneCityViewDT

- (void)executeOperation
{
    NSString *url = [NSString stringWithFormat:@"%@/%@", commerceHost, @"SNiPhoneCityView"];
    
    NSMutableDictionary *postDataDic = [self.attributes mutableCopy];
    [postDataDic setObject:kSuningStoreValue forKey:kSuningStoreKey];
    
    @weakify(self);
    httpOperation = [SNHttpClient sendRequest:url requestMethod:@"POST" parameters:postDataDic shouldParseInBackground:YES success:^(id responseObject) {
        
        @strongify(self);
        
        self.resultCityList = EncodeArrayFromDicUsingParseBlock(responseObject, @"cityList", ^id(NSDictionary *innerDic) {
            
            AddressInfoDTO *dto = [[AddressInfoDTO alloc] init];
            dto.city = EncodeStringFromDic(innerDic, @"cityNo");
            dto.cityContent = EncodeStringFromDic(innerDic, @"cityName");
            dto.province = EncodeStringFromDic(innerDic, @"provinceCode");
            return dto;
        });
        
        [self markAsFinished];
        
    } failure:^(NSUInteger statusCode, NSError *error) {
        
        @strongify(self);
        
        [self failWithError:error];
    }];
}

@end
