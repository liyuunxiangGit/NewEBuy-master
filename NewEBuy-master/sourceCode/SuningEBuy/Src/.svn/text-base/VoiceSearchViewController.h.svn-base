//
//  VoiceSearchViewController.h
//  SuningEBuy
//
//  Created by chupeng on 14-9-19.
//  Copyright (c) 2014年 Suning. All rights reserved.
//  语音搜索

#import "CommonViewController.h"
#import "iflyMSC/IFlySpeechRecognizerDelegate.h"

@class IFlySpeechRecognizer;

typedef enum : NSUInteger {
    STATE_Listening, //正在录声音
    STATE_Searching, //正在识别
    STATE_ERROR,     //出现错误
    STATE_GRAY,      //所有控件禁用
    STATE_NORMAL     //录音，识别被取消或停止
} STATE_UI;

typedef enum : NSUInteger {
    From_NewHome,
    From_NewSearch,
    From_SearchList,
    From_ShopSearch
}From;

@protocol VoiceSearchViewControllerDelegate <NSObject>
- (void)voiceSearchByKeyWord:(NSString *)keyword;
@end

@interface VoiceSearchViewController : CommonViewController<IFlySpeechRecognizerDelegate>
+ (VoiceSearchViewController *)sharedVoiceSearchCtrl;
- (void)showVoiceSearchView;
- (void)removeVoiceSearchView;

@property (nonatomic, weak) id<VoiceSearchViewControllerDelegate> delegate;

//识别对象
@property (nonatomic, strong) IFlySpeechRecognizer * iFlySpeechRecognizer;
@property (nonatomic, copy) NSString             * result;                  //识别结果
@property (nonatomic) BOOL                 isCanceled;           //是否取消
@property (nonatomic, strong) NSMutableArray *arrayAnimationListening;
@property (nonatomic, strong) NSMutableArray *arrayAnimationSearching;
@property (nonatomic, strong) NSMutableArray *arrayAnimationEnding;      //识别结束


#pragma mark - UI 
@property (nonatomic, strong) UILabel *labelTopTip; //顶部提示
@property (nonatomic, strong) UILabel *labelKeyWord; //识别出的用户的话
@property (nonatomic, strong) UILabel *labelBottomTip;  //科大讯飞的文案
@property (nonatomic, strong) UIButton *btnClose;   //关闭按钮
@property (nonatomic, strong) UIButton *btnCloseBig; //关闭按钮放大版
@property (nonatomic, strong) UIButton *btnSpeaker;  //话筒按钮
@property (nonatomic, strong) UIImageView *imgViewAnimation;  //动画控件
@property (nonatomic, assign) STATE_UI state; // set方法里调用了updateUI，不用再额外调用

@property (nonatomic, assign) From from;
@end
