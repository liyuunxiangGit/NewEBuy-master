//
//  MyIntegralService.h
//  SuningEBuy
//
//  Created by shasha on 12-9-19.
//  Copyright (c) 2012年 Suning. All rights reserved.
//
#import "DataService.h"
#import "ActivateIntegralDTO.h"

/*!
 @header   MyIntegralService
 @abstract 云钻模块相关数据处理类
 @author   莎莎 
 @version  4.3  2012/9/19 Creation 
 */

@class MyIntegralService;


@protocol MyIntegralServiceeDelegate ;


/*!
 @abstract     云钻相关服务
 @discussion   获取云钻余额：返回了云钻激活字段，以及当前账户的云钻余额
               云钻激活预备：返回了已经在用户信息中维护过了的，云钻激活所需字段。
                  云钻激活：上传用户所填云钻激活信息。激活云钻账户。  
 */
@interface MyIntegralService : DataService{

    HttpMessage      *_myIntegralMsg;
    HttpMessage      *_preCardInfoMsg;
    HttpMessage      *_activeIntegerMsg;
    HttpMessage      *_getIntegralDetailMsg;
    HttpMessage      *_exchangeIntegralMsg;


    
}


@property (nonatomic, weak) id<MyIntegralServiceeDelegate> delegate;
/*!
 @abstract     云钻激活的状态。
 */ 
@property (nonatomic, copy)   NSString  *actAchive;
/*!
 @abstract      云钻余额
 */
@property (nonatomic, copy)   NSString  *achievement;
/*!
 @abstract      云钻明细列表总页数
 */ 
@property (nonatomic, assign)   int  totalNum;
/*!
 @abstract      云钻明细列表当前页面
 */
@property (nonatomic, assign)   int  currentPage;

/*!
 @abstract     云钻明细列表
 */
@property (nonatomic, strong) NSArray  *integralDetailArr;

/*!
 @abstract     云钻明细列表
 */
@property (nonatomic, copy)  NSArray  *lastRecordArray;

/*!
 @abstract      云钻激活的预填写信息
 @discussion    预先请求的已经在用户信息中补充过的，云钻激活所需要的信息
 */
@property (nonatomic, strong) ActivateIntegralDTO *activateIntegralDto;

/*!
 @method
 @abstract 获取云钻余额以及云钻激活状态
 @discussion http数据请求调用
 */
- (void)beginGetMyIntegerInfoRequest;


/*!
 @method
 @abstract 获取云钻激活信息填写的已有信息
 @discussion http数据请求调用，用于预先填写云钻激活信息，使用用户信息中已有的信息
 */
- (void)BeginGetPreCardInfoRequest;


/*!
 @method
 @abstract 激活我的云钻
 @discussion http数据请求调用，用于激活我的云钻
 @param      ActivateIntegralDTO:activateIntegralDto  激活云钻对应的DTO
 */

- (void)BeginActiveIntegerRequest:(ActivateIntegralDTO *)activateIntegralDto withCheckCode:(NSString *)checkCode;

/*!
 @method
 @abstract   获取我的云钻详情
 @discussion http数据请求调用，用于获取我的云钻
 @param      int:currentPage 当前请求的
 */

- (void)BeginGetIntegerDetailInfoRequest:(int )currentPage integralType:(NSString*)type lastRecord:(NSArray*)lastRecord;


/*!
 @method
 @abstract   云钻兑换易购券
 @discussion http数据请求调用，用于云钻兑换易购券
 @param      NSString:change 需要兑换的易购券值
             NSString:changeCount 对换掉的云钻
             NSString:currentAchievement 当前账户云钻
 */
- (void)BeginExchangeIntegerRequest:(NSString *)change changeCount:(NSString *)changeCount currentAchievement:(NSString *)currentAchievement __attribute__((deprecated("接口废弃")));

@end


@protocol MyIntegralServiceeDelegate <NSObject>

@optional

- (void)myIntegralServiceHttpRequestCompletedWithService:(MyIntegralService *)service
                                                isSucess:(BOOL)isSucess
                                               errorCode:(NSString *)errorCode;

- (void)didGetPreCardInfoRequestCompletedWithService:(MyIntegralService *)service
                                            isSucess:(BOOL)isSucess
                                           errorCode:(NSString *)errorCode;

- (void)didActiveIntegerRequestCompletedWithService:(MyIntegralService *)service
                                            isSucess:(BOOL)isSucess
                                           errorCode:(NSString *)errorCode;

- (void)didGetIntegerDetailInfoRequestCompletedWithService:(MyIntegralService *)service
                                           isSucess:(BOOL)isSucess
                                          errorCode:(NSString *)errorCode;


- (void)didExchangeIntegerRequestCompletedWithService:(MyIntegralService *)service
                                                  isSucess:(BOOL)isSucess
                                                 errorCode:(NSString *)errorCode;

@end