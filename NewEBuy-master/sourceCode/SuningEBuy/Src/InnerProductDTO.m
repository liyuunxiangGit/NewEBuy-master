//
//  InnerProduct.m
//  SuningEBuy
//
//  Created by wei xie on 12-8-21.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "InnerProductDTO.h"

#define  kHttpResponseInnerBigBang         @"bigBang"
#define  kHttpResponseInnerProductIcon     @"promIcon"
#define  kHttpResponseInnerProductParNum   @"parNum"
#define  kHttpResponseInnerProductId       @"productId"
#define  kHttpResponseInnerProductCode     @"productCode"
#define  kHttpResponseInnerProductName     @"productName"
#define  kHttpResponseInnerProductImageURL @"productImage"
#define  kHttpResponseInnerProductDesc     @"productDesc"
#define  kHttpResponseInnerProductPrice    @"productPrice"


@implementation InnerProductBaseDTO

- (void)encodeFromDictionary:(NSDictionary *)dic{
    
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }

    self.floorName = EncodeStringFromDic(dic, @"floorName");
    self.floorSeq = NotNilAndNull([dic objectForKey:@"floorSeq"])?[dic objectForKey:@"floorSeq"]:@"";
    self.floorPic = NotNilAndNull([dic objectForKey:@"floorPic"])?[dic objectForKey:@"floorPic"]:@"";
    self.floorDesc = NotNilAndNull([dic objectForKey:@"floorDesc"])?[dic objectForKey:@"floorDesc"]:@"";

    NSArray *array = EncodeArrayFromDic(dic, @"innerProduct");
    
    NSMutableArray *list = [[NSMutableArray alloc] initWithCapacity:[array count]];
    for (NSDictionary *data in array) {
        
        InnerProductDTO *dto = [[InnerProductDTO alloc] init];
        [dto encodeFromDictionary:data];
        
        [list addObject:dto];
    }
    self.innerProduct = list;
}

@end

@implementation InnerProductDTO
@synthesize partNum = partNum_;
@synthesize productId = productId_;
@synthesize productCode = productCode_;
@synthesize productName = productName_;
@synthesize productImageURL = productImageURL_;
@synthesize productDesc = productDesc_;
@synthesize productPrice = productPrice_;
@synthesize promIcon = promIcon_;
@synthesize bigBang  = bigBang_;
@synthesize priceImageURL;

- (void)dealloc {
    
    TT_RELEASE_SAFELY(partNum_);
    TT_RELEASE_SAFELY(productId_);
    TT_RELEASE_SAFELY(productCode_);
    TT_RELEASE_SAFELY(productName_);
    TT_RELEASE_SAFELY(productImageURL_);
    TT_RELEASE_SAFELY(productDesc_);
    TT_RELEASE_SAFELY(productPrice_);
    TT_RELEASE_SAFELY(bigBang_);
    TT_RELEASE_SAFELY(promIcon_);
    
}

- (void)encodeFromDictionary:(NSDictionary *)dic{
    
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    NSString *aBigBang = [dic objectForKey:kHttpResponseInnerBigBang];
    NSString *aIcon = [dic objectForKey:kHttpResponseInnerProductIcon];
	NSString *aPartNum  = [dic objectForKey:kHttpResponseInnerProductParNum];
	NSString *aProductId    = [dic objectForKey:kHttpResponseInnerProductId];
	NSString *aProductCode   = [dic objectForKey:kHttpResponseInnerProductCode];
	NSString *aProductImageURL   = [dic objectForKey:kHttpResponseInnerProductImageURL];
	NSString *aProductPrice   = [dic objectForKey:kHttpResponseInnerProductPrice];
    NSString *aProductName    = [dic objectForKey:kHttpResponseInnerProductName];
    NSString *aProductDesc    = [dic objectForKey:kHttpResponseInnerProductDesc];
  
    if(NotNilAndNull(aBigBang)){
		self.bigBang = aBigBang;
	}
    if(NotNilAndNull(aIcon)){
		self.promIcon = aIcon;
	}
	if(NotNilAndNull(aPartNum)){
		self.partNum = aPartNum;
	}			
	if (NotNilAndNull(aProductId)) {
		self.productId = aProductId;
	}
    if (NotNilAndNull(aProductCode)) {
		self.productCode = aProductCode;
	}
    if (NotNilAndNull(aProductImageURL)) {
		self.productImageURL = aProductImageURL;
	}
    if (NotNilAndNull(aProductPrice)) {
		self.productPrice = aProductPrice;
	}
    if (NotNilAndNull(aProductName)) {
		self.productName = aProductName;
	}
    if (NotNilAndNull(aProductDesc)) {
		self.productDesc = aProductDesc;
	}
    self.vendorCode = EncodeStringFromDic(dic, @"vendorCode");
}

- (DataProductBasic *)transformToProductDTO
{
    DataProductBasic *dto = [[DataProductBasic alloc] init];
    dto.productId = self.productId;
    dto.productCode = self.productCode;
    dto.shopCode = self.vendorCode;
    return dto;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.bigBang forKey:@"bigBang"];
    [coder encodeObject:self.promIcon forKey:@"promIcon"];
    [coder encodeObject:self.partNum forKey:@"partNum"];
    [coder encodeObject:self.productId forKey:@"productId"];
    [coder encodeObject:self.productCode forKey:@"productCode"];
    [coder encodeObject:self.productImageURL forKey:@"productImageURL"];
    [coder encodeObject:self.productName forKey:@"productName"]; 
    [coder encodeObject:self.productDesc forKey:@"productDesc"]; 
    [coder encodeObject:self.productPrice forKey:@"productPrice"];
    [coder encodeObject:self.vendorCode forKey:@"vendorCode"];

}

- (id)initWithCoder:(NSCoder *)coder
{
    if (self = [super init])
    {
        self.bigBang = [coder decodeObjectForKey:@"bigBang"];
        self.promIcon = [coder decodeObjectForKey:@"promIcon"];
        self.partNum = [coder decodeObjectForKey:@"partNum"];
        self.productId = [coder decodeObjectForKey:@"productId"];
        self.productCode = [coder decodeObjectForKey:@"productCode"];
        self.productImageURL = [coder decodeObjectForKey:@"productImageURL"];
        self.productName = [coder decodeObjectForKey:@"productName"];
        self.productDesc = [coder decodeObjectForKey:@"productDesc"];
        self.productPrice = [coder decodeObjectForKey:@"productPrice"];
        self.vendorCode = [coder decodeObjectForKey:@"vendorCode"];

    }
    
    return self;
}

@end



@implementation NewInnerProductDTO


- (DataProductBasic *)transformToProductDTO
{
    DataProductBasic *dto = [[DataProductBasic alloc] init];
    dto.productId = self.sugGoodsId;
    dto.productCode = self.sugGoodsCode;
    dto.shopCode = self.vendorId;
    return dto;
}

- (void)encodeFromDictionary:(NSDictionary *)dic
{
    NSString *sugGoodsId = [dic objectForKey:@"sugGoodsId"];
    NSString *sugGoodsCode = [dic objectForKey:@"sugGoodsCode"];
    NSString *sugGoodsName = [dic objectForKey:@"sugGoodsName"];
    NSString *sugGoodsDes = [dic objectForKey:@"sugGoodsDes"];
    NSString *promotionInfo = [dic objectForKey:@"promotionInfo"];
    NSString *vendorId = [dic objectForKey:@"vendorId"];
    NSString *price = [dic objectForKey:@"price"];
    NSString *persent = [dic objectForKey:@"persent"];
    NSString *handwork = [dic objectForKey:@"handwork"];
    
    if (NotNilAndNull(sugGoodsId))
    {
        self.sugGoodsId = sugGoodsId;
    }
    
    if (NotNilAndNull(sugGoodsCode))
    {
        self.sugGoodsCode = sugGoodsCode;
    }
    
    if (NotNilAndNull(sugGoodsName))
    {
        self.sugGoodsName = sugGoodsName;
    }
    
    if (NotNilAndNull(sugGoodsDes))
    {
        self.sugGoodsDes = sugGoodsDes;
    }
    
    if (NotNilAndNull(promotionInfo))
    {
        self.promotionInfo = promotionInfo;
    }
    
    if (NotNilAndNull(vendorId))
    {
        self.vendorId = vendorId;
    }
    
    if (NotNilAndNull(price))
    {
        self.price = price;
    }
    
    if (NotNilAndNull(persent))
    {
        self.persent = persent;
    }
    
    if (NotNilAndNull(handwork))
    {
        self.handwork = handwork;
    }
}

@end
