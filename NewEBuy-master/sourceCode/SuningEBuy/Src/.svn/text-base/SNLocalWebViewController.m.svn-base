//
//  SNLocalWebViewController.m
//  SuningEBuy
//
//  Created by snping on 14-9-12.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "SNLocalWebViewController.h"


@interface SNLocalWebViewController ()

@end

@implementation SNLocalWebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:
                          CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
    
    webView.dataDetectorTypes = UIDataDetectorTypeNone;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:self.pathName
                                                     ofType:@"html"];
    
    NSString *content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    
    [webView loadHTMLString:content baseURL:nil];
    
    [self.view addSubview:webView];

    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
