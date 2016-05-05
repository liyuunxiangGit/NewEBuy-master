//
//  InsendTimeDTO.m
//  SuningEBuy
//
//  Created by 孔斌 on 14-11-5.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "InsendTimeDTO.h"

@implementation InsendTimeDTO

- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    self.mergeDataOption    = EncodeStringFromDic(dic, @"mergeDataOption");
    self.mergeDateFlag      = EncodeStringFromDic(dic, @"mergeDateFlag");
//    self.mergeDateFlag      = @"1";
    self.orderId            = EncodeStringFromDic(dic, @"orderId");
    
    NSArray *afterMergeList = EncodeArrayFromDic(dic, @"afterMergeInfo");
    if (afterMergeList !=nil && [afterMergeList count]>0) {
        
        for(NSDictionary *dic in afterMergeList){
            
            MergeDataOptionDTO *dto = [[MergeDataOptionDTO alloc] init];
            
            [dto encodeFromDictionary:dic];
            
            [self.afterMergeInfoList addObject:dto];
        }
    }
    
    NSArray *beforeMergeList = EncodeArrayFromDic(dic, @"beforeMergeInfo");
    if (beforeMergeList !=nil && [beforeMergeList count]>0) {
        
        for(NSDictionary *dic in beforeMergeList){
            
            MergeDataOptionDTO *dto = [[MergeDataOptionDTO alloc] init];
            
            [dto encodeFromDictionary:dic];
            
            [self.beforeMergeInfoList addObject:dto];
        }
    }
    
    if ([self.mergeDataOption isEqualToString:@"beforeMergeInfo"]) {
        self.defaultMergeList = self.beforeMergeInfoList;
        if ([self.mergeDateFlag isEqualToString:@"1"]) {
            self.togetherMergeList = self.beforeMergeInfoList;
            self.splitMergeList = self.afterMergeInfoList;
        }
        else if ([self.mergeDateFlag isEqualToString:@"2"])
        {
            self.splitMergeList = self.beforeMergeInfoList;
            self.togetherMergeList = self.afterMergeInfoList;
        }
    }
    else
    {
        self.defaultMergeList = self.afterMergeInfoList;
        if ([self.mergeDateFlag isEqualToString:@"1"]) {
            self.togetherMergeList = self.afterMergeInfoList;
            self.splitMergeList = self.beforeMergeInfoList;
        }
        else if ([self.mergeDateFlag isEqualToString:@"2"])
        {
            self.splitMergeList = self.afterMergeInfoList;
            self.togetherMergeList = self.beforeMergeInfoList;
        }
    }
    
    if ([self.mergeDateFlag isEqualToString:@"0"]) {
        self.insendTimeType = InsendTimeDefault;
    }
    else if ([self.mergeDateFlag isEqualToString:@"1"])
    {
        self.insendTimeType = InsendTimeTogether;
    }
    else if ([self.mergeDateFlag isEqualToString:@"2"])
    {
        self.insendTimeType = InsendTimeSplit;
    }
}

- (NSMutableArray *)afterMergeInfoList
{
    if (!_afterMergeInfoList) {
        _afterMergeInfoList = [[NSMutableArray alloc] init];
    }
    return _afterMergeInfoList;
}

- (NSMutableArray *)beforeMergeInfoList
{
    if (!_beforeMergeInfoList) {
        _beforeMergeInfoList = [[NSMutableArray alloc] init];
    }
    return _beforeMergeInfoList;
}

@end

@implementation MergeDataOptionDTO

- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }

    self.defDelDate      = EncodeStringFromDic(dic, @"defDelDate");
    self.defDelTime      = EncodeStringFromDic(dic, @"defDelTime");
    self.defDelWeek      = EncodeStringFromDic(dic, @"defDelWeek");
    self.delDateText     = EncodeStringFromDic(dic, @"delDateText");
    
    NSArray *dateList = EncodeArrayFromDic(dic, @"dateVoList");
    if (dateList !=nil && [dateList count]>0) {
        
        for(NSDictionary *dic in dateList){
            
            DateVoDTO *dto = [[DateVoDTO alloc] init];
            
            [dto encodeFromDictionary:dic];
            
            [self.dateVoList addObject:dto];
        }
    }
    
    NSArray *itemsList = EncodeArrayFromDic(dic, @"itemsVoList");
    if (itemsList !=nil && [itemsList count]>0) {
        
        for(NSDictionary *dic in itemsList){
            
            ItemsVoDTO *dto = [[ItemsVoDTO alloc] init];
            
            [dto encodeFromDictionary:dic];
            
            [self.itemsVoList addObject:dto];
        }
    }
    
    self.defDelDateStr = [NSString stringWithFormat:@"%@ %@ %@",self.defDelWeek,self.defDelDate,self.defDelTime];
}

- (NSMutableArray *)dateVoList
{
    if (!_dateVoList) {
        _dateVoList = [[NSMutableArray alloc] init];
    }
    return _dateVoList;
}

- (NSMutableArray *)itemsVoList
{
    if (!_itemsVoList) {
        _itemsVoList = [[NSMutableArray alloc] init];
    }
    return _itemsVoList;
}

@end

@implementation DateVoDTO

- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    self.delDate            = EncodeStringFromDic(dic, @"delDate");
    self.delWeek            = EncodeStringFromDic(dic, @"delWeek");
    NSArray *dateTimeList   = EncodeArrayFromDic(dic, @"delTimeList");
    if (dateTimeList !=nil && [dateTimeList count]>0) {
        
        for(NSDictionary *dic in dateTimeList){
            
            NSString *delTime = EncodeStringFromDic(dic, @"delTime");
            
            [self.delTimeList addObject:delTime];
        }
    }
    
    self.dateStr = [NSString stringWithFormat:@"%@(%@)",self.delDate,self.delWeek];
}

- (NSMutableArray *)delTimeList
{
    if (!_delTimeList) {
        _delTimeList = [[NSMutableArray alloc] init];
    }
    return _delTimeList;
}

@end

@implementation ItemsVoDTO

- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }

    self.orderitemsId       = EncodeStringFromDic(dic, @"orderitemsId");
    self.defInstallDate     = EncodeStringFromDic(dic, @"defInstallDate");
    self.itemPrice          = EncodeStringFromDic(dic, @"itemPrice");
    self.productName        = EncodeStringFromDic(dic, @"productName");
    self.quantity           = EncodeStringFromDic(dic, @"quantity");
    self.partNumber         = EncodeStringFromDic(dic, @"partNumber");
}

- (ShopCartV2DTO *)transformToShopCartV2DTO
{
    ShopCartV2DTO *dto = [[ShopCartV2DTO alloc] init];
    dto.itemPrice = @([self.itemPrice doubleValue]);
    dto.partNumber = self.partNumber;
    dto.quantity = self.quantity;
    dto.productName = self.productName;
    return dto;
}

@end

@implementation InstallDateDTO

- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    self.orderitemsId       = EncodeStringFromDic(dic, @"orderitemsId");
    self.defInstallDate     = EncodeStringFromDic(dic, @"defInstallDate");
}

@end

@implementation insendTimeSubmitDTO


@end
