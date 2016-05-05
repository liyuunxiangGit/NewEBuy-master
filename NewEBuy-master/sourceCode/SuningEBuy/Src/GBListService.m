//
//  GBListService.m
//  SuningEBuy
//
//  Created by shasha on 13-2-26.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "GBListService.h"

@implementation GBListService

@synthesize numberFound = _numberFound;
@synthesize flag = _flag;
@synthesize searchResultsList  = _searchResultsList;
@synthesize filtersList = _filtersList;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_numberFound);
    TT_RELEASE_SAFELY(_flag);
    TT_RELEASE_SAFELY(_searchResultsList);
    TT_RELEASE_SAFELY(_filtersList);
    
}

- (void)httpMsgRelease{
    HTTPMSG_RELEASE_SAFELY(__GBListMsg);
}

- (void)beginSendGBListRequest:(GBListPrametersDTO *)dto{
    
    NSMutableDictionary *postDic = [[NSMutableDictionary alloc] init];
    
    if (!IsStrEmpty(dto.cityId)) {
        [postDic setObject:dto.cityId forKey:@"cityId"];
    }
    
    if (!IsStrEmpty(dto.categoryId)) {
        [postDic setObject:dto.categoryId forKey:@"categoryId"];
    }
    
    if (!IsStrEmpty(dto.areaId)) {
        [postDic setObject:dto.areaId forKey:@"areaId"];
    }
    
    if (!IsStrEmpty(dto.indexId)) {
        [postDic setObject:dto.indexId forKey:@"indexId"];
    }
    
    if (!IsStrEmpty(dto.keyWord)) {
        [postDic setObject:dto.keyWord forKey:@"keyWord"];
    }
    
    [postDic setObject:[NSNumber numberWithInt:dto.sortType] forKey:@"sortType"];
    
    [postDic setObject:dto.pageNumber forKey:@"pageNumber"];
    
    [postDic setObject:dto.pageSize forKey:@"pageSize"];
    
    NSString *sendString = [@"" queryStringNoEncodeFromDictionary:postDic];
    
    NSString *encodeStr = [PasswdUtil encryptString:sendString
                                             forKey:@"SuningTG"
                                               salt:@"SuningTG"];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostGroupBuyAddressForHttp, @"getGoodsPageData.htm"];
//    NSString *url = [NSString stringWithFormat:@"%@/%@",@"http://10.22.6.177:8080/hoteltuan-web/groupbuy/mobileclient", @"getGoodsPageData.htm"];
    
    NSDictionary *sendDic =[[NSDictionary alloc] initWithObjectsAndKeys:encodeStr,@"data", nil];
    
    HTTPMSG_RELEASE_SAFELY(__GBListMsg);
    
    __GBListMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:url postDataDic:sendDic cmdCode:CC_GBGoodsList];
    
    TT_RELEASE_SAFELY(sendDic);
    TT_RELEASE_SAFELY(postDic);
    
    [self.httpMsgCtrl sendHttpMsg:__GBListMsg];
}

- (void)receiveDataFinished:(HttpMessage *)recieveMsg Data:(NSDictionary *)dataDic Result:(BOOL)isSuccess{
    
    if (isSuccess) {
        self.numberFound = EncodeStringFromDic(dataDic, @"numberFound");
        self.flag = EncodeStringFromDic(dataDic, @"flag");
        
        NSArray *searchResultsArr = [dataDic objectForKey:@"searchResults"];
        NSArray *noneResultsArr = [dataDic objectForKey:@"noneResults"];
        NSArray *filtersArr = [dataDic objectForKey:@"filters"];
        
        if (!IsArrEmpty(searchResultsArr)) {
            NSMutableArray *tempArr = [[NSMutableArray alloc] init];
            for (NSDictionary *dic in searchResultsArr) {
                GBListGoodsDTO *dto = [[GBListGoodsDTO alloc] init];
                [dto encodeFromDictionary:dic];
                [tempArr addObject:dto];
                TT_RELEASE_SAFELY(dto);
            }
            self.searchResultsList = tempArr;
            TT_RELEASE_SAFELY(tempArr);
        }else{
            if (!IsArrEmpty(noneResultsArr)) {
                NSMutableArray *tempArr = [[NSMutableArray alloc] init];
                for (NSDictionary *dic in noneResultsArr) {
                    GBListGoodsDTO *dto = [[GBListGoodsDTO alloc] init];
                    [dto encodeFromDictionary:dic];
                    [tempArr addObject:dto];
                    TT_RELEASE_SAFELY(dto);
                }
                self.searchResultsList = tempArr;
                TT_RELEASE_SAFELY(tempArr);
            }else{
                self.searchResultsList = nil;
            }
        }
        
        if (!IsArrEmpty(filtersArr)) {
            NSMutableArray *tempArr = [[NSMutableArray alloc] init];
            for (NSDictionary *dic in filtersArr) {
                GBSearchFilterDTO *dto = [[GBSearchFilterDTO alloc] init];
                [dto encodeFromDictionary:dic];
                [tempArr addObject:dto];
                TT_RELEASE_SAFELY(dto);
            }
            self.filtersList = tempArr;
            TT_RELEASE_SAFELY(tempArr);
        }else{
            self.filtersList = nil;
        }
        [self didGetCityListComplete:YES CMDCode:recieveMsg.cmdCode];
        
    }else{
        [self didGetCityListComplete:NO CMDCode:recieveMsg.cmdCode];
    }
}

- (void)didGetCityListComplete:(BOOL)isSuccess CMDCode:(E_CMDCODE)cmdCode{
    if ([self.delegate respondsToSelector:@selector(didSendGBListRequestComplete:Result:)]) {
        [self.delegate didSendGBListRequestComplete:self Result:isSuccess];
    }
}

@end
