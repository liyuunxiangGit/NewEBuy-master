//
//  HomePageService244.h
//  SuningEBuy
//
//  Created by zhangbeibei on 14-9-18.
//  Copyright (c) 2014年 Suning. All rights reserved.
//  获取首页数据的Service

@class HomePageService244;
@protocol HomePageService244Delegate <NSObject>

@optional
- (void)homePageServiceComplete:(HomePageService244 *)service isSuccess:(BOOL )isSuccess;

- (void)homeVersionServiceComplete:(HomePageService244 *)service homeDataFlag:(BOOL )dataFlag homeSwitchFlag:(BOOL )switchFlag;

@end

#import "DataService.h"

@interface HomePageService244 : DataService {
    HttpMessage        *homeDataHttpMsg;
    HttpMessage        *homeDataVersionHttpMsg;
    HttpMessage        *secondPageHttpMsg;
}

//页面名称
@property (nonatomic, copy)         NSString        *pageName;

//楼层列表数据
@property (nonatomic, strong)       NSMutableArray  *floorArray;

@property (nonatomic, assign) id<HomePageService244Delegate> delegate;



/**
 *  获取首页楼层数据
 *  接口只需要terminalID、channnelID、versionNumber
 *  方法内部自动获取这些参数
 */
- (void)queryHomePageData;


/**
 *  获取客户端首页版本号信息
 *
 */
- (void)queryHomeVersion;


/**
 *  获取聚合页信息(二级页面)
 *
 *  @param pageID 聚合页ID
 */
- (void)querySecondPageWithPageID:(NSString *)pageID;


/**
 *  取消已经发送的聚合页的请求
 */
- (void)cancelSecondPageRequest;

@end




