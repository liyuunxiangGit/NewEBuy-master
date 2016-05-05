//
//  GBGoodsDetailDTO.m
//  SuningEBuy
//
//  Created by  zhang jian on 13-2-26.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "GBGoodsDetailDTO.h"
#import "GBShopsListDTO.h"

@implementation GBGoodsDetailDTO

@synthesize snProId                         = _snProId;
@synthesize goodsName                       = _goodsName;
@synthesize goodsTitle                      = _goodsTitle;
@synthesize isGoods                         = _isGoods;
@synthesize imgBUrl                         = _imgBUrl;

@synthesize imgSUrl                         = _imgSUrl;
@synthesize presentPrice                    = _presentPrice;
@synthesize orignalPrice                    = _orignalPrice;
@synthesize saleCount                       = _saleCount;
@synthesize cityName                        = _cityName;

@synthesize titlePrefix                     = _titlePrefix;
@synthesize discount                        = _discount;
@synthesize surplusTime                     = _surplusTime;
@synthesize savePrice                       = _savePrice;
@synthesize refundType                      = _refundType;
@synthesize expireRefundType                = _expireRefundType;

@synthesize ifEnd                           = _ifEnd;
@synthesize grouponDetails                  = _grouponDetails;
@synthesize singleLimit                     = _singleLimit;
@synthesize splitValueServers               = _splitValueServers;
@synthesize groupShopsMap                   = _groupShopsMap;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_snProId);
    TT_RELEASE_SAFELY(_goodsName);
    TT_RELEASE_SAFELY(_goodsTitle);
    TT_RELEASE_SAFELY(_isGoods);
    TT_RELEASE_SAFELY(_imgBUrl);
    
    TT_RELEASE_SAFELY(_imgSUrl);
    TT_RELEASE_SAFELY(_presentPrice);
    TT_RELEASE_SAFELY(_orignalPrice);
    TT_RELEASE_SAFELY(_saleCount);
    TT_RELEASE_SAFELY(_cityName);
    
    TT_RELEASE_SAFELY(_titlePrefix);
    TT_RELEASE_SAFELY(_discount);
    TT_RELEASE_SAFELY(_surplusTime);
    TT_RELEASE_SAFELY(_savePrice);
    TT_RELEASE_SAFELY(_refundType);
    TT_RELEASE_SAFELY(_expireRefundType);
    
    TT_RELEASE_SAFELY(_ifEnd);
    TT_RELEASE_SAFELY(_grouponDetails);
    TT_RELEASE_SAFELY(_singleLimit);
    TT_RELEASE_SAFELY(_splitValueServers);
    TT_RELEASE_SAFELY(_groupShopsMap);
    
}

- (void)encodeFromDictionary:(NSDictionary *)dic
{
    
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    self.snProId            = EncodeStringFromDic(dic, @"snProId");
    self.goodsName          = EncodeStringFromDic(dic, @"goodsName");
    self.goodsTitle         = EncodeStringFromDic(dic, @"goodsTitel");
    self.isGoods            = EncodeStringFromDic(dic, @"isGoods");
    self.imgBUrl            = [NSURL URLWithString:EncodeStringFromDic(dic, @"imgBUrl")];
    
    self.imgSUrl            = [NSURL URLWithString:EncodeStringFromDic(dic, @"imgSUrl")];
    self.presentPrice       = EncodeStringFromDic(dic, @"presentPrice");
    self.orignalPrice       = EncodeStringFromDic(dic, @"orignalPrice");
    self.saleCount          = EncodeStringFromDic(dic, @"saleCount");
    self.cityName           = EncodeStringFromDic(dic, @"cityName");
    
    self.titlePrefix       = EncodeStringFromDic(dic, @"titlePrefix");
    self.discount           = EncodeStringFromDic(dic, @"discount");
    self.surplusTime        = EncodeStringFromDic(dic, @"surplusTime");
    
    NSString *__surplusTime = [dic objectForKey:@"surplusTime"];
    
    if (IsStrEmpty(__surplusTime) || [__surplusTime isEqualToString:@""]) {
        self.surplusTime = @"0";
    }else{
        self.surplusTime = [NSString stringWithFormat:@"%lf",[__surplusTime doubleValue] / 1000];
    }
    
    self.savePrice          = EncodeStringFromDic(dic, @"savePrice");
    self.refundType         = EncodeStringFromDic(dic, @"refundType");
    self.expireRefundType   = EncodeStringFromDic(dic, @"expireRefundType");
    
    self.ifEnd              = EncodeStringFromDic(dic, @"ifEnd");
    
    
    self.grouponDetails     = [NSString stringWithFormat:@"%@?snProId=%@",EncodeStringFromDic(dic, @"grouponDetails"),self.snProId];
    
    self.singleLimit        = EncodeStringFromDic(dic, @"singleLimit");
    self.splitValueServers  = EncodeStringFromDic(dic, @"splitValueServers");
    
    NSMutableArray *shopList = [dic objectForKey:@"groupShopsMap"];
    
    if (!IsArrEmpty(shopList) && [shopList count] != 0) {
        NSMutableArray *shopArr = [[NSMutableArray alloc] initWithCapacity:[shopList count]];
        for (NSDictionary *shopDic in shopList) {
            GBShopsListDTO *dto = [[GBShopsListDTO alloc] init];
            [dto encodeFromDictionary:shopDic];
            [shopArr addObject:dto];
        }
        self.groupShopsMap = shopArr;
    }
    
}



@end
