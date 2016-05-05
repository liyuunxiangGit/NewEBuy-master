//
//  UserDiscountService.h
//  SuningEBuy
//
//  Created by shasha on 12-9-28.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "DataService.h"
#import "UserDiscountInfoDTO.h"
@protocol UserDiscountServiceDelegate<NSObject>

@optional

- (void)didGetUserDiscountCompleted:(BOOL)isSuccess
                           errorMsg:(NSString *)errorMsg;

@end

@interface UserDiscountService : DataService{
    
    HttpMessage     *userDiscountHttpMsg;

}

@property (nonatomic, weak) id  <UserDiscountServiceDelegate>delegate;
@property (nonatomic, strong) UserDiscountInfoDTO  *userDiscountInfoDTO;

- (void)beginGetUserDiscountInfo;

@end

