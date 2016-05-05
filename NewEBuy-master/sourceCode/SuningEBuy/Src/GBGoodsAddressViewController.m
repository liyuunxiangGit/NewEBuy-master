//
//  GBGoodsAddressViewController.m
//  SuningEBuy
//
//  Created by  zhang jian on 13-2-27.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "GBGoodsAddressViewController.h"
#import "GBGoodsShopListCell.h"

@interface GBGoodsAddressViewController ()
{
    NSInteger                 selectedIndex;
}

@property (nonatomic, strong) UIWebView                         *callWebView;


@end

@implementation GBGoodsAddressViewController

@synthesize tuanType                    = _tuanType;
@synthesize gbShopsList                 = _gbShopsList;
@synthesize callWebView                 = _callWebView;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_tuanType);
    TT_RELEASE_SAFELY(_gbShopsList);
    TT_RELEASE_SAFELY(_callWebView);
    
}


- (id)init
{
    self = [super init];
    if (self) {
        self.title = L(@"GB_Shop_Info");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"virtual_gourpBuy"),self.title];
        if (!_gbShopsList) {
            _gbShopsList = [[NSArray alloc] init];
        }
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    self.hasNav = NO;
    [self useBottomNavBar];
    self.bottomNavBar.ebuyBtn.hidden = NO;
    
    self.tableView.frame = CGRectMake(0, 0, 320, self.view.bounds.size.height - 48);
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableView];
}

- (UIWebView *)callWebView
{
    if (!_callWebView) {
        _callWebView = [[UIWebView alloc] init];
    }
    return _callWebView;
}

- (BOOL)checkHardWareIsSupportCallHotLine:(NSString *)telephone
{
    BOOL isSupportTel = NO;
    
    NSString *telString = [NSString stringWithFormat:@"tel://%@",telephone];
    
    NSURL *telURL = [NSURL URLWithString:telString];
    
    isSupportTel = [[UIApplication sharedApplication] canOpenURL:telURL];
    
    return isSupportTel;
}

- (void)callHotLine:(NSString *)telephone
{
    NSString *telString = [NSString stringWithFormat:@"tel://%@",telephone];
    
    if ([self checkHardWareIsSupportCallHotLine:telephone]) {
        
        [self.callWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:telString]]];
    }else{
       // [self presentCustomDlg:L(@"Sorry, Unsupport call tel")];
        [self presentCustomDlg:L(@"GBPleaseChooseRightDevice")];
    }
}


#pragma mark -
#pragma mark tableview delegate/datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.gbShopsList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GBShopsListDTO *dto = [self.gbShopsList objectAtIndex:indexPath.row];
    return [GBGoodsShopListCell height:dto withTuanType:self.tuanType];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *shopListIdentifier = @"shopListIdentifier";
    GBGoodsShopListCell *cell = [tableView dequeueReusableCellWithIdentifier:shopListIdentifier];
    if (cell == nil) {
        cell = [[GBGoodsShopListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:shopListIdentifier];
    }
    
    [cell.callBtn addTarget:self action:@selector(callAction: event:) forControlEvents:UIControlEventTouchUpInside];
    
    GBShopsListDTO *dto = [self.gbShopsList objectAtIndex:indexPath.row];
    
    cell.tuanType = self.tuanType;
    cell.gbShopsListDTO = dto;
    
    return cell;
}

- (void)callAction:(id)sender event:(id)event{
    
    NSSet *touches = [event allTouches];
    
    UITouch *touch = [touches anyObject];
    
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:currentTouchPosition];
    
    if (indexPath != nil)
    {
        selectedIndex = indexPath.row;
        
        GBShopsListDTO *dto = [self.gbShopsList objectAtIndex:indexPath.row];
        if (!IsStrEmpty(dto.telephone)) {
            NSString *telephoneNum = [dto.telephone stringByReplacingOccurrencesOfString:@"-" withString:@""];
            [self callHotLine:telephoneNum];
        }
        
        //        if ([dto count] == 1)
        //        {
        //            [self callHotLine:[dto.teleList objectAtIndex:0]];
        //        }else if ([dto.teleList count] > 0)
        //        {
        //            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
        //                                                                     delegate:self
        //                                                            cancelButtonTitle:nil
        //                                                       destructiveButtonTitle:nil
        //                                                            otherButtonTitles:nil, nil];
        //            for (NSString *tel in dto.teleList)
        //            {
        //                [actionSheet addButtonWithTitle:tel];
        //            }
        //
        //            [actionSheet addButtonWithTitle:L(@"Cancel")];
        //
        //            [actionSheet showInView:self.view];
        //
        //            TT_RELEASE_SAFELY(actionSheet);
        //
        //        }
    }
}


//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    GBShopsListDTO *dto = [self.gbShopsList objectAtIndex:selectedIndex];
//
//    if (buttonIndex == [dto.teleList count]) {
//
//    }else
//    {
//        NSString *mobileNum = [dto.teleList objectAtIndex:buttonIndex];
//        mobileNum = [mobileNum stringByReplacingOccurrencesOfString:@"-" withString:@""];
//        [self callHotLine:mobileNum];
//    }
//}

@end
