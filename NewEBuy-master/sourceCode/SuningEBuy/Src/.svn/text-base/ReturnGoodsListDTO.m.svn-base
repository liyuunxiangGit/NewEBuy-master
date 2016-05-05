//
//  ReturnGoodsListDTO.m
//  SuningEBuy
//
//  Created by jian  zhang on 12-8-7.
//  Copyright (c) 2012年 nanjing. All rights reserved.
//

#import "ReturnGoodsListDTO.h"
#import "ProductUtil.h"

@implementation ReturnGoodsListDTO

@synthesize orderId = _orderId;
@synthesize orderItemsId = _orderItemsId;
@synthesize productId = _productId;
@synthesize partNumber = _partNumber;
@synthesize productName = _productName;

@synthesize orderTime = _orderTime;
@synthesize salNum = _salNum;
@synthesize deliveryStatus = _deliveryStatus;
@synthesize memberCardNo = _memberCardNo;
@synthesize channel = _channel;

@synthesize posId = _posId;
@synthesize saleHall  = _saleHall;
@synthesize productImage = _productImage;



- (void)dealloc {
    
    TT_RELEASE_SAFELY(_orderId);
    TT_RELEASE_SAFELY(_orderItemsId);
    TT_RELEASE_SAFELY(_productId);
    TT_RELEASE_SAFELY(_partNumber);
    TT_RELEASE_SAFELY(_productName);
    
    TT_RELEASE_SAFELY(_orderTime);
    TT_RELEASE_SAFELY(_salNum);
    TT_RELEASE_SAFELY(_deliveryStatus);
    TT_RELEASE_SAFELY(_memberCardNo);
    TT_RELEASE_SAFELY(_channel);
    
    TT_RELEASE_SAFELY(_posId);
    TT_RELEASE_SAFELY(_saleHall);
    TT_RELEASE_SAFELY(_productImage);
    
}


-(void)encodeFromDictionary:(NSDictionary *)dic{
    
	if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }

    NSString *__orderId = [dic objectForKey:@"orderId"];
    NSString *__orderItemsId = [dic objectForKey:@"orderItemsId"];
    NSString *__productId = [dic objectForKey:@"productId"];
    NSString *__partNumber = [dic objectForKey:@"partNumber"];
    NSString *__productName = [dic objectForKey:@"productName"];
    
    NSString *__orderTime = [dic objectForKey:@"orderTime"];
    NSString *__salNum = [dic objectForKey:@"salNum"];
    NSString *__deliveryStatus = [dic objectForKey:@"deliveryStatus"];
    NSString *__memberCardNo = [dic objectForKey:@"memberCardNo"];
    NSString *__channel = [dic objectForKey:@"channel"];
    
    NSString *__posId = [dic objectForKey:@"posId"];    
    NSString *__saleHall = [dic objectForKey:@"saleHall"];
    NSString *__cshopFlag = [dic objectForKey:@"cshopFlag"];
    
    NSString *__vendorCode = [dic objectForKey:@"vendorCode"];
    NSString *__vendorName = [dic objectForKey:@"vendorName"];
    
    if (NotNilAndNull(__vendorCode) && ![__vendorCode isEqualToString:@""]) {
        
        self.vendorCode = __vendorCode;
        
    }
    if (NotNilAndNull(__vendorName) && ![__vendorName isEqualToString:@""]) {
        
        self.vendorName = __vendorName;
        
    }
    
    if (NotNilAndNull(__orderId) && ![__orderId isEqualToString:@""]) {
        
        self.orderId = __orderId;
        
    }
    
    if (NotNilAndNull(__orderItemsId) && ![__orderItemsId isEqualToString:@""]) {
        
        self.orderItemsId = __orderItemsId;
        
    }
    if (NotNilAndNull(__productId) && ![__productId isEqualToString:@""]) {
        
        self.productId = __productId;
        
    }
    
    if (NotNilAndNull(__partNumber) && ![__partNumber isEqualToString:@""]) {
        
        self.partNumber = __partNumber;
        
        self.productImage = [ProductUtil getImageUrlWithProductCode:self.partNumber size:ProductImageSize60x60];
    
    }
        
    if (NotNilAndNull(__productName) && ![__productName isEqualToString:@""]) {
        
        self.productName = __productName;
        
    }
    if (NotNilAndNull(__orderTime) && ![__orderTime isEqualToString:@""]) {
        
        self.orderTime = __orderTime;
        
    }
    if (NotNilAndNull(__salNum) && ![__salNum isEqualToString:@""]) {
        
        self.salNum = __salNum;
        
    }
    if (NotNilAndNull(__deliveryStatus) && ![__deliveryStatus isEqualToString:@""]) {
        
        self.deliveryStatus = __deliveryStatus;
        
    }
    if (NotNilAndNull(__memberCardNo) && ![__memberCardNo isEqualToString:@""]) {
        
        self.memberCardNo = __memberCardNo;
        
    }
    if (NotNilAndNull(__channel) && ![__channel isEqualToString:@""]) {
        
        self.channel = __channel;
        
    }
    if (NotNilAndNull(__posId) && ![__posId isEqualToString:@""]) {
        
        self.posId = __posId;
        
    }
    if (NotNilAndNull(__saleHall) && ![__saleHall isEqualToString:@""]) {
        
        self.saleHall = __saleHall;
        
    }
    if (NotNilAndNull(__cshopFlag) && ![__cshopFlag isEqualToString:@""]) {
        
        self.cshopFlag = __cshopFlag;
        
    }
    
    
    
}   


@end
