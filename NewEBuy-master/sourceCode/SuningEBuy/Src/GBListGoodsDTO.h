//
//  GBListGoodsDTO.h
//  SuningEBuy
//
//  Created by shasha on 13-2-26.
//  Copyright (c) 2013年 Suning. All rights reserved.
//  GoodTuanVO 商品列表


@interface GBListGoodsDTO :NSObject

@property (nonatomic, copy) NSString  *snProId;   //商品编码
@property (nonatomic, copy) NSString  *goodId;  //商品ID
@property (nonatomic, copy) NSString  *goodName;  //商品名称
@property (nonatomic, copy) NSString  *descriptions;  //商品描述
@property (nonatomic, copy) NSString  *title2;  //中标题
@property (nonatomic, copy) NSString  *bimg;  //大图地址
@property (nonatomic, copy) NSString  *simg;  //小图地址
@property (nonatomic, copy) NSString  *limg;  //列表图
@property (nonatomic, copy) NSString  *presentPrice;  //现价
@property (nonatomic, copy) NSString  *originPrice;  //原价
@property (nonatomic, copy) NSString  *today;  //今日新团
@property (nonatomic, copy) NSString  *saleCount;  //销量
@property (nonatomic, copy) NSString  *upTime;  //上架时间
@property (nonatomic, copy) NSString  *downTime;  //下架时间
@property (nonatomic, copy) NSString  *boutique;  //是否精品
@property (nonatomic, copy) NSString  *star;  //星级
@property (nonatomic, copy) NSString  *areaName;  //区域名称
@property (nonatomic, copy) NSString  *businessName;  //商圈名称
@property (nonatomic, copy) NSString  *titlePrefix;  //商品描述前缀
@property (nonatomic, copy) NSString  *goodSrc;  //商品来源
@property (nonatomic, copy) NSString  *shopName;  //店铺名称
@property (nonatomic, copy) NSString  *buyFlag;  //团购状态
@property (nonatomic, copy) NSString  *zheKou;  //打折
@property (nonatomic, copy) NSString  *savePrice;  //节约价格

- (void)encodeFromDictionary:(NSDictionary *)dic;

@end
