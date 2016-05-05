//
//  LianBanZhuanTiViewController.m
//  SuningEBuy
//
//  Created by zhangbeibei on 14-9-17.
//  Copyright (c) 2014年 Suning. All rights reserved.
//


#import "LianBanZhuanTiViewController.h"
#import "ProductUtil.h"

@interface LianBanZhuanTiViewController ()

@end

@implementation LianBanZhuanTiViewController


-(void)dealloc
{
    [self unRegistKVO];
}

- (id)init {
    self = [super init];
    if (self) {
        self.isLotteryController = NO;
        self.isNeedBackItem = YES;
        self.hasNav = YES;
        self.bSupportPanUI = YES;
        self.iOS7FullScreenLayout = YES;
        hasAdImageView = NO;
        self.hidesBottomBarWhenPushed = YES;
        self.whereFrom = SNRouteSourceNone;
    }
    
    return self;
}


- (void)loadView
{
    [super loadView];
    
//    self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"PageTitleLianBanZhuanTi"),self.title];
    
    [self registKVO];
    
    //查询连版专题数据
    [self.zhuanTiService queryLianBanZhuanTiWithID:self.targetModuleID];
    
}

- (ZhuanTiService244 *)zhuanTiService {
    if (!_zhuanTiService) {
        _zhuanTiService = [[ZhuanTiService244 alloc] init];
        _zhuanTiService.delegate = self;
    }
    
    return _zhuanTiService;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    //解决在商品四级页里更改城市后，再返回列表页，列表里已经显示在页面上的那些cell的价格图片还是不变的问题
    NSArray *visibleIndexPath = [self.tableView indexPathsForVisibleRows];
    for (NSIndexPath *indexPath in visibleIndexPath) {
        if (indexPath.section == 1) {
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            if ([cell respondsToSelector:@selector(updateCellProductPriceImage)]) {
                [cell performSelector:@selector(updateCellProductPriceImage) withObject:nil];
            }
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    //取消请求和代理
    [self.zhuanTiService cancelLianBanRequestAdnDelegate];
}


#pragma mark -
#pragma mark KVO
//注册KVO监听
- (void)registKVO
{
    [self addObserver:self
           forKeyPath:@"AdActiveRuleCellHeight"
              options:NSKeyValueObservingOptionNew
              context:NULL];
}

- (void)unRegistKVO
{
    [self removeObserver:self
              forKeyPath:@"AdActiveRuleCellHeight"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"AdActiveRuleCellHeight"])
    {
        [self.tableView reloadData];
    }
}

-(void)setAdRowHeight:(CGFloat)height
{
    self.AdActiveRuleCellHeight = height;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.frame = [self visibleBoundsShowNav:YES showTabBar:NO];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.multipleTouchEnabled = NO;
    self.tableView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    self.tableView.backgroundColor = [UIColor view_Back_Color];
    [self.view addSubview:self.tableView];
}


- (void)zhuanTiServiceCompleted:(ZhuanTiDTO *)dto isSuccess:(BOOL)isSuccess errorMsg:(NSString *)errMsg {
    if (isSuccess) {
        if (_dataDTO != dto) {
            _dataDTO = dto;
        }
        
        //活动标题
        self.title = dto.subjectName ? dto.subjectName : @"";
        
        //采集pagetitle
        if (!IsStrEmpty(dto.subjectName)) {
            self.pageTitle = [NSString stringWithFormat:@"%@-%@", L(@"PageTitleLianBanZhuanTiPrefix"), dto.subjectName];
            [SSAIOSSNDataCollection multiPagesInCollection:self.pageTitle];
        }
        
        //处理广告信息
        TopADInfoDTO *adInfo = _dataDTO.topAD;
        if (!IsStrEmpty(adInfo.adImg)) {
            hasAdImageView = YES;
        }
        else {
            hasAdImageView = NO;
        }

        //调整广告文字的高度
        self.AdActiveRuleCellHeight = [AdActiveRuleCell cellHeight:adInfo.activityInfo];
        
        //如果没有数据，弹出提示，当用户点击确定按钮时返回上一页
        if (IsArrEmpty(_dataDTO.dataArray)) {
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
    else {
        if(_whereFrom == SNRouteSourceNone)
        {
            [self presentSheet:errMsg];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_dataDTO.dataArray count] + 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        if ([self getRuleHeight] == 0) {
            return 1;
        }else{
            return 2;
        }
    }
    else {
        LianBanFloorDTO *lianBanDTO = [_dataDTO.dataArray objectAtIndex:section-1];
        int count = [lianBanDTO.productArray count];
        return (count%2==0) ? count/2 : count/2+1;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0)
    {
        if (indexPath.row == 0) {
            if (hasAdImageView) {
                return 150;
            }
            else {
                return 0.0f;
            }

        }
        else {
            if ([self getRuleHeight] == 0) {
                
                return 0;
                
            }else{
                
                return self.AdActiveRuleCellHeight;
            }
        }
    }
    else {
        //一行两个商品
        return 190+30;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    else {
        return 40;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0 && !hasAdImageView && [self getRuleHeight] == 0) {
        return 0.0f;
    }
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return nil;
    }
    else {
        LBZTTableHeaderView *headerView = [[LBZTTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        [headerView updateViewWithDTO:[_dataDTO.dataArray safeObjectAtIndex:section - 1]];
        return headerView;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    int row = indexPath.row;
    TopADInfoDTO *adInfo = _dataDTO.topAD;
    
    if (indexPath.section == 0) {
        if (row == 0) {
            
            static NSString *innerImageViewIdentifier = @"innerImageViewIdentifier";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:innerImageViewIdentifier];
            
            if(cell == nil){
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:innerImageViewIdentifier];
                cell.accessoryType = UITableViewCellStyleDefault;
            }
            
            EGOImageButton *innerImageView = [[EGOImageButton alloc] initWithFrame:CGRectMake(0, 0, 320, 150)];
            [innerImageView setImageURL:[NSURL URLWithString:adInfo.adImg]];
            [innerImageView addTarget:self action:@selector(jumpToActivity) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:innerImageView];
            cell.clipsToBounds = YES;
            return cell ;
        }
        else {
            //section 0 , row 1
            static NSString *ActiveRuleCellIdentifier = @"ActiveRuleCellIdentifier——model4";
            
            AdActiveRuleCell *acell = (AdActiveRuleCell *)[tableView dequeueReusableCellWithIdentifier:ActiveRuleCellIdentifier];
            if(acell == nil){
                acell = [[AdActiveRuleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ActiveRuleCellIdentifier];
                acell.accessoryType = UITableViewCellAccessoryNone;
                acell.delegate=self;
            }
            [acell setRuleContent:adInfo.activityInfo];
            return acell;
        }
    }
    else {
        //一行两个
        static NSString *adModel3CellIdentifier = @"adModel3CellIdentifier";
        
        AdModel6Cell *cell = (AdModel6Cell *)[tableView dequeueReusableCellWithIdentifier:adModel3CellIdentifier];
        
        if(cell == nil){
            
            cell = [[AdModel6Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:adModel3CellIdentifier];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.accessoryType = UITableViewCellAccessoryNone;
            
            cell.backgroundColor = [UIColor clearColor];
            
            cell.imageDidDelegate = self;
        }
        
        int row = indexPath.row;
        int count;
        
        LianBanFloorDTO *lianBanDTO  = [_dataDTO.dataArray safeObjectAtIndex:(indexPath.section-1)];
        NSArray *productArray = lianBanDTO.productArray;
        InnerProductDTO *leftDto = nil;
        InnerProductDTO *rightDto = nil;
        
        
        count = [productArray count];
        
        if (row*2 < count) {
            
            HomeProductDTO *productDTO = [productArray safeObjectAtIndex:row*2];
            leftDto = [[InnerProductDTO alloc] init];
            leftDto.partNum = productDTO.orderNO;
            leftDto.productId = productDTO.productID;
            leftDto.productName = productDTO.productName;
            leftDto.productCode = productDTO.productCode;
            leftDto.vendorCode = productDTO.providerCode;
            leftDto.bigBang = productDTO.bigBang;
            leftDto.promIcon = productDTO.promIcon;
            leftDto.productDesc = productDTO.productDescription;
            //最优价格
            leftDto.priceImageURL = [ProductUtil minPriceImageOfProductId:productDTO.productID productCode:productDTO.productCode city:[Config currentConfig].defaultCity shopCode:productDTO.providerCode];
        }
        
        if (row*2+1 < count) {

            HomeProductDTO *productDTO = [productArray safeObjectAtIndex:row*2+1];
            rightDto = [[InnerProductDTO alloc] init];
            rightDto.partNum = productDTO.orderNO;
            rightDto.productId = productDTO.productID;
            rightDto.productName = productDTO.productName;
            rightDto.productCode = productDTO.productCode;
            rightDto.vendorCode = productDTO.providerCode;
            rightDto.bigBang = productDTO.bigBang;
            rightDto.promIcon = productDTO.promIcon;
            rightDto.productDesc = productDTO.productDescription;
            //最优价格
            rightDto.priceImageURL = [ProductUtil minPriceImageOfProductId:productDTO.productID productCode:productDTO.productCode city:[Config currentConfig].defaultCity shopCode:productDTO.providerCode];
        }
        
        [cell setItem:leftDto rightItem:rightDto withTag:row];
        
        return cell;
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)getRuleHeight{
    TopADInfoDTO *adInfo = _dataDTO.topAD;
    
    if (!adInfo.activityInfo) {
        return 0;
    }
    
    if (![AdActiveRuleCell canShowRuleCell:adInfo.activityInfo]) {
        
        return 0;
        
    }else{
        
        return   [AdActiveRuleCell height: adInfo.activityInfo];
    }
    
}

#pragma mark - TopAdImageClickMethod
- (void)jumpToActivity {
    TopADInfoDTO *adInfo = _dataDTO.topAD;
    
    [self handleTargetType:@"4" targetURLString:adInfo.targetURL];
}



#pragma mark - Model4Delegate && Model6Delegate && AdModel3Cell
- (void)cellImageDidClicked:(DataProductBasic *)dto {
    DLog(@"here clicked");
    
    if (dto == nil) {
        
        return;
    }
    
    //处理自营商品，商品集、连版专题接口返回的自营商品的供应商编码是10个0，需要修改一下。
    if ([dto.shopCode isEqualToString:@"0000000000"]) {
        dto.shopCode = @"";
    }
    else if ([dto.shopCode isEqualToString:@""]){
        dto.shopCode = nil;
    }
    
    ProductDetailViewController *controller = [[ProductDetailViewController alloc] initWithDataBasicDTO:dto];

    controller.productType = EightBannerProduct;
    [self.navigationController pushViewController:controller animated:YES];
    TT_RELEASE_SAFELY(controller);
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
