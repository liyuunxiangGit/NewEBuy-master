//
//  SNAddressCachePlugin.m
//  SNPlugin
//
//  Created by liukun on 14-5-20.
//  Copyright (c) 2014年 suning. All rights reserved.
//

#import "SNAddressCachePlugin.h"

@interface SNAddressCachePlugin()
{
    SNiPhoneProvinceViewDT *_provinceTask;
    SNiPhoneCityViewDT     *_cityTask;
    NSInvocationOperation  *_dbOperation;
}

@end

/*********************************************************************/

@implementation SNAddressCachePlugin

- (void)executeOperation
{
    _provinceTask = [[SNiPhoneProvinceViewDT alloc] init];
    _cityTask = [[SNiPhoneCityViewDT alloc] init];
    
    @weakify(self);
    _dbOperation = [NSBlockOperation blockOperationWithBlock:^{
        
        @strongify(self);
        SNiPhoneProvinceViewDT *provinceTask = self->_provinceTask;
        SNiPhoneCityViewDT *cityTask = self->_cityTask;
        
        if (provinceTask.successed && cityTask.successed)
        {
            NSArray *provinceList = [provinceTask resultProvinceList];
            NSArray *cityList = [cityTask resultCityList];
            
            
            
            [self markAsFinished];
        }
        else
        {
            [self failWithError:_provinceTask.error?_provinceTask.error:_cityTask.error];
        }
        
    }];
    
    [_dbOperation addDependency:_provinceTask];
    [_dbOperation addDependency:_cityTask];
    
    [BBTask asyncRunOperations:@[_provinceTask, _cityTask, _dbOperation]];
}

@end
