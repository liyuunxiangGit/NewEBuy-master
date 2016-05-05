//
//  SNiPhoneDistrictViewDT.m
//  SNMobileHttpClient
//
//  Created by liukun on 14-5-19.
//  Copyright (c) 2014年 suning. All rights reserved.
//

#import "SNiPhoneDistrictViewDT.h"

@implementation SNiPhoneDistrictViewDT

- (void)executeOperation
{
    NSString *cityCode = self.attributes[@"cityCode"];
    if (!cityCode.length)
    {
        DDLogError(@"SNiPhoneDistrictViewDT require `cityCode` attribute");
        [self failWithError:kSNDataTaskParamError];
        return;
    }
    
    NSString *url = [NSString stringWithFormat:@"%@/snmtDistrict_%@_%@_.html",
           htmlHost, kSuningStoreValue, cityCode];
    
    @weakify(self);
    httpOperation = [SNHttpClient sendRequest:url requestMethod:@"GET" parameters:nil shouldParseInBackground:YES success:^(id responseObject) {
        
        @strongify(self);
        
        self.resultDistrictList = EncodeArrayFromDicUsingParseBlock(responseObject, @"districtList", ^id(NSDictionary *innerDic) {
            
            AddressInfoDTO *dto = [[AddressInfoDTO alloc] init];
            dto.district = EncodeStringFromDic(innerDic, @"distNo");
            dto.districtContent = EncodeStringFromDic(innerDic, @"distName");
            return dto;
        });
        
        [self markAsFinished];
        
    } failure:^(NSUInteger statusCode, NSError *error) {
        
        @strongify(self);
        
        [self failWithError:error];
    }];
}

@end
