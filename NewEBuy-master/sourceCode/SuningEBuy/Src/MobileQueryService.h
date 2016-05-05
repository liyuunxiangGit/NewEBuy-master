//
//  MobileQueryService.h
//  SuningEBuy
//
//  Created by  liukun on 13-2-1.
//  Copyright (c) 2013年 Suning. All rights reserved.
//
/*!
 @header      MobileQueryService.h
 @abstract    <#头文件描述#>
 @author       liukun
 @version     v1.0  13-2-1
 */


#import "DataService.h"
#import "MobileQueryDTO.h"

@protocol MobileQueryServiceDelegate <NSObject>

@optional
- (void)requestMobileOrderComplete:(BOOL)isSuccess
                          errorMsg:(NSString *)errorMsg
                         orderList:(NSArray *)list
                              page:(SNPageInfo)pageInfo;

@end

//----------------------------------------------------------

@interface MobileQueryService : DataService
{
    HttpMessage     *mobilePayOrderListHttpMsg;
}

@property (nonatomic, weak) id<MobileQueryServiceDelegate> delegate;



- (void)requestMobileOrderWithPage:(NSInteger)page;


@end
