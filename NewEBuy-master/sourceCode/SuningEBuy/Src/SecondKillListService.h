//
//  SecondKillListService.h
//  SuningEBuy
//
//  Created by cui zl on 13-2-26.
//  Copyright (c) 2013年 Suning. All rights reserved.
//
/*!
 @header      SecondKillListService
 @abstract    获取兄弟秒杀列表的service
 @author      cuizl
 @version     v1.0  13-02-25
 */

#import <Foundation/Foundation.h>
#import "PanicPurchaseDTO.h"

@protocol SecondKillListDelegate <NSObject>

@optional
/*!
 @abstract      获取兄弟秒杀列表完成之后的回调方法
 @param         isSuccess  是否请求成功
 @param         errorMsg  失败的错误信息
 @param         list  成功时返回的兄弟秒杀商品列表
 */
- (void)getSecondKillListCompletionWithResult:(BOOL)isSuccess
                                     errorMsg:(NSString *)errorMsg
                               secondKillList:(NSArray *)list;
@end

@interface SecondKillListService : DataService
{
    HttpMessage *secondKillListHttpMsg;
}
@property (nonatomic, weak) id<SecondKillListDelegate> delegate;

-(void)beginSecondKillList;



@end
