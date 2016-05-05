//
//  ReturnGoodsQueryDTO.m
//  SuningEBuy
//
//  Created by jian  zhang on 12-8-8.
//  Copyright (c) 2012年 nanjing. All rights reserved.
//

#import "ReturnGoodsQueryDTO.h"
#import "ReturnGoodsStatusDTO.h"
#import "ProductUtil.h"

@implementation ReturnGoodsQueryDTO

@synthesize productId = _productId;
@synthesize productName = _productName;
@synthesize orderId = _orderId;
@synthesize productCode = _productCode;
@synthesize productImage = _productImage;
@synthesize submitTime = _submitTime;
@synthesize serviceType = _serviceType;
@synthesize detailList = _detailList;
@synthesize orderItemId = _orderItemId;
@synthesize vendorCode = _vendorCode;
@synthesize vendorName = _vendorName;
@synthesize returnGoodsFlag = _returnGoodsFlag;
@synthesize address = _address;
@synthesize telephone = _telephone;
@synthesize receiver = _receiver;
@synthesize reMark = _reMark;

- (void)dealloc {
    
    TT_RELEASE_SAFELY(_detailList);
    TT_RELEASE_SAFELY(_serviceType);
    TT_RELEASE_SAFELY(_submitTime);
    TT_RELEASE_SAFELY(_orderId);
    TT_RELEASE_SAFELY(_productCode);
    TT_RELEASE_SAFELY(_productId);
    TT_RELEASE_SAFELY(_productImage);
    TT_RELEASE_SAFELY(_productName);
    
}

- (void)encodeFromDictionary:(NSDictionary *)dic{
    
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    NSString *__orderId = [dic objectForKey:@"orderId"];
    NSString *__productId = [dic objectForKey:@"productId"];
    NSString *__productCode = [dic objectForKey:@"productCode"];
    
    NSString *__productName = [dic objectForKey:@"productName"];
    NSString *__submitTime = [dic objectForKey:@"submitTime"];
    NSString *__serviceType = [dic objectForKey:@"serviceType"];
    NSArray  *__detailList = [dic objectForKey:@"detailList"];
    NSString  *__orderItemId = [dic objectForKey:@"orderItemId"];
    NSString  *__vendorCode = [dic objectForKey:@"vendorCode"];
    NSString  *__vendorName = [dic objectForKey:@"vendorName"];
    NSString  *__returnGoodsFlag = [dic objectForKey:@"returnGoodsFlag"];
    NSString  *__address = [dic objectForKey:@"address"];
    NSString  *__telephone = [dic objectForKey:@"telephone"];
    NSString  *__receiver = [dic objectForKey:@"receiver"];
    NSString  *__reMark = [dic objectForKey:@"reMark"];
    
    
    if (NotNilAndNull(__orderId) && ![__orderId isEqualToString:@""]) {
        
        self.orderId = __orderId;
    }
    
    if (NotNilAndNull(__productId) && ![__productId isEqualToString:@""]) {
        
        self.productId = __productId;
    }
    
    if (NotNilAndNull(__detailList)) {
        
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in __detailList)
        {
            ReturnGoodsStatusDTO *dto = [[ReturnGoodsStatusDTO alloc] init];
            [dto encodeFromDictionary:dic];
            [array addObject:dto];
        }
        
        self.detailList = array;
    }
    
    if (NotNilAndNull(__productCode)) {
        self.productCode = __productCode;
        
        self.productImage = [ProductUtil getImageUrlWithProductCode:self.productCode size:ProductImageSize60x60];
    }
    
    if (NotNilAndNull(__productName) && ![__productName isEqualToString:@""]) {
        
        self.productName = __productName;
    }
    
    if (NotNilAndNull(__submitTime) && ![__submitTime isEqualToString:@""]) {
        
        self.submitTime = __submitTime;
    }
    
    if (NotNilAndNull(__serviceType) && ![__serviceType isEqualToString:@""]) {
        
        self.serviceType = @"退货";
    }
    
    if (NotNilAndNull(__orderItemId) && ![__orderItemId isEqualToString:@""]) {
        
        self.orderItemId = __orderItemId;
    }
    if (NotNilAndNull(__vendorCode) && ![__vendorCode isEqualToString:@""]) {
        
        self.vendorCode = __vendorCode;
    }
    if (NotNilAndNull(__vendorName) && ![__vendorName isEqualToString:@""]) {
        
        self.vendorName = __vendorName;
    }
    if (NotNilAndNull(__returnGoodsFlag) && ![__returnGoodsFlag isEqualToString:@""]) {
        
        self.returnGoodsFlag = __returnGoodsFlag;
    }
    if (NotNilAndNull(__address) && ![__address isEqualToString:@""]) {
        
        self.address = __address;
    }
    if (NotNilAndNull(__telephone) && ![__telephone isEqualToString:@""]) {
        
        self.telephone = __telephone;
    }
    if (NotNilAndNull(__receiver) && ![__receiver isEqualToString:@""]) {
        
        self.receiver = __receiver;
    }
    if (NotNilAndNull(__reMark) && ![__reMark isEqualToString:@""]) {
        
        self.reMark = __reMark;
    }
    
    
}



@end
