//
//  GBErrorCode.h
//  SuningEBuy
//
//  Created by  zhang jian on 13-2-25.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#ifndef SuningEBuy_GBErrorCode_h
#define SuningEBuy_GBErrorCode_h


//商品异常信息列表

/*
 100001	错误信息: 城市ID不能为空
 100002	错误信息: 每页条数不能为空
 100003	错误信息: 当前页数不合法
 100004	错误信息: 窝窝商品ID不能为空
 100005	错误信息: 窝窝商品ID不存在
 100006	错误信息: 商品ID不合法
 100007	错误信息: 酒店ID不能为空
 100008	错误信息: 酒店商品ID不存在
 100009	错误信息: 关键字输入有误
 100010	错误信息: 关键字不能为空
 */
#define     GBErrorCode_100001          L(@"GBCityIDCanNotBeEmpty")
#define     GBErrorCode_100002          L(@"GBItemInEveryPageCanNotBeEmpty")
#define     GBErrorCode_100003          L(@"GBPresentPageIsIllegal")
#define     GBErrorCode_100004          L(@"GBWOWOProductIDCanNotBeEmpty")
#define     GBErrorCode_100005          L(@"GBWOWOProductIDIsNotExist")
#define     GBErrorCode_100006          L(@"GBProductIDIsIllegal")
#define     GBErrorCode_100007          L(@"GBHotelIDCanNotBeEmpty")
#define     GBErrorCode_100008          L(@"GBHotelProductIDIsNotExist")
#define     GBErrorCode_100009          L(@"GBKeyWrong")
#define     GBErrorCode_100010          L(@"GBKeyWordCanNotBeEmpty")






/*
 200001	错误信息: 会员编号不能为空
 200002	错误信息: 查询时间段不能为空
 200003	错误信息: 当前页数不能为空
 200004	错误信息: 每页条数不能为空
 200005	错误信息: 查询时间段输入有误
 200006	错误信息: 订单编号不能为空
 200007	错误信息: 订单来源不能为空
 200008	错误信息: 订单来源输入有误
 200009	错误信息: 窝窝团购订单取消失败
 200010	错误信息: 酒店团购订单取消失败
 */
#define     GBErrorCode_200001          L(@"GBMemberNumberCanNotBeEmpty")
#define     GBErrorCode_200002          L(@"GBCheckTimeCanNotBeEmpty")
#define     GBErrorCode_200003          L(@"GBPresentPageIsIllegal")
#define     GBErrorCode_200004          L(@"GBItemInEveryPageCanNotBeEmpty")
#define     GBErrorCode_200005          L(@"GBCheckTimeInputIsWrong")
#define     GBErrorCode_200006          L(@"GBOrderNumberCanNotBeEmpty")
#define     GBErrorCode_200007          L(@"GBOrderSourceCanNotBeEmpty")
#define     GBErrorCode_200008          L(@"GBOrderSourceInputError")
#define     GBErrorCode_200009          L(@"GBWOWOOrderCancelFail")
#define     GBErrorCode_200010          L(@"GBHotelOrderCancelFail")





/*
 200011	错误信息: 窝窝团购订单退款失败
 200012	错误信息: 酒店团购订单不允许退款
 200013	错误信息: 此订单不是该会员的订单
 200014	错误信息: 购买数量不能为空
 200015	错误信息: 购买数量必须是纯数字
 200016	错误信息: 手机号码不能为空
 200017	错误信息: 手机号码必须是纯数字
 200018	错误信息: 内卡号不能为空
 200019	错误信息: 外卡号不能为空
 200020	错误信息: 订单生成失败，请重新提交
 */
#define     GBErrorCode_200011          L(@"GBWOWOOrderRefundFail")
#define     GBErrorCode_200012          L(@"GBHotelOrderProhibitRefund")
#define     GBErrorCode_200013          L(@"GBOrderNotBelongToThisMember")
#define     GBErrorCode_200014          L(@"GBBuyNumberCanNotBeEmpty")
#define     GBErrorCode_200015          L(@"GBBuyNumberMustAllBeFigure")
#define     GBErrorCode_200016          L(@"GBMobileNumberCanNotBeEmpty")
#define     GBErrorCode_200017          L(@"GBMobileNumberMustAllBeFigure")
#define     GBErrorCode_200018          L(@"GBNumberInsideCanNotBeEmpty")
#define     GBErrorCode_200019          L(@"GBNumberOutsideCanNotBeEmpty")
#define     GBErrorCode_200020          L(@"GBOrderBringFail")



/*
 200021	错误信息: 商品编号不能为空
 200022	错误信息:  酒店编号不能为空
 */
#define     GBErrorCode_200021          L(@"GBProductCodeCanNotBeEmpty")
#define     GBErrorCode_200022          L(@"GBHotelCodeCanNotBeEmpty")



//订单支付异常信息列表

/*
 300001	错误信息: 订单编号不能为空
 300002	错误信息: 会员编号不能为空
 300003	错误信息: 订单支付金额不合法（不能为空，必须为纯数字）
 300004	错误信息: 易付宝支付金额不能为空
 300005	错误信息: 订单信息获取失败
 300006	错误信息: 交易订单不存在
 300007	错误信息: 订单总金额与易付宝支付金额不相等
 300008	错误信息: 订单为非待支付状态
 300009	错误信息: 验证码不能为空
 300010	错误信息: 支付密码不能为空
*/
#define     GBErrorCode_300001          L(@"GBMemberOrderCodeCanNotBeEmpty")
#define     GBErrorCode_300002          L(@"GBMemberCodeCanNotBeEmpty")
#define     GBErrorCode_300003          L(@"GBOrderPayIsIllegal")
#define     GBErrorCode_300004          L(@"GBEBuyPayNumberCanNotBeEmpty")
#define     GBErrorCode_300005          L(@"GBOrderInfoGetFail")
#define     GBErrorCode_300006          L(@"GBOrderIsNotExist")
#define     GBErrorCode_300007          L(@"GBOrderTotalNumberIsNotEqualToEBuyNumber")
#define     GBErrorCode_300008          L(@"GBOrderIsNotWaitToBePaid")
#define     GBErrorCode_300009          L(@"GBVerifyCodeCanNotBeEmpty")
#define     GBErrorCode_300010          L(@"GBPaySecretCodeCanNotBeEmpty")




/*
 300011	错误信息: 支付方式入库订单表失败
 300012	错误信息: 支付方式不能为空
 300013	错误信息: 下架商品不可支付
 300014	错误信息: 查询易付宝余额异常
 300015	错误信息: 支付成功！保存支付数据和同步订单时捕获异常
 300016	错误信息: 订单支付失败，请稍后再试
 300017	错误信息: 易付宝支付密码校验失败
 300018	错误信息: 商品库存不足，无法满足订单需求
 300019	错误信息: 对不起，您来晚了，团购已结束，请重新选择
 */
#define     GBErrorCode_300011          L(@"GBOrderInStorageFail")
#define     GBErrorCode_300012          L(@"GBPayMethodCanNotBeEmpty")
#define     GBErrorCode_300013          L(@"GBCanNotPayForCancelProduct")
#define     GBErrorCode_300014          L(@"GBCheckForYUEBAOError")
#define     GBErrorCode_300015          L(@"GBPaySuccessButGetError")
#define     GBErrorCode_300016          L(@"GBOrderPayFail")
#define     GBErrorCode_300017          L(@"GBPayVerifyCodeCheckFail")
#define     GBErrorCode_300018          L(@"GBProductIsNotEnoughForOrder")
#define     GBErrorCode_300019          L(@"GBSorryForLater")



#endif
