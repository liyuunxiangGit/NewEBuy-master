//
//  DataService.h
//  SuningLottery
//
//  Created by wangrui on 7/4/12.
//  Copyright (c) 2012 suning. All rights reserved.
//
/*!
 @header      DataService
 @abstract    service的父类，所有的service都必须继承该类
 @author      王瑞初期，刘坤修改
 @version     v1.0.002  12-8-29
 */

#import "HttpMessage.h"
#import "HttpMsgCtrl.h"
#import <Foundation/Foundation.h>

#undef POST_VALUE
#define POST_VALUE(_VAL)  (_VAL)?(_VAL):@""

@interface DataService : NSObject <HttpResponseDelegate>
{
  @protected
    HttpMsgCtrl  *__weak _httpMsgCtrl;
    
    NSString     *_errorMsg;
}

@property (weak, nonatomic, readonly) HttpMsgCtrl *httpMsgCtrl;

/*!
 @property      errorMsg
 @abstract      存放错误信息的字段
 */
@property (nonatomic, copy) NSString  *errorMsg;
// xzoscar 2014-07-22 10:54 add
// Desc: 要根据错误码 跳转下个页面
@property (nonatomic,strong) NSString *errCode;


@property (nonatomic, strong) id  context;


/*!
 @method        httpMsgRelease
 @abstract      用于释放HttpMessage对象的地方
 @discussion    该方法在dealloc中执行，子类实现改方法即可
 */
- (void)httpMsgRelease;

- (NSString *)errorMsgOfASIErrorCode:(int)errorCode;

@end
