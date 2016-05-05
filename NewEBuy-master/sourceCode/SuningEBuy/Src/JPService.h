//
//  JPService.h
//  SuningEBuy
//
//  Created by  liukun on 13-1-25.
//  Copyright (c) 2013年 Suning. All rights reserved.
//
/*!
 @header      JPService.h
 @abstract    抽奖
 @author       liukun
 @version     v1.0  13-1-25
 */


#import "DataService.h"
#import "JPInfoDTO.h"

@protocol JPServiceDelegate <NSObject>

@optional
- (void)chouJiangCompleteWithResult:(BOOL)isSuccess
                          errorCode:(NSString *)errorCode
                           errorMsg:(NSString *)errorMsg
                             JPList:(NSArray *)list
                             ZJInfo:(JPInfoDTO *)zjInfo;


@end

//----------------------------------------------------------

@interface JPService : DataService
{
    HttpMessage     *chouJiangHttpMsg;
}


@property (nonatomic, readonly) BOOL isLoaded;

@property (nonatomic, weak) id<JPServiceDelegate> delegate;


- (void)beginChouJiang;

@end
