//
//  MyEbuyService.m
//  SuningEBuy
//
//  Created by shasha on 12-8-28.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "InterestProductService.h"
#import "HomeTopScrollAdDTO.h"
#import "SNCache.h"

@interface  InterestProductService()

@property (nonatomic, assign) BOOL                   isProductsLoaded;
@property (nonatomic, strong) EightBannerADService  *eightBannerService;
@property (nonatomic, strong) AdModelService        *admodelService;


- (void)getInterestProductOk:(BOOL)isSuccess list:(NSArray *)list;

@end

@implementation InterestProductService
@synthesize isProductsLoaded;
@synthesize delegate;
@synthesize eightBannerService = _eightBannerService;
@synthesize admodelService = _admodelService;

- (void)dealloc {
    
    _eightBannerService.delegate = nil;
    _admodelService.delegate = nil;
    TT_RELEASE_SAFELY(_eightBannerService);
    TT_RELEASE_SAFELY(_admodelService);
    
}

- (void)httpMsgRelease
{
    
}

- (id)init {
    
    self = [super init];
    
    if (self) {
        
        isProductsLoaded = NO;
    }
    
    return self;
}

- (void)beginGetIntrestProductsIsLimit21:(BOOL)isLimit
{   
    isLimit21 = isLimit;
    
    NSArray *cacheHotSaleList = [[SNMemoryCache defaultCache] objectForKey:@"sn.hotsale"];
    // add by cuizl 将促销商品添加到GlobalDataCenter单例中
     if([cacheHotSaleList count]==0)
     {
         [self.eightBannerService requestBannerListWithAdType:eHotSaleAdType];
         
     }
     else
     {
         
         if(isLimit){
             
             NSArray *array;
             //是否最多展示21个商品
             if (isLimit21 && [cacheHotSaleList count] > 21) {
                 
                 NSMutableArray *temp = [[NSMutableArray alloc] initWithArray:cacheHotSaleList];
                 [temp removeObjectsInRange:NSMakeRange(21, [cacheHotSaleList count]-21)];
                 array = temp;
                 
             }else{
                 
                 array = cacheHotSaleList;
                 
             }
             
             [self getInterestProductOk:YES list:array];
             
         }else{
             
             [self getInterestProductOk:YES list:cacheHotSaleList];
         }
     }

}

- (void)service:(EightBannerADService *)service requestEightBannerComplete:(BOOL)isSuccess
{
    if (isSuccess)
    {
        NSString *advertiseMentId = nil;
        if ([service.topBannerList count] > 0) {
            HomeTopScrollAdDTO *dto = [service.topBannerList objectAtIndex:0];
            advertiseMentId = dto.advertiseId;
        }else{
            advertiseMentId = @"40";
        }
        
        [self.admodelService requestModelListWithAdId:advertiseMentId];
    }
    else
    {
        self.errorMsg = service.errorMsg;
        [self getInterestProductOk:NO list:nil];
    }
}

- (void)service:(AdModelService *)service getAdModelListComplete:(BOOL)isSuccess
{
    if (isSuccess)
    {
        [[SNMemoryCache defaultCache] saveObject:service.innerProductList forKey:@"sn.hotsale"];
        //是否最多展示21个商品
        NSUInteger count = [service.innerProductList count];
        if (isLimit21 && count > 21) {
            
            NSMutableArray *temp = [[NSMutableArray alloc] initWithArray:service.innerProductList];
            [temp removeObjectsInRange:NSMakeRange(21, count-21)];
            [self getInterestProductOk:YES list:temp];
        }
        else
        {
            [self getInterestProductOk:YES list:service.innerProductList];
        }
    }
    else
    {
        self.errorMsg = service.errorMsg;
        [self getInterestProductOk:NO list:nil];
    }
}

- (void)getInterestProductOk:(BOOL)isSuccess list:(NSArray *)list{

    if ([self.delegate respondsToSelector:@selector(getIntrestProductsComplete:errorMsg:productList:)]) {
        
        [self.delegate getIntrestProductsComplete:isSuccess errorMsg:self.errorMsg productList:list];
    }

}

- (EightBannerADService *)eightBannerService{
    
    if (!_eightBannerService) {
        
        _eightBannerService = [[EightBannerADService alloc] init] ;
        
        _eightBannerService.delegate = self; 
        
    }
    
    return _eightBannerService;
}


- (AdModelService *)admodelService{

    if (!_admodelService) {
        
        _admodelService = [[AdModelService alloc] init];
        
        _admodelService.delegate = self;
        
    }
    return _admodelService;
}
@end
