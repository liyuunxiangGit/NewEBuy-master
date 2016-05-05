//
//  SearchListService.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-8-30.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "SearchListService.h"
#import "InnerProductDTO.h"
#import "SearchFilterValueDTO.h"

@interface SearchListService()

@property (nonatomic, strong) SearchParamDTO *searchCondition;

- (void)parseSearchList:(NSDictionary *)item;

//- (void)parseNoResSugProduct:(NSDictionary *)items;

@end

/*********************************************************************/

@implementation SearchListService

@synthesize delegate = _delegate;

@synthesize productList = _productList;
@synthesize filterList = _filterList;
@synthesize categoryList = _categoryList;
@synthesize resultNumber = _resultNumber;
@synthesize showNumber = _showNumber;

@synthesize isLoadMore;
@synthesize currentPage;
@synthesize totalPage;
@synthesize isLastPage;
@synthesize isLoading;

@synthesize searchCondition = _searchCondition;


- (void)dealloc {
    TT_RELEASE_SAFELY(_productList);
    TT_RELEASE_SAFELY(_filterList);
    TT_RELEASE_SAFELY(_categoryList);
    TT_RELEASE_SAFELY(_resultNumber);
    TT_RELEASE_SAFELY(_searchCondition);
}

- (void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(searchListHttpMsg);
    HTTPMSG_RELEASE_SAFELY(noResSugHttpMsg);
    HTTPMSG_RELEASE_SAFELY(noResRecommendMsgForCategory);
}

- (void)beginGetSearchListWithSearchCondition:(SearchParamDTO *)searchCondition
                                         page:(NSInteger)page
{
    if (isLoading) {
        return;
    }
    isLoading = YES;
    self.searchCondition = searchCondition;
    
    //设置页数
    searchCondition.currentPage = [NSString stringWithFormat:@"%d", page];
    
    //参数
    NSDictionary *postDataDic = [searchCondition postDataDictionary];
    
    //促销开关打开的话，走mts接口，否则走老搜索接口
    NSString *url = nil;
    
    NSString *sscxkg = [SNSwitch getSearchPromotionValue];
    if (NotNilAndNull(sscxkg) && [sscxkg isEqualToString:@"1"])
    {
        url = [NSString stringWithFormat:@"%@%@",
               KNewHomeAPIURL,
               kSearchMtsAction];

        NSString *switchContent = [SNSwitch getsscxkgSwitchContent];
        if (NotNilAndNull(switchContent))
        {
            if ([switchContent isEqualToString:@"1"])
            {
                [postDataDic setValue:@"2" forKey:@"channelId"];      //2为客户端
                [postDataDic setValue:@"1" forKeyPath:@"endDeviceId"];//1为ios，2为安卓
            }
            else if ([switchContent isEqualToString:@"0"])
            {
                [postDataDic setValue:@"1" forKey:@"channelId"];    //1为主站
            }
        }
    }
    else if (IsNilOrNull(sscxkg) || [sscxkg isEqualToString:@"0"])
    {
        url = [NSString stringWithFormat:@"%@/%@",
               kSearchHostAddressForHttp,
               kHttpRequestMobileSearchJsonp];
    }
    else if (NotNilAndNull(sscxkg) && [sscxkg isEqualToString:@"2"])
    {
        url = [NSString stringWithFormat:@"%@/%@",
               kSearchHostAddressForHttp,
               kHttpRequestMobileSearchJsonp];
        
        [postDataDic setValue:@"MOBILE" forKey:@"channelId"];
    }
    [postDataDic setValue:@"-1" forKey:@"yuyue"];       //加此参数，让搜索可以返回预约信息
    
    [postDataDic setValue:@"0" forKey:@"ifhf"];        //高筛信息全部展示
    
    HTTPMSG_RELEASE_SAFELY(searchListHttpMsg);
    
    searchListHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                   requestUrl:url
                                                  postDataDic:postDataDic
                                                      cmdCode:CC_SearchList];
    
    searchListHttpMsg.canMultipleConcurrent = YES;
    
    [self.httpMsgCtrl sendHttpMsg:searchListHttpMsg];
    
    
    if (NotNilAndNull(sscxkg) && [sscxkg isEqualToString:@"1"])
    {
        self.searchCondition.keyword = [self.searchCondition.keyword stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
    }
    if ([self.searchCondition.keyword length])
    {
        sourceTitle = L(@"Search_KeywordSearch");
    }
    else
    {
        sourceTitle = L(@"Search_CategorySearch");
    }
}


- (void)beginGetRecommendHotProductListRequest:(NSString*)keyword
{
    //    NSDictionary *postDataDic = [[NSDictionary alloc] initWithObjectsAndKeys:
    //                                 kHttpRequestHomeStoreValue, kHttpRequestHomeStoreKey, nil];
    //    NSString *url = [NSString stringWithFormat:@"%@/%@",
    //                     kHostAddressForHttp,
    //                     kHttpRequestMobileNoResSugGoods];
    //
    //    HTTPMSG_RELEASE_SAFELY(noResSugHttpMsg);
    //    noResSugHttpMsg = [[HttpMessage alloc] initWithDelegate:self
    //                                                 requestUrl:url
    //                                                postDataDic:postDataDic
    //                                                    cmdCode:CC_NoResSugProduct];
    
    NSString *url = [NSString stringWithFormat:@"%@",
                     kSearchNoResultNewHostHttp];
    
    NSDictionary *postDataDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 keyword, @"parameter",
                                 [Config currentConfig].defaultCity, @"cityId",
                                 @"10-7",@"sceneIds",
                                 @"6",@"count"
                                 , nil];
    
    HTTPMSG_RELEASE_SAFELY(noResSugHttpMsg);
    noResSugHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                 requestUrl:url
                                                postDataDic:postDataDic
                                                    cmdCode:CC_SearchNoResultRecommendForKeySearch];
    
    TT_RELEASE_SAFELY(postDataDic);
    [self.httpMsgCtrl sendHttpMsg:noResSugHttpMsg];
}

/*!
 @abstract      获取推荐商品列表 for 分类筛选无结果
 @param         categoryID 三级分类id
 */
- (void)beginGetRecommendHotProductListRequestForCategoryFilter:(NSString *)categoryID
{
    NSString *url = [NSString stringWithFormat:@"%@",
                     kSearchNoResultNewHostHttp];
    
    NSMutableDictionary *postDataDic = [NSMutableDictionary dictionary];
    [postDataDic setObject:categoryID?categoryID:@"" forKey:@"parameter"];
    [postDataDic setObject:@"10-8" forKey:@"sceneIds"];
    [postDataDic setObject:[Config currentConfig].defaultCity forKey:@"cityId"];
    [postDataDic setObject:@"6" forKey:@"count"];
    
    NSString *userid = @"";
    if ([UserCenter defaultCenter].isLogined)
    {
        userid = [UserCenter defaultCenter].userInfoDTO.custNum;
    }
    else
    {
        //未登录时候 取_snma下第一个|到第二个|之间的字符串
        NSArray * arr = [[NSHTTPCookieStorage sharedHTTPCookieStorage]cookies];
        
        for (int i = 0; i < arr.count; i++)
        {
            NSHTTPCookie *cookie = [arr objectAtIndex:i];
            
            if ([cookie.name isEqualToString:@"_snma"])
            {
                NSHTTPCookie *cookie = [arr objectAtIndex:i];
                NSString *value = cookie.value;
                
                NSArray *arrSepedStrings = [value componentsSeparatedByString:@"|"];
                if (arrSepedStrings.count > 1)
                {
                    userid = [arrSepedStrings objectAtIndex:1];
                    break;
                }
            }
        }
    }
    
    [postDataDic setObject:userid forKey:@"u"];
    
    HTTPMSG_RELEASE_SAFELY(noResRecommendMsgForCategory);
    noResRecommendMsgForCategory = [[HttpMessage alloc] initWithDelegate:self
                                                              requestUrl:url
                                                             postDataDic:postDataDic
                                                                 cmdCode:CC_SearchNoResultRecommendForCategoryFilter];
    TT_RELEASE_SAFELY(postDataDic);
    
    [self.httpMsgCtrl sendHttpMsg:noResRecommendMsgForCategory];
}

#pragma mark -
#pragma mark 结束

- (void)searchDidFinish:(BOOL)isSuccess
{
    isLoading = NO;
    if (_delegate && [_delegate respondsToSelector:@selector(getSearchListCompletionWithResult:
                                                             errorMsg:
                                                             service:)]) {
        [_delegate getSearchListCompletionWithResult:isSuccess errorMsg:self.errorMsg service:self];
    }
}

- (void)getNoResProductListOk:(BOOL)isSuccess list:(NSArray *)list
{
    if (_delegate &&
        [_delegate respondsToSelector:@selector(getRecommentHotProductCompletionWithResult:
                                                errorMsg:
                                                productList:)]) {
        
        [_delegate getRecommentHotProductCompletionWithResult:isSuccess
                                                     errorMsg:self.errorMsg
                                                  productList:list];
    }
}


- (void)getNoResProductListOkForCategoryFilter:(BOOL)isSuccess list:(NSArray *)list
{
    if (_delegate &&
        [_delegate respondsToSelector:@selector(getRecommentHotProductCompletionWithResultForCategoryFilter:errorMsg:productList:)])
    {
        [_delegate getRecommentHotProductCompletionWithResultForCategoryFilter:isSuccess errorMsg:self.errorMsg productList:list];
    }
}
#pragma mark -
#pragma mark http message delegate

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    if (receiveMsg.cmdCode == CC_SearchList) {
        [self searchDidFinish:NO];
    }else if (receiveMsg.cmdCode == CC_SearchNoResultRecommendForKeySearch){
        [self getNoResProductListOk:NO list:nil];
    }
    else if (receiveMsg.cmdCode == CC_SearchNoResultRecommendForCategoryFilter)
    {
        [self getNoResProductListOkForCategoryFilter:NO list:nil];
    }
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    if (receiveMsg.cmdCode == CC_SearchList) {
        
        NSDictionary *item = receiveMsg.jasonItems;
        if (!item) {
            self.errorMsg = kHttpResponseJSONValueFailError;
            [self searchDidFinish:NO];
        }else{
            //判断是否成功
            NSString *errorCode = receiveMsg.errorCode;
            
            if ([errorCode isEqualToString:@""])
            {
                [self parseSearchList:item];
            }else{
                //                self.errorMsg = L(@"Sorry, Can't find product");
                [self searchDidFinish:NO];
            }
        }
    }
    else if (receiveMsg.cmdCode == CC_SearchNoResultRecommendForKeySearch)
    {
        //        NSDictionary *items = receiveMsg.jasonItems;
        //
        //        if (!items) {
        //            self.errorMsg = kHttpResponseJSONValueFailError;
        //            [self getNoResProductListOk:NO list:nil];
        //        }
        //        else if ([receiveMsg.errorCode isEqualToString:@""])
        //        {
        //            [self parseNoResSugProduct:items];
        //        }else{
        //            [self getNoResProductListOk:NO list:nil];
        //        }
        NSDictionary *items = receiveMsg.jasonItems;
        
        if (!items) {
            self.errorMsg = kHttpResponseJSONValueFailError;
            [self getNoResProductListOk:NO list:nil];
        }
        else
        {
            if ([[items objectForKey:@"sugGoods"] isKindOfClass:[NSArray class]])
            {
                NSArray *arrSugGoods = [items objectForKey:@"sugGoods"];
                if (NotNilAndNull(arrSugGoods) && arrSugGoods.count > 0)
                {
                    NSDictionary *dic = [arrSugGoods objectAtIndex:0];
                    
                    NSString *resCode = [dic objectForKey:@"resCode"];
                    if ([resCode isEqualToString:@"01"] || [resCode isEqualToString:@"03"])
                    {
                        NSArray *arrSkus = [dic objectForKey:@"skus"];
                        
                        NSMutableArray *innerDtoListArr = [NSMutableArray array];
                        for (NSDictionary *dicProduct in arrSkus)
                        {
                            NewInnerProductDTO *dto = [[NewInnerProductDTO alloc] init];
                            [dto encodeFromDictionary:dicProduct];
                            
                            [innerDtoListArr addObject:dto];
                        }
                        
                        [self getNoResProductListOk:YES list:innerDtoListArr];
                    }
                    else if ([resCode isEqualToString:@"02"])
                    {
                        [self getNoResProductListOk:NO list:nil];
                    }
                }
                else
                {
                    [self getNoResProductListOk:NO list:nil];
                }
            }
            else
            {
                [self getNoResProductListOk:NO list:nil];
            }
        }
    }
    else if (receiveMsg.cmdCode == CC_SearchNoResultRecommendForCategoryFilter)
    {
        NSDictionary *items = receiveMsg.jasonItems;
        
        if (!items) {
            self.errorMsg = kHttpResponseJSONValueFailError;
            [self getNoResProductListOkForCategoryFilter:NO list:nil];
        }
        else
        {
            if ([[items objectForKey:@"sugGoods"] isKindOfClass:[NSArray class]])
            {
                NSArray *arrSugGoods = [items objectForKey:@"sugGoods"];
                if (NotNilAndNull(arrSugGoods) && arrSugGoods.count > 0)
                {
                    NSDictionary *dic = [arrSugGoods objectAtIndex:0];
                    
                    NSString *resCode = [dic objectForKey:@"resCode"];
                    if ([resCode isEqualToString:@"01"] || [resCode isEqualToString:@"03"])
                    {
                        NSArray *arrSkus = [dic objectForKey:@"skus"];
                        
                        NSMutableArray *innerDtoListArr = [NSMutableArray array];
                        for (NSDictionary *dicProduct in arrSkus)
                        {
                            NewInnerProductDTO *dto = [[NewInnerProductDTO alloc] init];
                            [dto encodeFromDictionary:dicProduct];
                            
                            [innerDtoListArr addObject:dto];
                        }
                        
                        [self getNoResProductListOkForCategoryFilter:YES list:innerDtoListArr];
                    }
                    else if ([resCode isEqualToString:@"02"])
                    {
                        [self getNoResProductListOkForCategoryFilter:NO list:nil];
                    }
                }
                else
                {
                    [self getNoResProductListOkForCategoryFilter:NO list:nil];
                }
            }
            else
            {
                [self getNoResProductListOkForCategoryFilter:NO list:nil];
            }
        }
    }
}

- (void)parseSearchList:(NSDictionary *)item
{
    Background_Begin
    //商品列表
    NSArray	*goodList = [item objectForKey:@"goods"];
    NSMutableArray *retArray = nil;
    
    if (NotNilAndNull(goodList) && [goodList count]>0) {
        retArray = [[NSMutableArray alloc] initWithCapacity:[goodList count]];
        for(NSDictionary *dic in goodList)
        {
            DataProductBasic *productDTO =[[DataProductBasic alloc] init];
            [productDTO encodeSearchResultProductFromDic:dic];
            productDTO.cityCode = self.searchCondition.cityId;
            [retArray addObject:productDTO];
        }
    }
    
    if (isLoadMore) {
        if (!_productList) {
            _productList = [[NSMutableArray alloc] initWithCapacity:[retArray count]];
        }
        [self.productList addObjectsFromArray:retArray];
    }else{
        self.productList = retArray;
    }
    

    
    //如果商品列表为空，解析减词列表
    //liukun 12-11-26添加判断，图书搜索时不做减词
    
    self.isJianCi = NO;
    self.strJianCiKeyWord = @"";
    
    //如果进行过自营，有货，分类，筛选等操作产生的减词，不使用减词结果
    //add by zhangbeibei 20140810: 解析减词时去掉有货的条件
    if ((!_productList || [_productList count] == 0) &&
        self.searchCondition.set != SearchSetBook && [self.searchCondition isCleanSearchWithoutInventory])
    {
        NSArray *__subSearchResults = [item objectForKey:@"subSearchResults"];
        if (NotNilAndNull(__subSearchResults) && [__subSearchResults count] > 0) {
            
            self.isJianCi = YES;
            
            NSDictionary *subResDic = [__subSearchResults objectAtIndex:0];
            
            //解析出当前使用的减词
            NSString *subkey = [subResDic objectForKey:@"subkey"];
            if (subkey)
            {
                NSRange range = [subkey rangeOfString:@"@A@"];
                
                if (range.location != NSNotFound)
                {
                    NSString *subString = [subkey substringToIndex:range.location];
                    self.strJianCiKeyWord = subString;
                }
//                NSRange range = [subkey rangeOfString:@"<b>"];
//                if (range.location != NSNotFound)
//                {
//                    NSString *subString = [subkey substringFromIndex:range.location + 3];
//                    NSRange range = [subString rangeOfString:@"</b>"];
//                    if (range.location != NSNotFound)
//                    {
//                        NSString *currentUsedString = [subString substringToIndex:range.location];
//                        if (!IsStrEmpty(currentUsedString))
//                        {
//                            self.strJianCiKeyWord = currentUsedString;
//                        }
//                    }
//                }
                
            }
            
            //解析减词结果列表
            NSArray *subGoods = [subResDic objectForKey:@"goods"];
            if (NotNilAndNull(subGoods) && [subGoods count] > 0) {
                NSMutableArray *retSubArray =
                [[NSMutableArray alloc] initWithCapacity:[subGoods count]];
                for(NSDictionary *dic in subGoods)
                {
                    DataProductBasic *productDTO =[[DataProductBasic alloc] init];
                    [productDTO encodeSearchResultProductFromDic:dic];
                    [retSubArray addObject:productDTO];
                }
                self.productList = retSubArray;
            }
        }
    }
    
    //类目
    NSArray *__categoryies = [item objectForKey:@"categories"];
    if (NotNilAndNull(__categoryies) && [__categoryies count] > 0)
    {
        NSMutableArray *retCateList =
        [[NSMutableArray alloc] initWithCapacity:[__categoryies count]];
        for (NSDictionary *dic in __categoryies)
        {
            SearchCateDTO *cateDTO = [[SearchCateDTO alloc] init];
            [cateDTO encodeFromDictionary:dic];
            [retCateList addObject:cateDTO];
        }
        self.categoryList = retCateList;
    }
    else
    {
        self.categoryList = [NSMutableArray array];
    }
    
    //筛选项
    NSArray *__filters = [item objectForKey:@"filters"];
    if (NotNilAndNull(__filters) && [__filters count] > 0)
    {
        NSMutableArray *retFilters =
        [[NSMutableArray alloc] initWithCapacity:[__filters count]];
        for (NSDictionary *dic in __filters)
        {
            SearchFilterDTO *dto = [[SearchFilterDTO alloc] init];
            [dto encodeFromDictionary:dic];
            if (dto.filterName && ![dto.filterName isEmptyOrWhitespace]) {
                [retFilters addObject:dto];
            }
        }
        self.filterList = retFilters;
    }
    else
    {
        self.filterList = [NSMutableArray array];
    }
    
    //有时类目搜索时，传入的cf不能正常展示checked,故遍历筛选列表，将其中选择的filterValue的
    //checked设置为YES
    if ([self.searchCondition.checkedFilters count] > 0 &&
        (self.searchCondition.searchType == SearchTypeCategory_3 ||
         self.searchCondition.searchType == SearchTypeCategory_2))
    {
        void (^checkValueInList)(NSString *, NSArray *) =
        ^(NSString *value, NSArray *list)
        {
            for (SearchFilterDTO *dto in self.filterList)
            {
                for (SearchFilterValueDTO *vDto in dto.valueList)
                {
                    if ([vDto.value isEqualToString:value])
                    {
                        if (!vDto.checked) { vDto.checked = YES; }
                        return;
                    }
                }
            }
        };
        
        for (NSString *value in [self.searchCondition.checkedFilters allValues])
        {
            checkValueInList(value, self.filterList);
        }
    }
    
    //品牌旗舰店
    self.brandShopDTO = nil;
    NSArray *brandshops = [item arrayValue:@"sugBrands"];
    if (NotNilAndNull(brandshops) && brandshops.count > 0)
    {
        for (int i = 0; i < brandshops.count; i++)
        {
            NSDictionary *dic = [brandshops objectAtIndex:i];
            BrandShopDTO *dto = [[BrandShopDTO alloc] init];
            [dto encodeFromDictionary:dic];
            if (dto.url.length > 12)
            {
                NSString *str = [dto.url substringWithRange:NSMakeRange(7, 5)];//查看是否以shop7开头，形式为：http://shop7xxxxx
                if ([str isEqualToString:@"shop7"])
                {
                    self.brandShopDTO = dto;
                    break;
                }
            }
        }
    }
    
    
    //常用分类
    self.sugdirsArray = nil;
    NSArray *sugDirs = [item arrayValue:@"sugDirs"];
    if (NotNilAndNull(sugDirs) && sugDirs.count > 0)
    {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:sugDirs.count];
        
        for (NSDictionary *dic in sugDirs) {
            SugDirDTO *dto = [[SugDirDTO alloc] init];
            [dto encodeFromDictionary:dic];
            
            [array addObject:dto];
        }
        
        self.sugdirsArray = array;
    }
    
        
    
    //收集搜索结果信息,并设置分页
    NSString *resultNumber = [item objectForKey:@"goodsCount"];
    if (NotNilAndNull(resultNumber)) {
        self.resultNumber = resultNumber;
        int totalNum = [resultNumber intValue];
        if (totalNum % 10 == 0) {
            self.totalPage = totalNum/10;
        }else{
            self.totalPage = totalNum/10 + 1;
        }
    }else{
        self.totalPage = 1;
    }
    
    if (currentPage < totalPage - 1)
    {
        isLastPage = NO;
        currentPage++;
    }else{
        isLastPage = YES;
    }
    
    NSInteger res_num = [resultNumber integerValue];
    if (res_num <= 0 && [self.productList count] > 0) { //减词情况存在时
        self.showNumber = [self.productList count];
    }else{
        self.showNumber = res_num;
    }
    
    Foreground_Begin
    [self searchDidFinish:YES];
    Foreground_End
    
    Background_End
}

//- (void)parseNoResSugProduct:(NSDictionary *)items
//{
//    Background_Begin
//    NSArray *productList = [items objectForKey:@"productList"];
//
//    NSMutableArray *array = nil;
//
//    if (productList && [productList count] > 0) {
//        array = [[NSMutableArray alloc] initWithCapacity:[productList count]];
//
//        for (NSDictionary *dic in productList)
//        {
//            DataProductBasic *dto = [[DataProductBasic alloc] init];
//            [dto encodeSearchNoResSugProductFromDic:dic];
//
//            //介于view使用的是InnerProductDTO
//            InnerProductDTO *innerDTO = [[InnerProductDTO alloc] init];
//            innerDTO.productId = dto.productId;
//            innerDTO.productName = dto.productName;
//            innerDTO.productCode = dto.productCode;
//            innerDTO.productPrice = [dto.price stringValue];
//            innerDTO.productImageURL = [dto.productImageURL absoluteString];
//            innerDTO.productDesc = dto.special;
//            [array addObject:innerDTO];
//        }
//    }
//
//    Foreground_Begin
//    [self getNoResProductListOk:YES list:array];
//    Foreground_End
//
//    Background_End
//}

#pragma mark -
#pragma mark load more

- (BOOL)hasMore
{
    return !isLastPage;
}

- (void)refreshData:(SearchParamDTO *)searchCondition
{
    isLoadMore = NO;
    
    currentPage = 0;
    
    totalPage = 0;
    
    isLastPage = YES;
    
    [self beginGetSearchListWithSearchCondition:searchCondition page:currentPage];
}

- (void)loadMoreData:(SearchParamDTO *)searchCondition
{
    isLoadMore = YES;
    
    [self beginGetSearchListWithSearchCondition:searchCondition page:currentPage];
}

@end
