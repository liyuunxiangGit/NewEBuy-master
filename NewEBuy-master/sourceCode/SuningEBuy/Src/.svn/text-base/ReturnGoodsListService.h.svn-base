//
//  ReturnGoodsListService.h
//  SuningEBuy
//
//  Created by 漫 王 on 12-9-29.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

/*!
 @header    ReturnGoodsListService 
 @abstract  //获取可退货订单列表   
 @author    wangman   
 @version   v1.1   12-10-10
 @discussion liukun modify 修改逻辑漏洞
 */

#import "DataService.h"

/*!
 @protocol      ReturnGoodsListServiceDelegate
 @abstract      ReturnGoodsListService的一个代理
 @discussion    获取可退货订单列表后回调
 */

@protocol ReturnGoodsListServiceDelegate <NSObject>

@optional

/*!
 @abstract     获取可退货订单列表后回调 
 @param        isSuccess 是否成功获取数据
 @param        list 可退货订单列表数据
 @param        pageInfo 可退货订单列表数据页数信息
 @param        errrorMsg 错误信息
 */

- (void)returnGoodsListRequestCompletedWith:(BOOL)isSuccess
                             retunGoodsList:(NSArray *)list
                                   pageInfo:(SNPageInfo *)pageInfo
                                  errrorMsg:(NSString *)errrorMsg;

@end

/*!
 @class      ReturnGoodsListService  
 @abstract   获取可退货订单列表
 */
@interface ReturnGoodsListService : DataService
{    
    id<ReturnGoodsListServiceDelegate> __weak _delegate;
        
    HttpMessage          *returnGoodsListHttpMsg;
}

@property (nonatomic, weak) id<ReturnGoodsListServiceDelegate> delegate;

/*!
 @method    beginSendReturnGoodsListHttpRequest   
 @abstract  发送获取可退货订单列表请求   
 @param     currentPage 当前页数          
 */
- (void)beginSendReturnGoodsListHttpRequest:(NSInteger)currentPage;

@end
