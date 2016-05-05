//
//  ProductConsultantListService.h
//  SuningEBuy
//
//  Created by 漫 王 on 12-9-24.
//  Copyright (c) 2012年 Suning. All rights reserved.
//



/*!
 @header     ProductConsultantService
 @abstract   获取电器商品咨询数据 
 @author     wangman  
 @version    v1.1  12-09-12 
 */
#import "DataService.h"

#import "DataProductBasic.h"

/*!
 @protocol       ProductConsultantListDelegate
 @abstract       ProductConsultantService的一个代理
 @discussion     获取电器商品咨询数据回调
 */

@protocol ProductConsultantListDelegate <NSObject>

/*!
 @method       productConstantCompletedWithResult： ProductConstantList: page: errorMsg:
 @abstract     获取电器商品咨询数据完成回调 
 @param        isSucess 是否成功获取 
 @param        list 商品咨询信息列表
 @param        page 商品咨询数据页数信息
 @param        errorMsg 错误信息
 */
@optional
- (void)productConstantCompletedWithResult:(BOOL)isSucess ProductConstantList:(NSMutableArray *)list pageInfo:(SNPageInfo)pageInfo errorMsg:(NSString *)errorMsg;

@end

/*!
 @class      ProductConsultantService 
 @abstract   获取商品咨询数据
 */

@interface ProductConsultantService : DataService{
    
    HttpMessage                          *_productConstantMsg;
    
    NSMutableArray                       *_productConstantList; //商品咨询数据存储列表
        
    id <ProductConsultantListDelegate>   __weak _delegate;
    
    DataProductBasic                 *_product;
    
    SNPageInfo                         _pageInfo;
    
    
}

@property (nonatomic ,strong)DataProductBasic                 *product;

@property (nonatomic ,strong) NSMutableArray                      *productConstantList;

@property (nonatomic, weak)id<ProductConsultantListDelegate>    delegate;

@property (nonatomic, assign)SNPageInfo  pageInfo;

/*!
 @method       beginProductConstantListHttpRequest: currentPage:
 @abstract     发送商品咨询数据请求
 @param        product 商品信息
 @param        currentPage 当前页数
 */

- (void)beginProductConstantListHttpRequest:(DataProductBasic *)product currentPage:(NSInteger)currentPage ;


@end
