//
//  SearchQueryRecommendedBrandService.m
//  SuningEBuy
//
//  Created by chupeng on 14-11-8.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "SearchQueryRecommendedBrandService.h"

@implementation SearchQueryRecommendedBrandService

- (void)dealloc {
    HTTPMSG_RELEASE_SAFELY(queryRecommendedBrandMsg);
}

- (void)beginQueryRecommendedBrand:(NSString *)keyword
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"1" forKey:@"channel"];
    [dic setObject:keyword?keyword:@"" forKey:@"keyword"];
    
    HTTPMSG_RELEASE_SAFELY(queryRecommendedBrandMsg);
    queryRecommendedBrandMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:kNewSearchQueryRecommendedBrandHost postDataDic:dic cmdCode:CC_SearchQueryRecommendedBrand];
    
    self.brandList = nil;
    
    queryRecommendedBrandMsg.requestMethod = RequestMethodGet;
    [self.httpMsgCtrl sendHttpMsg:queryRecommendedBrandMsg];

}

#pragma mark - http message delegate

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    if (receiveMsg.cmdCode == CC_SearchQueryRecommendedBrand)
    {
        NSDictionary *item = receiveMsg.jasonItems;
        
        if (item)
        {
            NSString *code = EncodeStringFromDic(item, @"code");
            if ([code isEqualToString:@"1"])
            {
                [self parseItem:item];
            }
        }
    }
}

- (void)parseItem:(NSDictionary *)item
{
    NSDictionary *dataDic = EncodeDicFromDic(item, @"data");
    if (dataDic)
    {
        self.brandList = [NSMutableArray array];
        NSArray *array = EncodeArrayFromDic(dataDic, @"brandList");
        if (array)
        {
            for (NSDictionary *dicBrand in array) {
                SugDirDTO *dto = [[SugDirDTO alloc] init];
                dto.dirName = EncodeStringFromDic(dicBrand, @"brandName");
                dto.dirId = EncodeStringFromDic(dicBrand, @"brandId");
                [self.brandList addObject:dto];
            }
        }
        
        self.keyword = EncodeStringFromDic(dataDic, @"keyword");
    }
}

- (void)searchDidFinish:(BOOL)isSuccess
{
    if (isSuccess)
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(queryRecommendedBrandCompletionWithResult:errorMsg:service:)])
        {
            [self.delegate queryRecommendedBrandCompletionWithResult:isSuccess errorMsg:self.errorMsg service:self];
        }
    }
}
@end
