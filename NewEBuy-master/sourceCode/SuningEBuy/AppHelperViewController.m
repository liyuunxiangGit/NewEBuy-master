//
//  AppHelperViewController.m
//  SuningEBuy
//
//  Created by shasha on 12-4-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AppHelperViewController.h"

#import "LoginViewController.h"
#import "AuthManagerNavViewController.h"

#import "NewRegisterViewController.h"


@interface AppHelperViewController ()
@property (nonatomic,strong) UIButton *loginButton;     // 登录
@property (nonatomic,strong) UIButton *tiyanButton;     // 立即体验
@end

@implementation AppHelperViewController
@synthesize helperScrollView = helperScrollView_;

- (void)dealloc {
    TT_RELEASE_SAFELY(helperScrollView_);
     dismissBlock = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)setDismissBlock:(SNBasicBlock)block
{
    if (block != dismissBlock) {
        dismissBlock = [block copy];
    }
}

-(UIWindow *)yinDWindow{
    if (!_yinDWindow) {
        _yinDWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _yinDWindow.windowLevel = UIWindowLevelStatusBar+YDaoLeavel;
        _yinDWindow.backgroundColor = [UIColor clearColor];
        _yinDWindow.hidden = NO;
        [_yinDWindow makeKeyAndVisible];
        
    }
    return _yinDWindow;
}

- (void)showOnWindow:(UIWindow *)window
{
    CGRect frame = [UIScreen mainScreen].bounds;
    if (!IOS7_OR_LATER) {
        frame.origin.y = 20;
        frame.size.height-=20;
    }
    self.view.frame = frame;
    [self.yinDWindow addSubview:self.view];
}

- (void)loadView{
    
    [super loadView];
    
    CGRect frame = self.view.bounds;
    self.helperScrollView.frame = frame;
    self.helperScrollView.contentSize = CGSizeMake(320*kDefaultAppHelperPageCount, frame.size.height);
    [self addHelperImages];
    
//    UIEdgeInsets inset = UIEdgeInsetsMake(2.0f,2.0f,2.0f,2.0f);
//    
//    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
//    CGFloat btY = frame.size.height-((480.0f==screenHeight)?90.0f:130.0f);
//    CGFloat btX = 640.0f;
    
//    if (nil == _loginButton) {
//        self.loginButton = [[UIButton alloc] initWithFrame:CGRectMake(btX+20.0f,btY,130.0f,33.0f)];
//        _loginButton.backgroundColor = [UIColor colorWithWhite:.3f alpha:.3f];
//        _loginButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
//        [_loginButton setTitle:@"登录·注册" forState:UIControlStateNormal];
//        [_loginButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
//        [_loginButton setTitleColor:[UIColor light_Gray_Color] forState:UIControlStateHighlighted];
//        
//        UIImage *img0 = [[UIImage imageNamed:@"helper_tiyanBt0.png"] resizableImageWithCapInsets:inset];
//        [_loginButton setBackgroundImage:img0 forState:UIControlStateNormal];
//        
//        [_loginButton addTarget:self action:@selector(on_loginRegisterButton_clicked:)
//               forControlEvents:UIControlEventTouchUpInside];
//        [self.helperScrollView addSubview:_loginButton];
//    }
    
//    if (nil == _tiyanButton) {
//        if (IOS7_OR_LATER) {
//            self.tiyanButton = [[UIButton alloc] initWithFrame:CGRectMake(btX+100.0f,btY-10.0f,120.0f, 33.0f)];
//        }else{
//            self.tiyanButton = [[UIButton alloc] initWithFrame:CGRectMake(btX+100.0f,btY+10.0f,120.0f, 33.0f)];
//        }
//        
////        _tiyanButton.backgroundColor = [UIColor colorWithWhite:.3f alpha:.3f];
////        _tiyanButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
////        [_tiyanButton setTitle:@"立即体验" forState:UIControlStateNormal];
////        [_tiyanButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
////        [_tiyanButton setTitleColor:[UIColor light_Gray_Color] forState:UIControlStateHighlighted];
////        UIImage *img0 = [[UIImage imageNamed:@"helper_tiyanBt1.png"] resizableImageWithCapInsets:inset];
////        [_tiyanButton setBackgroundImage:img0 forState:UIControlStateNormal];
//        [_tiyanButton addTarget:self action:@selector(on_loginRegisterButton_clicked:)
//               forControlEvents:UIControlEventTouchUpInside];
//        [self.helperScrollView addSubview:_tiyanButton];
//    }
}

- (void)addHelperImages{

    @autoreleasepool {
        
        CGRect frame = [[UIScreen mainScreen] bounds];

        for (int i = 0; i<kDefaultAppHelperPageCount; i++) {
            
            NSString *imageName = nil;
            if ([SystemInfo is_iPhone_5]) {
                imageName = [NSString stringWithFormat:@"NEWHELPER_%d-568h.png", i+1];
            }else{
                imageName = [NSString stringWithFormat:@"NEWHELPER_%d.png", i+1];
            }

            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
            imageView.frame = CGRectMake(frame.size.width*i, 0/*-20*/, frame.size.width, frame.size.height);
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            
            if (i == kDefaultAppHelperPageCount-1) {
                imageView.userInteractionEnabled = YES;
                UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
                [button setImage:[UIImage imageNamed:@"zhuce_"] forState:UIControlStateNormal];
                float width = [UIScreen mainScreen].bounds.size.width;
                [button addTarget:self action:@selector(loginRegisterButton_clicked:) forControlEvents:UIControlEventTouchUpInside];
                button.tag =1;
                if ([SystemInfo is_iPhone_5]) {
                    button.frame = CGRectMake(width/2-96-10, 380, 96, 34);
                }else{
                    button.frame = CGRectMake(width/2-96-10, 330, 96, 34);
                }
                button.backgroundColor = [UIColor clearColor];
                [imageView addSubview:button];
                
                UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectZero];
                [button1 setImage:[UIImage imageNamed:@"denglu1_.png"] forState:UIControlStateNormal];
                [button1 addTarget:self action:@selector(loginRegisterButton_clicked:) forControlEvents:UIControlEventTouchUpInside];
                button1.tag =2;
                if ([SystemInfo is_iPhone_5]) {
                    button1.frame = CGRectMake(width/2+10, 380, 96, 34);
                }else{
                    button1.frame = CGRectMake(width/2+10, 330, 96, 34);
                }
                button1.backgroundColor = [UIColor clearColor];
                [imageView addSubview:button1];
                
                UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectZero];
                [button2 setImage:[UIImage imageNamed:@"guangguangba_"] forState:UIControlStateNormal];
                [button2 addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
                button2.tag =2;
                if ([SystemInfo is_iPhone_5]) {
                    button2.frame = CGRectMake((width-96)/2, 424, 96, 34);
                }else{
                    button2.frame = CGRectMake((width-96)/2, 374, 96, 34);
                }
                button2.backgroundColor = [UIColor clearColor];
                [imageView addSubview:button2];
             }
            [self.helperScrollView addSubview:imageView];
            TT_RELEASE_SAFELY(imageView);
            
        }
        
    }

}

- (void)dismissView:(id)sender{
    
    CGContextRef contentext = UIGraphicsGetCurrentContext();
    
    [UIView beginAnimations:nil context:contentext];
    
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    [UIView setAnimationDuration:0.4];
    
    self.view.transform = CGAffineTransformMakeTranslation(-320, 0);
    
    [UIView setAnimationDelegate:self];
    
    [UIView setAnimationDidStopSelector:@selector(animationFinished:) ];
    
    [UIView commitAnimations];
    
}

-(UIScrollView*)helperScrollView
{
	
	if(!helperScrollView_)
    {
		
		helperScrollView_ = [[UIScrollView alloc] init];
		
		helperScrollView_.delegate = self;
		
		helperScrollView_.backgroundColor = [UIColor clearColor];
		
		helperScrollView_.showsVerticalScrollIndicator = NO;
		
		helperScrollView_.showsHorizontalScrollIndicator = NO;
		
		helperScrollView_.bounces = NO;
		
		helperScrollView_.pagingEnabled = YES;
        
        helperScrollView_.scrollsToTop = NO;
        		
		helperScrollView_.userInteractionEnabled = YES;
        
        helperScrollView_.tag = 10000;
		
        [self.view addSubview:helperScrollView_];
	}
    
	return helperScrollView_;	
}

#pragma mark -
#pragma mark Paging and Refresh image view

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x < 10)
    {
        scrollView.bounces = NO;
    }
    else
    {
        scrollView.bounces = YES;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    CGFloat space = scrollView.contentOffset.x - scrollView.width*(kDefaultAppHelperPageCount-1);
    if (space > 40) {
        [self dismissView:nil];
    }
}

- (void)goBack {
    [self.view removeFromSuperview];
    
    if (dismissBlock) {
        dismissBlock();
    }
}

- (void)animationFinished:(id)sender{
    [self goBack];
}

- (void)on_loginRegisterButton_clicked:(UIButton *)sender {
    
    [self displayOverFlowActivityView:L(@"LCLoading...")];
    AppHelperViewController *__weak weakSelf = self;
    self.yinDWindow.hidden=YES;
    if (_loginButton == sender) {
        
        // 登录
        [self displayOverFlowActivityView];
        LoginViewController *ctrler = [[LoginViewController alloc] init];
        AuthManagerNavViewController *navCtrler = [[AuthManagerNavViewController alloc] initWithRootViewController:ctrler];
        [__gNavController0 presentViewController:navCtrler animated:YES completion:^{
            [weakSelf removeOverFlowActivityView];
            [weakSelf goBack];
        }];
        
    }else{
        if (_tiyanButton == sender) {
            // 注册体验
            [self goBack];
        }
    }
}

- (void)loginRegisterButton_clicked:(UIButton *)sender {
    UIButton *btn = (UIButton *)sender;
    AppHelperViewController *__weak weakSelf = self;
    if (btn.tag ==2) {
        // 登录
        [self displayOverFlowActivityView];
        LoginViewController *ctrler = [[LoginViewController alloc] init];
        AuthManagerNavViewController *navCtrler = [[AuthManagerNavViewController alloc] initWithRootViewController:ctrler];
        [__gNavController0 presentViewController:navCtrler animated:YES completion:^{
            [weakSelf removeOverFlowActivityView];
            [weakSelf goBack];
        }];

    }
    else{
        [SSAIOSSNDataCollection CustomEventCollection:@"click"
                                             keyArray:@[@"clickno"]
                                           valueArray:@[@"1030105"]];
        
        NewRegisterViewController *registViewController = [[NewRegisterViewController alloc] init];
        registViewController.registerDelegate = self;
        AuthManagerNavViewController *navController = [[AuthManagerNavViewController alloc] initWithRootViewController:registViewController];
        [__gNavController0 presentViewController:navController animated:YES completion:^{
            [weakSelf removeOverFlowActivityView];
            [weakSelf goBack];
        }];


    }
}

@end
