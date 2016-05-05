//
//  SNShareKit.h
//  SuningEBuy
//
//  Created by  on 12-9-21.
//  Copyright (c) 2012年 Suning. All rights reserved.
//
/*!
 @header      SNShareKit
 @abstract    分享控制器
 @author      刘坤
 @version     v1.0.001  12-9-21
 */

//分享到新浪微博的Key和Secret
//苏宁易购iphone应用账号
#define kOAuthConsumerKey	 			@"2344735905"		
#define kOAuthConsumerSecret			@"6ba4294648fea64053ec1069c1e15ec4"
//caowei测试账号
//#define kOAuthConsumerKey				@"53051737"		
//#define kOAuthConsumerSecret			@"bf036c7bea8e0a54316881570b9d7ff2"
//分享到腾讯微博的Key和Secret
#define kTCWeiBoOAuthConsumerKey	 			@"801327664"
#define kTCWeiBoOAuthConsumerSecret			@"cfb9002ac7caa0c41ed9668bc1357bb9"


#define kWBKeychainNickname             @"WeiBoNickname"
#define kWBKeychainServiceNameSuffix    @"_WeiBoServiceName"

#define TCKeychainServiceNameSuffix    @"_WeiBoServiceName"
#define TCKeychainName                 @"WeiBoName"


#import <Foundation/Foundation.h>
#import "WBEngine.h"
#import <MessageUI/MessageUI.h>

#import "ChooseShareWayViewController.h"
#import "ShareContentViewController.h"
#import "TCWBEngine.h"
#import "TCWBSFHFKeychainUtils.h"
#import "WXApi.h"


#import "DataProductBasic.h"
#import "ChooseShareWayView.h"

@interface SNShareKit : NSObject<WBEngineDelegate, ChooseShareWayDelegate, MFMessageComposeViewControllerDelegate, ShareContentViewControllerDelegate,WXApiDelegate,UIActionSheetDelegate,BBAlertViewDelegate>
{
    WBEngine            *_engine;
    TCWBEngine       *_TCengine;

}

/*! 分享微博的主要工具类，包括登录，注销微博，分享文字图片 */
@property (nonatomic, readonly, strong) WBEngine *engine;

/*! 新浪微博昵称 */
@property (nonatomic, copy)   NSString *nickName;
@property (nonatomic, copy) NSString *shareTitle;
@property (nonatomic, copy) NSString *shareUrl;
@property (nonatomic, copy) NSString *shareContent;
@property (nonatomic, strong) UIImage *shareImage;
@property (nonatomic, strong) NSURL *shareImageURL;


@property (nonatomic, assign) SNShareType shareType;
@property (nonatomic, readonly,strong) TCWBEngine *TCegine;

@property (nonatomic, strong) DataProductBasic *productDto;

/*! @abstract 初始化方法 */
- (id)initWithNavigationController:(UINavigationController *)navigationController;


/*!
 @abstract      分享
 @param         content  要分享的话
 @param         image    要分享的图片
*/

- (void)didChooseShareWay:(SNShareType)shareWay;
- (void)setShareTitle:(NSString *)shareTitle;
- (void)setShareUrl:(NSString *)shareUrl;
- (void)shareWithContent:(NSString *)content image:(UIImage *)image productImageURL:(NSURL *)productImageURL;
- (void)shareWithContent:(NSString *)content image:(UIImage *)image;
- (void)shareWithContent:(NSString *)content;
- (void)shareWithProductDto:(DataProductBasic *)productDto;

- (void) TCWeiBoShareWithContent;
- (void) WeiXinShareWithContent;
- (void) sendWeiXinContentWithType:(int)scene;

//-(void)SNWeiBoShareWithContent:(SendWbType)type;
//- (void)SNCloudShareWithContent;
@end
