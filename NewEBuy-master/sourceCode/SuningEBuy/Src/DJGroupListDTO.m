//
//  DJGroupListDTO.m
//  SuningEBuy
//
//  Created by xie wei on 13-7-8.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "DJGroupListDTO.h"
#import "DJGroupListItemDTO.h"

@implementation DJGroupListDTO

@synthesize curPage = _curPage;
@synthesize rowsPerPage = _rowsPerPage;
@synthesize maxRowCount = _maxRowCount;
@synthesize maxPage = _maxPage;
@synthesize groupBuyList = _groupBuyList;

- (void)dealloc
{
    
}

- (void)encodeFromDictionary:(NSDictionary *)dic{
    
    if (dic == nil) {
        return;
    }
    
    self.curPage = EncodeStringFromDic(dic, @"curPage");
    self.rowsPerPage = EncodeStringFromDic(dic, @"rowsPerPage");
    self.maxRowCount = EncodeStringFromDic(dic, @"maxRowCount");
    self.maxPage = EncodeStringFromDic(dic, @"maxPage");
    
    NSArray *groupBuyList = nil;
    if ([[dic objectForKey:@"groupBuyList"] isKindOfClass:[NSArray class]]) {
        groupBuyList = [dic objectForKey:@"groupBuyList"];
    }
    
    if (IsArrEmpty(groupBuyList)) {
        self.groupBuyList = nil;
    }else{
        NSMutableArray *tempArr = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in groupBuyList) {
            DJGroupListItemDTO *dto = [[DJGroupListItemDTO alloc] init];
            [self encodeGroupBuyListInfo:dic ToGroupListDto:dto];
            [tempArr addObject:dto];
            TT_RELEASE_SAFELY(dto);
        }
        self.groupBuyList = tempArr;
        TT_RELEASE_SAFELY(tempArr);
    }
}

- (void)encodeGroupBuyListInfo:(NSDictionary *)dic ToGroupListDto:(DJGroupListItemDTO *)dto
{
    dto.grpPurId = EncodeStringFromDic(dic, @"grpPurId");
    dto.warmupTime = EncodeStringFromDic(dic, @"warmupTime");
    dto.startTime = EncodeStringFromDic(dic, @"startTime");
    dto.endTime = EncodeStringFromDic(dic, @"endTime");
    dto.currentTime = EncodeStringFromDic(dic, @"currentTime");
    
    dto.partnumber = EncodeStringFromDic(dic, @"partnumber");
    dto.catentryId = EncodeStringFromDic(dic, @"catentryId");
    dto.productName = EncodeStringFromDic(dic, @"productName");
    dto.displayPrice = EncodeStringFromDic(dic, @"displayPrice");
    
    dto.totalQty = EncodeStringFromDic(dic, @"totalQty");
    
    dto.netPrice = EncodeStringFromDic(dic, @"netPrice");
    dto.percentage = EncodeStringFromDic(dic, @"percentage");
    dto.adjustAmount = EncodeStringFromDic(dic, @"adjustAmount");
    dto.startFlag = EncodeStringFromDic(dic, @"startFlag");
    
    [self checkState:dto];
}

- (void)checkState:(DJGroupListItemDTO *)dto
{
    if (dto.startTime && dto.currentTime && dto.endTime)
    {
        NSString *dateFormat = @"yyyy-MM-dd HH:mm:ss";
        NSString *dateStartTimeTemp=[dto.startTime substringToIndex:19];
        NSString *dateCurrentTimeTemp=[dto.currentTime substringToIndex:19];
        NSString *dateEndTimeTemp=[dto.endTime substringToIndex:19];
        
        NSDate *dateStartTime = [NSDate dateFromString:dateStartTimeTemp withFormat:dateFormat];
        NSDate *serverTime = [NSDate dateFromString:dateCurrentTimeTemp withFormat:dateFormat];
        NSDate *dateEndTime = [NSDate dateFromString:dateEndTimeTemp withFormat:dateFormat];
        
        dto.startTimeSeconds = [dateStartTime timeIntervalSinceDate:serverTime];
        dto.endTimeSeconds = [dateEndTime timeIntervalSinceDate:serverTime];
    }
}

@end
