//
//  SNSwitch.h
//  SuningEBuy
//
//  Created by  liukun on 13-8-20.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>

//所有开关逻辑都在此类
@interface SNSwitch : NSObject

AS_SINGLETON(SNSwitch);

+ (void)updateWithCallBack:(SNBasicBlock)callBack;
+ (BOOL)isLoadOk;

//首页功能区动态获取图片Url
+ (NSMutableDictionary *)homeBtIosListImage;
//首页icon的list
+ (NSArray *)homeBtIosList;
//首页生活娱乐的iconList
+ (NSArray *)homeBtIosListForLife;
//首页modeList
+ (NSArray *)homeModeList;
//首页需要获取签到图片
+ (BOOL)isNeedGetSignPic;


//首页团购右边的活动链接图片url
+ (NSURL *)homeHotUrl;

//我的易购上部背景图片url
+ (NSURL *)myEbuyUrl;

//是否开启彩票
+ (BOOL)isOpenLottery;

//单价团购渠道 1主站 2手机
+ (NSString *)groupbuyChannel;

//单价团的专有渠道 0:只查询我的专有活动 1：查询包含我的渠道的所有活动
+ (NSString *)groupbuyMyChannelOnly;

//抢购渠道 1代表B2C抢购渠道，2代表客户端自主抢购渠道
+ (NSString *)rushPurchaseChannel;

+ (NSArray *)rushPurchaseList;

+ (NSArray *)groupList;

+ (BOOL)checkListRightOrNot:(NSArray *)array;

//是否可以进入web收银台支付页面
+ (BOOL)isOpenWebEppPay;

//是否可以进入web收银台我的易付宝
+ (BOOL)isOpenWebEppMyEpp;

//是否可以进入web收银台充值页面
+ (BOOL)isOpenWebEppCharge;

//是否在web收银台支付前判断是否激活易付宝
+ (BOOL)isOpenWebEppPayCheckEppStatus;

//是否在sdk支付前判断是否激活易付宝
+(BOOL)isOpenSDKEppPayCheckEppStatus;
+ (BOOL)isOpenUnionPay;  //是否开启银联支付
+ (BOOL)isOpenCyberPay;  //是否开启异度支付
+(BOOL)isOpenSNPaySDK;   //是否开启sdk支付
+ (NSString *)webEppPaymodeDesc; //易付宝web支付支付描述
+ (NSString *)unionPaymodeDesc; //银联支付描述
+ (NSString *)cyberPaymodeDesc; //异度支付描述
+ (NSString *)SNPaySDKDesc;      //易付宝sdk支付描述

//注册后是否可以送券
+ (BOOL)canRegistSendCounponActionKey:(NSArray **)actions;

//是否可以登录送券
+ (BOOL)canLoginSendCounponActionKey:(NSString **)actionKey;

//搜索框中的随即搜索词
+ (NSString *)randomSearchPlaceholder;

//去逛逛链接
+ (NSString *)goAround;

//游戏链接
+ (NSURL *)gameUrl;

//是否有送券活动
+ (BOOL)isOnCouponForImageUrl:(NSURL **)imageUrl webUrl:(NSURL **)webUrl;

//云信
+ (BOOL)isYunXinON;

//是否打开在线客服
+ (BOOL)isOpenOnlineService;

//分享有礼
+ (BOOL)isOpenSharePromoteWithTitle:(NSString **)title imageUrl:(NSURL **)url;

//是否打开进入店铺
+ (BOOL)isOpenGoToShopExit;


//是否打开门店订单入口
+ (BOOL)isOpenShopOrderList;

//是否passport登陆
+(BOOL)isPassportLogin;

//数据收集SDK开关
+ (BOOL)isSuningBISDKOn;

//--------begin cpa&cps 老开关，244版本弃用
//add by gjf 邀请好友赚现金显示规则
+(NSString *)ISwdygyqxs;

//add by gjf 领取红包条件查询接口
+(NSString *)ISwdyglqxs;
+(NSString *)checklqxrhbtk;
//--------end cpa&cps 老开关，244版本弃用


+(NSString *)shouyexinren244;
+(NSString *)yaoqinghaoyou244;
+(NSString *)lingquhongbao244;

+(BOOL)Isneedupdate;

//是否显示支付方式提示语
+(BOOL)isShowPayTypeAlert;
+(NSString *)showPayTypeAlertString;
/*
// Function    : yaoYiYaoEntranceAtQianDao
// Description : 摇易摇在签到页面的入口
// return      : 对应的图片路径
// Date        : 2014-04-03 11:00:00
// Author      : XZoscar
*/
+ (NSString *)yaoYiYaoEntranceAtQianDao;

+ (NSString *)soundMonitor;

+ (NSString *)soundMonitorShareContent;

//我的易购界面是否展示关联我的互联账号入口 YES - 展示，NO - 不展示
+(BOOL)isShowMyHulianAccount;
+(NSString *)getHulianUrl;

//有促销价的情况下是否展示易购价
+(BOOL)isNeednetPrice;

//是否在身边苏宁中显示声波签到
+ (BOOL)isNearbySuningVoiceSign;

//身边苏宁活动开关（预充值）
+ (NSDictionary *)getNearbySuningPrecash:(NSString *)cityName;

//身边苏宁活动开关（预约）
+ (NSDictionary *)getNearbySuningReserve:(NSString *)cityName;

//身边苏宁声波后台配置四级页
+ (BOOL)isNearbySuningVoiceSignStore;

//搜索是否使用带促销标签接口
+(BOOL)isSearchPromotionOpen;

//搜索促销开关sscxkg的值   为0，老搜索 ；为1，mts搜索； 为2，老搜索接口，调mts促销一拖2
+(NSString *)getSearchPromotionValue;

//搜索走mts时，是否使用客户端渠道,0表示渠道id==1(取主站), 1表示==2
+(BOOL)isSearchUseClientChannel;

//促销开关打开，并且内容为2表示走mts一拖2接口请求促销信息，此时走pc搜索接口，多传一个参数跟搜索引擎
+(NSString *)getsscxkgSwitchContent;

//四级页服务门店自提促销及是否展示门店自提
+ (BOOL)isShowServerZiti;
+ (NSString *)serverCuxiaoDesc;

//2.4.1 首页M2 团购区域是展示团购还是广告
+ (BOOL)isM2QiangGouToEight;
//2.4.1 首页M2 抢购区域是展示团购还是广告
+ (BOOL)isM2TuanGouToEight;

//订单列表上端图片获取url
+ (NSString *)orderTopPicture;

//订单列表图片跳转url
+ (NSString *)orderTopPictureToWapUrl;

//是否展示订单列表顶端图片
+ (NSString *)isShowOrderTopPicture;

//是否需要调用四级页大聚惠接口
+ (BOOL)isNeedJuhui;

@end
