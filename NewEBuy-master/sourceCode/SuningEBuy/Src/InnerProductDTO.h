//
//  InnerProduct.h
//  SuningEBuy
//
//  Created by wei xie on 12-8-21.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseHttpDTO.h"
#import "DataProductBasic.h"

@interface InnerProductDTO : BaseHttpDTO{

    NSString *bigBang_;
    NSString *promIcon_;
    NSString *partNum_;
    NSString *productId_;
    NSString *productCode_;
    NSString *productName_;
    NSString *productDesc_;
    NSString *productImageURL_;
    NSString *productPrice_;
    
   
}
@property(nonatomic,copy) NSString *bigBang;
@property(nonatomic,copy) NSString *promIcon;
@property(nonatomic,copy) NSString *partNum;                //序号
@property(nonatomic,copy) NSString *productId;              //商品ID
@property(nonatomic,copy) NSString *productCode;            //商品编码
@property(nonatomic,copy) NSString *productName;            //商品名称
@property(nonatomic,copy) NSString *productDesc;            //商品卖点
@property(nonatomic,copy) NSString *productImageURL;        //商品图片链接
@property(nonatomic,copy) NSString *productPrice;           //商品价格
@property(nonatomic,copy) NSString *vendorCode;             //供应商编码

@property(nonatomic,copy) NSURL *priceImageURL;             //价格图片


- (DataProductBasic *)transformToProductDTO;

@end

@interface InnerProductBaseDTO : BaseHttpDTO

@property (nonatomic, strong) NSString *floorName;        //楼层名称
@property (nonatomic, strong) NSString *floorSeq;         //楼层序值
@property (nonatomic, strong) NSString *floorPic;         //楼层图片
@property (nonatomic, strong) NSString *floorDesc;        //楼层说明
@property (nonatomic, strong) NSArray  *innerProduct;     //商品详情列表

@end

@interface NewInnerProductDTO : BaseHttpDTO
@property (nonatomic, strong) NSString *sugGoodsId;     //推荐商品id
@property (nonatomic, strong) NSString *sugGoodsCode;
@property (nonatomic, strong) NSString *sugGoodsName;
@property (nonatomic, strong) NSString *sugGoodsDes;
@property (nonatomic, strong) NSString *promotionInfo;
@property (nonatomic, strong) NSString *vendorId;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *persent;
@property (nonatomic, strong) NSString *handwork;

- (DataProductBasic *)transformToProductDTO;
@end