//
//  GBCategoryDTO.m
//  SuningEBuy
//
//  Created by shasha on 13-2-26.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "GBCategoryDTO.h"

@implementation GBCategoryDTO

@synthesize goodsCount = _goodsCount;
@synthesize categoryName = _categoryName;
@synthesize categoryId = _categoryId;
@synthesize subCategoryList = _subCategoryList;

- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (dic == nil)
    {
        return;
    }
    
    [self encodeNormalInfo:dic ToCategoryDto:self];

    NSArray *subcateArr = nil;
    if ([[dic objectForKey:@"subCategoryList"] isKindOfClass:[NSArray class]]) {
        subcateArr = [dic objectForKey:@"subCategoryList"];
    }
    
    if (IsArrEmpty(subcateArr)) {
        self.subCategoryList = nil;
    }else{
        NSMutableArray *tempArr = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in subcateArr) {
            GBCategoryDTO *dto = [[GBCategoryDTO alloc] init];
            [self encodeSecondCateInfo:dic ToCategoryDto:dto];
            [tempArr addObject:dto];
            TT_RELEASE_SAFELY(dto);
        }
        self.subCategoryList = tempArr;
        TT_RELEASE_SAFELY(tempArr);
    }
}

- (void)encodeNormalInfo:(NSDictionary *)dic ToCategoryDto:(GBCategoryDTO *)dto{
    dto.goodsCount = EncodeStringFromDic(dic, @"goodsCount");
    dto.categoryId = EncodeStringFromDic(dic, @"categoryId");
    dto.categoryName = EncodeStringFromDic(dic, @"categoryName");
}

- (void)encodeSecondCateInfo:(NSDictionary *)dic ToCategoryDto:(GBCategoryDTO *)dto{
    dto.goodsCount = EncodeStringFromDic(dic, @"goodsCount");
    dto.categoryId = EncodeStringFromDic(dic, @"subCategoryId");
    dto.categoryName = EncodeStringFromDic(dic, @"subCategoryName");
}
@end
