//
//  SNReaderViewControllerIOS7.m
//  SuningEBuy
//
//  Created by liukun on 14-8-25.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "SNReaderViewControllerIOS7.h"
#import <AVFoundation/AVFoundation.h>

#define kSNReaderScanWidth      240
#define kSNReaderScanHeight     240

@interface SNReaderViewControllerIOS7 () <AVCaptureMetadataOutputObjectsDelegate>
{
    dispatch_queue_t _queue;
    BOOL             _isBarScrolling;
    CGRect           _cropRect;
    BOOL             _scanFinished;
}

@property (nonatomic, strong) UIImageView *scrollBar;   //滚动条
@property (nonatomic, strong) UIToolbar *toolBar;
@property (nonatomic, strong) CALayer *headerLabel;      //视图上面的影阴
@property (nonatomic, strong) CALayer *footerLabel;      //视图下面的影阴
@property (nonatomic, strong) CALayer *rightLabel;      //视图右面的影阴
@property (nonatomic, strong) CALayer *leftLabel;      //视图左面的影阴


@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *prevLayer;
@property (nonatomic, strong) AVCaptureMetadataOutput *captureOutput;

@end

@implementation SNReaderViewControllerIOS7

- (void)dealloc
{
    dispatch_release(_queue);
}

- (instancetype)init
{
    self = [super init];
    if (self) {
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
        
        _queue = dispatch_queue_create("com.suning.SNReader", NULL);
        
        self.iOS7FullScreenLayout = YES;
        
        self.pageTitle = L(@"QRCodeScan");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    self.toolBar.bottom = [UIScreen mainScreen].bounds.size.height;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    
    CGFloat vLblHeight = (screenHeight-kSNReaderScanHeight)/2;
    self.headerLabel.frame = CGRectMake(0, 0, screenWidth, vLblHeight);
    self.footerLabel.frame = CGRectMake(0, screenHeight-vLblHeight, screenWidth, vLblHeight);
    
    CGFloat hLblWidth = (screenWidth-kSNReaderScanWidth)/2;
    self.leftLabel.frame = CGRectMake(0, vLblHeight, hLblWidth, kSNReaderScanHeight);
    self.rightLabel.frame = CGRectMake(screenWidth-hLblWidth, vLblHeight, hLblWidth, kSNReaderScanHeight);
    
    CGRect cropRect = CGRectMake(hLblWidth, vLblHeight, kSNReaderScanWidth, kSNReaderScanHeight);
    _cropRect = cropRect;
    
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
    
    [self initCapture];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.captureSession startRunning];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if ([self.captureSession isRunning]) {
        [self.captureSession stopRunning];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - capture

- (void)startReader
{
    if (![self.captureSession isRunning]) {
        [self.captureSession startRunning];
        _scanFinished = NO;
    }
}

- (void)stopReader
{
    if ([self.captureSession isRunning]) {
        [self.captureSession stopRunning];
        _scanFinished = YES;
    }
}

- (void)initCapture
{
    AVCaptureDevice* inputDevice =
    [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    [inputDevice lockForConfiguration:nil];
    if ([inputDevice hasTorch])
    {
        inputDevice.torchMode = AVCaptureTorchModeAuto;
    }
    [inputDevice unlockForConfiguration];
    
    AVCaptureDeviceInput *captureInput =
    [AVCaptureDeviceInput deviceInputWithDevice:inputDevice error:nil];
    
    if (!captureInput) {
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:L(@"AlertSystemPrompts")
                                                            message:L(@"Search_PleaseOpenCamera")
                                                           delegate:self
                                                  cancelButtonTitle:L(@"Ok")
                                                  otherButtonTitles:nil];
            [alert show];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:L(@"AlertSystemPrompts")
                                                            message:L(@"Search_FailedToFindCameraDevice")
                                                           delegate:self
                                                  cancelButtonTitle:L(@"Ok")
                                                  otherButtonTitles:nil];
            [alert show];
        }
        
        return;
    }
    
    AVCaptureMetadataOutput *captureOutput = [[AVCaptureMetadataOutput alloc] init];
    [captureOutput setMetadataObjectsDelegate:self queue:_queue];
    self.captureOutput = captureOutput;
    
    self.captureSession = [[AVCaptureSession alloc] init];
    
    [self.captureSession addInput:captureInput];
    [self.captureSession addOutput:captureOutput];
    
    CGFloat w = 1920.f;
    CGFloat h = 1080.f;
    if ([self.captureSession canSetSessionPreset:AVCaptureSessionPreset1920x1080]) {
        self.captureSession.sessionPreset = AVCaptureSessionPreset1920x1080;
    } else if ([self.captureSession canSetSessionPreset:AVCaptureSessionPreset1280x720]) {
        self.captureSession.sessionPreset = AVCaptureSessionPreset1280x720;
        w = 1280.f;
        h = 720.f;
    } else if ([self.captureSession canSetSessionPreset:AVCaptureSessionPreset640x480]) {
        self.captureSession.sessionPreset = AVCaptureSessionPreset640x480;
        w = 960.f;
        h = 540.f;
    }
    
    SNLogInfo(@"available types: %@", [captureOutput availableMetadataObjectTypes]);
    captureOutput.metadataObjectTypes = [captureOutput availableMetadataObjectTypes];
    CGRect bounds = [[UIScreen mainScreen] bounds];
    
    
    if (!self.prevLayer) {
        self.prevLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
    }
    // NSLog(@"prev %p %@", self.prevLayer, self.prevLayer);
    self.prevLayer.frame = bounds;
    self.prevLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    [self.view.layer insertSublayer:self.prevLayer atIndex:0];
    
    //计算rectOfInterest
    CGFloat p1 = bounds.size.height/bounds.size.width;
    CGFloat p2 = w/h;
    CGRect cropRect = _cropRect;
    if (p1 < p2) {
        //实际图像被截取一段高
        CGFloat fixHeight = bounds.size.width * w / h;
        CGFloat fixPadding = (fixHeight - bounds.size.height)/2;
        captureOutput.rectOfInterest = CGRectMake((cropRect.origin.y + fixPadding)/fixHeight,
                                                  cropRect.origin.x/bounds.size.width,
                                                  cropRect.size.height/fixHeight,
                                                  cropRect.size.width/bounds.size.width);
    } else {
        
        CGFloat fixWidth = bounds.size.height * w / h;
        CGFloat fixPadding = (fixWidth - bounds.size.width)/2;
        captureOutput.rectOfInterest = CGRectMake(cropRect.origin.y/bounds.size.height,
                                                  (cropRect.origin.x + fixPadding)/fixWidth,
                                                  cropRect.size.height/bounds.size.height,
                                                  cropRect.size.width/fixWidth);
    }
}


- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if (!_scanFinished) {
        
        if ([metadataObjects count]) {
            
            for (AVMetadataObject *obj in metadataObjects) {
                
                if ([obj isKindOfClass:[AVMetadataMachineReadableCodeObject class]]) {
                    
                    [self stopReader];
                    
                    AVMetadataMachineReadableCodeObject *codeObj = (AVMetadataMachineReadableCodeObject *)obj;
                    SNLogInfo(@"type: %@, value: %@", codeObj.type, codeObj.stringValue);
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        if ([_delegate respondsToSelector:@selector(readerController:didScanResult:isTwoDCode:)]) {
                            [_delegate readerController:self didScanResult:codeObj.stringValue isTwoDCode:[codeObj.type isEqualToString:AVMetadataObjectTypeQRCode]];
                        }
                    });
                    
                    break;
                }
            }
        }
    }
}

#pragma mark - video

- (void)onVideoStart: (NSNotification*) note
{
    [self startScrollBar];
}

- (void)onVideoStop: (NSNotification*) note
{
    [self stopScrollBar];
}

- (void)startScrollBar
{
    self.scrollBar.hidden = NO;
    _isBarScrolling = YES;
    self.scrollBar.frame = CGRectMake(_cropRect.origin.x, CGRectGetMinY(_cropRect), self.scrollBar.frame.size.width, self.scrollBar.frame.size.height);
    [self setScrollBarPositionAnimatied];
}

- (void)stopScrollBar
{
    self.scrollBar.hidden = YES;
    _isBarScrolling = NO;
}

- (void)setScrollBarPositionAnimatied
{
    if (_isBarScrolling)
    {
        [UIView animateWithDuration:2.0f delay:0.0f
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             
                             self.scrollBar.frame = CGRectMake(_cropRect.origin.x, CGRectGetMaxY(_cropRect) - 7, self.scrollBar.frame.size.width, self.scrollBar.frame.size.height);
                             
                         } completion:^(BOOL finished) {
                             
                             self.scrollBar.frame = CGRectMake(_cropRect.origin.x, CGRectGetMinY(_cropRect), self.scrollBar.frame.size.width, self.scrollBar.frame.size.height);
                             
                             [self setScrollBarPositionAnimatied];
                         }];
    }
}

#pragma mark - actions

- (void)CancelClicked:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
        if ([_delegate respondsToSelector:@selector(readerControllerCancelButtonTapped:)]) {
            [_delegate readerControllerCancelButtonTapped:self];
        }
        
    }];
}

- (void)DoneClicked:(id)sender
{
    if ([_delegate respondsToSelector:@selector(readerControllerScanHistoryButtonTapped:)]) {
        [_delegate readerControllerScanHistoryButtonTapped:self];
    }
}

#pragma mark - views

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
        _scrollBar.image = [UIImage imageNamed:@"ZXing_AnimateBar"];
        _scrollBar.contentMode = UIViewContentModeScaleToFill;
        [self.view addSubview:_scrollBar];
    }
    return _scrollBar;
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

@end
