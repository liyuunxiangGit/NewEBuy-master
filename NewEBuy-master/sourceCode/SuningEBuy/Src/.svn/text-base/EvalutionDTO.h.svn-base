//
//  EvalutionDTO.h
//  SuningEBuy
//
//  Created by  zhang jian on 13-4-9.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EvalutionDTO : BaseHttpDTO

{
    NSString           *_orderId;                  //B2C订单号
    NSString           *_orderTime;                //下单时间
    NSArray            *_orderItemList;            //商品详情

}

@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, strong) NSString *orderTime;
@property (nonatomic, strong) NSArray  *orderItemList;


@end

@interface EvalutionDetailDTO : BaseHttpDTO
{
    NSString     *partNumber;                //商品编码
    NSString     *catentryId;                //商品ID
    NSString     *catentryName;              //商品名称
    NSString     *orderItemId;               //B2C订单行项目号
    NSString     *supplierName;              //供应商名称
    NSString     *reviewFlag;                //是否已评价标识：1-是；0-否
    NSString     *orderShowFlag;             //是否已晒单标识：1-是；0-否
    NSURL        *_productUrl;               //商品图片地址
}

@property (nonatomic, strong) NSString *partNumber;
@property (nonatomic, strong) NSString *catentryId;
@property (nonatomic, strong) NSString *catentryName;
@property (nonatomic, strong) NSString *orderItemId;
@property (nonatomic, strong) NSString *supplierName;
@property (nonatomic, strong) NSString *reviewFlag;
@property (nonatomic, strong) NSString *orderShowFlag;
@property (nonatomic, strong) NSURL    *productUrl;



@end