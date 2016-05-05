//
//  GBSearchService.m
//  SuningEBuy
//
//  Created by  liukun on 13-3-4.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "GBSearchService.h"
#import "GBSearchListGoodsDTO.h"

@implementation GBSearchService

@synthesize goodsList = _goodsList;
@synthesize pageCount = _pageCount;

@synthesize delegate = _delegate;
@synthesize isHasResult = _isHasResult;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_goodsList);
    TT_RELEASE_SAFELY(_pageCount);
    
}

- (void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(gbSearchHttpMsg);
}

#pragma mark -
#pragma mark service life

- (void)beginGBSearchWithKeyword:(NSString *)keyword
                          cityId:(NSString *)cityId
                      searchType:(GBSearchType)type
                            page:(NSInteger)page
{
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] initWithCapacity:5];
    [postDataDic setObject:POST_VALUE(cityId) forKey:@"cityId"];
    [postDataDic setObject:POST_VALUE(keyword) forKey:@"keyWord"];
    [postDataDic setObject:__INT(type) forKey:@"searchType"];
    [postDataDic setObject:__INT(page) forKey:@"pageNumber"];
    [postDataDic setObject:__INT(10) forKey:@"pageSize"];

    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostGroupBuyAddressForHttp, @"getGroupBuySearch.htm"];
    HTTPMSG_RELEASE_SAFELY(gbSearchHttpMsg);
    gbSearchHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                 requestUrl:url
                                                postDataDic:postDataDic
                                                    cmdCode:CC_GBSearch];
    [self.httpMsgCtrl sendHttpMsg:gbSearchHttpMsg];
}

#pragma mark -
#pragma mark final
- (void)searchOk:(BOOL)isSuccess
{
    if ([_delegate respondsToSelector:@selector(gbSearchComplete:service:)])
    {
        [_delegate gbSearchComplete:isSuccess service:self];
    }

}
#pragma mark - http message delegate
#pragma mark   HTTP 代理方法
- (void)receiveDataFinished:(HttpMessage *)recieveMsg Data:(NSDictionary *)dataDic Result:(BOOL)isSuccess{
   
    BOOL isHasResult = [[dataDic objectForKey: @"isSuccess"] boolValue];
    
    self.isHasResult = isHasResult;
    self.pageCount = EncodeStringFromDic(dataDic, @"pageCount");
    
    if (isSuccess) {
        
        NSArray *tempArr = (NSArray *)[dataDic objectForKey:@"goodsSearchList"];
        if ([tempArr count] > 0)
        {
            NSMutableArray *goodsListMArr = [NSMutableArray arrayWithCapacity:[tempArr count]];
            for (NSDictionary *dic in tempArr)
            {
                GBSearchListGoodsDTO *dto = [[GBSearchListGoodsDTO alloc] init];
                [dto encodeFromDictionary:dic];
                [goodsListMArr addObject:dto];
                TT_RELEASE_SAFELY(dto);
            }
            self.goodsList = goodsListMArr;
        }
        else
        {
            self.goodsList = nil;
        }
        
        [self searchOk:YES];
    }else{
        [self searchOk:NO];
    }
}

#pragma mark -
#pragma mark parse data

@end
