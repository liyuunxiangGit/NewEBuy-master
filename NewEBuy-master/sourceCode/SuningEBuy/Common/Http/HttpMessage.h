//
//  HttpMessage.h
//  SuningLottery
//
//  Created by wangrui on 7/3/12.
//  Copyright (c) 2012 suning. All rights reserved.
//
/*!
 @header      HttpMessage
 @abstract    网络请求信息的封装类
 @author      王瑞初期 刘坤修改
 @version     v1.0.004  12-9-6
 @discussion  12-10-9 liukun 添加方法cancelDelegateAndCancel
 */

#import "MsgConstant.h"
#import "ASIHTTPRequest.h"
#import <Foundation/Foundation.h>

typedef enum {
    RequestMethodPost        = 0,
    RequestMethodGet         = 1,
    
    // post流数据 非表单 xzoscar 2014/09/22 add
    // 且支持单个文件流上传
    RequestMethodPostStream  = 2,

}RequestMethod;

@protocol HttpResponseDelegate;

@interface HttpMessage : NSObject
{
  @private
    
    // 客户端请求信息
	
	E_CMDCODE                _cmdCode;   // 请求标识
    CGFloat                  _timeout;   // 请求超时时间
	NSString                 *_requestUrl;   // 请求地址
    NSDictionary             *_postDataDic;  // 请求数据
    RequestMethod            _requestMethod;
	
    // 服务端响应信息
    
    id<HttpResponseDelegate> __weak _delegate;  // 请求回调
    int                      _requestFailErrorCode;
    
	NSString                 *_errorCode;   // 错误码
    NSString                 *_responseString;	// 响应信息
    NSDictionary             *_jasonItems;
    
    BOOL                     _canMultipleConcurrent;//请求是否可以多个并行 default is NO
    NSMutableArray           *_addedCookies;
}
@property (nonatomic, assign) BOOL isShouXian;

@property (nonatomic, assign) E_CMDCODE cmdCode;
@property (nonatomic, assign) CGFloat  timeout;
@property (nonatomic, copy) NSString *requestUrl;
@property (nonatomic, strong) NSDictionary *postDataDic;
@property (nonatomic, assign) RequestMethod requestMethod;
@property (nonatomic, weak) id<HttpResponseDelegate> delegate;
@property (nonatomic, copy) NSString *errorCode;
@property (nonatomic, copy) NSString *responseString;
@property (nonatomic, strong) NSDictionary *jasonItems;
@property (nonatomic, assign) BOOL canMultipleConcurrent;   //请求是否可以多个并行
@property (nonatomic, strong) NSMutableArray *addedCookies;
@property (nonatomic, assign) NSInteger responseStatusCode;
@property (nonatomic, strong) NSError   *error;
@property (nonatomic, strong) NSMutableDictionary   *additionValues;

// 用户数据，2014/09/24 xzoscar
@property (nonatomic, strong) id userInfo;

// 二进制流 如 图片数据
@property (nonatomic, strong) NSData *postData;

@property (nonatomic, assign) BOOL   isUploadImage; // default NO

/*!
 @method        initWithDelegate:requestUrl:postDataDic:cmdCode:
 @abstract      初始化方法，参数为必须字段
 @param         delegate  接收回调方法的代理
 @param         url       发送请求的url
 @param         postDic   发送请求的参数
 @param         code      该请求的唯一标识
 @result        HttpMessage对象
 */
- (id)initWithDelegate:(id<HttpResponseDelegate>)delegate 
            requestUrl:(NSString *)url 
           postDataDic:(NSDictionary *)postDic 
               cmdCode:(E_CMDCODE)code;


/*!
 @method        cancelDelegate
 @abstract      取消代理，并取消对应的ASIHttp请求
 */
- (void)cancelDelegate;


/*!
 @method        cancelDelegateAndCancel
 @abstract      取消代理，并取消对应的ASIHttp请求
 */
- (void)cancelDelegateAndCancel;

@end

#pragma mark delegate_ 
/*!
 @protocol       HttpResponseDelegate
 @abstract       HttpMessage的一个代理
 @discussion     代理模式
 */
@protocol HttpResponseDelegate<NSObject>

@optional
/*!
 @method        receiveDidFinished
 @abstract      请求完成（请求有返回）后的回调方法
 @discussion    代理类中实现
 @param         receiveMsg  HttpMessage对象
 */
- (void)receiveDidFinished:(HttpMessage *)receiveMsg;


/*!
 @method        receiveDidFailed
 @abstract      请求失败（超时，网络未链接等错误）后的回调方法
 @discussion    代理类中实现
 @param         receiveMsg  HttpMessage对象
 */
- (void)receiveDidFailed:(HttpMessage *)receiveMsg;

@end
