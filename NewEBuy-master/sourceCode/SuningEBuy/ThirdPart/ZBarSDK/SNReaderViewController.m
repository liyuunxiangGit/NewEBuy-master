//
//  EmbedReaderViewController.m
//  SuningEBuy
//
//  Created by 刘坤 on 11-12-13.
//  Copyright (c) 2011年 Suning. All rights reserved.
//

#import "SNReaderViewController.h"
#import <AVFoundation/AVFoundation.h>

#define kSNReaderScanWidth      260
#define kSNReaderScanHeight     260

@interface SNReaderViewController ()
{
    BOOL isScrolling;
}
@end

@implementation SNReaderViewController

@synthesize toolBar = _toolBar;

@synthesize readerView = _readerView;

@synthesize snDelegate = _snDelegate;

@synthesize isServicePay = isServicePay_;
/*
 date:2012-4-20
 auther:zhaofk
 reason:2.0优化：条形码少秒增加4个lable
 */
@synthesize headerLabel = _headerLabel;
@synthesize footerLabel = _footerLabel;
@synthesize rightLabel=_rightLabel;
@synthesize leftLabel=_leftLabel;

- (id)init
{
    self = [super init];
    
    if (self)
    {
        self.isServicePay = NO;
        
        [[NSNotificationCenter defaultCenter] addObserver: self
                                                 selector: @selector(onVideoStart:)
                                                     name: AVCaptureSessionDidStartRunningNotification
                                                   object: nil];
        [[NSNotificationCenter defaultCenter] addObserver: self
                                                 selector: @selector(onVideoStop:)
                                                     name: AVCaptureSessionDidStopRunningNotification
                                                   object: nil];
        [[NSNotificationCenter defaultCenter] addObserver: self
                                                 selector: @selector(onVideoStop:)
                                                     name: AVCaptureSessionWasInterruptedNotification
                                                   object: nil];
        [[NSNotificationCenter defaultCenter] addObserver: self
                                                 selector: @selector(onVideoStart:)
                                                     name: AVCaptureSessionInterruptionEndedNotification
                                                   object: nil];
    }
    return self;
}

- (void)dealloc
{
    self.readerView.readerDelegate = nil;
    TT_RELEASE_SAFELY(_readerView);
    
    TT_RELEASE_SAFELY(_toolBar);
    /*
     date:2012-4-20
     auther:zhaofk
     reason:2.0优化：条形码少秒增加4个lable
     */
    TT_RELEASE_SAFELY(_headerLabel);
    TT_RELEASE_SAFELY(_footerLabel);
    TT_RELEASE_SAFELY(_leftLabel);
    TT_RELEASE_SAFELY(_rightLabel);
    
    TT_INVALIDATE_TIMER(_timer);
}

- (void)loadView
{
    [super loadView];
    
    [self setWantsFullScreenLayout:YES];
    
    self.readerView.frame = self.view.bounds;
    [self.view addSubview:self.readerView];
    
    self.toolBar.bottom = [UIScreen mainScreen].bounds.size.height;
    /*
     date:2012-4-20
     auther:zhaofk
     reason:2.0优化：条形码少秒增加4个lable
     */
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    
    CGFloat vLblHeight = (screenHeight-kSNReaderScanHeight)/2;
    self.headerLabel.frame = CGRectMake(0, 0, screenWidth, vLblHeight);
    self.footerLabel.frame = CGRectMake(0, screenHeight-vLblHeight, screenWidth, vLblHeight);
    
    CGFloat hLblWidth = (screenWidth-kSNReaderScanWidth)/2;
    self.leftLabel.frame = CGRectMake(0, vLblHeight, hLblWidth, kSNReaderScanHeight);
    self.rightLabel.frame = CGRectMake(screenWidth-hLblWidth, vLblHeight, hLblWidth, kSNReaderScanHeight);
    
    CGRect cropRect = CGRectMake(hLblWidth, vLblHeight, kSNReaderScanWidth, kSNReaderScanHeight);
    self.cropRect = cropRect;
    self.readerView.scanCrop = CGRectMake(cropRect.origin.y/self.readerView.height, cropRect.origin.x/self.readerView.width, cropRect.size.height/self.readerView.height, cropRect.size.width/self.readerView.width);

    [self.view.layer addSublayer:self.headerLabel];
    [self.view.layer addSublayer:self.footerLabel];
    [self.view.layer addSublayer:self.rightLabel];
    [self.view.layer addSublayer:self.leftLabel];
    
    self.toolBar.bottom = self.view.bounds.size.height;
    self.toolBar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [self.view addSubview:self.toolBar];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, vLblHeight-70, 260, 70)];
    label.font = [UIFont systemFontOfSize:16.0];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.text = L(@"ZBar_Reader_Mention");
    label.numberOfLines = 3;
    label.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:label];
    
    //添加四个小图片
    {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"ScanQR1.png"];
        imageView.frame = CGRectMake(CGRectGetMinX(cropRect)-4, CGRectGetMinY(cropRect)-4, 16, 16);
        [self.view addSubview:imageView];
    }
    {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"ScanQR2.png"];
        imageView.frame = CGRectMake(CGRectGetMaxX(cropRect)-12, CGRectGetMinY(cropRect)-4, 16, 16);
        [self.view addSubview:imageView];
    }
    {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"ScanQR3.png"];
        imageView.frame = CGRectMake(CGRectGetMinX(cropRect)-4, CGRectGetMaxY(cropRect)-12, 16, 16);
        [self.view addSubview:imageView];
    }
    {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"ScanQR4.png"];
        imageView.frame = CGRectMake(CGRectGetMaxX(cropRect)-12, CGRectGetMaxY(cropRect)-12, 16, 16);
        [self.view addSubview:imageView];
    }
}

- (void)startScrollBar
{
    self.scrollBar.hidden = NO;
    isScrolling = YES;
    self.scrollBar.frame = CGRectMake(self.cropRect.origin.x, CGRectGetMinY(self.cropRect), self.scrollBar.frame.size.width, self.scrollBar.frame.size.height);
    [self setScrollBarPositionAnimatied];
}

- (void)stopScrollBar
{
    self.scrollBar.hidden = YES;
    isScrolling = NO;
}

- (void)setScrollBarPositionAnimatied
{
    if (isScrolling)
    {
        [UIView animateWithDuration:2.0f delay:0.0f
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             
                             self.scrollBar.frame = CGRectMake(self.cropRect.origin.x, CGRectGetMaxY(self.cropRect) - 7, self.scrollBar.frame.size.width, self.scrollBar.frame.size.height);
                             
                         } completion:^(BOOL finished) {
                             
                             self.scrollBar.frame = CGRectMake(self.cropRect.origin.x, CGRectGetMinY(self.cropRect), self.scrollBar.frame.size.width, self.scrollBar.frame.size.height);
                             
                             [self setScrollBarPositionAnimatied];
                         }];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    [self.readerView flushCache];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self startReader];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:NO];
    
    //检查用户是否禁止使用相机
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
#ifdef __IPHONE_7_0
        
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusDenied)
        {
            BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"AlertSystemPrompts")
                                                            message:L(@"Search_PleaseOpenCamera")
                                                           delegate:nil
                                                  cancelButtonTitle:L(@"Ok")
                                                  otherButtonTitles:nil];
            [alert setCancelBlock:^{
                
                [self CancelClicked:nil];
            }];
            [alert show];
        }
#else
        AVCaptureDevice* inputDevice =
        [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        AVCaptureDeviceInput *captureInput =
        [AVCaptureDeviceInput deviceInputWithDevice:inputDevice error:nil];
        
        if (!captureInput)
        {
            BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"AlertSystemPrompts")
                                                            message:L(@"Search_PleaseOpenCamera")
                                                           delegate:nil
                                                  cancelButtonTitle:L(@"Ok")
                                                  otherButtonTitles:nil];
            [alert setCancelBlock:^{
                
                [self CancelClicked:nil];
            }];
            [alert show];
        }
#endif
        
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:NO];
    //[self.readerView flushCache];
    [self stopReader];
}
//头部影阴
- (CALayer *)headerLabel
{
    if (!_headerLabel)
    {
        _headerLabel = [[CALayer alloc] init];
        _headerLabel.frame = CGRectMake(0, 0, 320, 90);
        _headerLabel.backgroundColor=RGBACOLOR(102, 102, 102, 0.7).CGColor;
        
    }
    return _headerLabel;
}

//底部影阴
- (CALayer *)footerLabel
{
    if (!_footerLabel)
    {
        _footerLabel = [[CALayer alloc] init];
        _footerLabel.frame = CGRectMake(0, 330, 320, 250);
        _footerLabel.backgroundColor=RGBACOLOR(102, 102, 102, 0.7).CGColor;
    }
    return _footerLabel;
}
//头部影阴
- (CALayer *)rightLabel
{
    if (!_rightLabel)
    {
        _rightLabel = [[CALayer alloc] init];
        _rightLabel.frame = CGRectMake(300, 90, 20, 240);
        _rightLabel.backgroundColor=RGBACOLOR(102, 102, 102, 0.7).CGColor;
    }
    return _rightLabel;
}

//底部影阴
- (CALayer *)leftLabel
{
    if (!_leftLabel)
    {
        _leftLabel = [[CALayer alloc] init];
        _leftLabel.frame = CGRectMake(0, 90, 20, 240);
        _leftLabel.backgroundColor=RGBACOLOR(102, 102, 102, 0.7).CGColor;
    }
    return _leftLabel;
}


- (ZBarReaderView *)readerView
{
    if (!_readerView)
    {
        _readerView = [[ZBarReaderView alloc] init];
        
        _readerView.readerDelegate = self;
        
        _readerView.maxZoom = 4;
    }
    return _readerView;
}

- (UIToolbar *)toolBar
{
    if (!_toolBar)
    {
        _toolBar= [[UIToolbar alloc] init];
        
        
        
        [_toolBar sizeToFit];
        
        if ( IOS7_OR_LATER )
        {
            _toolBar.barStyle = UIBarStyleBlack;
            _toolBar.barTintColor = [UIColor whiteColor];
            _toolBar.translucent = YES;
        }
        else
        {
            _toolBar.barStyle = UIBarStyleBlackTranslucent;
            _toolBar.tintColor = [UIColor whiteColor];
        }
        
        UIButton *btnCancel = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        [btnCancel setImage:[UIImage imageNamed:@"nav_back_normal"] forState:UIControlStateNormal];
        [btnCancel setImage:[UIImage imageNamed:@"nav_back_select"] forState:UIControlStateHighlighted];
        [btnCancel addTarget:self action:@selector(CancelClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIButton *btnHistory = [[UIButton alloc] initWithFrame:CGRectMake(248, 5, 114 / 2, 34)];
        btnHistory.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [btnHistory setTitle:L(@"Search_ScanRecord") forState:UIControlStateNormal];
        [btnHistory setTitleColor:[UIColor colorWithRed:224 / 255.0 green:127 / 255.0 blue:56 / 255.0 alpha:1.0] forState:UIControlStateNormal];
        [btnHistory setTitleColor:[UIColor colorWithRed:224 / 255.0 green:127 / 255.0 blue:56 / 255.0 alpha:1.0] forState:UIControlStateHighlighted];
        [btnHistory addTarget:self action:@selector(DoneClicked:) forControlEvents:UIControlEventTouchUpInside];
        btnHistory.layer.borderWidth = 0.5;
        btnHistory.layer.borderColor = [UIColor colorWithRed:224 / 255.0 green:127 / 255.0 blue:56 / 255.0 alpha:1.0].CGColor;
        
        [_toolBar addSubview:btnCancel];
        [_toolBar addSubview:btnHistory];
    }
    
    return _toolBar;
}

- (UIImageView *)scrollBar
{
    if (!_scrollBar) {
        _scrollBar = [[UIImageView alloc] init];
        _scrollBar.frame = CGRectMake(0, 0, kSNReaderScanWidth, 9);
        //_scrollBar.backgroundColor = [UIColor colorWithRGBHex:0xffb400];
        //ZXing_AnimateBar@2x
        _scrollBar.image = [UIImage imageNamed:@"ZXing_AnimateBar"];
        _scrollBar.contentMode = UIViewContentModeScaleToFill;
//        _scrollBar.layer.shadowColor = [UIColor greenColor].CGColor;
//        _scrollBar.layer.shadowOffset = CGSizeMake(1, 1);
//        _scrollBar.layer.shadowOpacity = 0.5;
//        _scrollBar.layer.shadowRadius = 5;
        [self.view addSubview:_scrollBar];
    }
    return _scrollBar;
}

- (void)CancelClicked:(id)sender
{
    if (IOS5_OR_LATER)
    {
        [self dismissViewControllerAnimated:YES completion:^{
            
            [self afterDismiss];
        }];
    }
    else
    {
        [self dismissModalViewControllerAnimated:NO];
        [self afterDismiss];
    }
}

- (void)DoneClicked:(id)sender
{
    if ([_snDelegate conformsToProtocol:@protocol(SNReaderDelegate)])
    {
        if ([_snDelegate respondsToSelector:@selector(goToScanHistory)])
        {
            [_snDelegate goToScanHistory];
        }
    }
}


- (void)readerView:(ZBarReaderView *)readerView didReadSymbols:(ZBarSymbolSet *)symbols fromImage:(UIImage *)image
{
    if ([_snDelegate conformsToProtocol:@protocol(SNReaderDelegate)])
    {
        if ([_snDelegate respondsToSelector:@selector(readerView:didReadSymbols:fromImage:)])
        {
            [_snDelegate readerView:readerView didReadSymbols:symbols fromImage:image];
        }
        
    }
}

//二维码扫描跳转抢购商品详情页
#pragma mark - Delegate Method

- (void)afterDismiss
{
    if ([_snDelegate respondsToSelector:@selector(snReaderDismissByCancel)]) {
        [_snDelegate snReaderDismissByCancel];
    }
}

- (void)showMessage
{
    [self displayOverFlowActivityView];
}

-(void)showMessage:(NSString *)string
{
    NSString* str = nil;
    NSString* strR = nil;
    if (!string)
    {
        str = L(@"Go on reading");
        strR = L(@"Return home");
    }
    else
    {
        str = L(@"Ok");
    }
    BBAlertView *alertView = [[BBAlertView alloc]initWithStyle:BBAlertViewStyleDefault Title:L(@"system-error")  message:IsStrEmpty(string)?L(@"Can not match the Dimensional code!"):string customView:nil delegate:nil cancelButtonTitle:str otherButtonTitles:strR ];
    
    [alertView setConfirmBlock:^{
        
        if (IOS5_OR_LATER) {
            [self dismissViewControllerAnimated:YES completion:^{
                
                [self afterDismiss];
            }];
        }else{
            [self dismissModalViewControllerAnimated:NO];
            
            [self afterDismiss];
        }
        
    }];
    
    [alertView setCancelBlock:^{
        
        [self startReader];
        
    }];
    
    [alertView show];
    
    TT_RELEASE_SAFELY(alertView);
}

- (void)startReader
{
    [self.readerView start];
}

- (void)stopReader
{
    [self.readerView stop];
}

- (void)onVideoStart: (NSNotification*) note
{
    [self startScrollBar];
}

- (void)onVideoStop: (NSNotification*) note
{
    [self stopScrollBar];
}

@end
