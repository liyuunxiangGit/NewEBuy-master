//
//  MyIntegralExchangeViewController.m
//  SuningEBuy
//
//  Created by shasha on 12-9-21.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "MyIntegralExchangeViewController.h"
#import "AchievementExchangeDTO.h"
#import "DetailAchievementCell.h"
#import "DetailAchievementIdCell.h"
#import "InternalRuleHelpViewController.h"
#import "NewIntegralView/NewIntegralView.h"
#import "integralDetailTableViewCell.h"

@interface MyIntegralExchangeViewController() {
    
    BOOL                     isLoadingOK;
    
    UILabel                  *_integralValueLabel;
    
    BOOL                     isGetIntegral;
}

//云钻明细
@property (nonatomic,strong) UIView                     *achDetailsView;
//加载更多
@property (nonatomic,strong) UIView                     *loadMoreView;
//云钻余额
@property (nonatomic,strong) SNUITableViewCell          *totalAchCellView;
//用于展示
@property (nonatomic,strong) MyIntegralService          *service;

//云钻明细列表
@property (nonatomic,strong) NSMutableArray             *achList;

@property (nonatomic,strong) UIActivityIndicatorView    *indicatorView;

@property (nonatomic, strong) NewIntegralView           *integralHeaderView;

@property (nonatomic, assign) int                        totalNum;

@property (nonatomic, strong) UIImageView               *noDetailIconImageView;

@property (nonatomic, strong) UILabel                   *noDetailDescLabel;

- (void)initBackBarButtonItem;

-(SNUITableViewCell *)totalAchCellView:(NSString *)string;

@end

@implementation MyIntegralExchangeViewController

@synthesize achDetailsView = _achDetailsView;

@synthesize loadMoreView = _loadMoreView;

@synthesize totalAchCellView = _totalAchCellView;

@synthesize service = _service;

@synthesize achList = _achList;

- (void)dealloc {
    TT_RELEASE_SAFELY(_achDetailsView);
    TT_RELEASE_SAFELY(_loadMoreView);
    TT_RELEASE_SAFELY(_totalAchCellView);
    TT_RELEASE_SAFELY(_tpTableView);
    SERVICE_RELEASE_SAFELY(_service);
    TT_RELEASE_SAFELY(_achList);
    TT_RELEASE_SAFELY(_integralHeaderView);
    TT_RELEASE_SAFELY(_noDetailDescLabel);
    TT_RELEASE_SAFELY(_noDetailIconImageView);
}

- (id)init {
    
    self = [super init];
    
    if (self) {
        
        self.title = L(@"MyIntegral");
        
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"member_myEbuy"),self.title];
        
        self.currentPage = 1;
        
        isGetIntegral = YES;
        
        self.tableView = self.tpTableView;
        
        [self.tableView setBackgroundColor:[UIColor whiteColor]];
        
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

-(void)loadView{
    
    [super loadView];
    
    _integralHeaderView = [[NewIntegralView alloc]initWithFrame:CGRectMake(0, 0, 320,105) andOwner:self];
    
    [self.view addSubview:_integralHeaderView];
	
	CGRect frame = [self visibleBoundsShowNav:YES showTabBar:!self.hidesBottomBarWhenPushed];
    
    frame.size.height -= _integralHeaderView.height;
    
    frame.origin.y += _integralHeaderView.height;
	
	self.tpTableView.frame = frame;
    
    [self.tpTableView addSubview: (UIView *)self.refreshHeaderView];
	
    [self.view addSubview:self.tpTableView];
    
    self.hasSuspendButton = YES;
    
    [self initialButtonItems];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (isLoadingOK == NO) {
        
        [self displayOverFlowActivityView];
        
        [self.indicatorView startAnimating];
        
        [self.service beginGetMyIntegerInfoRequest];
        
        if (isGetIntegral)
        {
            [self.service BeginGetIntegerDetailInfoRequest:self.currentPage integralType:@"ADD" lastRecord:_achList];
            
        }else{
            
            [self.service BeginGetIntegerDetailInfoRequest:self.currentPage integralType:@"SUBSTRUCT" lastRecord:_achList];
        }
        
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
}


- (void)initialButtonItems
{
    self.navigationItem.rightBarButtonItem = [self rightBtnItemWithTitle:L(@"MyEBuy_Rules")];
}

- (void)righBarClick
{
    [self goToInternalRules];
}

- (void) goToInternalRules{
    
    InternalRuleHelpViewController *vc = [[InternalRuleHelpViewController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
    TT_RELEASE_SAFELY(vc);
    
}

#pragma mark - Http Delegate Methods
#pragma mark   Http数据请求的回调方法

- (void)myIntegralServiceHttpRequestCompletedWithService:(MyIntegralService *)service isSucess:(BOOL)isSucess errorCode:(NSString *)errorCode{
    
    if (isSucess) {
        
        _integralHeaderView.totalIntegralLabel.text =  self.service.achievement;
        
    }else{
        
        _integralHeaderView.totalIntegralLabel.text =  @"--";
        
    }
    
}

- (void)setIntegralValueText:(NSString *)string
{
    _integralValueLabel.text = string;
    
    CGSize size = [@"a" sizeWithFont:_integralValueLabel.font];
    CGSize stringSize=[string sizeWithFont:_integralValueLabel.font
                         constrainedToSize:CGSizeMake(MAXFLOAT, size.height)];
    
    _integralValueLabel.frame=CGRectMake(87, 0, stringSize.width, 40);
}

- (void)didGetIntegerDetailInfoRequestCompletedWithService:(MyIntegralService *)service isSucess:(BOOL)isSucess errorCode:(NSString *)errorCode{
    
    [self removeOverFlowActivityView];
    
    [self refreshDataComplete];
    
    if (isSucess) {
        
        isLoadingOK = YES;
        
        if (!_achList) {
            
            _achList = [[NSMutableArray alloc] init];
            
        }
        
        _achList = [NSMutableArray arrayWithArray:service.integralDetailArr];
        
        if ([_achList count] == 0)
        {
            if (!_noDetailIconImageView||![_tpTableView.subviews containsObject:_noDetailIconImageView])
            {
                [_tpTableView addSubview:self.noDetailIconImageView];
                
                [_tpTableView addSubview:self.noDetailDescLabel];
                
                [_tpTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
                
                [_tpTableView setBackgroundColor:UIColorFromRGB(0xf2f2f2)];
            }
            
        }else{
            
            if (_noDetailIconImageView&&[_tpTableView.subviews containsObject:_noDetailIconImageView])
            {
                [_noDetailIconImageView removeFromSuperview];
                
                [_noDetailDescLabel removeFromSuperview];
                
                [_tpTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
                
                [_tpTableView setBackgroundColor:[UIColor whiteColor]];
            }
            
            _totalNum = 0;
            
            for (NSArray *item in _achList)
            {
                _totalNum += [item count];
            }
            
            self.currentPage = service.currentPage;
            
            if (_totalNum < service.totalNum) {
                
                self.isLastPage = NO;
                
                self.currentPage ++;
                
            }else{
                
                self.isLastPage = YES;
            }
        }
        
        [self.tpTableView reloadData];
        
    }else{
        
        isLoadingOK = NO;
        
        [self presentSheet:L(errorCode)];
        
    }
    
    DLog(@"detailList Count %d",[self.achList count] );
    
}

#pragma mark - Event Methods
#pragma mark   事件的处理方法

- (void)backToMyEbuy:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    //[self.navigationController popToRootViewControllerAnimated:YES];
    
}


#pragma mark - TableView Delegate Datasource Methods
#pragma mark   TableView 的代理以及数据源方法。
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20.0f;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *dateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320,20)];
        
    dateView.backgroundColor = [UIColor colorWithRed:0.92f green:0.92f blue:0.92f alpha:1.0f];
    
    UILabel *dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 300, dateView.height)];
    
    dateLabel.backgroundColor = [UIColor clearColor];
    
    dateLabel.textColor = [UIColor colorWithRed:0.44f green:0.44f blue:0.44f alpha:1.0f];
    
    dateLabel.font = [UIFont systemFontOfSize:10.f];
    
    AchievementExchangeDTO *dto = (AchievementExchangeDTO*)[[self.achList objectAtIndex:section] lastObject];
    
    dateLabel.text = dto.processTime;
    
    [dateView addSubview:dateLabel];
        
    return dateView;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  [self.achList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!self.isLastPage&&([self.achList  count] - 1== section)) {
        
        return [[self.achList objectAtIndex:section] count]+1;
    }
    
    return [[self.achList objectAtIndex:section] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (([self.achList count]-1 == indexPath.section)&&([[self.achList lastObject] count] == indexPath.row)&&!isLastPage)
    {
        return 30;
    }
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (([self.achList count]-1 == indexPath.section)&&([[self.achList lastObject] count] == indexPath.row)&&!isLastPage) {
        
        
        static NSString *cellID = @"cellID";
        
        SNUITableViewCell *cell = (SNUITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (nil == cell)
        {
            cell = [[SNUITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
            [cell.contentView addSubview:self.loadMoreView];
        }
        return cell;
    }
    
    AchievementExchangeDTO *achievementExchangeDTO = [[self.achList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    
    static NSString *detailAchievementCellIdentifier = @"detailAchievementCellIdentifier";
    
    integralDetailTableViewCell *cell = (integralDetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:detailAchievementCellIdentifier];
    
    if (nil == cell)
    {
        cell = [[integralDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detailAchievementCellIdentifier];
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }

    if (IsStrEmpty(achievementExchangeDTO.billNo))
    {
        cell.iconImageView.image = [UIImage imageNamed:@"integralIcon"];
        
        cell.iconImageView.height = 22;
        
    }else{
        NSString *commodityCode =achievementExchangeDTO.billNo;
        
        if ([commodityCode length] == 9)
        {
            commodityCode = [NSString stringWithFormat:@"000000000%@",commodityCode];
        }
        
        cell.iconImageView.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/b2c/catentries/%@_1_60x60.jpg",kGetCommodityImageForHttps,commodityCode]];
        
        cell.iconImageView.height = 30;
    }
    
    cell.commodityNameLabel.text = achievementExchangeDTO.commodityName;
    
    cell.integralLabel.text = achievementExchangeDTO.batchPoint;
    
    return cell;

}


#pragma mark - Properties Initialization Metnods
#pragma mark   属性的初始化方法
- (void)initBackBarButtonItem{
    
    UIButton *fakeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 65, 30)];
    
    fakeButton.titleLabel.font = [UIFont boldSystemFontOfSize:11.0];
    
    [fakeButton addTarget:self action:@selector(backToMyEbuy:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *buttonTitle = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, 50, 28)];
    
    buttonTitle.text = L(@"myEbuy");
    
    buttonTitle.font = [UIFont boldSystemFontOfSize:12];
    
    buttonTitle.textColor = [UIColor whiteColor];
    
    buttonTitle.backgroundColor = [UIColor clearColor];
    
    [fakeButton addSubview:buttonTitle];
    
    TT_RELEASE_SAFELY(buttonTitle);
    
    [fakeButton setBackgroundImage:[UIImage imageNamed:@"public_blue_leftBarButtonItem.png"]
                          forState:UIControlStateNormal];
    
    UIBarButtonItem *fakeButtonItem = [[UIBarButtonItem alloc] initWithCustomView:fakeButton];
    
    self.navigationItem.leftBarButtonItem = fakeButtonItem;
    
    
    TT_RELEASE_SAFELY(fakeButtonItem);
    TT_RELEASE_SAFELY(fakeButton);
    
}

- (void)backForePage
{
    [self backToMyEbuy:nil];
}

//当前云钻余额
-(SNUITableViewCell *)totalAchCellView:(NSString *)string{
    
    if (nil == _totalAchCellView) {
        
        static NSString *totalAchievementCellIdentifier = @"totalAchievementCellIdentifier";
        
        UIFont *font = [UIFont systemFontOfSize:14.0];
        
        CGSize size = [@"a" sizeWithFont:font];
        
        _totalAchCellView = [[SNUITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:totalAchievementCellIdentifier];
        _totalAchCellView.backgroundColor = [UIColor cellBackViewColor];
        
        _totalAchCellView.selectionStyle =UITableViewCellSelectionStyleNone;
        
        UILabel *totalAchDesLabel= [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 80, 40)];
        
        totalAchDesLabel.textAlignment = UITextAlignmentLeft;
        
        totalAchDesLabel.backgroundColor = [UIColor clearColor];
        
        totalAchDesLabel.textColor = [UIColor light_Black_Color];//[UIColor grayColor];
        
        totalAchDesLabel.text = [NSString stringWithFormat:@"%@：",L(@"Integral balance")];
        
        totalAchDesLabel.font = font;
        
        totalAchDesLabel.autoresizingMask = UIViewAutoresizingNone;
        
        [self.totalAchCellView addSubview:totalAchDesLabel];
        
        TT_RELEASE_SAFELY(totalAchDesLabel);
        
        UILabel *totalAchLabel = [[UILabel alloc] init];
        
        _integralValueLabel = totalAchLabel;
        
        totalAchLabel.textAlignment = UITextAlignmentLeft;
		
        totalAchLabel.backgroundColor = [UIColor clearColor];
        
        totalAchLabel.textColor = [UIColor orange_Light_Color];//[UIColor redColor];
        
        totalAchLabel.font = font;
		
        totalAchLabel.autoresizingMask = UIViewAutoresizingNone;
        /*
         * author:崔正来
         * date：2012-09-05
         * description：动态的计算文本框的长度
         */
        CGSize stringSize=[totalAchLabel.text sizeWithFont:totalAchLabel.font constrainedToSize:CGSizeMake(MAXFLOAT, size.width)];
        
        totalAchLabel.frame=CGRectMake(87, 0, stringSize.width, 40);
        
        [self.totalAchCellView addSubview:totalAchLabel];
        
        TT_RELEASE_SAFELY(totalAchLabel);
        
        UILabel *achUnitLabel = [[UILabel alloc] initWithFrame:CGRectMake(110+stringSize.width, 0, 150, 40)];
        
        achUnitLabel.textAlignment = UITextAlignmentLeft;
		
        achUnitLabel.backgroundColor = [UIColor clearColor];
        
        achUnitLabel.textColor = [UIColor colorWithRGBHex:0x999081];//[UIColor blackColor];
        
        achUnitLabel.text = L(@"Achievement Unit");
        
        achUnitLabel.font = [UIFont systemFontOfSize:16.0];
		
        achUnitLabel.autoresizingMask = UIViewAutoresizingNone;
        
        // [self.totalAchCellView addSubview:achUnitLabel];
        
        TT_RELEASE_SAFELY(achUnitLabel);
        
        self.indicatorView.frame = CGRectMake(110+stringSize.width+10, 10, 20, 20);
        [_totalAchCellView addSubview:self.indicatorView];
        
    }
    
    return _totalAchCellView;
    
}

- (UIActivityIndicatorView *)indicatorView
{
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _indicatorView.hidesWhenStopped = YES;
    }
    return _indicatorView;
}

- (TPKeyboardAvoidingTableView *)tpTableView
{
	
	if(!_tpTableView){
		
		_tpTableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectZero
                                                                    style:UITableViewStylePlain];
		
		
		[_tpTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
		
		[_tpTableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
		
		_tpTableView.scrollEnabled = YES;
		
		_tpTableView.userInteractionEnabled = YES;
		
		_tpTableView.delegate =self;
		
		_tpTableView.dataSource =self;
		
		_tpTableView.backgroundColor = [UIColor clearColor];
		
        _tpTableView.backgroundView = nil;
	}
	
	return _tpTableView;
}




//云钻明细
-(UIView *)achDetailsView{
    
    if (_achDetailsView == nil) {
        
        _achDetailsView = [[UIView alloc]init ];
        
        _achDetailsView.frame = CGRectMake(20, 0, 180, 40);
        
        UILabel *achDetailsLbl = [[UILabel alloc] init];
        
        achDetailsLbl.frame = CGRectMake(20, 0, 180, 40);
        
        achDetailsLbl.backgroundColor = [UIColor clearColor];
        
        achDetailsLbl.text = L(@"Achievement Details");
        
        achDetailsLbl.textColor = [UIColor colorWithRGBHex:0x444444];//[UIColor grayColor];
        
        achDetailsLbl.font = [UIFont fontWithName:@"Heiti SC Medium" size:16.0];
        
        [_achDetailsView addSubview:achDetailsLbl];
        
        TT_RELEASE_SAFELY(achDetailsLbl);
    }
    return _achDetailsView;
    
}

-(UIImageView*)noDetailIconImageView
{
    if (!_noDetailIconImageView)
    {
        _noDetailIconImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"NoDetailIcon"]];
        
        _noDetailIconImageView.backgroundColor = [UIColor clearColor];
        
        _noDetailIconImageView.center = _tpTableView.center;
        
        CGRect mframe = _noDetailIconImageView.frame;
        
        mframe.size = CGSizeMake(130, 109);
        
        mframe.origin.y = 50;
        
        _noDetailIconImageView.frame = mframe;
    }
    
    return _noDetailIconImageView;
}

-(UILabel*)noDetailDescLabel
{
    if (!_noDetailDescLabel)
    {
        _noDetailDescLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _noDetailIconImageView.bottom + 20,_tpTableView.width,14)];
        
        _noDetailDescLabel.backgroundColor = [UIColor clearColor];
        
        _noDetailDescLabel.font = [UIFont systemFontOfSize:13];
        
        _noDetailDescLabel.textColor = UIColorFromRGB(0x707070);
        
        _noDetailDescLabel.textAlignment = UITextAlignmentCenter;
        
        _noDetailDescLabel.text = L(@"MyEBuy_YouHaveNoIntegralAndGoToEarn");
    }
    
    return _noDetailDescLabel;
}



//加载更多的视图
-(UIView *)loadMoreView{
    
    if (_loadMoreView == nil) {
        
        _loadMoreView =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30) ];
        
        _loadMoreView.backgroundColor = [UIColor clearColor];//f2f2f2
        
        UIButton  *_loadMoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _loadMoreBtn.frame = CGRectMake(0, 0, 320, 30);
        
        [_loadMoreBtn setBackgroundColor:[UIColor clearColor]];
        
        [_loadMoreBtn setTitle:L(@"loadMore") forState:UIControlStateNormal];
        
        [_loadMoreBtn.titleLabel setFont:[UIFont systemFontOfSize:16.0]];
        
        [_loadMoreBtn.titleLabel setTextAlignment:UITextAlignmentCenter];
        
        [_loadMoreBtn setTitleColor:[UIColor grayColor ] forState:UIControlStateNormal];
        
        [_loadMoreBtn addTarget:self action:@selector(loadMoreData) forControlEvents:UIControlEventTouchUpInside];
        
        [_loadMoreView addSubview:_loadMoreBtn];
        
        TT_RELEASE_SAFELY(_loadMoreBtn);
        
    }
    
    return _loadMoreView;
    
}

//获取标签的宽度
-(CGFloat)xgetWidth:(UILabel *)label{
    
    CGSize size = [label.text sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(315, 1000) lineBreakMode:UILineBreakModeCharacterWrap];
    //当数据过长时，以省略号的形式展现，“需要”不作前移
    return size.width>54?54:size.width;
    
}

//下拉刷新
- (void)refreshData
{
    [super refreshData];
    
    self.currentPage = 1;
    
    [self displayOverFlowActivityView];
    
    [self.service beginGetMyIntegerInfoRequest];
    
    if (isGetIntegral)
    {
        [self.service BeginGetIntegerDetailInfoRequest:self.currentPage integralType:@"ADD" lastRecord:_achList];
        
    }else{
        
        [self.service BeginGetIntegerDetailInfoRequest:self.currentPage integralType:@"SUBSTRUCT" lastRecord:_achList];
    }
}

- (void)refreshDataComplete{
    
    [super refreshDataComplete];
}

#pragma mark - rewrite method of PageRefreshTableViewController
// 加载更多
- (void)loadMoreData
{
    [super loadMoreData];
    
    [self displayOverFlowActivityView];
    
    if (isGetIntegral)
    {
        [self.service BeginGetIntegerDetailInfoRequest:self.currentPage integralType:@"ADD" lastRecord:_achList];
        
    }else{
        
        [self.service BeginGetIntegerDetailInfoRequest:self.currentPage integralType:@"SUBSTRUCT" lastRecord:_achList];
    }
    
}


- (void)loadMoreDataComplete{
    
    [super loadMoreDataComplete];
}

- (MyIntegralService *)service{
    
    if (!_service) {
        
        _service = [[MyIntegralService alloc] init];
        
        _service.delegate = self;
    }
    
    return _service;
}

- (void)segment:(CustomSegment *)segment didSelectAtIndex:(NSInteger)index
{
    [_achList removeAllObjects];
    
    self.currentPage = 1;
    
    [self displayOverFlowActivityView];
    
    if (index == 0)
    {
        isGetIntegral = YES;
        
        [self.service beginGetMyIntegerInfoRequest];
        
        [self.service BeginGetIntegerDetailInfoRequest:self.currentPage integralType:@"ADD" lastRecord:_achList];
        
        [_integralHeaderView.getIntegralBtn setTitle:L(@"MyEBuy_GoToEarnIntegral") forState:UIControlStateNormal];
        
        CGRect frame = _integralHeaderView.getIntegralBtn.frame;
        
        frame.size.width = 75;
        
        frame.origin.x = _integralHeaderView.totalIntegralLabel.right;
        
        _integralHeaderView.getIntegralBtn.frame = frame;
        
    }else
    {
        isGetIntegral = NO;
        
        [self.service beginGetMyIntegerInfoRequest];
        
        [self.service BeginGetIntegerDetailInfoRequest:self.currentPage integralType:@"SUBSTRUCT" lastRecord:_achList];
        
        [_integralHeaderView.getIntegralBtn setTitle:L(@"MyEBuy_GoToDraw") forState:UIControlStateNormal];
        
        CGRect frame = _integralHeaderView.getIntegralBtn.frame;
        
        frame.size.width = 60;
        
        frame.origin.x = _integralHeaderView.totalIntegralLabel.right + 15;
        
        _integralHeaderView.getIntegralBtn.frame = frame;
    }
    
    [self.tableView reloadData];
}

-(void)integralAction:(id)sender
{
    isLoadingOK = NO;
    
    if (isGetIntegral)
    {
        QYaoYiYaoScoreViewCtrler *ctrler = nil;
        
        ctrler = [[QYaoYiYaoScoreViewCtrler alloc] initWithNibName:@"QYaoYiYaoScoreViewCtrler" bundle:nil];
        
        [self.navigationController pushViewController:ctrler animated:YES];
    }else{
        
        QYaoYiYaoViewCtrler *ctrler = [[QYaoYiYaoViewCtrler alloc] initXibWithType:1];
        
        ctrler.delegate             = self;
        
        [self.navigationController pushViewController:ctrler animated:YES];
        
    }
}


@end
