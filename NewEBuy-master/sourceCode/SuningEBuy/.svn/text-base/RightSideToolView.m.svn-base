//
//  RightSideToolView.m
//  SuningEBuy
//
//  Created by liukun on 14-2-18.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "RightSideToolView.h"
#import "BBSideBarViewController.h"
#import "ImageAboveLabelButton.h"
#import "ShopCartV2ViewController.h"
#import <SSA_IOS/SSAIOSSNDataCollection.h>

#define CONTENT_WIDTH       75.0f

@implementation RightSideToolView

- (id)init
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = RGBCOLOR(101, 107, 111);
        
        //设置位置
        CGRect frame = [[UIScreen mainScreen] bounds];
        self.frame = frame;
        
        CGFloat contentWidth = CONTENT_WIDTH;
        
        UIView *contentView = [[UIView alloc] init];
        contentView.backgroundColor = [UIColor clearColor];
        contentView.frame = self.bounds;
        
        CGFloat top = 0;
        {
            UIButton *btn = [ImageAboveLabelButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(0, top, contentWidth, 60);
            [btn setTitle:L(@"home") forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
            [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithRGBHex:0xff6a00] forState:UIControlStateHighlighted];
            [btn setImage:[UIImage imageNamed:@"right_home_normal.png"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"right_home_select.png"] forState:UIControlStateHighlighted];

            [btn addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 0;
            [contentView addSubview:btn];
            top += 80;
        }
        {
            UIButton *btn = [ImageAboveLabelButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(0, top, contentWidth, 60);
            [btn setTitle:L(@"search") forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
            [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithRGBHex:0xff6a00] forState:UIControlStateHighlighted];
            [btn setImage:[UIImage imageNamed:@"right_search_normal.png"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"right_search_select.png"] forState:UIControlStateHighlighted];
            
            [btn addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 1;
            [contentView addSubview:btn];
            top += 80;
        }
        {
            UIButton *btn = [ImageAboveLabelButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(0, top, contentWidth, 60);
            [btn setTitle:L(@"Categories") forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
            [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithRGBHex:0xff6a00] forState:UIControlStateHighlighted];
            [btn setImage:[UIImage imageNamed:@"right_cate_normal.png"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"right_cate_select.png"] forState:UIControlStateHighlighted];

            [btn addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 2;
            [contentView addSubview:btn];
            top += 80;
        }
        {
            UIButton *btn = [ImageAboveLabelButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(0, top, contentWidth, 60);
            [btn setTitle:L(@"shopCart") forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
            [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithRGBHex:0xff6a00] forState:UIControlStateHighlighted];
            [btn setImage:[UIImage imageNamed:@"right_shopcart_normal.png"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"right_shopcart_select.png"] forState:UIControlStateHighlighted];
            
            [btn addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 3;
            [contentView addSubview:btn];
            
            self.badgeValueBtn.frame = CGRectMake(50, top, 20, 20);
            [contentView addSubview:self.badgeValueBtn];
            top += 80;
        }
        {
            UIButton *btn = [ImageAboveLabelButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(0, top, contentWidth, 60);
            [btn setTitle:L(@"myEbuy") forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
            [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithRGBHex:0xff6a00] forState:UIControlStateHighlighted];
            [btn setImage:[UIImage imageNamed:@"right_myebuy_normal.png"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"right_myebuy_select.png"] forState:UIControlStateHighlighted];
            
            [btn addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 4;
            [contentView addSubview:btn];
            top += 60;
        }
        
        contentView.frame = CGRectMake(frame.size.width-contentWidth, (frame.size.height-top)/2, contentWidth, top);
        [self addSubview:contentView];
        
        [self addSubview:self.screenshotImageView];
    }
    return self;
}


- (UIButton *)badgeValueBtn
{
    if (!_badgeValueBtn)
    {
        _badgeValueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //    _badgeValueBtn.backgroundColor = RGBCOLOR(234, 89, 10);
        [_badgeValueBtn setBackgroundImage:[UIImage streImageNamed:@"Service_Detail_List_Cell_Point.png"] forState:UIControlStateDisabled];
        [_badgeValueBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _badgeValueBtn.alpha = 0;
        //    _badgeValueBtn.layer.cornerRadius = 7.0;
        [_badgeValueBtn setTitleEdgeInsets:UIEdgeInsetsMake(1, 2, 0, 0)];
        _badgeValueBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        //    _badgeValueBtn.layer.borderColor = RGBCOLOR(251, 195, 0).CGColor;
        //    _badgeValueBtn.layer.borderWidth = 0.5;
        _badgeValueBtn.enabled = NO;
        _badgeValueBtn.frame = CGRectMake(50, 240, 20, 20);
        _badgeValueBtn.layer.zPosition = 1;
    }
    return _badgeValueBtn;
}

-(void)showBadgeValue:(NSString*)number
{
    if ([number isEqualToString:@"0"] || IsStrEmpty(number))
    {
        self.badgeValueBtn.alpha = 0;
    }
    else
    {
        if ([number intValue] > 99) {
            number = @"99+";
        }
        int length = [number length];
        
        CGSize size = [@"9" sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(64, 20)];
        
       CGRect rect = self.badgeValueBtn.frame;
        rect.size.width = size.width * (length + 2)>20?size.width*(length+2):20;
        rect.size.height = size.height> 20 ?size.height:20;
        rect.origin.x = 75 - rect.size.width - 5;
        rect.origin.y = 240;//self.tabBar.bottom - 46;
        [self.badgeValueBtn setBackgroundImage:[UIImage streImageNamed:@"Service_Detail_List_Cell_Point.png"] forState:UIControlStateDisabled];
        
        self.badgeValueBtn.frame = rect;
        [self.badgeValueBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [self.badgeValueBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        
        self.badgeValueBtn.alpha = 1.0;
        [self.badgeValueBtn setTitle:number forState:UIControlStateNormal];
        [self.badgeValueBtn setTitle:number forState:UIControlStateDisabled];
    }
}

- (UIImageView *)screenshotImageView
{
    if (!_screenshotImageView) {
        _screenshotImageView = [[UIImageView alloc] init];
        _screenshotImageView.userInteractionEnabled = YES;
        _screenshotImageView.frame = self.bounds;
        _screenshotImageView.layer.shadowColor = [UIColor grayColor].CGColor;
        _screenshotImageView.layer.shadowOffset = CGSizeMake(2, 0);
        _screenshotImageView.layer.shadowOpacity = 0.5;
        _screenshotImageView.layer.shadowRadius = 3;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = _screenshotImageView.bounds;
        button.backgroundColor = [UIColor clearColor];
        [button addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
        [_screenshotImageView addSubview:button];
    }
    return _screenshotImageView;
}

+ (instancetype)sharedInstance
{
    static RightSideToolView *__instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __instance = [[RightSideToolView alloc] init];
    });
    return __instance;
}

- (void)buttonTapped:(id)sender
{
    NSInteger index = [sender tag];

    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"82050%d",index+2], nil]];
    [RightSideToolView hideWithCompletion:^{
        
        //如果在本地生活团购，先回到易购
        [BBSideBarViewController backToEbuyAnimated:NO];
        
        UITabBarController *tabBarVC = APP_DELEGATE.tabBarViewController;
        if (index == 3) {
            ShopCartV2ViewController *vc = [[ShopCartV2ViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.isNeedBackItem = YES;
            [(UINavigationController *)tabBarVC.selectedViewController pushViewController:vc animated:YES];
        }
        else
        {
            UINavigationController *nav = [[tabBarVC viewControllers] safeObjectAtIndex:index];
            [tabBarVC setSelectedIndex:index];
            [nav popToRootViewControllerAnimated:NO];
        }
    }];
}

- (void)hide
{
    [RightSideToolView hideWithCompletion:nil];
}

+ (void)show
{
    UIWindow *window = APP_DELEGATE.window;
    
//    UITabBarController *tabBarVC = APP_DELEGATE.tabBarViewController;
    CGSize size = window.size;
    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    [window.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [RightSideToolView sharedInstance].screenshotImageView.image = viewImage;

    [window addSubview:[RightSideToolView sharedInstance]];
    
    [UIView animateWithDuration:0.3
                          delay:0.
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         [RightSideToolView sharedInstance].screenshotImageView.transform = CGAffineTransformMakeTranslation(-CONTENT_WIDTH, 0);
                         
                     } completion:NULL];
}

+ (void)hideWithCompletion:(void(^)(void))block
{
    [UIView animateWithDuration:0.3
                          delay:0.
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         [RightSideToolView sharedInstance].screenshotImageView.transform = CGAffineTransformIdentity;
                         
                     } completion:^(BOOL finish){
                         
                         [[RightSideToolView sharedInstance] removeFromSuperview];
                         
                         if (block) {
                             block();
                         }
                     }];
}

@end
