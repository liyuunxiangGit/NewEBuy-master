//
//  SNWebViewController.h
//  SuningEBuy
//
//  Created by liukun on 14-5-12.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "CustomSegment.h"

typedef NS_ENUM(NSInteger, SNWebViewType) {
    SNWebViewTypeCommon,                                  //default
    SNWebViewTypeAdModel,                                 //八联版促销页，一般活动页面都是该类型，同common
    SNWebViewTypeEfubao,                                  //我的易付宝
    SNWebViewTypeGame,                                    //易购游戏
    SNWebViewTypeAppStore,                                //应用频道
    SNWebViewTypeEppPay,                                  //易付宝收银台
    SNWebViewTypeEppCharge,                               //易付宝充值
    SNWebViewTypeEppPayPlane,                             //易付宝收银台 for 机票
    SNWebViewTypeCShop,                                   //c店店铺
    SNWebViewTypeBook,                                    //苏宁阅读
    SNWebViewTypeDJGroup,                                 //单价团
    SNWebViewTypeYaoYiYao,                                //摇一摇
    SNWebViewTypeManZuo,                                  //满座
    SNWebViewTypeCaiPiao                                  //彩票
};

typedef enum {
    BackMethodType_APP = 1,         //返回app
    BackMethodType_WebMainPage,     //返回web首页
    BackMethodType_PreviousPage     //返回前一页面
    
} BackMethodType;

@class WebViewJavascriptBridge;

/**
 *  苏宁易购中的webView使用的统一ViewController
 */
@interface SNWebViewController : CommonViewController <UIWebViewDelegate, CustomSegmentDelegate>
{
    @private
    UIWebView           *_webView;
    NSURLRequest        *_request;
    NSString            *_htmlString;
    SNWebViewType       _webType;
    
    //服务器传递过来的返回类型
    int                 backType;
    
    //是否直接返回到客户端我的易购(商品预约的所有页面都是直接返回APP)
    BOOL    isDirectBackToAPP;
    
    //web页面最先的请求dict,用以实现返回web首页
    NSDictionary        *originDict;
    
    //url数组，实现segment
    CustomSegment       *segment;
    
    NSArray             *urlArray;
    NSArray             *urlTitleArray;
    
    BOOL           needShowOverFlowOnce;
    
    @protected
    NSArray             *_urlPatterns;
}

@property (nonatomic, strong, readonly) UIWebView *webView;
@property (nonatomic, strong)   NSURLRequest *request;
@property (nonatomic, readonly) SNWebViewType webType;
//web页面需要判断是从哪一个一面进入web页的，增加一个标志位 0:默认值，无意义 1：从首页  2：从页面集(二级页) 3:促销专题
// 4:连版专题 5：商品集
@property (nonatomic, assign)   int   controllerSourceType;

/**
 *  退出时是否要清除缓存, 默认NO
 */
@property (nonatomic, assign) BOOL shouldClearCacheOnExit;

/**
 *  是否使用documentTitle作为NavBar的title, 默认YES
 */
@property (nonatomic, assign) BOOL shouldUseDocumentTitle;

/**
 *  点击返回时是否要在webView中goBack, 默认YES
 */
@property (nonatomic, assign) BOOL shouldGoBackInWebWhenTouchNavBack;

/**
 *  是否要转菊花, 默认YES
 */
@property (nonatomic, assign) BOOL shouldDisplayOverflow;

/**
 *  固定的title，如果被设置了，那么title不可被更改
 */
@property (nonatomic, strong) NSString *stableTitle;
@property (nonatomic, strong) WebViewJavascriptBridge *jsBridge;
@property (nonatomic, strong) UIColor  *webTitleColor;

/**
 *  使用request进入webView的初始化方法
 *
 *  @param request 进入webView的request对象
 *
 *  @return SNWebViewController的实例
 */
- (id)initWithRequest:(NSURLRequest *)request;

/**
 *  使用url进入webView的初始化方法
 *
 *  @param url webView第一次加载的url
 *
 *  @return SNWebViewController的实例
 */
- (id)initWithRequestUrl:(NSString *)url;


/**
 *  用两个url初始化，页面多了一个segment
 *  arr1 : url数组
 *  arr2 : 标题数组
 */
- (id)initwithURLArray:(NSArray *)arr1 titleArray:(NSArray *)arr2;

/**
 *  使用html初始化的方法
 *
 *  @param html 一段html代码，可以是一个静态页面，也可以是一个form表单
 *
 *  @return SNWebViewController的实例
 */
- (id)initWithHtmlString:(NSString *)html;

/**
 *  可详细定制的初始化方法
 *
 *  @param type       webView页面的类型，在`SNWebViewType`中枚举的类型
 *  @param attributes 初始化的一些参数集合，如下：@{
 @"url" : @"进入的链接url",
 @"form" : @"以form表单进入时使用该参数",
 @"html" : @"以html进入时的参数",
 @"request" : @"已request进入时的参数",
 @"shopId" : @"类型为SNWebViewTypeCShop时，需要传入商店id时传入",
 @"activeName" : @"八联版促销活动标题,包含此字段时，默认认为是八联版",
 }
 *
 *  @return SNWebViewController的实例
 */
- (instancetype)initWithType:(SNWebViewType)type attributes:(NSDictionary *)attributes;

/**
 *  刷新当前页面
 */
- (void)reload;

/**
 *  后退
 */
- (void)goBack;

/**
 *  前进
 */
- (void)goForward;

/**
 *  加载request
 */
- (void)loadRequest;

/**
 *  是否要信任登录到epp
 */
- (BOOL)shouldTrushToEpp;

/**
 *  调出分享
 *
 *  @param title     分享title
 *  @param content   分享内容
 *  @param targetUrl 分享targetUrl
 *  @param iconUrl   分享图片url
 *  @param shareWays 分享方式， see  `ChooseShareWayView`
 *  @since 2.4.3
 *  @author liukun   14/8/14
 */
- (void)nativeShareWithTitle:(NSString *)title content:(NSString *)content targetUrl:(NSString *)targetUrl iconUrl:(NSString *)iconUrl shareWays:(NSArray *)shareWays;

@end
