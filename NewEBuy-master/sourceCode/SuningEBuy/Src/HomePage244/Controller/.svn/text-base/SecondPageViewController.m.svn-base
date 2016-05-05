//
//  SecondPageViewController.m
//  SuningEBuy
//
//  Created by zhangbeibei on 14-9-28.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "SecondPageViewController.h"

@interface SecondPageViewController ()

@end

@implementation SecondPageViewController


- (id)init {
    self  = [super init];
    if (self) {
        self.pageTitle =L(@"PageTitlePageSet");
        self.hasNav = YES;
        self.iOS7FullScreenLayout = YES;
        self.hidesBottomBarWhenPushed = YES;
        
        floorDataArray = [[NSMutableArray alloc] init];
    }
    return self;
}


- (HomePageService244 *)homePageService {
    if (!_homePageService) {
        _homePageService = [[HomePageService244 alloc] init];
        _homePageService.delegate = self;
    }
    return _homePageService;
}

#pragma mark -ViewLifeCycle

- (void)loadView
{
    [super loadView];
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    //发送请求，获取页面集数据
    if (!IsStrEmpty(self.pageID)) {
        [self.homePageService querySecondPageWithPageID:self.pageID];
    }
    else {
        [self backForePage];
    }

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.homePageService cancelSecondPageRequest];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.frame = [self visibleBoundsShowNav:YES showTabBar:NO];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.multipleTouchEnabled = NO;
    //    self.tableView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.backgroundColor = [UIColor view_Back_Color];
    [self.view addSubview:self.tableView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource & Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [floorDataArray count];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //页面处理逻辑和首页的楼层一样
    int row = indexPath.row;
    HomeFloorDTO *homeFloorDTO = [floorDataArray safeObjectAtIndex:row];
    
    static NSString *cellReuseIdentifier = @"HomeFloorCellIdentifier";
    NSString *floorIDString = [[GlobalDataCenter defaultCenter].floorID_TypeDict objectForKey:homeFloorDTO.templateID];
    int flootType = -1;
    if (NotNilAndNull(floorIDString)) {
        flootType = [floorIDString intValue];
    }
    
    NSString *cellFullIdentifier = [NSString stringWithFormat:@"HomeFloorCellIdentifier_%@", homeFloorDTO.templateID];
    
    HomeFloorTableViewCell *cell = nil;
    switch (flootType) {
        case 1: {
            cell = [tableView dequeueReusableCellWithIdentifier:cellFullIdentifier];
            if (!cell) {
                cell = [[HomeFloorTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellFullIdentifier];
                //                [cell.contentView addSubview:self.eightBannerView];
                EightBannerView244 *bannerView = [[EightBannerView244 alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
                bannerView.tag = 77001;
                bannerView.delegate = self;
                
                [cell.contentView addSubview:bannerView];
                TT_RELEASE_SAFELY(bannerView);
            }
            
            //更新cell内容
            EightBannerView244 *view = (EightBannerView244 *)[cell.contentView viewWithTag:77001];
            
            [view updateViewWithDTO:homeFloorDTO];
            break;
        }
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
        case 8:
        case 9:
        case 10:
        case 11:
        case 13:
        case 14:
        case 15:
        case 18:
        case 19:
        case 20:
        case 21:
        case 22: {
            cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
            if (!cell) {
                //                cell = [[NSClassFromString(CellClassName) alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellFullIdentifier];
                cell = [[HomeFloorTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseIdentifier];
                cell.delegate = self;
            }
            cell.selectionStyle
            = UITableViewCellSelectionStyleNone;
            if ([cell respondsToSelector:@selector(updateViewWithFloorDTO:)]) {
                [cell performSelector:@selector(updateViewWithFloorDTO:) withObject:homeFloorDTO];
            }
            
            break;
        }
        case 12: {
            cell = [tableView dequeueReusableCellWithIdentifier:cellFullIdentifier];
            if (!cell) {
                cell = [[HomeFloorTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellFullIdentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                Floor12View *tempView = [[Floor12View alloc] initWithFrame:CGRectMake(0, 0, 320, 75)];
                tempView.delegate = self;
                tempView.tag = 77010;
                [cell.contentView addSubview:tempView];
                TT_RELEASE_SAFELY(tempView);
                
            }
            Floor12View *shopView = (Floor12View *)[cell.contentView viewWithTag:77010];
            
            [shopView updateViewWithFloorDTO:homeFloorDTO];
            
            break;
        }
        case 16: {
            cell = [tableView dequeueReusableCellWithIdentifier:cellFullIdentifier];
            if (!cell) {
                cell = [[HomeFloorTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellFullIdentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                //                [cell.contentView addSubview:self.shopRecommendView];
                
                ShopRecommend244 *tempShop = [[ShopRecommend244 alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
                tempShop.tag = 77002;
                tempShop.delegate = self;
                [cell.contentView addSubview:tempShop];
                TT_RELEASE_SAFELY(tempShop);
                
            }
            
            //更新cell内容
            ShopRecommend244 *shopView = (ShopRecommend244 *)[cell.contentView viewWithTag:77002];
            
            [shopView updateViewWithFloorDTO:homeFloorDTO];
            
            break;
        }
        case 17: {
            cell = [tableView dequeueReusableCellWithIdentifier:cellFullIdentifier];
            if (!cell) {
                cell = [[HomeFloorTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellFullIdentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;

                BrandRecommend244 *tempBrand = [[BrandRecommend244 alloc] initWithFrame:CGRectMake(0, 0, 320, 140)];
                tempBrand.delegate = self;
                tempBrand.tag = 77003;
                [cell.contentView addSubview:tempBrand];
                TT_RELEASE_SAFELY(tempBrand);
            }
            
            BrandRecommend244 *brandView = (BrandRecommend244 *)[cell.contentView viewWithTag:77003];
            [brandView updateViewWithFloorDTO:homeFloorDTO];
            
            break;
        }
        default: {
            cell = [tableView dequeueReusableCellWithIdentifier:cellFullIdentifier];
            if (!cell) {
                cell = [[HomeFloorTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellFullIdentifier];
            }
        }
            break;
    }
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeFloorDTO *homeFloorDTO = [floorDataArray safeObjectAtIndex:indexPath.row];
    
    NSString *floorIDString = [[GlobalDataCenter defaultCenter].floorID_TypeDict objectForKey:homeFloorDTO.templateID];
    int flootType = -1;
    if (NotNilAndNull(floorIDString)) {
        flootType = [floorIDString intValue];
    }
    
    //从字段中取出楼层type对应的高度
    NSString *tempStr = [NSString stringWithFormat:@"app_%02d",flootType];
    if ([[GlobalDataCenter defaultCenter].homeCellHeightDict objectForKey:tempStr]) {
        return [[[GlobalDataCenter defaultCenter].homeCellHeightDict objectForKey:tempStr] floatValue];
    }
    else {
        //不识别的楼层模板，高度设置为0
        return 0.0;
    }
}


#pragma mark -HomePageServiceDelegate
- (void) homePageServiceComplete:(HomePageService244 *)service isSuccess:(BOOL) isSuccess {
    if (isSuccess) {
        if (KPerformance)
        {
            if ([PerformanceStatistics sharePerformanceStatistics].arrayData.count > 0)
            {
                
                [PerformanceStatistics sharePerformanceStatistics].countStatus += 1;
                if ([PerformanceStatistics sharePerformanceStatistics].countStatus == [PerformanceStatistics sharePerformanceStatistics].arrayData.count)
                {
                    PerformanceStatisticsData* temp = [[PerformanceStatistics sharePerformanceStatistics].arrayData safeObjectAtIndex:0];
                    temp.endTime = [NSDate date];
                    [[PerformanceStatistics sharePerformanceStatistics]sendData:temp];
                    [[PerformanceStatistics sharePerformanceStatistics].arrayData removeAllObjects];
                }
            }
            
        }
        
        //二级页标题
        if (!IsStrEmpty(service.pageName)) {
            self.title = service.pageName ? service.pageName : @"";
            
            //采集pagetitle
            self.pageTitle = [NSString stringWithFormat:@"%@-%@", L(@"PageTitlePageSetPrefix"), service.pageName];
            [SSAIOSSNDataCollection multiPagesInCollection:self.pageTitle];
        }
        
        //有数据则刷新页面，无数据则弹出提示框
        if (!IsArrEmpty(service.floorArray)) {
            [floorDataArray removeAllObjects];
            [floorDataArray addObjectsFromArray:service.floorArray];
            [self.tableView reloadData];
        }
        else {
            
            BBAlertView *alert = [[BBAlertView alloc] initWithTitle:@""
                                                            message:L(@"AlertVisitedPageInexistence")
                                                           delegate:self
                                                  cancelButtonTitle:L(@"AlertIKnow")
                                                  otherButtonTitles:nil];

            [alert show];
        }
        

    }
    else {
        [self presentSheet:service.errorMsg];
    }
}


#pragma mark - BBAlertViewDelegate
- (void)alertView:(BBAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    //返回上一页
    [self backForePage];
}


#pragma mark - EightBannerViewDelegate
- (void)eightBannerSelectedDTO:(HomeModuleDTO *)moduleDTO {
    [self handleTargetType:moduleDTO.targetType targetURLString:moduleDTO.targetURL];
}

- (void)selectModuleDTO:(HomeModuleDTO *)dto {
    [self eightBannerSelectedDTO:dto];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
