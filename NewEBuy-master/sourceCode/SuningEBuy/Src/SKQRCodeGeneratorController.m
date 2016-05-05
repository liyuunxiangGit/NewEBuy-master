//
//  SKQRCodeGeneratorController.m
//  SuningEBuy
//
//  Created by  liukun on 13-2-26.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "SKQRCodeGeneratorController.h"
#import "QRCodeGenerator.h"
#import "SNShareKit.h"

@interface SKQRCodeGeneratorController ()


@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) SNShareKit *shareKit;

@end

@implementation SKQRCodeGeneratorController

@synthesize baseString = _baseString;

@synthesize imageView = _imageView;
@synthesize tipLabel = _tipLabel;
@synthesize image = _image;
@synthesize shareKit = _shareKit;


- (id)init
{
    self = [super init];
    if (self) {
        self.title = L(@"SK_QR_Generator_TITLE");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"search_searchPage"),self.title];
        
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:L(@"Back")
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(back:)];
        self.navigationItem.leftBarButtonItem = leftItem;
        
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:L(@"Share")
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(share:)];
        self.navigationItem.rightBarButtonItem = rightItem;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.imageView.frame = CGRectMake(20, 20, 280, 280);
    [self.view addSubview:self.imageView];
    
    self.tipLabel.frame = CGRectMake(20, 320, 280, 25);
    [self.view addSubview:self.tipLabel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark views

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = [UIColor whiteColor];
    }
    return _imageView;
}

- (UILabel *)tipLabel
{
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.backgroundColor = [UIColor clearColor];
        _tipLabel.textAlignment = UITextAlignmentCenter;
        _tipLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        _tipLabel.textColor = [UIColor grayColor];
    }
    return _tipLabel;
}

- (SNShareKit *)shareKit
{
    if (!_shareKit) {
        _shareKit = [[SNShareKit alloc] initWithNavigationController:self.navigationController];
        _shareKit.shareType = SNShareSinaWeibo;
    }
    return _shareKit;
}

#pragma mark -
#pragma mark life cycle

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.image = [QRCodeGenerator qrImageForString:self.baseString
                                         imageSize:560];
    self.imageView.image = self.image;
    self.tipLabel.text = L(@"SK_QR_Generator_OK_MESSAGE");
}

#pragma mark -
#pragma mark actions

- (void)back:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)share:(id)sender
{
    [self.shareKit shareWithContent:L(@"SK_QR_Share_Content_Msg")
                              image:self.image];
}

@end
