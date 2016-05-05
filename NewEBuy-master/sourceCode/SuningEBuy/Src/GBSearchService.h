//
//  GBSearchService.h
//  SuningEBuy
//
//  Created by  liukun on 13-3-4.
//  Copyright (c) 2013年 Suning. All rights reserved.
//
/*!
 @header      GBSearchService.h
 @abstract    <#头文件描述#>
 @author       liukun
 @version     v1.0  13-3-4
 */


#import "GBBaseService.h"

typedef enum {
    GBSearchTypeProduct = 1,        //商品
    GBSearchTypeStore,              //商户
    GBSearchTypeArea,               //商圈
}GBSearchType;

@protocol GBSearchServiceDelegate;
//----------------------------------------------------------

@interface GBSearchService : GBBaseService
{
    HttpMessage *gbSearchHttpMsg;
}

@property (nonatomic, weak) id<GBSearchServiceDelegate> delegate;
@property (nonatomic, strong) NSArray  *goodsList;
@property (nonatomic, copy)   NSString  *pageCount;
@property (nonatomic, assign) BOOL      isHasResult;

- (void)beginGBSearchWithKeyword:(NSString *)keyword
                          cityId:(NSString *)cityId
                      searchType:(GBSearchType)type
                            page:(NSInteger)page;

@end

@protocol GBSearchServiceDelegate <NSObject>

@optional
- (void)gbSearchComplete:(BOOL)isSuccess
                 service:(GBSearchService *)service;
@end