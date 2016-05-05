//
//  DefineConstant.h
//  BlueBoxDemo
//
//  Created by 刘坤 on 12-7-28.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#ifndef DEFINE_CONSTANT_H
#define DEFINE_CONSTANT_H  1

#define HSVCOLOR(h,s,v) [UIColor colorWithHue:h saturation:s value:v alpha:1]
#define HSVACOLOR(h,s,v,a) [UIColor colorWithHue:h saturation:s value:v alpha:a]

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iOS7 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)?YES:NO)
#define ApplicationScreenHeight ([[UIScreen mainScreen] bounds].size.height - (iOS7?0:20))
#define ApplicationScreenWidth ([[UIScreen mainScreen] bounds].size.width)

////打印
//#ifdef DEBUGLOG
//#       define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
//#else
//#       define DLog(...)
//#endif


#if !__has_feature(objc_arc)

//弹出提示框
#define BBAlertMessage(__MSG) \
{\
BBAlertView *alert = [[BBAlertView alloc] initWithStyle:BBAlertViewStyleDefault \
Title:L(@"system-info") \
message:(__MSG) \
customView:nil \
delegate:nil \
cancelButtonTitle:L(@"Confirm") \
otherButtonTitles:nil]; \
[alert show]; \
[alert release]; \
}

#else

//弹出提示框
#define BBAlertMessage(__MSG) \
{\
BBAlertView *alert = [[BBAlertView alloc] initWithStyle:BBAlertViewStyleDefault \
Title:L(@"system-info") \
message:(__MSG) \
customView:nil \
delegate:nil \
cancelButtonTitle:L(@"Confirm") \
otherButtonTitles:nil]; \
[alert show]; \
}

#endif




//释放ASIHttpRequest专用
#define HTTP_RELEASE_SAFELY(__POINTER) \
{\
    if (nil != (__POINTER))\
    {\
        [__POINTER clearDelegatesAndCancel];\
        TT_RELEASE_SAFELY(__POINTER);\
    }\
}

//释放httpMessage专用
#define HTTPMSG_RELEASE_SAFELY(__REF) \
{\
    if (nil != (__REF))\
    {\
        [__REF cancelDelegateAndCancel];\
        TT_RELEASE_SAFELY(__REF);\
    }\
}

//释放service专用
#define SERVICE_RELEASE_SAFELY(__REF) \
{\
    if ((__REF) != nil)\
    { \
        [__REF setDelegate:nil];\
        TT_RELEASE_SAFELY(__REF);\
    }\
}

//释放SNPopoverViewController
#define POP_RELEASE_SAFELY(__POINTER) \
{\
    if (nil != (__POINTER))\
    {\
        [__POINTER dismissPopoverAnimated:YES];\
        TT_RELEASE_SAFELY(__POINTER);\
    }\
}

//是否为空或是[NSNull null]
#define NotNilAndNull(_ref)  (((_ref) != nil) && (![(_ref) isEqual:[NSNull null]]))
#define IsNilOrNull(_ref)   (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]))

//字符串是否为空
#define IsStrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref)isEqualToString:@""]))
//数组是否为空
#define IsArrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref) count] == 0))


#define OC(str) [NSString stringWithCString:(str) encoding:NSUTF8StringEncoding]

//16进制色值参数转换
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//block 声明
#ifdef NS_BLOCKS_AVAILABLE
typedef void (^SNBasicBlock)(void);
typedef void (^SNOperationCallBackBlock)(BOOL isSuccess, NSString *errorMsg);
typedef void (^SNArrayBlock)(NSArray *list);
#endif


//enums
typedef enum {
    
    MobileMode = 1,
    
    EmailMode
    
}RetrieveMode;

//图片质量
typedef enum{
    
    AUTO_QUAILTY = 0,
    HEIGHT_QUAILTY,
    LOW_QUAILTY
    
}ImageQuailty;


typedef enum {
    MessageFilterSelectAll,                                       //推送消息设置选择全部
    MessageFilterSelectSalesPromotion,                            //推送消息设置选择促销消息
    MessageFilterSelectPersonality,                               //推送消息设置选择个性推荐
    MessageFilterSelectSalesPromotionAndPersonality,              //推送消息设置选择促销消息和个性推荐
    MessageFilterSelectLogistic,                                  //推送消息设置选择物流消息
    MessageFilterSelectSalesPromotionAndLogistic,                 //推送消息设置选择促销消息和物流消息
    MessageFilterSelectPersonalityAndLogistic,                    //推送消息设置选择个性推荐和物流消息
    MessageFilterSelectNone  =  100,                              //推送消息设置一个都不选
} MessageFilterSelecter;

//分页页面分页信息

struct SNPageInfo {
    NSInteger currentPage;
    NSInteger totalPage;
    NSInteger pageSize;
};
typedef struct SNPageInfo SNPageInfo;

extern SNPageInfo SNPageInfoMake(NSInteger currentPage, NSInteger totalPage, NSInteger pageSize);

extern const SNPageInfo SNPageInfoZero;


//便捷方式创建NSNumber类型
#undef	__INT
#define __INT( __x )			[NSNumber numberWithInt:(NSInteger)__x]

#undef	__UINT
#define __UINT( __x )			[NSNumber numberWithUnsignedInt:(NSUInteger)__x]

#undef	__FLOAT
#define	__FLOAT( __x )			[NSNumber numberWithFloat:(float)__x]

#undef	__DOUBLE
#define	__DOUBLE( __x )			[NSNumber numberWithDouble:(double)__x]

//便捷创建NSString
#undef  STR_FROM_INT
#define STR_FROM_INT( __x )     [NSString stringWithFormat:@"%d", (__x)]

//线程执行方法
#define Foreground_Begin  dispatch_async(dispatch_get_main_queue(), ^{
#define Foreground_End    });

#define Background_Begin  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{\
                                @autoreleasepool {
#define Background_End          }\
                          });


//时间格式的装转  WB使用
extern NSString *WBHeadUrlString(NSString *sysHeadPicFlag,NSString *sysHeadPicNum,CGSize size,NSString*custNum);

//单例创建
#undef	AS_SINGLETON
#define AS_SINGLETON( __class ) \
+ (__class *)sharedInstance;

#undef	DEF_SINGLETON
#define DEF_SINGLETON( __class ) \
+ (__class *)sharedInstance \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[__class alloc] init]; } ); \
return __singleton__; \
}


//arc custom retain and release
#define ARCRetain(...) void *retainedThing = (__bridge_retained void *)__VA_ARGS__; retainedThing = retainedThing
#define ARCRelease(...) void *retainedThing = (__bridge void *) __VA_ARGS__; id unretainedThing = (__bridge_transfer id)retainedThing; unretainedThing = nil


extern NSString* getDownloadChannelId(void);
extern NSString* getDownloadChannelName(void);

#define kDownloadChannel    getDownloadChannelName()
#define kDownloadChannelNum getDownloadChannelId()

extern NSString* const suningCookieDomain;

extern NSString* EncodeStringFromDic(NSDictionary *dic, NSString *key);
extern NSNumber* EncodeNumberFromDic(NSDictionary *dic, NSString *key);
extern NSDictionary *EncodeDicFromDic(NSDictionary *dic, NSString *key);
extern NSArray      *EncodeArrayFromDic(NSDictionary *dic, NSString *key);
extern NSArray      *EncodeArrayFromDicUsingParseBlock(NSDictionary *dic, NSString *key, id(^parseBlock)(NSDictionary *innerDic));


#endif      //--------------------------------endLine
