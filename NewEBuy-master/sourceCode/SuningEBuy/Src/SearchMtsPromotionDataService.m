//
//  SearchMtsPromotionDataService.m
//  SuningEBuy
//
//  Created by chupeng on 14-7-23.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "SearchMtsPromotionDataService.h"


@implementation SearchMtsPromotionDataService


- (void)dealloc {
    HTTPMSG_RELEASE_SAFELY(mtsPromotionHttpMsg);
}

- (void)beginGetMtsPromotionInfoWithProductID:productid productCode:(NSString *)productCode bigPoloyActivityID:(NSString*)bigActivityID bigPoloyVendor:(NSString *)bigVendor orderInfo:(NSString *)orderinfo;

{
    //拼接url，使用get方式
    //参数是 商品id, 商品编码， channelid，cityid， 终端id, 大聚会活动id, 大聚会渠道id， 大聚会供应商编码
    
    NSString *cityid = [Config currentConfig].defaultCity;
    
    NSString *channelID = [self getChannelID];
    NSString *url = nil;
    
    if (orderinfo.length > 0)
    {
        if ([orderinfo hasSuffix:@"#"])
        {
            orderinfo = [orderinfo substringToIndex:orderinfo.length - 1];
        }
    }
    
    //add by zhangbeibei 0809
    if ([SNSwitch isSearchUseClientChannel]) {
        url = [NSString stringWithFormat:@"%@_%@_%@_%@_%@_%@_%@_%@_%@.html"
                         , kSearchMtsPromotion
                         , productid
                         , productCode
                         , channelID
                         , cityid
                         , @"2"
                         , bigActivityID
                         , @"MOBILE"
                         , bigVendor
                         ];
    }
    else {
        url = [NSString stringWithFormat:@"%@_%@_%@_%@_%@__%@_%@_%@.html"
                         , kSearchMtsPromotion
                         , productid
                         , productCode
                         , channelID
                         , cityid
                         , bigActivityID
                         , @"MOBILE"
                         , bigVendor
                         ];
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (NotNilAndNull(orderinfo))
    {
        [dic setObject:orderinfo forKey:@"orderInfo"];
    }
//    NSString *url = @"http://mpre.cnsuning.com/mts-web/spfs/querySalesShow_000000000104592654_1_9173_2___.html";
    
    HTTPMSG_RELEASE_SAFELY(mtsPromotionHttpMsg);
    
    mtsPromotionHttpMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:url postDataDic:dic cmdCode:CC_SearchMtsPromotion];
    mtsPromotionHttpMsg.requestMethod = RequestMethodGet;
    mtsPromotionHttpMsg.canMultipleConcurrent = YES;
    
    [self.httpMsgCtrl sendHttpMsg:mtsPromotionHttpMsg];
}

- (NSString *)getChannelID
{
    NSString *switchContent = [SNSwitch getsscxkgSwitchContent];
    if (NotNilAndNull(switchContent))
    {
        if ([switchContent isEqualToString:@"1"])
        {
            return @"2";
        }
        else if ([switchContent isEqualToString:@"0"])
        {
            return @"1";
        }
    }
    return @"1";
}

- (void)cancelRequest
{
    [self.httpMsgCtrl cancelHttpRequest:mtsPromotionHttpMsg];
    HTTPMSG_RELEASE_SAFELY(mtsPromotionHttpMsg);
}

#pragma mark - http message delegate

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    if (receiveMsg.cmdCode == CC_SearchMtsPromotion)
    {
        NSDictionary *item = receiveMsg.jasonItems;
        
        if (!item)
        {
            self.errorMsg = kHttpResponseJSONValueFailError;
            [self searchDidFinish:NO];
        }
        else
        {
            NSString *errorCode = receiveMsg.errorCode;
            
            if ([errorCode isEqualToString:@""])
            {
                [self parseItem:item];
            }
            else
            {
                [self searchDidFinish:NO];
            }
        }
    }
}

- (void)searchDidFinish:(BOOL)isSuccess
{
    if (isSuccess)
    {
        if (NotNilAndNull(self.parentDto))
        {
            self.parentDto.minPriceOfPromotion = self.minPriceOfPromotion;
            self.parentDto.flagOfPromotionImgView = self.flagOfPromotionImgView;
            self.parentDto.iSdaJuHui = self.iSdaJuHui;
            [[NSNotificationCenter defaultCenter] postNotificationName:REFRESH_SEARCHLIST object:nil];
        }
    }
}

- (void)parseItem:(NSDictionary *)item
{
    NSString *iSdaJuHui = [item strValue:@"iSdaJuHui"];
    if ([iSdaJuHui isEqualToString:@"TRUE"])
    {
        self.iSdaJuHui = YES;
        [self searchDidFinish:YES];
        return;
    }
    else if ([iSdaJuHui isEqualToString:@"FALSE"])
    {
        self.iSdaJuHui = NO;
    }
    
    NSArray *arr = EncodeArrayFromDic(item, @"activityList");
    if (arr != nil && arr.count > 0)
    {
        float minPrice = 0;
        BOOL firstValue = YES;
        
        for (NSDictionary *dic in arr) {
            SearchPromotionActivityDto *dto = [[SearchPromotionActivityDto alloc] init];
            dto.activityTypeId = EncodeStringFromDic(dic, @"activityTypeId");
            dto.salesPrice = EncodeStringFromDic(dic, @"salesPrice");
            
            if (dto.salesPrice != nil)
            {
                if (firstValue && [dto.salesPrice floatValue] > 0)
                {
                    firstValue = NO;
                    minPrice = [dto.salesPrice floatValue];
                }
                else if ([dto.salesPrice floatValue] < minPrice && [dto.salesPrice floatValue] > 0)
                    minPrice = [dto.salesPrice floatValue];
            }
            
            int typeID = [dto.activityTypeId intValue];
            switch (typeID) {
                case 1:
                {
                    self.flagOfPromotionImgView |= Qiang;
                    break;
                }
                case 2:
                {
                    self.flagOfPromotionImgView |= Tuan;
                    break;
                }
                case 3:
                {
                    self.flagOfPromotionImgView |= Quan;
                    break;
                }
                case 4:
                {
                    self.flagOfPromotionImgView |= Jiang;
                    break;
                }
                case 101:
                {
                    self.flagOfPromotionImgView |= YU;
                }
                default:
                    break;
            }
            
            [self.activityInfoArray addObject:dto];
        }
        
        //最小促销价格
        self.minPriceOfPromotion = [NSString stringWithFormat:@"%0.02f", minPrice];
        
        [self searchDidFinish:YES];
    }
    [self searchDidFinish:NO];
}
@end
