//
//  ReturnGoodsPrepareDTO.h
//  SuningEBuy
//
//  Created by david david on 12-8-8.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseHttpDTO.h"


@interface ReturnGoodsPrepareDTO : BaseHttpDTO
@property (nonatomic,copy) NSString  *vendorCShopName;      //销售商家
@property (nonatomic,copy) NSString  *vendorCode;           //商家编码
@property(nonatomic,copy)   NSString *orderId;              //订单号
@property(nonatomic,copy)   NSString *orderItemsId;         //订单行项目号
@property(nonatomic,copy)   NSString *productName;          //商品名称
@property(nonatomic,copy)   NSString *productCode;          //商品编码

@property(nonatomic,copy)   NSString *quantityValue;        //商品数量
@property(nonatomic,copy)   NSString *deliveryDate;         //取件日期
@property(nonatomic,copy)   NSString *policyDesc;           //支付类型
@property(nonatomic,copy)   NSString *channel;              //销售渠道
@property(nonatomic,copy)   NSString *eppActiveFlag;        //易付宝是否已经激活
@property(nonatomic,copy)   NSString *returnType;           //退款方式
@property(nonatomic,copy)   NSString *appraisal;            //鉴定方  0表示空 1表示我司 2表示供应商 3表示现场客户
@property(nonatomic,copy)   NSString *factoryContect;       //厂家联系电话
@property(nonatomic,copy)   NSString *heyueji;              //合约机标识，目前为空
@property(nonatomic,copy)   NSString *powerFlag;            //节能补贴标识 Y为节能补贴
@property(nonatomic,copy)   NSString *text;                 //退货类型
@property(nonatomic,copy)   NSString *errorCode;            //错误码

@property(nonatomic,copy)   NSString *returnYfbAmount;      //易付宝付款金额，返回易付宝金额
@property(nonatomic,copy)   NSString *returnYhkAmount;      //银行卡付款金额，返回银行卡
@property(nonatomic,copy)   NSString *returnFlag;            //退款标识  “1”: 企业版网银支付、快捷支付、信用卡直付、个人网银支付退至银行卡 “2”:退至易付宝账户“3”:第三方支付退银行卡 “4”:货到付款现金支付  退至银行卡账户  退至易付宝账户   “6”:退至相应账户  “7”:礼品卡、券退回账户
@property(nonatomic,copy)   NSString *returncard;            //是否必传卡信息标识 “1”:必传卡信息“0”:非必须
@property(nonatomic,copy)   NSString *payFlag;               //支付类型标识   “1”:单笔支付   “2”:混合支付
@property(nonatomic,copy)   NSString *currentDay;            //系统当前日期

@property(nonatomic,copy)   NSString *zstatus1;              //

@property(nonatomic,copy)   NSString *needTOOnline;          //是否需要在线客服退货 1需要，0不需要

@property(nonatomic,copy)   NSString *partNumber;          //是否需要在线客服退货 1需要，0不需要

@property(nonatomic,copy)   NSString *price;
@property(nonatomic,copy)   NSString *payWay;

@property (nonatomic, strong) NSString *payFreeForReturn; //取件费

@property (nonatomic, strong) NSString *invoiceIsPrinted;//是否打印发票

@property (nonatomic, strong) NSString *unreasonableReturnFlag;//是否可无理由退货
@property (nonatomic, strong) NSString *minDeliverDate;//开始日期
@property (nonatomic, strong) NSString *maxDeliverDate;//终止日期
@property (nonatomic, strong) NSString *province;//省
@property (nonatomic, strong) NSString *city;//市

@property (nonatomic, strong) NSString *area;//区
@property (nonatomic ,strong) NSString *detailAddress;//详细地址

//245
@property (nonatomic ,strong) NSString *permitRetStatus;//可退货状态
@property (nonatomic ,strong) NSString *permitRetNum;//可退货数量
@property (nonatomic ,strong) NSString *apprFlag;//鉴定标识
@property (nonatomic ,strong) NSString *apprType;//鉴定类型
@property (nonatomic ,strong) NSString *apprAddress;//退货鉴定地址
@property (nonatomic ,strong) NSString *telnum;//退货鉴定联系方式
@end
