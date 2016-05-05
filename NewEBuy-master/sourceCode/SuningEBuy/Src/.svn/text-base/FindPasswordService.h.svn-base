//
//  FindPasswordService.h
//  SuningEBuy
//
//  Created by  zhang jian on 13-8-19.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataService.h"
#import "FindPasswordDTO.h"

@protocol FindPasswordServiceDelegate;

@interface FindPasswordService : DataService
{
    HttpMessage             *findPasswordHTTPMsg;
    FindPasswordStep        _findPasswordStep;
}

@property (nonatomic, weak) id<FindPasswordServiceDelegate>   delegate;


- (void)beginFindPasswordHttpRequest:(FindPasswordDTO *)dto;


@end

@protocol FindPasswordServiceDelegate <NSObject>

@optional
- (void)findPasswordHttpComplete:(FindPasswordService *)service
                       isSuccess:(BOOL)isSuccess;

@end