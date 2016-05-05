//
//  SearchCityListViewController.h
//  SuningEBuy
//
//  Created by 芳奎 赵 on 12-7-2.
//  Copyright (c) 2012年 苏宁. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HotelOrderBaseViewController.h"

@interface SearchCityListViewController :  HotelOrderBaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSDictionary        *cities;                //城市字典
    NSMutableArray      *keys;                  //key数组
    id                  __weak delegate;               //代理
    UITableView         *tableView_;            //个性化tableview
    UINavigationBar     *navigationBar_;        //导航栏
    UIImageView         *backgroundImageView_;  //背景图
}
@property (nonatomic, strong) UIView  *bottomView;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UIButton *yiGouBtn;

@property (nonatomic, strong) UITableView       *tableView;             //个性化tableview
@property (nonatomic, strong) NSDictionary      *cities;                //城市字典
@property (nonatomic, strong) NSMutableArray    *keys;                  //key数组
@property (nonatomic, weak) id delegate;                              //代理

- (void)pressReturn:(id)sender;//返回按钮出发事件
-(void)getCityFromPlist;//获取城市

@end

@protocol SearchHotelCityListViewControllerProtocol
- (void) citySelectionUpdate:(NSString*)selectedCity andViewController:(id)controller;
- (NSString*) getDefaultCity;
@end


