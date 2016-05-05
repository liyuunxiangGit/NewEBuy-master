//
//  SNiPhoneProvinceViewDT.m
//  SNMobileHttpClient
//
//  Created by liukun on 14-5-6.
//  Copyright (c) 2014年 suning. All rights reserved.
//

#import "SNiPhoneProvinceViewDT.h"

@implementation SNiPhoneProvinceViewDT

- (void)executeOperation
{
    NSString *url = [NSString stringWithFormat:@"%@/%@", commerceHost, @"SNiPhoneProvinceView"];
    
    NSDictionary *postDataDic = @{kSuningStoreKey: kSuningStoreValue};
    
    @weakify(self);
    httpOperation = [SNHttpClient sendRequest:url requestMethod:@"POST" parameters:postDataDic shouldParseInBackground:YES success:^(id responseObject) {
        
        @strongify(self);
        self.resultProvinceList = EncodeArrayFromDicUsingParseBlock(responseObject, @"provinceList", ^id(NSDictionary *innerDic) {
            
            AddressInfoDTO *provinceInfo = [[AddressInfoDTO alloc] init];
            provinceInfo.province = EncodeStringFromDic(innerDic, @"provinceCode");
            provinceInfo.provinceContent = EncodeStringFromDic(innerDic, @"provinceName");
            return provinceInfo;
        });
        
        [self markAsFinished];
        
    } failure:^(NSUInteger statusCode, NSError *error) {
        
        @strongify(self);
        
        [self failWithError:error];
    }];
}

@end
