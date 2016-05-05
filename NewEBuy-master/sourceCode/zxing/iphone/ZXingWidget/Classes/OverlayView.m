// -*- Mode: ObjC; tab-width: 2; indent-tabs-mode: nil; c-basic-offset: 2 -*-

/**
 * Copyright 2009 Jeff Verkoeyen
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "OverlayView.h"
#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>
static const CGFloat kPadding = 30;
static const CGFloat kLicenseButtonPadding = 10;

@interface OverlayView()
@property (nonatomic,assign) UIButton *cancelButton;
@property (nonatomic,assign) UIButton *licenseButton;
@property (nonatomic,retain) UILabel *instructionsLabel;
@end


@implementation OverlayView

@synthesize delegate, oneDMode;
@synthesize points = _points;
@synthesize cancelButton;
@synthesize licenseButton;
@synthesize cropRect;
@synthesize instructionsLabel;
@synthesize displayedMessage;
@synthesize cancelButtonTitle;
@synthesize cancelEnabled;
@synthesize toolBar = _toolBar;
@synthesize headerLabel = _headerLabel;
@synthesize footerLabel = _footerLabel;
@synthesize rightLabel = _rightLabel;
@synthesize leftLabel = _leftLabel;
@synthesize scrollBar = _scrollBar;


////////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithFrame:(CGRect)theFrame cancelEnabled:(BOOL)isCancelEnabled oneDMode:(BOOL)isOneDModeEnabled {
  return [self initWithFrame:theFrame cancelEnabled:isCancelEnabled oneDMode:isOneDModeEnabled showLicense:YES];
}

- (id) initWithFrame:(CGRect)theFrame cancelEnabled:(BOOL)isCancelEnabled oneDMode:(BOOL)isOneDModeEnabled showLicense:(BOOL)showLicenseButton {
  self = [super initWithFrame:theFrame];
  if( self ) {
      
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

    CGFloat rectSize = self.frame.size.width - kPadding * 2;
    if (!oneDMode) {
      cropRect = CGRectMake(kPadding, (self.frame.size.height - rectSize) / 2, rectSize, rectSize);
    } else {
      CGFloat rectSize2 = self.frame.size.height - kPadding * 2;
      cropRect = CGRectMake(kPadding, kPadding, rectSize, rectSize2);		
    }

    self.backgroundColor = [UIColor clearColor];
//    self.oneDMode = isOneDModeEnabled;
      
    if (showLicenseButton) {
        self.licenseButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
        
        CGRect lbFrame = [licenseButton frame];
        lbFrame.origin.x = self.frame.size.width - licenseButton.frame.size.width - kLicenseButtonPadding;
        lbFrame.origin.y = self.frame.size.height - licenseButton.frame.size.height - kLicenseButtonPadding;
        [licenseButton setFrame:lbFrame];
        [licenseButton addTarget:self action:@selector(showLicenseAlert:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:licenseButton];
    }
    self.cancelEnabled = isCancelEnabled;

    if(0){
//    if (self.cancelEnabled) {
      UIButton *butt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
      self.cancelButton = butt;
      if ([self.cancelButtonTitle length] > 0 ) {
        [cancelButton setTitle:self.cancelButtonTitle forState:UIControlStateNormal];
      } else {
        [cancelButton setTitle:NSLocalizedStringWithDefaultValue(@"OverlayView cancel button title", nil, [NSBundle mainBundle], @"Cancel", @"Cancel") forState:UIControlStateNormal];
      }
      [cancelButton addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
      [self addSubview:cancelButton];
    }
      
      CGFloat height = theFrame.size.height;
      CGFloat barWidth = self.toolBar.frame.size.width;
      CGFloat barHeight = self.toolBar.frame.size.height;
      self.toolBar.frame = CGRectMake(0, height-barHeight, barWidth, barHeight);
      
      CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
      CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
      
      
      CGFloat vLblHeight = (screenHeight-cropRect.size.height)/2;
      self.headerLabel.frame = CGRectMake(0, 0, screenWidth, vLblHeight);
      self.footerLabel.frame = CGRectMake(0, screenHeight-vLblHeight, screenWidth, vLblHeight);
      
      CGFloat hLblWidth = (screenWidth-cropRect.size.width)/2;
      self.leftLabel.frame = CGRectMake(0, vLblHeight, hLblWidth, cropRect.size.height);
      self.rightLabel.frame = CGRectMake(screenWidth-hLblWidth, vLblHeight, hLblWidth, cropRect.size.height);
    
      //    self.readerView.scanCrop = CGRectMake(cropRect.origin.x/self.readerView.width, cropRect.origin.y/self.readerView.height, cropRect.size.width/self.readerView.width, cropRect.size.height/self.readerView.height);
      
      [self.layer addSublayer:self.headerLabel];
      [self.layer addSublayer:self.footerLabel];
      [self.layer addSublayer:self.rightLabel];
      [self.layer addSublayer:self.leftLabel];
      [self addSubview:self.toolBar];
      
      UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, vLblHeight-70, 260, 70)];
      label.font = [UIFont systemFontOfSize:16.0];
      label.textColor = [UIColor whiteColor];
      label.backgroundColor = [UIColor clearColor];
      label.text = @"请将条形码或二维码放置在屏幕中央";
      label.numberOfLines = 3;
      label.textAlignment = UITextAlignmentCenter;
      [self addSubview:label];
      
      //添加四个小图片
      {
          UIImageView *imageView = [[UIImageView alloc] init];
          imageView.image = [UIImage imageNamed:@"ScanQR1.png"];
          imageView.frame = CGRectMake(CGRectGetMinX(cropRect)-4, CGRectGetMinY(cropRect)-4, 16, 16);
          [self addSubview:imageView];
      }
      {
          UIImageView *imageView = [[UIImageView alloc] init];
          imageView.image = [UIImage imageNamed:@"ScanQR2.png"];
          imageView.frame = CGRectMake(CGRectGetMaxX(cropRect)-12, CGRectGetMinY(cropRect)-4, 16, 16);
          [self addSubview:imageView];
      }
      {
          UIImageView *imageView = [[UIImageView alloc] init];
          imageView.image = [UIImage imageNamed:@"ScanQR3.png"];
          imageView.frame = CGRectMake(CGRectGetMinX(cropRect)-4, CGRectGetMaxY(cropRect)-12, 16, 16);
          [self addSubview:imageView];
      }
      {
          UIImageView *imageView = [[UIImageView alloc] init];
          imageView.image = [UIImage imageNamed:@"ScanQR4.png"];
          imageView.frame = CGRectMake(CGRectGetMaxX(cropRect)-12, CGRectGetMaxY(cropRect)-12, 16, 16);
          [self addSubview:imageView];
      }
  }
  return self;
}

- (UIToolbar *)toolBar
{
    if (!_toolBar)
    {
        _toolBar= [[UIToolbar alloc] init];
        
        
        
        [_toolBar sizeToFit];
        
        if ( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )
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
        
//        UIBarButtonItem *flexItem = [[UIBarButtonItem alloc]
//                                     initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
//                                     target:nil
//                                     action:nil];
//        
//        UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc]
//                                         initWithTitle:@"取消"
//                                         style:UIBarButtonItemStylePlain
//                                         target:self
//                                         action:@selector(CancelClicked:)];
//        
//        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]
//                                       initWithTitle:@"扫描记录"
//                                       style:UIBarButtonItemStyleBordered
//                                       target:self
//                                       action:@selector(DoneClicked:)];
        
        UIButton *btnCancel = [[UIButton alloc] initWithFrame:CGRectMake(15, (44 - 20.5) / 2, 23 / 2, 41 / 2)];
        [btnCancel setBackgroundImage:[UIImage imageNamed:@"nav_back_normal"] forState:UIControlStateNormal];
        [btnCancel setBackgroundImage:[UIImage imageNamed:@"nav_back_select"] forState:UIControlStateHighlighted];
        [btnCancel addTarget:self action:@selector(CancelClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIButton *btnHistory = [[UIButton alloc] initWithFrame:CGRectMake(248, 5, 114 / 2, 34)];
        btnHistory.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [btnHistory setTitle:@"扫描记录" forState:UIControlStateNormal];
        [btnHistory setTitleColor:[UIColor colorWithRed:224 / 255.0 green:127 / 255.0 blue:56 / 255.0 alpha:1.0] forState:UIControlStateNormal];
        [btnHistory setTitleColor:[UIColor colorWithRed:224 / 255.0 green:127 / 255.0 blue:56 / 255.0 alpha:1.0] forState:UIControlStateHighlighted];
        [btnHistory addTarget:self action:@selector(DoneClicked:) forControlEvents:UIControlEventTouchUpInside];
        btnHistory.layer.borderWidth = 0.5;
        btnHistory.layer.borderColor = [UIColor colorWithRed:224 / 255.0 green:127 / 255.0 blue:56 / 255.0 alpha:1.0].CGColor;
        
        [_toolBar addSubview:btnCancel];
        [_toolBar addSubview:btnHistory];
//        [_toolBar setItems:[NSArray arrayWithObjects:cancelBtn,flexItem,doneButton, nil]];
//        
//        [flexItem release];
//        [cancelBtn release];
//        [doneButton release];
    }
    
    return _toolBar;
}

//头部影阴
- (CALayer *)headerLabel
{
    if (!_headerLabel)
    {
        _headerLabel = [[CALayer alloc] init];
        _headerLabel.frame = CGRectMake(0, 0, 320, 90);
        _headerLabel.backgroundColor=[UIColor colorWithRed:102./255. green:102./255. blue:102./255. alpha:0.7].CGColor;
        
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
        _footerLabel.backgroundColor=[UIColor colorWithRed:102./255. green:102./255. blue:102./255. alpha:0.7].CGColor;
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
        _rightLabel.backgroundColor=[UIColor colorWithRed:102./255. green:102./255. blue:102./255. alpha:0.7].CGColor;
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
        _leftLabel.backgroundColor=[UIColor colorWithRed:102./255. green:102./255. blue:102./255. alpha:0.7].CGColor;
    }
    return _leftLabel;
}

- (UIImageView *)scrollBar
{
    if (!_scrollBar) {
        _scrollBar = [[UIImageView alloc] init];
        _scrollBar.frame = CGRectMake(0, 0, cropRect.size.width, 9);
        //_scrollBar.backgroundColor = [UIColor colorWithRed:0xff green:0xb4 blue:0x00 alpha:1];
        _scrollBar.image = [UIImage imageNamed:@"ZXing_AnimateBar"];
        _scrollBar.contentMode = UIViewContentModeScaleToFill;
        _scrollBar.layer.shadowColor = [UIColor greenColor].CGColor;
        _scrollBar.layer.shadowOffset = CGSizeMake(1, 1);
        _scrollBar.layer.shadowOpacity = 0.5;
        _scrollBar.layer.shadowRadius = 5;
        [self addSubview:_scrollBar];
    }
    return _scrollBar;
}


- (void)CancelClicked:(id)sender
{
    [delegate cancelled];
}

- (void)DoneClicked:(id)sender
{
    [delegate goToScanHistory];
}


- (void)cancel:(id)sender {
	// call delegate to cancel this scanner
	if (delegate != nil) {
		[delegate cancelled];
	}
}

- (void)showLicenseAlert:(id)sender {
    NSString *title =
        NSLocalizedStringWithDefaultValue(@"OverlayView license alert title", nil, [NSBundle mainBundle], @"License", @"License");

    NSString *message =
        NSLocalizedStringWithDefaultValue(@"OverlayView license alert message", nil, [NSBundle mainBundle], @"Scanning functionality provided by ZXing library, licensed under Apache 2.0 license.", @"Scanning functionality provided by ZXing library, licensed under Apache 2.0 license.");

    NSString *cancelTitle =
        NSLocalizedStringWithDefaultValue(@"OverlayView license alert cancel title", nil, [NSBundle mainBundle], @"OK", @"OK");

    NSString *viewTitle =
        NSLocalizedStringWithDefaultValue(@"OverlayView license alert view title", nil, [NSBundle mainBundle], @"View License", @"View License");

    UIAlertView *av =
        [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:viewTitle, nil];

    [av show];
    [self retain]; // For the delegate callback ...
    [av release];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
  if (buttonIndex == [alertView firstOtherButtonIndex]) {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.apache.org/licenses/LICENSE-2.0.html"]];
  }
  [self release];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
	[_points release];
  [instructionsLabel release];
  [displayedMessage release];
    [cancelButtonTitle release];
    [_toolBar release];
    [_headerLabel release];
    [_footerLabel release];
    [_rightLabel release];
    [_leftLabel release];
    [_scrollBar release];
	[super dealloc];
}


- (void)drawRect:(CGRect)rect inContext:(CGContextRef)context {
	CGContextBeginPath(context);
	CGContextMoveToPoint(context, rect.origin.x, rect.origin.y);
	CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y);
	CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y + rect.size.height);
	CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y + rect.size.height);
	CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y);
	CGContextStrokePath(context);
}

- (CGPoint)map:(CGPoint)point {
    CGPoint center;
    center.x = cropRect.size.width/2;
    center.y = cropRect.size.height/2;
    float x = point.x - center.x;
    float y = point.y - center.y;
    int rotation = 90;
    switch(rotation) {
    case 0:
        point.x = x;
        point.y = y;
        break;
    case 90:
        point.x = -y;
        point.y = x;
        break;
    case 180:
        point.x = -x;
        point.y = -y;
        break;
    case 270:
        point.x = y;
        point.y = -x;
        break;
    }
    point.x = point.x + center.x;
    point.y = point.y + center.y;
    return point;
}

#define kTextMargin 10

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)drawRect:(CGRect)rect {
	[super drawRect:rect];
    
    //不做操作
    return;
    
  if (displayedMessage == nil) {
//    self.displayedMessage = NSLocalizedStringWithDefaultValue(@"OverlayView displayed message", nil, [NSBundle mainBundle], @"Place a barcode inside the viewfinder rectangle to scan it.", @"Place a barcode inside the viewfinder rectangle to scan it.");
      self.displayedMessage = @"请将条形码或二维码放置在屏幕中央";
  }
	CGContextRef c = UIGraphicsGetCurrentContext();
  
	CGFloat white[4] = {1.0f, 1.0f, 1.0f, 1.0f};
	CGContextSetStrokeColor(c, white);
	CGContextSetFillColor(c, white);
	if (0) {
        [self drawRect:cropRect inContext:c];
    }
	
  //	CGContextSetStrokeColor(c, white);
	//	CGContextSetStrokeColor(c, white);
	CGContextSaveGState(c);
	if (oneDMode) {
        NSString *text = NSLocalizedStringWithDefaultValue(@"OverlayView 1d instructions", nil, [NSBundle mainBundle], @"Place a red line over the bar code to be scanned.", @"Place a red line over the bar code to be scanned.");
        UIFont *helvetica15 = [UIFont fontWithName:@"Helvetica" size:15];
        CGSize textSize = [text sizeWithFont:helvetica15];
        
		CGContextRotateCTM(c, M_PI/2);
        // Invert height and width, because we are rotated.
        CGPoint textPoint = CGPointMake(self.bounds.size.height / 2 - textSize.width / 2, self.bounds.size.width * -1.0f + 20.0f);
        [text drawAtPoint:textPoint withFont:helvetica15];
	}
	else {
    UIFont *font = [UIFont systemFontOfSize:18];
    CGSize constraint = CGSizeMake(rect.size.width  - 2 * kTextMargin, cropRect.origin.y);
    CGSize displaySize = [self.displayedMessage sizeWithFont:font constrainedToSize:constraint];
    CGRect displayRect = CGRectMake((rect.size.width - displaySize.width) / 2 , cropRect.origin.y - displaySize.height, displaySize.width, displaySize.height);
    [self.displayedMessage drawInRect:displayRect withFont:font lineBreakMode:UILineBreakModeWordWrap alignment:UITextAlignmentCenter];
	}
	CGContextRestoreGState(c);
	int offset = rect.size.width / 2;
	if (oneDMode) {
		CGFloat red[4] = {1.0f, 0.0f, 0.0f, 1.0f};
		CGContextSetStrokeColor(c, red);
		CGContextSetFillColor(c, red);
		CGContextBeginPath(c);
		//		CGContextMoveToPoint(c, rect.origin.x + kPadding, rect.origin.y + offset);
		//		CGContextAddLineToPoint(c, rect.origin.x + rect.size.width - kPadding, rect.origin.y + offset);
		CGContextMoveToPoint(c, rect.origin.x + offset, rect.origin.y + kPadding);
		CGContextAddLineToPoint(c, rect.origin.x + offset, rect.origin.y + rect.size.height - kPadding);
		CGContextStrokePath(c);
	}
	if( nil != _points ) {
		CGFloat blue[4] = {0.0f, 1.0f, 0.0f, 1.0f};
		CGContextSetStrokeColor(c, blue);
		CGContextSetFillColor(c, blue);
		if (oneDMode) {
			CGPoint val1 = [self map:[[_points objectAtIndex:0] CGPointValue]];
			CGPoint val2 = [self map:[[_points objectAtIndex:1] CGPointValue]];
			CGContextMoveToPoint(c, offset, val1.x);
			CGContextAddLineToPoint(c, offset, val2.x);
			CGContextStrokePath(c);
		}
		else {
			CGRect smallSquare = CGRectMake(0, 0, 10, 10);
			for( NSValue* value in _points ) {
				CGPoint point = [self map:[value CGPointValue]];
				smallSquare.origin = CGPointMake(
                                         cropRect.origin.x + point.x - smallSquare.size.width / 2,
                                         cropRect.origin.y + point.y - smallSquare.size.height / 2);
				[self drawRect:smallSquare inContext:c];
			}
		}
	}
}


////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) setPoints:(NSMutableArray*)pnts {
    [pnts retain];
    [_points release];
    _points = pnts;
	
    if (pnts != nil) {
        self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.25];
    }
    [self setNeedsDisplay];
}

- (void) setPoint:(CGPoint)point {
    if (!_points) {
        _points = [[NSMutableArray alloc] init];
    }
    if (_points.count > 3) {
        [_points removeObjectAtIndex:0];
    }
    [_points addObject:[NSValue valueWithCGPoint:point]];
    [self setNeedsDisplay];
}


- (void)layoutSubviews {
  [super layoutSubviews];
  if (cancelButton) {
    if (oneDMode) {
      [cancelButton setTransform:CGAffineTransformMakeRotation(M_PI/2)];
      [cancelButton setFrame:CGRectMake(20, 175, 45, 130)];
    } else {
      CGSize theSize = CGSizeMake(100, 50);
      CGRect rect = self.frame;
      CGRect theRect = CGRectMake((rect.size.width - theSize.width) / 2, cropRect.origin.y + cropRect.size.height + 20, theSize.width, theSize.height);
      [cancelButton setFrame:theRect];
    }
  }
}

#pragma mark ----------------------------- scroll bar control

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

@end
