//
//  SalePromotionViewController.m
//  SuningEBuy
//
//  Created by GUO on 14-9-19.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "SalePromotionViewController.h"
#import "PruductList244ViewController.h"
#import "LianBanZhuanTiViewController.h"
#import "SNWebViewController.h"
#import "SecondPageViewController.h"

@interface SalePromotionViewController ()
{
    
}
@property (nonatomic,strong) ZhuanTiDTO              *cuXiaoDto;
@end

@implementation SalePromotionViewController

@synthesize cuXiaoDto = _cuXiaoDto;

- (void)dealloc
{
    self.zhuanTiService.delegate = nil;
}

- (id)init
{
    self = [super init];
    if(self)
    {
        self.title = @"";
        self.hasNav = YES;
        self.hidesBottomBarWhenPushed = YES;
        self.whereFrom = SNRouteSourceNone;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.frame = [self visibleBoundsShowNav:self.hasNav showTabBar:NO];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self refreshData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.zhuanTiService cancelCuxiaoRequestAndDelegate];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int count = [self.cuXiaoDto.dataArray count];
    if([model isEqualToString:@"30001"]){
        if(count%5 == 0){
            return count/5 + 1;
        }else{
            return count/5 + 2;
        }
    }else if([model isEqualToString:@"30002"]){
        return count + 1;
    }else if([model isEqualToString:@"30003"]){
        if(count%2 == 0){
            return count/2 + 1;
        }else{
            return count/2 + 2;
        }
    }else if([model isEqualToString:@"30004"]){
        if(count%9 == 0){
            return count/9 + 1;
        }else{
            return count/9 + 2;
        }
    }else if([model isEqualToString:@"30005"]){
        if(count%4 == 0){
            return count/4 + 1;
        }else{
            return count/4 + 2;
        }
    }else if([model isEqualToString:@"30006"]){
        if(count%5 == 0){
            return count/5 + 1;
        }else{
            return count/5 + 2;
        }
    }else if([model isEqualToString:@"30007"]){
        if(count%3 == 0){
            return count/3 + 1;
        }else{
            return count/3 + 2;
        }
    }else{
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        if([model isEqualToString:@"30002"] || [model isEqualToString:@"30003"]){
            return 130;
        }
        else{
            return 120;
        }
    }
    else{
        if([model isEqualToString:@"30001"]){
            return 285;
        }
        else if([model isEqualToString:@"30002"]){
            return 130;
        }else if([model isEqualToString:@"30003"]){
            return 130;
        }else if([model isEqualToString:@"30004"]){
            return 460;
        }else if([model isEqualToString:@"30005"]){
            return 160;
        }else if([model isEqualToString:@"30006"]){
            return 160;
        }else if([model isEqualToString:@"30007"]){
            return 160;
        }else{
            return 0;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *salePromotionReuseIdentifier = [NSString stringWithFormat:@"SalePromotion_%d",indexPath.row];
    SalePromotionCell *promotionCell = [tableView dequeueReusableCellWithIdentifier:salePromotionReuseIdentifier];
    if(!promotionCell)
    {
        promotionCell = [[SalePromotionCell alloc] initWithStyle:UITableViewCellSelectionStyleNone reuseIdentifier:salePromotionReuseIdentifier];
        promotionCell.backgroundColor = [UIColor clearColor];
    }
    promotionCell.delegate = self;
    promotionCell.backgroundColor = [UIColor whiteColor];
    promotionCell.tag = indexPath.row;
    [promotionCell setViewsWith:self.cuXiaoDto];
    return promotionCell;
}

//促销回调 点击跳转相应页面
- (void)goToTargetPageWithHMDTO:(HomeModuleDTO *)dto
{
    [self handleTargetType:dto.targetType targetURLString:dto.targetURL];
 
}

//促销页面头部广告点击跳转
- (void)goToTargetPageWithTopAD:(TopADInfoDTO *)dto
{
    [self handleTargetType:dto.targetType targetURLString:dto.targetURL];
}

- (ZhuanTiService244 *)zhuanTiService {
    if (!_zhuanTiService) {
        _zhuanTiService = [[ZhuanTiService244 alloc] init];
        _zhuanTiService.delegate = self;
    }
    return _zhuanTiService;
}

#pragma mark
#pragma mark - zhuanTiServiceCallBack
- (void)zhuanTiServiceCompleted:(ZhuanTiDTO *)dto isSuccess:(BOOL)isSuccess errorMsg:(NSString *)errMsg {
    if(isSuccess){
        self.cuXiaoDto = dto;
        model = self.cuXiaoDto.templateID;
        self.title = dto.subjectName;
        
        //采集pagetitle
        if (!IsStrEmpty(dto.subjectName)) {
            self.pageTitle = [NSString stringWithFormat:@"%@-%@", L(@"PageTitleSalePromotionPrefix"), dto.subjectName];
            [SSAIOSSNDataCollection multiPagesInCollection:self.pageTitle];
        }
        
        if (IsArrEmpty(dto.dataArray)) {
            BBAlertView *alert = [[BBAlertView alloc] initWithTitle:@""
                                                            message:L(@"AlertVisitedPageInexistence")
                                                           delegate:self
                                                  cancelButtonTitle:L(@"AlertIKnow")
                                                  otherButtonTitles:nil];
            [alert show];
        }
        else {
            [self.tableView reloadData];
        }

    }
    else{
        if (_whereFrom == SNRouteSourceNone)
        {
            [self presentSheet:errMsg posY:100];
            
        }else{
            BBAlertView *alert = [[BBAlertView alloc] initWithTitle:@""
                                                            message:L(@"AlertVisitedPageInexistence")
                                                           delegate:self
                                                  cancelButtonTitle:L(@"AlertIKnow")
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }
}

#pragma mark
#pragma mark - refreshData

- (void)refreshData
{
    [super refreshData];
    [self.zhuanTiService queryCuXiaoZhuanTiWithID:self.targetModuleID];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
