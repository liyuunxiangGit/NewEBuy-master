//
//  InterestProductService.h
//  SuningEBuy
//
//  Created by shasha on 12-8-28.
//  Copyright (c) 2012年 Suning. All rights reserved.
//
/*!
 @header      InterestProductService
 @abstract    获取热销商品的service
 @author      shasha
 @version     v1.0  12-8-28
 @discussion  modify by liukun 12-9-28
 */

#import "DataService.h"
#import "EightBannerADService.h"
#import "AdModelService.h"

@protocol InterestProductServiceDelegate ;

@interface InterestProductService : DataService<EightBannerADServiceDelegate,AdModelServiceDelegate>
{
    BOOL    isLimit21;
}

@property (nonatomic, weak) id              <InterestProductServiceDelegate>delegate;


/*!
 @abstract      开始获取热销商品列表
 @param         isLimit  是否限制解析数量为21个,作为感兴趣商品解析时最多解析21个
 */
- (void)beginGetIntrestProductsIsLimit21:(BOOL)isLimit;

@end

@protocol InterestProductServiceDelegate <NSObject>

/*!
 @abstract      获取热销商品完成
 @param         isSuccess  获取热销商品是否成功
 @param         errorMsg  失败时的错误信息
 @param         list      热销商品列表
 */
@optional
- (void)getIntrestProductsComplete:(BOOL)isSuccess 
                          errorMsg:(NSString*)errorMsg 
                       productList:(NSArray *)list;

@end