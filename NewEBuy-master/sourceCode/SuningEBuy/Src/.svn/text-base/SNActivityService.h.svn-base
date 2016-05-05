//
//  SNActivityService.h
//  SuningEBuy
//
//  Created by 家兴 王 on 12-10-22.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "DataService.h"
#import "SNActivityDTO.h"
#import "SNActivityProductDTO.h"


@protocol SNActivityServiceDelegate <NSObject>

@optional
/*!
 @abstract      获取促销商品完成之后的回调方法
 @param         isSuccess  是否请求成功
 @param         errorMsg  失败的错误信息
 @param         dto  成功时返回的抢购商品dto
 */
- (void)getActivityProductListCompletionWithResult:(BOOL)isSuccess 
                                          errorMsg:(NSString *)errorMsg 
                                  SNActivityDetail:(SNActivityDTO *)dto
                            SNActivityProductArray:(NSArray *)array
                                           pageNum:(NSInteger)pageNum
                                         pageCount:(NSInteger)pageCount
                                           actRule:(NSString *)actRule;

@end

@interface SNActivityService : DataService
{
    HttpMessage *hotSaleHttpMsg;
}
@property (nonatomic, weak) id<SNActivityServiceDelegate> delegate;

/*!
 @abstract      开始获取促销商品详情
 */
- (void)beginGetActivityProdcuctDetailList:(NSString *)activityId
                               currentPage:(NSInteger)currentPage; 


@end
