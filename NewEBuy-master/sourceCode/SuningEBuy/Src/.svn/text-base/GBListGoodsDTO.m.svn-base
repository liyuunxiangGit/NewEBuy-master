//
//  GBListGoodsDTO.m
//  SuningEBuy
//
//  Created by shasha on 13-2-26.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "GBListGoodsDTO.h"

@implementation GBListGoodsDTO

@synthesize snProId = _snProId;
@synthesize goodId = _goodId;
@synthesize goodName = _goodName;
@synthesize descriptions = _descriptions;
@synthesize title2 = _title2;
@synthesize bimg = _bimg;
@synthesize simg = _simg;
@synthesize limg = _limg;
@synthesize presentPrice = _presentPrice;
@synthesize originPrice = _originPrice;
@synthesize today = _today;
@synthesize saleCount = _saleCount;
@synthesize upTime = _upTime;
@synthesize downTime = _downTime;
@synthesize boutique = _boutique;
@synthesize star = _star;
@synthesize areaName = _areaName;
@synthesize businessName = _businessName;
@synthesize titlePrefix = _titlePrefix;
@synthesize goodSrc = _goodSrc;
@synthesize shopName = _shopName;
@synthesize buyFlag = _buyFlag;
@synthesize zheKou = _zheKou;
@synthesize savePrice = _savePrice;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_snProId);
    TT_RELEASE_SAFELY(_goodId);
    TT_RELEASE_SAFELY(_goodName);
    TT_RELEASE_SAFELY(_descriptions);
    TT_RELEASE_SAFELY(_title2);
    TT_RELEASE_SAFELY(_bimg);
    TT_RELEASE_SAFELY(_simg);
    TT_RELEASE_SAFELY(_limg);
    TT_RELEASE_SAFELY(_presentPrice);
    TT_RELEASE_SAFELY(_originPrice);
    TT_RELEASE_SAFELY(_today);
    TT_RELEASE_SAFELY(_saleCount);
    TT_RELEASE_SAFELY(_upTime);
    TT_RELEASE_SAFELY(_downTime);
    TT_RELEASE_SAFELY(_boutique);
    TT_RELEASE_SAFELY(_star);
    TT_RELEASE_SAFELY(_areaName);
    TT_RELEASE_SAFELY(_businessName);
    TT_RELEASE_SAFELY(_titlePrefix);
    TT_RELEASE_SAFELY(_goodSrc);
    TT_RELEASE_SAFELY(_shopName);
    TT_RELEASE_SAFELY(_buyFlag);
    TT_RELEASE_SAFELY(_zheKou);
    TT_RELEASE_SAFELY(_savePrice);
    
}

- (void)encodeFromDictionary:(NSDictionary *)dic{
    
    if (dic == nil) {
        return;
    }
    
    self.snProId = EncodeStringFromDic(dic, @"snProId");
    self.goodId = EncodeStringFromDic(dic, @"goodId");
    self.goodName = EncodeStringFromDic(dic, @"goodName");
    self.descriptions = EncodeStringFromDic(dic, @"description");
    self.title2 = EncodeStringFromDic(dic, @"title2");
    self.bimg = EncodeStringFromDic(dic, @"bimg");
    self.simg = EncodeStringFromDic(dic, @"simg");
    self.limg = EncodeStringFromDic(dic, @"limg");
    self.presentPrice = EncodeStringFromDic(dic, @"presentPrice");
    self.originPrice = EncodeStringFromDic(dic, @"originPrice");
    self.today = EncodeStringFromDic(dic, @"today");
    self.saleCount = EncodeStringFromDic(dic, @"saleCount");
    self.upTime = EncodeStringFromDic(dic, @"upTime");
    self.downTime = EncodeStringFromDic(dic, @"downTime");
    self.boutique = EncodeStringFromDic(dic, @"boutique");
    self.star = EncodeStringFromDic(dic, @"star");
    self.areaName = EncodeStringFromDic(dic, @"areaName");
    self.businessName = EncodeStringFromDic(dic, @"businessName");
    self.titlePrefix = EncodeStringFromDic(dic, @"titlePrefix");
    self.goodSrc = EncodeStringFromDic(dic, @"goodSrc");
    self.shopName = EncodeStringFromDic(dic, @"shopName");
    self.buyFlag = EncodeStringFromDic(dic, @"buyFlag");
    self.zheKou = EncodeStringFromDic(dic, @"zheKou");
    self.savePrice = EncodeStringFromDic(dic, @"savePrice");
}

@end
