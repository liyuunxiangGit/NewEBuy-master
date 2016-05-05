//
//  GBDetailViewController.m
//  SuningEBuy
//
//  Created by  zhang jian on 13-2-25.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "GBDetailViewController.h"
#import "GBGoodsDetialFirstCell.h"
#import "GBGoodsDetailSecondCell.h"
#import "GBGoodsDetailForthCell.h"
#import "GBPayViewController.h"
#import "GBGoodsInfoViewController.h"
#import "GBGoodsAddressViewController.h"
#import "GBDetailTipsViewController.h"

@interface GBDetailViewController ()
{
    BOOL      isLoadedOk;
}

@property (nonatomic, strong) UIWebView   *callWebView;

@end

@implementation GBDetailViewController

@synthesize gbDetailService                 = _gbDetailService;
@synthesize snProId                         = _snProId;
@synthesize tuanGouType                     = _tuanGouType;
@synthesize callWebView                     = _callWebView;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_callWebView);
    TT_RELEASE_SAFELY(_gbDetailService);
    TT_RELEASE_SAFELY(_snProId);
    TT_RELEASE_SAFELY(_tuanGouType);
    
}

- (UIWebView *)callWebView
{
    if (!_callWebView)
    {
        _callWebView = [[UIWebView alloc] init];
    }
    return _callWebView;
}

- (GBDetailService *)gbDetailService
{
    if (!_gbDetailService)
    {
        _gbDetailService = [[GBDetailService alloc] init];
        
        _gbDetailService.gbDelegate = self;
    }
    return _gbDetailService;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.title = L(@"Group Detail");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"virtual_gourpBuy"),self.title];
        isLoadedOk = NO;
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    self.hasNav = NO;
    [self useBottomNavBar];
    self.bottomNavBar.ebuyBtn.hidden = NO;
    
    self.view.backgroundColor = RGBCOLOR(242, 242, 242);
    
    self.tableView.frame = CGRectMake(0, 0, 320, self.view.bounds.size.height - 48);
    
    self.tableView.backgroundColor = RGBCOLOR(239, 239, 239);
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!isLoadedOk)
    {
        [self displayOverFlowActivityView];
        
        [self.gbDetailService beginGetGBGoodsDetail:self.tuanGouType withSnProId:self.snProId];
    }
}

- (void)getGBGoodsDetailComplete:(GBDetailService *)service Result:(BOOL)isSuccess
{
    [self removeOverFlowActivityView];
    if (isSuccess)
    {
        isLoadedOk = YES;
        [self.tableView reloadData];
    }else{
        isLoadedOk = NO;
        [self presentSheet:self.gbDetailService.errorMsg];
    }
}

#pragma mark -
#pragma mark datasource/delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.gbDetailService.gbGoodsDetailDTO == nil) {
        return 0;
    }
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2) {
        return 2;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 250;
    }else if (indexPath.section == 1)
    {
        return [GBGoodsDetailSecondCell height:[NSString stringWithFormat:@"[%@]%@",self.gbDetailService.gbGoodsDetailDTO.titlePrefix,self.gbDetailService.gbGoodsDetailDTO.goodsTitle]];
    }else if (indexPath.section == 2)
    {
        return 40;
    }
    return 66;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        static NSString *firstCellIdentifier = @"firstCellIdentifier";
        
        GBGoodsDetialFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:firstCellIdentifier];
        
        if(cell == nil){
            cell = [[GBGoodsDetialFirstCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:firstCellIdentifier];
            cell.backgroundColor = RGBCOLOR(242, 242, 242);
            cell.contentView.backgroundColor = RGBCOLOR(242, 242, 242);
        }
        cell.gbGoodsDetailDto = self.gbDetailService.gbGoodsDetailDTO;
        
        [cell.buyBtn addTarget:self action:@selector(buySubmitAction:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else if (indexPath.section == 1)
    {
        static NSString *secondCellIdentifier = @"secondCellIdentifier";
        
        GBGoodsDetailSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:secondCellIdentifier];
        
        if(cell == nil){
            cell = [[GBGoodsDetailSecondCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:secondCellIdentifier];
            cell.backgroundColor = RGBCOLOR(242, 242, 242);
            cell.contentView.backgroundColor = RGBCOLOR(242, 242, 242);
        }
        cell.gbGoodsDetailDto = self.gbDetailService.gbGoodsDetailDTO;
        return cell;
    }else if (indexPath.section == 2)
    {
        static NSString *forthCellIdentifier = @"forthCellIdentifier";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:forthCellIdentifier];
        
        if(cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:forthCellIdentifier];
//            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor whiteColor];
            cell.contentView.backgroundColor = [UIColor whiteColor];
            
            UIImageView *aditorImg = [[UIImageView alloc] initWithFrame:CGRectMake(298, 12, 9, 14)];
            aditorImg.image = [UIImage imageNamed:@"arrow_right_gray.png"];
            [cell.contentView addSubview:aditorImg];
            
            UIImageView *lineImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 39.5, 320, 0.5)];
            lineImg.image = [UIImage imageNamed:@"line.png"];
            [cell.contentView addSubview:lineImg];
            
            
            
//            [cell.topBtn addTarget:self action:@selector(cellClickAction:) forControlEvents:UIControlEventTouchUpInside];
//            [cell.centerBtn addTarget:self action:@selector(cellClickAction:) forControlEvents:UIControlEventTouchUpInside];
        }
        else
        {
//            [cell removeAllSubviews];
        }
        
        UIImageView *aditorImg = [[UIImageView alloc] initWithFrame:CGRectMake(298, 12, 9, 14)];
        aditorImg.image = [UIImage imageNamed:@"arrow_right_gray.png"];
        [cell.contentView addSubview:aditorImg];
        
        UIImageView *lineImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 39.5, 320, 0.5)];
        lineImg.image = [UIImage imageNamed:@"line.png"];
        [cell.contentView addSubview:lineImg];
        
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.backgroundColor = [UIColor clearColor];
        if ([self.tuanGouType isEqualToString:@"1"]) {
            if (indexPath.row == 0) {
                cell.textLabel.text = L(@"GBProjectOfGroupBuy");
            }
            else
            {
                cell.textLabel.text = L(@"GB_Shop_Info");
            }
        }
        else
        {
            if (indexPath.row == 0) {
                cell.textLabel.text = L(@"GB_Goods_Detail");
            }
            else
            {
                cell.textLabel.text = L(@"GB_Shop_Info");
            }
        }
        
//        [cell goodsType:self.tuanGouType];
        return cell;
    }
    
    static NSString *gbDetailIdentifier = @"gbDetailIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:gbDetailIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:gbDetailIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = RGBCOLOR(242, 242, 242);
        cell.contentView.backgroundColor = RGBCOLOR(242, 242, 242);
    }
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = 1004;
    btn.frame = CGRectMake(15, 15, 290, 35);
    [btn setTitleColor:RGBCOLOR(94, 94, 94) forState:UIControlStateNormal];
    [btn setTitle:L(@"GBTelephoeNumberOfGroupBuy") forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [btn setBackgroundImage:[UIImage imageNamed:@"button_white_normal.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(cellClickAction:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:btn];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            GBGoodsInfoViewController *info = [[GBGoodsInfoViewController alloc] initWithRequestUrl:self.gbDetailService.gbGoodsDetailDTO.grouponDetails titleName:nil];
            [self.navigationController pushViewController:info animated:YES];
        }
        else
        {
            //商家地址
            GBGoodsAddressViewController *add = [[GBGoodsAddressViewController alloc] init];
            if ([self.tuanGouType isEqualToString:@"1"]){
                add.tuanType = @"1"; //1表示酒店
            }else{
                add.tuanType = @"0"; //0表示非酒店
            }
            add.gbShopsList = self.gbDetailService.gbGoodsDetailDTO.groupShopsMap;
            [self.navigationController pushViewController:add animated:YES];
        }
    }
}

- (void)cellClickAction:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    if (btn.tag == 1001)
    {
        GBGoodsInfoViewController *info = [[GBGoodsInfoViewController alloc] initWithRequestUrl:self.gbDetailService.gbGoodsDetailDTO.grouponDetails titleName:btn.titleLabel.text];
        [self.navigationController pushViewController:info animated:YES];
    }else if (btn.tag == 1002){
        //商家地址
        GBGoodsAddressViewController *add = [[GBGoodsAddressViewController alloc] init];
        if ([self.tuanGouType isEqualToString:@"1"]){
            add.tuanType = @"1"; //1表示酒店
        }else{
            add.tuanType = @"0"; //0表示非酒店
        }
        add.gbShopsList = self.gbDetailService.gbGoodsDetailDTO.groupShopsMap;
        [self.navigationController pushViewController:add animated:YES];
    }else if (btn.tag == 1004)
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:L(@"GBChooseOperation")
                                                                 delegate:self
                                                        cancelButtonTitle:L(@"Cancel")
                                                   destructiveButtonTitle:L(@"GBCall 4006-766-766")
                                                        otherButtonTitles:nil, nil];
        [actionSheet showInView:self.view];

    }
}

#pragma mark - 
#pragma mark UIActionSheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
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
        [self.callWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"tel://4006766766"]]];
    }else{
        [self presentCustomDlg:L(@"Sorry, Unsupport call tel \n hotline: 4006-766-766")];
    }
}

- (void)buySubmitAction:(id)sender
{
    GBPayViewController *pay = [[GBPayViewController alloc] init];
    pay.gbGoodsDetailDTO = self.gbDetailService.gbGoodsDetailDTO;
    pay.tuanGouType = self.tuanGouType;
    [self.navigationController pushViewController:pay animated:YES];
}


@end