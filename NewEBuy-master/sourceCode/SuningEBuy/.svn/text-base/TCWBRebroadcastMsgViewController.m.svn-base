//
//  TCWBRebroadcastMsgViewController.m
//  TCWeiBoSDKDemo
//
//  Created by zzz on 8/24/12.
//  Copyright (c) 2012 bysft. All rights reserved.
//

#import "TCWBRebroadcastMsgViewController.h"
#import "TCWBTopicViewController.h"
#import "TCWBFriendViewController.h"
#import "TCWBEngine.h"
#import "TCWBGlobalUtil.h"
#import "UIImage+rotate.h"
#import "key.h"
#import "FileStreame.h"
#import "Reachability.h"
#import "UINoteView.h"
#import "RegexKitLite.h"

static float		g_keyboardFrameHeightLastTime = 216;		// 默认初始键盘高度


#define TAG_LABEL_TITLE   11
#define TAG_NOTEVIEW      12

#define NOTEVIEW_WIDTH   160
#define NOTEVIEW_HEIGHT  160


@implementation TCWBRebroadcastMsgViewController
@synthesize textView;
@synthesize viewMidBase;
@synthesize viewUpBase;
@synthesize viewDownBase;
@synthesize viewWordNum;
@synthesize weiboEngine;
@synthesize myDict;
@synthesize imagePickerController;
@synthesize myLocation;
@synthesize viewImage;
@synthesize ctrlimageView;
@synthesize curSelectedRange;
@synthesize loadingView;

- (void)dealloc {
    
    imageViewPlaceBtn = nil;
    locationManager.delegate = nil;
    [locationManager stopUpdatingHeading];
    g_keyboardFrameHeightLastTime = 216;
    [weiboEngine cancelSpecifiedDelegateAllRequest:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (id)initWithEngine:(TCWBEngine *)engine parameter:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        self.weiboEngine = engine;
        self.myDict = [NSDictionary dictionaryWithDictionary:dict];
        
        nMutualIndex = 0;
        nRecentHtIndex = 1;
    }
     
    return self;
}


#pragma mark - View lifecycle
/*
 
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView
 {
 }
 
 */

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    curSelectedRange.location = 0;
    [self.navigationController setNavigationBarHidden:YES];
    self.view.backgroundColor = [UIColor whiteColor];


    // 导航条
    UIImageView *imageViewNavBar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"composeupbg.png"]];
    [imageViewNavBar setFrame:CGRectMake(0, 0, self.view.frame.size.width, NavBarHeight)];
    [imageViewNavBar setUserInteractionEnabled:YES];
    [self.view addSubview:imageViewNavBar];
    

    
    // 标题
    UILabel *labelTitle = [[UILabel alloc] init];
    [labelTitle setTag:TAG_LABEL_TITLE];
    
    [labelTitle setBackgroundColor:[UIColor clearColor]];
    [labelTitle setFont:[UIFont systemFontOfSize:17]];
    [labelTitle setTextColor:[UIColor whiteColor]];
    [labelTitle setTextAlignment:UITextAlignmentCenter];
    
    NSBundle *main = [NSBundle mainBundle];
    NSString *strRebroadcast = [main localizedStringForKey:kLanguageRebroadcast value:nil table:kTCWBTable];    
    
    [labelTitle setText:strRebroadcast];
    
    CGSize szTitle = [labelTitle.text sizeWithFont:labelTitle.font];
    [labelTitle setFrame:CGRectMake((320 - szTitle.width)/2, (44 - szTitle.height)/2, szTitle.width, szTitle.height)];
    
    [self.view addSubview:labelTitle];
    
    
    // 取消
    UIButton *buttonLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonLeft.frame = CGRectMake(5, 5.5, 52, 33);
	buttonLeft.titleLabel.font = [UIFont systemFontOfSize:14];
    
    NSString *strCancel = [main localizedStringForKey:KLanguageCancel value:nil table:kTCWBTable];
    [buttonLeft setTitle:strCancel forState:UIControlStateNormal];
    
    [buttonLeft setBackgroundImage:[UIImage imageNamed:@"composequxiaobtn.png"] forState:UIControlStateNormal];
	[buttonLeft addTarget:self action:@selector(cancelCompose:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonLeft];
   
    // 发送
    NSString *strSend = [main localizedStringForKey:kLanguageSend value:nil table:kTCWBTable];
    UIButton *buttonRight = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonRight.frame = CGRectMake(263, 5, 52, 33);
    buttonRight.tag = ButtonRightTag;
	[buttonRight setTitle:strSend forState:UIControlStateNormal];
    buttonRight.titleLabel.font = [UIFont systemFontOfSize:14];
	[buttonRight setBackgroundImage:[UIImage imageNamed:@"composesentbtn.png"] forState:UIControlStateNormal];
    [buttonRight setBackgroundImage:[UIImage imageNamed:@"composesentbtnhover.png"] forState:UIControlStateHighlighted];
    [buttonRight addTarget:self action:@selector(DoneCompose:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonRight];
    
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0) {
        // 上方背景视图
        viewUpBase = [[UIView alloc] initWithFrame:CGRectMake(0, NavBarHeight, self.view.frame.size.width, 126 + AltituteScrent)];
        textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 320, 122 + AltituteScrent)];
        // 中间背景视图
        viewMidBase = [[UIView alloc] initWithFrame:CGRectMake(0, 126 + NavBarHeight + AltituteScrent, 320, 59)];
        //  底部底层背景
        viewDownBase = [[UIView alloc] initWithFrame:CGRectMake(0, 200 + NavBarHeight + AltituteScrent, self.view.frame.size.width, 216)];		// 默认键盘高度216

    }else {
        // 上方背景视图
        viewUpBase = [[UIView alloc] initWithFrame:CGRectMake(0, NavBarHeight, self.view.frame.size.width, 126)];
        textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 320, 122)];
        // 中间背景视图
        viewMidBase = [[UIView alloc] initWithFrame:CGRectMake(0, 126 + NavBarHeight, 320, 59)];
        //  底部底层背景
        viewDownBase = [[UIView alloc] initWithFrame:CGRectMake(0, 200 + NavBarHeight, self.view.frame.size.width, 216)];		// 默认键盘高度216


    }   
    	// 文本输入框默认高度141
    [self.view addSubview:viewUpBase];
    [self.view addSubview:viewMidBase];
    
	textView.font = [UIFont systemFontOfSize:18];
	textView.delegate = self;
    textView.tag = 100;
    textView.text = [self.myDict objectForKey:@"content"];
    curSelectedRange.location = textView.text.length;
    curSelectedRange.length = 0;
    [viewUpBase addSubview:textView];
    
    // 中间放按钮视图
	imageViewPlaceBtn = [[UIImageView alloc] initWithFrame:CGRectMake(0, 30, 320, 45)];
	imageViewPlaceBtn.image = [UIImage imageNamed:@"composeiconbg.png"];
	[viewMidBase addSubview:imageViewPlaceBtn];
	imageViewPlaceBtn.userInteractionEnabled = YES;
    
    // 字数统计　
	viewWordNum = [[WordsLeftView alloc] initWithFrame:CGRectMake(0, 15, self.view.frame.size.width, 17)];
	[imageViewPlaceBtn addSubview:viewWordNum];
	viewWordNum.wordsNum = MaxInputWords;
    
    viewDownBase.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"composeEmotionBg"]];
	[self.view addSubview:viewDownBase];
   
    // 照相机
    UIButton *btnPhotoFromCamera = [UIButton buttonWithType:UIButtonTypeCustom];
	[btnPhotoFromCamera setImage:[UIImage imageNamed:@"composeCameraEnable.png"] forState:UIControlStateNormal];
	[btnPhotoFromCamera setImage:[UIImage imageNamed:@"composeCamerahover.png"] forState:UIControlStateHighlighted];
	btnPhotoFromCamera.frame =  PhotoFromCameraBtnFrame;
    btnPhotoFromCamera.tag = PhotoFromCameraBtnTag;
	[btnPhotoFromCamera addTarget:self action:@selector(pickImageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
	[viewMidBase addSubview:btnPhotoFromCamera];
    
    // 定位
    UIButton *btnPosition = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnPosition setFrame:PositionBtnFrame];
    [btnPosition setTag:PositionBtnTag];
    [btnPosition setImage:[UIImage imageNamed:@"composedingwei.png"] forState:UIControlStateNormal];
    [btnPosition addTarget:self action:@selector(positionBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    bShowPosition = YES;
    [viewMidBase addSubview:btnPosition];
    
    // 好友
    UIButton *btnFriendsSearch = [UIButton buttonWithType:UIButtonTypeCustom];
	[btnFriendsSearch setImage:[UIImage imageNamed:@"composeAt.png"] forState:UIControlStateNormal];
	[btnFriendsSearch setImage:[UIImage imageNamed:@"composeAthover.png"] forState:UIControlStateHighlighted];
	btnFriendsSearch.frame = FriendsearchBtnFrame;			// 23*22
	btnFriendsSearch.tag = FriendSearchBtnTag;
	[btnFriendsSearch addTarget:self action:@selector(friendSearchBtnClicked) forControlEvents:UIControlEventTouchUpInside];
	[viewMidBase addSubview:btnFriendsSearch];
    
	// 话题
	UIButton *btnTopicSearch = [UIButton buttonWithType:UIButtonTypeCustom];
	[btnTopicSearch setImage:[UIImage imageNamed:@"compose#.png"] forState:UIControlStateNormal];
	[btnTopicSearch setImage:[UIImage imageNamed:@"compose#hover.png"] forState:UIControlStateHighlighted];
	btnTopicSearch.frame = TopicSearchBtnFrame;
	btnTopicSearch.tag = TopicSearchBtnTag;
	[btnTopicSearch addTarget:self action:@selector(topicSearchBtnClicked) forControlEvents:UIControlEventTouchUpInside];
	[viewMidBase addSubview:btnTopicSearch];
    
    // loading视图
    loadingView = [[UIActivityIndicatorView alloc] initWithFrame:PositionBtnFrame];
    loadingView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    loadingView.hidden = YES;
    [viewMidBase addSubview:loadingView];

    
    // 图片缩略图
    imageReadyPost = [self.myDict objectForKey:@"image"];
    if (imageReadyPost) {
        viewImage = [[AttachedPictureView alloc]initWithFrame:CGRectMake(5 - 43, -2, 43, 32)];
        viewImage.myAttachedPictureViewDelegate = self;
        [viewMidBase addSubview:viewImage];
        [imageReadyPost rotateImage:imageReadyPost.imageOrientation];
        [viewImage setAttachedImage:imageReadyPost];
        viewImage.backgroundColor = [UIColor clearColor];
        
        CATransition *animation = [CATransition animation];
        animation.delegate = self;
        animation.duration = 0.7;
        animation.timingFunction = UIViewAnimationCurveEaseInOut;
        animation.type = kCATransitionPush;
        viewImage.frame = CGRectMake(5, -2, 43, 32);
        [[viewImage layer] addAnimation:animation forKey:@"animation"];
    }
        
    UINoteView *noteview = [[UINoteView alloc] initWithFrame:CGRectMake((320 - NOTEVIEW_WIDTH)/2, 50, NOTEVIEW_WIDTH, NOTEVIEW_HEIGHT)];
    [noteview setTag:TAG_NOTEVIEW];
    
    [self.view addSubview:noteview];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

    
    // 定位
    locationManager = [[CLLocationManager alloc] init];
    [locationManager setDelegate:self];
    
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [locationManager setDistanceFilter:1000.0f];
    
    
    NSString *strName = [weiboEngine name];
    NSString *strOpenId = [weiboEngine openId];
    
    // 请求 互听好友
    [weiboEngine getFriendMutualListWithFormat:kJson 
                                          name:strName 
                                       fopenID:strOpenId 
                                        reqNum:10
                                    startIndex:nMutualIndex ++
                                       andInstall:0 
                                   parReserved:nil 
                                      delegate:self 
                                     onSuccess:@selector(didRequestMutualList:) 
                                     onFailure:@selector(failedRequestMutualList:)];
    
    // 请求 最近联系人
    [weiboEngine getFriendIntimateListWithFormat:kJson 
                                      andReqNum:20
                                 parReserved:nil
                                    delegate:self 
                                   onSuccess:@selector(didRequestIntimateFriend:) 
                                   onFailure:@selector(failedRequestIntimateFriend:)]; 
    
    // 最近使用话题
    [weiboEngine gethtRecentUsedWithFormat:kJson
                                    reqNum:kRecentHtReqNum
                                      page:nRecentHtIndex ++
                               andSortType:0
                               parReserved:nil
                                  delegate:self
                                 onSuccess:@selector(didRequestTopic:)
                                 onFailure:@selector(failedRequestTopic:)]; 
    
     

    
    // 检测网络
    if (([[Reachability reachabilityForLocalWiFi] currentReachabilityStatus] == NotReachable) 
		&& ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable)){
        
        NSString *strNote = @"网络请求失败,稍候请重试";
        [self performSelector:@selector(showNoteView:) withObject:strNote afterDelay:1.5];
    }

}


// 键盘即将消失时调用
- (void)keyboardWillHide:(NSNotification *)notification {
	NSDictionary	*userInfo = [notification userInfo];
	CGRect			bounds;
	[(NSValue *)[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&bounds];
	NSNumber *height = nil; 
	height = [[NSNumber alloc] initWithFloat:bounds.size.height - g_keyboardFrameHeightLastTime];
	g_keyboardFrameHeightLastTime = bounds.size.height;		// 保存上一次键盘高度
	if ([height intValue] != 0) {
		[self performSelectorOnMainThread:@selector(scrollIfNeeded:) withObject:height waitUntilDone:NO];
	}
}

// 键盘出现时调用
- (void) keyboardWasShown:(NSNotification *) notification {
    [self keyboardWillHide:notification];
}

// 键盘中英文切换时，为防止视图被遮挡而视图上下移动
- (void)scrollIfNeeded:(NSNumber *)boundsHeight {
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.3];
	viewUpBase.frame = CGRectMake(viewUpBase.frame.origin.x, viewUpBase.frame.origin.y  ,
								  viewUpBase.frame.size.width, viewUpBase.frame.size.height - [boundsHeight floatValue]);
	textView.frame = CGRectMake(textView.frame.origin.x, textView.frame.origin.y  ,
                                textView.frame.size.width, textView.frame.size.height - [boundsHeight floatValue]);
	viewMidBase.frame = CGRectMake(viewMidBase.frame.origin.x, viewMidBase.frame.origin.y - [boundsHeight floatValue] ,
								   viewMidBase.frame.size.width, viewMidBase.frame.size.height );
    
	[UIView commitAnimations];
    
}

// 取消
- (void)cancelCompose:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

// 完成编译，发表
- (void)DoneCompose:(id)sender {
    UIButton *button = (UIButton *)sender;
    button.enabled = NO;
    DLog(@"super DoneCompose!");
    DLog(@"%@",textView.text);
    int textUTF8StrLength = [self calcStrWordCount:textView.text];
    // 文字内容大于140字，提示不能发送
    if (textUTF8StrLength > MaxInputWords) {
        UIActionSheet *menu = [[UIActionSheet alloc] initWithTitle: @"抱歉, 每条广播字数上限为140字!"
														  delegate:self cancelButtonTitle:@"取消" 
											destructiveButtonTitle:@"清除超出文字" otherButtonTitles:nil, nil];
		menu.actionSheetStyle = UIActionSheetStyleDefault;
		menu.destructiveButtonIndex = 1;
		menu.tag = DoneComposeActionSheetTag;
		[menu showInView:self.view];
        
    }else {         // 发送内容时，如果定位打开，先获取经纬度。未打开定位，经纬度传空值
         CLLocationCoordinate2D coordinate = [myLocation coordinate];
        NSString *strLongitude = [NSString stringWithFormat:@"%f",coordinate.longitude];
        NSString *strLatitude = [NSString stringWithFormat:@"%f",coordinate.latitude];
        if ([strLongitude intValue] == 0 && [strLatitude intValue] == 0) {
            strLongitude = nil;
            strLatitude = nil;
        }
        // 发送内容不包含图片，直接发送文字
        if (imageReadyPost == nil && bImageLocal == NO) {
            [self dismissModalViewControllerAnimated:YES];
            id delegate = ((DelegateObject *)[self.myDict objectForKey:@"requestDelegate"]).delegate;
            SEL postStartCallback = NSSelectorFromString([self.myDict objectForKey:@"postStartCallback"]);
            if ([delegate respondsToSelector:postStartCallback]) {
                SuppressPerformSelectorLeakWarning
                ([delegate performSelector:postStartCallback]);
            }
            NSMutableDictionary *dicAppFrom = [NSMutableDictionary dictionaryWithObject:@"ios-sdk-2.0-publish" forKey:@"appfrom"];
            [self.weiboEngine postTextTweetWithFormat:@"json" 
                                                 content:textView.text 
                                                clientIP:nil 
                                               longitude:strLongitude 
                                             andLatitude:strLatitude
                                             parReserved:dicAppFrom
                                                delegate:delegate
                                               onSuccess:NSSelectorFromString([self.myDict objectForKey:@"successCallback"])
                                               onFailure:NSSelectorFromString([self.myDict objectForKey:@"failureCallback"])];
        }else {     // 发送内容包含图片，先判断是否需要压缩，然后再发送
                dataImage = UIImageJPEGRepresentation(imageReadyPost, 1.0);
                NSUInteger sizeOrigin = [dataImage length];
                NSUInteger sizesizeOriginKB = sizeOrigin / 1024;
                
                // 图片大于500k要先进行压缩 
                if (sizesizeOriginKB > 500) {
                    float a = 500.00000;
                    float  b = (float)sizesizeOriginKB;
                    float q = sqrt(a/b);
                    CGSize sizeImage = [imageReadyPost size];
                    CGFloat iwidthSmall = sizeImage.width * q;
                    CGFloat iheightSmall = sizeImage.height * q;
                    CGSize itemSizeSmall = CGSizeMake(iwidthSmall, iheightSmall);
                    UIGraphicsBeginImageContext(itemSizeSmall);
                    CGRect imageRectSmall = CGRectMake(0.0f, 0.0f, itemSizeSmall.width, itemSizeSmall.height);
                    [imageReadyPost drawInRect:imageRectSmall];
                    UIImage *SmallImage = UIGraphicsGetImageFromCurrentImageContext();
                    UIGraphicsEndImageContext();
                    NSData *dataImageSend = UIImageJPEGRepresentation(SmallImage, 1.0);
                    dataImage = dataImageSend;
                }
            NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithCapacity:5];
            [dic setObject:@"json" forKey:@"format"];
            [dic setObject:@"0" forKey:@"compatibleflag"];
            [dic setObject:([textView hasText] ? textView.text : @"#分享图片#") forKey:@"content"];
            if (dataImage != nil) {
                [dic setObject:dataImage forKey:@"pic"];
            }
            if (strLongitude != nil) {
                [dic setObject:strLongitude forKey:@"longitude"];
            }
            if (strLatitude != nil) {
                [dic setObject:strLatitude forKey:@"latitude"];
            }
            bImageLocal = NO;
            [self dismissModalViewControllerAnimated:YES];
            id delegate = ((DelegateObject *)[self.myDict objectForKey:@"requestDelegate"]).delegate;
            SEL postStartCallback = NSSelectorFromString([self.myDict objectForKey:@"postStartCallback"]);
            if ([delegate respondsToSelector:postStartCallback]) {
                SuppressPerformSelectorLeakWarning
                ([delegate performSelector:postStartCallback]);
            }
            NSMutableDictionary *dicAppFrom = [NSMutableDictionary dictionaryWithObject:@"ios-sdk-2.0-publish" forKey:@"appfrom"];
                // 调用发带图片微博借口
            [self.weiboEngine postPictureTweetWithFormat:@"json" 
                                                    content:([textView hasText] ? textView.text : @"#分享图片#") 
                                                   clientIP:nil 
                                                        pic:dataImage 
                                             compatibleFlag:@"0" 
                                                  longitude:strLongitude 
                                                andLatitude:strLatitude 
                                                parReserved:dicAppFrom
                                                   delegate:delegate 
                                                  onSuccess:NSSelectorFromString([self.myDict objectForKey:@"successCallback"])
                                                  onFailure:NSSelectorFromString([self.myDict objectForKey:@"failureCallback"])];
        }
    }
}

// 获得好友列表
- (void)friendSearchBtnClicked {
    [self setTextViewIsFirstResponser:NO];
    TCWBFriendViewController *tcWBFriendViewController = [[TCWBFriendViewController alloc] init];
    
    [tcWBFriendViewController setUserName:[weiboEngine name]];
    [tcWBFriendViewController setRebroadcatstMsgViewController:self];
    
    NSString *strUserName = [weiboEngine name];
    
    // 读取 互听好友数据 
    NSString *strMutualFriendPath = [FileStreame getMutualFriendPath:strUserName];
    NSArray *arrMutualFriend = [NSMutableArray arrayWithContentsOfFile:strMutualFriendPath];
    
    
    // 读取 最近联系人数据
    NSString *strIntimateFriendPath = [FileStreame getIntimateFriendPath:strUserName];
    NSArray *arrIntimateFriend = [NSMutableArray arrayWithContentsOfFile:strIntimateFriendPath];
    
    [tcWBFriendViewController setFriend:arrMutualFriend
                         intimateFriend:arrIntimateFriend];
    
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:tcWBFriendViewController];
    [self presentModalViewController:navigationController animated:YES];
    
}


// 获得话题列表
- (void)topicSearchBtnClicked {
    [self setTextViewIsFirstResponser:NO];
    TCWBTopicViewController *tcWBTopicViewController = [[TCWBTopicViewController alloc] init];
    [tcWBTopicViewController setRebroadcatstMsgViewController:self];
    NSString *strUserName = [weiboEngine name];
    NSString *strPath = [FileStreame getTopicPath:strUserName];
    NSArray *arrTopic = [NSArray arrayWithContentsOfFile:strPath];
    
    [tcWBTopicViewController setTopic:arrTopic];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:tcWBTopicViewController];
    [self presentModalViewController:navigationController animated:YES];
    
}

// 照相机
- (void)pickImageBtnClick:(id)sender {
    // 2012-09-06 By Yi Minwen 增加照相机设备检测
    if (! [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;		
        self.imagePickerController = imagePicker;
        self.imagePickerController.delegate = self;
        [self presentModalViewController:self.imagePickerController animated:YES];
    }
    else {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"打开相册", nil];
        actionSheet.tag = PhotoCamerTag;
        actionSheet.destructiveButtonIndex = -1;
        actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
        [actionSheet showInView:self.view];
    }
}

// 开启定位
- (void)positionBtnClicked:(id)sender {
    UIButton *button = (UIButton *)sender;
    
    if (bShowPosition) {    // 显示地理位置开关打开,并去获取经纬度
        button.hidden = YES;
        loadingView.hidden = NO;
        [loadingView startAnimating];
        [locationManager startUpdatingLocation];
        [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(stopLoading) userInfo:nil repeats:NO];
        
    } else {    //  关闭地理位置开关，图片变为灰色，经纬度变回默认值
        [locationManager stopUpdatingLocation];
        [button setImage:[UIImage imageNamed:@"composedingwei.png"] forState:UIControlStateNormal];
        self.myLocation = nil;
        bShowPosition = YES;
    }
}

// 删除图片
-(void)picCtrlViewDelBtnClicked {
    bImageLocal = NO;
    if (imageReadyPost) {
        imageReadyPost = nil;
    }
	[ctrlimageView removeFromSuperview];
	ctrlimageView = nil;
	[viewImage removeFromSuperview];
	viewImage = nil;
    // 删除图片的同时判断文字是否为0，文字不存在则发送按钮不可用
	if ([textView.text length] == 0) {
        UIButton *button = (UIButton *)[self.view viewWithTag:ButtonRightTag];
        button.enabled = NO;
	}
	[self setTextViewIsFirstResponser:YES];		
}


#pragma -
#pragma UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    imageReadyPost = nil;
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
	if (nil == viewImage) {
		viewImage = [[AttachedPictureView alloc]initWithFrame:CGRectMake(5 - 43, -2, 43, 32)];
		viewImage.myAttachedPictureViewDelegate = self;
		[viewMidBase addSubview:viewImage];
        
        viewImage.backgroundColor = [UIColor clearColor];
        bImageLocal = YES;
        //	显示图片缩略图片
        CATransition *animation = [CATransition animation];
        animation.delegate = self;
        animation.duration = 0.7;
        animation.timingFunction = UIViewAnimationCurveEaseInOut;
        animation.type = kCATransitionPush;
        viewImage.frame = CGRectMake(5, -2, 43, 32);
        [[viewImage layer] addAnimation:animation forKey:@"animation"];

	}
	imageReadyPost = [image rotateImage:image.imageOrientation];
	[viewImage setAttachedImage:imageReadyPost];
    UIButton *button = (UIButton *)[self.view viewWithTag:ButtonRightTag];
    button.enabled = YES;
    [self dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissModalViewControllerAnimated:YES];
}    


- (void)viewWillAppear:(BOOL)animate {
    [super viewWillAppear:YES];
    [self setTextViewIsFirstResponser:YES];
}

#pragma mark -
#pragma mark AttachedPictureViewDelegate
- (void)AttachedPictureViewClicked {
	if (nil == ctrlimageView) {
		ctrlimageView = [[AttachedPictureCtrlView alloc] initWithFrame:CGRectMake(80, 16, 180.0f, 180.0f)];
		[ctrlimageView setMyAttachedPictureCtrlViewDelegate: self];
        [ctrlimageView attachImage:imageReadyPost];
		[viewDownBase addSubview:ctrlimageView];	
        [self setTextViewIsFirstResponser:NO];
	}
	else {
		[ctrlimageView attachImage:imageReadyPost];
		if (ctrlimageView.hidden == YES) {
			ctrlimageView.hidden = NO;	
            [self setTextViewIsFirstResponser:NO];
		}
		else {
			ctrlimageView.hidden = YES;
            [self setTextViewIsFirstResponser:YES];
		}
	}
}

#pragma mark -
#pragma mark 字数统计相关

// 字数统计
- (int)calcStrWordCount:(NSString *)str {
	int nResult = 0;
	NSString *strSourceCpy = [str copy];
	NSMutableString *strCopy =[[NSMutableString alloc] initWithString: strSourceCpy];
    NSArray *array = [strCopy componentsMatchedByRegex:@"((news|telnet|nttp|file|http|ftp|https)://){1}(([-A-Za-z0-9]+(\\.[-A-Za-z0-9]+)*(\\.[-A-Za-z]{2,5}))|([0-9]{1,3}(\\.[0-9]{1,3}){3}))(:[0-9]*)?(/[-A-Za-z0-9_\\$\\.\\+\\!\\*\\(\\),;:@&=\\?/~\\#\\%]*)*"];
	if ([array count] > 0) {
		for (NSString *itemInfo in array) {
			NSRange searchRange = {0};
			searchRange.location = 0;
			searchRange.length = [strCopy length];
			[strCopy replaceOccurrencesOfString:itemInfo withString:@"aaaaaaaaaaaa" options:NSCaseInsensitiveSearch range:searchRange];
		}
	}

	char *pchSource = (char *)[strCopy cStringUsingEncoding:NSUTF8StringEncoding];
	int sourcelen = strlen(pchSource);
	
	int nCurNum = 0;		// 当前已经统计的字数
	for (int n = 0; n < sourcelen; ) {
		if( *pchSource & 0x80 ) {
			pchSource += 3;		// NSUTF8StringEncoding编码汉字占３字节
			n += 3;
			nCurNum += 2;
		}
		else {
			pchSource++;
			n += 1;
			nCurNum += 1;
		}
	}
	// 字数统计规则，不足一个字(比如一个英文字符)，按一个字算
	nResult = nCurNum / 2 + nCurNum % 2;	 
	
	return nResult;
}


// 从字符串中获取字数个数为N的字符串，单字节字符占半个字数，双字节占一个字数
- (NSString *)getSubString:(NSString *)strSource WithCharCounts:(NSInteger)number {
	// 一个字符以内，不处理
	if (strSource == nil || [strSource length] <= 1) {
		return strSource;
	}
	char *pchSource = (char *)[strSource cStringUsingEncoding:NSUTF8StringEncoding];
	int sourcelen = strlen(pchSource);
	int nCharIndex = 0;		// 字符串中字符个数,取值范围[0, [strSource length]]
	int nCurNum = 0;		// 当前已经统计的字数
	for (int n = 0; n < sourcelen; ) {
		if( *pchSource & 0x80 ) {
			if ((nCurNum + 2) > number * 2) {
				break;
			}
			pchSource += 3;		// NSUTF8StringEncoding编码汉字占３字节
			n += 3;
			nCurNum += 2;
		}
		else {
			if ((nCurNum + 1) > number * 2) {
				break;
			}
			pchSource++;
			n += 1;
			nCurNum += 1;
		}
		nCharIndex++;
	}
	assert(nCharIndex > 0);
	return [strSource substringToIndex:nCharIndex];
}

#pragma mark - textView相关

// 插入字符串到光标位置
- (void)insertTextAtCurrentIndex:(NSString *)contextStr {
	if ([textView hasText]) {
		// 获得光标所在的位置
		int location = curSelectedRange.location;
		// 将UITextView中的内容进行调整（主要是在光标所在的位置进行字符串截取，再拼接你需要插入的文字即可）
		NSString *content = textView.text;
		if (location > [content length]) {
			location = [content length];
		}
		NSString *result = [NSString stringWithFormat:@"%@%@%@",[content substringToIndex:location], contextStr, [content substringFromIndex:location]];
		// 将调整后的字符串添加到UITextView上面
		textView.text = result;
		// 设置光标位置
		curSelectedRange.location = location + contextStr.length;
		textView.selectedRange = curSelectedRange;
	}
	else {
		textView.text = contextStr;
        //设置光标位置
		curSelectedRange.location = contextStr.length;
		textView.selectedRange = curSelectedRange;
	}
    
}


// 设置文本框为输入状态
- (void)setTextViewIsFirstResponser:(BOOL)isFirstResponser {
	if (isFirstResponser) {
		// 1. 恢复文本输入状态
		[textView becomeFirstResponder];
		if ([textView hasText]) {
			textView.selectedRange = curSelectedRange;
		}
	}
	else {
		// 2. 文本框失去聚焦状态
		if ([textView isFirstResponder] && [textView hasText]) {
			curSelectedRange = textView.selectedRange;
		}
		[textView resignFirstResponder];
	}
    
}


#pragma mark TextVeiwDelegate

// 往textView输入文字时触发
- (void)textViewDidChange:(UITextView *)tView {
	if (tView.tag == 100) {
		int textUTF8StrLength = [self calcStrWordCount:textView.text];
		if (textUTF8StrLength > MaxInputWords + 200) {
			tView.text = [tView.text substringToIndex:MaxInputWords + 200];
		} 
		NSInteger charLeft = MaxInputWords - textUTF8StrLength;
        // 修正字个数
        [viewWordNum setWordsNum:charLeft];
        
        // 文字和图片都没有的情况下默认不可以发送
         UIButton *button = (UIButton *)[self.view viewWithTag:ButtonRightTag];
        if ([textView.text length] == 0 && imageReadyPost == nil) {
            button.enabled = NO;
        }else {
            button.enabled = YES;
        }
    }
}

// textView中不直接输入字而改变内容的时候触发
- (void)textViewDidBeginEditing:(UITextView *)textV {
    if (textV.tag == 100) {
		int textUTF8StrLength = [self calcStrWordCount:textView.text];
		if (textUTF8StrLength > MaxInputWords + 200) {
			textV.text = [textView.text substringToIndex:MaxInputWords + 200];
		} 
		NSInteger charLeft = MaxInputWords - textUTF8StrLength;
        // 修正字个数
        [viewWordNum setWordsNum:charLeft];
    }   
}
#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (DoneComposeActionSheetTag == actionSheet.tag) {
        switch (buttonIndex) {
            case 0:	{	// "清除超出文字"
                // 去掉尾部多余文字
                textView.text = [self getSubString:textView.text WithCharCounts:MaxInputWords];
                curSelectedRange.location = textView.text.length;
				curSelectedRange.length = 0;
            }
                break;
                
            default: {	// ”取消“
            }
                break;
        }
        
	}
    if (PhotoCamerTag == actionSheet.tag) {
        switch (buttonIndex) {
            case 0:{    // 取自相机
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;		
                imagePicker.delegate = self;
                [self presentModalViewController:imagePicker animated:YES];
                
            }
                break;
            case 1:{    // 取自相册
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;		
                self.imagePickerController = imagePicker;
                self.imagePickerController.delegate = self;
                [self presentModalViewController:self.imagePickerController animated:YES];
                
            }
                break;
            default:
                break;
        }
    }
}

- (void)topicViewsubTitle:(NSString *)title {
    textView.text = [textView.text stringByAppendingString:title];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



#pragma mark 互听好友 函数

- (void)didRequestMutualList:(NSDictionary *)dicMutualList {
        
    NSNumber *numReturn = [dicMutualList objectForKey:kWeiboReturn];
    if (kWeiboSucess != [numReturn intValue]) {
        
        return;
    }
    
    if (![[dicMutualList objectForKey:kWeiboData] isKindOfClass:[NSDictionary class]]) {
        
        return;
    }

    
    NSDictionary *dicData = [dicMutualList objectForKey:kWeiboData];
    NSArray *arrInfo = [dicData objectForKey:kWeiboInfo];
    
    for (int i = 0; i < [arrInfo count]; i ++) {
        
        NSMutableDictionary *dicFriend = [arrInfo objectAtIndex:i];
        
        NSString *strHeadURL = [dicFriend objectForKey:kWeiboHeadURL];
        [dicFriend setObject:strHeadURL forKey:kWeiboHead];
    }
    
    // 读/写 互听好友 文件
    [NSThread detachNewThreadSelector:@selector(threadMutualFriend:) toTarget:self withObject:arrInfo];
    
    
    
    NSNumber *numHasNext = [dicData objectForKey:kWeiboHasNext];
    if ([numHasNext intValue] == kHasNextYes) {
        
        NSString *strName = [weiboEngine name];
        NSString *strOpenId = [weiboEngine openId];
        
        [weiboEngine getFriendMutualListWithFormat:kJson 
                                              name:strName 
                                           fopenID:strOpenId 
                                            reqNum:10*nMutualIndex
                                        startIndex:0
                                           andInstall:0 
                                       parReserved:nil 
                                          delegate:self 
                                         onSuccess:@selector(didRequestMutualList:) 
                                         onFailure:@selector(failedRequestMutualList:)];
        
        nMutualIndex ++;
    }
    
    
}



- (void)failedRequestMutualList:(NSError *)error {
    
    DLog(@"error = %@",error);
}


#pragma mark 最近联系人 函数

- (void)didRequestIntimateFriend:(NSDictionary *)dicIntimateFriend {
    
    NSNumber *numReturn = [dicIntimateFriend objectForKey:kWeiboReturn];
    if (kWeiboSucess != [numReturn intValue]) {
        
        return;
    }
    if (![[dicIntimateFriend objectForKey:kWeiboData] isKindOfClass:[NSDictionary class]]) {
        
        return;
    }
    
    NSDictionary *dicData = [dicIntimateFriend objectForKey:kWeiboData];
    NSArray *arrIntimateFriend = [dicData objectForKey:kWeiboInfo];
    
    // 读/写 最近联系人 
    [NSThread detachNewThreadSelector:@selector(threadIntimateFriend:) toTarget:self withObject:arrIntimateFriend];        

}


- (void)failedRequestIntimateFriend:(NSError *)error { 
    
    DLog(@"error = %@",error);
}



#pragma mark 定位委托

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    if (!self.myLocation) {
		self.myLocation = newLocation;
	}
	else if (newLocation.horizontalAccuracy < self.myLocation.horizontalAccuracy) {
		self.myLocation = newLocation;
	}
    
}

// loadView停止转动
- (void)stopLoading {
    [loadingView stopAnimating];
    UIButton *button = (UIButton *)[self.view viewWithTag:PositionBtnTag];
    button.hidden = NO;
    if (self.myLocation != nil) {
        [button setImage:[UIImage imageNamed:@"composedingweihover.png"] forState:UIControlStateNormal];// 获取位置信息成功，图标变亮
        bShowPosition = NO;
    }
}

// 定位失败的时候
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    DLog(@"error = %@",error);

}


#pragma mark 话题

- (void)didRequestTopic:(NSDictionary *)dicTopic {
    
    NSNumber *numReturn = [dicTopic objectForKey:kWeiboReturn];
    if (kWeiboSucess != [numReturn intValue]) {
        
        return;
    }
    
    if (![[dicTopic objectForKey:kWeiboData] isKindOfClass:[NSDictionary class]]) {
        
        return;
    }

    
    NSDictionary *dicData = [dicTopic objectForKey:kWeiboData];
    NSArray *arrayTopic = [dicData objectForKey:kWeiboInfo];
    
    [NSThread detachNewThreadSelector:@selector(threadTopic:) toTarget:self withObject:arrayTopic]; 
    
    
    NSNumber *numSuccNum = [dicData objectForKey:kWeiboRecentHtSuccNum];
    if ([numSuccNum isKindOfClass:[NSNumber class]] && kRecentHtReqNum == [numSuccNum intValue]) {
        [weiboEngine gethtRecentUsedWithFormat:kJson
                                        reqNum:kRecentHtReqNum
                                          page:nRecentHtIndex ++
                                   andSortType:0
                                   parReserved:nil
                                      delegate:self
                                     onSuccess:@selector(didRequestTopic:)
                                     onFailure:@selector(failedRequestTopic:)]; 
    }
}


- (void)failedRequestTopic:(NSError *)error {
    
    DLog(@"error = %@",error);
}



#pragma mark 功能函数

- (void)showNoteView:(NSString *)strText {
    
    UINoteView *noteview = (UINoteView *)[self.view viewWithTag:TAG_NOTEVIEW];
    [noteview setNoteText:strText];
    
    [noteview showNoteView];
}



#pragma mark 线程函数

- (void)threadMutualFriend:(NSArray *)arrFriend {
    
    @autoreleasepool {
    
        NSString *strUserName = [weiboEngine name];
        NSString *strPath = [FileStreame getMutualFriendPath:strUserName];
        NSMutableArray *arrMutualFriend = [NSMutableArray arrayWithContentsOfFile:strPath];
        
        if ([arrMutualFriend count] > 0) {
            
            for (int i = 0; i < [arrFriend count]; i ++) {
                
                NSDictionary *dicFriend = [arrFriend objectAtIndex:i];
                NSString *strName = [dicFriend objectForKey:kWeiboName];
                
                for (int j = 0; j < [arrMutualFriend count]; j ++) {
                    
                    NSDictionary *dicFriendFromFile = [arrMutualFriend objectAtIndex:j];
                    NSString *strNameReadFromFile = [dicFriendFromFile objectForKey:kWeiboName];
                    
                    if ([strName isEqualToString:strNameReadFromFile]) {
                        
                        break;
                    }
                    
                    if (j == [arrMutualFriend count] - 1) {
                        
                        [arrMutualFriend addObject:dicFriend];
                    }
                }
                
                
            }
        }
        // 读取互听好友为空
        else {
            
            [arrMutualFriend addObjectsFromArray:arrFriend];
        }
        
        [arrMutualFriend writeToFile:strPath atomically:YES];
    
    
    }
}


- (void)threadIntimateFriend:(NSArray *)arrFriend {
    
    @autoreleasepool {
    
        NSString *strUserName = [weiboEngine name];
        NSString *strPath = [FileStreame getIntimateFriendPath:strUserName];
        NSMutableArray *arrIntimateFriend = [NSMutableArray arrayWithContentsOfFile:strPath];
        
        if ([arrIntimateFriend count] > 0) {
            
            for (int i = 0; i < [arrFriend count]; i ++) {
                
                NSDictionary *dicFriend = [arrFriend objectAtIndex:i];
                NSString *strName = [dicFriend objectForKey:kWeiboName];
                
                for (int j = 0; j < [arrIntimateFriend count]; j ++) {
                    
                    NSDictionary *dicFriendFromFile = [arrIntimateFriend objectAtIndex:j];
                    NSString *strNameReadFromFile = [dicFriendFromFile objectForKey:kWeiboName];
                    
                    if ([strName isEqualToString:strNameReadFromFile]) {
                        
                        break;
                    }
                    
                    if (j == [arrIntimateFriend count] - 1) {
                        
                        [arrIntimateFriend addObject:dicFriend];
                    }
                }
                
            }
        }
        // 最近联系人为空
        else {
            
            [arrIntimateFriend addObjectsFromArray:arrFriend];
        }
        
        [arrIntimateFriend writeToFile:strPath atomically:YES];
    
    
    }
}


- (void)threadTopic:(NSArray *)arrayTopic {
    
    @autoreleasepool {
    
        NSString *strUserName = [weiboEngine name];
        NSString *strPath = [FileStreame getTopicPath:strUserName];
        NSMutableArray *arrTopic = [NSMutableArray arrayWithContentsOfFile:strPath];
        
        if ([arrTopic count] > 0) {
            
            for (int i = 0; i < [arrayTopic count]; i ++) {
                
                NSDictionary *dicTopic = [arrayTopic objectAtIndex:i];
                NSString *strTopicName = [dicTopic objectForKey:kWeiboRecentHtText];
                
                for (int j = 0; j < [arrTopic count]; j ++ ) {
                    
                    NSString *strName = [arrTopic objectAtIndex:j];
                    if ([strTopicName isEqualToString:strName]) {
                        
                        break;
                    }
                    if (j == [arrTopic count] - 1) {
                        
                        [arrTopic addObject:strTopicName];
                    }
                }
            }
        }
        else {
            
            for (int i = 0; i < [arrayTopic count]; i ++) {
                
                NSDictionary *dicTopic = [arrayTopic objectAtIndex:i];
                NSString *strTopicName = [dicTopic objectForKey:kWeiboRecentHtText];
                
                [arrTopic addObject:strTopicName];
            }
        }
        
        [arrTopic writeToFile:strPath atomically:YES];
    
    }
}


@end
