//
//  AnalyzeViewController.m
//  SuningEBuy
//
//  Created by chupeng on 14-11-13.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "AnalyzeViewController.h"

@interface AnalyzeViewController ()

@end

@implementation AnalyzeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (AnalyzeViewController *)sharedAnalyzeViewController
{
    static dispatch_once_t onceToken;
    static AnalyzeViewController *v = nil;
    dispatch_once(&onceToken, ^{
        v  = [[self alloc] init];
        [HttpMsgCtrl shareInstance].delegate = v;
    });
    
    return v ;
}

- (void)showAnalyzeView
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.view];
    [window bringSubviewToFront:self.view];
}

- (void)removeFromWD
{
    if (self.view.superview)
    {
        [self.view removeFromSuperview];
    }
}

- (IBAction)clearAllLog:(id)sender {
    self.logTextView.text = @"";
}

- (IBAction)hide:(id)sender {
    [self removeFromWD];
}



- (IBAction)copyToPasteBoard:(id)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.logTextView.text;
}

#pragma mark - httpCtrl delegate
- (void)requestDidFinished:(NSString *)logString
{
    NSString *strBefore = self.logTextView.text;
    strBefore = [strBefore stringByAppendingString:logString];
    self.logTextView.text = strBefore;
}

- (void)requestDidFailed:(NSString *)logString
{
    NSString *strBefore = self.logTextView.text;
    strBefore = [strBefore stringByAppendingString:logString];
    self.logTextView.text = strBefore;
}

@end
