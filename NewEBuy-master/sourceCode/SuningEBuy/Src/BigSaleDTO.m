//
//  BigSaleDTO.m
//  SuningEBuy
//
//  Created by 孔斌 on 14-7-23.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "BigSaleDTO.h"

@implementation BigSaleDTO

-(void)encodeFromDictionary:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    self.grppurId = NotNilAndNull([dic objectForKey:@"grppurId"])?[dic objectForKey:@"grppurId"]:@"";
    self.grppurName = NotNilAndNull([dic objectForKey:@"grppurName"])?[dic objectForKey:@"grppurName"]:@"";
    self.gbCommHot = NotNilAndNull([dic objectForKey:@"gbCommHot"])?[dic objectForKey:@"gbCommHot"]:@"";
    self.dataSrc = NotNilAndNull([dic objectForKey:@"dataSrc"])?[dic objectForKey:@"dataSrc"]:@"";
    self.categCode = NotNilAndNull([dic objectForKey:@"categCode"])?[dic objectForKey:@"categCode"]:@"";
    self.brandCode = NotNilAndNull([dic objectForKey:@"brandCode"])?[dic objectForKey:@"brandCode"]:@"";
    self.vendorCode = NotNilAndNull([dic objectForKey:@"vendorCode"])?[dic objectForKey:@"vendorCode"]:@"";
    self.vendorName = NotNilAndNull([dic objectForKey:@"vendorName"])?[dic objectForKey:@"vendorName"]:@"";
    self.partType = NotNilAndNull([dic objectForKey:@"partType"])?[dic objectForKey:@"partType"]:@"";
    self.partNumber = NotNilAndNull([dic objectForKey:@"partNumber"])?[dic objectForKey:@"partNumber"]:@"";
    self.partName = NotNilAndNull([dic objectForKey:@"partName"])?[dic objectForKey:@"partName"]:@"";
    self.gbCommNum = NotNilAndNull([dic objectForKey:@"gbCommNum"])?[dic objectForKey:@"gbCommNum"]:@"";
    self.limitBuyNum = NotNilAndNull([dic objectForKey:@"limitBuyNum"])?[dic objectForKey:@"limitBuyNum"]:@"";
    self.gbPrice = NotNilAndNull([dic objectForKey:@"gbPrice"])?[dic objectForKey:@"gbPrice"]:@"";
    self.payPrice = NotNilAndNull([dic objectForKey:@"payPrice"])?[dic objectForKey:@"payPrice"]:@"";
    self.previewBegindt = NotNilAndNull([dic objectForKey:@"previewBegindt"])?[dic objectForKey:@"previewBegindt"]:@"";
    self.previewEnddt = NotNilAndNull([dic objectForKey:@"previewEnddt"])?[dic objectForKey:@"previewEnddt"]:@"";
    self.gbBegindate = NotNilAndNull([dic objectForKey:@"gbBegindate"])?[dic objectForKey:@"gbBegindate"]:@"";
    self.gbEnddate = NotNilAndNull([dic objectForKey:@"gbEnddate"])?[dic objectForKey:@"gbEnddate"]:@"";
    self.stauts = NotNilAndNull([dic objectForKey:@"stauts"])?[dic objectForKey:@"stauts"]:@"";
    self.saleNum = NotNilAndNull([dic objectForKey:@"saleNum"])?[dic objectForKey:@"saleNum"]:@"";
    self.curTime = NotNilAndNull([dic objectForKey:@"curTime"])?[dic objectForKey:@"curTime"]:@"";
    
    //子码列表数据
    NSArray  *subInfoArray        = [dic objectForKey:@"subInfoList"];
    if (NotNilAndNull(subInfoArray) && [subInfoArray count] > 0) {
        NSMutableArray *arrays = [[NSMutableArray alloc] initWithCapacity:[subInfoArray count]];
        for (NSDictionary *item in subInfoArray){
            BigSaleDTO *subBigSaleDto = [[BigSaleDTO alloc] init];
            subBigSaleDto.partNumber    = NotNilAndNull([item objectForKey:@"partNumber"]) ? [item objectForKey:@"partNumber"] : @"";
            subBigSaleDto.partName      = NotNilAndNull([item objectForKey:@"partName"]) ? [item objectForKey:@"partName"] : @"";
            subBigSaleDto.gbPrice       = NotNilAndNull([item objectForKey:@"gbPrice"]) ? [item objectForKey:@"gbPrice"] : @"";
            subBigSaleDto.payPrice      = NotNilAndNull([item objectForKey:@"buyPrice"]) ? [item objectForKey:@"buyPrice"] : @"";
            subBigSaleDto.gbCommNum     = NotNilAndNull([item objectForKey:@"gbCommNum"]) ? [item objectForKey:@"gbCommNum"] : @"";
            [arrays addObject:subBigSaleDto];
        }
        self.subInfoList = arrays;
    }
    
    [self checkState];
}

- (void)checkState
{
    if (!IsStrEmpty(self.gbBegindate) && !IsStrEmpty(self.curTime) && !IsStrEmpty(self.gbEnddate))
    {
        NSString *dateFormat = @"yyyy-MM-dd HH:mm:ss";
        NSString *dateStartTimeTemp=[self.gbBegindate substringToIndex:19];
        NSString *dateCurrentTimeTemp=[self.curTime substringToIndex:19];
        NSString *dateEndTimeTemp=[self.gbEnddate substringToIndex:19];
        
        NSDate *dateStartTime = [NSDate dateFromString:dateStartTimeTemp withFormat:dateFormat];
        NSDate *serverTime = [NSDate dateFromString:dateCurrentTimeTemp withFormat:dateFormat];
        NSDate *dateEndTime = [NSDate dateFromString:dateEndTimeTemp withFormat:dateFormat];
        
        self.startTimeSeconds = [dateStartTime timeIntervalSinceDate:serverTime];
        self.endTimeSeconds = [dateEndTime timeIntervalSinceDate:serverTime];
    }
}

-(void)setBigSaleStatus:(NSString *)bigSaleState
{
    if ([bigSaleState isEqualToString:@"1"]) {
        self.bigSaleState = BsReadyForSale;
    }else if ([bigSaleState isEqualToString:@"2"])
    {
        self.bigSaleState = BsOnSale;
    }else if ([bigSaleState isEqualToString:@"3"])
    {
        self.bigSaleState = BsSaleOut;
    }else if ([bigSaleState isEqualToString:@"4"])
    {
        self.bigSaleState = BsTimeOver;
    }
}


@end
