//
//  TCWBRebroadcastMsgViewController.h
//  TCWeiBoSDKDemo
//
//  Created by zzz on 8/24/12.
//  Copyright (c) 2012 bysft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WordsLeftView.h"
//#import "TCWBTopicViewController.h"
#import "AttachedPictureView.h"
#import "AttachedPictureCtrlView.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreLocation/CLLocationManagerDelegate.h>
#import <CoreLocation/CoreLocation.h>

@class  TCWBEngine;

// 定义撰写界面字符最大个数
//#define MaxInputWords							140
// 定义中间按钮个数
#define MidViewBtnCount							5
// 定义NavtionBar高度
#define NavBarHeight                            44
// 定义不同屏幕的高度差
#define AltituteScrent                          88

// 按钮边框位置
#define FriendsearchBtnFrame                    CGRectMake(20, 42.0f, 22.0f, 22.0f)
#define TopicSearchBtnFrame                     CGRectMake(20 + 30 + 22, 42.0f, 22.0f, 22.0f)
#define PhotoFromCameraBtnFrame					CGRectMake(20 + (30 + 22) * 2, 42.0f, 22.0f, 22.0f)
#define PositionBtnFrame						CGRectMake(20 + (30 + 22) * 3, 42.0f, 22.0f, 22.0f)

// 定义控件tag起始值
#define ComposeMainBaseViewTag					500
#define viewUpBaseTag							(ComposeMainBaseViewTag + 1)		// 基本区域: 顶部文本区
#define TextViewTag								(viewUpBaseTag + 1)					// 文本输入框
#define viewMidBaseTag							(ComposeMainBaseViewTag + 10)		// 基本区域: 中部文本区
#define AttachedImageViewTag					(viewMidBaseTag + 1)				// 附件贴图
#define AvalibleCharactersLeftImageViewTag		(viewMidBaseTag + 2)				// 剩余字数
#define ReplyAndCommentBtnTag					(viewMidBaseTag + 10)				// 评论并转播 按钮
#define PhotoFromCameraBtnTag					(viewMidBaseTag + 11)				// 照相 按钮
#define PhotoFromLibraryBtnTag					(viewMidBaseag + 12)				// 相册 按钮
#define FriendSearchBtnTag						(viewMidBaseTag + 13)				// 好友 按钮
#define TopicSearchBtnTag						(viewMidBaseTag + 14)				// 话题搜索 按钮
#define CutlineImageViewTag						(viewMidBaseTag + 16)				// 分割线 
#define CleanWordsActionSheetTag				(viewMidBaseTag + 17)				// 清空文字提示框标记
#define CancelComposeActionSheetTag				(viewMidBaseag + 18)				// 取消操作时提示框标记
#define DoneComposeActionSheetTag				(viewMidBaseTag + 19)				// 完成操作时提示框标记
#define PositionBtnTag                          (viewMidBaseTag + 20)
#define viewDownBaseTag							(ComposeMainBaseViewTag + 30)		// 基本区域: 底部文本区
#define ButtonRightTag                          (ComposeMainBaseViewTag + 31)
#define PhotoCamerTag                           (ComposeMainBaseViewTag + 32)


@interface TCWBRebroadcastMsgViewController : UIViewController<UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,AttachedPictureViewDelegate,AttachedPictureCtrlViewDelegate,CLLocationManagerDelegate, UIActionSheetDelegate> {
    UITextView                  *textView;                  
    UIView                      *viewMidBase;               // 中间基础视图
    UIView                      *viewUpBase;                // 上边基础视图
    UIView                      *viewDownBase;              // 底部基础视图
    UIImageView                 *imageViewPlaceBtn;         // 承载按钮视图
    WordsLeftView               *viewWordNum;               // 显示文字个数的视图
    TCWBEngine                  *weiboEngine;               // 数据引擎，用于请求数据
    NSDictionary                *myDict;                    // 初始化时接收数据的字典
    UIImagePickerController     *imagePickerController;
    NSRange                     curSelectedRange;           // 光标位置
    AttachedPictureView         *viewImage;                 // 拍照图像
	AttachedPictureCtrlView     *ctrlimageView;             // 点击附件时显示的视图
    NSData                      *dataImage;                 // 图片数据
    UIImage                     *imageReadyPost;            // 准备发送的图片
    BOOL                        bShowPosition;              // 是否开启定位    
    int                         keyboardHeight;             // 键盘高度
    BOOL                        bImageLocal;                // 是否取自本地图片
    CLLocation                  *myLocation;                // 用户所处在的位置
    CLLocationManager           *locationManager;
    UIActivityIndicatorView     *loadingView;               // 打开地图时loading视图
    int                         nMutualIndex;
    int                         nRecentHtIndex;
}

@property (nonatomic, strong)UITextView                 *textView;
@property (nonatomic, strong)UIView                     *viewMidBase;
@property (nonatomic, strong)UIView                     *viewUpBase;
@property (nonatomic, strong)UIView                     *viewDownBase;
@property (nonatomic, strong)WordsLeftView              *viewWordNum;
@property (nonatomic, strong)TCWBEngine                 *weiboEngine;
@property (nonatomic, strong)NSDictionary               *myDict;
@property (nonatomic, assign)NSRange                    curSelectedRange;
@property (nonatomic, strong)UIImagePickerController    *imagePickerController;
@property (nonatomic, strong)CLLocation                 *myLocation;
@property (nonatomic, strong)AttachedPictureView        *viewImage; 
@property (nonatomic, strong)AttachedPictureCtrlView    *ctrlimageView;
@property (nonatomic, strong)UIActivityIndicatorView    *loadingView;

- (id)initWithEngine:(TCWBEngine *)engine parameter:(NSDictionary *)dict;
- (NSString *)getSubString:(NSString *)strSource WithCharCounts:(NSInteger)number;

// 字数统计
- (int)calcStrWordCount:(NSString *)str;
// 插入字符串到光标位置
- (void)insertTextAtCurrentIndex:(NSString *)contextStr;
// 设置文本框为输入状态
- (void)setTextViewIsFirstResponser:(BOOL)isFirstResponser;

@end