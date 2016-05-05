//
//  VoiceSearchViewController.m
//  SuningEBuy
//
//  Created by chupeng on 14-9-19.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "VoiceSearchViewController.h"

#define APPID_VALUE @"541bcbfa"
#define URL_VALUE             @""                 // url
#define TIMEOUT_VALUE         @"20000"            // timeout      连接超时的时间，以ms为单位
#define BEST_URL_VALUE        @"1"                // best_search_url 最优搜索路径


#define SEARCH_AREA_VALUE     L(@"AnhuiProvinceHefeiCity")
#define ASR_PTT_VALUE         @"1"
#define VAD_BOS_VALUE         @"5000"
#define VAD_EOS_VALUE         @"1800"
#define PLAIN_RESULT_VALUE    @"1"
#define ASR_SCH_VALUE         @"1"

#import "iflyMSC/IFlySpeechUtility.h"
#import "iflyMSC/IFlySpeechRecognizer.h"
#import "ISRDataHelper.h"
#import "iflyMSC/IFlyResourceUtil.h"
#import "RecognizerFactory.h"
#import <AVFoundation/AVFoundation.h>

#import <math.h>
@interface VoiceSearchViewController ()

@end

@implementation VoiceSearchViewController

+ (VoiceSearchViewController *)sharedVoiceSearchCtrl
{
    static dispatch_once_t onceToken;
    static VoiceSearchViewController *voiceController = nil;
    dispatch_once(&onceToken, ^{
        voiceController = [[self alloc] init];
    });
    
    return voiceController;
}

- (void)showVoiceSearchView
{
    if (![self canRecord])
    {
        BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"system-error")
                                                        message:L(@"open-mircophone")
                                                       delegate:nil
                                              cancelButtonTitle:L(@"Ok")
                                              otherButtonTitles:nil];
        [alert show];
        
        return;
    }
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.view];
    [window bringSubviewToFront:self.view];
    
    self.state = STATE_Listening;
    [self startListen];
}

- (BOOL)canRecord
{
    __block BOOL bCanRecord = YES;
    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)
    {
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
            [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
                if (granted) {
                    bCanRecord = YES;
                } else {
                    bCanRecord = NO;
                }
            }];
        }
    }
    return bCanRecord;
}

- (void)removeVoiceSearchView
{
    if (self.view.superview)
    {
        [self.view removeFromSuperview];
        
        
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.imgViewAnimation.center = self.btnSpeaker.center;
    self.btnCloseBig.center = self.btnClose.center;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.labelTopTip];
    [self.view addSubview:self.labelKeyWord];
    [self.view addSubview:self.labelBottomTip];
    [self.view addSubview:self.btnClose];
    [self.view addSubview:self.imgViewAnimation];
    [self.view addSubview:self.btnCloseBig];
    [self.view addSubview:self.btnSpeaker];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)arrayAnimationListening
{
    if (!_arrayAnimationListening)
    {
        _arrayAnimationListening = [NSMutableArray array];
        for (int i = 1; i <= 18; i++)
        {
            NSString *strName = [NSString stringWithFormat:@"Animation-%d@2x.png", i];
            UIImage *image = [UIImage imageNamed:strName];
            if (image)
                [_arrayAnimationListening addObject:image];
        }
    }
    
    return _arrayAnimationListening;
}

- (NSMutableArray *)arrayAnimationSearching
{
    if (!_arrayAnimationSearching)
    {
        _arrayAnimationSearching = [NSMutableArray array];
        for (int i = 1; i <= 18; i++)
        {
            NSString *strName = [NSString stringWithFormat:@"Animation-%d@2x.png", i];
            UIImage *image = [UIImage imageNamed:strName];
            if (image)
                [_arrayAnimationSearching addObject:image];
        }
    }
    
    return _arrayAnimationSearching;
}

- (NSMutableArray *)arrayAnimationEnding
{
    if (!_arrayAnimationEnding)
    {
        _arrayAnimationEnding = [NSMutableArray array];
        for (int i = 21; i <= 25; i++)
        {
            NSString *strName = [NSString stringWithFormat:@"Animation-%d@2x.png", i];
            UIImage *image = [UIImage imageNamed:strName];
            if (image)
                [_arrayAnimationEnding addObject:image];
        }
    }
    
    return _arrayAnimationEnding;
}


#pragma mark - UI
- (UILabel *)labelTopTip
{
    if (!_labelTopTip)
    {
        _labelTopTip = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 320, 20)];
        _labelTopTip.backgroundColor = [UIColor clearColor];
        _labelTopTip.textAlignment = NSTextAlignmentCenter;
        _labelTopTip.textColor = [UIColor colorWithRGBHex:0x313131];
        _labelTopTip.font = [UIFont systemFontOfSize:16];
        _labelTopTip.text = L(@"Search_SpeakGoodsOrStore");
        
    }
    
    return _labelTopTip;
}

- (UILabel *)labelKeyWord
{
    if (!_labelKeyWord)
    {
        _labelKeyWord = [[UILabel alloc] initWithFrame:CGRectMake(0, 145, 320, 20)];
        _labelKeyWord.backgroundColor = [UIColor clearColor];
        _labelKeyWord.textAlignment = NSTextAlignmentCenter;
        _labelKeyWord.textColor = [UIColor colorWithRGBHex:0x313131];
        _labelKeyWord.font = [UIFont systemFontOfSize:16];
        
    }
    
    return _labelKeyWord;
}

- (UILabel *)labelBottomTip
{
    if (!_labelBottomTip)
    {
        _labelBottomTip = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.height - 25, 320, 20)];
        _labelBottomTip.backgroundColor = [UIColor clearColor];
        _labelBottomTip.textAlignment = NSTextAlignmentCenter;
        _labelBottomTip.textColor = [UIColor colorWithRGBHex:0xd2d2d2];
        _labelBottomTip.font = [UIFont systemFontOfSize:13];
        _labelBottomTip.text = L(@"Search_TheCoreTechnologyProvidedByiFLYTEK");
    }
    
    return _labelBottomTip;
}

- (UIButton *)btnSpeaker
{
    if (!_btnSpeaker)
    {
        _btnSpeaker = [[UIButton alloc] initWithFrame:CGRectMake(120, self.view.height - 178, 80, 80)];
        _btnSpeaker.backgroundColor = [UIColor clearColor];
        [_btnSpeaker addTarget:self action:@selector(btnSpeakerTapped) forControlEvents:UIControlEventTouchUpInside];
        [_btnSpeaker setBackgroundImage:[UIImage imageNamed:@"VoiceSearch_SpeakerNormal"] forState:UIControlStateNormal];
    }
    
    return _btnSpeaker;
}

- (void)btnSpeakerTapped
{
    if (self.state == STATE_Listening)
    {
        [self startListen];
    }
    else if (self.state == STATE_Searching)
    {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(showSearchStateAndGoSearch) object:nil];
        [self startListen];
        self.state = STATE_Listening;
    }
    else if (self.state == STATE_ERROR)
    {
        [self startListen];
        self.state = STATE_Listening;
    }
    else if (self.state == STATE_GRAY)
    {
        [self startListen];
        self.state = STATE_Listening;
    }
    else if (self.state == STATE_NORMAL)
    {
        [self startListen];
        self.state = STATE_Listening;
    }
    
}

- (void)updateUI
{
    switch (self.state) {
        case STATE_Listening:
        {
            self.labelTopTip.text = L(@"Search_SpeakGoodsOrStore");
            self.labelKeyWord.text = @"";
            
            [self.btnSpeaker setBackgroundImage:[UIImage imageNamed:@"button-Microphone-normal"] forState:UIControlStateNormal];
    
            self.imgViewAnimation.image = nil;
            self.imgViewAnimation.transform = CGAffineTransformIdentity;
            self.imgViewAnimation.animationImages = self.arrayAnimationListening;
            self.imgViewAnimation.animationDuration = 1.8;
            self.imgViewAnimation.animationRepeatCount = 0;
            [self.imgViewAnimation startAnimating];
            break;
        }
        case STATE_Searching:
        {
            self.labelTopTip.text = L(@"Search_Recognising");
            self.labelKeyWord.text = @"";
            
            [self.btnSpeaker setBackgroundImage:[UIImage imageNamed:@"button-Microphone-normal"] forState:UIControlStateNormal];
         
            self.imgViewAnimation.animationImages = nil;
            [self.imgViewAnimation stopAnimating];
            
            
            self.imgViewAnimation.image = [UIImage imageNamed:@"Animation-19.png"];
            
            CABasicAnimation* rotationAnimation;
            rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
            rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
            rotationAnimation.duration = 1;
            rotationAnimation.cumulative = YES;
            rotationAnimation.repeatCount = 1;
            rotationAnimation.removedOnCompletion = YES;
            rotationAnimation.delegate = self;
            
            [self.imgViewAnimation.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
            break;
        }
        case STATE_ERROR:
        {
            self.labelKeyWord.text = @"";
            
            [self.btnSpeaker setBackgroundImage:[UIImage imageNamed:@"button-Microphone-normal"] forState:UIControlStateNormal];
            
            self.imgViewAnimation.image = nil;
            self.imgViewAnimation.transform = CGAffineTransformIdentity;
            self.imgViewAnimation.animationImages = nil;
            break;
        }
        case STATE_GRAY:
        {
            self.labelTopTip.text = [NSString stringWithFormat:@"%@:",L(@"Search_Searching")];
            self.labelKeyWord.text = self.result;
            
            [self.btnSpeaker setBackgroundImage:[UIImage imageNamed:@"button-Microphone-gray"] forState:UIControlStateNormal];
            
            
            self.imgViewAnimation.image = nil;
            self.imgViewAnimation.transform = CGAffineTransformIdentity;
            self.imgViewAnimation.animationImages = nil;
            break;
        }
        case STATE_NORMAL:
        {
            self.labelTopTip.text = L(@"Search_NotRecogniseYourVoice");

            
            [self.btnSpeaker setBackgroundImage:[UIImage imageNamed:@"button-Microphone-normal"] forState:UIControlStateNormal];
            
            self.imgViewAnimation.image = nil;
            self.imgViewAnimation.transform = CGAffineTransformIdentity;
            self.imgViewAnimation.animationImages = nil;
            break;
        }

        default:
            break;
    }
}

//识别的转圈动画完了后，还要有个收起动画
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if ([anim isKindOfClass:[CABasicAnimation class]])
    {
        self.imgViewAnimation.image = [UIImage imageNamed:@"Animation-20.png"];
        self.imgViewAnimation.transform = CGAffineTransformIdentity;
        self.imgViewAnimation.animationImages = self.arrayAnimationEnding;
        self.imgViewAnimation.animationDuration = 0.6;
        self.imgViewAnimation.animationRepeatCount = 1;
        [self.imgViewAnimation startAnimating];
    }
}

- (UIButton *)btnClose
{
    if (!_btnClose)
    {
        _btnClose = [[UIButton alloc] initWithFrame:CGRectMake(320 - 21 - 23, 35, 23, 23)];
        _btnClose.backgroundColor = [UIColor clearColor];
        [_btnClose addTarget:self action:@selector(btnCloseTapped) forControlEvents:UIControlEventTouchUpInside];
        [_btnClose setBackgroundImage:[UIImage imageNamed:@"VoiceSearch_CloseBtn"] forState:UIControlStateNormal];
    }
    
    return _btnClose;
}

- (UIButton *)btnCloseBig
{
    if (!_btnCloseBig)
    {
        _btnCloseBig = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
        _btnCloseBig.backgroundColor = [UIColor clearColor];
        [_btnCloseBig addTarget:self action:@selector(btnCloseTapped) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _btnCloseBig;
}


- (void)btnCloseTapped
{
    [self.iFlySpeechRecognizer cancel];
//    [self.iFlySpeechRecognizer setDelegate: nil];
    [self removeVoiceSearchView];
}

- (UIImageView*)imgViewAnimation
{
    if (!_imgViewAnimation)
    {
        _imgViewAnimation = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imgViewAnimation.contentMode = UIViewContentModeCenter;

        _imgViewAnimation.frame = CGRectMake((320 - 225) / 2, self.view.height - 220, 225, 225);
        _imgViewAnimation.animationDuration = 1.8 ;
    }
    
    return _imgViewAnimation;
}


- (IFlySpeechRecognizer*)iFlySpeechRecognizer
{
    if (!_iFlySpeechRecognizer)
    {
        //创建识别
        _iFlySpeechRecognizer = [RecognizerFactory CreateRecognizer:self Domain:@"iat"];
    }
    
    return _iFlySpeechRecognizer;
}

- (void)startListen
{
    self.labelKeyWord.text = @"";
    self.result = @"";
    //设置为录音模式
    [self.iFlySpeechRecognizer setParameter:IFLY_AUDIO_SOURCE_MIC forKey:@"audio_source"];
    [self.iFlySpeechRecognizer setParameter:@"3000" forKey:@"vad_bos"];
    [self.iFlySpeechRecognizer setParameter:@"700" forKey:@"vad_eos"];
    [self.iFlySpeechRecognizer setParameter:@"0" forKey:@"asr_ptt"];
    if (self.iFlySpeechRecognizer.isListening)
    {
        self.labelTopTip.text = L(@"Search_ClickTooMuch");
        [self performSelector:@selector(restoreText) withObject:@"restoreText" afterDelay:0.5];
    }
    else
    {
        bool ret = [self.iFlySpeechRecognizer startListening];
        
        if (ret) {
            DLog(@"打开监听 成功");
            
            [self performSelector:@selector(stopListen) withObject:nil afterDelay:15];//15秒后关闭录音，避免网络差的时候一直在录
        }
        else
        {
            DLog(@"打开监听 失败");
        }
    }
}

- (void)restoreText
{
    self.labelTopTip.text = L(@"Search_SpeakGoodsOrStore");
}

- (void)stopListen
{
    [self.iFlySpeechRecognizer stopListening];
}

- (void)cancelListen
{
    [self.iFlySpeechRecognizer cancel];
}

#pragma mark - 识别回调

//{"sn":1,"ls":false,"bg":0,"ed":0,"ws":[{"bg":0,"cw":[{"w":"还是","sc":0.00}]}]}
- (void) onResults:(NSArray *) results isLast:(BOOL)isLast
{

    NSMutableString *resultString = [[NSMutableString alloc] init];
    
    NSDictionary *dic = results[0];
    
    for (NSString *key in dic) {
        [resultString appendFormat:@"%@",key];
    }

    NSString * resultFromJson =  [[ISRDataHelper shareInstance] getResultFromJson:resultString];

    self.result = [NSString stringWithFormat:@"%@%@", self.result, resultFromJson];;
    if (isLast)
    {
        if (!IsStrEmpty(self.result))
        {
            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(showSearchStateAndGoSearch) object:nil];
            self.state = STATE_Searching;
            [self performSelector:@selector(showSearchStateAndGoSearch) withObject:nil afterDelay:1.6];//识别加收起的总动画时间
        }
    }
}

- (void)showSearchStateAndGoSearch
{
    self.state = STATE_GRAY;
    self.labelKeyWord.text = self.result;
    
    [self performSelector:@selector(goSearch) withObject:nil afterDelay:1];//1秒是给用户在进入搜索前看当前的识别结果
}

- (void)goSearch
{
    [[NSNotificationCenter defaultCenter] postNotificationName:VOICE_SEARCH object:nil];
}

//
//1）	请说出您想要的商品名称！
//（1）	亲，正在识别中...
//
//（1）	提示文案：“正在为您搜索：”
//用户搜索词文案：华为P6
//
//（1）	亲，未识别出您的语音，请点击话筒重新开始！
//（1）	亲，服务器正忙，请您稍后重试！
//（1）	亲，您点击太频繁了，请稍后重试！

- (void) onError:(IFlySpeechError *) error
{
    NSString *text ;
    
    if (self.isCanceled)
    {
        text = L(@"Search_RecogniseCancel");
    }
    else if (error.errorCode == 0 )
    {
        if (_result.length==0)
        {
            text = L(@"Search_NoRecogniseResult");
            
            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(restoreText) object:@"restoreText"];
            self.state = STATE_ERROR;
            
            self.labelTopTip.text = L(@"Search_NotRecogniseYourVoice2");
        }
        else
        {
            text = L(@"Search_RecogniseSuccess");
        }
    }
    else if (error.errorCode == 20001 || error.errorCode == 20002 || error.errorCode == 20003) //
    {
        text = L(@"Search_ServerIsBusy");
        
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(restoreText) object:@"restoreText"];
        self.state = STATE_ERROR;
        self.labelTopTip.text = text;
    }
    else
    {
        text = L(@"Search_NotRecogniseYourVoice2");
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(restoreText) object:@"restoreText"];
        self.state = STATE_ERROR;
        self.labelTopTip.text = text;
    }
}

- (void) onCancel
{
    NSLog(L(@"Search_RecogniseCancel"));
}

/**
 * @fn      onBeginOfSpeech
 * @brief   开始识别回调
 *
 * @see
 */
- (void) onBeginOfSpeech
{
    
}


/**
 * @fn      onEndOfSpeech
 * @brief   停止录音回调
 *
 * @see
 */
- (void) onEndOfSpeech
{

    
}

- (void)setState:(STATE_UI)state
{
    _state = state;
    [self updateUI];
    
}
@end
