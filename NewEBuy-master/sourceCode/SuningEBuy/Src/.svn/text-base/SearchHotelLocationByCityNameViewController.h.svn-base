//
//  SearchHotelLocationByCityNameViewController.h
//  SuningEBuy
//
//  Created by 芳奎 赵 on 12-7-4.
//  Copyright (c) 2012年 苏宁. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotelSARDTO.h"
#import "HotelBusinessCircleDTO.h"
#import "HotelOrderBaseViewController.h"
#import "HotelLocationService.h"


@interface SearchHotelLocationByCityNameViewController : HotelOrderBaseViewController<UITableViewDataSource,UITableViewDelegate,HotelLocationDelegate>
{
    ASIFormDataRequest  *locationASIHttpRequest; //位置列表请求
    NSString            *cityName_;              //用于承接上级页面（酒店搜索页面）传递的城市名参数
    id                  delegate;               //代理
    UITableView         *tableView_;            //table视图
    UINavigationBar     *navigationBar_;        //导航栏
    UIImageView         *backgroundImageView_;  //背景图
    
}
@property (nonatomic, strong) UIView  *bottomView;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UIButton *yiGouBtn;

@property (nonatomic, strong) UITableView     *tableView;          //个性化tableview
//@property (nonatomic, retain) UINavigationBar *navigationBar;      //导航栏
@property (nonatomic, strong) UIImageView     *backgroundImageView;//背景图
@property (nonatomic, weak) id              delegate;            //代理
@property (nonatomic, strong) NSMutableArray  *businessCircleList; //联想词列表
@property (nonatomic, strong) NSMutableArray  *SARList;            //行政区列表
@property (nonatomic, strong) NSString        *cityName;           //城市名称
@property (nonatomic, strong) UIButton* leftBtn;                   //商业圈button
@property (nonatomic, strong) UIButton* rightBtn;                  //行政区button
@property (nonatomic, assign) NSInteger       selectIndex;
@property (nonatomic, strong)  UIView         *headView;

@property (nonatomic,strong) HotelLocationService *locationService;

//- (void)pressReturn:(id)sender;
//-(void)getCityFromPlist;
- (void)sendlocationHttpRequest;                                   //获取位置请求
- (id)initWithCityName:(NSString *) cityName;                      //带参初始化方法

@end


@protocol SearchHotelLocationViewControllerProtocol
- (void) locationID:(NSString*)locationID andLocationName:(NSString*)locationName;

@end
