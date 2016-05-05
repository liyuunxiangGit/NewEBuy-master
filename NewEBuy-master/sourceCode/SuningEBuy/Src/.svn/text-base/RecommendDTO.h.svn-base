//
//  RecommendListDTO.h
//  SuningEBuy
//
//  Created by 孔斌 on 14-4-8.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "BaseHttpDTO.h"
#import <Foundation/Foundation.h>
#import "DataProductBasic.h"

@interface RecommendDTO : BaseHttpDTO

#pragma mark ----------------------------- C店相关

@property (nonatomic, retain) NSString  *sceneId;           //场景的标识
@property (nonatomic, retain) NSString  *parameter;         //目录id
@property (nonatomic, retain) NSString  *cityId;            //城市Id
@property (nonatomic, retain) NSArray   *recommendList;     //推荐的商品集合

@end


@interface RecommendListDTO : BaseHttpDTO

{
    NSString     *_sugGoodsCode;              //推荐商品编码
    NSString     *_sugGoodsId;                //推荐商品ID
    NSString     *_sugGoodsName;              //推荐商品名称
    NSString     *_sugGoodsDes;               //推荐商品描述
    NSString     *_promotionInfo;             //促销信息
    NSString     *_vendorId;                  //供应商编码
    NSString     *_price;                     //推荐商品价格
    NSString     *_persent;                   //百分比（目前只有最终购买有）
    NSString     *_handwork;                  //是否是人工干预的数据（1是人工干预0,2是算法）
    NSURL        *_productUrl;                //商品图片地址
}

@property (nonatomic, strong) NSString  *sugGoodsCode;
@property (nonatomic, strong) NSString  *sugGoodsId;
@property (nonatomic, strong) NSString  *sugGoodsName;
@property (nonatomic, strong) NSString  *sugGoodsDes;
@property (nonatomic, strong) NSString  *promotionInfo;
@property (nonatomic, strong) NSString  *vendorId;
@property (nonatomic, strong) NSString  *price;
@property (nonatomic, strong) NSString  *persent;
@property (nonatomic, strong) NSString  *handwork;
@property (nonatomic, strong) NSURL     *productUrl;

- (DataProductBasic *)transformToProductDTO;

@end

