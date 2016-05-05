//
//  CategoryService.h
//  SuningEBuy
//
//  Created by li xiaokai on 13-4-9.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "DataService.h"
#import "ProductCategoryDTO.h"

#define kCategoryCacheKey       @"sn.category.json"
@class CategoryService;

@protocol  CategoryServiceDelegate<NSObject>

@optional
- (void)service:(CategoryService *)service loadCateComplete:(BOOL)isSuccess;

@end

@interface CategoryService :DataService{
    
    HttpMessage     *cateHttpMsg;
    
    BOOL            _isFromCache;
    BOOL            _isCategoryLoaded;
}

@property (nonatomic, weak) id  <CategoryServiceDelegate>delegate;
@property (nonatomic, readonly) BOOL                  isFromCache;
@property (nonatomic, strong) NSMutableArray *categoryList;
@property (nonatomic, readonly) BOOL                  isCategoryLoaded;
@property (nonatomic,strong)NSString                   *categoryStr;

- (void)sendCategoryRequest:(NSString *)category;

@end
