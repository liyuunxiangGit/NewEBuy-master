//
//  EvalutionDTO.m
//  SuningEBuy
//
//  Created by  zhang jian on 13-4-9.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "EvalutionDTO.h"
#import "ProductUtil.h"

@implementation EvalutionDTO
@synthesize orderId = _orderId;
@synthesize orderTime = _orderTime;
@synthesize orderItemList = _orderItemList;


-(void)dealloc
{
    TT_RELEASE_SAFELY(_orderId);
    TT_RELEASE_SAFELY(_orderTime);
    TT_RELEASE_SAFELY(_orderItemList);
    
}

-(void)encodeFromDictionary:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    self.orderId = NotNilAndNull([dic objectForKey:@"orderId"])?[dic objectForKey:@"orderId"]:@"";

    self.orderTime = NotNilAndNull([dic objectForKey:@"orderTime"])?[dic objectForKey:@"orderTime"]:@"";
    
    NSArray *array = EncodeArrayFromDic(dic, @"orderItemList");
    
    NSMutableArray *list = [[NSMutableArray alloc] initWithCapacity:[array count]];
    for (NSDictionary *data in array) {
        
        EvalutionDetailDTO *dto = [[EvalutionDetailDTO alloc] init];
        [dto encodeFromDictionary:data];
        
        [list addObject:dto];
    }
    self.orderItemList = list;
    
}

@end


@implementation EvalutionDetailDTO

@synthesize partNumber = _partNumber;
@synthesize catentryId = _catentryId;
@synthesize catentryName = _catentryName;
@synthesize orderItemId= _orderItemId;
@synthesize supplierName = _supplierName;
@synthesize reviewFlag = _reviewFlag;
@synthesize orderShowFlag = _orderShowFlag;
@synthesize productUrl = _productUrl;

- (void)dealloc{
    TT_RELEASE_SAFELY(_partNumber);
    TT_RELEASE_SAFELY(_catentryId);
    TT_RELEASE_SAFELY(_catentryName);
    TT_RELEASE_SAFELY(_orderItemId);
    TT_RELEASE_SAFELY(_supplierName);
    TT_RELEASE_SAFELY(_reviewFlag);
    TT_RELEASE_SAFELY(_orderShowFlag);
    TT_RELEASE_SAFELY(_productUrl);
}

-(void)encodeFromDictionary:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }

    self.partNumber = NotNilAndNull([dic objectForKey:@"partNumber"])?[dic objectForKey:@"partNumber"]:@"";
    self.catentryId = NotNilAndNull([dic objectForKey:@"catentryId"])?[dic objectForKey:@"catentryId"]:@"";
    self.catentryName = NotNilAndNull([dic objectForKey:@"catentryName"])?[dic objectForKey:@"catentryName"]:@"";
    self.orderItemId = NotNilAndNull([dic objectForKey:@"orderItemId"])?[dic objectForKey:@"orderItemId"]:@"";
    self.supplierName = NotNilAndNull([dic objectForKey:@"supplierName"])?[dic objectForKey:@"supplierName"]:@"";
    self.reviewFlag = NotNilAndNull([dic objectForKey:@"reviewFlag"])?[dic objectForKey:@"reviewFlag"]:@"";
    self.orderShowFlag = NotNilAndNull([dic objectForKey:@"orderShowFlag"])?[dic objectForKey:@"orderShowFlag"]:@"";
    if ([[AppDelegate currentAppDelegate] isHeightQuailtyImg])
    {
        
        self.productUrl = [ProductUtil getImageUrlWithProductCode:self.partNumber size:ProductImageSize160x160];
    }
    else
    {
        
       self.productUrl = [ProductUtil getImageUrlWithProductCode:self.partNumber size:ProductImageSize100x100];
    }
}

@end
