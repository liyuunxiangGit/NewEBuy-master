//
//  PlaneRefundViewController.m
//  SuningEBuy
//
//  Created by david on 14-2-18.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "PlaneRefundViewController.h"
#import "RefundTitleCell.h"
#import "PlaneCallPhoneCell.h"


@implementation PlaneRefundViewController

- (id)init
{
    self = [super init];
    if (self) {
        
        self.title = L(@"BTRefundAndChangeService");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect frame = [self visibleBoundsShowNav:YES showTabBar:NO];
    
    self.tableView.frame = frame;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.view addSubview:self.tableView];
}

-(UIWebView*)webView
{
    if(_webView == nil)
    {
        _webView = [[UIWebView alloc]init];
    }
    
    return  _webView;
}

#pragma mark -
#pragma mark UITableView

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        return 80;
    }
    
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        static NSString *titleIdentifier = @"titleIdentifier";
        
        RefundTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:titleIdentifier];
        if (cell == nil) {
            cell = [[RefundTitleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:titleIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        [cell refreshCell:L(@"BTWeProvideServiceOfRefundAndChangeBunk")];
        
        return cell;
    }
    
    static NSString *callIdentifier = @"callIdentifier";
    
    PlaneCallPhoneCell *cell = [tableView dequeueReusableCellWithIdentifier:callIdentifier];
    if (cell == nil) {
        cell = [[PlaneCallPhoneCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:callIdentifier];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 1) {
        
        UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:L(@"GBChooseOperation")
                                                                delegate:self
                                                       cancelButtonTitle:L(@"Cancel")
                                                  destructiveButtonTitle:nil
                                                       otherButtonTitles:L(@"BTCall4008_766_766"), nil];
        
        actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
        
        actionSheet.delegate = self;
        
        [actionSheet showInView:self.tableView];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0) {
        
        [self callHotLine];
    }
}


- (BOOL)checkHardWareIsSupportCallHotLine
{
    
    BOOL isSupportTel = NO;
    
    NSURL *telURL = [NSURL URLWithString:@"tel://4006766766"];
    
    isSupportTel = [[UIApplication sharedApplication] canOpenURL:telURL];
    
    return isSupportTel;
    
}

- (void)callHotLine
{
    if ([self checkHardWareIsSupportCallHotLine]) {
        
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"tel://4006766766"]]];
        
    }else{
        
        BBAlertView *alert = [[BBAlertView alloc]
                              initWithTitle:L(@"Tips")
                              message:L(@"Sorry, Unsupport call tel \n hotline:4006766766")
                              delegate:nil
                              cancelButtonTitle:L(@"Ok")
                              otherButtonTitles:nil];
        [alert show];
    }
}

@end
