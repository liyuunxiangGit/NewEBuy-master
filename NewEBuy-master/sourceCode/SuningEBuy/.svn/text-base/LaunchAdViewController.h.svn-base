//
//  LaunchAdViewController.h
//  SuningEBuy
//
//  Created by  liukun on 13-3-14.
//  Copyright (c) 2013年 Suning. All rights reserved.
//
/*!
 @header      LaunchAdViewController.h
 @abstract    广告页
 @author      刘坤
 @version     13-3-15 
 @discussion  在应用启动时加载，直接取本地图片，如果可以取到，就展示，未取到图片，就不展示该页面
              1、使用SNFileCache存储url, key为 sn.launch.ad
              2、需要在GetSwitchListCommand里加载完成时，默认加载该图片
 */

#import <UIKit/UIKit.h>



#import "DMOrderService.h"

@interface LaunchAdViewController : UIViewController<EGOImageViewExDelegate,DMOrderServiceDelegate>
{
    SNBasicBlock dimissBlock;
    
    BOOL needToSpecailView;
}


@property (nonatomic, strong) UIImageView *adImageView;
@property (nonatomic, strong) DMOrderService *DMService;

@property (nonatomic, strong) EGOImageViewEx *dmImageView;

@property (nonatomic,strong)DMOrderResultDTO *dmResultDto;

@property (nonatomic)BOOL isPush;

@property (nonatomic, strong) NSDictionary *dmInfoDict;


- (void)setDismissBlock:(SNBasicBlock)block;
- (void)showOnWindow:(UIWindow *)window;
-(void)requestDMorder;
- (void)dismissAd;

@end
