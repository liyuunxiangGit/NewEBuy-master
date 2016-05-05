//
//  MessageCenter.h
//  BlueBoxDemo
//
//  Created by 刘坤 on 12-6-8.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

//登录

#define AUTOLOGIN_BEGIN                             @"AutoLoginDidBegin"

//易付宝
#define  EFUBAO_MESSAGE                             @"GotoEfubaoMessage"
//登录完成
#define  LOGIN_OK_MESSAGE                           @"LOGIN_OK_MESSAGE"
//自动登陆完成
#define  AUTOLOGIN_OK_MESSAGE                       @"AUTOLOGIN_OK_MESSAGE"
#define  AUTOLOGIN_Failed_MESSAGE                   @"AUTOLOGIN_Failed_MESSAGE"
//注册完成
#define  REGISTE_OK_MESSAGE                         @"REGISTE_OK_MESSAGE"  

//登录session失效
#define  LOGIN_SESSION_FAILURE                      @"LOGIN_SESSION_FAILURE"
//登录失效且要弹出登录界面
#define  LOGIN_SESSION_FAILURE_NEED_LOGIN           @"LOGIN_SESSION_FAILURE_NEED_LOGIN"

//登录失效且要弹出登录界面 //本地生活特别
#define  LOGIN_SESSION_FAILURE_NEED_LOGIN_GROUP           @"LOGIN_SESSION_FAILURE_NEED_LOGIN_GROUP"

//登录用户与上次登录不同
#define LOGIN_USER_CHANGE_MESSAGE                   @"LOGIN_USER_CHANGE_MESSAGE"

#define  POPUP_MESSAGE                              @"POPUP_MESSAGE"

#define  POPUP_MESSAGE                              @"POPUP_MESSAGE"

#define  POPUPWITHUSERNAME_MESSAGE                  @"POPUPWITHUSERNAME_MESSAGE"

//注销
#define  LOGOUT_OK_NOTIFICATION                     @"LOGOUT_OK"
 

//支付结束、支付成功（原来ebuy中的shopping_ok）
#define  PAY_SUCCESS_NOTIFICATION                   @"PAY_SUCCESS"

#define  GET_USERACCOUNTINFO_SUCCESS_NOTIFICATION   @"GET_USERACCOUNTINFO_SUCCESS"

/*热销商品加载完成*/
#define HOTSALE_LOADED_NOTIFICATION                 @"HOTSALE_LOADED_NOTIFICATION"

#define HOTSALE_TO_PRODUCTDETAIL_NOTIFICATION       @"HOTSALE_TO_PRODUCTDETAIL_NOTIFICATION"

//默认送货城市改变
#define DEFAULT_CITY_CHANGE_NOTIFICATION            @"DEFAULT_CITY_CHANGE_NOTIFICATION"

//团购成功
#define GROUP_PURCHASE_OK_NOTIFICATION              @"GROUP_PURCHASE_OK_NOTIFICATION"

//团购或抢购状态更改需要刷新四级页面                    
#define PURCHASE_STATE_CHANGE_NOTIFICATION          @"PURCHASE_STATE_CHANGE_NOTIFICATION"

//手机充值成功后查看订单
#define QUERY_MOBILE_RECORD                             @"query_mobile_record"

//手机充值成功后继续充值
#define PAY_MOBILE_AGAIN                            @"pay_mbile_again"

//继续充值时停止上一次验证码计时
#define STOP_VERIFY_CALCULAGRAPH                    @"stop_verify_calculagraph"

//一键购地址新增或修改完成
#define EASILY_BUY_UPDATE_ADDRESS                   @"EASILY_BUY_UPDATE_ADDRESS"

//新增咨询
#define NEW_PRODUCT_CONSULTANT                      @"NEW_PRODUCT_CONSULTANT"

//购物完成
#define SHOPPING_OK_MESSAGE                         @"SHOPPING_OK_MESSAGE"

//清空购物车
#define CART_CLEAN_MESSAGE                          @"CART_CLEAN_MESSAGE"

//退货完成
#define RETURN_GOODS_OK_MESSAGE                      @"RETURN_GOODS_OK_MESSAGE"

//订单取消成功  
#define CANCEL_ORDER_OK_MESSAGE                     @"CANCEL_ORDER_OK_MESSAGE"

//订单确认收货成功
#define RECEIPT_CONFIRM_SUCCESS                     @"RECEIPT_CONFIRM_SUCCESS"

//我的商旅机票订单
#define SHOULD_GO_TO_PLANE_ORDERCENTER                @"GoTo_PlaneOrderCenter"

//刷新首页专题促销
#define Refresh_SpecialSubject_Views                  @"Refresh_SpecialSubject_Views"

//定位完成
#define LOCATE_FINISH_MESSAGE                        @"LOCATE_FINISH_MESSAGE"

//进入后台超过5分钟再回来
#define INTO_BACKGROUND_OVER_5_MIN                   @"INTO_BACKGROUND_OVER_5_MIN"

//选球超过两千回滚的消息
#define   ROLL_BACK                                   @"ROLL_BACK"

//刷新我的彩票
#define   REFRESH_MYLOTTERY     @"REFRESH_MYLOTTERY"


#define HOME_FIRST_LOADED_MESSAGE               @"HOME_FIRST_LOADED_MESSAGE"

//找回密码成功
#define Find_Password_Success                   @"Find_Password_Success"


//合并成功
#define MERGE_SUCCESS_ACTION                    @"MERGE_SUCCESS_ACTION"

//咨询
#define CONSULTATION                            @"CONSULTATION"

//身边苏宁
#define NEARBYSUNING                            @"NEARBYSUNING"


//弹出选择搜索类型页面
#define SEARCHTYPE_CHANGED                  @"SEARCHTYPE_CHANGED"

//刷新搜索结果页
#define REFRESH_SEARCHLIST                    @"REFRESH_SEARCHLIST"

#define REFRESH_FILTERVIEWCTRL @"refreshFilterTableView"
#define DIDSELECT_CITY @"didSelectCity"
#define DIDSELECT_CATA @"didSelectCata"

#define VOICE_SEARCH  @"VOICESEARCH"
