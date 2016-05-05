//
//  GBListService.h
//  SuningEBuy
//
//  Created by shasha on 13-2-26.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "GBBaseService.h"
#import "GBListPrametersDTO.h"
#import "GBListGoodsDTO.h"
#import "GBCategoryDTO.h"
#import "GBSearchFilterDTO.h"

@protocol GBListServiceDelegate;

@interface GBListService : GBBaseService{
    HttpMessage *__GBListMsg;
}

@property (nonatomic, strong) NSString  *numberFound;
@property (nonatomic, strong) NSString  *flag;
@property (nonatomic, strong) NSArray   *searchResultsList;
@property (nonatomic, strong) NSMutableArray   *filtersList;

@property (nonatomic, weak) id<GBListServiceDelegate>  delegate;

- (void)beginSendGBListRequest:(GBListPrametersDTO *)dto;

@end

@protocol GBListServiceDelegate <NSObject>

- (void)didSendGBListRequestComplete:(GBListService *)service  Result:(BOOL)isSuccess;

@end
