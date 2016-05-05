//
//  PurchaseDetailViewController.m
//  SuningEBuy
//
//  Created by xmy on 26/12/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "PurchaseDetailViewController.h"
#import "NQiangGouThridCell.h"
#import "SNSwitch.h"
#import "ShopCartV2ViewController.h"

#define FirstSectionQiangGou    1
#define SecondSectionQiangGou   2
#define ThirdSectionQiangGou    3
#define FourthSectionQiangGou   4
#define FiveSectionQiangGou     5
#define SixSectionQiangGou      6
#define SevenSectionQiangGou    7
@interface PurchaseDetailViewController ()

@end

@implementation PurchaseDetailViewController

- (void)dealloc {
    
    
    
    
}

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithPurchaseDTOandIsSK:(id)purchaseDTO
{
    self = [super initWithDataBasicDTO:nil];
    if (self) {
        
        [self.panicDTO addObserver:self
                        forKeyPath:@"purchaseState"
                           options:NSKeyValueObservingOptionNew
                           context:nil];        

        self.panicDTO = purchaseDTO;

        self.title = L(@"Panic Detail");
        
        self.productBase = self.panicDTO.transformToProductDTO;
        
        //根据开关决定抢购的类型
        //后台维护抢购渠道 1代表B2C抢购渠道，2代表客户端自主抢购渠道 （如果维护为一个无效的值，客户端默认调用1）
        NSString *chanId = [SNSwitch rushPurchaseChannel];
        if ([chanId isEqualToString:@"2"])
        {
            self.panicChannel = PanicChannelMobile;
        }
        else
        {
            self.panicChannel = PanicChannelB2C;
        }
    }
    
    return self;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self refreshBtn];
    
}

- (void)loadView
{
    [super loadView];
    
    self.title = L(@"Panic Detail");

    self.type = 2;
    
    [self refreshFirstProImagesView];
    
    [self refreshBtn];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"time"]) {
        double seconds = [[change objectForKey:@"new"] floatValue];
        double leavingTime = 0;
        switch (self.panicDTO.purchaseState) {
            case ReadyForSale:
            {
                leavingTime = (double)self.panicDTO.startTimeSeconds - seconds;
                [self setTime:leavingTime];
                break;
            }
            case OnSale:
            {
                leavingTime = (double)self.panicDTO.endTimeSeconds - seconds;
                [self setTime:leavingTime];
                break;
            }
            case SaleOut:
            {
                leavingTime = (double)self.panicDTO.endTimeSeconds - seconds;
                [self setTime:leavingTime];
                break;
            }
            case TimeOver:
            {
                break;
            }
            default:
                break;
        }
    }
    else if ([keyPath isEqualToString:@"purchaseState"])
    {
        [self reloadTableViewData];
        
    }
}

- (void)setTime:(double)seconds
{
    if (self.panicDTO.purchaseState == TimeOver) {
        
        return;
    }

    if (seconds < 1 && self.isLoadPurchase) {
        if (self.panicDTO.purchaseState == ReadyForSale) {
            self.panicDTO.purchaseState = OnSale;
            self.panicDTO.purchaseState = OnSale;
            
            [self refreshBtn];
            
        }
        else if (self.panicDTO.purchaseState == OnSale|| self.panicDTO.purchaseState == SaleOut){
            
            self.panicDTO.purchaseState = TimeOver;
            self.panicDTO.purchaseState = TimeOver;
            
            self.stateStr = L(@"Product_Over");
            self.buyNowBtn.enabled = NO;
            
        }
    }
    
    NSString *timeString = nil;
 
    if(self.panicDTO.purchaseState == OnSale|| self.panicDTO.purchaseState == SaleOut
       || self.panicDTO.purchaseState == ReadyForSale)
    {
        
        NSInteger day = seconds / (3600 * 24);
        NSInteger hour = (seconds - day * 3600 * 24) / 3600;
        NSInteger minute = (seconds - day * 3600 * 24 - hour * 3600) / 60;
        NSInteger second = (seconds - day * 3600 * 24 - hour * 3600 - minute * 60);
  
        if (day >= 100) {
            
            
            timeString = [NSString stringWithFormat:@"%03d天%02d:%02d:%02d", day, hour, minute, second];
            
        }else{
            
            timeString = [NSString stringWithFormat:@"%02d天%02d:%02d:%02d", day, hour, minute, second];
            
        }
    }else{
        
        timeString = @"00天00:00:00";
        
    }
    self.timeStr = timeString;
    
}

- (void)refreshBtn{
    
    self.addCarBtn.hidden = YES;
    self.CarBtn.hidden = YES;
    self.CarNumBtn.hidden = YES;
    
    //[self.buyNowBtn setTitle:@"" forState:UIControlStateNormal];

    self.buyNowBtn.frame = CGRectMake(15, 7, 290, 35);

    [self.buyNowBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.buyNowBtn setBackgroundImage:[UIImage imageNamed:@"submit_button_normal.png"] forState:UIControlStateNormal];
    
    [self.buyNowBtn setBackgroundImage:[UIImage imageNamed:@"button_white_disable.png"] forState:UIControlStateDisabled];
    
    [self.bottomNavBar addSubview:self.buyNowBtn];
    
    if (self.panicDTO.purchaseState == ReadyForSale) {
        
        self.stateStr = L(@"readyForSaleState");
        self.buyNowBtn.enabled = NO;
        
    }
    else if (self.panicDTO.purchaseState == SaleOut){
        
        self.stateStr = L(@"SK without ant piece");
        self.buyNowBtn.enabled = NO;
    }
    else if(self.panicDTO.purchaseState == OnSale){
        
        
        if (self.panicDTO.leftQty && 0 == [self.panicDTO.leftQty intValue]) {
            
            self.stateStr = L(@"SK without ant piece");
            self.buyNowBtn.enabled = NO;
        }
//        else if(self.panicDTO.isSale && [self.panicDTO.isSale isEqualToString:@"0"]){
//            
//            self.stateStr = @"我要抢";
//            self.buyNowBtn.enabled = NO;
//        }
        else{
            
            self.stateStr = L(@"Add QuickBuy");
            self.buyNowBtn.enabled = YES;
        }
    }
    else{
        
        self.stateStr = L(@"Product_Over");
        self.buyNowBtn.enabled = NO;
    }
    
    
    if ([self isPurchaseProductEnabled] == NO)
    {
        self.buyNowBtn.enabled = NO;
        
        return;
    }
    
    
}

- (BOOL)isPurchaseProductEnabled
{
    if(self.panicDTO.purchaseState ==  SaleOut
        || self.panicDTO.purchaseState == TimeOver)
    {
        return NO;
    }
    else
    {
        if (self.productBase.isCShop)
        {
            if (self.productBase.suningPrice.doubleValue > 0)
            {
                return YES;
            }
            else
            {
                return NO;
            }
        }
        else
        {
            if ([self.productBase.hasStorage isEqualToString:@"Y"] &&
                ![self.productBase.cityCode isEqualToString:@""] &&
                [self.productBase.suningPrice doubleValue] > 0 &&
                self.productBase.isPublished)
            {
//                return YES;
                BOOL isEnabled;
                
                if (self.panicDTO.purchaseState == SaleOut) {
                    isEnabled = NO;
                }else{
                    isEnabled = YES;
                }
                
//                if ([self.panicDTO.isSale isEqualToString:@"0"]) {
//                    
//                    isEnabled = NO;;
//                }
                
                return isEnabled;

            }
            else
            {
                return NO;
            }
        }

    }
    
    
/*    //先判断商品是否支持购买，再判断状态
    if ([self isProductEnabled]) {
        
//        return YES;
        BOOL isEnabled;
        
        if (self.panicDTO.purchaseState == SaleOut) {
            isEnabled = NO;
        }else{
            isEnabled = YES;
        }
        
        if ([self.panicDTO.isSale isEqualToString:@"0"]) {
            
            isEnabled = NO;;
        }
        
        return isEnabled;
    }else{
        return NO;
    }*/
}

//我要抢按钮事件
-(void)beginEasyBuy{
    
    [self joinPanicPurchase];
}
#pragma mark -
#pragma mark command delegate

- (void)joinPanicPurchase
{
    
    loginSel = @selector(beginEasyBuy);
    
    if (![self checkLogin]){
        
        return;
    }
    
//    if (nil == self.productBase || [self.productBase.hasStorage isEqualToString:@"N"])
//    {
//        return;
//    }
    
    if([self isPurchaseProductEnabled] == NO)
    {
        return;
    }
    
    self.buyNowBtn.enabled = NO;
    if (self.productBase.cityCode.length == 0)
    {
        self.productBase.cityCode = [[Config currentConfig] defaultCity];
    }
    
    NSString *errorMsg = nil;
    
    BOOL canAddToShopCart = [self.shoppingCartBoard checkProductCanAddToShopCart:self.productBase
                                                                        errorMsg:&errorMsg];
    if (canAddToShopCart)
    {
        [self displayOverFlowActivityView];
        
        NSString *userId=[UserCenter defaultCenter].userInfoDTO.userId;
        
        NSString *cityCode=self.productBase.cityCode==nil?self.productBase.cityCode:[Config currentConfig].defaultCity;
        
        self.productBase.quickbuyId = self.panicDTO.rushPurId;
        
        [self.panicService beginGetPanicPurchaseLimitList:self.panicDTO.rushPurId
                                                   userId:userId
                                                   cityId:cityCode];
    }
    else
    {
        [self presentCustomDlg:errorMsg];
        self.buyNowBtn.enabled = YES;
    }
    
}



#pragma mark -
#pragma mark service data




- (void)refreshData
{
    NSString *cityCode=self.productBase.cityCode==nil?[Config currentConfig].defaultCity:self.productBase.cityCode;
    
    [self displayOverFlowActivityView];
    
    [self.panicService beginGetPanicPurchaseDetailList:self.panicDTO.rushPurId  cityId:cityCode];
    
  //  [super refreshData];
    
}

//加入购物车
- (void)addtoShoppingCart2
{
//    if (nil == self.productBase || [self.productBase.hasStorage isEqualToString:@"N"])
//    {
//        return;
//    }
    
    if([self isPurchaseProductEnabled] == NO)
    {
        return;
    }
    
    if (self.productBase.cityCode.length == 0)
    {
        self.productBase.cityCode = [[Config currentConfig] defaultCity];
    }
    
    SNOperationCallBackBlock block = ^(BOOL isSuccess, NSString *errorMsg){
        if (isSuccess) {
            
            BBAlertView *alert =[ [BBAlertView alloc]initWithTitle:nil message:L(@"Product_PurchasePayInThirtyMinute") delegate:nil cancelButtonTitle:L(@"Ok") otherButtonTitles:L(@"Product_GoToShopCart")];
            [alert show];
            [alert setConfirmBlock:^{
                
                [[AppDelegate currentAppDelegate].tabBarViewController setSelectedIndex:3];
                [(UINavigationController*)[[AppDelegate currentAppDelegate].tabBarViewController.viewControllers objectAtIndex:3] popToRootViewControllerAnimated:NO];
            }];
            [alert setCancelBlock:^{
                
                [self refreshBtn];
                
            }];
        }
        else{
            [self presentCustomDlg:errorMsg];
        }
    };
    
    [self.shoppingCartBoard addProductToShoppingCart:self.productBase
                                     completionBlock:block];
    
}

#pragma mark -
#pragma mark servicedelegate

- (void)getPanicPurchaseLimitCompletionWithResult:(BOOL)isSuccess errorCode:(NSString *)errorCode  errorMsg:(NSString*)errorMsg flag:(NSString *)flag rushProcessId:(NSString *)rushProcessId
{
    [self removeOverFlowActivityView];
    self.buyNowBtn.enabled = YES;
    if(isSuccess)
    {
        if([flag isEqualToString:@"0"])
        {
            self.productBase.qianggouPrice = [NSNumber numberWithDouble:[self.panicDetailDto.rushPurPrice doubleValue]];
            self.productBase.rushProcessId = rushProcessId;
            [self addtoShoppingCart2];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"joinPanicPurchase" object:nil];
            
            [self refreshData];
        }else{
            
            if([errorCode isEqualToString:@"2"]||[errorCode isEqualToString:@"3"]||[errorCode isEqualToString:@"5"])
            {
                [self presentSheet:L(@"panicPurchase over")];
                
            }else if([errorCode isEqualToString:@"4"])
            {
                [self presentSheet:L(@"user had panic")];
                
            }else if([errorCode isEqualToString:@"6"])
            {
                [self presentSheet:L(@"city not sale")];
                
            }else if([errorCode isEqualToString:@"1"]||[errorCode isEqualToString:@"7"]||[errorCode isEqualToString:@"8"])
            {
                [self presentSheet:L(@"sorry panic failed")];
            }
            else if([errorCode isEqualToString:@"9"]){
                
                [self presentSheet:L(@"panicPurchase not start")];
            }else if([errorCode isEqualToString:@"10"]){
                
                [self presentSheet:L(@"userId failed")];
            }else if([errorCode isEqualToString:@"11"]){
                
                [self presentSheet:L(@"panicPurchase not support client")];
            }else if([errorCode isEqualToString:@"12"]){
                
                [self presentSheet:L(@"panicPurchase not support mobile")];
            }else {
                
                if (IsNilOrNull(errorMsg)) {
                    errorMsg = L(@"sorry panic failed");
                }
                [self presentSheet:errorMsg];
            }
        }
    }else {
        
        [self presentSheet:errorMsg];
        
    }
    
    [self.tableView reloadData];

}


- (void)getPanicPurchaseDetailCompletionWithResult:(BOOL)isSuccess errorMsg:(NSString *)errorMsg panicPurchaseDetail:(PanicPurchaseDTO *)dto errorCode:(NSString *)errorCode
{
    if(isSuccess && errorMsg==nil)
    {
        self.isLoadPurchase = YES;
        //如果没有计时器，说明不是从列表页面进入，则手动创建计时器
        if (self.calculagraph == nil)//_calculagraph == nil
        {
            noCalculagraphAtFirst = YES;
            self.calculagraph = [[Calculagraph alloc] init];
        }
        
        if (noCalculagraphAtFirst)
        {
            [self.calculagraph start];
        }
        
        self.buyNowBtn.enabled = YES;
        
        if (IsStrEmpty(self.panicDTO.startTime)) {
            
//            [_panicDTO removeObserver:self forKeyPath:@"purchaseState"];
            dto.rushPurId = self.panicDTO.rushPurId;
            self.panicDTO = dto;
            [self.panicDTO addObserver:self
                            forKeyPath:@"purchaseState"
                               options:NSKeyValueObservingOptionNew
                               context:nil];
            
        }
    
        self.panicDetailDto=dto;
        
        self.panicDTO.leftQty = dto.leftQty;
        self.panicDTO.isSale = dto.isSale;
        self.panicDTO.rushPurPrice = dto.rushPurPrice;
        
        self.productBase.quickbuyId = dto.rushPurId;
        
        self.lastTabView.type = self.type;
        self.lastTabView.panicDTO = self.panicDTO;
        self.lastTabView.panicChannel = self.panicChannel;
        self.lastTabView.isLoadPurchase = self.isLoadPurchase;
       
        if([errorCode isEqualToString:@"0"])
        {
            if([dto.leftQty isEqualToString:@"0"])
            {
                [self presentSheet:L(@"panicPurchase over")];
                
                self.buyNowBtn.enabled = NO;
            }
//            else if([dto.isSale isEqualToString:@"0"])
//            {
//                [self presentSheet:@"该城市暂不销售"];
//                
//                self.buyNowBtn.enabled = NO;
//                
//            }
            else if (IsStrEmpty(dto.partNumber)){
                
                [self removeOverFlowActivityView];
                self.buyNowBtn.enabled = NO;
                [self presentSheet:L(@"panicPurchase over")];
                return;
            }
            
            [self displayOverFlowActivityView];
            [self.proDetailService beginGetProductDetailInfo:self.productBase];
        }
    }
    else
    {
        [self removeOverFlowActivityView];
        self.buyNowBtn.enabled = NO;
        
        [self presentSheet:errorMsg];
        
        
    }
    [self.tableView reloadData];

}


/*- (void)getProductDetailCompletionWithResult:(BOOL)isSuccess errorMsg:(NSString *)errorMsg productDetail:(DataProductBasic *)product
{
    
    [self removeOverFlowActivityView];
    if (isSuccess) {
        
        if (IsStrEmpty(product.productName)) {
            product.productName = self.productBase.productName;
        }
        self.productBase = product;
        self.productBase.qianggouPrice = [NSNumber numberWithDouble:[self.panicDetailDto.rushPurPrice doubleValue]];        
        
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

    
}*/

#pragma mark -
#pragma mark tableView deleagte

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == ThirdSectionQiangGou)
    {
        return 0;
    }
    else if(indexPath.section == SevenSectionQiangGou)
    {//屏蔽最优商家列表入口
        return 0;
    }
    else
    {
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == ThirdSectionQiangGou) {
        
        static NSString *productImageCellIdentifier = @"NQiangGouThridCell";
        
        NQiangGouThridCell *cell = (NQiangGouThridCell *)[tableView dequeueReusableCellWithIdentifier:productImageCellIdentifier];
        
        if (nil == cell)
        {
            cell = [[NQiangGouThridCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:productImageCellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.contentView.backgroundColor = RGBCOLOR(242, 242, 242);

        }
        
        self.productBase.qianggouPrice = [NSNumber numberWithDouble:[self.panicDetailDto.rushPurPrice doubleValue]];

        [cell setNQiangGouThridCellInfo:self.panicDTO WithDetail:self.productBase];
        
        if(!self.isLoadDetail)
        {
            cell.sellPointLab.text = @"";
        }
        
        cell.downPrice.text = [NSString stringWithFormat:@"%@: ",L(@"discount")];

        cell.saveLbl.text = [NSString stringWithFormat:@"%@：%@",L(@"leftCount"),self.panicDTO.leftQty?self.panicDTO.leftQty:@""];
        
        return cell;
    }
    else if(indexPath.section == FourthSectionQiangGou)
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
    else if(indexPath.section == SevenSectionQiangGou)
    {
        return [[UITableViewCell alloc] init];
    }
    
    return  [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == FiveSectionQiangGou)
    {
        
        self.lastTabView.appariseNumStr = self.appariseNumStr;
        self.lastTabView.selectTye = indexPath.row;
        self.lastTabView.calculagraph = self.calculagraph;
        [self.navigationController pushViewController:self.lastTabView animated:YES];
        
    }
}

@end
