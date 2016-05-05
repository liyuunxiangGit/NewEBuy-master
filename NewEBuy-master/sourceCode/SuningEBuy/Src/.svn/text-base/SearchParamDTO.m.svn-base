//
//  SearchParamDTO.m
//  SuningEBuy
//
//  Created by  on 12-10-16.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "SearchParamDTO.h"

@implementation SearchParamDTO

@synthesize searchType = _searchType;
@synthesize set = _set;
@synthesize inventory = _inventory;
@synthesize keyword = _keyword;
@synthesize cityId = _cityId;
@synthesize categoryId = _categoryId;
@synthesize currentPage = _currentPage;
@synthesize pageSize = _pageSize;
@synthesize sortType = _sortType;
@synthesize checkedFilters = _checkedFilters;
@synthesize brand = _brand;
@synthesize title = _title;
@synthesize shopNum = _shopNum;

- (void)dealloc {
    TT_RELEASE_SAFELY(_inventory);
    TT_RELEASE_SAFELY(_keyword);
    TT_RELEASE_SAFELY(_cityId);
    TT_RELEASE_SAFELY(_categoryId);
    TT_RELEASE_SAFELY(_currentPage);
    TT_RELEASE_SAFELY(_pageSize);
    TT_RELEASE_SAFELY(_checkedFilters);
    TT_RELEASE_SAFELY(_brand);
    TT_RELEASE_SAFELY(_title);
    TT_RELEASE_SAFELY(_shopNum);
}

- (void)build
{
    self.cityId = [Config currentConfig].defaultCity;
    
    //默认请求有货商品
    if (!self.inventory) self.inventory = @"-1";
    
    //设置默认一页显示10条数据
    self.pageSize = @"10";
    self.currentPage = @"0";
    self.sortType = SortTypeDefault;
}


- (void)clean
{
    self.keyword = nil;
    self.cityId = nil;
    self.categoryId = nil;
    self.currentPage = nil;    
    self.pageSize = nil;
    [self.checkedFilters removeAllObjects];
    self.brand = nil;
    self.shopNum = nil;
}

//保证对象不为空
- (NSMutableDictionary *)checkedFilters
{
    if (!_checkedFilters) {
        _checkedFilters = [[NSMutableDictionary alloc] init];
    }
    return _checkedFilters;
}


- (id)initWithSearchType:(SearchType)type set:(SearchSet)set
{
    self = [super init];
    if (self) {
        self.searchType = type;
        self.set = set;
        [self build];
    }
    return self;
}

- (void)resetWithSearchType:(SearchType)type set:(SearchSet)set
{
    [self clean];
    self.searchType = type;
    self.set = set;
    [self build];
}


- (NSDictionary *)postDataDictionary
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    NSString *sscxkg = [SNSwitch getSearchPromotionValue];
    if (NotNilAndNull(sscxkg) && [sscxkg isEqualToString:@"1"])
    {
        [dic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
    }
    
    NSString *setStr = nil;
    switch (_set) {
        case SearchSetMix:
            setStr = @"5";
            break;
        case SearchSetElec:
            setStr = @"6";
            break;
        case SearchSetBook:
            setStr = @"7";
            break;
        default:
            setStr = @"5";
            break;
    }
    if (setStr)        [dic setObject:setStr forKey:@"set"];
    if (_inventory)
    {
        if (_set == SearchSetBook)
        {
            [dic setObject:@"-1" forKey:@"iv"];
        }
        else
        {
            [dic setObject:self.inventory forKey:@"iv"];
        }
    }
    if (_keyword)
    {
        [dic setObject:self.keyword forKey:@"keyword"];
    
        //mts对编码支持有问题，这里先url编码一次，总共url编码两次，因为mts环境url解码了一次，后台代码又url解码了一次
        
        if (NotNilAndNull(sscxkg) && [sscxkg isEqualToString:@"1"])
        {
            self.keyword = [self.keyword stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            [dic setObject:self.keyword forKey:@"keyword"];
        }
    }
    
    if (_cityId)       [dic setObject:self.cityId forKey:@"cityId"];
    if (_categoryId)   [dic setObject:self.categoryId forKey:@"ci"];
    if (_currentPage)  [dic setObject:self.currentPage forKey:@"cp"];
    if (_pageSize)     [dic setObject:self.pageSize forKey:@"ps"];
    
    NSString *sortStr = nil;
    switch (_sortType) {
        case SortTypeDefault:
            switch (self.searchType) {
                case SearchTypeKeyword:
                case SearchTypeBrand:
                    sortStr = @"0";
                    break;
                case SearchTypeCategory_2:
                    sortStr = self.set==SearchSetBook?@"8":@"12";
                    break;
                case SearchTypeCategory_3:
                    //图书使用默认排序
                    sortStr = self.set==SearchSetBook?@"8":@"14";
                    break;
                default:
                    break;
            }
            break;
        case SortTypeSalevolume:
            sortStr = @"8";
            break;
        case SortTypePriceUp:
            sortStr = @"9";
            break;
        case SortTypePriceDown:
            sortStr = @"10";
            break;
        case SortTypeEvaluate:
            sortStr = @"6";
            break;
//        case SortTypeEvaluUp:
//            sortStr = @"5";
//            break;
//        case SortTypeEvaluDown:
//            sortStr = @"6";
//            break;
        default:
            sortStr = @"0";
            break;
    }
    
    if (sortStr)      [dic setObject:sortStr forKey:@"st"];
    
    if ([self.checkedFilters count] > 0) {
        NSMutableString *cfMStr = [[NSMutableString alloc] init];
        for (NSString *key in [self.checkedFilters allKeys])
        {
            NSString *value = [self.checkedFilters objectForKey:key];
            [cfMStr appendFormat:@"%@:%@,", key, value];
        }
        
        //238版本价格区间固定存在，服务器下发的价格筛选项被屏蔽 by chupeng 2014-5-28
        if (NotNilAndNull(self.priceString))
        {
            [cfMStr appendFormat:@"%@:%@,", @"price", self.priceString];
        }
        
//        //加入热销品牌 by chupeng
//        if (!IsStrEmpty(self.brandRecommended))
//        {
//            [cfMStr appendFormat:@"%@,", self.brandRecommended];
//        }
        
        [cfMStr deleteCharactersInRange:NSMakeRange([cfMStr length]-1, 1)];
        [dic setObject:cfMStr forKey:@"cf"];
        TT_RELEASE_SAFELY(cfMStr);
    }
    else
    {
        NSMutableString *cfMStr = [[NSMutableString alloc] init];
        
        //238版本价格区间固定存在，服务器下发的价格筛选项被屏蔽 by chupeng 2014-5-28
        if (NotNilAndNull(self.priceString))
        {
            [cfMStr appendFormat:@"%@:%@,", @"price", self.priceString];
        }
        
//        //加入热销品牌 by chupeng
//        if (!IsStrEmpty(self.brandRecommended))
//        {
//            [cfMStr appendFormat:@"%@,", self.brandRecommended];
//        }
        
        if (NotNilAndNull(cfMStr) && cfMStr.length >= 1)
        {
            [cfMStr deleteCharactersInRange:NSMakeRange([cfMStr length]-1, 1)];
            [dic setObject:cfMStr forKey:@"cf"];
        }
    }
    
    //加入促销筛选 by chupeng 2014 - 5- 29
    if (!IsStrEmpty(self.salesPromotion))
        [dic setObject:self.salesPromotion forKey:@"sp"];
    
    if (_brand)       [dic setObject:self.brand forKey:@"bi"];
    
    if (!_shopNum)
    {
        self.shopNum = @"-1";
        [dic setObject:self.shopNum forKey:@"ct"];
    }
    else
    {
        [dic setObject:self.shopNum forKey:@"ct"];
    }

    
    //2.3.8开始，切换新价格图片，加一个是否通码参数 chupeng 
    
//    [dic setObject:@"1" forKey:@"istongma"];
    return dic;
}


//判断是否进行过自营，有货，筛选，促销等操作
- (BOOL)isCleanSearch
{
    if ([self.inventory isEqualToString:@"-1"] && [self.shopNum isEqualToString:@"-1"] && self.checkedFilters.count < 1 && (IsStrEmpty(self.salesPromotion)))
    {
        return YES;
    }
    return NO;
}

//add by zhangbeibei 20140810: 去掉有货条件
- (BOOL)isCleanSearchWithoutInventory {
    if ([self.shopNum isEqualToString:@"-1"] && self.checkedFilters.count < 1 && (IsStrEmpty(self.salesPromotion)))
    {
        return YES;
    }
    return NO;
}

- (void)setCF:(NSString *)cf
{
    NSArray *pairs = [cf componentsSeparatedByString:@","];
    if ([pairs count])
    {
        NSMutableDictionary *checkFilters = [NSMutableDictionary dictionary];
        for (NSString *pair in pairs)
        {
            NSArray *keyValueArr = [pair componentsSeparatedByString:@":"];
            if ([keyValueArr count] == 2)
            {
                [checkFilters setObject:keyValueArr[1] forKey:keyValueArr[0]];
            }
        }
        
        if (checkFilters.count) self.checkedFilters = checkFilters;
    }
}

@end
