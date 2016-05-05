//
//  ScanSearchViewController.m
//  SuningEBuy
//
//  Created by 孔斌 on 13-8-20.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "ScanSearchViewController.h"
#import "BrowsingHistoryDAO.h"
#import "ScanHistoryProductCell.h"
#import "ProductDetailViewController.h"

@interface ScanSearchViewController ()

@end

@implementation ScanSearchViewController

@synthesize scanSearchView = _scanSearchView;

@synthesize historyList = _historyList;

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
	// Do any additional setup after loading the view.
}

- (void)dealloc{
    TT_RELEASE_SAFELY(_scanSearchView);
    TT_RELEASE_SAFELY(_historyList);
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    [self reloadScanHistoryTableViewData];

}

- (id)init
{
    self = [super init];
    if (self) {
        _scanSearchView = [[ScanSearchView alloc] initWithOwner:self];
        
        self.view = _scanSearchView;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reloadScanHistoryTableViewData
{
    BrowsingHistoryDAO *dao = [[BrowsingHistoryDAO alloc] init];
    NSArray *products = [dao getAllBrowsingHistorysFromDB];
    NSMutableArray *list = [[NSMutableArray alloc] initWithArray:products];
    self.historyList = list;
    TT_RELEASE_SAFELY(list);
    TT_RELEASE_SAFELY(dao);
    
    if (self.historyList == nil || [self.historyList count] == 0) {
        _scanSearchView.scanTableView.tableFooterView = _scanSearchView.noScanHistoryLabel;
        
    }else {
        _scanSearchView.scanTableView.tableFooterView = _scanSearchView.delAllScanButtonView;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [_scanSearchView.scanTableView reloadData];
    });
}


- (void)cleanScanHistory
{
    BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"system-error")
                                                    message:L(@"Confirm clear scan history")
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
            BrowsingHistoryDAO *dao = [[BrowsingHistoryDAO alloc] init];
            
            [dao deleteAllHistorysFromDB];
            
            TT_RELEASE_SAFELY(dao);
            
            [self reloadScanHistoryTableViewData];
        }
    }
}

#pragma mark -
#pragma mark table view delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.historyList?[self.historyList count]:0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *BrowsingCellIdentifier = @"BrowsingCellIdentifier";
    
    ScanHistoryProductCell *cell = (ScanHistoryProductCell *)[tableView dequeueReusableCellWithIdentifier:BrowsingCellIdentifier];
    
    if (cell == nil)
    {
        cell = [[ScanHistoryProductCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BrowsingCellIdentifier];
        UIImageView *line=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"line"]];
        line.frame=CGRectMake(0, 79.5, 320, 0.5);
        [cell.contentView addSubview:line];
        TT_RELEASE_SAFELY(line);
    }
    
    DataProductBasic *data = [self.historyList objectAtIndex:indexPath.row];
    
    [cell setItem:data];
    
    UIImageView *vArrow = [[UIImageView alloc] initWithFrame:CGRectMake(310, 14, 6, 11)];
    vArrow.image = [UIImage imageNamed:@"arrow_right_gray"];
    cell.accessoryView = vArrow;
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
    
    BrowsingHistoryDAO *dao = [[BrowsingHistoryDAO alloc] init];
    
    [dao deleteProductByData:data];
    
    TT_RELEASE_SAFELY(dao);
    
    [self.historyList removeObjectAtIndex:indexPath.row];
    
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self reloadScanHistoryTableViewData];
}


@end
