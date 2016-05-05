//
//  SKQRCodeReadController.m
//  SuningEBuy
//
//  Created by  liukun on 13-2-26.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "SKQRCodeReadController.h"

@interface SKQRGrayView : UIView

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *tipLabel;

@end

@implementation SKQRGrayView

@synthesize imageView = _imageView;
@synthesize tipLabel = _tipLabel;


- (id)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        _imageView = [[UIImageView alloc] init];
        _imageView.image = [UIImage imageNamed:@"sk_qr_temp.png"];
        [self addSubview:_imageView];
        
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.font = [UIFont boldSystemFontOfSize:16.0];
        _tipLabel.backgroundColor = [UIColor clearColor];
        _tipLabel.text = L(@"SK_QR_Reader_Tip");
        _tipLabel.lineBreakMode = UILineBreakModeCharacterWrap;
        _tipLabel.numberOfLines = 2;
        _tipLabel.textColor = [UIColor whiteColor];
        [self addSubview:_tipLabel];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, RGBACOLOR(102, 102, 102, 0.7).CGColor);
    
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    CGFloat tL = 46.0f;
    CGFloat bL = 100.0f;
    CGFloat lL = 40.0f;
    CGRect clips[] =
	{
		CGRectMake(0, 0, width, tL),
		CGRectMake(0, height-bL, width, bL),
        CGRectMake(0, tL, lL, height-2*tL),
        CGRectMake(width-lL, tL, lL, height-2*tL)
	};
    
    self.imageView.frame = CGRectMake(lL+3, height-bL+13, 44, 44);
    self.tipLabel.frame = CGRectMake(self.imageView.right+5, height-bL+10, width-2*lL-50+12, 50);
    CGContextClipToRects(context, clips, sizeof(clips) / sizeof(clips[0]));
    CGContextFillRect(context, self.bounds);
}

@end

/*********************************************************************/

@implementation SKQRCodeReadController

@synthesize readerView = _readerView;
@synthesize validateInfo = _validateInfo;
@synthesize delegate = _delegate;

- (void)dealloc
{
    _readerView.readerDelegate = nil;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.title = L(@"SK_QR_Reader_TITLE");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"search_searchPage"),self.title];
//        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:L(@"Back")
//                                                                     style:UIBarButtonItemStylePlain
//                                                                    target:self
//                                                                    action:@selector(back:)];
//        self.navigationItem.leftBarButtonItem = leftItem;
//        [leftItem release];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    CGRect frame = self.view.bounds;
    frame.size.height-=44;
    
    self.readerView.frame = self.view.bounds;
    [self.view addSubview:self.readerView];
    
    SKQRGrayView *grayView = [[SKQRGrayView alloc] init];
    grayView.frame = frame;
    [self.view addSubview:grayView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.readerView start];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.readerView stop];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark actions

//- (void)back:(id)sender
//{
//    [self dismissModalViewControllerAnimated:YES];
//}

#pragma mark -
#pragma mark views

- (ZBarReaderView *)readerView
{
    if (!_readerView)
    {
        _readerView = [[ZBarReaderView alloc] init];
        
        _readerView.readerDelegate = self;
    }
    return _readerView;
}

#pragma mark -
#pragma mark reader view delegate

- (void)readerView:(ZBarReaderView *)readerView didReadSymbols:(ZBarSymbolSet *)symbols fromImage:(UIImage *)image
{
    ZBarSymbol *symbol = nil;
    
    for(symbol in symbols) {
        break;
    }
    
    NSString *data = symbol.data;
    zbar_symbol_type_t type = symbol.type;
    
    
    //只有是QRCODE类型才解析
    if (type == ZBAR_QRCODE ) {
        [readerView stop];

        //二维码的情况处理
        if ([data eq:self.validateInfo])
        {
            if ([_delegate respondsToSelector:@selector(validateQRPassed)])
            {
                [_delegate validateQRPassed];
            }
            [self dismissModalViewControllerAnimated:YES];
        }
        else
        {
            [self presentSheet:L(@"SK_QR_Validate_Error")];
            
            [readerView start];
        }
        
    }
    
}
@end
