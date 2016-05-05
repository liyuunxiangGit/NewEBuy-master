//
//  PurchaseProductListViewController.m
//  SuningEBuy
//
//  Created by cui zl on 13-6-15.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "PurchaseProductListViewController.h"
#import "PurchasePruductListCell.h"
#import "PurchaseItemCell.h"
#import "PurchaseDetailViewController.h"
#import "ProductDetailViewController.h"
#import "SNSwitch.h"
#import "DJGroupRuleView.h"

//#define QGShowListIcon       [UIImage imageNamed:@"Purchase_quick_buy_switch_big_list.png"]
//#define QGShowPreviewIcon    [UIImage imageNamed:@"Purchase_quick_buy_switch_small_list.png"]
#define kActivityButton_Height   24.0
#define kActivityButton_Width    69.0

@interface PurchaseProductListViewController()
{
    CGFloat      startY;
    NSString     *__lastActId;
}

@end

@implementation PurchaseProductListViewController

@synthesize service = _service;
@synthesize purchaseList = _purchaseList;
@synthesize calculagraph = _calculagraph;
@synthesize selectPurchaseDto = _selectPurchaseDto;
//@synthesize navItemButton = _navItemButton;
//@synthesize purchaseBackImage = _purchaseBackImage;
//@synthesize accessImg = _accessImg;
//@synthesize defaultNameButton = _defaultNameButton;

- (id)init
{
    self = [super init];
    if (self) {
        
        // isShowBigList = YES;
//        isClik = NO;
//        [self addAnimation];
//        self.accessImg.image = [UIImage imageNamed:@"Purchase_up.png"];

        //self.title = L(@"Panic_Purchase_List")
        
        self.pageTitle = L(@"sale_panicPage_panicList");
        
        self.currentPage = 1;
        
      //  __lastActId = @"0";
        NSString *str = [[SNSwitch rushPurchaseList] objectAtIndex:0];
        NSArray *arrayOne = [str componentsSeparatedByString:@","];
        __lastActId = [arrayOne objectAtIndex:0];
        
        self.hidesBottomBarWhenPushed =YES;
        self.navigationItem.rightBarButtonItem = [self rightBtnItemWithTitle:L(@"Purchase_Rule")];
//        [self.defaultNameButton setTitle:[arrayOne objectAtIndex:1] forState:UIControlStateNormal];

        //抢购添加列表显示
        //        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
        //        view.backgroundColor = [UIColor clearColor];
        //        [view addSubview:self.navItemButton];
        //        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:view];
        //        self.navigationItem.rightBarButtonItem = item;
    }
    return self;
}

- (void)dealloc
{
    //error TT_RELEASE_SAFELY(_service);
    SERVICE_RELEASE_SAFELY(_service);
    TT_RELEASE_SAFELY(_purchaseList);
    [_calculagraph stop];
    [_calculagraph  removeObserver:self forKeyPath:@"time"];
    TT_RELEASE_SAFELY(_calculagraph);
    TT_RELEASE_SAFELY(_selectPurchaseDto);
    // TT_RELEASE_SAFELY(_navItemButton);
    
}

- (NSMutableArray *)purchaseList
{
    if (!_purchaseList) {
        _purchaseList = [[NSMutableArray alloc] init];
    }
    return _purchaseList;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if(self.purchaseList.count == 0)
    {
        [self refreshData];
    }
    [self.tableView reloadData];
}

-(void)loadView
{
    [super loadView];
    
    self.title =L(@"Purchase_LimitedTimePurchase");
    if ([SNSwitch rushPurchaseList].count ==0) {
        listType =2;
        self.tableView.frame =[self visibleBoundsShowNav:YES showTabBar:NO];
    }
    else
    {
        
        NSArray *array =[SNSwitch rushPurchaseList];
        
//        UIScrollView *scroll =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 35)];
//        scroll.contentSize =CGSizeMake(70*array.count, 35);
//        scroll.showsHorizontalScrollIndicator =NO;
//        [self.view addSubview:scroll];
        
        self.titleArr =[[NSMutableArray alloc]init];
        self.codeArr =[[NSMutableArray alloc]init];
        
        
        for (int i =0; i< [array count]; i++) {
            NSString *str = [array objectAtIndex:i];
            NSArray *arrayOne = [str componentsSeparatedByString:@","];
            
            NSString *str1 = [arrayOne objectAtIndex:0];
            [self.codeArr addObject:str1];
            
            NSString *str2 = [arrayOne objectAtIndex:1];
            [self.titleArr addObject:str2];
        }
        
        if ([self.codeArr count]==1) {
            listType =2;
        }
        else
            listType =1;
        
        [self.segment setItems:self.titleArr];

        [self.view addSubview:self.segment];
        
        self.tableView.frame = CGRectMake(0, _segment.bottom+2, 320, self.view.size.height-44-35-2 );
        
        self.title = [self.titleArr objectAtIndex:0];
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView addSubview:self.refreshHeaderView];
    [self.view addSubview:self.tableView];
//    if ([SNSwitch rushPurchaseList].count == 0){
//        [self.defaultNameButton setTitle:@"限时抢购" forState:UIControlStateNormal];
//        [self.purchaseBackImage removeFromSuperview];
//        [self.accessImg removeFromSuperview];
//        self.defaultNameButton.enabled = NO;
//        
//    }
//    else{
//        [self.view addSubview:self.purchaseBackImage];
//        [self.defaultNameButton addSubview:self.accessImg];
//        self.defaultNameButton.enabled = YES;
//    }
//    self.navigationItem.titleView = self.defaultNameButton;
}

-(PurchaseService*)service
{
    if(_service == nil)
    {
        _service = [[PurchaseService alloc]init];
        _service.delegate = self;
    }
    return  _service;
}

- (Calculagraph *)calculagraph
{
    if (!_calculagraph)
    {
        _calculagraph = [[Calculagraph alloc] init];
        [_calculagraph addObserver:self
                        forKeyPath:@"time"
                           options:NSKeyValueObservingOptionNew
                           context:nil];
    }
    return _calculagraph;
}

- (CustomSegment *)segment
{
    if (!_segment) {
//        CGFloat w =[SNSwitch rushPurchaseList].count*70;
//        CGFloat width =w>320?w:320;
        _segment =[[CustomSegment alloc]initWithFrame:CGRectMake(0, 0, 320, 35)];
        _segment.delegate =self;
        _segment.userInteractionEnabled=YES;
    }
    return _segment;
}

- (void)segment:(CustomSegment *)segment didSelectAtIndex:(NSInteger)index
{
    if (index == [self.codeArr count]-1) {
        listType =2;
    }
    else
        listType =1;
    
    __lastActId = [self.codeArr objectAtIndex:index];
    
    self.title = [self.titleArr objectAtIndex:index];
    
    if (!IsArrEmpty(self.purchaseList)) {
        
        NSIndexPath *indexpath =[NSIndexPath indexPathForRow:0 inSection:0];
        
        [self.tableView scrollToRowAtIndexPath:indexpath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }
    
    [self refreshData];
}
//-(void)clickButton
//{
//    if (isClik == YES) {
//        [self addAnimation];
//        self.accessImg.image = [UIImage imageNamed:@"Purchase_up.png"];
//        isClik = NO;
//    }else{
//        [self disAnimation];
//        self.accessImg.image = [UIImage imageNamed:@"Purchase_down.png"];
//        isClik =YES;
//    }
//}
//
//- (void)addAnimation{
//    [UIView animateWithDuration:0.5f animations:^{
//        self.purchaseBackImage.frame = CGRectMake(0, 0, 320, self.purchaseBackImage.height);
//        self.tableView.frame = CGRectMake(0, self.purchaseBackImage.height, 320, self.tableView.height);
//    } completion:^(BOOL finished) {
//        self.tableView.frame = CGRectMake(0 , self.purchaseBackImage.height,320 , self.view.size.height-self.purchaseBackImage.height);
//    }];
//}
//
//- (void)disAnimation
//{
//    [UIView animateWithDuration:0.5f animations:^{
//        self.purchaseBackImage.frame = CGRectMake(0, -self.purchaseBackImage.height, 320, self.purchaseBackImage.height);
//        self.tableView.frame = CGRectMake(0, 0, 320, self.tableView.height);
//    } completion:^(BOOL finished) {
//        self.tableView.frame = CGRectMake(0 ,0 ,320 , self.view.size.height);
//    }];
//}
//
//- (void)setTitleLable:(id)sender
//{
//    isClik =YES;
//    [self disAnimation];
//    UIButton *btn=(UIButton *)sender;
//    btn.selected=!btn.selected;
//    [self.defaultNameButton setTitle:btn.titleLabel.text forState:UIControlStateNormal];
//    self.accessImg.image = [UIImage imageNamed:@"Purchase_down.png"];
//    for(id vc in self.purchaseBackImage.subviews)
//    {
//        if([vc isKindOfClass:[UIButton class]])
//        {
//            UIButton *b= (UIButton*)vc;
//            if(b.tag != btn.tag)
//            {
//                b.selected = NO;
//            }else{
//                btn.selected = YES;
//            }
//        }
//    }
//    
//    self.currentPage = 1;
//    NSString *str = [[SNSwitch rushPurchaseList] objectAtIndex:btn.tag - 1000];
//    NSArray *arrayOne = [str componentsSeparatedByString:@","];
//    __lastActId = [arrayOne objectAtIndex:0];
//    [self displayOverFlowActivityView];
//    [self.service beginGetPanicPurchaseList:[Config currentConfig].defaultCity actChanId:__lastActId pageNumber:self.currentPage];
//    
//}

//- (UIButton *)defaultNameButton
//{
//    if (!_defaultNameButton)
//    {
//        _defaultNameButton = [[UIButton alloc] init];
//        
//        _defaultNameButton.frame = CGRectMake(0, 0, 200, 30);
//        [_defaultNameButton setTitleColor:[UIColor colorWithRGBHex:0x444444] forState:UIControlStateNormal];
//        
//        _defaultNameButton.backgroundColor = [UIColor clearColor];
//        
//        _defaultNameButton.titleLabel.font = [UIFont boldSystemFontOfSize:21.0];
//        
//        [_defaultNameButton setTitle:@"限时抢购" forState:UIControlStateNormal];
//        
//        [_defaultNameButton addTarget:self  action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _defaultNameButton;
//}
//
//- (UIImageView *)accessImg
//{
//    if (!_accessImg) {
//        _accessImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.defaultNameButton.titleLabel.right, 10, 12, 11)];
//        _accessImg.backgroundColor = [UIColor clearColor];
//        _accessImg.image = [UIImage imageNamed:@"Purchase_down.png"];
//        [_accessImg setContentMode:UIViewContentModeScaleToFill];
//        _accessImg.userInteractionEnabled = YES;
//    }
//    _accessImg.frame = CGRectMake(self.defaultNameButton.titleLabel.right+10, 10, 12, 11);
//    return _accessImg;
//}
//
//-(UIImageView *)purchaseBackImage
//{
//    if (!_purchaseBackImage) {
//        _purchaseBackImage = [[UIImageView alloc] init];
//        _purchaseBackImage.backgroundColor = [UIColor clearColor];
//        _purchaseBackImage.userInteractionEnabled = YES;
//        [_purchaseBackImage setImage:[UIImage streImageNamed:@"Purchase_background.png"]];
//        NSArray *array = [SNSwitch rushPurchaseList];
//        int row = ([array count]-1)/4 + 1;
//        _purchaseBackImage.frame = CGRectMake(0, - (10 +(22+ 6)*row + 4), 320, 10 +(22+ 6)*row + 4);
//        for (int i = 0 ; i<[array count]; i++) {
//            
//            int numRow = i/4;
//            int numTag = i%4;
//            CGRect frame = CGRectMake (11.5 +(kActivityButton_Width+7)*numTag ,10 +(22+6)*numRow ,kActivityButton_Width ,kActivityButton_Height);
//            UIButton *button = [[UIButton alloc] init];
//            button.tag =1000+i;
//            button.frame = frame;
//            
//            NSString *str = [array objectAtIndex:i];
//            NSArray *arrayOne = [str componentsSeparatedByString:@","];
//            
//            NSString *str2 = [arrayOne objectAtIndex:1];
//            [button setTitle:str2 forState:UIControlStateNormal];
//            
//            if (i == 0) {
//                button.selected = YES;
//            }
//            
//            button.titleLabel.font =[UIFont systemFontOfSize:14.0f];
//            
//            [button setTitleColor:[UIColor colorWithRGBHex:0x666666] forState:UIControlStateNormal];
//            
//            [button addTarget:self  action:@selector(setTitleLable:) forControlEvents:UIControlEventTouchUpInside];
//            [button setBackgroundImage:[UIImage streImageNamed:@"Activity_Button.png"] forState:UIControlStateNormal];
//            [button setBackgroundImage:[UIImage streImageNamed:@"Purchase_pressed.png"] forState:UIControlStateSelected];
//            
//            [_purchaseBackImage addSubview:button];
//        }
//    }
//    return _purchaseBackImage;
//}

//-(void)viewSwitchAction:(id)sender
//{
//    isShowBigList = !isShowBigList;
//
//    //重新设置按钮图片
//    [_navItemButton setBackgroundImage:isShowBigList?QGShowPreviewIcon:QGShowListIcon
//                              forState:UIControlStateNormal];
//
//    [self.tableView reloadData];
//
//
//}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
}

- (void)getPanicPurchaseListCompletionWithResult:(BOOL)isSuccess
                                        errorMsg:(NSString *)errorMsg
                                       panicList:(NSArray *)list
{
    [self removeOverFlowActivityView];
    //刷新下拉完成
    if (self.isFromHead)
    {
        
        [self refreshDataComplete];
    }
    else
    {
        [self loadMoreDataComplete];
    }
    
    if (isSuccess) {
        
        [self.view hideNetworkErrorView];
        
        if (list && [list count] > 0) {
            
            if (self.isFromHead)
            {
                [self.purchaseList removeAllObjects];
                [self.purchaseList addObjectsFromArray:list];
            }
            else
            {
                [self changeProductStartTime];
                [self.purchaseList addObjectsFromArray:list];
            }
            
            if (self.service.isLastPage) {
                self.isLastPage = YES;
            }else{
                self.isLastPage = NO;
                self.currentPage++;
            }
            
            //开启计时器
            [self.calculagraph start];
        }else{
            
            [self.purchaseList removeAllObjects];
            [self presentSheet:L(@"No_Panic_Purchase")];
            self.isLastPage = YES;
        }
        [self.tableView reloadData];
    }else{
//        [self presentSheet:errorMsg];
        
        if (self.purchaseList.count > 0)
        {
            [self presentSheet:errorMsg];
        }
        else
        {
            __weak PurchaseProductListViewController *weakSelf = self;
            [self.view showNetworkErrorViewWithRefreshBlock:^{
                
                [weakSelf refreshData];
            }];
        }
    }
}

- (void)changeProductStartTime
{
    for (PanicPurchaseDTO *dto in self.purchaseList)
    {
        if (dto.purchaseState == ReadyForSale) {
            dto.startTimeSeconds = dto.startTimeSeconds - [self.calculagraph seconds];
        }else{
            dto.endTimeSeconds = dto.endTimeSeconds - [self.calculagraph seconds];
        }
    }
}

#pragma mark -
#pragma mark purchase card view delegate

//- (void)joinPurchase:(id)dto
//{
//    if (dto == nil) {
//        return;
//    }
//    PurchaseDetailViewController *vc = [[PurchaseDetailViewController alloc] initWithPurchaseDTOandIsSK:dto];
//    
//    vc.productType = PanicProduct;
//    
//    self.selectPurchaseDto = dto;
//    
//    vc.calculagraph = self.calculagraph;
//    
//    //vc.hidesBottomBarWhenPushed = YES;
//    
//    [self.navigationController pushViewController:vc animated:YES];
//    
//    TT_RELEASE_SAFELY(vc);
//}

#pragma mark-
#pragma mark -tableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([self hasMore]) {
        return [self.purchaseList count] + 1;
    }
    return [self.purchaseList count];
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self hasMore] && indexPath.section == [self.purchaseList count]) {
        return 48;
    }

    if (listType ==2) {
        return [PurchaseTimeItemCell height];
    }
    else
        return [PurchaseItemCell height];

}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self hasMore] && indexPath.section == [self.purchaseList count])
    {
        static NSString *MoreResultIdentify = @"MoreResultIdentify";
		
		UITableViewMoreCell * cell = [tableView dequeueReusableCellWithIdentifier:MoreResultIdentify];
		
		if (cell == nil)
        {
			cell = [[UITableViewMoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MoreResultIdentify];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
			cell.title = L(@"Get More...");
            
            cell.animating = NO;
			
			return cell;
		}
        
        cell.title = L(@"Get More...");
        
		cell.animating = NO;
		
		return cell;
    }
    
    if (listType == 1) {
        static NSString *cellIdentifier = @"cellIdentifier";
        
        PurchaseItemCell *cell = (PurchaseItemCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[PurchaseItemCell alloc] initWithStyle:UITableViewCellStyleDefault
                                           reuseIdentifier:cellIdentifier];
            cell.cal = self.calculagraph;
            //        cell.delegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        id dto = [self.purchaseList objectAtIndex:indexPath.section];
        [cell setItem:dto];
        //self.purchaseBackImage.hidden = NO;
        
        return cell;
    }
    else if (listType ==2)
    {
        static NSString *cellIdentifier = @"timeCellIdentifier";
        
        PurchaseTimeItemCell *cell = (PurchaseTimeItemCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[PurchaseTimeItemCell alloc] initWithStyle:UITableViewCellStyleDefault
                                           reuseIdentifier:cellIdentifier];
            cell.cal = self.calculagraph;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        id dto = [self.purchaseList objectAtIndex:indexPath.section];
        [cell setItem:dto];
        
        return cell;
    }
    else
        return nil;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self hasMore] && indexPath.section == [self.purchaseList count]) {
        [self loadMoreData];
        return;
    }
    
    if (listType ==1) {
        PurchaseItemCell *cell = (PurchaseItemCell*)[self.tableView cellForRowAtIndexPath:indexPath];
        
        PanicPurchaseDTO *panicDTO = (PanicPurchaseDTO *)cell.item;
        
        if (panicDTO.purchaseState == OnSale) {
            self.selectPurchaseDto = cell.item;
            
            DataProductBasic *dataProductBasic = cell.item.transformToProductDTO;
            
            ProductDetailViewController *productViewController = [[ProductDetailViewController alloc] initWithDataBasicDTO:dataProductBasic];
            productViewController.type = 2;
            productViewController.productType = FromPanicProduct;
//            productViewController.calculagraph = self.calculagraph;
            productViewController.panicDTO = cell.item;
            //根据开关决定抢购的类型
            //后台维护抢购渠道 1代表B2C抢购渠道，2代表客户端自主抢购渠道 （如果维护为一个无效的值，客户端默认调用1）
            NSString *chanId = [SNSwitch rushPurchaseChannel];
            if ([chanId isEqualToString:@"2"])
            {
                productViewController.panicChannel = PanicChannelMobile;
            }
            else
            {
                productViewController.panicChannel = PanicChannelB2C;
            }
            [self.navigationController pushViewController:productViewController animated:YES];
            return;
            
//            PurchaseDetailViewController *vc = [[PurchaseDetailViewController alloc] initWithPurchaseDTOandIsSK:cell.item];
//            
//            vc.productType = PanicProduct;
//            
//            self.selectPurchaseDto = cell.item;
//            
//            vc.calculagraph = self.calculagraph;
//            
//            [self.navigationController pushViewController:vc animated:YES];
//            
//            TT_RELEASE_SAFELY(vc);
            
        }
        else if (panicDTO.purchaseState == TimeOver)
        {
            
        }
        else
        {
            self.selectPurchaseDto = cell.item;
            
            DataProductBasic *dataProductBasic = cell.item.transformToProductDTO;
            
            ProductDetailViewController *productViewController = [[ProductDetailViewController alloc] initWithDataBasicDTO:dataProductBasic];
            productViewController.type = 2;
            productViewController.productType = FromPanicProduct;
//            productViewController.calculagraph = self.calculagraph;
            productViewController.panicDTO = cell.item;
            //根据开关决定抢购的类型
            //后台维护抢购渠道 1代表B2C抢购渠道，2代表客户端自主抢购渠道 （如果维护为一个无效的值，客户端默认调用1）
            NSString *chanId = [SNSwitch rushPurchaseChannel];
            if ([chanId isEqualToString:@"2"])
            {
                productViewController.panicChannel = PanicChannelMobile;
            }
            else
            {
                productViewController.panicChannel = PanicChannelB2C;
            }
            [self.navigationController pushViewController:productViewController animated:YES];
            return;
            
            PurchaseDetailViewController *vc = [[PurchaseDetailViewController alloc] initWithPurchaseDTOandIsSK:cell.item];
            
            vc.productType = FromPanicProduct;
            
            self.selectPurchaseDto = cell.item;
            
            vc.calculagraph = self.calculagraph;
            
            [self.navigationController pushViewController:vc animated:YES];
            
            TT_RELEASE_SAFELY(vc);
        }
    }
    else
    {
        PurchaseTimeItemCell *cell = (PurchaseTimeItemCell*)[self.tableView cellForRowAtIndexPath:indexPath];
        
        PanicPurchaseDTO *panicDTO = (PanicPurchaseDTO *)cell.item;
        
        if (panicDTO.purchaseState == OnSale) {
            self.selectPurchaseDto = cell.item;
            
            DataProductBasic *dataProductBasic = cell.item.transformToProductDTO;
            
            ProductDetailViewController *productViewController = [[ProductDetailViewController alloc] initWithDataBasicDTO:dataProductBasic];
            productViewController.type = 2;
            productViewController.productType = FromPanicProduct;
//            productViewController.calculagraph = self.calculagraph;
            productViewController.panicDTO = cell.item;
            //根据开关决定抢购的类型
            //后台维护抢购渠道 1代表B2C抢购渠道，2代表客户端自主抢购渠道 （如果维护为一个无效的值，客户端默认调用1）
            NSString *chanId = [SNSwitch rushPurchaseChannel];
            if ([chanId isEqualToString:@"2"])
            {
                productViewController.panicChannel = PanicChannelMobile;
            }
            else
            {
                productViewController.panicChannel = PanicChannelB2C;
            }
            [self.navigationController pushViewController:productViewController animated:YES];
            return;
            
            PurchaseDetailViewController *vc = [[PurchaseDetailViewController alloc] initWithPurchaseDTOandIsSK:cell.item];
            
            vc.productType = FromPanicProduct;
            
            self.selectPurchaseDto = cell.item;
            
            vc.calculagraph = self.calculagraph;
            
            [self.navigationController pushViewController:vc animated:YES];
            
            TT_RELEASE_SAFELY(vc);
            
        }
        else if (panicDTO.purchaseState == TimeOver)
        {
            
        }
        else
        {
            self.selectPurchaseDto = cell.item;
            
            DataProductBasic *dataProductBasic = cell.item.transformToProductDTO;
            
            ProductDetailViewController *productViewController = [[ProductDetailViewController alloc] initWithDataBasicDTO:dataProductBasic];
            productViewController.type = 2;
            productViewController.productType = FromPanicProduct;
//            productViewController.calculagraph = self.calculagraph;
            productViewController.panicDTO = cell.item;
            //根据开关决定抢购的类型
            //后台维护抢购渠道 1代表B2C抢购渠道，2代表客户端自主抢购渠道 （如果维护为一个无效的值，客户端默认调用1）
            NSString *chanId = [SNSwitch rushPurchaseChannel];
            if ([chanId isEqualToString:@"2"])
            {
                productViewController.panicChannel = PanicChannelMobile;
            }
            else
            {
                productViewController.panicChannel = PanicChannelB2C;
            }
            [self.navigationController pushViewController:productViewController animated:YES];
            return;
            
            PurchaseDetailViewController *vc = [[PurchaseDetailViewController alloc] initWithPurchaseDTOandIsSK:cell.item];
            
            vc.productType = FromPanicProduct;
            
            self.selectPurchaseDto = cell.item;
            
            vc.calculagraph = self.calculagraph;
            
            [self.navigationController pushViewController:vc animated:YES];
            
            TT_RELEASE_SAFELY(vc);
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view =[[UIView alloc]init];
    view.backgroundColor =[UIColor clearColor];
    
    return view;
}
#pragma mark -
#pragma mark Refresh And Load More
- (void)refreshData
{
    [super refreshData];
    
    self.currentPage = 1;
    
    [self.service beginGetPanicPurchaseList:[Config currentConfig].defaultCity actChanId:__lastActId pageNumber:self.currentPage];
    
    [self displayOverFlowActivityView];
    
}

- (void)loadMoreData
{
    [super loadMoreData];
    
    [self.service beginGetPanicPurchaseList:[Config currentConfig].defaultCity actChanId:__lastActId pageNumber:self.currentPage];
    
    [self displayOverFlowActivityView];
}

- (void)righBarClick
{
    [self addAnimation1];
}

- (void)addAnimation1{
    
    UIWindow *window = self.appDelegate.window;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"spreeBuyRule" ofType:@"txt"];
    
	NSString *shellTitleText = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    DJGroupRuleView *ruleView = [[DJGroupRuleView alloc]initWithFrame:window.bounds andTitle:L(@"activeRule") andText:shellTitleText];
    
    [ruleView showInView:window];
}

//滑动处理

//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
//{
//    startY = scrollView.contentOffset.y;
//}
//
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    [super scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
//    CGFloat endY = scrollView.contentOffset.y;
//    if (endY - startY > 10 && !isClik) {
//        isClik =YES;
//        self.accessImg.image = [UIImage imageNamed:@"Purchase_down.png"];
//        [self disAnimation];
//    }
//}

@end
