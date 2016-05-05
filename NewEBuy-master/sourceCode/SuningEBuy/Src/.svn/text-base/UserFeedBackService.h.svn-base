//
//  UserFeedBackService.h
//  SuningEBuy
//
//  Created by xie wei on 13-7-19.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserFeedBackDTO.h"

@protocol UserFeedBackServiceDelegate;

@interface UserFeedBackService : DataService{
    HttpMessage *__UserFeedBackMsg;
}

@property (nonatomic, weak) id<UserFeedBackServiceDelegate> delegate;

@property (nonatomic, copy) NSString *isSucess;
@property (nonatomic, copy) NSString *serviceErrorCode;
@property (nonatomic, copy) NSString *errorMessage;
@property (nonatomic, assign) BOOL isNetWorkError;

- (void)beginSendFeedBackRequest:(UserFeedBackDTO *)dto;

@end

@protocol UserFeedBackServiceDelegate <NSObject>

- (void)didSendFeedBackRequestComplete:(UserFeedBackService *)service  Result:(BOOL)isSuccess;

@end
