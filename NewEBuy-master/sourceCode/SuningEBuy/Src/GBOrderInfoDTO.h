//
//  GBOrderInfoDTO.h
//  SuningEBuy
//
//  Created by  liukun on 12-12-29.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GBConfig.h"
#import "GBVoucherDTO.h"
#import "GBVoucherSingleInfoDTO.h"
#import "GBShopDTO.h"

typedef enum {
    GBOrderWaitPay = 0,         //等待支付
    GBOrderPaySuccess,          //支付完成
    GBOrderComplete,            //订单完成
    GBOrderCancel,              //订单取消
    GBOrderRefunding,           //订单退款中
    GBOrderRefunded,            //订单退款完成
    GBOrderSystemCancel     //系统订单取消
}GBOrderStatus;

@interface GBOrderInfoDTO : NSObject
{
@private
    GBType          _gbType;        //团购类型
    NSString        *_createTime;   //订单创建时间
    NSString        *_orderAmount;  //订单金额
    GBOrderStatus   _orderStatus;   //订单状态
    NSString        *_snProId;      //商品编号
    NSString        *_saleCount;    //购买数量
    NSString        *_snProAmount;  //商品单价
    NSString        *_snProName;    //商品名称
    NSString        *_orderId;      //订单id
    
    //详情字段
    NSString        *_telephone;    //联系电话
    NSString        *_userId;       //会员编号
    BOOL            _canRefund;     //是否能退款，窝窝团才有
    NSString        *_notice;       //温馨提示
    NSMutableArray         *_voucherList;  //券列表
    
    NSInteger        _voucherType;//券类型
    GBVoucherDTO        *_voucherMap;//券信息
    NSString        *_hotelId;//酒店编号
    NSString        *_hotelName;//酒店名称
    NSString       *_email;//用户邮箱
    NSString       *_service;//团购服务
    NSMutableArray *_shopList;//分库信息
    
    
}

@property (nonatomic, assign) GBType gbType;
@property (nonatomic, copy)   NSString *createTime;
@property (nonatomic, copy)   NSString *orderAmount;
@property (nonatomic, assign) GBOrderStatus orderStatus;

@property (nonatomic, strong) NSString *statusName;

@property (nonatomic, copy)   NSString *snProId;
@property (nonatomic, copy)   NSString *saleCount;
@property (nonatomic, copy)   NSString *snProAmount;
@property (nonatomic, copy)   NSString *snProName;
@property (nonatomic, copy)   NSString *orderId;
@property (nonatomic,strong)  NSString *imgUrlStr;

@property (nonatomic, copy)   NSString *telephone;
@property (nonatomic, copy)   NSString *userId;
@property (nonatomic, assign) BOOL canRefund; //未消费退款
@property (nonatomic, copy)   NSString *notice;
@property (nonatomic, strong) NSMutableArray *voucherList;
@property (nonatomic)         BOOL canExpireRefund;//已过期退款

@property (nonatomic,assign)  NSInteger        voucherType;
@property (nonatomic,strong)  GBVoucherDTO        *voucherMap;
@property (nonatomic,strong)  NSString        *hotelId;
@property (nonatomic,strong)  NSString        *hotelName;
@property (nonatomic,strong)  NSString        *email;
@property (nonatomic,strong)  NSString        *service;
@property (nonatomic,strong)  NSMutableArray        *shopList;
@property (nonatomic,strong)  NSString       *spSrc;


- (void)encodeOrderListFromDic:(NSDictionary *)dic;
- (void)encodeOrderDetailFromDic:(NSDictionary *)dic;


@end
