//
//  HomeTopRecommendDTO.m
//  SuningEMall
//
//  Created by Wang Jia on 11-1-9.
//  Copyright 2011 IBM. All rights reserved.
//

#import "HomeTopRecommendDTO.h"


@implementation HomeTopRecommendDTO

@synthesize productCode = _productCode;
@synthesize productId = _productId;
@synthesize productName = _productName;
@synthesize productPrice =  productPrice_;
@synthesize productDesc = productDesc_;

-(void)dealloc{
    
    TT_RELEASE_SAFELY(_productCode);
    TT_RELEASE_SAFELY(_productId);
    TT_RELEASE_SAFELY(_productName);
    TT_RELEASE_SAFELY(productPrice_);
    TT_RELEASE_SAFELY(productDesc_);
}


-(void)encodeFromDictionary:(NSDictionary *)dic{

	if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }

	NSString *code    = [dic objectForKey:kHttpResponseHomeTopProductCode];
	NSString *proId   = [dic objectForKey:kHttpResponseHomeTopProductId];
	NSString *name    = [dic objectForKey:kHttpResponseHomeTopProductName];
    NSString *price   = [dic objectForKey:kHttpResponseHomeTopProductPrice];
    NSString *desc   =  [dic objectForKey:khttpresponseHomeTopPorductDesc];

    if (NotNilAndNull(code)) {
        self.productCode = code;
    }
    if (NotNilAndNull(proId)) {
        self.productId = proId;
    }
    if (NotNilAndNull(name)) {
        self.productName = name;
    }
	if (NotNilAndNull(price)) {
        self.productPrice = price;
    }	
    
    if (NotNilAndNull(desc)) {
        self.productDesc = desc;
    }	

}

//
//"innerProduct":[ {"partNum":"1", "productId":"1185118", "productCode":"102311509", "productImage":"http://image.suning.cn/content/catentries/00000000010231/000000000102311509/fullimage/000000000102311509_1.jpg", "productName":"宾得数码相机RZ18(白)+4G卡+包", "productDesc":"宾得中端卡片机，高性价比", "productPrice":"1549.00000" }

-(void)encodeFromDictionaryByNew:(NSDictionary *)dic{
    
	if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
	NSString *code    = [dic objectForKey:@"productCode"];
	NSString *proId   = [dic objectForKey:@"productId"];
	NSString *name    = [dic objectForKey:@"productName"];
    NSString *price   = [dic objectForKey:@"productPrice"];
    NSString *desc   =  [dic objectForKey:@"productDesc"];
    
    if (NotNilAndNull(code)) {
        self.productCode = code;
    }
    if (NotNilAndNull(proId)) {
        self.productId = proId;
    }
    if (NotNilAndNull(name)) {
        self.productName = name;
    }
	if (NotNilAndNull(price)) {
        self.productPrice = price;
    }	
    
    if (NotNilAndNull(desc)) {
        self.productDesc = desc;
    }	
    
}
- (void)encodeWithCoder:(NSCoder *)coder
{
     [coder encodeObject:self.productCode forKey:@"productCode"];
     [coder encodeObject:self.productId forKey:@"productId"];
     [coder encodeObject:self.productName forKey:@"productName"];
     [coder encodeObject:self.productPrice forKey:@"productPrice"];
    [coder encodeObject:self.productDesc forKey:@"productDesc"];

}

- (id)initWithCoder:(NSCoder *)coder
{
    
    if (self = [super init])
    {
        self.productCode = [coder decodeObjectForKey:@"productCode"];
        self.productId = [coder decodeObjectForKey:@"productId"];
        self.productName = [coder decodeObjectForKey:@"productName"];
        self.productPrice = [coder decodeObjectForKey:@"productPrice"];
        self.productDesc = [coder decodeObjectForKey:@"productDesc"];
    }
    
    return self;
}


@end
