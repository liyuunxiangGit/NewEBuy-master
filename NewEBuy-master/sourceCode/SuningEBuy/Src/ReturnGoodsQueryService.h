//
//  ReturnGoodsQueryService.h
//  SuningEBuy
//
//  Created by 漫 王 on 12-9-28.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

/*!
 @header     ReturnGoodsQueryService
 @abstract   获取已退货订单列表  
 @author     wangman 
 @version    v1.1  12-10-10
 */

#import "DataService.h"
#import "ReturnGoodsPrepareDTO.h"
#import "ReturnGoodsQueryDTO.h"
#import "CShopReturnGoodsDTO.h"

/*!
 @protocol      ReturnGoodsQueryServiceDelegate
 @abstract      ReturnGoodsQueryService的一个代理
 @discussion    获取已退货订单列表后回调
 */

@protocol ReturnGoodsQueryServiceDelegate <NSObject>

@optional

/*!
 @method   returnGoodsQueryHttpRequestCompletedWith: returnGoodList: page: errorMsg:    
 @abstract 获取已退货订单列表后回调   
 @param    isSucess 是否获取成功    
 @param    list 可退货订单列表
 @param    page 可退货订单列表页数信息
 @param    errorMsg 错误信息
 */
- (void)returnGoodsQueryHttpRequestCompletedWith:(BOOL)isSucess returnGoodList:(NSMutableArray *)list pageInfo:(SNPageInfo )pageInfo
                               returnexpresslist:(NSMutableArray *)expresslist
                                        errorMsg:(NSString*)errorMsg;

- (void)returnGoodsCompletedWith:(BOOL)isSuccess
                             errorMsg:(NSString *)errorMsg;
                                  



@end

/*!
 @class     ReturnGoodsQueryService 
 @abstract  获取可退货订单列表 
 */
@interface ReturnGoodsQueryService : DataService
{
    
    HttpMessage       *_returnGoodsQueryHttpMsg;
    
    NSMutableArray    *_returnGoodList;
    NSMutableArray    *_returnexpresslist;
    
    NSMutableArray    *_page;
    
    id  <ReturnGoodsQueryServiceDelegate> __weak _delegate;
    
    SNPageInfo          _pageInfo;
    
}

@property (nonatomic, strong)NSMutableArray    *returnGoodList;
@property (nonatomic, strong)NSMutableArray    *returnexpresslist;
 
@property (nonatomic, weak)id                <ReturnGoodsQueryServiceDelegate>delegate;

@property (nonatomic, assign)SNPageInfo pageInfo;
/*!
 @method    beginSendReturnGoodsQueryHttpRequest    
 @abstract  发送获取可退货订单列表请求    
 @param     currentPage 当前页数   
 */
- (void)beginSendReturnGoodsQueryHttpRequest:(NSInteger)currentPage;

- (void)confirmReturnGoods:(CShopReturnGoodsDTO *)dto
              orderItemsId:(NSString *)orderItemsId
                expressNum:(NSString *)expressNum
               companyName:(NSString *)companyName
             expressDetail:(NSString *)expressDetail;

/*!
 @method    returnGoodsQueryOK   
 @abstract  获取可退货订单列表后处理    
 @param     isSuccess 是否成功获取    
 */
- (void)returnGoodsQueryOK:(BOOL)isSuccess;
- (void)returnGoods:(BOOL)isSuccess;

//
//-(void)returnGoodsConfirmOK:(BOOL)isSuccess confirmDto:(ReturnGoodsPrepareDTO *)dto;

- (void)beginSendReturnGoodsQueryHttpRequest:(NSInteger)currentPage storeId:(NSString*)aStoreId;

@end
