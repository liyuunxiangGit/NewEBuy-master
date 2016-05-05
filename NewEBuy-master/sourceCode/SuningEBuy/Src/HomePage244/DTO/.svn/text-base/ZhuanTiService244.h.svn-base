//
//  ZhuanTiService244.h
//  SuningEBuy
//
//  Created by zhangbeibei on 14-9-19.
//  Copyright (c) 2014年 Suning. All rights reserved.
//  促销专题service

#import "DataService.h"
#import "ZhuanTiDTO.h"

@protocol ZhuanTiServiceDelegate <NSObject>

@optional
- (void)zhuanTiServiceCompleted:(ZhuanTiDTO *)dto isSuccess:(BOOL)isSuccess errorMsg:(NSString *)errMsg;

@end

@interface ZhuanTiService244 : DataService {
    HttpMessage        *cuXiaoHttpMsg;
    HttpMessage        *lianBanHttpMsg;
    HttpMessage        *productListHttpMsg;
}

@property (nonatomic, assign) id<ZhuanTiServiceDelegate> delegate;


/**
 *  获取促销专题的信息
 *
 *  @param cuxiaoID 促销专题ID, 非空
 */
- (void)queryCuXiaoZhuanTiWithID:(NSString *)cuxiaoID;

/**
 *  获取连版信息
 *
 *  @param broadcastID 连版专题ID
 */
- (void)queryLianBanZhuanTiWithID:(NSString *)broadcastID;


/**
 *  获取商品列表信息
 *
 *  @param moduleID 模块ID
 *  @param pageNum  页号
 *  @param pageSize 每页条数
 */
- (void)queryProductListWithModuleID:(NSString *)moduleID pageNum:(int )pageNum pageSize:(int )pageSize;


- (void)cancelCuxiaoRequestAndDelegate;
- (void)cancelLianBanRequestAdnDelegate;
- (void)cancelProductListRequestAndDelegate;
@end
