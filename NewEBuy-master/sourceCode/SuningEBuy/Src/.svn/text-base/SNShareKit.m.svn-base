//
//  SNShareKit.m
//  SuningEBuy
//
//  Created by  on 12-9-21.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "SNShareKit.h"
#import "SNPopoverController.h"
#import "SFHFKeychainUtils.h"
#import "LoginViewController.h"
#import "SNSwitch.h"
#import <SSA_IOS/SSAIOSSNDataCollection.h>

@interface SNShareKit()
{
    UINavigationController  *_navController;
}

@property (nonatomic, strong) SNPopoverController *snPopoverController;


- (void)sendSms:(NSString *)string;

@end

/*********************************************************************/

@implementation SNShareKit

@synthesize engine = _engine;
@synthesize nickName = _nickName;
@synthesize shareTitle = _shareTitle;
@synthesize shareUrl = _shareUrl;

@synthesize snPopoverController = _snPopoverController;
@synthesize shareContent = _shareContent;
@synthesize shareImage = _shareImage;
@synthesize shareType = _shareType;
@synthesize shareImageURL = _shareImageURL;
@synthesize TCegine = _TCengine;

- (void)dealloc {
    TT_RELEASE_SAFELY(_shareImageURL);
    TT_RELEASE_SAFELY(_engine);
    TT_RELEASE_SAFELY(_nickName);
    TT_RELEASE_SAFELY(_TCengine);
    TT_RELEASE_SAFELY(_snPopoverController);
    TT_RELEASE_SAFELY(_shareImage);
    TT_RELEASE_SAFELY(_shareContent);
    TT_RELEASE_SAFELY(_shareTitle);
}

- (id)initWithNavigationController:(UINavigationController *)navigationController {
    self = [super init];
    if (self) {
        _navController = navigationController;
        _shareType = SNShareSinaWeibo;
    }
    return self;
}

- (void)setShareTitle:(NSString *)shareTitle{
    if (_shareTitle != shareTitle) {
        
        TT_RELEASE_SAFELY(_shareTitle);
        
        _shareTitle = shareTitle;
        
    }
}

- (void)setShareUrl:(NSString *)shareUrl{
    if (_shareUrl != shareUrl) {
        
        TT_RELEASE_SAFELY(_shareUrl);
        
        _shareUrl = shareUrl;
    }
}

#pragma mark -
#pragma mark lify cycle

- (void)shareWithContent:(NSString *)content image:(UIImage *)image productImageURL:(NSURL *)productImageURL
{
 
    self.shareImageURL = productImageURL;
    self.shareImage = image;
    self.shareContent = content;

//    ChooseShareWayViewController *shareController = [[ChooseShareWayViewController alloc]init];
//    shareController.delegate = self;
//    [self.snPopoverController presentWithContentViewController:shareController animated:YES];
}

- (void)shareWithContent:(NSString *)content image:(UIImage *)image
{
    self.shareImage = image;
    self.shareContent = content;
    
//    ChooseShareWayViewController *shareController = [[ChooseShareWayViewController alloc]init];
//    shareController.delegate = self;
//    [self.snPopoverController presentWithContentViewController:shareController animated:YES];
}

- (void)shareWithContent:(NSString *)content
{
    self.shareContent = content;
    
//    ChooseShareWayViewController *shareController = [[ChooseShareWayViewController alloc]init];
//    shareController.delegate = self;
//    [self.snPopoverController presentWithContentViewController:shareController animated:YES];
}

- (void)shareWithProductDto:(DataProductBasic *)productDto
{
    self.productDto = productDto;
}

- (void)didChooseShareWay:(SNShareType)shareWay
{
    self.shareType = shareWay;
    switch (shareWay) {
            //分享有礼
        case SNShareWinGift:
        {
            
             [self.engine logIn];
            
        }
            break;
            
            //云信广场
        case SNShareSNWeibo:
        {
            if ([self checkUserLoginOrNot]) {
                
//                if ([UserCenter defaultCenter].userInfoDTO.nickName.trim.length == 0 || [UserCenter defaultCenter].userInfoDTO.sex.trim.length == 0 )
//                {
//                    CardDetailViewController *message = [[CardDetailViewController alloc] initWithFisrtIn:YES];
//                    message.cardDelegate = _navController;
//                    message.nextSelector = @selector(nextStep);
//                    AuthManagerNavViewController *nav = [[AuthManagerNavViewController alloc] initWithRootViewController:message hasTopRoundCorner:YES];
//                    [_navController presentModalViewController:nav animated:YES];
//                }else{
#warning 云信分享， TODO
//                    [self SNWeiBoShareWithContent:ShareGuang];
//                }
            }
            
            break;
        }
            
            //云信好友
        case SNShareSNCloud:
        {
            if ([self checkUserLoginOrNot]) {
                
//                if ([UserCenter defaultCenter].userInfoDTO.nickName.trim.length == 0 || [UserCenter defaultCenter].userInfoDTO.sex.trim.length == 0 )
//                {
//                    CardDetailViewController *message = [[CardDetailViewController alloc] initWithFisrtIn:YES];
//                    message.cardDelegate = _navController;
//                    message.nextSelector = @selector(nextStep);
//                    AuthManagerNavViewController *nav = [[AuthManagerNavViewController alloc] initWithRootViewController:message hasTopRoundCorner:YES];
//                    [_navController presentModalViewController:nav animated:YES];
//                }else{
#warning 云信分享， TODO
//                    [self SNCloudShareWithContent];
//                }
                
            }
            
            break;
        }
            
            //新浪微博
        case SNShareSinaWeibo:
        {
             [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"121407"], nil]];
            [self.engine logIn];
            break;
        }
            
            //短信
        case SNShareSMS:
        {
             [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"121409"], nil]];
            [self sendSms:self.shareContent];
            break;
        }
            
            //腾讯微博
        case SNShareTCWeiBo:
        {
             [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"121408"], nil]];
            [self TCWeiBoShareWithContent];
            break;
        }
            
            //微信好友
        case SNShareWeiXin:
        {
             [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"121405"], nil]];
            [self sendWeiXinContentWithType:WXSceneSession];
            break;
        }
            
            //微信朋友圈
        case SNShareWeiXinFriend:
        {
             [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"121406"], nil]];
            [self sendWeiXinContentWithType:WXSceneTimeline];
        }
        default:
            break;
    }
}

//-(void)SNWeiBoShareWithContent:(SendWbType)type
//{
//    AuthManagerNavViewController *auth = (AuthManagerNavViewController *)_navController;
//    
//    [auth setNavigationBackground:2];
//    
//    WBRootViewController *vc = [[WBRootViewController alloc] initWithType:type];
//    
//    WBProductDTO *dto = [[WBProductDTO alloc] init];
//    
//    dto.productId = self.productDto.productId;
//    dto.productCode =  self.productDto.productCode;
//    dto.vendorCode =  self.productDto.shopCode;
//    dto.productName =  self.productDto.productName;
//    dto.productPriceUrl = [NSString stringWithFormat:@"%@",[ProductUtil bestPriceImageOfProductId:self.productDto.productId city:[Config currentConfig].defaultCity]];
//    
//    NSURL *url = nil;
//    
//    if ([[AppDelegate currentAppDelegate] isHeightQuailtyImg])
//    {
//        
//        url = [ProductUtil getImageUrlWithProductCode:self.productDto.productCode size: ProductImageSize160x160];
//    }
//    else{
//        
//        url = [ProductUtil getImageUrlWithProductCode:self.productDto.productCode size: ProductImageSize100x100];
//    }
//    
//    dto.productImgUrl = [NSString stringWithFormat:@"%@",url];
//    dto.productHot =  self.productDto.productFeature;
//    
//    dto.queryFlg = @"0";
//    
//    
//    NSMutableArray *array = [[NSMutableArray alloc] init];
//    [array addObject:dto];
//    [vc chooseProudcts:array];
//    
//    [_navController pushViewController:vc animated:YES];
//    
//}
//
//-(void)SNCloudShareWithContent
//{
//    AuthManagerNavViewController *auth = (AuthManagerNavViewController *)_navController;
//    
//    [auth setNavigationBackground:2];
//    
//    SelectContactViewController *vc = [[SelectContactViewController alloc] init];
//    
//    WBProductDTO *dto = [[WBProductDTO alloc] init];
//    
//    dto.productId = self.productDto.productId;
//    dto.productCode =  self.productDto.productCode;
//    dto.vendorCode =  self.productDto.shopCode;
//    dto.productName =  self.productDto.productName;
//    dto.productPriceUrl   = [NSString stringWithFormat:@"%@",[ProductUtil bestPriceImageOfProductId:self.productDto.productId city:[Config currentConfig].defaultCity]];
//    
//    NSURL *url = nil;
//    
//    if ([[AppDelegate currentAppDelegate] isHeightQuailtyImg])
//    {
//        
//        url = [ProductUtil getImageUrlWithProductCode:self.productDto.productCode size: ProductImageSize160x160];
//    }
//    else{
//        
//        url = [ProductUtil getImageUrlWithProductCode:self.productDto.productCode size: ProductImageSize100x100];
//    }
//    
//    dto.productImgUrl = [NSString stringWithFormat:@"%@",url];
//    dto.productHot =  self.productDto.special;
//    
//    dto.queryFlg = @"0";
//    
//    [vc._shareProductArray addObject:dto];
//    
//    [_navController pushViewController:vc animated:YES];
//    
//}

- (BOOL)checkUserLoginOrNot{
    
    if ([UserCenter defaultCenter].isLogined) {
        return YES;
    }else{
        LoginViewController *loginViewController = [[LoginViewController alloc] init];
        
        loginViewController.loginDelegate = self;
//        loginViewController.loginDidCancelSelector = @selector(loginCancel);
//        loginViewController.loginDidOkSelector = @selector(longOK);
        AuthManagerNavViewController *userNav = [[AuthManagerNavViewController alloc]
                                                 initWithRootViewController:loginViewController];
        
        [loginViewController setLoginOkBlock:^{
            [self didChooseShareWay:self.shareType];
        }];
        
        [_navController presentModalViewController:userNav animated:YES];
        
        TT_RELEASE_SAFELY(loginViewController);
        TT_RELEASE_SAFELY(userNav);
        return NO;
    }
}

// 微信分享
- (void)WeiXinShareWithContent{
    UIActionSheet *acSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:L(@"Cancel") destructiveButtonTitle:nil otherButtonTitles:L(@"Product_ShareToWeiXinFriends"),L(@"Product_ShareToFriends"), nil];
    acSheet.tag =1110;
    acSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [acSheet showInView:[[UIApplication sharedApplication]keyWindow]];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{

    if (actionSheet.tag == 1110) {
        if (buttonIndex == 0) {
            [self sendWeiXinContentWithType:WXSceneSession];
        }
        if (buttonIndex == 1) {
            [self sendWeiXinContentWithType:WXSceneTimeline];
        }
    }
}

-(void)sendWeiXinContentWithType:(int)scene{

    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
        
        // {{{ 微信朋友圈 分享，XZoscar，2014-05-04 19:31
        SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
        req.scene = scene;
        if (self.shareImage == nil) {
            // 文本消息
            req.bText = YES;
            req.text  = self.shareContent;
        }else {
            // 多媒体消息
            req.bText = NO;
            WXMediaMessage *message = [WXMediaMessage message];
            message.title           = self.shareTitle;
            message.description     = self.shareContent;
            if (nil == self.shareImage) {
                self.shareImage = [UIImage imageNamed:@"icon"];
            }
            [message setThumbImage:self.shareImage];
            WXWebpageObject *ext = [WXWebpageObject object];
            if (IsStrEmpty(self.shareUrl)) {
                [self setShareUrl:@"http://m.suning.com"];
            }
            ext.webpageUrl      = self.shareUrl;
            message.mediaObject = ext;
            req.message         = message;
        }
        [WXApi sendReq:req];
        // }}}
        
   }else{
        
        BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"Product_FriendTips")
                                                        message:L(@"update_now_or_not")
                                                       delegate:self
                                              cancelButtonTitle:L(@"Cancel")
                                              otherButtonTitles:L(@"Install_weixin_for_free")];
        alert.tag = 1201;
        [alert show];
    }
}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag ==1201 && buttonIndex == 1) {
        NSString *weiXinLink = @"itms-apps://itunes.apple.com/cn/app/wei-xin/id414478124?mt=8";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:weiXinLink]];
    }
}

-(void) onReq:(BaseReq*)req
{
    if([req isKindOfClass:[GetMessageFromWXReq class]])
    {
        
    }
    else if([req isKindOfClass:[ShowMessageFromWXReq class]])
    {
        
    }
    
}

-(void) onResp:(BaseResp*)resp
{
    //可以省略
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        
    }
//    else if([resp isKindOfClass:[SendAuthResp class]])
//    {
//    }
}

//腾讯微博分享

- (void)TCWeiBoShareWithContent{
    //登录
    if (![self.TCegine isAuthorizeExpired]) {
        [self loginSuccess];
    }else{
    [self.TCegine logInWithDelegate:self onSuccess:@selector(loginSuccess) onFailure:@selector(loginFail:)];
        }
}

- (void)loginSuccess{
    [_navController dismissModalViewControllerAnimated:YES];
    
     NSString *serviceName = [NSString stringWithFormat:@"TC_%@%@",kTCWeiBoOAuthConsumerKey,TCKeychainServiceNameSuffix];
   NSString*temp= [ TCWBSFHFKeychainUtils getPasswordForUsername:TCKeychainName andServiceName:serviceName error:nil];
    if (temp) {
        self.nickName = temp;
    }else{
        self.nickName = @"";
    }
    ShareContentViewController *ctrl =
    [[ShareContentViewController alloc] initWithContent:self.shareContent image:self.shareImage shareType:self.shareType];
    
    if (self.shareType == SNShareWinGift) {
        
        NSDictionary *dic = [GlobalDataCenter defaultCenter].activitySwitchMap;
        NSDictionary *shareDic = [dic objectForKey:@"sharePromote"];
        
        if (NotNilAndNull(shareDic) && [shareDic isKindOfClass:[NSDictionary class]]) {
            
             ctrl.shareContentString  = [shareDic objectForKey:@"switchDetail"];
            
            
        }
    }
    ctrl.imageURL = self.shareImageURL;
    
    ctrl.shareContentViewControllerDelegate = self;
    
    ctrl.nickName = self.nickName;
    
    AuthManagerNavViewController *nav =
    [[AuthManagerNavViewController alloc] initWithRootViewController:ctrl];
    
    [_navController presentModalViewController:nav animated:YES];
    
    TT_RELEASE_SAFELY(ctrl);
    
    TT_RELEASE_SAFELY(nav);
    
}

- (void)loginFail:(NSError *)error{
    [_navController dismissModalViewControllerAnimated:YES];
    
    NSString *errorMsg = nil;
        NSString *code = [NSString stringWithFormat:@"%@",[NSNumber numberWithInteger:[error code]]];
    NSDictionary *userInfo = [error userInfo];
    NSString *sdkCode = [userInfo objectForKey:@"TCWBSDKErrorCodeKey"];
    if ([code isEqual:@"100"] || [code isEqual:@"101"])
    {
        errorMsg = L(@"Auth_fail");
    }else if([sdkCode isEqual:@"200"])
    {
        errorMsg = L(@"Json_error");
    }else if([sdkCode isEqual:@"201"])
    {
        errorMsg = L(@"Request_error");
        
    }else if([code isEqual:@"203"]){
        errorMsg = L(@"Ahth_error");
    }else{
        errorMsg = L(@"Auth_fail");
    }
    
//    NSString *message = [[NSString alloc] initWithFormat:@"%@",[NSNumber numberWithInteger:[error code]]];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:errorMsg
                                                       delegate:self
                                              cancelButtonTitle:L(@"Ok")
                                              otherButtonTitles:nil];
    [alertView show];
    

}
//授权成功回调
- (void)onSuccessAuthorizeLogin
{
    [self TCWeiBoShareWithContent];
}

- (void)didRequestMutualList:(id)result{
    
}

#pragma mark -  get homeline callback

- (void)successCallBack:(id)result{
    
}

- (void)failureCallBack{
    
}


#pragma mark -
#pragma mark weibo

- (void)engineAlreadyLoggedIn:(WBEngine *)engine{
    
    DLog(@"engineAlreadyLoggedIn!");
    
    [_navController dismissModalViewControllerAnimated:YES];
    //从KeyChain中获取新浪用户昵称
    NSString *serviceName = [NSString stringWithFormat:@"WB_%@%@",kOAuthConsumerKey,kWBKeychainServiceNameSuffix];
    NSString *temp = [SFHFKeychainUtils getPasswordForUsername:kWBKeychainNickname andServiceName:serviceName error:nil];
    if (temp) {
        self.nickName = temp;
    }else{
        self.nickName = @"";
    }
    
    
    ShareContentViewController *ctrl = 
    [[ShareContentViewController alloc] initWithContent:self.shareContent image:self.shareImage shareType:self.shareType];
    
    if (self.shareType == SNShareWinGift) {
        
        NSDictionary *dic = [GlobalDataCenter defaultCenter].activitySwitchMap;
        NSDictionary *shareDic = [dic objectForKey:@"sharePromote_ios"];
        
        if (NotNilAndNull(shareDic) && [shareDic isKindOfClass:[NSDictionary class]]) {
            
            ctrl.shareContentString  = [shareDic objectForKey:@"switchDetail"];
            
            
        }
    }
    ctrl.imageURL = self.shareImageURL;
    
    ctrl.shareContentViewControllerDelegate = self;
    
    ctrl.nickName = self.nickName;
    
    AuthManagerNavViewController *nav = 
    [[AuthManagerNavViewController alloc] initWithRootViewController:ctrl];
    
    [_navController presentModalViewController:nav animated:YES];
    
    TT_RELEASE_SAFELY(ctrl);
    
    TT_RELEASE_SAFELY(nav);
    
}


- (void)engineDidLogIn:(WBEngine *)engine {
    
    DLog(@"engineDidLogIn!");
    
    [self engineAlreadyLoggedIn:engine];
}

- (void)engineNotAuthorized:(WBEngine *)engine{
    
    DLog(@"engineNotAuthorized");
    
    [self.engine logIn];
    
}

- (void)engineAuthorizeExpired:(WBEngine *)engine{
    
    DLog(@"engineAuthorizeExpired");
    
    [self.engine logIn];
    
}

- (void)engine:(WBEngine *)engine requestDidFailWithError:(NSError *)error{
    
    //移除小黑框
    UINavigationController *nav = (UINavigationController *)[_navController modalViewController];
    CommonViewController *VC = (CommonViewController *)[[nav viewControllers] objectAtIndex:0];
    if ([VC isKindOfClass:[CommonViewController class]]) {
        [VC removeOverFlowActivityView];
    }
    VC.navigationItem.rightBarButtonItem.enabled = YES;
    [_navController dismissModalViewControllerAnimated:YES];
    if (error) {
        NSDictionary *dic = [error userInfo];
        if (dic) {
            double error_code = [[dic objectForKey:@"error_code"]doubleValue];
            DLog(@"error_code = %@", [dic objectForKey:@"error_code"]);
            NSString *errorMsg;
            if (error_code == 20019) {
                errorMsg = L(@"SNS_Content_Send_Repeat_Error");
            }else if(error_code == 20006){
                errorMsg = L(@"SNS_Image_Size_Too_Large_Error");
            }else if(error_code == 21331){
                errorMsg = L(@"SNS_Server_Unaviliable");
            }else if(error_code == 10002){
                errorMsg = L(@"SNS_Server_Resource_Unaviliable");
            }else if(error_code == 10023){
                errorMsg = L(@"SNS_Request_Beyond_Limit");
            }else if(error_code == 20016){
                errorMsg = L(@"SNS_Share_Too_Much");
            }else if(error_code == 21321){
                errorMsg = L(@"SNS_Unaudited_Error");  
            }else{
                errorMsg = L(@"SNS_Share_Fail");
            }
            
            BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"system-info")
                                                            message:errorMsg
                                                           delegate:nil
                                                  cancelButtonTitle:L(@"Ok")
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }

}


- (void)engine:(WBEngine *)engine requestDidSucceedWithResult:(id)result{
    
    
    NSString *msg = L(@"Sina_SNS_Share_Success");
    
    if (self.shareType == SNShareWinGift) {
        
        msg = L(@"Product_SuccessParticipate");
    }
    
    BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"system-info")
                                                    message:msg
                                                   delegate:nil
                                          cancelButtonTitle:L(@"Ok")
                                          otherButtonTitles:nil];
    [alert show];
        
    [_navController dismissModalViewControllerAnimated:YES];
}

//点击分享内容页面的按钮，调用该方法，并将内容分享到新浪微博或腾讯微博
- (void)shareContentToSNS:(NSString *)content{
    
    @weakify(self);
    void (^shareWithImage)(UIImage *) = ^(UIImage *image){
        
        @strongify(self);
        if (self.shareType == SNShareSinaWeibo
            || self.shareType == SNShareWinGift) {
            [self.engine sendWeiBoWithText:content image:image];
        }else{
            [self.TCegine postPictureTweetWithFormat:@"json" content:content clientIP:nil pic:UIImageJPEGRepresentation(image, 1.0) compatibleFlag:@"0" longitude:nil andLatitude:nil parReserved:nil delegate:self onSuccess:@selector(onPostMsgSucceed:) onFailure:@selector(onPostMsgFailed:)];
        }
    };
    
    if (self.shareImage)
    {
        shareWithImage(self.shareImage);
    }
    else if (self.shareImageURL)
    {
        SNImageLoadImage(self.shareImageURL, ^(UIImage *image) {
            
            shareWithImage(image);
        });
    }
    else
    {
        shareWithImage(nil);
    }

}

- (void)onPostMsgSucceed:(NSDictionary *)dicResult{
    DLog(@"%s %@", __FUNCTION__,dicResult);
    BBAlertView *alert  = nil;
    if ([[dicResult objectForKey:@"ret"] intValue] == 0) {
        alert = [[BBAlertView alloc] initWithTitle:L(@"system-info")
                                           message:L(@"TCWeiBo_share_Success")
                                          delegate:nil
                                 cancelButtonTitle:L(@"Ok")
                                 otherButtonTitles:nil];
    }else {
        alert = [[BBAlertView alloc] initWithTitle:L(@"system-info")
                                           message:L(@"TCWeiBo_share_Fail")
                                          delegate:nil
                                 cancelButtonTitle:L(@"Ok")
                                 otherButtonTitles:nil];
    }
    [alert show];
    [_navController dismissModalViewControllerAnimated:YES];

}

- (void)onPostMsgFailed:(NSDictionary *)dicResult{
    DLog(@"error is %@",dicResult);
    //移除小黑框
    UINavigationController *nav = (UINavigationController *)[_navController modalViewController];
    CommonViewController *VC = (CommonViewController *)[[nav viewControllers] objectAtIndex:0];
    if ([VC isKindOfClass:[CommonViewController class]]) {
        [VC removeOverFlowActivityView];
    }
    VC.navigationItem.rightBarButtonItem.enabled = YES;
    [_navController dismissModalViewControllerAnimated:YES];

     BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"system-info")
                                       message:L(@"TCWeiBo_share_Fail")
                                      delegate:nil
                             cancelButtonTitle:L(@"Ok")
                             otherButtonTitles:nil];
    [alert show];

}

#pragma mark -
#pragma mark sms

//调用短信分享API
- (void)sendSms:(NSString *)string
{
	//判断是否可以发送短信
	BOOL canSendSMS = [MFMessageComposeViewController canSendText];
	DLog(@"can send SMS [%d]", canSendSMS);	
	if (canSendSMS) {
        
		MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
		picker.messageComposeDelegate = self;
        if ([picker.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) 
        {
            [picker.navigationBar setBackgroundImage:[UIImage imageNamed:kNavigationBarBackgroundImage] forBarMetrics:UIBarMetricsDefault];
            picker.navigationBar.tintColor = RGBCOLOR(101, 141, 179);
            
        }
		picker.body = string;
        [_navController presentModalViewController:picker animated:YES];
	}else
    {
        BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"system-error")
                                                        message:L(@"Device_Unsupport_Send_SMS")
                                                       delegate:nil
                                              cancelButtonTitle:L(@"Ok")
                                              otherButtonTitles:nil];
        [alert show];
    }
}

//发送短信api的回调函数
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    
    [_navController dismissModalViewControllerAnimated:YES];
	
	switch (result) {
		case MessageComposeResultCancelled:
        {
            DLog(@"cancel send message");
			break;
        }
		case MessageComposeResultSent:
        {
            DLog(@"send message success");
            BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"system-info")
                                                            message:L(@"SMS_Share_Success")
                                                           delegate:nil
                                                  cancelButtonTitle:L(@"Ok")
                                                  otherButtonTitles:nil];
            [alert show];
			break;
        }
		case MessageComposeResultFailed:
        {
			DLog(@"send message fail");
			break;
        }
		default:
			break;
	}
}
#pragma mark -
#pragma mark propertys

- (WBEngine *)engine{
    
    if (_engine == nil) {
        _engine = [[WBEngine alloc]initWithAppKey:kOAuthConsumerKey appSecret:kOAuthConsumerSecret];
        _engine.navigationController = _navController;
        _engine.delegate = self;
    }
    return _engine;
}

- (SNPopoverController *)snPopoverController
{
    if (!_snPopoverController) {
        _snPopoverController = [[SNPopoverController alloc] init];
        
        if (!_navController.tabBarController) {
            CGRect frame = _snPopoverController.blackLayerFrame;
            frame.size.height+=49;
            _snPopoverController.blackLayerFrame = frame;
        }
    }
    return _snPopoverController;
}

- (TCWBEngine *)TCegine{
    if (!_TCengine) {
        _TCengine = [[TCWBEngine alloc] initWithAppKey:kTCWeiBoOAuthConsumerKey andSecret:kTCWeiBoOAuthConsumerSecret andRedirectUrl:@"http://sale.suning.com/images/advertise/hg/20120419xsjkhd/index.html"];
        [_TCengine setRootViewController:_navController];
    }
    return _TCengine;
}

@end
