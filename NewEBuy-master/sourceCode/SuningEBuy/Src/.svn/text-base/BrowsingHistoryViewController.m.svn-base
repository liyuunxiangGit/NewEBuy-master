//
//  BrowsingHistoryViewController.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-2-6.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "BrowsingHistoryViewController.h"
#import "BrowsingHistoryDAO.h"
#import "DataProductBasic.h"
#import "SolrProductCell.h"
#import "ProductDetailViewController.h"

@implementation BrowsingHistoryViewController

@synthesize historyList = historyList_;

- (id)init
{
    self = [super init];
    
    if (self)
    {
        self.title = L(@"History Browsing");
        
        self.pageTitle = L(@"member_myEbuy_history");
        
        //        UIBarButtonItem *nextButton = [[UIBarButtonItem alloc]
        //                                       initWithImage:[UIImage streImageNamed:@"btn_trash_orange.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(cleanAllHistory)];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame =CGRectMake(280, 12, 26, 26);
        [btn setBackgroundImage:[UIImage imageNamed:@"btn_trash_orange.png"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(cleanAllHistory) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithCustomView:btn];
        self.navigationItem.rightBarButtonItem = nextButton;
        
        self.iOS7FullScreenLayout = YES;
        self.hidesBottomBarWhenPushed = YES;
        self.bSupportPanUI = NO;
    }
    return self;
}

//- (void)righBarClick
//{
//    [self cleanAllHistory];
//}


- (void)initData
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        @autoreleasepool {
            
            BrowsingHistoryDAO *dao = [[BrowsingHistoryDAO alloc] init];
            
            NSArray *products = [dao getAllBrowsingHistorysFromDB];
            
            NSMutableArray *list = [[NSMutableArray alloc] initWithArray:products];
            
            self.historyList = list;
            
            TT_RELEASE_SAFELY(list);
            
            TT_RELEASE_SAFELY(dao);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if(products.count == 0)
                {
                    //                    if (IOS7_OR_LATER)
                    //                    {
                    //                        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:L(@"system-error") message:L(@"NO Browsing History") delegate:self cancelButtonTitle:L(@"Ok") otherButtonTitles:nil, nil];
                    //
                    //                        alterView.tag = 2;
                    //                        [alterView show];
                    //
                    //                    }
                    //                    else
                    //                    {
                    BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"system-error")
                                                                    message:L(@"NO Browsing History")
                                                                   delegate:self
                                                          cancelButtonTitle:L(@"Ok")
                                                          otherButtonTitles:nil];
                    
                    alert.tag = 2;
                    [alert show];
                    //                    }
                    
                }
                
                [self.tableView reloadData];
            });
            
        }
    });
    
}



- (void)cleanAllHistory
{
    //    if (IOS7_OR_LATER)
    //    {
    //        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:L(@"system-error") message:L(@"Confirm Clean Up?") delegate:self cancelButtonTitle:L(@"Cancel") otherButtonTitles:L(@"Ok"), nil];
    //
    //        alertView.tag = 1;
    //        [alertView show];
    //
    //    }
    //    else
    //    {
    BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"system-error")
                                                    message:L(@"Product_ConfirmClearScanHistory")
                                                   delegate:self
                                          cancelButtonTitle:L(@"Cancel")
                                          otherButtonTitles:L(@"Ok")];
    alert.tag = 1;
    [alert show];
    
    //    }
}

#pragma mark - alertView delegate
- (void)alertView:(BBAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1) {
        
        if (buttonIndex == 1)
        {
            BrowsingHistoryDAO *dao = [[BrowsingHistoryDAO alloc] init];
            
            [dao deleteAllHistorysFromDB];
            
            TT_RELEASE_SAFELY(dao);
            
            [self initData];
        }
    }
    
    else if (alertView.tag == 2) {
        if (buttonIndex == 0) {
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}


- (void)dealloc
{
    TT_RELEASE_SAFELY(historyList_);
    
}

- (void)loadView
{
    [super loadView];
    
    CGRect frame = [self visibleBoundsShowNav:self.hasNav showTabBar:NO];
	
	self.tableView.frame = frame;
    
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableView];
    
    [self.view addGestureRecognizer:self.swipeRight];
    self.swipeRight.enabled=YES;
    
    
    self.hasSuspendButton = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self initData];
}

#pragma mark -
#pragma mark Table View Delegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.historyList count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 105;
}

- (UISwipeGestureRecognizer *)swipeRight
{
    if (!_swipeRight) {
        _swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backForePage)];
        [_swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
        _swipeRight.delegate = self;
    }
    return _swipeRight;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *BrowsingCellIdentifier = @"BrowsingCellIdentifier";
    
    SolrProductCell *cell = (SolrProductCell *)[tableView dequeueReusableCellWithIdentifier:BrowsingCellIdentifier];
    
    if (cell == nil)
    {
        cell = [[SolrProductCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BrowsingCellIdentifier];
        //liukun 在234版本更改
        cell.isShowEvaluation = NO;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    DataProductBasic *data = [self.historyList objectAtIndex:indexPath.row];
    
    [cell setItem:data withDto:nil];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DataProductBasic *data = [self.historyList objectAtIndex:indexPath.row];
    data.cityCode = [Config currentConfig].defaultCity;
    ProductDetailViewController *productViewController = [[ProductDetailViewController alloc] initWithDataBasicDTO:data];
    
    [self.navigationController pushViewController:productViewController animated:YES];
    
    TT_RELEASE_SAFELY(productViewController);
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle ==UITableViewCellEditingStyleInsert) {
        
    }
    DataProductBasic *data = [self.historyList objectAtIndex:indexPath.row];
    
    BrowsingHistoryDAO *dao = [[BrowsingHistoryDAO alloc] init];
    
    [dao deleteProductByData:data];
    
    TT_RELEASE_SAFELY(dao);
    
    [self.historyList removeObjectAtIndex:indexPath.row];
    
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
}

@end
