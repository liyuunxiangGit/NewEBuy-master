//
//  PanicPurchaseDTO.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-4-18.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "PanicPurchaseDTO.h"
#import "ProductUtil.h"

@implementation PanicPurchaseDTO

@synthesize rushPurId = _rushPurId;

@synthesize startTime = _startTime;

@synthesize endTime = _endTime;

@synthesize currentTime = _currentTime;

@synthesize totalQtyLmt = _totalQtyLmt;

@synthesize leftQty =_leftQty;

@synthesize catentryId = _catentryId;

@synthesize partNumber = _partNumber;

@synthesize catentryName = _catentryName;

@synthesize  catalogId = _catalogId;

@synthesize purchaseState = purchaseState_;

@synthesize netPrice = _netPrice;

@synthesize rushPurPrice = _rushPurPrice;

@synthesize imageURL = _imageURL;

@synthesize descriptions = _descriptions;

@synthesize isSale = _isSale;

@synthesize startTimeSeconds = _startTimeSeconds;

@synthesize endTimeSeconds = _endTimeSeconds;

- (void)dealloc {
    
    TT_RELEASE_SAFELY(_rushPurId);
    TT_RELEASE_SAFELY(_startTime);
    TT_RELEASE_SAFELY(_endTime);
    TT_RELEASE_SAFELY(_currentTime);
    TT_RELEASE_SAFELY(_totalQtyLmt);
    TT_RELEASE_SAFELY(_leftQty);
    TT_RELEASE_SAFELY(_catentryId);
    TT_RELEASE_SAFELY(_partNumber);
    TT_RELEASE_SAFELY(_catentryName);
    TT_RELEASE_SAFELY(_catalogId);
    TT_RELEASE_SAFELY(_netPrice);
    TT_RELEASE_SAFELY(_rushPurPrice);
    TT_RELEASE_SAFELY(_imageURL);
    TT_RELEASE_SAFELY(_descriptions);
    TT_RELEASE_SAFELY(_isSale);
}

- (id)init
{
    self = [super init];
    if (self) {
        self.shopCode = @"";
    }
    return self;
}

//抢购列表B2C渠道
- (void)encodeRushListForB2CFromDic:(NSDictionary *)dic
{
    self.catentryId = EncodeStringFromDic(dic, @"catentry_id");
    self.rushPurId = EncodeStringFromDic(dic, @"xgrppu_id");
    self.startTime = EncodeStringFromDic(dic, @"starttime");
    self.endTime = EncodeStringFromDic(dic, @"endtime");
    self.currentTime = EncodeStringFromDic(dic, @"currenttime");
    self.totalQtyLmt = EncodeStringFromDic(dic, @"limit_count");
    self.leftQty = EncodeStringFromDic(dic, @"subCount");
    self.partNumber = EncodeStringFromDic(dic, @"partnumber");
    self.catentryName = EncodeStringFromDic(dic, @"catenname");
    self.descriptions = EncodeStringFromDic(dic, @"catentry_desc");
    self.purchaseState = EncodeStringFromDic(dic, @"startFlag").integerValue;
    self.netPrice = EncodeStringFromDic(dic, @"netPrice");
    self.rushPurPrice = EncodeStringFromDic(dic, @"price");
    NSString *shopCode = EncodeStringFromDic(dic, @"shopCode");
    self.shopCode = shopCode?shopCode:@"";
    NSURL *imageUrl = [ProductUtil getImageUrlWithProductCode:self.partNumber size:ProductImageSize200x200];
    self.imageURL = imageUrl;

    self.startFlag = EncodeStringFromDic(dic, @"startFlag");
    
    if ([self.startFlag isEqualToString:@"0"]) {
        self.purchaseState = ReadyForSale;
    }
    else if ([self.startFlag isEqualToString:@"1"])
    {
        self.purchaseState = OnSale;
    }
    else
    {
        self.purchaseState = SaleOut;
    }
    
    [self checkState];

}

//抢购详情B2C渠道
- (void)encodeRushDetailForB2CFromDic:(NSDictionary *)dic
{
    self.catentryId = EncodeStringFromDic(dic, @"catentry_id");
    self.rushPurId = EncodeStringFromDic(dic, @"rushpur_id");
    self.startTime = EncodeStringFromDic(dic, @"starttime");
    self.endTime = EncodeStringFromDic(dic, @"endtime");
    self.currentTime = EncodeStringFromDic(dic, @"currenttime");
    self.totalQtyLmt = EncodeStringFromDic(dic, @"limit_count");
    self.leftQty = EncodeStringFromDic(dic, @"subCount");
    self.partNumber = EncodeStringFromDic(dic, @"partnumber");
    self.catentryName = EncodeStringFromDic(dic, @"catenname");
    self.descriptions = EncodeStringFromDic(dic, @"catentry_desc");
    self.purchaseState = EncodeStringFromDic(dic, @"startFlag").integerValue;
    self.netPrice = EncodeStringFromDic(dic, @"netPrice");
    self.rushPurPrice = EncodeStringFromDic(dic, @"price");
    self.isSale = EncodeStringFromDic(dic, @"isSale");
    NSString *shopCode = EncodeStringFromDic(dic, @"shopCode");
    self.shopCode = shopCode?shopCode:@"";
    NSURL *imageUrl = [ProductUtil getImageUrlWithProductCode:self.partNumber size:ProductImageSize200x200];
    self.imageURL = imageUrl;
    
    self.startFlag = EncodeStringFromDic(dic, @"startFlag");
    
    if ([self.startFlag isEqualToString:@"0"]) {
        self.purchaseState = ReadyForSale;
    }
    else if ([self.startFlag isEqualToString:@"1"])
    {
        self.purchaseState = OnSale;
    }
    else
    {
        self.purchaseState = SaleOut;
    }
    
    [self checkState];
}
//Mobile渠道的抢购解析
- (void)encodeRushForMobileFromDic:(NSDictionary *)dic
{
    self.catentryId = EncodeStringFromDic(dic, @"catentryId");
    self.rushPurId = EncodeStringFromDic(dic, @"rushPurId");
    self.startTime = EncodeStringFromDic(dic, @"startTime");
    self.endTime = EncodeStringFromDic(dic, @"endTime");
    self.currentTime = EncodeStringFromDic(dic, @"currentTime");
    self.totalQtyLmt = EncodeStringFromDic(dic, @"totalQtyLmt");
    self.leftQty = EncodeStringFromDic(dic, @"leftQty");
    self.partNumber = EncodeStringFromDic(dic, @"partNumber");
    self.catentryName = EncodeStringFromDic(dic, @"catentryName");
    self.descriptions = EncodeStringFromDic(dic, @"catentryDesc");
    self.catalogId = EncodeStringFromDic(dic, @"catalogId");
    self.purchaseState = EncodeStringFromDic(dic, @"status").integerValue;
    self.netPrice = EncodeStringFromDic(dic, @"netPrice");
    self.rushPurPrice = EncodeStringFromDic(dic, @"rushPurPrice");
    self.isSale = EncodeStringFromDic(dic, @"isSale");
    NSString *shopCode = EncodeStringFromDic(dic, @"shopCode");
    self.shopCode = shopCode?shopCode:@"";

    NSURL *imageUrl = [ProductUtil getImageUrlWithProductCode:self.partNumber size:ProductImageSize200x200];
    self.imageURL = imageUrl;
    
    self.startFlag = EncodeStringFromDic(dic, @"startFlag");
    
    if ([self.startFlag isEqualToString:@"0"]) {
        self.purchaseState = ReadyForSale;
    }
    else if ([self.startFlag isEqualToString:@"1"])
    {
        self.purchaseState = OnSale;
    }
    else
    {
        self.purchaseState = SaleOut;
    }
    
    [self checkState];
    
}

- (void)checkState
{
    if (self.leftQty && [self.leftQty intValue] <= 0) {
        self.purchaseState = SaleOut;
    }
    
    if (self.startTime && self.currentTime && self.endTime)
    {
        
        NSString *dateFormat = @"yyyy-MM-dd HH:mm:ss";
        NSString *dateStartTimeTemp=[self.startTime substringToIndex:19];
        NSString *dateCurrentTimeTemp=[self.currentTime substringToIndex:19];
        NSString *dateEndTimeTemp=[self.endTime substringToIndex:19];
        
        NSDate *dateStartTime = [NSDate dateFromString:dateStartTimeTemp withFormat:dateFormat];
        NSDate *serverTime = [NSDate dateFromString:dateCurrentTimeTemp withFormat:dateFormat];
        NSDate *dateEndTime = [NSDate dateFromString:dateEndTimeTemp withFormat:dateFormat];
        
        self.startTimeSeconds = [dateStartTime timeIntervalSinceDate:serverTime];
        self.endTimeSeconds = [dateEndTime timeIntervalSinceDate:serverTime];
        
        if (self.startTimeSeconds > 0) {
            self.purchaseState = ReadyForSale;
        }else if (self.endTimeSeconds > 0)
        {
            self.purchaseState = OnSale;
            
            if (!self.leftQty || [self.leftQty intValue] <= 0) {
                self.purchaseState = SaleOut;
            }
        }else if(self.endTimeSeconds <= 0){
            self.purchaseState = TimeOver;
        }else{
            self.purchaseState = SaleOut;
        }
    }
}

- (DataProductBasic *)transformToProductDTO
{
    DataProductBasic *productDTO = [[DataProductBasic alloc] init];
    productDTO.productId = self.catentryId;
    productDTO.productName = self.catentryName;
    productDTO.productCode = self.partNumber;
    productDTO.shopCode = self.shopCode;
    return productDTO;
}

- (void)setPurchaseState:(PurchaseState)purchaseState
{
    if (purchaseState_ != purchaseState) {
        
        purchaseState_ = purchaseState;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PanicPurchaseStateDidChangeNotification" object:nil userInfo:@{@"purchaseDTO": self}];
    }
    
}

@end
