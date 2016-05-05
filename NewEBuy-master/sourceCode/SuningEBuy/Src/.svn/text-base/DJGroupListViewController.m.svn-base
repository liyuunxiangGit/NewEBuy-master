//
//  DJGroupListViewController.m
//  SuningEBuy
//
//  Created by xie wei on 13-7-8.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "DJGroupListViewController.h"
#import "DJGroupListDTO.h"
#import "DJGroupListInputDTO.h"
#import "DJGroupListItemDTO.h"
#import "Calculagraph.h"
#import "DJGroupDetailViewController.h"
#import "DJGroupRuleView.h"
#import "SNSwitch.h"
#import "DJGroupListService.h"

//#define  kDJGroupRuleIcon       [UIImage imageNamed:@"purchase_list_btn.png"]
#define kPageSize    10
//#define kActivityButton_Height   24.0
//#define kActivityButton_Width    69.0

@interface DJGroupListViewController ()

@property (nonatomic, strong) DJGroupListDTO *groupListDto;
@property (nonatomic, strong) DJGroupListService *service;
//@property (nonatomic, strong) UIButton *navItemButton;
@property (nonatomic, strong) Calculagraph *calculagraph;
@property (nonatomic, assign) GroupChannel groupChannel;
@property (nonatomic, strong) DJGroupListInputDTO *inputDto;
@property (nonatomic, strong) NSMutableArray *showArr;

@property (nonatomic, strong) CustomSegment *segment;

//@property (nonatomic ,strong) UIImageView        *groupBackImage;
//@property (nonatomic, strong) UIImageView        *groupAccessImg;
//@property (nonatomic, strong) UIButton           *groupDefaultNameButton;

@end


@implementation DJGroupListViewController

@synthesize groupListDto = _groupListDto;
@synthesize service = _service;
//@synthesize navItemButton = _navItemButton;
@synthesize calculagraph = _calculagraph;
@synthesize groupChannel = _groupChannel;
@synthesize inputDto = _inputDto;
@synthesize showArr = _showArr;

@synthesize segment = _segment;

//@synthesize groupAccessImg = _groupAccessImg;
//@synthesize groupDefaultNameButton = _groupDefaultNameButton;
//@synthesize groupBackImage = _groupBackImage;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_groupListDto);
    SERVICE_RELEASE_SAFELY(_service);
//    TT_RELEASE_SAFELY(_navItemButton);
    
    [_calculagraph stop];
    [_calculagraph  removeObserver:self forKeyPath:@"time"];
    TT_RELEASE_SAFELY(_calculagraph);
    
    TT_RELEASE_SAFELY(_inputDto);
    TT_RELEASE_SAFELY(_showArr);
    
    TT_RELEASE_SAFELY(_segment)
}

- (id)init
{
    self = [super init];
    if (self) {
        self.title = L(@"DJ_Group_List");
//        isClik = NO;
//        [self addAnimation];
//        self.groupAccessImg.image = [UIImage imageNamed:@"Purchase_up.png"];
        
        self.currentPage = 1;
        //        __lastActId = @"0";
        NSString *str = [[SNSwitch groupList] objectAtIndex:0];
        NSArray *arrayOne = [str componentsSeparatedByString:@","];
        __lastActId = [arrayOne objectAtIndex:0];
        
//        [self.groupDefaultNameButton setTitle:[arrayOne objectAtIndex:1] forState:UIControlStateNormal];
        
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"PageTitleCuxiaoDanpingtuan"),self.title];
        self.navigationItem.rightBarButtonItem = [self rightBtnItemWithTitle:L(@"Purchase_Rule")];
        
        NSString *chanId = [SNSwitch groupbuyChannel];
        // 渠道维护
        //        NSString *chanId = @"1";
        if ([chanId isEqualToString:@"2"])
        {
            self.groupChannel = MobileChannel;
        }
        else
        {
            self.groupChannel = MainChannel;
        }
        
        self.hidesBottomBarWhenPushed =YES;
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
//    CGRect frame = self.view.frame;
//    frame.origin.x = 0;
//    frame.origin.y = 0;
//    frame.size.width = 320;
//    frame.size.height= self.view.size.height-92;
//    self.tableView.frame = frame;
    
    if ([SNSwitch groupList].count == 0){
        self.tableView.frame =[self visibleBoundsShowNav:YES showTabBar:NO];
//        [self.groupDefaultNameButton setTitle:@"团购" forState:UIControlStateNormal];
//        [self.groupBackImage removeFromSuperview];
//        [self.groupAccessImg removeFromSuperview];
//        self.groupDefaultNameButton.enabled = NO;
        
    }
    else{
        NSArray *array =[SNSwitch groupList];
        
//        UIScrollView *scroll =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 35)];
//        scroll.contentSize =CGSizeMake(70*array.count, 35);
//        scroll.showsHorizontalScrollIndicator =NO;
//        [self.view addSubview:scroll];
        
        NSMutableArray *titleArr =[[NSMutableArray alloc]init];
    
        for (int i =0; i< [array count]; i++) {
            NSString *str = [array objectAtIndex:i];
            NSArray *arrayOne = [str componentsSeparatedByString:@","];
            
            NSString *str2 = [arrayOne objectAtIndex:1];
            [titleArr addObject:str2];
        }
        
        [self.segment setItems:titleArr];
        
        [self.view addSubview:self.segment];
        
        self.tableView.frame = CGRectMake(0, _segment.bottom+2, 320, self.view.size.height-44-35-2 );
        
        self.title = [titleArr objectAtIndex:0];
        
//        [self.view addSubview:self.groupBackImage];
//        [self.groupDefaultNameButton addSubview:self.groupAccessImg];
//        self.groupDefaultNameButton.enabled = YES;
    }
    
    [self.tableView addSubview:self.refreshHeaderView];
    [self.view addSubview:self.tableView];

//    self.navigationItem.titleView = self.groupDefaultNameButton;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if(IsArrEmpty(self.showArr)){
        self.inputDto.storeId = @"10052";
        self.inputDto.pageType = @"4";
        self.inputDto.channel = [NSString stringWithFormat:@"%d",self.groupChannel];
        self.inputDto.numLimit = @"1000"; //团购活动数量
        self.inputDto.cityId = [Config currentConfig].defaultCity;
        self.inputDto.isPage = @"0";
        self.inputDto.currentPage = @"1";
        self.inputDto.pageSize = @"10";
        self.inputDto.myChannelOnly = [SNSwitch groupbuyMyChannelOnly];
        
        self.inputDto.displayArea = __lastActId;
        
        self.isFromHead = NO; //是否下拉刷新
        
        [self getDJGoodsList];
    }
    
    //    [self showTabBar];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
}

#pragma mark - Refresh LoadMore Methods
#pragma mark - 刷新列表以及加载更多方法

- (void)refreshData
{
    [super refreshData];
    
    self.currentPage = 1;
    
    [self getDJGoodsList];
}

- (void)loadMoreData
{
    [super loadMoreData];
    
    self.currentPage ++;
    
    [self getDJGoodsList];
}


#pragma mark - 事件处理方法

//- (void)groupRuleClick
//{
//    [self addAnimation1];
//    //    self.blackView.hidden = NO;
//    //    self.tipTitleView.hidden = NO;
//    //    self.tipBackView.hidden = NO;
//}

- (void)righBarClick
{
    [self addAnimation1];
    //    self.blackView.hidden = NO;
    //    self.tipTitleView.hidden = NO;
    //    self.tipBackView.hidden = NO;
}

//- (void)setTitleLable:(id)sender
//{
//    isClik =YES;
//    [self disAnimation];
//    UIButton *btn=(UIButton *)sender;
//    btn.selected=!btn.selected;
//    [self.groupDefaultNameButton setTitle:btn.titleLabel.text forState:UIControlStateNormal];
//    self.groupAccessImg.image = [UIImage imageNamed:@"Purchase_down.png"];
//    for(id vc in self.groupBackImage.subviews)
//    {
//        if([vc isKindOfClass:[UIButton class]])
//        {
//            UIButton *b= (UIButton*)vc;
//            if(b.tag != btn.tag)
//            {
//                b.selected = NO;
//            }
//            else
//            {
//                btn.selected = YES;
//            }
//        }
//    }
//}

-(DJGroupListService*)service
{
    if(_service == nil)
    {
        _service = [[DJGroupListService alloc]init];
        _service.delegate = self;
    }
    return  _service;
}

//-(void)clickButton
//{
//    if (isClik == YES) {
//        [self addAnimation];
//        self.groupAccessImg.image = [UIImage imageNamed:@"Purchase_up.png"];
//        isClik = NO;
//    }
//    else
//    {
//        [self disAnimation];
//        self.groupAccessImg.image = [UIImage imageNamed:@"Purchase_down.png"];
//        isClik =YES;
//    }
//}

#pragma mark - "我要团"点击 回调

- (void)joinGroup:(id)dto
{
    DJGroupListItemDTO *itemDto = (DJGroupListItemDTO *)dto;
    
//    DataProductBasic *dataProductBasic = cell.item.transformToProductDTO;
    
    DataProductBasic *productDTO = [[DataProductBasic alloc] init];
    productDTO.productId = itemDto.catentryId;
    productDTO.productCode = itemDto.partnumber;
#warning 默认苏宁自营,后期优化
    productDTO.shopCode = @"";
    
    ProductDetailViewController *productViewController = [[ProductDetailViewController alloc] initWithDataBasicDTO:productDTO];
    productViewController.productType = FromGroupProduct;
    productViewController.baseItemDto = itemDto;
    productViewController.actId = itemDto.grpPurId;
    productViewController.channelId = itemDto.channelID;
    productViewController.hidesBottomBarWhenPushed = YES;
    productViewController.type = 3;
    [self.navigationController pushViewController:productViewController animated:YES];
    return;
    
    
    DJGroupDetailViewController *detailViewController = [[DJGroupDetailViewController alloc] initWithDto:itemDto];
    detailViewController.productType = FromGroupProduct;
    detailViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailViewController animated:YES];
    TT_RELEASE_SAFELY(detailViewController);
}

#pragma mark - 数据请求回调

- (void)getDJGoodsList{
    [self displayOverFlowActivityView];
    self.inputDto.currentPage = [NSString stringWithFormat:@"%d",self.currentPage];
    [self.service beginSendDJListRequest:self.inputDto];
}

- (void)didSendDJListRequestComplete:(DJGroupListService *)service Result:(BOOL)isSuccess
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
        
        if (!IsArrEmpty(service.groupListArray)) {
            self.service = service;
            if (service.pageCount > self.currentPage) {
                self.isLastPage = NO;
            }else{
                self.isLastPage = YES;
            }
            
            if (1 == self.currentPage)
            {
                [self.showArr removeAllObjects];
                [self.showArr addObjectsFromArray:service.groupListArray];
            }
            else
            {
                [self changeProductStartTime];
                [self.showArr addObjectsFromArray:service.groupListArray];
            }
            [self.calculagraph start];
        }else{
            self.isLastPage = YES;
            [self.showArr removeAllObjects];
            [self presentSheet:L(@"No_DJ_List")];
        }
        [self.tableView reloadData];
    }else{
        
        if (self.showArr.count > 0)
        {
            if (IsStrEmpty(service.netWorkErro)) {
                [self presentSheet:L(@"No_DJ_List")];
            }
            else{
                [self presentSheet:service.netWorkErro];
            }
            
        }
        else
        {
            __weak DJGroupListViewController *weakSelf = self;
            [self.view showNetworkErrorViewWithRefreshBlock:^{
                
                [weakSelf refreshData];
            }];
        }
    }
}

- (void)changeProductStartTime
{
    for (DJGroupDetailDTO *dto in self.showArr)
    {
        if ([dto.startFlag isEqualToString:@"1"]) {
            dto.startTimeSeconds = dto.startTimeSeconds - [self.calculagraph seconds];
        }else{
            dto.endTimeSeconds = dto.endTimeSeconds - [self.calculagraph seconds];
        }
    }
}


- (void)refreshTableView
{
    [self.tableView reloadData];
}

#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([self hasMore]) {
        return self.showArr.count + 1;
    }else {
        return self.showArr.count;
    }
//    return 1;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([self hasMore] && (self.showArr.count == indexPath.section))
    {
        return 48;
    }
    return [DJGroupItemCell height];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self hasMore] && (indexPath.section == self.showArr.count)) {
        static NSString *MoreCellIdentifier = @"MoreCellIdentifier";
        UITableViewMoreCell *cell = (UITableViewMoreCell*)[tableView dequeueReusableCellWithIdentifier:MoreCellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewMoreCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MoreCellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.title = L(@"loadMore");
            cell.animating = NO;
        }
        
        return cell;
    }
    
    static NSString *cellIdentifier = @"cellIdentifier";
    
    DJGroupItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[DJGroupItemCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellIdentifier];
        cell.cal = self.calculagraph;
//        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    id dto = [self.showArr objectAtIndex:indexPath.section];
    [cell setItem:dto];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([self hasMore] && indexPath.section == self.showArr.count)
    {
        [self loadMoreData];
        return;
    }
    
    DJGroupListItemDTO *itemDto = [self.showArr objectAtIndex:indexPath.section];
    
    DataProductBasic *productDTO = [[DataProductBasic alloc] init];
    productDTO.productId = itemDto.catentryId;
    productDTO.productCode = itemDto.partnumber;
#warning 默认苏宁自营,后期优化
    productDTO.shopCode = @"";
    
    ProductDetailViewController *productViewController = [[ProductDetailViewController alloc] initWithDataBasicDTO:productDTO];
    productViewController.productType = FromGroupProduct;
    productViewController.baseItemDto = itemDto;
    productViewController.actId = itemDto.grpPurId;
    productViewController.channelId = itemDto.channelID;
    productViewController.hidesBottomBarWhenPushed = YES;
    productViewController.type = 3;
    [self.navigationController pushViewController:productViewController animated:YES];
    return;
    
    DJGroupDetailViewController *detailViewController = [[DJGroupDetailViewController alloc] initWithDto:itemDto];
    detailViewController.productType = FromGroupProduct;
    detailViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailViewController animated:YES];
    TT_RELEASE_SAFELY(detailViewController);
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

#pragma mark - 属性方法
- (CustomSegment *)segment
{
    if (!_segment) {
//        CGFloat w =[SNSwitch groupList].count*70;
//        CGFloat width =w>320?w:320;
        _segment =[[CustomSegment alloc]initWithFrame:CGRectMake(0, 0, 320, 35)];
        _segment.delegate =self;
        _segment.userInteractionEnabled=YES;
        
    }
    return _segment;
}

- (void)segment:(CustomSegment *)segment didSelectAtIndex:(NSInteger)index
{
    NSString *str = [[SNSwitch groupList] objectAtIndex:index];
    NSArray *arrayOne = [str componentsSeparatedByString:@","];
    __lastActId = [arrayOne objectAtIndex:0];
    
    NSString *str1 = [[SNSwitch groupList] objectAtIndex:index];
    NSArray *arrayTwo = [str1 componentsSeparatedByString:@","];
    
    NSString *str2 = [arrayTwo objectAtIndex:1];
    self.title = str2;
    
    self.inputDto.displayArea = __lastActId;
    self.inputDto.currentPage = @"1";
    
    [self refreshData];
    
    if (!IsArrEmpty(self.showArr)) {
        NSIndexPath *indexpath =[NSIndexPath indexPathForRow:0 inSection:0];
        
        [self.tableView scrollToRowAtIndexPath:indexpath atScrollPosition:UITableViewScrollPositionBottom animated:NO];

    }

}
//- (UIButton *)navItemButton
//{
//    if (!_navItemButton)
//    {
//        _navItemButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_navItemButton setImage:kDJGroupRuleIcon
//                        forState:UIControlStateNormal];
//        _navItemButton.size = CGSizeMake(50, 30);
//        [_navItemButton addTarget:self action:@selector(groupRuleClick)
//                 forControlEvents:UIControlEventTouchUpInside];
//    }
//    
//    return _navItemButton;
//}

//- (UIImageView *)groupAccessImg
//{
//    if (!_groupAccessImg) {
//        _groupAccessImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.groupDefaultNameButton.titleLabel.right, 10, 12, 11)];
//        _groupAccessImg.backgroundColor = [UIColor clearColor];
//        _groupAccessImg.image = [UIImage imageNamed:@"Purchase_down.png"];
//        [_groupAccessImg setContentMode:UIViewContentModeScaleToFill];
//        _groupAccessImg.userInteractionEnabled = YES;
//    }
//    _groupAccessImg.frame = CGRectMake(self.groupDefaultNameButton.titleLabel.right+10, 10, 12, 11);
//    return _groupAccessImg;
//}

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

- (DJGroupListInputDTO *)inputDto
{
    if (!_inputDto) {
        _inputDto = [[DJGroupListInputDTO alloc] init];
    }
    return _inputDto;
}

- (NSMutableArray *)showArr
{
    if (!_showArr) {
        _showArr = [[NSMutableArray alloc] init];
    }
    return _showArr;
}

//- (void)addAnimation{
//    [UIView animateWithDuration:0.5f animations:^{
//        self.groupBackImage.frame = CGRectMake(0, 0, 320, self.groupBackImage.height);
//        self.tableView.frame = CGRectMake(0, self.groupBackImage.height, 320, self.tableView.height);
//    } completion:^(BOOL finished) {
//        self.tableView.frame = CGRectMake(0 , self.groupBackImage.height,320 , self.view.size.height-self.groupBackImage.height);
//    }];
//}

//- (void)disAnimation
//{
//    [UIView animateWithDuration:0.5f animations:^{
//        self.groupBackImage.frame = CGRectMake(0, -self.groupBackImage.height, 320, self.groupBackImage.height);
//        self.tableView.frame = CGRectMake(0, 0, 320, self.tableView.height);
//    } completion:^(BOOL finished) {
//        self.tableView.frame = CGRectMake(0 ,0 ,320 , self.view.size.height);
//    }];
//}

- (void)addAnimation1{
    
    UIWindow *window = self.appDelegate.window;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"groupBuyRule" ofType:@"txt"];
    
	NSString *shellTitleText = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    DJGroupRuleView *ruleView = [[DJGroupRuleView alloc]initWithFrame:window.bounds andTitle:L(@"activeRule") andText:shellTitleText];
    
    [ruleView showInView:window];
}


- (void)backForePage
{
    if (isClickingRight) {
        return;
    }
    [super backForePage];
}

//- (UIImageView *)groupBackImage
//{
//    if (!_groupBackImage)
//    {
//        _groupBackImage = [[UIImageView alloc] init];
//        _groupBackImage.backgroundColor = [UIColor clearColor];
//        UIImage *image = [UIImage newImageFromResource:@"Purchase_background.png"];
//        [_groupBackImage setImage:image];
//        _groupBackImage.userInteractionEnabled = YES;
//        NSArray *array = [SNSwitch groupList];
//        
//        int row = ([array count]-1)/4 + 1;
//        
//        _groupBackImage.frame = CGRectMake(0, - (10 +(22+ 6)*row + 4), 320, 10 +(22+ 6)*row + 4);
//        
//        for (int i = 0 ; i<[array count]; i++) {
//            
//            int numRow = i/4;
//            
//            int numTag = i%4;
//            
//            CGRect frame = CGRectMake (11.5 +(kActivityButton_Width+7)*numTag ,10 +(22+6)*numRow ,kActivityButton_Width ,kActivityButton_Height);
//            UIButton *button = [[UIButton alloc] init];
//            button.tag =1000+i;
//            button.frame = frame;
//            NSString *str = [array objectAtIndex:i];
//            NSArray *arrayOne = [str componentsSeparatedByString:@","];
//            NSString *str2 = [arrayOne objectAtIndex:1];
//            [button setTitle:str2 forState:UIControlStateNormal];
//            
//            if (i == 0) {
//                button.selected = YES;
//            }
//            
//            button.titleLabel.font =[UIFont systemFontOfSize:14.0f];
//            [button setTitleColor:[UIColor colorWithRGBHex:0x666666] forState:UIControlStateNormal];
//            [button addTarget:self  action:@selector(setTitleLable:) forControlEvents:UIControlEventTouchUpInside];
//            [button setBackgroundImage:[UIImage streImageNamed:@"Activity_Button.png"] forState:UIControlStateNormal];
//            [button setBackgroundImage:[UIImage streImageNamed:@"Purchase_pressed.png"] forState:UIControlStateSelected];
//            [_groupBackImage addSubview:button];
//        }
//    }
//    return _groupBackImage;
//}

//- (UIButton *)groupDefaultNameButton
//{
//    if (!_groupDefaultNameButton)
//    {
//        _groupDefaultNameButton = [[UIButton alloc] init];
//        _groupDefaultNameButton.frame = CGRectMake(0, 0, 160, 30);
//        [_groupDefaultNameButton setTitleColor:[UIColor colorWithRGBHex:0x444444] forState:UIControlStateNormal];
//        _groupDefaultNameButton.backgroundColor = [UIColor clearColor];
//        _groupDefaultNameButton.titleLabel.font = [UIFont boldSystemFontOfSize:21.0];
//        [_groupDefaultNameButton setTitle:@"团购" forState:UIControlStateNormal];
//        
//        [_groupDefaultNameButton addTarget:self  action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _groupDefaultNameButton;
//}

////滑动处理
//
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
//        self.groupAccessImg.image = [UIImage imageNamed:@"Purchase_down.png"];
//        [self disAnimation];
//    }
//}


@end
