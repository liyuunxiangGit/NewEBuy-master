//
//  SearchQueryRecommendedBrandService.h
//  SuningEBuy
//
//  Created by chupeng on 14-11-8.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "DataService.h"
#import "SugDirDTO.h"
//@class SearchQueryRecommendedBrandService;
@protocol SearchQueryRecommendedBrandServiceDelegate;

@interface SearchQueryRecommendedBrandService : DataService
{
    HttpMessage *queryRecommendedBrandMsg;
}

@property (nonatomic, copy) NSString *keyword;
@property (nonatomic, strong) NSMutableArray *brandList; //借用了SugDirDTO（常用分类的dto）
@property (nonatomic, weak) id <SearchQueryRecommendedBrandServiceDelegate> delegate;
- (void)beginQueryRecommendedBrand:(NSString *)keyword;
@end

@protocol SearchQueryRecommendedBrandServiceDelegate <NSObject>
- (void)queryRecommendedBrandCompletionWithResult:(BOOL)isSuccess errorMsg:(NSString *)errorMsg service:(SearchQueryRecommendedBrandService *)service;
@end