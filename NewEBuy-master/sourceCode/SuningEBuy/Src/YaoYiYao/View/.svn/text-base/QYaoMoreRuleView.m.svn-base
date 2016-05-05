//
//  QYaoMoreRuleView.m
//  SuningEBuy
//
//  Created by XZoscar on 14-4-4.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "QYaoMoreRuleView.h"
#import "SuningMainClick.h"

@implementation QYaoMoreRuleView

- (void)dealloc {
    
    self.webView        = nil;
    self.loadingView    = nil;
    self.contentView    = nil;
}

+ (QYaoMoreRuleView *)moreRuleView {
    
    QYaoMoreRuleView *view = [[[NSBundle mainBundle] loadNibNamed:@"QYaoMoreRuleView" owner:nil options:nil] objectAtIndex:0];
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    view.hidden = YES;
    
   //[[SuningMainClick sharedInstance] setCurrentPageTitle:@"摇易摇-活动规则"];
    
    return view;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UIView *view = ((UITouch *)touches.anyObject).view;
    if (view == self
        || view == _contentView) {
        [self setVisible:NO animate:YES];
    }
}

- (void)setVisible:(BOOL)visiable animate:(BOOL)animated {
    if (visiable) {
        self.hidden = NO;
        if (animated) {
            self.alpha  = 0.0f;
            [UIView animateWithDuration:.45f animations:^{
                self.alpha = 1.0f;
            }];
        }
    }else {
        if (animated) {
            self.alpha = 1.0f;
            [UIView animateWithDuration:.25f animations:^{
                self.alpha = 0.0f;
            }];
            [UIView animateWithDuration:.25f animations:^{
                 self.alpha = 0.0f;
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
        }else {
             [self removeFromSuperview];
        }
    }
}

- (IBAction)actionClose {
    [self setVisible:NO animate:YES];
}

- (void)loadDataFromUrl:(NSString *)ruleUrl {
    
    if (nil != ruleUrl
        && [ruleUrl hasPrefix:@"http"]) {
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:ruleUrl]];
        [self.webView loadRequest:request];
    }else {
        self.loadingView.hidden = YES;
    }
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView
                    shouldStartLoadWithRequest:(NSURLRequest *)request
                    navigationType:(UIWebViewNavigationType)navigationType {
    
    return YES;
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    self.loadingView.hidden = NO;
    [self.loadingView startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [self.loadingView stopAnimating];
    self.loadingView.hidden = YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    [self.loadingView stopAnimating];
    self.loadingView.hidden = YES;
}

@end
