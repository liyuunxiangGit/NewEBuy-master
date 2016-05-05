//
//  ShopSearchListService.m
//  SuningEBuy
//
//  Created by chupeng on 14-7-10.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "ShopSearchListService.h"

#pragma mark - ShopSearchListParamDTO @implementation

@implementation ShopSearchListParamDTO
- (id)init
{
    if (self = [super init])
    {
        _keyWord = @"";
        _cp = @"0";
        _ps = @"10";
        _st = @"0";
//        _cn = @"";
    }
    
    return self;
}
@end

#pragma mark - ShopSearchListService @implementation

@implementation ShopSearchListService
@synthesize isLoadMore;
@synthesize currentPage;
@synthesize totalPage;
@synthesize isLastPage;
@synthesize isLoading;

- (void)dealloc {
    HTTPMSG_RELEASE_SAFELY(shopSearchListHttpMsg);
}

- (id)init
{
    if (self = [super init])
    {
        _shopList = [NSMutableArray array];
    }
    
    return self;
}

- (void)beginGetShopSearchListWithSearchCondition:(ShopSearchListParamDTO *)shopSearchCondition page:(NSInteger)page
{
    if (isLoading)
        return;
    isLoading = YES;
    
    
    self.shopSearchParam = shopSearchCondition;
    
    //页数
    self.shopSearchParam.cp = [NSString stringWithFormat:@"%d", page];
    
    //设置参数
    NSMutableDictionary *postDataDic = [NSMutableDictionary dictionary];
    
    //关键词
    [postDataDic setValue:self.shopSearchParam.keyWord forKey:@"keyword"];
    
    //城市
    [postDataDic setValue:self.shopSearchParam.cn forKey:@"cn"];
    
    //排序类型
    [postDataDic setValue:self.shopSearchParam.st forKey:@"st"];
    
    //请求页面的index
    [postDataDic setValue:self.shopSearchParam.cp forKey:@"cp"];
    
    //每页最大记录数
    [postDataDic setValue:self.shopSearchParam.ps forKey:@"ps"];
    
    //店铺搜索标示符
    [postDataDic setValue:@"shopsearch" forKey:@"app"];
    
    NSString *url = [NSString stringWithFormat:@"%@", kShopSearchHost];
    
    HTTPMSG_RELEASE_SAFELY(shopSearchListHttpMsg);
    
    shopSearchListHttpMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:url postDataDic:postDataDic cmdCode:CC_ShopSearchList];
    
    shopSearchListHttpMsg.requestMethod = RequestMethodGet;
    
    [self.httpMsgCtrl sendHttpMsg:shopSearchListHttpMsg];
}

- (BOOL)hasMore
{
    return !isLastPage;
}

- (void)refreshData:(ShopSearchListParamDTO *)shopSearchCondition
{
    isLoadMore = NO;
    
    currentPage = 0;
    
    totalPage = 0;
    
    isLastPage = YES;
    
     [self beginGetShopSearchListWithSearchCondition:shopSearchCondition page:currentPage];
}

- (void)loadMoreData:(ShopSearchListParamDTO *)shopSearchCondition
{
    isLoadMore = YES;
    
    [self beginGetShopSearchListWithSearchCondition:shopSearchCondition page:currentPage];
}

- (void)searchDidFinish:(BOOL)isSuccess
{
    isLoading = NO;
    if (_delegate && [_delegate respondsToSelector:@selector(getShopListCompletedWithResult:
                                                             errorMsg:
                                                             service:)]) {
        [_delegate getShopListCompletedWithResult: isSuccess errorMsg:self.errorMsg service:self];
    }
}

#pragma mark - http message delegate
- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    if (receiveMsg.cmdCode == CC_ShopSearchList)
    {
        NSDictionary *item = receiveMsg.jasonItems;
        
        if (!item)
        {
            self.errorMsg = kHttpResponseJSONValueFailError;
            [self searchDidFinish:NO];
        }
        else
        {
            //判断是否成功
            NSString *errorCode = receiveMsg.errorCode;
            
            if ([errorCode isEqualToString:@""] || errorCode == nil)
            {
                [self parseShopSearchList:item];
            }
            else
            {
                [self searchDidFinish:NO];
            }
        }
    }
}

- (void)parseShopSearchList:(NSDictionary *)item
{
    Background_Begin
    
    //设置分页
    NSString *resultNumber = [item objectForKey:@"totalCount"];
    if (NotNilAndNull(resultNumber))
    {
        self.resultNumber = resultNumber;
        int totalNum = [resultNumber intValue];
        if (totalNum % 10 == 0)
            self.totalPage = totalNum / 10;
        else
            self.totalPage = totalNum / 10 + 1;
    }
    else
        self.totalPage = 1;
    
    if (currentPage < totalPage - 1) {
        isLastPage = NO;
        currentPage++;
    }
    else
    {
        isLastPage = YES;
    }
    
    //解析结果
    NSArray *goodsList = [item arrayValue:@"goodsList"];
    NSMutableArray *retArray = nil;
    
    if (NotNilAndNull(goodsList) && [goodsList count] > 0)
    {
        retArray = [[NSMutableArray alloc] initWithCapacity:[goodsList count]];
        for(NSDictionary *dic in goodsList)
        {
            ShopSearchListDTO *dto = [[ShopSearchListDTO alloc] init];
            [dto encodeFromDictionary:dic];
            [retArray addObject:dto];
        }
    }

    if (isLoadMore)
    {
        [self.shopList addObjectsFromArray:retArray];
    }
    else
    {
        self.shopList = retArray;
    }
    
    Foreground_Begin
    if (IsNilOrNull(self.shopList) || self.shopList.count == 0)
    {
        [self searchDidFinish:NO];
    }
    else
    {
        [self searchDidFinish:YES];
    }
    Foreground_End
    
    Background_End
}


@end
