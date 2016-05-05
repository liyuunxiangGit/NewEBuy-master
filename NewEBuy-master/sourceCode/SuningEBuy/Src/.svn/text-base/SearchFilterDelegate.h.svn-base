//
//  SearchFilterDelegate.h
//  SuningEBuy
//
//  Created by 刘坤 on 12-9-4.
//  Copyright (c) 2012年 Suning. All rights reserved.
//
/*!
 @header      SearchFilterDelegate
 @abstract    搜索筛选的代理协议
 @author      刘坤
 @version     v1.0.001  12-9-4
 */
#import <Foundation/Foundation.h>

typedef void(^SearchFilterBlock)(NSArray *);
/*!
 @protocol       SearchFilterDelegate
 @abstract       搜索筛选的代理协议
 @discussion     定义了类目、筛选两种的回调代理方法，城市筛选通过通知进行，故不在这里定义
 */
@protocol SearchFilterDelegate <NSObject>

@optional
- (void)catePickDidOk;

- (void)filterPickDidOk;

- (void)filterPickDidOkWithRefreshCompleteCallBack:(SearchFilterBlock)callBack;

- (void)resetCatesAndFilters;//点击了筛选的重置按钮

- (void)allFilteOk;//点击了筛选的确定按钮

- (void)popToCata; //分类进搜索，筛选点分类时退到分类标签页
@end
