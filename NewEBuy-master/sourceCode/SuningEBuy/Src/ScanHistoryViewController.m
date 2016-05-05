//
//  ScanHistoryViewController.m
//  SuningEBuy
//
//  Created by  liukun on 13-8-19.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "ScanHistoryViewController.h"
#import "ScanHistoryDAO.h"
#import "SolrProductCell.h"
#import "ProductDetailViewController.h"

@interface ScanHistoryViewController ()

@end

@implementation ScanHistoryViewController

- (void)dealloc
{
    TT_RELEASE_SAFELY(_historyList);
}

- (id)init
{
    self = [super init];
    if (self) {
        self.title = L(@"Search_ScanRecord");
        self.pageTitle = L(@"search_searchPage_ScanRecord");
        self.navigationItem.rightBarButtonItem = [self rightBtnItemWithTitle:L(@"CleanAllHistory")];
        self.hidesBottomBarWhenPushed = YES;
        self.bSupportPanUI = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backForePage
{
    [self.navigationController popViewControllerAnimated:NO];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (_backBlock) {
            _backBlock();
        }
    });
}

- (void)righBarClick
{
    [self cleanAllHistory];
}


- (void)initData
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        @autoreleasepool {
        
            ScanHistoryDAO *dao = [[ScanHistoryDAO alloc] init];
            
            NSArray *products = [dao getAllScanHistorysFromDB];
            
            NSMutableArray *list = [[NSMutableArray alloc] initWithArray:products];
            
            self.historyList = list;
            
            TT_RELEASE_SAFELY(list);
            
            TT_RELEASE_SAFELY(dao);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if(products.count == 0)
                {
                    [self showNoHistoryAlert];
                }
                
                [self.tableView reloadData];
            });
        
        }
    });
    
}

- (void)showNoHistoryAlert
{
    BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"system-error")
                                                    message:L(@"Search_NoScanHistory")
                                                   delegate:self
                                          cancelButtonTitle:L(@"Ok")
                                          otherButtonTitles:nil];
    
    alert.tag = 2;
    [alert show];
}

- (void)cleanAllHistory
{
    BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"system-error")
                                                    message:L(@"Confirm Clean Up?")
                                                   delegate:self
                                          cancelButtonTitle:L(@"Cancel")
                                          otherButtonTitles:L(@"Ok")];
    
    alert.tag = 1;
    [alert show];
}

#pragma mark - alertView delegate
- (void)alertView:(BBAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1) {
        
        if (buttonIndex == 1)
        {
            ScanHistoryDAO *dao = [[ScanHistoryDAO alloc] init];
            
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

- (void)loadView
{
    [super loadView];
    
	self.tableView.frame = [self visibleBoundsShowNav:self.hasNav showTabBar:NO];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
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
    return 110;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *BrowsingCellIdentifier = @"BrowsingCellIdentifier";
    
    SolrProductCell *cell = (SolrProductCell *)[tableView dequeueReusableCellWithIdentifier:BrowsingCellIdentifier];
    
    if (cell == nil)
    {
        cell = [[SolrProductCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BrowsingCellIdentifier];
    }
    
    DataProductBasic *data = [self.historyList objectAtIndex:indexPath.row];
    
    [cell setItem:data withDto:nil];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DataProductBasic *data = [self.historyList objectAtIndex:indexPath.row];
    
    ProductDetailViewController *productViewController = [[ProductDetailViewController alloc] initWithDataBasicDTO:data];
    
    [self.navigationController pushViewController:productViewController animated:YES];
    
    TT_RELEASE_SAFELY(productViewController);
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    DataProductBasic *data = [self.historyList objectAtIndex:indexPath.row];
    
    ScanHistoryDAO *dao = [[ScanHistoryDAO alloc] init];
    
    [dao deleteProductByData:data];
    
    TT_RELEASE_SAFELY(dao);
    
    [self.historyList removeObjectAtIndex:indexPath.row];
    
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    if ([self.historyList count] == 0)
    {
        [self showNoHistoryAlert];
    }
}


@end
