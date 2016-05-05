//
//  ChooseCouponViewController.m
//  SuningEBuy
//
//  Created by  liukun on 13-12-24.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "ChooseCouponViewController.h"
#import "GiftCouponService.h"
#import "NCouponItemCell.h"
#import "NCouponValidateCodeCell.h"
#import "UITableViewCell+BgView.h"
#import "NCouponRecommendCell.h"
#import "AddCouponViewController.h"
#import "NCouponFinalCell.h"

@interface ChooseCouponViewController () <GiftCouponServiceDelegate, NCouponItemCellDelegate,AddCouponDelegate, UITextFieldDelegate>
{
    NSMutableArray *_dataSourceArray;
    
    UIButton    *_getCodeButton;
    UITextField *_codeTextField;
    UITextField *_recommendPhoneField;
    
    NSMutableArray *_dataSourceUnable;
    UIImageView    *arrowbtn;
    BOOL        istableshow;
    
    NSInteger   totalVisibleCount;
    NSInteger   totalUnableCount;
}
@property (nonatomic, strong) NSMutableArray *selectcouponarray;

@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) UIButton *button2;
@property (nonatomic, strong) GiftCouponService *giftCouponService;
@property (nonatomic, strong) UIImageView *bottomView;
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) CheckCodeService *checkCodeService;
@property (nonatomic, assign) int selectIndex;
@property (nonatomic, strong) UIImageView *lineView;
@property (nonatomic, strong) UIButton *headerviewbtn;
@end

@implementation ChooseCouponViewController

- (void)dealloc
{
    SERVICE_RELEASE_SAFELY(_giftCouponService);
    
    [_checkCodeService stopCalculagraph];
    SERVICE_RELEASE_SAFELY(_checkCodeService);
    
}


-(void)updateTableView{
    //    [];
}

- (id)init
{
    self = [super init];
    if (self) {
        self.title = L(@"PFUseCouponOrRecommendationNumber");
        self.pageTitle = L(@"Product_ShoppingCart_UseCoupon");//[NSString stringWithFormat:@"%@-%@",L(@"shopProcess_shop_ticketList"AddCouponViewController),self.title];
        
        [self.view addSubview:self.button1];
        UIView *vSeplineV = [[UIView alloc] initWithFrame:CGRectMake(self.button1.frame.size.width, 25 / 2, 0.5, 15)];
        vSeplineV.backgroundColor = [UIColor colorWithRGBHex:0xdcdcdc];
        [self.view addSubview:vSeplineV];
        
        [self.view addSubview:self.button2];
        UIView *vSeplineV2 = [[UIView alloc] initWithFrame:CGRectMake(self.button2.frame.size.width + self.button2.origin.x, 25 / 2, 0.5, 15)];
        vSeplineV2.backgroundColor = [UIColor colorWithRGBHex:0xdcdcdc];
        [self.view addSubview:vSeplineV2];
        
        UIView *vBottomGrayLine = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, 320, 0.5)];
        vBottomGrayLine.backgroundColor = [UIColor colorWithRGBHex:0xdcdcdc];
        [self.view addSubview:vBottomGrayLine];
        
        [self.view bringSubviewToFront:vSeplineV];
        [self.view bringSubviewToFront:vSeplineV2];
        [self checkCodeService];    //初始化service
        [self setButtonsBackground];
        _selectIndex=0;
        istableshow = NO;
        self.bSupportPanUI = NO;
    }
    return self;
}

- (UIButton *)button1
{
    if (!_button1)
    {
        _button1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 160, 40)];
        
        _button1.backgroundColor = [UIColor clearColor];
        
        _button1.titleLabel.font = [UIFont systemFontOfSize:14.0];
        //        _button1.layer.borderColor = [UIColor lightGrayColor].CGColor;
        //        _button1.layer.borderWidth = 1;
        [_button1 setTitle:L(@"PFAvailableTickets") forState:UIControlStateNormal];
        [_button1 setTitleColor:RGBCOLOR(139, 139, 139) forState:UIControlStateNormal];
        _button1.tag = 0;
        
        
        [_button1 addTarget:self
                     action:@selector(buttonPressed:)
           forControlEvents:UIControlEventTouchUpInside];
        
        [_button1 setBackgroundColor:[UIColor whiteColor]];
    }
    return _button1;
}

- (UIButton *)button2
{
    if (!_button2)
    {
        _button2 = [[UIButton alloc] initWithFrame:CGRectMake(160, 0, 160, 40)];
        
        _button2.backgroundColor = [UIColor clearColor];
        
        _button2.titleLabel.font = [UIFont systemFontOfSize:14.0];
        //        _button2.layer.borderColor = [UIColor lightGrayColor].CGColor;
        //        _button2.layer.borderWidth = 1;
        [_button2 setTitle:L(@"PFUnavailableTickets") forState:UIControlStateNormal];
        [_button2 setTitleColor:RGBCOLOR(139, 139, 139) forState:UIControlStateNormal];
        _button2.tag = 1;
        
        [_button2 addTarget:self
                     action:@selector(buttonPressed:)
           forControlEvents:UIControlEventTouchUpInside];
        
        [_button2 setBackgroundColor:[UIColor whiteColor]];
        
    }
    return _button2;
}

- (void)buttonPressed:(id)sender
{
    NSInteger index = [(UIButton *)sender tag];
    _selectIndex=index;
    if (index == 0) {
        if (!_isCouponLoaded) {
            self.tpTableView.hidden = YES;
            [self displayOverFlowActivityView];
            [self.giftCouponService beginGetGiftCouponListRequest:self.isCOrder unUsable:NO];
        }
        else{
            self.tpTableView.hidden = NO;
            [self prepareTableViewDatasource];
            [self.tpTableView reloadData];
        }
    }
    else{
        if (!_isUnuseCouponLoaded) {
            self.tpTableView.hidden = YES;
            [self sendunuseCouponLisetRequest];
        }
        else{
            self.tpTableView.hidden = NO;
            [self prepareTableViewDatasourceUnable];
            [self.tpTableView reloadData];
        }
    }
    [self setButtonsBackground];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    CGRect frame = [self visibleBoundsShowNav:self.hasNav showTabBar:YES];
    frame.origin.y+=35;
    frame.size.height-=35;
    self.tpTableView.frame = frame;
    [self.view addSubview:self.tpTableView];
    
    [self useBottomNavBar];
    self.bottomNavBar.backButton.hidden = NO;
    [self.bottomNavBar addSubview:self.confirmButton];
    
    //    self.bottomView.frame = CGRectMake(0, frame.size.height-55, 320, 55);
    //    [self.bottomView addSubview:self.confirmButton];
    //    [self.view addSubview:self.bottomView];
}

- (PayFlowService *)payFlowService
{
    if (!_payFlowService) {
        _payFlowService = [[PayFlowService alloc] init];
        _payFlowService.delegate = self;
    }
    return _payFlowService;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    if (!_isCouponLoaded)
    //默认进来可用券
    {
        _selectIndex=0;
        [self sendCouponListRequest];
        [self setButtonsBackground];
    }
    _getCodeButton.enabled = YES;
    [_getCodeButton setTitle:L(@"BTObtain")
                    forState:UIControlStateNormal];
}

- (void)backForePage
{
    //    [self.navigationController popViewControllerAnimated:YES];
    [self confirm:nil];
    //deprecated at 2014/1/7
    //    BOOL hasChoosedCoupon = NO;
    //
    //    for (GiftCouponDTO *dto in self.cashCartList)
    //    {
    //        if (dto.isSelected) {
    //            hasChoosedCoupon = YES;
    //            break;
    //        }
    //    }
    //
    //    for (GiftCouponDTO *dto in self.normalCouponList)
    //    {
    //        if (dto.isSelected) {
    //            hasChoosedCoupon = YES;
    //            break;
    //        }
    //    }
    //
    //    if (hasChoosedCoupon)
    //    {
    //        BBAlertView *alert = [[BBAlertView alloc]
    //                              initWithTitle:L(@"system-info")
    //                              message:@"您是要用券的吧"
    //                              delegate:nil
    //                              cancelButtonTitle:@"否"
    //                              otherButtonTitles:@"是"];
    //        [alert setCancelBlock:^{
    //
    //            [self.navigationController popViewControllerAnimated:YES];
    //        }];
    //        [alert setConfirmBlock:^{
    //
    //            [self confirm:nil];
    //        }];
    //        [alert show];
    //    }
    //    else
    //    {
    //        [self confirm:nil];
    //    }
    
}

#pragma mark ----------------------------- views

- (UIImageView *)bottomView{
    
    if (!_bottomView) {
        _bottomView = [[UIImageView alloc] init];
        _bottomView.userInteractionEnabled = YES;
        _bottomView.backgroundColor = [UIColor clearColor];
        _bottomView.image = [UIImage imageNamed:@"DJ_Detail_GroupBtnBack.png"];
        _bottomView.frame = CGRectMake(0, self.view.bounds.size.height - 92, 320, 55);
    }
    return _bottomView;
}

- (UIButton *)confirmButton
{
    if(!_confirmButton)
    {
        _confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 5, 300, 38)];
        [_confirmButton setTitle:L(@"PFOk") forState:UIControlStateNormal];
        [_confirmButton setTitleColor:[UIColor whiteColor]
                             forState:UIControlStateNormal];
        [_confirmButton setTitleColor:[UIColor dark_Gray_Color] forState:UIControlStateDisabled];
        [_confirmButton addTarget:self
                           action:@selector(confirm:)
                 forControlEvents:UIControlEventTouchUpInside];
        [_confirmButton setBackgroundImage:[UIImage streImageNamed:@"button_white_disable.png"] forState:UIControlStateDisabled];
        
        [_confirmButton setBackgroundImage:[UIImage streImageNamed:@"button_orange_normal.png"]
                                  forState:UIControlStateNormal];
    }
    
    return _confirmButton;
}

#pragma mark ----------------------------- table view refresh

- (void)scrollToBottom
{
    NSInteger sectionCount = [_dataSourceArray count];
    NSInteger lastSectionRowCount = [[[_dataSourceArray lastObject] objectForKey:kTableViewNumberOfRowsKey] integerValue];
    NSIndexPath* ipath = [NSIndexPath indexPathForRow:lastSectionRowCount-1 inSection:sectionCount-1];
    [self.tpTableView scrollToRowAtIndexPath:ipath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (void)reloadTableView
{
    [self prepareTableViewDatasource];
    [self.tpTableView reloadData];
}

- (void)prepareTableViewDatasourceUnable
{
    NSMutableArray *array = [NSMutableArray array];
    
    NSInteger totalCount = 0;
    
    //礼品卡行
    if (self.uncashCartList.count > 0)
    {
        totalCount += self.uncashCartList.count;
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        
        //添加数据
        NSMutableArray *cellList = [NSMutableArray array];
        
        for (GiftCouponDTO *dto in self.uncashCartList)
        {
            NSDictionary *cellDic = @{
                                      kTableViewCellTypeKey: @"Coupon_Cell",
                                      kTableViewCellDataKey: dto,
                                      kTableViewCellHeightKey : @([NCouponItemCell height])};
            [cellList addObject:cellDic];
        }
        [dic setObject:@([cellList count]) forKey:kTableViewNumberOfRowsKey];
        [dic setObject:cellList forKey:kTableViewCellListKey];
        
        [array addObject:dic];
    }
 
    //普通券行
    {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        
        NSMutableArray *cellList = [NSMutableArray array];
        
        if (self.unnormalCouponList.count != 0)
        {
            
            totalCount += self.unnormalCouponList.count;

            for (GiftCouponDTO *dto in self.unnormalCouponList)
            {
                NSDictionary *cellDic = @{
                                          kTableViewCellTypeKey: @"Coupon_Cell",
                                          kTableViewCellDataKey: dto,
                                          kTableViewCellHeightKey : @([NCouponItemCell height])};
                [cellList addObject:cellDic];
            }

//            if (!_headerviewbtn) {
            
//            }
            //没有优惠券
            [dic setObject:@([cellList count]) forKey:kTableViewNumberOfRowsKey];
            [dic setObject:cellList forKey:kTableViewCellListKey];
            
            [array addObject:dic];

        }
        else
        {
            if (self.unccouplist.count == 0) {
                NSDictionary *cellDic = @{
                                          kTableViewCellTypeKey: @"NoCoupon_Cell",
                                          kTableViewCellDataKey: [NSNull null],
                                          kTableViewCellHeightKey : @(44)};
                [cellList addObject:cellDic];
                [dic setObject:@([cellList count]) forKey:kTableViewNumberOfRowsKey];
                [dic setObject:cellList forKey:kTableViewCellListKey];
                
                [array addObject:dic];

            }
            
        }
        
//        [dic setObject:@([cellList count]) forKey:kTableViewNumberOfRowsKey];
//        [dic setObject:cellList forKey:kTableViewCellListKey];
//        
//        [array addObject:dic];
    }
    //c店店铺
    if (self.unccouplist.count >0 ) {
        for (NSDictionary *dto in self.unccouplist) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            
            //添加数据
            NSMutableArray *cellList = [NSMutableArray array];
            [self.unccouplisttitle addObject:[dto objectForKey:@"vendorName"]];
            NSArray *array1 = [dto objectForKey:@"couponlist"];
            
            for (GiftCouponDTO *dto1 in array1){
                NSDictionary *cellDic = @{
                                          kTableViewCellTypeKey: @"CCoupon_Cell",
                                          kTableViewCellDataKey: dto1,
                                          kTableViewCellHeightKey : @([NCouponItemCell height])};
                [cellList addObject:cellDic];
            }
            [dic setObject:@([cellList count]) forKey:kTableViewNumberOfRowsKey];
            [dic setObject:cellList forKey:kTableViewCellListKey];
            [array addObject:dic];
            
        }
        
        
    }
    
    totalUnableCount = totalCount;
    if (_isUnuseCouponLoaded) {
        [self.button2 setTitle:[NSString stringWithFormat:@"%@(%d)", L(@"PFUnavailableTickets"),totalUnableCount]
                      forState:UIControlStateNormal];
    }
    _dataSourceUnable = array;
}

-(NSMutableArray *)ccouplisttitle{
    if (!_ccouplisttitle) {
        _ccouplisttitle = [[NSMutableArray alloc] init];
    }
    return _ccouplisttitle;
}

-(NSMutableArray *)selectcouponarray{
    if (!_selectcouponarray) {
        _selectcouponarray = [[NSMutableArray alloc] init];
    }
    return _selectcouponarray;
}

-(NSMutableArray *)unccouplisttitle{
    if (!_unccouplisttitle) {
        _unccouplisttitle = [[NSMutableArray alloc] init];
    }
    return _unccouplisttitle;
}
- (void)prepareTableViewDatasource
{
    NSMutableArray *array = [NSMutableArray array];
    
    NSInteger totalCount = 0;
    //礼品卡行
    if (self.cashCartList.count > 0 )
    {
        totalCount += self.cashCartList.count;
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        
        //添加数据
        NSMutableArray *cellList = [NSMutableArray array];
        
        BOOL _isShowCashCardValidCell = NO;
        for (GiftCouponDTO *dto in self.cashCartList)
        {
            if (dto.isSelected) {
                _isShowCashCardValidCell = YES;
            }
            NSDictionary *cellDic = @{
                                      kTableViewCellTypeKey: @"Coupon_Cell",
                                      kTableViewCellDataKey: dto,
                                      kTableViewCellHeightKey : @([NCouponItemCell height])};
            [cellList addObject:cellDic];
        }
        
        if (_isShowCashCardValidCell)
        {
            NSDictionary *cellDic = @{
                                      kTableViewCellTypeKey: @"ValidateCode_Cell",
                                      kTableViewCellDataKey: [NSNull null],
                                      kTableViewCellHeightKey : @([NCouponValidateCodeCell height:[UserCenter defaultCenter].userInfoDTO.phoneNo])};
            [cellList addObject:cellDic];
        }
        
        [dic setObject:@([cellList count]) forKey:kTableViewNumberOfRowsKey];
        [dic setObject:cellList forKey:kTableViewCellListKey];
        //        if (!_cashdic) {
        //            _cashdic = [[NSDictionary    alloc] initWithDictionary:dic];
        //        }
        self.cashdic = dic;
        if (!istableshow) {
            [array addObject:dic];
        }
        else{
            NSMutableDictionary *dic1 = [[NSMutableDictionary alloc] init];
            [array addObject:dic1];
            
        }
    }
  
    //普通券行
    if (self.normalCouponList.count>0)
    {
        
        totalCount += self.normalCouponList.count;

        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        
        NSMutableArray *cellList = [NSMutableArray array];
        
        {
            for (GiftCouponDTO *dto in self.normalCouponList)
            {
                NSDictionary *cellDic = @{
                                          kTableViewCellTypeKey: @"Coupon_Cell",
                                          kTableViewCellDataKey: dto,
                                          kTableViewCellHeightKey : @([NCouponItemCell height])};
                [cellList addObject:cellDic];
            }
        }
        
        [dic setObject:@([cellList count]) forKey:kTableViewNumberOfRowsKey];
        [dic setObject:cellList forKey:kTableViewCellListKey];
        if (self.ccouplist.count==0) {
            //添加优惠券行
            NSDictionary *cellDic = @{
                                      kTableViewCellTypeKey: @"AddCoupon_Cell",
                                      kTableViewCellDataKey: [NSNull null],
                                      kTableViewCellHeightKey : @(44)};
            [cellList addObject:cellDic];
            
            [dic setObject:@([cellList count]) forKey:kTableViewNumberOfRowsKey];
            [dic setObject:cellList forKey:kTableViewCellListKey];

        }
        
        [array addObject:dic];
    }
    
       //c店店铺
    if (self.ccouplist.count >0 ) {
        //添加数据
        int indextaddcoup=0;
        for (NSDictionary *dto in self.ccouplist) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            NSMutableArray *cellList = [NSMutableArray array];
            [self.ccouplisttitle addObject:[dto objectForKey:@"vendorName"]];
            NSArray *array1 = [dto objectForKey:@"couponlist"];
            for (GiftCouponDTO *dto1 in array1){
                NSDictionary *cellDic = @{
                                          kTableViewCellTypeKey: @"Coupon_Cell",
                                          kTableViewCellDataKey: dto1,
                                          kTableViewCellHeightKey : @([NCouponItemCell height])};
                [cellList addObject:cellDic];
            }
            
//            [dic setObject:@([cellList count]) forKey:kTableViewNumberOfRowsKey];
//            [dic setObject:cellList forKey:kTableViewCellListKey];
            if (indextaddcoup==self.ccouplist.count-1) {
                //添加优惠券行
                NSDictionary *cellDic1 = @{
                                          kTableViewCellTypeKey: @"AddCoupon_Cell",
                                          kTableViewCellDataKey: [NSNull null],
                                          kTableViewCellHeightKey : @(44)};
                [cellList addObject:cellDic1];

            }
            
            [dic setObject:@([cellList count]) forKey:kTableViewNumberOfRowsKey];
            [dic setObject:cellList forKey:kTableViewCellListKey];
            [array addObject:dic];
            indextaddcoup++;
        }
        
       
    }
    if (self.ccouplist.count == 0 && self.normalCouponList.count ==0 && self.cashCartList.count==0) {
        //没有优惠券
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        NSMutableArray *cellList = [NSMutableArray array];

        NSDictionary *cellDic = @{
                                  kTableViewCellTypeKey: @"NoCoupon_Cell",
                                  kTableViewCellDataKey: [NSNull null],
                                  kTableViewCellHeightKey : @(44)};
        [cellList addObject:cellDic];
        [dic setObject:@([cellList count]) forKey:kTableViewNumberOfRowsKey];
        [dic setObject:cellList forKey:kTableViewCellListKey];
        [array addObject:dic];
        


    }
    if (self.ccouplist.count == 0 && self.normalCouponList.count ==0) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        NSMutableArray *cellList = [NSMutableArray array];

        NSDictionary *cellDic1 = @{
                                   kTableViewCellTypeKey: @"AddCoupon_Cell",
                                   kTableViewCellDataKey: [NSNull null],
                                   kTableViewCellHeightKey : @(44)};
        [cellList addObject:cellDic1];
        [dic setObject:@([cellList count]) forKey:kTableViewNumberOfRowsKey];
        [dic setObject:cellList forKey:kTableViewCellListKey];
        [array addObject:dic];
        
    }

    //推荐号行
    {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        
        NSMutableArray *cellList = [NSMutableArray array];
        
        //添加优惠券行
        {
            NSDictionary *cellDic = @{
                                      kTableViewCellTypeKey: @"RecommendCode_Cell",
                                      kTableViewCellDataKey: [NSNull null],
                                      kTableViewCellHeightKey : @([NCouponRecommendCell height])};
            [cellList addObject:cellDic];
        }
        
        //已添加的联盟推荐号行
        if ([self hasAlliance])
        {
            NSDictionary *cellDic = @{
                                      kTableViewCellTypeKey: @"Alliance_Cell",
                                      kTableViewCellDataKey: [NSNull null],
                                      kTableViewCellHeightKey : @([NCouponFinalCell height])};
            [cellList addObject:cellDic];
        }
        
        [dic setObject:@([cellList count]) forKey:kTableViewNumberOfRowsKey];
        [dic setObject:cellList forKey:kTableViewCellListKey];
        
        [array addObject:dic];
    }

    totalVisibleCount = totalCount;
    if (_isCouponLoaded) {
        [self.button1 setTitle:[NSString stringWithFormat:@"%@(%d)",L(@"PFAvailableTickets"),totalVisibleCount]
                      forState:UIControlStateNormal];
    }
    _dataSourceArray = array;
}

#pragma mark ----------------------------- tableView dataSource and delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_selectIndex == 0) {
        return [_dataSourceArray count];
    }
    return [_dataSourceUnable count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_selectIndex == 0) {
        NSDictionary *sectionDic = [_dataSourceArray safeObjectAtIndex:section];
        return [[sectionDic objectForKey:kTableViewNumberOfRowsKey] integerValue];
    }
    else{
        NSDictionary *sectionDic = [_dataSourceUnable safeObjectAtIndex:section];
        return [[sectionDic objectForKey:kTableViewNumberOfRowsKey] integerValue];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_selectIndex == 0) {
        NSDictionary *sectionDic = [_dataSourceArray safeObjectAtIndex:indexPath.section];
        NSArray *cellList = [sectionDic objectForKey:kTableViewCellListKey];
        NSDictionary *cellDic = [cellList safeObjectAtIndex:indexPath.row];
        return [[cellDic objectForKey:kTableViewCellHeightKey] floatValue];
    }
    else{
        NSDictionary *sectionDic = [_dataSourceUnable safeObjectAtIndex:indexPath.section];
        NSArray *cellList = [sectionDic objectForKey:kTableViewCellListKey];
        NSDictionary *cellDic = [cellList safeObjectAtIndex:indexPath.row];
        return [[cellDic objectForKey:kTableViewCellHeightKey] floatValue];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0 && _selectIndex == 0) {
        if (self.cashCartList.count>0) {
            return 40;
        }
    }
    if (_selectIndex == 0) {
        int indexfrom=0;
        if (self.normalCouponList.count>0) {
            indexfrom++;
        }
        if (self.cashCartList.count>0) {
            indexfrom++;
        }
        if (section >= indexfrom) {
            if (self.normalCouponList.count == 0 && self.ccouplist.count==0) {
                return 5;
            }
            return 40;
    }
    
    }
    if (_selectIndex == 1) {
        int indexfrom=0;
        if (self.unnormalCouponList.count>0) {
            indexfrom++;
        }
        if (self.uncashCartList.count>0) {
            indexfrom++;
        }
        if (section >= indexfrom) {
            if (self.unccouplist.count == 0) {
                return 5;
            }
            return 40;
        }
    }
    
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (_selectIndex == 0) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
        if (self.cashCartList.count>0) {
            if (section == 0) {
                [view addSubview:self.headerviewbtn];
            }
        }
        if (self.ccouplisttitle.count>0) {
            int indexfrom = 0;
            if (self.cashCartList.count>0) {
                indexfrom++;
            }
            if (self.normalCouponList.count>0) {
                indexfrom++;
            }
            if (section >= indexfrom && section<self.ccouplist.count+indexfrom) {
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 250, 40)];
                label.backgroundColor = [UIColor clearColor];
                UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(280, 0, 40, 40)];
                [lab setBackgroundColor:[UIColor clearColor]];
                NSDictionary *dic = [self.ccouplist objectAtIndex:section-indexfrom];
                NSString *str = [NSString stringWithFormat:@"(%@)",[dic objectForKey:@"couponCount"]];
                lab.text = str;
                label.text = [self.ccouplisttitle objectAtIndex:section-indexfrom];
                [view addSubview:lab];
                [view addSubview:label];
            }
        }
        return view;
    }
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    if (self.unccouplisttitle.count>0) {
        int indexfrom = 0;
        if (self.uncashCartList.count>0) {
            indexfrom =1;
        }
        if (self.unnormalCouponList.count>0) {
            indexfrom++;
        }
        if (section >= indexfrom && section<self.unccouplist.count+indexfrom ) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 250, 38)];
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(280, 0, 40, 38)];
            NSDictionary *dic = [self.unccouplist objectAtIndex:section-indexfrom];
            NSString *str = [NSString stringWithFormat:@"(%@)",[dic objectForKey:@"couponCount"]];
            lab.text = str;
            [view addSubview:lab];
            label.text = [self.unccouplisttitle objectAtIndex:section-indexfrom];
            [view addSubview:label];
        }
    }
    
    return view;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_selectIndex == 0) {
        NSDictionary *sectionDic = [_dataSourceArray safeObjectAtIndex:indexPath.section];
        //cell的位置
        //    int rowCount = [[sectionDic objectForKey:kTableViewNumberOfRowsKey] integerValue];
        
        NSArray *cellList = [sectionDic objectForKey:kTableViewCellListKey];
        NSDictionary *cellDic = [cellList safeObjectAtIndex:indexPath.row];
        
        NSString *cellType = [cellDic objectForKey:kTableViewCellTypeKey];
        id item = [cellDic objectForKey:kTableViewCellDataKey];
        
        if ([cellType isEqualToString:@"Coupon_Cell"])
        {
            NCouponItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellType];
            if (cell == nil) {
                cell = [[NCouponItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellType ischeckbuttonshow:YES];
                cell.delegate = self;
            }
            cell.ischeckbuttonshow = YES;
            NSParameterAssert([item isKindOfClass:[GiftCouponDTO class]]);
            [cell resetframe];
            cell.item = item;
            cell.checkButton.hidden = NO;
            return cell;
        }
        else if ([cellType isEqualToString:@"ValidateCode_Cell"])
        {
            NCouponValidateCodeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellType];
            if (cell == nil)
            {
                cell = [[NCouponValidateCodeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellType];
                [cell.getCodeButton addTarget:self action:@selector(getCode) forControlEvents:UIControlEventTouchUpInside];
                _getCodeButton = cell.getCodeButton;
                _codeTextField = cell.codeTextField;
                _codeTextField.text = self.captcha;
            }
            
            cell.phoneNum = [UserCenter defaultCenter].userInfoDTO.phoneNo;
            
            return cell;
        }
        else if ([cellType isEqualToString:@"NoCoupon_Cell"])
        {
            SNUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellType];
            if (cell == nil)
            {
                cell = [[SNUITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellType];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.accessoryType = UITableViewCellAccessoryNone;
                UILabel *label = [[UILabel alloc] init];
                label.frame = CGRectMake(0, 0, 300, 44);
                label.backgroundColor = [UIColor clearColor];
                label.textAlignment = NSTextAlignmentCenter;
                label.font = [UIFont boldSystemFontOfSize:14.0f];
                label.textColor = [UIColor redColor];
                label.text = L(@"PFNoOrderCanUseCoupon");
                label.tag = 1001;
                [cell.contentView addSubview:label];
            }
            UILabel *label = (UILabel *)[cell viewWithTag:1001];
            label.text =  L(@"PFNoOrderCanUseCoupon");
            return cell;
            
        }
        else if ([cellType isEqualToString:@"AddCoupon_Cell"])
        {
            SNUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellType];
            if (cell == nil)
            {
                cell = [[SNUITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellType];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                UILabel *label = [[UILabel alloc] init];
                label.frame = CGRectMake(18, 0, 200, 44);
                label.backgroundColor = [UIColor clearColor];
                label.textAlignment = NSTextAlignmentLeft;
                label.font = [UIFont boldSystemFontOfSize:15.0f];
                label.textColor = [UIColor light_Black_Color];
                label.text = [NSString stringWithFormat:@"+ %@",L(@"PFAddCoupon")];
                [cell.contentView addSubview:label];
            }
            return cell;
        }
        else if ([cellType isEqualToString:@"RecommendCode_Cell"])
        {
            NCouponRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:cellType];
            if (cell == nil)
            {
                cell = [[NCouponRecommendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellType];
                _recommendPhoneField = cell.textField;
                _recommendPhoneField.delegate = self;
                [_recommendPhoneField addTarget:self action:@selector(recommendTextDidChange:) forControlEvents:UIControlEventEditingChanged];
                [cell.scanButton addTarget:self action:@selector(scanBarCode) forControlEvents:UIControlEventTouchUpInside];
            }
            return cell;
        }
        else if ([cellType isEqualToString:@"Alliance_Cell"])
        {
            NCouponFinalCell *cell = [tableView dequeueReusableCellWithIdentifier:cellType];
            if (cell == nil)
            {
                cell = [[NCouponFinalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellType];
            }
            [cell setBalance:self.allianceDiscount name:self.allianceName];
            return cell;
        }
        
    }
    
    else{
        NSDictionary *sectionDic = [_dataSourceUnable safeObjectAtIndex:indexPath.section];
        NSArray *cellList = [sectionDic objectForKey:kTableViewCellListKey];
        NSDictionary *cellDic = [cellList safeObjectAtIndex:indexPath.row];
        
        NSString *cellType = [cellDic objectForKey:kTableViewCellTypeKey];
        id item = [cellDic objectForKey:kTableViewCellDataKey];
        
        if ([cellType isEqualToString:@"NoCoupon_Cell"])
        {
            SNUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellType];
            if (cell == nil)
            {
                cell = [[SNUITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellType];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.accessoryType = UITableViewCellAccessoryNone;
                UILabel *label = [[UILabel alloc] init];
                label.frame = CGRectMake(0, 0, 300, 44);
                label.backgroundColor = [UIColor clearColor];
                label.textAlignment = NSTextAlignmentCenter;
                label.font = [UIFont boldSystemFontOfSize:14.0f];
                label.textColor = [UIColor redColor];
                label.text = L(@"PFYourAccountHasNoUnavailableTickets");
                label.tag = 1001;
                [cell.contentView addSubview:label];
            }
            UILabel *label = (UILabel *)[cell viewWithTag:1001];
            label.text =  L(@"PFYourAccountHasNoUnavailableTickets");
            return cell;
        }
        
        NCouponItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellType];
        if (cell == nil) {
            cell = [[NCouponItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellType ischeckbuttonshow:NO];
            cell.delegate = self;
        }
        cell.ischeckbuttonshow = NO;
        [cell resetframe];
        cell.checkButton.hidden = YES;
//        NSParameterAssert([item isKindOfClass:[GiftCouponDTO class]]);
        
        cell.item = item;
        return cell;
        
    }
    
    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_selectIndex == 0) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        NSDictionary *sectionDic = [_dataSourceArray safeObjectAtIndex:indexPath.section];
        
        NSArray *cellList = [sectionDic objectForKey:kTableViewCellListKey];
        NSDictionary *cellDic = [cellList safeObjectAtIndex:indexPath.row];
        
        NSString *cellType = [cellDic objectForKey:kTableViewCellTypeKey];
        if ([cellType isEqualToString:@"AddCoupon_Cell"])
        {
            [self addCoupon];
        }
        
    }
}

-(UIButton *)headerviewbtn{
    if (!_headerviewbtn) {
        _headerviewbtn = [[UIButton  alloc] initWithFrame:CGRectMake(0, 0, 320, 38)];
        _headerviewbtn.backgroundColor = [UIColor whiteColor];
        //        [_headerviewbtn setTitle:@"礼品卡" forState:UIControlStateNormal];
        UILabel *label = [[UILabel   alloc] initWithFrame:CGRectMake(8, 5, 60, 30)];
        label.text = L(@"PFGiftCards");
        [_headerviewbtn addSubview:label];
        arrowbtn = [[UIImageView   alloc] initWithFrame:CGRectMake(280, 18, 11, 6)];
        arrowbtn.image = [UIImage imageNamed:@"arrow_bottom_gray.png"];
        
        [_headerviewbtn addTarget:self action:@selector(showhiden) forControlEvents:UIControlEventTouchUpInside];
        [_headerviewbtn addSubview:arrowbtn];
        istableshow = NO;
    }
    return _headerviewbtn;
}

-(void)showhiden{
    if (!istableshow) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [_dataSourceArray replaceObjectAtIndex:0 withObject:dic];
        
    }
    else{
        [_dataSourceArray replaceObjectAtIndex:0 withObject:_cashdic];
        //        [dic ];
        //        [_dataSourceArray insertObject:_cashdic atIndex:0];
    }
    [UIView beginAnimations:Nil context:nil];
    [UIView setAnimationDuration:0.3];
    arrowbtn.transform=CGAffineTransformMakeRotation(!istableshow?-M_PI:0);
    [self.tpTableView reloadData];
    
    [UIView commitAnimations];
    //    NSIndexPath *indexPath =  [NSIndexPath indexPathForRow:0 inSection:0];
    
    istableshow=!istableshow;
}

#pragma mark ----------------------------- text field delegate(联盟手机号)

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}

- (void)recommendTextDidChange:(id)sender
{
    if (_recommendPhoneField.text.trim.length == 11)
    {
        [self recommendAction];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == _recommendPhoneField)
    {
        if (_recommendPhoneField.text.trim.length < 11)
        {
            [self recommendAction];
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _recommendPhoneField)
    {
        if (_recommendPhoneField.text.trim.length == 11)
        {
            [self recommendAction];
        }
    }
    [textField resignFirstResponder];
    return YES;
}

- (void)recommendAction
{
    NSString *recommendNumStr = [_recommendPhoneField.text trim];
    
    if (![GiftCouponService validateRegisterId:recommendNumStr] && !IsStrEmpty(recommendNumStr)) {
        [self presentSheet:L(@"PFTelePhoneNumberWrong") posY:50];
        return;
    }
    else if(IsStrEmpty(recommendNumStr))
    {
        [self presentSheet:L(@"PFRecommendedNumberCannotBeEmpty") posY:50];
        return;
    }
    [self login];
    [_recommendPhoneField resignFirstResponder];
    [self scrollToBottom];
    [self displayOverFlowActivityView];
    
    self.giftCouponService.context = recommendNumStr;
    [self.giftCouponService beginActiveGiftCouponRequest:@"" cardPwd:@"" phoneNo:recommendNumStr];
}

- (void)activeRecommendNumCompletionWithResult:(BOOL)isSuccess
                                  allianceName:(NSString *)allianceName
                              allianceDiscount:(NSString *)allianceDiscount
                                      errorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];
    _recommendPhoneField.text=@"";
    if (isSuccess) {
        
        self.allianceTel = self.giftCouponService.context;
        self.allianceName = allianceName;
        self.allianceDiscount = allianceDiscount;
        if(self.allianceDiscount!=0){
            [self presentSheet:L(@"PFOneOrderOnlyUseOneRecommendedNumber") posY:50];
        }
        
        [self presentSheet:[NSString stringWithFormat:@"%@,%@：%@",L(@"PFAddSuccess"),L(@"PFStraightDownAmount"),allianceDiscount] posY:50];

        [self reloadTableView];
        [self scrollToBottom];
    }
    else
    {
        if (IsStrEmpty(errorMsg)) {
            [self presentSheet:L(@"PFAddFailed")];
        }else{
            [self presentSheet:errorMsg];
        }
    }
    
    self.giftCouponService.context = nil;
    
}

- (BOOL)hasAlliance
{
    //是否使用了联盟推荐号
    if (self.allianceDiscount.doubleValue > 0)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

#pragma mark ----------------------------- actions

//获取校验码
- (void)getCode
{
    [self login];
    [self displayOverFlowActivityView];
    _getCodeButton.enabled = NO;
    
    [_codeTextField resignFirstResponder];
    [_recommendPhoneField resignFirstResponder];
    [self.checkCodeService beginGetCheckCode:[UserCenter defaultCenter].userInfoDTO.phoneNo checkCodeState:eUserCashCardBind];
}

//添加优惠券
- (void)addCoupon
{
    AddCouponViewController *vc = [[AddCouponViewController alloc] init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

//扫描条形码
- (void)scanBarCode
{
    SNReaderViewController *readerViewController = [[SNReaderViewController alloc] init];
    readerViewController.snDelegate = self;
    readerViewController.isServicePay = YES;
    [self presentModalViewController:readerViewController animated:YES];
}

-(NSString *)comfirmwithcstore{
    if (self.selectcouponarray.count == 0) {
        return nil;
    }
    if(!self.isAllCOrder){
        return nil;
    }
    NSString *returstr;
    GiftCouponDTO *dto = [self.selectcouponarray objectAtIndex:0];
    //如果不是c店
    if (dto.vendorCode == nil) {
        for (GiftCouponDTO *dto1 in self.selectcouponarray) {
            if (dto1.vendorCode!= nil) {
                returstr=[NSString stringWithFormat:@"%@%@%@",L(@"PFThisTicketCannot"),dto.name,L(@"PFUseTogether")];
                return returstr;
            }
        }
    }
    //如果是c店
    else{
        for (GiftCouponDTO *dto1 in self.selectcouponarray) {
            if (dto1.vendorCode == nil) {
                returstr=[NSString stringWithFormat:@"%@%@%@",L(@"PFThisTicketCannot"),dto.name,L(@"PFUseTogether")];
                return returstr;
            }
        }

    }
    return nil;
}

- (void)confirm:(id)sender
{
    //检查是否选择了礼品卡
    NSMutableArray *lipingKaList = [NSMutableArray array];
    
    for (GiftCouponDTO *dto in self.cashCartList)
    {
        if (dto.isSelected) {
            [lipingKaList addObject:dto];
        }
    }
    
    if ([lipingKaList count] > 0)
    {
        //检验验证码
        NSString *codeStr = _codeTextField.text.trim;
        if (!codeStr.length)
        {
            [self presentSheet:L(@"PFPleaseEnterCorrectVerificationCode") posY:50];
            if (istableshow) {
                [self showhiden];
            }
            [_codeTextField becomeFirstResponder];
            return;
        }
        
        if (![GiftCouponService validateString:codeStr])
        {
            [self presentSheet:L(@"PFPleaseInputCorrectVerificationCode") posY:50];
            if (istableshow) {
                [self showhiden];
            }
            [_codeTextField becomeFirstResponder];
            return;
        }
        
        self.captcha = codeStr;
    }
    
    //c店
    NSString *cannotcomp = [self comfirmwithcstore];
    if (cannotcomp) {
        [self presentSheet:cannotcomp posY:50];
        return;
    }
    
    NSMutableArray *selectArray = [NSMutableArray array];
    if ([lipingKaList count]) [selectArray addObjectsFromArray:lipingKaList];
    //添加已选的普通券
    for (GiftCouponDTO *dto in self.normalCouponList)
    {
        if (dto.isSelected || dto.couponType == CouponTypeVoucherCode) //直降code默认绑定
        {
            [selectArray addObject:dto];
        }
    }
    
    //c店
    for (NSDictionary *dto in self.ccouplist) {
        [self.ccouplisttitle addObject:[dto objectForKey:@"vendorName"]];
        NSArray *array1 = [dto objectForKey:@"couponlist"];
        for (GiftCouponDTO *dto1 in array1){
            if (dto1.isSelected) //直降code默认绑定
            {
                [selectArray addObject:dto1];
            }
        }
    }
    
    if ([selectArray count])
    {
        self.selectCouponList = selectArray;
    }
    else
    {
        self.selectCouponList = nil;
    }
    
    [self displayOverFlowActivityView];
    [self.payFlowService beginSaveCardAndCouponRequest:@"0" ecoupon:self.selectCouponList codeString:self.captcha];
    
}
- (void)saveCardAndCouponCompletionWithResult:(BOOL)isSuccess errorMsg:(NSString *)errorMsg payDTO:(payFlowDTO *)dto
{
    [self removeOverFlowActivityView];
    if (isSuccess) {
        //商品总额
        double price = [self.payFlowService.productAllPrice doubleValue];
        self.totalPriceStr = [NSString stringWithFormat:@"￥%0.2f",price];
        //实付金额
        double shouldPay = [self.payFlowService.userPayAllPrice doubleValue];
        self.shouldPayPrice = [NSString stringWithFormat:@"￥%0.2f",shouldPay];
        //优惠金额
        double discount = [self.payFlowService.totalDiscount doubleValue];
        if (discount<0) {
            discount=-discount;
        }
        self.totalDiscount = [NSString stringWithFormat:@"￥%0.2f",discount];
        //运费
        double shipPrice = [self.payFlowService.totalShipPrice doubleValue];
        self.totalFareStr = [NSString stringWithFormat:@"￥%0.2f",shipPrice];
        //回调
        if ([_delegate respondsToSelector:@selector(chooseCouponDidOk:)])
        {
            [_delegate chooseCouponDidOk:self];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        self.selectCouponList = nil;
        [self presentSheet:errorMsg];
    }
}

#pragma mark ----------------------------- bar code reader call back

- (void)readerView:(ZBarReaderView *)view
    didReadSymbols:(ZBarSymbolSet *)symbols
         fromImage:(UIImage *)image
{
    ZBarSymbol *symbol = nil;
    
    for (symbol in symbols)
    {
        break;
    }
    
    NSString *zbarString = symbol.data;
    
    [self dismissModalViewControllerAnimated: YES];
    _recommendPhoneField.text = zbarString;
    [self recommendAction];
}

- (void)manualInput
{
    if (IOS5_OR_LATER)
    {
        [self dismissViewControllerAnimated:YES completion:^{
            
            [_recommendPhoneField becomeFirstResponder];
        }];
    }
    else
    {
        [self dismissModalViewControllerAnimated:NO];
        
        [_recommendPhoneField becomeFirstResponder];
    }
}

#pragma mark ----------------------------- add coupon delegate

- (void)addCouponDidOk:(AddCouponViewController *)vc
{
    //刷新券列表
    _dataSourceUnable = nil;
    [self sendCouponListRequest];
    
}

#pragma mark ----------------------------- coupon cell delegate

- (BOOL)couponCell:(NCouponItemCell *)cell shouldChangeCouponSelectState:(GiftCouponDTO *)couponDTO
{
    [self login];
    if ([couponDTO.exclusive isEqualToString:@"1"]) //互斥券将
    {
        if (!couponDTO.isSelected) //从未选中变为选中
        {
            //将已经选中互斥券的设置为未勾选
            for (GiftCouponDTO *dto in self.cashCartList)
            {
                if ([dto.exclusive isEqualToString:@"1"] && dto.isSelected && ![dto.couponTmpId isEqualToString:couponDTO.couponTmpId])
                {
                    dto.isSelected = NO;
                }
            }
            
            for (GiftCouponDTO *dto in self.normalCouponList)
            {
                if ([dto.exclusive isEqualToString:@"1"] && dto.isSelected && ![dto.couponTmpId isEqualToString:couponDTO.couponTmpId])
                {
                    int iscoupgift = 0;
                    for (NSDictionary *dto1 in self.ccouplist) {
                        NSArray *array1 = [dto1 objectForKey:@"couponlist"];
                        for (GiftCouponDTO *dtocstore in array1){
                            if([dtocstore.giftCouponId isEqualToString:couponDTO.giftCouponId]){
                                iscoupgift ++;
                            }
                        }
                    }
                    if (iscoupgift==0) {
                        dto.isSelected = NO;
                    }
                }
            }
            for (NSDictionary *dto in self.ccouplist) {
                NSArray *array1 = [dto objectForKey:@"couponlist"];
                for (GiftCouponDTO *dto1 in array1){
                    if ([couponDTO.vendorCode isEqualToString:dto1.vendorCode]) {
                        if ([dto1.exclusive isEqualToString:@"1"] && dto1.isSelected)
                        {
                            dto1.isSelected = NO;
                            int indext = 0;
                            for(GiftCouponDTO * giftdto in self.selectcouponarray){
                                if ([giftdto.giftCouponId isEqualToString:dto1.giftCouponId]) {
                                    [self.selectcouponarray removeObjectAtIndex:indext];
                                    break;
                                }
                                indext++;

                            }
                            
                        }
                    }
                   
                }
            }
        }
        
    }

    int indext = 0;
    BOOL ishavedto=NO;
    for(GiftCouponDTO * giftdto in self.selectcouponarray){
        if ([giftdto.giftCouponId isEqualToString:couponDTO.giftCouponId]) {
            if (giftdto.isSelected) {
                [self.selectcouponarray removeObjectAtIndex:indext];
                ishavedto=YES;
                break;
            }
            else{
                ishavedto=NO;
            }
        }
        indext++;
    }
    if (!ishavedto) {
        [self.selectcouponarray addObject:couponDTO];
    }
    [self qtandcstore:couponDTO];

        return YES;
}

//pt通用券跟c店互斥
-(void)qtandcstore:(GiftCouponDTO *)couponDTO{
    //平台通用券跟c店互斥
    //如果点的c店券，则将平台券取消且提示
    if (couponDTO.vendorCode!=nil) {
        int indext=0;
        NSMutableString *altertext = [[NSMutableString alloc] initWithString:L(@"PFYouSelectTicketCannot")];
        for (GiftCouponDTO *dto in self.cashCartList)
        {
            if (dto.isSelected&&dto.ispt)
            {
                dto.isSelected = NO;
                int indext1 = 0;
                for(GiftCouponDTO * giftdto in self.selectcouponarray){
                    if (giftdto.giftCouponId == dto.giftCouponId) {
                        [self.selectcouponarray removeObjectAtIndex:indext1];
                        break;
                    }
                    indext1++;
                }

                [altertext appendString:dto.name];
                if (indext!=self.cashCartList.count-1) {
                    [altertext appendString:@","];

                }
                indext++;
            }
        }
        for (GiftCouponDTO *dto in self.normalCouponList)
        {
            if (dto.isSelected&&dto.ispt)
            {
                dto.isSelected = NO;
                int indext1 = 0;
                for(GiftCouponDTO * giftdto in self.selectcouponarray){
                    if ([giftdto.giftCouponId isEqualToString:dto.giftCouponId]  ) {
                        [self.selectcouponarray removeObjectAtIndex:indext1];
                        break;
                    }
                    indext1++;
                }
                [altertext appendString:dto.name];
                if (indext!=self.cashCartList.count-1) {
                    [altertext appendString:@","];
                }
                indext++;
            }
        }
        if (indext>0) {
            [altertext appendString:L(@"PFUseTogether")];
            [self presentSheet:altertext];

        }
    }
    //如果点的是平台通用券
    else{
        if (couponDTO.ispt) {
            int alertindex = 0;
            NSMutableString *altertext = [[NSMutableString alloc] initWithString:L(@"PFYouSelectTicketCannot")];
            for (NSDictionary *dto in self.ccouplist) {
                NSArray *array1 = [dto objectForKey:@"couponlist"];
                for (GiftCouponDTO *mydto in array1){
                    if (mydto.isSelected)
                    {
                        mydto.isSelected = NO;
                        [altertext appendString:mydto.name];
                        int indext = 0;
                        for(GiftCouponDTO * giftdto in self.selectcouponarray){
                            if ([giftdto.giftCouponId isEqualToString:mydto.giftCouponId]) {
                                [self.selectcouponarray removeObjectAtIndex:indext];
                                break;
                            }
                            indext++;
                        }
                        alertindex++;
                    }
                }
            }
            if (alertindex>0) {
                [altertext appendString:L(@"PFUseTogether")];
                [self presentSheet:altertext];
            }
        }
    }

}

- (void)couponCell:(NCouponItemCell *)cell didChangeCouponSelectState:(GiftCouponDTO *)couponDTO
{
    [self login];
    //刷新页面
    
    [self reloadTableView];
    [self.tpTableView reloadData];
    
}

#pragma mark ----------------------------- getGiftCoupon

- (GiftCouponService *)giftCouponService
{
    if (!_giftCouponService) {
        _giftCouponService = [[GiftCouponService alloc ] init];
        _giftCouponService.delegate = self;
    }
    return _giftCouponService;
}

-(void)sendunuseCouponLisetRequest{
    [self displayOverFlowActivityView];
    [self.giftCouponService beginGetGiftCouponListRequest:self.isCOrder unUsable:YES];
}

- (void)sendCouponListRequest
{
    [self displayOverFlowActivityView];
    
    //如果有券列表了，先计算下已选中的
    if ([self.cashCartList count] || [self.normalCouponList count] || [self.ccouplist count])
    {
        NSMutableArray *list = [NSMutableArray array];
        for (GiftCouponDTO *dto in self.cashCartList)
        {
            if (dto.isSelected) {
                [list addObject:dto];
            }
        }
        for (GiftCouponDTO *dto in self.normalCouponList)
        {
            if (dto.isSelected) {
                [list addObject:dto];
            }
        }
        for (NSDictionary *dto in self.ccouplist) {
            NSArray *array1 = [dto objectForKey:@"couponlist"];
            for (GiftCouponDTO *dto1 in array1){
                if (dto1.isSelected) {
                    [list addObject:dto1];
                }
            }
        }
        self.selectCouponList = list;
    }
    
    [self.giftCouponService beginGetGiftCouponListRequest:self.isCOrder unUsable:NO];
}

- (void)getGiftCouponListCompletionWithResult:(BOOL)isSuccess
                                     errorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];
    
    if (isSuccess)
    {
        self.tpTableView.hidden = NO;
        if (_selectIndex == 0) {
            _isCouponLoaded = YES;
            
            //244 纯c店商品也可使用 gjf
//            if (!self.isAllCOrder) {
                self.cashCartList = [self.giftCouponService.cashCardList copy];
//            }
            
            
            self.normalCouponList = [self.giftCouponService.normalCouponList copy];
            self.ccouplist = [self.giftCouponService.couponList copy];
            
//            if ( self.cashCartList.count > 0)
            
            [self rebuildCouponSelectState];
            
            [self reloadTableView];
        }
        else{
            
            _isUnuseCouponLoaded = YES;
            self.uncashCartList = [self.giftCouponService.cashCardList copy];
            self.unnormalCouponList = [self.giftCouponService.normalCouponList copy];
            self.unccouplist = [self.giftCouponService.couponList copy];
            
            [self prepareTableViewDatasourceUnable];
            [self.tpTableView reloadData];
        }
    }
    else
    {
        //do nothing
        
        [self presentSheet:self.giftCouponService.errorMsg];
    }
}

- (void)rebuildCouponSelectState
{
    if (self.selectCouponList.count)
    {
        //建立索引
        NSMutableDictionary *selectCouponDic = [NSMutableDictionary dictionary];
        for (GiftCouponDTO *dto in self.selectCouponList)
        {
            if (dto.giftCouponId.length)
            {
                [selectCouponDic setObject:dto forKey:dto.giftCouponId];
            }
        }
        
        //遍历设置
        for (GiftCouponDTO *dto in self.cashCartList)
        {
            id sameItem = [selectCouponDic objectForKey:dto.giftCouponId];
            if (sameItem) {
                dto.isSelected = YES;
            }else{
                dto.isSelected = NO;
            }
        }
        
        for (GiftCouponDTO *dto in self.normalCouponList)
        {
            id sameItem = [selectCouponDic objectForKey:dto.giftCouponId];
            if (sameItem) {
                
                dto.isSelected = YES;
            }else{
                dto.isSelected = NO;
            }
        }
        for (NSDictionary *dto in self.ccouplist) {
            NSArray *array1 = [dto objectForKey:@"couponlist"];
            for (GiftCouponDTO *dto1 in array1){
                id sameItem = [selectCouponDic objectForKey:dto1.giftCouponId];
                if (sameItem) {
                    dto1.isSelected = YES;
                }else{
                    dto1.isSelected = NO;
                }
            }
        }

    }
}

#pragma mark ----------------------------- 获取验证码

- (CheckCodeService *)checkCodeService
{
    if (!_checkCodeService) {
        _checkCodeService = [[CheckCodeService alloc] init];
        _checkCodeService.delegate = self;
        _checkCodeService.limitTime = 120.0f;
        _checkCodeService.userCal = YES;
    }
    return _checkCodeService;
}

- (void)didGetCheckCodeComplete:(BOOL)isSuccess errorDesc:(NSString *)errorDesc
{
    [self removeOverFlowActivityView];
    
    if (isSuccess)
    {
        [_codeTextField becomeFirstResponder];
    }
    else
    {
        _getCodeButton.enabled = YES;
        [self presentSheet:errorDesc.length?errorDesc:L(@"PFGetVerificationCodeFailedAndGetAgain")];
    }
}


//剩余时间重试,在userCal为yes时执行
- (void)eppGetCodeRemainTimeToRetry:(NSInteger)seconds checkCodeState:(CheckCodeState)status
{
    if (status == eUserCashCardBind)
    {
        if(seconds <= 0)
        {
            _getCodeButton.enabled = YES;
            [_getCodeButton setTitle:L(@"BTObtain")
                            forState:UIControlStateNormal];
        }
        else
        {
            _getCodeButton.enabled = YES;
            NSString *title = [NSString stringWithFormat:@"%d%@",seconds,L(@"Seconds")];
            [_getCodeButton setTitle:title
                            forState:UIControlStateNormal];
            _getCodeButton.enabled = NO;
        }
    }
}


- (void)setButtonsBackground
{
    for (int i = 0; i < 2; i++)
    {
        //        int buttonIndex = i>2 ? 2 : i;
        int selectIndex = _selectIndex;
        
        if (selectIndex == 0) {
            //            if (IOS7_OR_LATER)
            //            {
            [self.button1 setTitleColor:[UIColor btnTitleHotColor] forState:UIControlStateNormal];
            [self.button2 setTitleColor:[UIColor btnTitleNormalColor] forState:UIControlStateNormal];
            
            [UIView animateWithDuration:0.3 animations:^{
                self.lineView.frame = CGRectMake(0, 38.5, self.button1.frame.size.width, 1.5);
            }];
            
        }else if (selectIndex == 1){
            //            if (IOS7_OR_LATER)
            //            {
            [self.button2 setTitleColor:[UIColor btnTitleHotColor] forState:UIControlStateNormal];
            [self.button1 setTitleColor:[UIColor btnTitleNormalColor] forState:UIControlStateNormal];
            
            
            [UIView animateWithDuration:0.3 animations:^{
                self.lineView.frame = CGRectMake(self.button2.origin.x, 38.5, self.button2.frame.size.width, 1.5);
            }];
        }
    }
}

- (UIImageView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 38.5, 106, 1.5)];
        _lineView.backgroundColor = RGBCOLOR(252, 124, 38);
        [self.view addSubview:_lineView];
    }
    return _lineView;
}

@end
