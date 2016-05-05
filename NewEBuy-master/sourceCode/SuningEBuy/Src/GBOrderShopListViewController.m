//
//  GBOrderShopListViewController.m
//  SuningEBuy
//
//  Created by 王 漫 on 13-3-6.
//  Copyright (c) 2013年 Suning. All rights reserved.
//


#import "GBOrderShopListViewController.h"
#import "NProOrderLastCell.h"

@interface GBOrderShopListViewController ()
{
    NSInteger                 selectedIndex;
}

@property (nonatomic, strong) UIWebView                         *callWebView;

@end

@implementation GBOrderShopListViewController

@synthesize shopList = _shopList;
@synthesize callWebView = _callWebView;

- (void)dealloc{
    TT_RELEASE_SAFELY(_shopList);
    TT_RELEASE_SAFELY(_callWebView);
}

-(id)initWithShopList:(NSMutableArray *)shopList{
    if (self= [super init]) {
        self.title = L(@"GB_Shop_Info");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"virtual_gourpBuy"),self.title];
        if (!_shopList) {
            _shopList = [[NSMutableArray alloc]init];
        }
        self.shopList = shopList;
    }
    return  self;
}

-(void)loadView{
    [super loadView];
    
    self.view.frame = [self visibleBoundsShowNav:self.hasNav showTabBar:NO];
    UIView * contentView = self.view;
    CGRect frame =contentView.frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
    self.groupTableView.frame = [self setCommonViewFrame:self.hasNav WithTab:YES];//[self setViewFrame:self.hasNav];//frame;
//    self.groupTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.groupTableView];
//    [self useBottomNavBar];
//    [self.bottomNavBar addSubview:self.bottomCell];
    
    self.hasSuspendButton = YES;
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
        [self presentCustomDlg:L(@"GBPleaseChooseRightDevice")];
    }
}




- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (IsNilOrNull(_shopList) || [_shopList count]==0 ) {
        [self presentSheet:L(@"GBNoShopInfoNow")];
    }
}

#pragma mark - tableView delagate and dataSource
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.00001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 15)];
    
    if(IOS7_OR_LATER)
    {
        view.backgroundColor = [UIColor uiviewBackGroundColor];
        
    }
    else
    {
        view.backgroundColor = [UIColor clearColor];
        
    }
    
    return view;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0.00001)];
    
    if(IOS7_OR_LATER)
    {
        view.backgroundColor = [UIColor uiviewBackGroundColor];
        
    }
    else
    {
        view.backgroundColor = [UIColor clearColor];
        
    }
    
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (NotNilAndNull(_shopList)&& [_shopList count]>0) {
        return [_shopList count];
    }
    return 0;

//    if (NotNilAndNull(_shopList)) {
//        return 1;
//    }return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (NotNilAndNull(_shopList)) {
        return 3;
    }return 0;

//    if (NotNilAndNull(_shopList)&& [_shopList count]>0) {
//        return [_shopList count];
//    }
//    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (NotNilAndNull(_shopList) && [_shopList count]>0) {
        
        GBShopDTO *dto = [self.shopList safeObjectAtIndex:indexPath.row];

        return [NProOrderLastCell setGroupShopInfoCellHeight:dto WithRow:indexPath.row];//[GBOrderShopInfoCell height:[self.shopList objectAtIndex:indexPath.row]];
    }
    return 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    static NSString *GBOrderShopInfoCellIdentifier = @"GBOrderShopInfoCellIdentifier";
    NProOrderLastCell *cell  = (NProOrderLastCell *)[tableView dequeueReusableCellWithIdentifier:GBOrderShopInfoCellIdentifier];
    if (cell == nil) {
        cell = [[NProOrderLastCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GBOrderShopInfoCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell.payBtn addTarget:self action:@selector(callAction: event:) forControlEvents:UIControlEventTouchUpInside];
    GBShopDTO *dto = [self.shopList safeObjectAtIndex:row];
    [cell setGroupShopInfo:dto WithRow:indexPath.row];
    return cell;

//    NSInteger row = indexPath.row;
//    static NSString *GBOrderShopInfoCellIdentifier = @"GBOrderShopInfoCellIdentifier";
//    GBOrderShopInfoCell *cell  = (GBOrderShopInfoCell *)[tableView dequeueReusableCellWithIdentifier:GBOrderShopInfoCellIdentifier];
//    if (cell == nil) {
//        cell = [[GBOrderShopInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GBOrderShopInfoCellIdentifier];
//    }
//    [cell.callBtn addTarget:self action:@selector(callAction: event:) forControlEvents:UIControlEventTouchUpInside];
//    GBShopDTO *dto = [self.shopList objectAtIndex:row];
//    [cell setItem:dto];
//    return cell;
}

- (void)callAction:(id)sender event:(id)event{
    
    NSSet *touches = [event allTouches];
    
    UITouch *touch = [touches anyObject];
    
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:currentTouchPosition];
    
    if (indexPath != nil)
    {
        selectedIndex = indexPath.row;
        
        GBShopDTO *dto = [self.shopList safeObjectAtIndex:indexPath.row];
//        if ([dto.telList count] == 1)
//        {
            [self callHotLine:dto.tel];
//        }
//        else if ([dto.telList count] > 0)
//        {
//            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
//                                                                     delegate:self
//                                                            cancelButtonTitle:L(@"Cancel")
//                                                       destructiveButtonTitle:nil
//                                                            otherButtonTitles:nil, nil];
//            for (NSString *tel in dto.telList)
//            {
//                [actionSheet addButtonWithTitle:tel];
//            }
//            [actionSheet showInView:self.view];
//            
//            TT_RELEASE_SAFELY(actionSheet);
//            
//        }
    }
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == [self.shopList count] - 1) {
        
    }else
    {
        GBShopDTO *dto = [self.shopList safeObjectAtIndex:selectedIndex];
        
        [self callHotLine:[dto.telList safeObjectAtIndex:buttonIndex -1]];
    }
}


//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if( ([_shopList count]-1) != indexPath.row) {
//        UIImageView  *separatorLine = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"GB_seperatLine.png"]];
//        separatorLine.backgroundColor = [UIColor clearColor];
//        separatorLine.frame= CGRectMake(10,cell.contentView.bottom- 1 , 300, 2);
//        [cell.contentView addSubview:separatorLine];
//        TT_RELEASE_SAFELY(separatorLine);
//    }
//}

@end
