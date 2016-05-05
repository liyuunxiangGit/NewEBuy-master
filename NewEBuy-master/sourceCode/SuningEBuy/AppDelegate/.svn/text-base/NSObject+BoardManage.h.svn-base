//
//  NSObject+BoardManage.h
//  SuningEBuy
//
//  Created by  liukun on 13-2-21.
//  Copyright (c) 2013年 Suning. All rights reserved.
//
//  本类别宗旨： 通过方法注入NSObject的方法，是的应用程序可以在任何地方很方便的查询或跳转页面

#import <Foundation/Foundation.h>

@class HomeScrollViewController;
//@class SearchViewController;
@class NewSearchViewController;
@class ShopCartV2ViewController;
@class MyEbuyViewController;
@class MoreViewController;
@class CategoryViewController;
@class HomePageControlView;


@interface NSObject (BoardManage)

//应用程序代理
- (AppDelegate *)appDelegate;

//当前用户
- (UserInfoDTO *)user;
- (BOOL)isEppActive;
- (double)eppBalance;

//几大跟视图控制器
- (HomeScrollViewController *)homeBoard;
- (HomePageControlView *)homeBoardNew;
- (NewSearchViewController *)searchBoard;
- (ShopCartV2ViewController *)shoppingCartBoard;
- (MyEbuyViewController *)myEbuyBoard;
- (CategoryViewController *)categoryBoard;


//常用跳转,可再增加
//跳转首页
- (void)jumpToHomeBoard;

- (void)jumpToOrderCenterBoard:(SNBasicBlock)callback;
//跳转到订单中心
- (void)jumpToOrderCenterBoard;
//去激活易付宝
- (void)jumpToActivityEfubao;
//跳转到我的云钻
- (void)jumpToMyIntegal;

@end
