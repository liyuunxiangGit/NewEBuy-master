//
//  SweepstakesRuleInfoViewController.m
//  SuningEBuy
//
//  Created by robin on 1/28/13.
//  Copyright (c) 2013 Suning. All rights reserved.
//

#import "SweepstakesRuleInfoViewController.h"

@implementation SweepstakesRuleInfoViewController

@synthesize ruleWebView = _ruleWebView;

@synthesize ruleInfoString =_ruleInfoString;

@synthesize backBtn = _backBtn;

@synthesize  topBarBackgroundImage = _topBarBackgroundImage;

@synthesize sweepViewImage = _sweepViewImage;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_ruleWebView);
    
    TT_RELEASE_SAFELY(_ruleInfoString);

    TT_RELEASE_SAFELY(_backBtn);

    TT_RELEASE_SAFELY(_topBarBackgroundImage);
    
    TT_RELEASE_SAFELY(_sweepViewImage);
    
}

-(UIWebView *)ruleWebView{
    if (nil == _ruleWebView) {
        _ruleWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, _topBarBackgroundImage.bottom, self.view.width, self.view.height - _topBarBackgroundImage.bottom)];
        _ruleWebView.delegate = self;
        
        _ruleWebView.opaque = NO;
        _ruleWebView.backgroundColor = [UIColor clearColor];
        _ruleWebView.scalesPageToFit = YES;
        
//        _ruleWebView.autoresizingMask = (UIViewAutoresizingFlexibleWidth |
//                                     UIViewAutoresizingFlexibleHeight |
//                                     UIViewAutoresizingFlexibleBottomMargin);
//        
        //_ruleWebView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        
        [self.view addSubview: _ruleWebView];

    }
    return _ruleWebView;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
	[self displayOverFlowActivityView];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
	[self removeOverFlowActivityView];
	//self.isNeedData = NO;
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
	//[self removeOverFlowActivityView];
    //self.isNeedData = YES;
}

- (void)loadView
{
    [super loadView];
    
    self.view.backgroundColor= [UIColor redColor];
    
    [self.view addSubview: self.topBarBackgroundImage];
    
    [self.view addSubview: self.backBtn];
    
    //self.sweepViewImage.imageURL = [NSURL URLWithString:kSweepstakesInfoImageURL];
    
    self.ruleInfoString = kSweepstakesInfoImageURL;
 
    if ([self.ruleInfoString length] >0) {
         [self.ruleWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: self.ruleInfoString ]]];   
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIButton *)backBtn{
    if (_backBtn == nil) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _backBtn.frame = CGRectMake(10, 10, 46, 25);
        //[_backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //[_backBtn setTitle:L(@"AddPersonInfoBtn") forState:UIControlStateNormal];
        UIImage *image = [UIImage imageNamed:@"lottery_back.png"];
        [_backBtn setBackgroundImage:image forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

-(void)backEvent
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (EGOImageView *)sweepViewImage{
    
    if (!_sweepViewImage) {
        
		_sweepViewImage = [[EGOImageView alloc] initWithFrame:CGRectMake(0, _topBarBackgroundImage.bottom, self.view.width, self.view.height - _topBarBackgroundImage.bottom)];
        
		_sweepViewImage.backgroundColor =[UIColor clearColor];
        
        //_sweepViewImage.contentMode = UIViewContentModeScaleAspectFit;

        _sweepViewImage.layer.masksToBounds = YES;
        
        _sweepViewImage.delegate = self;
        
        _sweepViewImage.placeholderImage = nil;
        
        [self displayOverFlowActivityView];
        
        [self.view addSubview:_sweepViewImage];
        
    }
    
    return _sweepViewImage;
}

- (void)imageViewLoadedImage:(EGOImageView*)imageView
{
    [self removeOverFlowActivityView];
    
    DLog(@"imageViewLoadedImagev %f", imageView.image.size.height);
    
    self.sweepViewImage.top = self.topBarBackgroundImage.bottom;
    self.sweepViewImage.height=  imageView.image.size.height/2;
    
}

- (void)imageViewFailedToLoadImage:(EGOImageView*)imageView error:(NSError*)error
{
    [self removeOverFlowActivityView];
}

- (UIImageView *)topBarBackgroundImage
{
    if (!_topBarBackgroundImage)
    {
        
        UIImage *image1 = [UIImage imageNamed:@"lottery_web_bg.png"];
        UIImage *streImage1 = [image1 stretchableImageWithLeftCapWidth:0 topCapHeight:10];
        
        _topBarBackgroundImage = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, self.view.width, 44)];
        
        _topBarBackgroundImage.backgroundColor= [UIColor redColor];
        
        _topBarBackgroundImage.image = streImage1;
        
        [self.view addSubview: _topBarBackgroundImage];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.frame = CGRectMake(0, 0, self.view.width, 44);
        titleLabel.textAlignment  = UITextAlignmentCenter;
        
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:16];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.text = L(@"Sweepstakes_LotteryRule");
        
        [_topBarBackgroundImage addSubview:titleLabel];
        
        
        
        UIImageView *bakcImageView =  [[UIImageView alloc]  initWithFrame: CGRectMake(0, _topBarBackgroundImage.bottom, self.view.width, self.view.height-_topBarBackgroundImage.height)];
        
        UIImage *streImage2 = [image1 stretchableImageWithLeftCapWidth:0 topCapHeight:10];
        
        bakcImageView.image = streImage2;
        
        [self.view addSubview: bakcImageView];
        
        
        
    }
    return _topBarBackgroundImage;
}


@end
