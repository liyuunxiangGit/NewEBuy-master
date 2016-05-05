//
//  QYaoYiYaoViewCtrler.m
//  YaoYiYao
//
//  Created by XZoscar on 14-4-1.
//  Copyright (c) 2014年 suning. All rights reserved.
//

#import "QYaoYiYaoViewCtrler.h"
#import "QYaoYiYaoViewCtrler+Req.h"
#import "QYaoMoreRuleView.h"
#import "LoginViewController.h"
//#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "SNShareKit.h"
#import "SuningMainClick.h"
#import <SSA_IOS/SSAIOSSNDataCollection.h>
//#import "QYaoYiYaoScoreViewCtrler.h"
#import "UIImageView+WebCache.h"

#pragma mark - 摇奖结果 view --- --- --- --- --- --- --- --- --- --- ---

@interface QYaoYiYaoResultView : UIView

@property (nonatomic,strong) IBOutlet UILabel *valueLabel;
@property (nonatomic,strong) IBOutlet UILabel *valueLabel2;
@property (nonatomic,strong) IBOutlet UILabel *unitLabel;

// type == 1 云券，type == 2 云钻, type = 3 容错提示信息,type == 4 实物奖品描述
+ (QYaoYiYaoResultView *)resultViewWithType:(NSUInteger)type;

@end

@interface QYaoYiYaoResultView ()
@property (nonatomic,strong) IBOutlet UIImageView *typeIconView,*exchangeCodeImgView;
@end

@implementation QYaoYiYaoResultView

// type == 1 云券，type == 2 云钻, type = 3 容错提示信息,type == 4 实物奖品描述
// 1 == xibType 大促摇易摇xib模版(云钻摇易摇)
// 2 == xibType 默认的摇易摇xib模版 (大促摇易摇)

+ (QYaoYiYaoResultView *)resultViewWithType:(NSUInteger)type {
    
    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"QYaoYiYaoResultView" owner:nil options:nil];
    QYaoYiYaoResultView *view = arr[type-1];
    view.backgroundColor = [UIColor clearColor];
    if (type == 4) {
        UIImage *btImage = [UIImage imageNamed:@"y2_buttonRadius.png"];
        btImage = [btImage resizableImageWithCapInsets:UIEdgeInsetsMake(15.0f,15.0f,15.0f,15.0f)];
        view.exchangeCodeImgView.image = btImage;
    }
    return view;
}

@end

#pragma mark - 导航栏 segments view --- --- --- --- --- --- --- --- ---

// @class QYaoYYSegment
#pragma mark - @implementation QYaoYYSegment

@implementation QYaoYYSegment

- (void)dealloc {
    self.delegate       = nil;
}

+ (QYaoYYSegment *)segment {
    
    return [[[NSBundle mainBundle] loadNibNamed:@"QYaoYYSegment"
                                          owner:nil options:nil] objectAtIndex:0];
}

- (IBAction)onClickedSegments:(UIButton *)sender {
    
    if (sender.selected) {
        return;
    }else {
        if (sender == _segment0) {
            _segment0.selected = YES;
            _segment1.selected = NO;
            [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:@"520601", nil]];
            //[SuningMainClick sharedInstance].currentPageTitle = @"摇易摇-摇易摇页面";
        }else if (sender == _segment1) {
            _segment0.selected = NO;
            _segment1.selected = YES;
            [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:@"520602", nil]];
            //[SuningMainClick sharedInstance].currentPageTitle = @"摇易摇-云宝箱";
        }
        
        [self animatedToSegment:sender.tag];
        if (nil != _delegate
            && [_delegate respondsToSelector:@selector(delegate_selectedSegment:)]) {
            [_delegate delegate_selectedSegment:sender.tag];
        }
    }
}

- (void)animatedToSegment:(NSUInteger)tag {
    
    [UIView animateWithDuration:.35f animations:^{
        _animatedLine.center
        = CGPointMake(tag *(_animatedLine.bounds.size.width)+_animatedLine.bounds.size.width/2.0f,
                      _animatedLine.center.y);
    } completion:^(BOOL finished) {
    }];
}

@end

#pragma mark - 摇易摇view controller --- --- --- --- --- --- --- --- ---

@interface QYaoYiYaoViewCtrler() {
    @private
    CGPoint _wordImgViewPos;
}

@property (nonatomic,assign) NSUInteger            xibType;
// ui
@property (nonatomic,strong) IBOutlet UIButton     *resultButton;

// 查询活动 结果呈现label
@property (nonatomic,strong) IBOutlet UILabel      *queryActiveResultLbl;
// 摇奖结果呈现
@property (nonatomic,strong) IBOutlet UIView       *shakedPrizeResultView;
// role图片
@property (nonatomic,strong) IBOutlet UIImageView  *shakedLed0,*shakedLed1,*shakedLed2;

@property (nonatomic,strong) IBOutlet UIImageView  *wordImgView,*role2ImgView;

@property (nonatomic,strong) NSTimer               *queueLedTimer,*wordAnimatedTimer;
@property (nonatomic,strong) NSTimer               *onceShakeTimer;

@property (nonatomic,strong) IBOutlet UIImageView  *backgroundImgView;

@property (nonatomic,strong) IBOutlet UIView       *workView0,*workView1;
@property (nonatomic,strong) IBOutlet UIScrollView *workScrollView;

@property (nonatomic,strong) UIWebView             *cloudBoxWebView;

//@property (nonatomic,strong) AVAudioPlayer         *shakingAudioPlayer,*shakedAudioPlayer;
@property (nonatomic,strong) QYaoYYSegment         *segment;

@property (nonatomic,strong) ChooseShareWayView    *shareView;
@property (nonatomic,strong) SNShareKit            *shareKit;

- (IBAction)actionMoreRule;
- (IBAction)actionClickedFootButton:(UIButton *)sender;

@end


// @class QYaoYiYaoViewCtrler
#pragma mark - @implementation QYaoYiYaoViewCtrler

@implementation QYaoYiYaoViewCtrler

- (void)dealloc {
    
//    // 声波中 使用
//    AVAudioSession *session = [AVAudioSession sharedInstance];
//    [session setCategory:AVAudioSessionCategoryRecord error:nil];
    
   // __registHttpServe.delegate  = nil;
    __yaoHttpServe.httpDelegate = nil;
    _shareView.delegate         = nil;
    _segment.delegate           = nil;
    _cloudBoxWebView.delegate   = nil;
    
    [self.shareView removeFromSuperview];
    self.shareView              = nil;
    
    [self stopQueueLed];
    [self stopWordAnimation];
    
//    [self.shakingAudioPlayer stop];
//    [self.shakedAudioPlayer  stop];
//    
//    self.shakedAudioPlayer    = nil;
//    self.shakingAudioPlayer   = nil;
    
    self.queueLedTimer        = nil;
    self.wordAnimatedTimer    = nil;
    self.onceShakeTimer       = nil;
}

#pragma mark - initialize

// 1->QViewController_score.xib,xib模版(云钻摇易摇)
// 2->QViewController.xib,xib模版 (大促摇易摇)
- (id)initXibWithType:(NSUInteger)xibType {
    self = [self initWithNibName:(1==xibType)?@"QYaoYiYaoViewCtrler_score":@"QYaoYiYaoViewCtrler" bundle:nil];
    self.xibType = xibType;
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.hidesBottomBarWhenPushed = YES;
        
        // 默认 1 摇易摇
        [self setActiveTypeId:@"1"]; // 云钻摇易摇活动id = 1,大促为202，声波为2、3、4、5
        [self setPageTitle:@"摇易摇-摇易摇页面"];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    // to shake motion
    [self resignFirstResponder];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // to shake motion
    [self becomeFirstResponder];
    
    // TODO ...
    __currQueueLedIndex     = 0;
    __bOnceShakeShakeing    = NO;
}

// to shake motion
- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)backForePage {
    
    [self stopQueueLed];
    [self stopWordAnimation];
    
//    [self.shakingAudioPlayer stop];
//    [self.shakedAudioPlayer  stop];
    
    if (.0f == _workScrollView.contentOffset.x) {
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        if ([self.cloudBoxWebView canGoBack]) {
            [self.cloudBoxWebView goBack];
        }else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    _wordImgViewPos = _wordImgView.center;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.workView0.hidden = YES;
    __bOnceShakeShakeing  = YES;
    _queryActiveResultLbl.text = nil;
    
    [self displayOverFlowActivityView:L(@"LCLoading...")];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        UIImage *bgImg = nil;
        NSString *bundlePath = [NSBundle mainBundle].resourcePath;
        if (1 == _xibType) {    // 云钻摇易摇
            bgImg     = [UIImage imageWithContentsOfFile:[bundlePath stringByAppendingPathComponent:@"y2_shake_bg.png"]];
        }else if (2 == _xibType) { // 大促摇易摇
            bgImg     = [UIImage imageWithContentsOfFile:[bundlePath stringByAppendingPathComponent:@"y1_shake_bg.png"]];
        }
        
        //[self initializeAudioPlayer];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            _backgroundImgView.image = bgImg;
            if (1 == _xibType) {
                UIImage *btImage = [UIImage imageNamed:@"y2_buttonRadius.png"];
                btImage = [btImage resizableImageWithCapInsets:UIEdgeInsetsMake(15.0f,15.0f,15.0f,15.0f)];
                [_resultButton setBackgroundImage:btImage forState:UIControlStateNormal];
            }
            
            self.workView0.hidden    = NO;
            
//            // 静音状态 下 不播放
//            AVAudioSession *session = [AVAudioSession sharedInstance];
//            [session setActive:NO error:nil];
            
            [self becomeFirstResponder];
            
            if (_ctrlerType == kQYaoViewCtrlerYaoYiYao) {
                self.segment           = [QYaoYYSegment segment];
                _segment.delegate      = self;
                self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_segment];
                
                self.cloudBoxWebView = [[UIWebView alloc] initWithFrame:CGRectMake(.0f,.0f,
                                                                                   _workView1.frame.size.width,
                                                                                   _workView1.frame.size.height)];
                _cloudBoxWebView.backgroundColor = [UIColor colorWithRed:242.0f/255.0f
                                                                   green:242.0f/255.0f
                                                                    blue:242.0f/255.0f
                                                                   alpha:1.0f];
                _cloudBoxWebView.delegate        = self;
                _cloudBoxWebView.scalesPageToFit = YES;
                [_workView1 addSubview:_cloudBoxWebView];
                
                // 查询活动（摇动的时候判断是否登录，没登录提示登录）
                // 声波中 进入 ，不用查询
                [self updateViewUserInteractionEnabled:NO];
                [[self yaoJiangService] reqActiveQuery:self.activeTypeId];
                
            }else if (_ctrlerType == kQYaoViewCtrlerShengBo) {
                
                [self downloadBackgroundImage:_activeQueryBean.backgroundUrl];
                
                [self setTitle:L(@"PageTitlePlayVoice")];
                [self removeOverFlowActivityView];
                [self updateShakePrizeResult:kQYaoYiYaoResultStateShakeReadyGo desc:_activeQueryBean.resultDesc];
            }
        });
        
    });
}

- (void)setActiveQueryBean:(QYaoQueryDTO *)activeQueryBean {
    if (_activeQueryBean != activeQueryBean) {
        _activeQueryBean = activeQueryBean;
        
        if (_ctrlerType == kQYaoViewCtrlerYaoYiYao) {
            [self downloadBackgroundImage:_activeQueryBean.backgroundUrl];
        }
    }
}

- (void)downloadBackgroundImage:(NSString *)backgroundURL {
    
    if (nil != backgroundURL
        && [backgroundURL hasPrefix:@"http"]) {
        
        [_backgroundImgView sd_setImageWithURL:[NSURL URLWithString:backgroundURL]
                              placeholderImage:nil options:SDWebImageRefreshCached];
    }
}

#pragma mark - AVAudioPlayer（声音播放）

//- (void)initializeAudioPlayer {
//    
//    // ipod 没声音 需设置 “set session category”
//    AVAudioSession *session = [AVAudioSession sharedInstance];
//    [session setCategory:AVAudioSessionCategoryAmbient error:nil];
//    
//    if (nil == _shakingAudioPlayer) {
//        NSURL *shakingSoundUrl = [[NSBundle mainBundle] URLForResource:@"shake_sound_kongfu" withExtension:@"mp3"];
//        if (nil != shakingSoundUrl) {
//            self.shakingAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:shakingSoundUrl error:nil];
//            [_shakingAudioPlayer prepareToPlay];
//        }
//    }
//    
//    if (nil == _shakedAudioPlayer) {
//        NSString *shakedSoundPath = [[NSBundle mainBundle] pathForResource:@"shake_match" ofType:@"mp3"];
//        if (nil != shakedSoundPath) {
//            self.shakedAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:shakedSoundPath]
//                                                                            error:nil];
//            [_shakedAudioPlayer prepareToPlay];
//        }
//    }
//}

//-(void)playSoundWhenShake:(NSInteger)tag
//{
//    if (0 == tag) {
//        
//        if ([_shakedAudioPlayer isPlaying]) {
//            [_shakingAudioPlayer stop];
//        }
//        [_shakingAudioPlayer play];
//    }else if (1 == tag) {
//        
//        if ([_shakedAudioPlayer isPlaying]) {
//            [_shakedAudioPlayer stop];
//        }
//        [_shakedAudioPlayer play];
//    }
//}

#pragma mark - 摇奖（动画、定时器）

- (void)startQueueLed {
    
    if (![self.queueLedTimer isValid]) {
        self.queueLedTimer = [NSTimer scheduledTimerWithTimeInterval:.06f
                                                              target:self
                                                            selector:@selector(startQueueLed)
                                                            userInfo:nil
                                                             repeats:YES];
    }else {
        
        if (__currQueueLedIndex > 1) {
            __currQueueLedIndex = 0;
        }
        
        _shakedLed0.hidden = (0 == __currQueueLedIndex) ? NO : YES;
        _shakedLed1.hidden = (0 == __currQueueLedIndex) ? YES : NO;
        
        __currQueueLedIndex++;
    }
    
}

- (void)stopQueueLed {
    
    if ([self.queueLedTimer isValid]) {
        [self.queueLedTimer invalidate];
        __currQueueLedIndex = 0;
    }
}

- (void)startWordAnimation {
    
    if (2 != _xibType) {
        return;
    }
    
    if (![self.wordAnimatedTimer isValid]) {
        self.wordAnimatedTimer  = [NSTimer scheduledTimerWithTimeInterval:.1f
                                                                   target:self
                                                                 selector:@selector(startWordAnimation)
                                                                 userInfo:nil
                                                                  repeats:YES];
    }else { // {{{
        
        _wordImgView.center = CGPointMake(_wordImgViewPos.x,_wordImgViewPos.y - 50.0f);
        _wordImgView.image  = [UIImage imageNamed:@"y1_shake_font_2.png"];
        
        UIImageView *__weak i_wordImgView = _wordImgView;
        
        [UIView animateWithDuration:.08f animations:^{
            i_wordImgView.center = CGPointMake(_wordImgViewPos.x,_wordImgViewPos.y + 30);
            
        } completion:^(BOOL finished) {
            i_wordImgView.center =_wordImgViewPos;
            
        }];
    } // }}}
}

- (void)stopWordAnimation {
    
    if ([self.wordAnimatedTimer isValid]) {
        [self.wordAnimatedTimer invalidate];
    }
    
   _wordImgView.image  = [UIImage imageNamed:@"y1_shake_font_1.png"];
}


// 当前状态下 是否可以继续摇动
- (BOOL)canableContunueShake {
    
    BOOL bCanableShake = NO;
    
    if (!__bOnceShakeShakeing
        && .0f == _workScrollView.contentOffset.x
        && (nil == _shareView
            || _shareView.isRemoved)
        && self.view.userInteractionEnabled) {
        
        bCanableShake = YES;
        
        NSArray *array = [UIApplication sharedApplication].keyWindow.subviews;
        for (id view in array) {
            if ([view isKindOfClass:NSClassFromString(@"QYaoMoreRuleView")]) {
                bCanableShake = NO;
                break;
            }
        }
    }
    return bCanableShake;
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
    if (motion == UIEventSubtypeMotionShake
        && [self canableContunueShake]) {
        
        // 计时 一次摇动
        __bOnceShakeShakeing         = YES;
        _shakedLed2.hidden           = YES;
        
        _role2ImgView.hidden         = YES;
        
        _queryActiveResultLbl.hidden = (1 == _xibType)?NO:YES;
        
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        
        [self updateViewUserInteractionEnabled:NO];
        [self updateShakePrizeResult:kQYaoYiYaoResultStateShakingPrize desc:nil];
        
        [self startQueueLed];
        [self startWordAnimation];
        //[self playSoundWhenShake:0];
        
        if (![self.onceShakeTimer isValid]) {
            self.onceShakeTimer = [NSTimer scheduledTimerWithTimeInterval:2.5f
                                                                   target:self
                                                                 selector:@selector(onceShakeCtrl)
                                                                 userInfo:nil
                                                                  repeats:NO];
        }
    }
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
    [self stopQueueLed];
    [self stopWordAnimation];
}

- (void)onceShakeCtrl {
    
    [self.onceShakeTimer invalidate];
    
    [self stopWordAnimation];
    
    if (![[UserCenter defaultCenter] isLogined]) {
        // 未登录
        [self showShakePrizeResult:kQYaoYiYaoResultStateNotBegin desc:nil];
        
    }else {
        // 执行抽奖
        [[self yaoJiangService] reqActiveChouJiang:self.activeTypeId];
    }
}

// 展示查询活动结果
- (void)showQueryActiveResultDesc:(NSString *)description err:(NSString *)errCode {
   
    // 云钻yaoyiyao 当前没有正在进行的活动 在底部提示，有活动的 活动段描述在底部显示
    // 大促yaoyiyao 都在底部显示
    
    if (nil != errCode && [errCode isEqualToString:@"e01"]) {
        // 当前没有正在进行的活动
        [self updateShakePrizeResult:kQYaoYiYaoResultStateNoActive desc:nil];
    }else {
        _queryActiveResultLbl.hidden = NO;
        _queryActiveResultLbl.text = description;
    }
    
    [self updateViewUserInteractionEnabled:YES];
}

- (void)updateShakePrizeResult:(kQYaoYiYaoResultStateType)type desc:(NSString *)description {
    
    [_shakedPrizeResultView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _resultButton.tag            = (NSInteger)type;
    _resultButton.hidden         = YES;
    
    if (type == kQYaoYiYaoResultStateCanCloneScore
        || type == kQYaoYiYaoResultStateCanCloneCloudTicket) {
        [_resultButton setTitle:L(@"CloneToFriend") forState:UIControlStateNormal];
    }else if (type == kQYaoYiYaoResultStateWiningNormalScore
              || type == kQYaoYiYaoResultStateWiningNormalCloudTicket) {
        [_resultButton setTitle:L(@"Share") forState:UIControlStateNormal];
    }
    
    QYaoYiYaoResultView *shakedView = nil;
    
    if (type == kQYaoYiYaoResultStateCanCloneCloudTicket
        || type == kQYaoYiYaoResultStateWiningNormalCloudTicket) { // 重奖 : 云券
        
        shakedView = [QYaoYiYaoResultView resultViewWithType:1];
        shakedView.valueLabel.text      = _activeResultBean.prizeValue;
        if (nil != _activeResultBean.prizeName && _activeResultBean.prizeName.length > 0) {
            shakedView.unitLabel.text = _activeResultBean.prizeName;
        }
        
        _resultButton.hidden = NO;
        
    }else if (type == kQYaoYiYaoResultStateCanCloneScore
              || type == kQYaoYiYaoResultStateWiningNormalScore) { // 重奖 : 云钻
        
        shakedView = [QYaoYiYaoResultView resultViewWithType:2];
        shakedView.valueLabel.text      = _activeResultBean.prizeValue;
        if (nil != _activeResultBean.prizeName && _activeResultBean.prizeName.length > 0) {
            shakedView.unitLabel.text = _activeResultBean.prizeName;
        }
        
        _resultButton.hidden = NO;
        
    }else if (type == kQYaoYiYaoResultStateShakeReadyGo) {
        
        shakedView = [QYaoYiYaoResultView resultViewWithType:3];
        [shakedView.valueLabel setText:((description == nil) ? L(@"PhoneYYYGetCoupon") : description)];
        _role2ImgView.hidden = YES;
        
    }else if (type == kQYaoYiYaoResultStateUnknown) {
        
        shakedView = [QYaoYiYaoResultView resultViewWithType:3];
        [shakedView.valueLabel setText:L(@"WrongTryAgain")];
        
    }else if (type == kQYaoYiYaoResultStateShakingPrize) {
        shakedView = [QYaoYiYaoResultView resultViewWithType:3];
        [shakedView.valueLabel setText:L(@"ShakingPrize")];
        
    }else if (type == kQYaoYiYaoResultStateNotBegin) {
        
        shakedView = [QYaoYiYaoResultView resultViewWithType:3];
        if (![[UserCenter defaultCenter] isLogined]) {
            [_resultButton setTitle:L(@"LoginTitle") forState:UIControlStateNormal];
            _resultButton.hidden = NO;
            [shakedView.valueLabel setText:((description == nil) ? L(@"LoginFirstBeforeJoinYYY") : description)];
        }else {
            [shakedView.valueLabel setText:((description == nil) ? L(@"PhoneYYYGetCoupon") : description)];
        }
    }else if (type == kQYaoYiYaoResultStateScoreNotEnough
              || type == kQYaoYiYaoResultStateActivityTimesLimited
              || type == kQYaoYiYaoResultStateNotWining) {
        
        shakedView = [QYaoYiYaoResultView resultViewWithType:3];
       if (type == kQYaoYiYaoResultStateScoreNotEnough) {
            [shakedView.valueLabel setText:((description == nil) ? /*@"您的云钻不足，您可以签到赚取云钻"*/L(@"HavenotEnoughCloudDiamond") : description)];
            [_resultButton setTitle:/*@"去签到"*/L(@"GoStroll") forState:UIControlStateNormal];
            _resultButton.hidden = NO;
        }else if (type == kQYaoYiYaoResultStateActivityTimesLimited) {
            [shakedView.valueLabel setText:((description == nil) ? L(@"EventTimesOutNextTime") : description)];
            [_resultButton setTitle:L(@"GoStroll") forState:UIControlStateNormal];
            _resultButton.hidden = NO;
            
        }else if (type == kQYaoYiYaoResultStateNotWining) {
            [shakedView.valueLabel setText:((description == nil) ? L(@"HearMeSomeoneBeGHSByYYY") : description)];
            [_resultButton setTitle:L(@"UpPersonality") forState:UIControlStateNormal];
            _resultButton.hidden = NO;
        }
    }else if (type == kQYaoYiYaoResultStateNoActive) {
        shakedView = [QYaoYiYaoResultView resultViewWithType:3];
        [shakedView.valueLabel setText:L(@"NowHaveNoEvent")];
        [_resultButton setTitle:L(@"GoStroll") forState:UIControlStateNormal];
        _resultButton.hidden = NO;
        _role2ImgView.hidden = YES;
    }else if (type == kQYaoYiYaoResultStateWiningPhyTicket) {  // 重奖 : 实物奖励
        
        if ([_activeResultBean.isShowNum isEqualToString:@"1"]) { // 展示云钻兑换码
            shakedView = [QYaoYiYaoResultView resultViewWithType:4];
            shakedView.valueLabel2.text = [NSString stringWithFormat:@"%@%@",L(@"ExchangeCode"),_activeResultBean.serialNumber];
            if (2 == _xibType) {
                // 大促 摇易摇
                shakedView.valueLabel2.textColor = [UIColor redColor];
            }
        }else {
            shakedView = [QYaoYiYaoResultView resultViewWithType:3];
        }
        
        shakedView.valueLabel.text  = [NSString stringWithFormat:@"%@%@",L(@"CongratulationYouGet"),_activeResultBean.prizeTypeName];
    
    }
    
    if (nil != shakedView) {
        [_shakedPrizeResultView addSubview:shakedView];
    }
}

- (void)showShakePrizeResult:(kQYaoYiYaoResultStateType)type desc:(NSString *)description {
    
    //[self playSoundWhenShake:1];
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
    CGRect frame = _shakedPrizeResultView.frame;
    _shakedPrizeResultView.frame = CGRectMake(frame.origin.x,frame.origin.y,frame.size.width,.0f);
    [UIView animateWithDuration:.5f animations:^{
        _shakedPrizeResultView.frame = frame;
    } completion:^(BOOL finished) {
        if (finished) {
            [self stopQueueLed];
            [self stopWordAnimation];
            
            [self updateShakePrizeResult:type desc:description];
            [self updateViewUserInteractionEnabled:YES];
            _shakedLed2.hidden   = NO;
            __bOnceShakeShakeing = NO;
        }
    }];
}

#pragma mark - 登录 @selector

// @selector of LoginViewController
// update current view state

- (void)loginSuccess {
    
    if (self.workScrollView.contentOffset.x < 10.0f) {
        // 摇奖 视图
    }else {
        // 云宝箱 视图
        [self loadCloudBoxData];
    }
    
    [self updateShakePrizeResult:kQYaoYiYaoResultStateShakeReadyGo desc:self.activeQueryBean.resultDesc];
    
    if (nil != _delegate
        && [_delegate respondsToSelector:@selector(delegate_YaoYiYaoViewCtrler_loginSuccess)]) {
        [_delegate delegate_YaoYiYaoViewCtrler_loginSuccess];
    }
}

- (void)loginCancel {
    
    // 回到 抽奖视图
    if (.0f != self.workScrollView.contentOffset.x) {
        [self.segment onClickedSegments:self.segment.segment0];
    }
    
}

#pragma mark - update UI (视图更新)

- (void)updateViewUserInteractionEnabled:(BOOL)bEnabled {
    
    self.view.userInteractionEnabled = bEnabled;
    self.resultButton.enabled        = bEnabled;
    self.moreRuleButton.enabled      = bEnabled;
    self.segment.segment1.enabled    = bEnabled;
}

#pragma mark - share(分享)

- (ChooseShareWayView *)shareView
{
    if (nil == _shareView) {
        _shareView = [[ChooseShareWayView alloc] initWithShareTypes:@[SNShareToWeiXin,SNShareToWeiXinFriend,SNShareToSinaWeibo,SNShareToTCWeiBo,SNShareToSMS]];
        _shareView.delegate = self;
    }
    
    return _shareView;
}

- (SNShareKit *)shareKit
{
    if (!_shareKit) {
        _shareKit = [[SNShareKit alloc] initWithNavigationController:self.navigationController];
        [_shareKit setShareTitle:L(@"ShakeEasyShake-Share")];
    }
    
    [_shareKit shareWithContent:self.activeResultBean.shareContent];
    
    return _shareKit;
}

- (void)chooseShareWay:(SNShareType)shareWay
{
    [self.shareKit didChooseShareWay:shareWay];
}

#pragma mark - QSegmentViewDelegate ...

// 云宝箱 tab 页面

- (void)loadCloudBoxData {
    
    NSString *userNum = [UserCenter defaultCenter].userInfoDTO.custNum;
    if (nil != userNum
        && userNum.length > 0) {
        
//        NSString *url = [kHostSuningMts stringByAppendingString:
//                         [NSString stringWithFormat:@"/ticket/cloudbox/%@.html",userNum]];
        // 2014/09/02 要求切换环境并更改
        NSString *url = [kEbuyWapHostURL stringByAppendingString:@"/ticket/cloudbox/cust.html"];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        [_cloudBoxWebView loadRequest:request];
    }
}

- (void)delegate_selectedSegment:(NSUInteger)segmentTag {
    
    CGPoint point = CGPointMake(segmentTag * self.workScrollView.bounds.size.width,
                                _workScrollView.contentOffset.y);
    
    [self removeOverFlowActivityView];
    
    if (1 == segmentTag) {
        // 切换到 云宝箱 需要先登录
        if (![[UserCenter defaultCenter] isLogined]) {
            // 未登录
            LoginViewController *ctrler = [[LoginViewController alloc] init];
            ctrler.loginDelegate            = self;
            ctrler.loginDidOkSelector       = @selector(loginSuccess);
            ctrler.loginDidCancelSelector   = @selector(loginCancel);
            ctrler.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            AuthManagerNavViewController *navCtrler = [[AuthManagerNavViewController alloc] initWithRootViewController:ctrler];
            [self presentModalViewController:navCtrler animated:YES];
        }else {
            // 已登录
            [self loadCloudBoxData];
        }
    }
    
    [self.workScrollView setContentOffset:point animated:YES];
}

- (IBAction)actionMoreRule {
    
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"521201"], nil]];
    QYaoMoreRuleView *moreRuleView = [QYaoMoreRuleView moreRuleView];
    [moreRuleView setVisible:YES animate:YES];
    [moreRuleView loadDataFromUrl:self.activeQueryBean.activeRuleUrl];
}


- (void)presentLoginViewCtrler {
    
    LoginViewController *ctrler = [[LoginViewController alloc] init];
    ctrler.loginDelegate            = self;
    ctrler.loginDidOkSelector       = @selector(loginSuccess);
    ctrler.loginDidCancelSelector   = @selector(loginCancel);
    ctrler.modalTransitionStyle     = UIModalTransitionStyleFlipHorizontal;
    AuthManagerNavViewController *navCtrler = [[AuthManagerNavViewController alloc] initWithRootViewController:ctrler];
    [self presentModalViewController:navCtrler animated:YES];
}

- (IBAction)actionClickedFootButton:(UIButton *)sender {
    
    kQYaoYiYaoResultStateType type = (kQYaoYiYaoResultStateType)sender.tag;
    if (type == kQYaoYiYaoResultStateNotBegin) {
        if (![[UserCenter defaultCenter] isLogined]) {
            [self presentLoginViewCtrler];
        }
    }else if (type == kQYaoYiYaoResultStateScoreNotEnough) {
        
//        // 去签到
//        [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"521001"], nil]];
//        
//        // 云钻不足，下一步 跳转到云钻乐园（不再跳到签到页面） xzoscar 2014/08/19
//        QYaoYiYaoScoreViewCtrler *ctrler = nil;
//        ctrler = [[QYaoYiYaoScoreViewCtrler alloc] initWithNibName:@"QYaoYiYaoScoreViewCtrler" bundle:nil];
//        [self.navigationController pushViewController:ctrler animated:YES];
        // 2014/09/01 修改 需求 要求去掉签到，此处改为 去逛逛
        [self.navigationController popToRootViewControllerAnimated:YES];
    
        
    }else if (type == kQYaoYiYaoResultStateActivityTimesLimited
              || type == kQYaoYiYaoResultStateNoActive) {
        
        // 去逛逛（跳到首页）
        if ([self.activeResultBean.resultCode isEqualToString:@"e03"])
        {
            [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"521301"], nil]];
        }
        else
        {
            [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"521101"], nil]];
        }
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }else if (type == kQYaoYiYaoResultStateNotWining) {
        [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"520901"], nil]];
        // ->提升人品（即本地分享）
        [self.shareView showChooseShareWayView];
        
    }else if (type == kQYaoYiYaoResultStateCanCloneScore
              || type == kQYaoYiYaoResultStateCanCloneCloudTicket) {
        [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"520701"], nil]];
        // 克隆 校验
        if (nil != self.activeResultBean.prizeId
            && nil != self.activeResultBean.cloneUrl) {
            
            [self displayOverFlowActivityView];
            [self updateViewUserInteractionEnabled:NO];
            [self.yaoJiangService reqActiveCloneValidate:self.activeTypeId
                                                 prizeId:self.activeResultBean.prizeId];
        }
        
    }else if (type == kQYaoYiYaoResultStateWiningNormalScore
              || type == kQYaoYiYaoResultStateWiningNormalCloudTicket) {
        // 分享
        [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"520801"], nil]];
        [self.shareView showChooseShareWayView];
    }
}

@end
