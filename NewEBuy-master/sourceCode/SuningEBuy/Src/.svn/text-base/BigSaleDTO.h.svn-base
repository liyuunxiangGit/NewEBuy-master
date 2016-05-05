//
//  BigSaleDTO.h
//  SuningEBuy
//
//  Created by 孔斌 on 14-7-23.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "BaseHttpDTO.h"
#import <Foundation/Foundation.h>

typedef enum _BigSaleState{
    BsReadyForSale,
    BsOnSale,
    BsSaleOut,
    BsTimeOver
}BigSaelState;


@interface BigSaleDTO : BaseHttpDTO

@property (nonatomic, strong) NSString *grppurId ;          //团购活动ID
@property (nonatomic, assign) BigSaelState bigSaleState;
@property (nonatomic, strong) NSString *grppurName;         //团购名称
@property (nonatomic, strong) NSString *gbCommHot;          //团购商品卖点
@property (nonatomic, strong) NSString *dataSrc;            //"数据来源", 0 : C店商品，1:  B店商品
@property (nonatomic, strong) NSString *categCode;          //类目编码
@property (nonatomic, strong) NSString *brandCode;          //品牌编码
@property (nonatomic, strong) NSString *vendorCode;         //商家编码
@property (nonatomic, strong) NSString *vendorName;         //商家名称
@property (nonatomic, strong) NSString *partType;           //"商品类型", 0：单一商品 1：通码商品
@property (nonatomic, strong) NSString *partNumber;         //商品编码
@property (nonatomic, strong) NSString *partName;           //商品名称
@property (nonatomic, strong) NSString *gbCommNum;          //参团商品数量
@property (nonatomic, strong) NSString *limitBuyNum;        //每人限购数量
@property (nonatomic, strong) NSString *gbPrice;            //团购价
@property (nonatomic, strong) NSString *payPrice;           //易购价
@property (nonatomic, strong) NSString *previewBegindt;     //预热开始时间
@property (nonatomic, strong) NSString *previewEnddt;       //预热结束时间
@property (nonatomic, strong) NSString *gbBegindate;        //团购开始时间
@property (nonatomic, strong) NSString *gbEnddate;          //团购结束时间
@property (nonatomic, strong) NSString *stauts;             //"状态", 0:不启用  1：启用
@property (nonatomic, strong) NSString *saleNum;            //已购买人数
@property (nonatomic, strong) NSString *curTime;            // 当前时间 yyyy-MM-dd HH:mm:ss
@property (nonatomic, strong) NSArray  *subInfoList;        //其他子码列表


@property (nonatomic, assign) NSTimeInterval startTimeSeconds;
@property (nonatomic, assign) NSTimeInterval endTimeSeconds;

-(void)encodeFromDictionary:(NSDictionary *)dic;
-(void)setBigSaleStatus:(NSString *)bigSaleState;

@end
