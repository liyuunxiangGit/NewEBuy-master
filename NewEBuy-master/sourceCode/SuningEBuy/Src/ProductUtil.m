//
//  ProductUtil.m
//  SuningEBuy
//
//  Created by  on 12-10-16.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "ProductUtil.h"

@implementation ProductUtil

#pragma mark -
#pragma mark 类方法

+ (NSURL *)imageUrl_ls_ForProduct:(NSString *)productCode
{
    if (productCode == nil || [productCode isEmptyOrWhitespace]) {
        return nil;
    }
    
    NSString *codeString = nil;    
    if ([productCode length] < 18){
        codeString = [NSString stringWithFormat:@"%018lld", [productCode longLongValue]];        
    }else{
        codeString = productCode;
    }
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@/%@/%@_ls.jpg",
                        kImageAddressForHttp, 
                        [codeString substringToIndex:14], 
                        codeString, 
                        codeString];
    NSURL *url = [NSURL URLWithString:urlStr];
    return url;
}

+ (NSURL *)imageUrl_ls1_ForProduct:(NSString *)productCode
{
    if (productCode == nil || [productCode isEmptyOrWhitespace]) {
        return nil;
    }
    
    NSString *codeString = nil;    
    if ([productCode length] < 18){
        codeString = [NSString stringWithFormat:@"%018lld", [productCode longLongValue]];        
    }else{
        codeString = productCode;
    }
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@/%@/%@_ls1.jpg",
                        kImageAddressForHttp, 
                        [codeString substringToIndex:14], 
                        codeString, 
                        codeString];
    NSURL *url = [NSURL URLWithString:urlStr];
    return url;
}


//加载小图
+ (NSArray *)getSmallImageUrlList:(DataProductBasic *)item
{
    if (item == nil) {
        return nil;
    }
    /*设置默认图片最少0*/
    int productCount = 1;
    
    if (item.imageNum && ![item.imageNum isEqualToString:@""] && [item.imageNum intValue] > 0)
    {
        productCount = [item.imageNum intValue];
    }
    
    // 创建数组，保存图片url
    NSMutableArray *temArr = [[NSMutableArray alloc] initWithCapacity:productCount];
    
    NSURL *url = [NSURL URLWithString:kImageAddressForHttp];
    
    NSString *codeString;
    
    if ([item.productCode length] < 18){
        codeString = [NSString stringWithFormat:@"%018lld", [item.productCode longLongValue]];        
    }else{
        codeString = item.productCode;
    }
    
    for (int i = 1;i<= productCount;i++) {
        NSString *str =  [NSString stringWithFormat:@"%@/%@/fullimage/%@_%d.jpg",
                          [codeString substringToIndex:14], 
                          codeString, 
                          codeString,
                          i];
        
        NSURL *temSmallImage = [url URLByAppendingPathComponent:str];
        [temArr addObject:temSmallImage];
    }
    
    return temArr;
}

+ (NSURL *)getFirstSmallImageUrl:(NSString *)productCode
{
    if (productCode == nil || [productCode isEmptyOrWhitespace]) {
        return nil;
    }
    
    NSString *codeString;
    
    if ([productCode length] < 18){
        codeString = [NSString stringWithFormat:@"%018lld",[productCode longLongValue]];        
    }else{
        codeString = productCode;
    }
    
    NSString *str =  [NSString stringWithFormat:@"%@/%@/%@/fullimage/%@_1.jpg",
                      kImageAddressForHttp,
                      [codeString substringToIndex:14],
                      codeString,
                      codeString];
    
    NSURL *url = [NSURL URLWithString:str];
    return url;
}

// 加载大图
+ (NSArray *)getBigImageUrlList:(DataProductBasic *)item
{
    if (item == nil) {
        return nil;
    }
    /*设置默认图片最少0*/
    int productCount = 1;
    
    if (item.imageNum && ![item.imageNum isEqualToString:@""] && [item.imageNum intValue] > 0)
    {
        productCount = [item.imageNum intValue];
    }
    
    // 创建数组，保存图片url
    NSMutableArray *temArr = [[NSMutableArray alloc] initWithCapacity:productCount];
    
    NSURL *url = [NSURL URLWithString:kImageAddressForHttp];
    
    NSString *code;
    
    if([item.productCode length] < 18){
        code = [NSString stringWithFormat:@"%018lld", [item.productCode longLongValue]];        
    }else{
        code = item.productCode;
    }
    
    if (item.isABook)   //图书情况
    {
        for (int i = 1;i<= productCount;i++) {
            NSString *str =  [NSString stringWithFormat:@"%@/%@/fullimage/%@_%d.jpg",
                              [code substringToIndex:14], 
                              code, 
                              code,
                              i];
            
            NSURL *temSmallImage = [url URLByAppendingPathComponent:str];
            [temArr addObject:temSmallImage];
        }
    }
    else                //电器情况
    {
        for (int i = 1;i<= productCount;i++) {
            NSString *str =  [NSString stringWithFormat:@"%@/%@/fullimage/%@_%df.jpg",
                              [code substringToIndex:14],
                              code,
                              code,
                              i];
            
            NSURL *temSmallImage = [url URLByAppendingPathComponent:str];
            [temArr addObject:temSmallImage];
        }
        
    }
    
    return temArr;
}

+ (NSURL *)getImageUrl_fullimage_1:(NSString *)productCode{
    
    if (productCode == nil || [productCode isEmptyOrWhitespace]) {
        return nil;
    }
    
    NSString *codeString;
    
    if ([productCode length] < 18){
        codeString = [NSString stringWithFormat:@"%018lld",[productCode longLongValue]];        
    }else{
        codeString = productCode;
    }
    
    NSString *str =  [NSString stringWithFormat:@"%@/%@/%@/fullimage/%@_1.jpg",
                      kImageAddressForHttp,
                      [codeString substringToIndex:14],
                      codeString,
                      codeString];
    
    NSURL *url = [NSURL URLWithString:str];
    return url;
}

+ (NSURL *)getImageUrl_fullimage_1f:(NSString *)productCode{
    
    if (productCode == nil || [productCode isEmptyOrWhitespace]) {
        return nil;
    }
    
    NSString *codeString;
    
    if ([productCode length] < 18){
        codeString = [NSString stringWithFormat:@"%018lld",[productCode longLongValue]];        
    }else{
        codeString = productCode;
    }
    
    NSString *str =  [NSString stringWithFormat:@"%@/%@/%@/fullimage/%@_1f.jpg",
                      kImageAddressForHttp,
                      [codeString substringToIndex:14],
                      codeString,
                      codeString];
    
    NSURL *url = [NSURL URLWithString:str];
    return url;
}

+ (NSURL *)getImageUrl_tn:(NSString *)productCode{
    if (productCode == nil || [productCode isEmptyOrWhitespace]) {
        return nil;
    }
    
    NSString *codeString;
    
    if ([productCode length] < 18){
        codeString = [NSString stringWithFormat:@"%018lld",[productCode longLongValue]];        
    }else{
        codeString = productCode;
    }
    
    NSString *str =  [NSString stringWithFormat:@"%@/%@/%@/%@_tn.jpg",
                      kImageAddressForHttp,
                      [codeString substringToIndex:14],
                      codeString,
                      codeString];
    
    NSURL *url = [NSURL URLWithString:str];
    return url;
}

+ (NSURL *)getImageUrl_ls:(NSString *)productCode{
    
    if (productCode == nil || [productCode isEmptyOrWhitespace]) {
        return nil;
    }
    
    NSString *codeString;
    
    if ([productCode length] < 18){
        codeString = [NSString stringWithFormat:@"%018lld",[productCode longLongValue]];        
    }else{
        codeString = productCode;
    }
    
    NSString *str =  [NSString stringWithFormat:@"%@/%@/%@/%@_ls.jpg",
                      kImageAddressForHttp,
                      [codeString substringToIndex:14],
                      codeString,
                      codeString];
    
    NSURL *url = [NSURL URLWithString:str];
    return url;
}

+ (NSURL *)getImageUrl_ls1:(NSString *)productCode{
    if (productCode == nil || [productCode isEmptyOrWhitespace]) {
        return nil;
    }
    
    NSString *codeString;
    
    if ([productCode length] < 18){
        codeString = [NSString stringWithFormat:@"%018lld",[productCode longLongValue]];        
    }else{
        codeString = productCode;
    }
    
    NSString *str =  [NSString stringWithFormat:@"%@/%@/%@/%@_ls1.jpg",
                      kImageAddressForHttp,
                      [codeString substringToIndex:14],
                      codeString,
                      codeString];
    
    NSURL *url = [NSURL URLWithString:str];
    return url;
}

+ (NSURL *)getImageUrl_fullimage_2:(NSString *)productCode{
    if (productCode == nil || [productCode isEmptyOrWhitespace]) {
        return nil;
    }
    
    NSString *codeString;
    
    if ([productCode length] < 18){
        codeString = [NSString stringWithFormat:@"%018lld",[productCode longLongValue]];        
    }else{
        codeString = productCode;
    }
    
    NSString *str =  [NSString stringWithFormat:@"%@/%@/%@/fullimage/%@_2.jpg",
                      kImageAddressForHttp,
                      [codeString substringToIndex:14],
                      codeString,
                      codeString];
    
    NSURL *url = [NSURL URLWithString:str];
    return url;
}

+ (NSURL *)getImageUrl_fullimage_2f:(NSString *)productCode{
    if (productCode == nil || [productCode isEmptyOrWhitespace]) {
        return nil;
    }
    
    NSString *codeString;
    
    if ([productCode length] < 18){
        codeString = [NSString stringWithFormat:@"%018lld",[productCode longLongValue]];        
    }else{
        codeString = productCode;
    }
    
    NSString *str =  [NSString stringWithFormat:@"%@/%@/%@/fullimage/%@_2f.jpg",
                      kImageAddressForHttp,
                      [codeString substringToIndex:14],
                      codeString,
                      codeString];
    
    NSURL *url = [NSURL URLWithString:str];
    return url;
}


+ (NSURL *)getImageUrlWithProductCode:(NSString *)productCode size:(ProductImageSize)size
{
    if (productCode.trim.length == 0) {
        return nil;
    }
    
    NSString *codeString;
    
    if ([productCode length] < 18){
        codeString = [NSString stringWithFormat:@"%018lld",[productCode longLongValue]];
    }else{
        codeString = productCode;
    }
    
    NSString *str =  [NSString stringWithFormat:@"%@/%@_1_%dx%d.jpg",
                      kImageServerHost,
                      codeString,
                      size,
                      size];
    
    NSURL *url = [NSURL URLWithString:str];
    return url;
}



+ (NSArray *)getImageUrlListWithProduct:(DataProductBasic *)item size:(ProductImageSize)size
{
    if (item == nil) {
        return nil;
    }
    /*设置默认图片最少0*/
    int productCount = 1;
    
    if (item.imageNum && ![item.imageNum isEqualToString:@""] && [item.imageNum intValue] > 0)
    {
        productCount = [item.imageNum intValue];
    }
    
    // 创建数组，保存图片url
    NSMutableArray *temArr = [[NSMutableArray alloc] initWithCapacity:productCount];
        
    NSString *codeString;
    
    if ([item.productCode length] < 18){
        codeString = [NSString stringWithFormat:@"%018lld", [item.productCode longLongValue]];
    }else{
        codeString = item.productCode;
    }
    
    for (int i = 1;i<= productCount;i++) {
        if (i>8) {
            break;
        }
        NSString *str =  [NSString stringWithFormat:@"%@/%@_%d_%dx%d.jpg",
                          kImageServerHost,
                          codeString,
                          i,
                          size,
                          size];
        
        NSURL *url = [NSURL URLWithString:str];
        [temArr addObject:url];
    }
    
    
    
    return temArr;
}

+ (NSURL *)priceImageUrlOfProductId:(NSString *)proId city:(NSString *)cityId
{
    if (proId.length == 0 || cityId.length == 0) {
        return nil;
    }
    
    NSString *url = [NSString stringWithFormat:@"%@/%@_%@_10052_10-3.png",
                     kPriceServerHost,
                     proId,
                     cityId];
    
    return [NSURL URLWithString:url];
}

#pragma mark - 通码价格图片
//
//{9位商品编码}_{城市id}_20000__clientType_{样式类型}.png
//示例：http://preprice1.suning.cn/webapp/wcs/stores/prdprice/109041325_9173_20000__clientType_9-1.png
//http://price1.suning.cn/webapp/wcs/stores/prdprice
//通码到指定商家价格图片(client： pc=1、mobile=2、wap=3)
//client  填写数字 1  2  3形式
+ (NSURL *)getPriceImageUrlWithPartNumber:(NSString *)partnumber city:(NSString *)cityId;
{
    if (partnumber.length == 0 || cityId.length == 0) {
        return nil;
    }
    
    NSString *url = [NSString stringWithFormat:@"%@/%@_%@_20000_2_9-1.png",
                     kPriceServerHost,
                     partnumber,
                     cityId];
    
    return [NSURL URLWithString:url];
}

+ (NSURL *)minPriceImageOfPartNumber:(NSString *)partnumber city:(NSString *)cityId
{
    if (partnumber.length == 0 || cityId.length == 0) {
        return nil;
    }
    
    NSString *url = [NSString stringWithFormat:@"%@/%@_%@_20002_9-1.png",
                     kPriceServerHost,
                     partnumber,
                     cityId];
    
    return [NSURL URLWithString:url];
}
#pragma mark -
+ (NSURL *)supplierNumImageOfProductId:(NSString *)proId city:(NSString *)cityId
{
    if (proId.length == 0 || cityId.length == 0) {
        return nil;
    }
    
    NSString *url = [NSString stringWithFormat:@"%@/%@_%@_10001_1.png",
                     kPriceServerHost,
                     proId,
                     cityId];
    
    return [NSURL URLWithString:url];
}

+ (NSURL *)minPriceImageOfProductId:(NSString *)proId city:(NSString *)cityId
{
    if (proId.length == 0 || cityId.length == 0) {
        return nil;
    }
    
    NSString *url = [NSString stringWithFormat:@"%@/%@_%@_10002_10-3.png",
                     kPriceServerHost,
                     proId,
                     cityId];
    
    return [NSURL URLWithString:url];
}


+ (NSURL *)minPriceImageOfProductId:(NSString *)proId productCode:(NSString *)proCode city:(NSString *)cityId shopCode:(NSString *)shopCode
{
    if (proId.length == 0 || cityId.length == 0) {
        return nil;
    }
    
    NSString *url = nil;
    if (IsStrEmpty(shopCode)) {
        //最优商家
        url = [NSString stringWithFormat:@"%@/%@_%@_10000_10-3.png",
                         kPriceServerHost,
                         proId,
                         cityId];
    }
    else if ([shopCode isEqualToString:@"0000000000"]) {
        //苏宁自营价格
        url = [NSString stringWithFormat:@"%@/%@_%@_10052_10-3.png",
               kPriceServerHost,
               proId,
               cityId];
    }
    else {
        //取9位的商品编码
        url = [NSString stringWithFormat:@"%@/%@_%@_%@_10-3.png",
               kPriceServerHost,
               proCode,
               cityId,
               shopCode];
    }
    return [NSURL URLWithString:url];
}




+ (NSURL *)bestPriceImageOfProductId:(NSString *)proId city:(NSString *)cityId
{
    
    if (proId.length == 0 || cityId.length == 0) {
        return nil;
    }
    
    NSString *url = [NSString stringWithFormat:@"%@/%@_%@_10000_10-3.png",
                     kPriceServerHost,
                     proId,
                     cityId];
    
    return [NSURL URLWithString:url];
}

+ (NSURL *)mobileWebSuningUrlWithProduct:(DataProductBasic *)product
{
    NSAssert([product isKindOfClass:[DataProductBasic class]], @"DataProductBasic type error");
    if (product.productId.length)
    {
        NSString *str =
        [NSString stringWithFormat:@"http://m.suning.com/emall/snmwprd_10052_%@_%@_.html",
         product.isABook ? @"22001" : @"10051",
         product.productId];
        
        return [NSURL URLWithString:str];
    }
    else
    {
        return nil;
    }
}

@end
