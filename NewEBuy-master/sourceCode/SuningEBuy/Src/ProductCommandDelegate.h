//
//  ProductCommandDelegate.h
//  SuningEBuy
//
//  Created by  on 12-9-13.
//  Copyright (c) 2012年 Suning. All rights reserved.
//
/*!
 @header      ProductCommandDelegate
 @abstract    商品详情需要实现的协议，用于传递事件
 @author      刘坤
 @version     v1.0.001  12-9-13
 */
#import <Foundation/Foundation.h>

@class DataProductBasic;
@protocol ProductCommandDelegate <NSObject>

 @optional //add by xiewei

/*!
 @abstract      点击商品详情其中的某个图片的事件
 @param         index  点击的图片的位置
 @param         imageUrls 所有小图url的数组
 @param         bigImageUrls  所有大图url的数组
 */
- (void)didTouchImageAtIndex:(NSInteger)index 
             withSmallImages:(NSArray *)imageUrls 
                andBigImages:(NSArray *)bigImageUrls;


/*!
 @abstract      商品簇更改
 @param         productDTO  更改后的商品详情参数dto
 */
- (void)productClusterDidChange:(DataProductBasic *)productDTO;

/*!
 @abstract      检查是否登录，如果未登录则弹出登录界面
 */
- (BOOL)checkLogin;

/*!
 @abstract      加入收藏
 */
- (void)addToFavorite;

/*!
 @abstract      添加购物车
 */
- (void)addToShoppingCart;

/*!
 @abstract      一键购
 */
- (void)beginEasilyBuy;


/*!
 @abstract      默认城市改变
 */
- (void)defaultCityDidChange;


/*!
 @abstract      分享
 */
- (void)share;

/*!
 @abstract      商品是否可买
 */
- (BOOL)isProductEnabled;

/*!
 @abstract      是否可以一键购
 */
- (BOOL)isEasilyBuyEnabled;

/*!
 @abstract      去商品介绍
 */
- (void)goToProductIntroduction;


/*!
 @abstract      去商品更多信息，包括参数、装箱清单
 */
- (void)goToProductMoreInfo;


/*!
 @abstract      去评价页面
 */
- (void)goToProductAppraisal;


/*!
 @abstract      去咨询页面
 */
- (void)goToProductConsultant;


/*!
 @abstract      去晒单页面
 */
- (void)goToProductShaiDan;

/*!
 @abstract      去抢购详情
 */
- (void)goToQiangGou;

//热点展开的变化

-(void)expandChange:(BOOL)expand;
@end
