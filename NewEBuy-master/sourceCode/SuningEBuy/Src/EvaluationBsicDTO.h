//
//  EvaluationBsicDTO.h
//  SuningEBuy
//
//  Created by 孔斌 on 13-8-24.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EvaluationBsicDTO : NSObject

@property (nonatomic, strong) NSString *qualityStar;      //商品满意度
@property (nonatomic, strong) NSString *content;          //使用心得
@property (nonatomic, strong) NSString *orderItemId;      //订单行项目ID
@property (nonatomic, strong) NSString *anonFlag;         //是否匿名     1 是匿名，0是非匿名
@property (nonatomic, strong) NSString *orderId;          //B2C订单号
@property (nonatomic, strong) NSString *partNumber;       //商品编码
@property (nonatomic, strong) NSString *attitudeStar;     //卖家的服务态度      1~5
@property (nonatomic, strong) NSString *sellerSpeedStar;  //卖家的发货速度      1~5
@property (nonatomic, strong) NSString *dlvrSpeedStar;    //物流的送货速度      1~5


@end
