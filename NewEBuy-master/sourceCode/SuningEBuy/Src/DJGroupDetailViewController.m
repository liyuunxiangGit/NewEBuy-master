//
//  DJGroupDetailViewController.m
//  SuningEBuy
//
//  Created by xmy on 26/12/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "DJGroupDetailViewController.h"
#import "NQiangGouThridCell.h"
#import "ShopCartV2ViewController.h"

#define FirstSectionTuanGou    1
#define SecondSectionTuanGou   2
#define ThirdSectionTuanGou    3
#define FourthSectionTuanGou   4
#define FiveSectionTuanGou     5
#define SixSectionTuanGou      6
#define SevenSectionTuanGou    7


//1：即将开始 2：已开始 3：已团完 4：已结束
#define kWillStart @"1"
#define kHaveStart @"2"
#define kNOGood @"3"
#define kHaveEnd @"4"

@interface DJGroupDetailViewController ()

@end

@implementation DJGroupDetailViewController

- (void)dealloc
{
    SERVICE_RELEASE_SAFELY(_service);
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    self.title = L(@"Group Detail");
    
    self.type = 3;
    
    [self refreshFirstProImagesView];
    
    self.addCarBtn.hidden = YES;
    
    [self refreshBtn];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)refreshBtn{
    
    self.addCarBtn.hidden = YES;
    self.CarBtn.hidden = YES;
    self.CarNumBtn.hidden = YES;
    
    [self.buyNowBtn setTitle:@"" forState:UIControlStateNormal];
    
    self.buyNowBtn.frame = CGRectMake(15, 7, 290, 35);
    
    [self.buyNowBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.buyNowBtn setBackgroundImage:[UIImage imageNamed:@"submit_button_normal.png"] forState:UIControlStateNormal];
    
    [self.buyNowBtn setBackgroundImage:[UIImage imageNamed:@"button_white_disable.png"] forState:UIControlStateDisabled];
    
    [self.bottomNavBar addSubview:self.buyNowBtn];
    
    if ([self.detailDto.startFlag isEqualToString:kWillStart]) {
        
        self.stateStr = L(@"Product_LeftToBegin");
        self.buyNowBtn.enabled = NO;
        
    } else if ([self.detailDto.startFlag isEqualToString:kHaveStart]) {

        self.stateStr = L(@"Add GroupBuy");
        
        self.buyNowBtn.enabled = YES;
        
    }
    else if ([self.detailDto.startFlag isEqualToString:kNOGood]) {
      
        self.stateStr = L(@"Group buy is over");
        
        self.buyNowBtn.enabled = NO;
    }
    

    if ([self isProductEnabled] == NO)
    {
        self.buyNowBtn.enabled = NO;
        
        
    }
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self refreshBtn];
    
}

////刷新城市 接收通知
//- (void)defaultCityDidChange
//{
//    if (![self.productBasicDTO.cityCode isEqualToString:[Config currentConfig].defaultCity]) {
//        self.productBasicDTO.cityCode = [Config currentConfig].defaultCity;
//        [self refreshData];
//    }
//}

- (void)refreshData
{
    [self displayOverFlowActivityView];
    
    [self.service beginSendDJListRequest:self.actId channelId:self.channelId];
    
//    [super refreshData];
    
}

- (id)initWithDto:(DJGroupListItemDTO *)dto{
    
    self = [super initWithDataBasicDTO:nil];
    
    if (self = [super init]) {
        self.title = L(@"DJ_Group_Detail");
        self.baseItemDto = dto;
        self.actId = self.baseItemDto.grpPurId;
        self.channelId = self.baseItemDto.channelID;
        
        DataProductBasic *productDTO = [[DataProductBasic alloc] init];
        productDTO.productId = self.baseItemDto.catentryId;
        productDTO.productCode = self.baseItemDto.partnumber;
#warning 默认苏宁自营,后期优化
        productDTO.shopCode = @"";
        self.productBase = productDTO;
        
        [self.tableView reloadData];
    }
    return self;
}


- (DJGroupDetailService *)service
{
    if (!_service) {
        _service = [[DJGroupDetailService alloc] init];
        _service.delegate = self;
    }
    return _service;
}


- (void)requestProductDetailData
{
    self.navigationItem.rightBarButtonItem.enabled = NO;
    [self.proDetailService beginGetProductDetailInfo:self.productBase];
}

//我要团按钮事件
-(void)beginEasyBuy{
    
    [self joinGroup];
}

- (void)joinGroup
{
    loginSel = @selector(beginEasyBuy);
    
    if (![self checkLogin]){
        
        return;
    }
    
    if ([self.productBase.hasStorage isEqualToString:@"N"]){
        [self presentSheet:L(@"Product_ProductNotEnough")];
        self.buyNowBtn.enabled = NO;
        return;
    }else if ([self.productBase.hasStorage isEqualToString:@"Z"]){
        [self presentSheet:L(@"DJGroup_NotOnSale")];
        self.buyNowBtn.enabled = NO;
        return;
    }
    

    if (self.productBase.cityCode.length == 0)
    {
        self.productBase.cityCode = [[Config currentConfig] defaultCity];
    }
    
    self.productBase.danjiaGroupId = self.detailDto.grpPurId;
    self.productBase.qianggouPrice = [NSNumber numberWithDouble:[self.detailDto.displayPrice doubleValue]];
    
    NSString *errorMsg = nil;
    
    BOOL canAddToShopCart = [self.shoppingCartBoard checkProductCanAddToShopCart:self.productBase
                                                                        errorMsg:&errorMsg];
    if (canAddToShopCart)
    {
        if ([UserCenter defaultCenter].efubaoStatus == eLoginByPhoneUnBound) {
            [self presentCustomDlg:L(@"Product_BindMobilePhoneAndBuy")];
            return;
        }
        
        [self displayOverFlowActivityView];
        DJGroupApplyDTO *applyDto = [[DJGroupApplyDTO alloc] init];
        applyDto.storeId = @"10052";
        applyDto.catalogId = @"10051";
        applyDto.groupId = self.detailDto.grpPurId;
        applyDto.catentryId = self.detailDto.catentryId;
        applyDto.amount = @"1";
        
        [self.groupApplyService beginSendDJGroupApplyRequest:applyDto];
    }
    else
    {
        [self presentCustomDlg:errorMsg];
    }
    
}

#pragma mark - 基本信息

#pragma mark - 数据请求回调
//点击我要团按钮后返回的数据
- (void)didSendDJGroupApplyRequestComplete:(DJGroupApplyService *)service  Result:(BOOL)isSuccess
{
    [self removeOverFlowActivityView];
    
    if(isSuccess)
    {
        NSString *flag = service.result;
        
        if([flag isEqualToString:@"1"])
        {
            self.productBase.qianggouPrice = [NSNumber numberWithDouble:[self.detailDto.displayPrice doubleValue]];
            [self addtoShoppingCart];
            
        }else {
            if([flag isEqualToString:@"2"]){
                [self presentSheet:L(@"Product_NotLogin")];
            }else if([flag isEqualToString:@"3"]){
                [self presentSheet:L(@"Product_BindMobilePhoneAndBuy")];
            }else if([flag isEqualToString:@"4"]){
                [self presentSheet:L(@"Product_NotFoundActivity")];
            }else if([flag isEqualToString:@"5"]){
                [self presentSheet:L(@"Product_GroupNotEffective")];
            }else if([flag isEqualToString:@"6"]){
                [self presentSheet:L(@"Product_BeyondTheLimit")];
            }else if([flag isEqualToString:@"7"]){
                [self presentSheet:L(@"Product_GroupNumNotEnough")];
            }else {
                [self presentSheet:L(@"Product_GroupFailed")];
            }
        }
    }else {
        
        [self presentSheet:L(@"Product_GroupFailed")];
        
    }
    
    [self.tableView reloadData];
    
}

- (void)addtoShoppingCart
{
    if (nil == self.productBase || [self.productBase.hasStorage isEqualToString:@"N"])
    {
        return;
    }
    if (self.productBase.cityCode.length == 0)
    {
        self.productBase.cityCode = [[Config currentConfig] defaultCity];
    }
    
    SNOperationCallBackBlock block = ^(BOOL isSuccess, NSString *errorMsg){
        if (isSuccess) {
            BBAlertView *alert = [[BBAlertView alloc] initWithStyle:BBAlertViewStyleDefault
                                                              Title:L(@"system-info")
                                                            message:L(@"Product_AlreadyAddedToShopCart")
                                                         customView:nil
                                                           delegate:nil
                                                  cancelButtonTitle:L(@"Confirm")
                                                  otherButtonTitles:L(@"Product_GoToShopCart")];
            [alert show];
            [alert setConfirmBlock:^{
                
                [[AppDelegate currentAppDelegate].tabBarViewController setSelectedIndex:3];
                [(UINavigationController*)[[AppDelegate currentAppDelegate].tabBarViewController.viewControllers objectAtIndex:3] popToRootViewControllerAnimated:NO];
            }];
            [alert setCancelBlock:^{
                
            }];
            
            [self refreshData];
            
        }else{
            [self presentCustomDlg:errorMsg];
        }
    };
    
    if (self.productBase.danjiaGroupId.length == 0)
    {
        self.productBase.danjiaGroupId = self.detailDto.grpPurId;
    }
    
    if (self.productBase.danjiaGroupId.length)
    {
        [self.shoppingCartBoard addProductToShoppingCart:self.productBase
                                         completionBlock:block];
    }
    
    [self.tableView reloadData];
    
}


- (void)didSendDJDetailRequestComplete:(DJGroupDetailService *)service Result:(BOOL)isSuccess
{
    if (isSuccess) {
        if (!IsNilOrNull(service)) {
            self.service = service;
            if (self.service.detailDto) {
                self.detailDto = self.service.detailDto;
                //开启计时器
                [self.calculagraph start];
                
                self.lastTabView.detailDto = self.detailDto;
            }
            
        }else{
            [self removeOverFlowActivityView];
            [self presentSheet:L(@"Product_GroupNotEffective")];
        }
    }else{
        [self removeOverFlowActivityView];
        [self presentSheet:L(@"ASI_CONNECTION_FAILURE_ERROR")];
    }
    
    [self requestProductDetailData];
    
    [self.tableView reloadData];
    
}

/*
 - (void)getProductDetailCompletionWithResult:(BOOL)isSuccess errorMsg:(NSString *)errorMsg productDetail:(DataProductBasic *)product
 {
 
 [self removeOverFlowActivityView];
 if (isSuccess) {
 
 if (IsStrEmpty(product.productName)) {
 product.productName = self.productBase.productName;
 }
 self.productBase = product;
 
 self.appraisalVC.productBasic = self.productBase;
 [self.appraisalVC sendHttpRequest];
 
 [self refreshBtn];
 [super reloadTableViewData];
 }
 else{
 
 BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"system-info")
 message:errorMsg
 delegate:nil
 cancelButtonTitle:L(@"Ok")
 otherButtonTitles:nil];
 if (!self.proDetailService.isRequestError) {
 [alert setCancelBlock:^{
 [self.navigationController popViewControllerAnimated:YES];
 }];
 }
 [alert show];
 }
 
 [self.tableView reloadData];
 
 
 }
 */

#pragma mark -
#pragma mark tableView deleagte

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == ThirdSectionTuanGou)
    {
        return 0;
    }
    else if(indexPath.section == SevenSectionTuanGou)
    {
        return 0;
    }
    else
    {
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == ThirdSectionTuanGou) {
        
        static NSString *productImageCellIdentifier = @"TuanGou_NQiangGouThridCell";
        
        NQiangGouThridCell *cell = (NQiangGouThridCell *)[tableView dequeueReusableCellWithIdentifier:productImageCellIdentifier];
        
        if (nil == cell)
        {
            cell = [[NQiangGouThridCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:productImageCellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.contentView.backgroundColor = RGBCOLOR(242, 242, 242);
            
        }
        
        self.productBase.tuangouPrice = [NSNumber numberWithDouble:[self.detailDto.displayPrice doubleValue]];
        
        [cell setNTuanGouThridCellInfo:self.detailDto WithDetail:self.productBase];
        
        if(!self.isLoadDetail)
        {
            cell.sellPointLab.text = @"";
        }
        
        cell.downPrice.text = [NSString stringWithFormat:@"%@: ",L(@"DJGroup_GroupBuyPrice")];
                
        cell.saveLbl.text =
        [NSString stringWithFormat:@"%@：¥ %.2f                         %@%@%@",L(@"DJGroup_SaveMoney"),[self.detailDto.adjustAmount doubleValue]?[self.detailDto.adjustAmount doubleValue]:0,L(@"DJGroup_AlreadyGroupBuy"), self.detailDto.totalQty?self.detailDto.totalQty:@"",L(@"Purchase_Jian")];
        
        return cell;
    }
    else if(indexPath.section == FourthSectionTuanGou)
    {
        static NSString *cellIdetifier = @"NProDetailFourthCell_3";
        
        NProDetailFourthCell *cell = (NProDetailFourthCell*)[tableView dequeueReusableCellWithIdentifier:cellIdetifier];
        
        if(cell == nil)
        {
            cell = [[NProDetailFourthCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdetifier];
            cell.type = 1;//self.type;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = RGBCOLOR(242, 242, 242);
            cell.contentView.backgroundColor = RGBCOLOR(242, 242, 242);
        }
        
        if(self.isLoadDetail)
        {
            [cell setNProDetailFourCellInfo:self.productBase WithType:self.type coloStr:nil];
            
        }
        cell.deliveryFeeLbl.hidden = YES;
        //        [cell.arrowImageV addTarget:self action:@selector(selectColorOrSizeOrNum:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.clipsToBounds = YES;
        
        return cell;
    }
    else if(indexPath.section == SevenSectionTuanGou)
    {
        return [[UITableViewCell alloc] init];
    }
    
    return  [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == FiveSectionTuanGou)
    {
        
        self.lastTabView.appariseNumStr = self.appariseNumStr;
        self.lastTabView.selectTye = indexPath.row;
        self.lastTabView.type = 3;
        self.lastTabView.groupBuyCalculagraph = self.calculagraph;
        [self.navigationController pushViewController:self.lastTabView animated:YES];
        
    }
}

#pragma mark - 计时器

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"time"]) {
        
        if ([self.detailDto.startFlag isEqualToString:kNOGood] || [self.detailDto.startFlag isEqualToString:kHaveEnd]) {
            [self setTime:0];
            return;
        }
        
        NSTimeInterval leavingTime = 0;
        
        if ([self.detailDto.startFlag isEqualToString:kWillStart]) {
            leavingTime = self.detailDto.startTimeSeconds - self.calculagraph.seconds;
            [self setTime:leavingTime];

        } else if ([self.detailDto.startFlag isEqualToString:kHaveStart]){
            leavingTime = self.detailDto.endTimeSeconds - self.calculagraph.seconds;
            [self setTime:leavingTime];

        }else if ([self.detailDto.startFlag isEqualToString:kNOGood]){
            leavingTime = self.detailDto.endTimeSeconds - self.calculagraph.seconds;
            [self setTime:leavingTime];

        } else {
            [self setTime:0];
            
            [self setTime:leavingTime];

            return;
        }
        
        if (leavingTime < 1) {
            if ([self.detailDto.startFlag isEqualToString:kWillStart]) {
                self.detailDto.startFlag = kHaveStart;
            }else if ([self.detailDto.startFlag isEqualToString:kHaveStart]){
                self.detailDto.startFlag = kHaveEnd;
            }
            
            [self setTime:leavingTime];

            return;
        }
        
        [self setTime:leavingTime];
    }
}

- (void)setTime:(NSTimeInterval)seconds
{
    if ([self.detailDto.startFlag isEqualToString:@"3"] || [self.detailDto.startFlag isEqualToString:@"4"] || (seconds == 0)){
        [self.buyNowBtn setTitle:L(@"Group buy is over") forState:UIControlStateNormal];
        self.buyNowBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        self.buyNowBtn.enabled = NO;
        return;
    }
    
    NSInteger day = seconds / (3600 * 24);
    NSInteger hour = (seconds - day * 3600 * 24) / 3600;
    NSInteger minute = (seconds - day * 3600 * 24 - hour * 3600) / 60;
    NSInteger second = (seconds - day * 3600 * 24 - hour * 3600 - minute * 60);
    
    NSString *timeString = nil;
    if (day >= 100) {
        timeString = [NSString stringWithFormat:@"%03d%@%02d:%02d:%02d", day,L(@"GBDay"), hour, minute, second];
    }else{
        timeString = [NSString stringWithFormat:@"%02d%@%02d:%02d:%02d", day,L(@"GBDay"), hour, minute, second];
    }
    
    self.timeStr = timeString;
    
    NSString *stateString = nil;
    if ([self.detailDto.startFlag isEqualToString:kWillStart]) {
//        stateString = [NSString stringWithFormat:@"        距离开始      %@", timeString];
        stateString = L(@"Product_LeftToBegin");
//        [self.buyNowBtn setTitle:stateString forState:UIControlStateNormal];
        self.buyNowBtn.enabled = NO;
        self.buyNowBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
    } else if ([self.detailDto.startFlag isEqualToString:kHaveStart]) {
//        stateString = [NSString stringWithFormat:@"        我要团      %@", timeString];
        stateString = L(@"Add GroupBuy");

//        [self.buyNowBtn setTitle:stateString forState:UIControlStateNormal];
        
        self.buyNowBtn.enabled = YES;
        if (self.isLoadDetail == YES) {
            if ([self isProductEnabled] == NO)
            {
                self.buyNowBtn.enabled = NO;
                
            }
        }
        
        self.buyNowBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
    }
    else if ([self.detailDto.startFlag isEqualToString:kNOGood]) {
//        stateString = [NSString stringWithFormat:@"        团购已结束      %@", timeString];
//        [self.buyNowBtn setTitle:stateString forState:UIControlStateNormal];
        
        stateString = L(@"Group buy is over");

        self.buyNowBtn.enabled = NO;
        self.buyNowBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    
    self.stateStr = stateString;
}



@end
