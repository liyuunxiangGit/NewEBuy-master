//
//  ProductParamService.h
//  SuningEBuy
//
//  Created by  on 12-9-13.
//  Copyright (c) 2012年 Suning. All rights reserved.
//
/*!
 @header      获取商品参数的service
 @abstract    获取商品参数的service
 @author      刘坤
 @version     v1.0.001  12-9-13
 */

#import "DataService.h"
#import "DataProductBasic.h"

@protocol ProductParamServiceDelegate <NSObject>

@optional
- (void)getProductParamCompletionWithResult:(BOOL)isSuccess 
                                   errorMsg:(NSString *)errorMsg 
                                  paramList:(NSArray *)list;

@end

@interface ProductParamService : DataService
{
    HttpMessage     *getParamHttpMsg;
}

@property (nonatomic, weak) id<ProductParamServiceDelegate> delegate;

/*!
 @abstract      开始获取商品参数
 @param         product  包含商品详情的dto
 */
- (void)beginGetProductParamWithProduct:(DataProductBasic *)product;

@end
