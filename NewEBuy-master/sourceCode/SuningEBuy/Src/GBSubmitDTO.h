//
//  GBSubmitDTO.h
//  SuningEBuy
//
//  Created by  zhang jian on 13-2-25.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseHttpDTO.h"

/*!
 @abstract  支付方式
 */
typedef enum {
    GBPayModeUnSelect        = -1,     //未选择
    GBPayModeEfubao          = 1,  //易付宝支付  11608  15501
    GBPayModeOnlineBank      = 2,  //网银支付，现在的手机客户端不支持该方式 原为INT16_MAX
    GBPayModeHuiFuWeb        = 3   //汇付天下网页支付 11611   18001
}GBPayMode;



@interface GBSubmitDTO : BaseHttpDTO

{
    
}

@property (nonatomic, copy)  NSString                   *orderId;       //订单编号
@property (nonatomic, copy)  NSString                   *userId;        //会员编号
@property (nonatomic, copy)  NSString                   *payAmount;     //手机银联支付金额
@property (nonatomic, copy)  NSString                   *eppAmount;     //易付宝支付金额
@property (nonatomic, copy)  NSString                   *paymentType;   //支付方式   18001（汇付天下） 18002（中国银联） 0（易付宝余额支付）
@property (nonatomic, assign)GBPayMode                  payMode;       //支付方式

@property (nonatomic, copy)  NSString                   *memberId;
@property (nonatomic, copy)  NSString                   *eppPassword;   //支付密码
@property (nonatomic, copy)  NSString                   *validateMsg;   //验证码（根据需求添加）
@property (nonatomic, copy)  NSString                   *categoryId;

@property (nonatomic)NSInteger gbType;//酒店 非酒店

@property (nonatomic,strong)NSString *snProId;

@property (nonatomic, copy)  NSString *snProName;    


@end
