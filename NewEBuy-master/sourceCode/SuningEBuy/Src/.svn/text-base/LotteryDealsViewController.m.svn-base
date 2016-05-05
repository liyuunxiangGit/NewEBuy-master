//
//  LotteryDealsViewController.m
//  SuningLottery
//
//  Created by lyywhg on 13-4-12.
//  Copyright (c) 2013年 suning. All rights reserved.
//

#import "LotteryDealsViewController.h"
#import "LotteryOrderDetailViewController.h"
#import "LotteryHallViewController.h"

#define kDealListObservingKey  @"dealListErrorMsg"
#define kDealSerialNumberListObservingKey   @"dealSerialNumberListErrorMsg"

@interface LotteryDealsViewController ()

//暂存数组  用于暂存请求来的数据
@property (nonatomic, strong)    NSMutableArray         *dealListArray;
@end

@implementation LotteryDealsViewController

@synthesize showBingoBtn = _showBingoBtn;
@synthesize showAllBtn = _showAllBtn;

@synthesize dealTypeChooseBtn = _dealTypeChooseBtn;
@synthesize dealTypeTriangle = _dealTypeTriangle;

@synthesize popUpChooseView = _popUpChooseView;
@synthesize popActionSheet = _popActionSheet;
@synthesize dealTypeChooseView = _dealTypeChooseView;

@synthesize centerNoneDataView = _centerNoneDataView;
@synthesize tip  = _tip;
@synthesize goToLotteryHallBtn = _goToLotteryHallBtn;

@synthesize dealsListService = _dealsListService;

@synthesize dealListArray = _dealListArray;
@synthesize isFormLotteryHall = _isFormLotteryHall;

-(id)init
{
    self = [super init];
    if (self) {
        self.title = L(@"LOLotteryOrderList");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"virtual_lottery"),L(@"LOListOnOtherBehalf")];
        self.isLotteryController = YES;
        dealsType_ =  kDealsType_DaiGou;
        showBingoOrNot_ = kShowAll;
        currentPage_ = 1;
        totalPage_ = 0;
        last_dealsType_ = dealsType_;
        last_showBingoOrNot_ = dealsType_;
        last_currentPage_ = currentPage_;
        isFirstLoad_      = YES;
        self.isFormLotteryHall = NO;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshMyLottery:) name:LOGIN_OK_MESSAGE object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshMyLottery:) name:REFRESH_MYLOTTERY object:nil];
    }
    return self;
}

-(id)initDataCaiPiao
{
    self = [super init];
    if (self) {
        self.title = L(@"LOLotteryOrderList");
        self.pageTitle = [NSString stringWithFormat:@"%@",L(@"virtual_lottery_lotteryOrderList")];
        self.isLotteryController = YES;
        dealsType_ =  kDealsType_DaiGou;
        showBingoOrNot_ = kShowAll;
        currentPage_ = 1;
        totalPage_ = 0;
        last_dealsType_ = dealsType_;
        last_showBingoOrNot_ = dealsType_;
        last_currentPage_ = currentPage_;
        isFirstLoad_      = YES;
        self.isFormLotteryHall = NO;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshMyLottery:) name:LOGIN_OK_MESSAGE object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshMyLottery:) name:REFRESH_MYLOTTERY object:nil];
    }
    return self;
}

-(void)dealloc
{
    
    TT_RELEASE_SAFELY(_dealTypeChooseView);
    TT_RELEASE_SAFELY(_dealTypeTriangle);
    TT_RELEASE_SAFELY(_dealTypeChooseBtn);
    TT_RELEASE_SAFELY(_tableView);
    
    TT_RELEASE_SAFELY(_centerNoneDataView);
    TT_RELEASE_SAFELY(_tip);
    TT_RELEASE_SAFELY(_goToLotteryHallBtn);
    
    TT_RELEASE_SAFELY(_dealsListService);
    
    TT_RELEASE_SAFELY(_dealListArray);
    
    TT_RELEASE_SAFELY(_alertImageV);

    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

-(UIButton *)showAllBtn
{
    if (!_showAllBtn) {
        _showAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_showAllBtn setFrame:CGRectMake(10, 10, 150, 35)];
        [_showAllBtn setTitle:L(@"LOListOnOtherBehalf") forState:UIControlStateNormal];
        
        [_showAllBtn setTitleColor:[UIColor colorWithRGBHex:0x707070] forState:UIControlStateNormal];
        [_showAllBtn setTitleColor:[UIColor colorWithRGBHex:0x515151] forState:UIControlStateSelected];
        
        [_showAllBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRGBHex:0xffffff]
                                                           size:_showAllBtn.bounds.size]
                               forState:UIControlStateNormal];
        [_showAllBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRGBHex:0xdcdcdc]
                                                           size:_showAllBtn.bounds.size]
                               forState:UIControlStateSelected];
        _showAllBtn.layer.borderColor = [UIColor colorWithRGBHex:0xdcdcdc].CGColor;
        _showAllBtn.layer.borderWidth = 1;
        
        _showAllBtn.selected = YES;
        [_showAllBtn addTarget:self action:@selector(showBingoOrNot:)
              forControlEvents:UIControlEventTouchDown];
        _showAllBtn.tag = 123;
    }
    return _showAllBtn;
}

-(UIButton *)showBingoBtn
{
    if (!_showBingoBtn) {
        _showBingoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_showBingoBtn setFrame:CGRectMake(160, 10, 150, 35)];
        [_showBingoBtn setTitle:L(@"LOAdditionalNumberList") forState:UIControlStateNormal];
        [_showBingoBtn setTitleColor:[UIColor colorWithRGBHex:0x707070] forState:UIControlStateNormal];
        [_showBingoBtn setTitleColor:[UIColor colorWithRGBHex:0x515151] forState:UIControlStateSelected];
        
        [_showBingoBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRGBHex:0xffffff]
                                                           size:_showAllBtn.bounds.size]
                               forState:UIControlStateNormal];
        [_showBingoBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRGBHex:0xdcdcdc]
                                                           size:_showAllBtn.bounds.size]
                               forState:UIControlStateSelected];
        _showBingoBtn.layer.borderColor = [UIColor colorWithRGBHex:0xdcdcdc].CGColor;
        
        _showBingoBtn.layer.borderWidth = 1;
        
        [_showBingoBtn addTarget:self action:@selector(showBingoOrNot:) forControlEvents:UIControlEventTouchDown];
        _showBingoBtn.tag = 321;
    }
    return _showBingoBtn;
}

-(UIButton *)dealTypeChooseBtn
{
    if (!_dealTypeChooseBtn) {
        _dealTypeChooseBtn = [[UIButton alloc]init];
        [_dealTypeChooseBtn setFrame:CGRectMake(self.view.width/2 -80, 5, 160, 30)];
        [_dealTypeChooseBtn setTitle:L(@"LOListOnOtherBehalf") forState:UIControlStateNormal];
        _dealTypeChooseBtn.backgroundColor = [UIColor clearColor];
        [_dealTypeChooseBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
        
        [_dealTypeChooseBtn addTarget:self action:@selector(showChooseView) forControlEvents:UIControlEventTouchDown];
    }
    return _dealTypeChooseBtn;
}


-(UIImageView *)dealTypeTriangle
{
    if (!_dealTypeTriangle) {
        _dealTypeTriangle = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"open_Triangle.png"]];
        [_dealTypeTriangle setFrame:CGRectMake(118, 10, 10, 10)];
    }
    return _dealTypeTriangle;
}


-(UIView *)popUpChooseView
{
    if (!_popUpChooseView) {
        _popUpChooseView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissPopUp)];
        singleTap.numberOfTapsRequired = 1;
        [_popUpChooseView addGestureRecognizer:singleTap];
        TT_RELEASE_SAFELY(singleTap);
    }
    return _popUpChooseView;
}

-(UIImageView *)popActionSheet
{
    if (!_popActionSheet) {
        _popActionSheet = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"popActionSheetBackground.png"]];
        [_popActionSheet setFrame:CGRectMake(self.view.width/2 - self.dealTypeChooseBtn.width/2 , 20, self.dealTypeChooseBtn.width , 50 * 2)];
    }
    return _popActionSheet;
}

-(UITableView *)dealTypeChooseView
{
    if (!_dealTypeChooseView) {
        _dealTypeChooseView = [[UITableView alloc]init];
        
        _dealTypeChooseView.tag = 77;
        
        [_dealTypeChooseView setFrame:CGRectMake(self.view.width/2 - self.dealTypeChooseBtn.width/2 + 11, 20 + 8, self.dealTypeChooseBtn.width - 22, 42 * 2)];
        _dealTypeChooseView.layer.cornerRadius = 4.0;
        _dealTypeChooseView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _dealTypeChooseView.exclusiveTouch = YES;
        _dealTypeChooseView.scrollEnabled = NO;
        
        _dealTypeChooseView.delegate = self;
        _dealTypeChooseView.dataSource = self;
    }
    return _dealTypeChooseView;
}

-(UIView *)centerNoneDataView
{
    if (!_centerNoneDataView) {
        _centerNoneDataView = [[UIView alloc]initWithFrame:self.tableView.frame];
        
//        UIImage *facePNG = [UIImage imageNamed:@"order_CaiPiaoIcon.png"];
//        UIImageView *face = [[UIImageView alloc]initWithImage:facePNG];
//        [face setSize:facePNG.size];
//        [face setOrigin:CGPointMake(100, 50)];
//        [_centerNoneDataView addSubview:face];
        
        [_centerNoneDataView addSubview:self.alertImageV];
        
//        if (self.appDelegate.tabBarViewController.selectedIndex == 0) {
//        }else{
//            [self.tip setFrame:CGRectMake(40, face.origin.y+ face.height + 15, face.width + 120, 30)];
//            //我的易购中不添加去投注
//        }
        [self.tip setFrame:CGRectMake(0, self.alertImageV.bottom+15, self.view.frame.size.width, 30)];
        
        [_centerNoneDataView addSubview:self.tip];

/*        [self.goToLotteryHallBtn setFrame:CGRectMake(face.origin.x, self.tip.origin.y + self.tip.height+5, face.width, 30)];
        [_centerNoneDataView addSubview:self.goToLotteryHallBtn];*/

//        TT_RELEASE_SAFELY(face);
    }
    return _centerNoneDataView;
}

-(UILabel *)tip
{
    if (!_tip) {
        _tip = [[UILabel alloc]init];
        _tip.backgroundColor = [UIColor clearColor];
        [_tip setTextColor:[UIColor grayColor]];
        [_tip setFont:[UIFont systemFontOfSize:14]];
        [_tip setTextAlignment:NSTextAlignmentCenter];
    }
    return _tip;
}

-(UIButton *)goToLotteryHallBtn
{
    if (!_goToLotteryHallBtn) {
        _goToLotteryHallBtn = [[UIButton alloc]init];;
        [_goToLotteryHallBtn setBackgroundImage:[UIImage imageNamed:@"goToChooseBall.png"] forState:UIControlStateNormal];
        [_goToLotteryHallBtn addTarget:self action:@selector(goToLotteryHall) forControlEvents:UIControlEventTouchDown];
    }
    return _goToLotteryHallBtn;
}

-(OrderService *)dealsListService
{
    if (!_dealsListService)
    {
        _dealsListService = [[OrderService alloc]init];
        _dealsListService.delegate = self;
    }
    return _dealsListService;
}

-(NSMutableArray *)dealListArray
{
    if (!_dealListArray) {
        _dealListArray = [[NSMutableArray alloc]init];
    }
    return _dealListArray;
}

-(void)loadView
{
    [super loadView];
    
    //self.pageTitle = L(@"virtual_lottery_lotteryOrderList");
//    UIImageView *btnBackground = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"myLottery_background.png"]];
//    [btnBackground setOrigin:self.showAllBtn.origin];
//    [btnBackground setSize:CGSizeMake(self.showAllBtn.width + self.showBingoBtn.width, self.showAllBtn.height)];
//    [self.view addSubview:btnBackground];
//    TT_RELEASE_SAFELY(btnBackground);
    
//    UIImageView *cutlineOfTwoBtn = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cellCutline.png"]];
//    [cutlineOfTwoBtn setFrame:CGRectMake(self.showAllBtn.right, 0, 2, 44)];
//    [self.view addSubview:cutlineOfTwoBtn];
//    TT_RELEASE_SAFELY(cutlineOfTwoBtn);
//
    
    CGRect frame = [self visibleBoundsShowNav:self.hasNav showTabBar:NO];
    self.view.frame = frame;
    frame.origin.y = 55;
    frame.size.height -= 55;
    self.tableView.frame = frame;
    [self.tableView addSubview:self.refreshHeaderView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tag = 88;
    
    [self.view addSubview:self.showAllBtn];
    [self.view addSubview:self.showBingoBtn];
    [self.dealTypeChooseBtn addSubview:self.dealTypeTriangle];

    [self.view addSubview:self.tableView];
    self.hasSuspendButton = YES;
}



-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self displayOverFlowActivityView];
    
    [self sendDaiGouOrZhuiHaoListHttpRequest];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//
//    if (![[[self.navigationController.navigationBar subviews] lastObject] isKindOfClass:[UIButton class]]) {
//        [self.navigationController.navigationBar addSubview:self.dealTypeChooseBtn];
//    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

- (void)lotteryDealListHttpComplete:(BOOL)isSuccess
{
    [self removeOverFlowActivityView];

    if (self.isFromHead) {
        
        [self refreshDataComplete];
    }else{
        
        [self loadMoreDataComplete];
    }

    if ([_dealsListService.unLoginErrorCode isEqualToString:@"common.2.userNotLoggedIn"]) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:LOGIN_SESSION_FAILURE_NEED_LOGIN object:nil];
        return;
    }

    //第一次加载
    if (isFirstLoad_ == YES) {
        isFirstLoad_ = NO;
    }

    if (isSuccess)
    {
        NSArray *orderList = _dealsListService.orderList;
        
        if ([self checkIfNeedSendRequest] != PageDifferent || currentPage_ == 1)
        {
            [self.dealListArray removeAllObjects];   //清空内容
        }
        if (IsArrEmpty(orderList) && !IsStrEmpty(_dealsListService.errorMsg))
        {
            [self presentSheet:self.dealsListService.errorMsg];
            [self.tip setHidden:YES];
            [self.goToLotteryHallBtn setHidden:YES];
            [self.tableView reloadData];

            [self syconShowType];   //每次请求完成都 同步前后状态
            
            return;
        }
        else
        {
            [self.tip setHidden:NO];
            [self.goToLotteryHallBtn setHidden:NO];
        }
        
        
        NSString *errorDesc = _dealsListService.errorMsg;
        totalPage_ = _dealsListService.totalPages;
        
        if (IsStrEmpty(errorDesc.trim))
        {            
            for (LotteryDealsDto *dto in orderList)
            {
                //因接口使用 苏宁彩票 客户端 需要剔除 苏宁易购没有的彩种
                if([dto.gid isEqualToString:@"53"] || [dto.gid isEqualToString:@"52"] || [dto.gid isEqualToString:@"50"] || [dto.gid isEqualToString:@"01"] || [dto.gid isEqualToString:@"07"] || [dto.gid isEqualToString:@"51"] || [dto.gid isEqualToString:@"03"])
                {
                    [self.dealListArray addObject:dto];
                }
            }
        }
        
        [self performSelectorOnMainThread:@selector(updateTable) withObject:nil waitUntilDone:YES];
     
        self.isLoading = NO;
        [self syconShowType];   //每次请求完成都 同步前后状态

    }else{
        [self presentSheet:self.dealsListService.errorMsg];
    }
}

- (void)lotteryDealsSerialNumberListHttpComplete:(BOOL)isSuccess
{
    [self removeOverFlowActivityView];

    
    if (self.isFromHead) {
        
        [self refreshDataComplete];
    }else{
        
        [self loadMoreDataComplete];
    }

    if ([_dealsListService.unLoginErrorCode isEqualToString:@"common.2.userNotLoggedIn"]) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:LOGIN_SESSION_FAILURE_NEED_LOGIN object:nil];
        return;
    }

    //第一次加载
    if (isFirstLoad_ == YES) {
        isFirstLoad_ = NO;
    }

    if (isSuccess) {
        NSArray *orderList = _dealsListService.orderList;
        
        if ([self checkIfNeedSendRequest] != PageDifferent || currentPage_ == 1)
        {
            [self.dealListArray removeAllObjects];   //清空内容
        }
        
        if (IsArrEmpty(orderList) && !IsStrEmpty(_dealsListService.errorMsg))
        {
            [self presentSheet:self.dealsListService.errorMsg];
            [self.tip setHidden:YES];
            [self.goToLotteryHallBtn setHidden:YES];
            [self.tableView reloadData];
            [self syconShowType];   //每次请求完成都 同步前后状态
            return;
        }else
        {
            [self.tip setHidden:NO];
            [self.goToLotteryHallBtn setHidden:NO];
        }
        
        NSString *errorDesc = _dealsListService.errorMsg;
        totalPage_ = _dealsListService.totalPages;
        if ([self checkIfNeedSendRequest] != PageDifferent)
        {
            [self.dealListArray removeAllObjects];   //清空内容
        }
        
        if (errorDesc.trim.length == 0)
        {
            
            for (LotteryDealsSerialNumberDto *dto in orderList)
            {
                
                [self.dealListArray addObject:dto];
            }
        }
        
        [self performSelectorOnMainThread:@selector(updateTable) withObject:nil waitUntilDone:YES];

        self.isLoading = NO;
        [self syconShowType];   //每次请求完成都 同步前后状态

    }else
    {
        [self presentSheet:self.dealsListService.errorMsg];
    }
    
}

- (UIImageView*)alertImageV
{
    if(!_alertImageV)
    {
        _alertImageV = [[UIImageView alloc] init];
        
        _alertImageV.image = [UIImage imageNamed:@"order_CaiPiaoIcon.png"];
        
        _alertImageV.frame = CGRectMake(118, 0, 64, 84);
        
        [_alertImageV setSize:_alertImageV.image.size];
        [_alertImageV setOrigin:CGPointMake(128, 50)];
    }
    
    return _alertImageV;
}

#pragma mark - delegate and dataSource of dealsTypeChooseView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 77) {
        return 43;
    }
    if (indexPath.row == [self.dealListArray count]) {
        return 48;
    }
    return 60;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 77) {
        return 2;
    }
    if ([self.dealListArray count] == 0) {
        if (dealsType_ == kDealsType_DaiGou) {
//            [self.tip setText:L(@"Buy Lottery Tip")];
            self.alertImageV.image = [UIImage imageNamed:@"order_CaiPiaoIcon.png"];
            self.alertImageV.frame = CGRectMake(119.25, 50, 81.5, 61);
            
            [self.alertImageV setSize:_alertImageV.image.size];
            [self.alertImageV setOrigin:CGPointMake(119.25, 50)];
            [self.tip setText:L(@"LONoListOnOtherBehalf")];
            self.tip.frame = CGRectMake(0, self.alertImageV.bottom+15, self.view.frame.size.width, 30);

        }else
        {
            self.alertImageV.image = [UIImage imageNamed:@"order_CaiPiaoIcon.png"];
            self.alertImageV.frame = CGRectMake(119.25, 50, 81.5, 61);
            
            [self.alertImageV setSize:_alertImageV.image.size];
            [self.alertImageV setOrigin:CGPointMake(119.25, 50)];
            [self.tip setText:L(@"LONoAdditionalNumberList")];
            self.tip.frame = CGRectMake(0, self.alertImageV.bottom+15, self.view.frame.size.width, 30);
        }
        
        if (isFirstLoad_ == YES) {
            
            
        }else
        {
//            [self.tableView addSubview:self.alertImageV];

            [self.tableView addSubview:self.centerNoneDataView];
        }
        return 0;
    }else
    {
//        [self.alertImageV removeFromSuperview];

        [self.centerNoneDataView removeFromSuperview];
    }
    DLog(@"msg_sn:%d",[self.dealListArray count]);
    if (currentPage_ == totalPage_) {
        return [self.dealListArray count];
    }
    return [self.dealListArray count] + 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 77) {
        
        UITableViewCell   *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:nil];
        
        UIImageView *backView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"downButtonBackground.png"]];
        [backView setFrame:cell.contentView.frame];
        [cell.contentView addSubview:backView];
        
        UIImageView *tempTriangle = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"open_Triangle.png"]];
        [tempTriangle setFrame:CGRectMake(115, 17, 10, 10)];
        [cell.contentView addSubview:tempTriangle];
        
        UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake( 10, 5, 105, cell.contentView.height - 20)];
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.font = [UIFont boldSystemFontOfSize:20];
        [textLabel setTextColor:[UIColor whiteColor]];
        if (indexPath.row == 0) {
            [textLabel setText:L(@"LOListOnOtherBehalf")];
        }else
        {
            [textLabel setText:L(@"LOAdditionalNumberList")];
        }
        [cell.contentView addSubview:textLabel];
        
        
        if (dealsType_ == kDealsType_DaiGou) {
            if (indexPath.row == 1) {
                [backView setHidden:YES];
                [tempTriangle setHidden:YES];
                [textLabel setTextColor:[UIColor blackColor]];
            }
        }else
        {//追号
            if (indexPath.row == 0) {
                [backView setHidden:YES];
                [tempTriangle setHidden:YES];
                [textLabel setTextColor:[UIColor blackColor]];
            }
        }
        TT_RELEASE_SAFELY(backView);
        TT_RELEASE_SAFELY(tempTriangle);
        TT_RELEASE_SAFELY(textLabel);
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    if (indexPath.row == [self.dealListArray count])
    {
        static NSString *SearchMoreIdentifier = @"SearchMoreIdentifier";
        
        UITableViewMoreCell *moreCell = (UITableViewMoreCell *)[tableView dequeueReusableCellWithIdentifier:SearchMoreIdentifier];
        
        if (moreCell == nil) {
            moreCell = [[UITableViewMoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SearchMoreIdentifier];
        }
        
        moreCell.title = L(@"Get More...");
        
        [moreCell setAnimating:NO];
        
        UIView *view = [[UIView alloc] init];
        view.frame = moreCell.bounds;
        view.backgroundColor = [UIColor clearColor];
        moreCell.backgroundView = view;
        
        return moreCell;
    }
    
    static NSString *dataCellReuseIdentifier = @"lotteryDealsCell";
    LotteryDealsCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:dataCellReuseIdentifier];
    if (!cell) {
        cell = [[LotteryDealsCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:dataCellReuseIdentifier];
    }
    if (dealsType_ == kDealsType_DaiGou) {
        LotteryDealsDto *dto = [self.dealListArray objectAtIndex:indexPath.row];
        [cell setItems:dto];
    }else
    {
        LotteryDealsSerialNumberDto *dto = [self.dealListArray objectAtIndex:indexPath.row];
        [cell setItems:dto];
    }
    return cell;
}

- (UINavigationController *)navigationController
{
    UINavigationController *nav = [super navigationController];
    if (!nav) {
        nav = [[self parentViewController] navigationController];
    }
    return nav;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag == 77)
    {
        if (indexPath.row ==0) {
            dealsType_ = kDealsType_DaiGou;
            [self.dealTypeChooseBtn setTitle:L(@"LOListOnOtherBehalf") forState:UIControlStateNormal];
        }else if(indexPath.row == 1)
        {
            dealsType_ = kDealsType_ZhuiHao;
            [self.dealTypeChooseBtn setTitle:L(@"LOAdditionalNumberList") forState:UIControlStateNormal];
        }
        currentPage_ = 1;
        if ([self checkIfNeedSendRequest] == TypeDifferent) {
            [self showBingoOrNot:self.showAllBtn];
        }
        
        [self dismissPopUp];
    }else if (tableView.tag == 88)
    {
        if (indexPath.row != [self.dealListArray count])
        {
            LotteryOrderDetailViewController *detailViewController = [[LotteryOrderDetailViewController alloc] initWithListDto:[self.dealListArray objectAtIndex:[indexPath row]] isCustomLotteryList:dealsType_ == kDealsType_DaiGou ? YES : NO];
            detailViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:detailViewController animated:YES];
            
            return;
        }else
        {
            if (self.isLoading) {
                return;
            }else
            {
                [self loadMoreData];
            }
        }
    }
}

#pragma mark - morecell method
#pragma mark 加载更多相关
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [super scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    /*判是否加载更多*/
    CGSize contentOffset = [self.tableView contentSize];
    
    CGRect bounds = [self.tableView bounds];
    if (scrollView.contentOffset.y + bounds.size.height >= contentOffset.height && contentOffset.height>=(self.view.frame.size.height-46)) {
        if(currentPage_ < totalPage_){
            [self loadMoreData];
        }
    }
}


- (void)loadMoreData
{    
//    [self startMoreCellAnimation:YES];
    
    currentPage_ = currentPage_ + 1;
    
    [self sendDaiGouOrZhuiHaoListHttpRequest];
}

- (void)startMoreCellAnimation:(BOOL)animating
{
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.tableView numberOfRowsInSection:0] - 1 inSection:0] ;
	
	UITableViewCell *cell = (UITableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
	
	if ([cell isKindOfClass:[UITableViewMoreCell class]]) {
		
		UITableViewMoreCell *_cell = (UITableViewMoreCell *)cell;
        
		[_cell setAnimating: animating];
	}
	
}





#pragma mark - 父类方法
-(void)reloadTableViewDataSource
{
    [super reloadTableViewDataSource];
    currentPage_ = 1;
    [self sendDaiGouOrZhuiHaoListHttpRequest];
}

#pragma mark - self-define method
//点击取消登陆的回调
-(void)cancelLogin
{
}


-(void)refreshMyLottery:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:REFRESH_MYLOTTERY]) {
        //订单生成之后判断是什么类型的订单
        NSNumber *typeNumber = [[notification userInfo] objectForKey:@"type"];
        dealsType_ = [typeNumber integerValue] == kDealsType_DaiGou?kDealsType_DaiGou:kDealsType_ZhuiHao;
        if (dealsType_ == kDealsType_DaiGou) {
            [self.dealTypeChooseBtn setTitle:L(@"LOListOnOtherBehalf") forState:UIControlStateNormal];
        }else
        {
            [self.dealTypeChooseBtn setTitle:L(@"LOAdditionalNumberList") forState:UIControlStateNormal];
        }
        
        currentPage_ = 1;
        
        [self.showAllBtn setBackgroundColor:[UIColor darkGrayColor]];
        [self.showBingoBtn setBackgroundColor:[UIColor clearColor]];
        [self.showBingoBtn.titleLabel setTextColor:[UIColor blackColor]];
        [self.showAllBtn.titleLabel setTextColor:[UIColor whiteColor]];
        showBingoOrNot_ = kShowAll;
        [self displayOverFlowActivityView];
        
        [self sendDaiGouOrZhuiHaoListHttpRequest];
        
        NSString *goToType = [[notification userInfo] objectForKey:@"goToType"];
        
        if ([goToType isEqualToString:@"1"])
        {
            LotteryHallViewController *hall = [[LotteryHallViewController alloc] init];
            [self.navigationController pushViewController:hall animated:YES];
        }else if([goToType isEqualToString:@"2"])
        {
            //如果notification 的userinfo有projid字段 表示需要跳转到订单详情界面
            if([[notification userInfo] objectForKey:@"projid"] != nil)
            {
                LotteryOrderDetailViewController *detailViewController = [[LotteryOrderDetailViewController alloc] initWithProjId:[[notification userInfo] objectForKey:@"projid"] gid:[[notification userInfo] objectForKey:@"gid"] isCustomLotteryList:dealsType_ == kDealsType_DaiGou ? YES : NO];

                [self.navigationController pushViewController:detailViewController animated:YES];
            }
        }else{
            
            //如果notification 的userinfo有projid字段 表示需要跳转到订单详情界面
            if([[notification userInfo] objectForKey:@"projid"] != nil)
            {
                LotteryOrderDetailViewController *detailViewController = [[LotteryOrderDetailViewController alloc] initWithProjId:[[notification userInfo] objectForKey:@"projid"] gid:[[notification userInfo] objectForKey:@"gid"] isCustomLotteryList:dealsType_ == kDealsType_DaiGou ? YES : NO];
                
                [self.navigationController pushViewController:detailViewController animated:YES];
            }
        }
        
    }else
    {
        dealsType_ = kDealsType_DaiGou;
        
        [self.dealTypeChooseBtn setTitle:L(@"LOListOnOtherBehalf") forState:UIControlStateNormal];
        currentPage_ = 1;
        
        
        showBingoOrNot_ = kShowAll;
        [self displayOverFlowActivityView];
        
        [self sendDaiGouOrZhuiHaoListHttpRequest];
        
        
    }
}


-(void)showBingoOrNot:(UIButton *) button
{
    if (button.tag == 123) {
        
        self.showAllBtn.selected = YES;
        self.showBingoBtn.selected = NO;
//        [self.showAllBtn setBackgroundColor:[UIColor darkGrayColor]];
//        [self.showBingoBtn setBackgroundColor:[UIColor clearColor]];
//        [self.showBingoBtn.titleLabel setTextColor:[UIColor blackColor]];
//        [self.showAllBtn.titleLabel setTextColor:[UIColor whiteColor]];
        showBingoOrNot_ = kShowAll;
        dealsType_ = kDealsType_DaiGou;
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"virtual_lottery"),L(@"LOListOnOtherBehalf")];
    }else if(button.tag == 321)
    {
        self.showAllBtn.selected = NO;
        self.showBingoBtn.selected = YES;
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"virtual_lottery"),L(@"LOAdditionalSaleList")];
//        [self.showAllBtn setBackgroundColor:[UIColor clearColor]];
//        [self.showBingoBtn setBackgroundColor:[UIColor darkGrayColor]];
//        [self.showAllBtn.titleLabel setTextColor:[UIColor blackColor]];
//        [self.showBingoBtn.titleLabel setTextColor:[UIColor whiteColor]];
        showBingoOrNot_ = kShowAll;
        dealsType_ = kDealsType_ZhuiHao;
    }
    currentPage_ = 1;
    if ([self checkIfNeedSendRequest] != NoneDifferent) {
        
        [self displayOverFlowActivityView];
        [self sendDaiGouOrZhuiHaoListHttpRequest];
    }else
    {
        //没有不同 就不切换了
    }
}


-(void)showChooseView
{
    //未放入界面中
    [self.popUpChooseView addSubview:self.popActionSheet];
    
    [[AppDelegate currentAppDelegate].window addSubview:self.popUpChooseView];
    
    [[AppDelegate currentAppDelegate].window addSubview:self.dealTypeChooseView];
}

-(void)dismissPopUp
{
    [self.popUpChooseView removeFromSuperview];
    [self.popActionSheet removeFromSuperview];
    [self.dealTypeChooseView removeFromSuperview];
    TT_RELEASE_SAFELY(_dealTypeChooseView);
    
}

-(void)updateTable
{
    [self.tableView reloadData];
}

-(void)goToLotteryHall
{
    if (self.isFormLotteryHall)
    {
        for (UINavigationController *ctrl in [self.navigationController viewControllers]) {
            
            if ([ctrl isKindOfClass:[LotteryHallViewController class]]) {
                
                [self.navigationController popToViewController:ctrl animated:YES];
            }
        }        
    }else
    {
        LotteryHallViewController *ctrl = [[LotteryHallViewController alloc]init];
        [self.navigationController pushViewController:ctrl animated:YES];
    }
}

-(void)sendDaiGouOrZhuiHaoListHttpRequest
{
    
    self.isLoading = YES;
    
    NSString *currentPageProperty = [NSString stringWithFormat:@"%d",currentPage_];
    
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc]init];
    
    [postDataDic setObject:@"1" forKey:@"json"];                        //是否返回json字符串：－1是；0或空返回xml
    [postDataDic setObject:[NSString stringWithFormat:@"%d",dealsType_] forKey:@"flag"];                       //类型：10 查询代购订单   11查询追号
    [postDataDic setObject:@"10" forKey:@"ps"];                         //页面大小
    [postDataDic setObject:currentPageProperty forKey:@"pn"];           //当前页码
    [postDataDic setObject:@"0" forKey:@"tp"];                          //总页数
    [postDataDic setObject:@"0" forKey:@"tr"];                          //总记录数
    [postDataDic setObject:@"" forKey:@"qtype"];
    
    //显示全部彩票   不传时间段
    if (showBingoOrNot_ == kShowAll) {
        [postDataDic setObject:[NSString stringWithFormat:@""] forKey:@"newValue"]; //是否中奖：1中奖 0未中奖 为空时时全部订单
    }else
    {
        [postDataDic setObject:[NSString stringWithFormat:@"%d",showBingoOrNot_] forKey:@"newValue"];
    }
    DLog(@"msg_sn:%@",postDataDic);
    
    if (dealsType_ == kDealsType_DaiGou) {
        [self.dealsListService sendLotteryDealListHttpRequest:postDataDic];
    }else
    {
        [self.dealsListService sendLotteryDealsSerialNumberListHttpRequest:postDataDic];
    }
    
    TT_RELEASE_SAFELY(postDataDic);
}


//记录上次显示的内容 以便减少发送请求
-(void)syconShowType
{
    last_showBingoOrNot_ = showBingoOrNot_;
    last_dealsType_ = dealsType_;
    last_currentPage_ = currentPage_;
}

//返回是否与上次不同  不同则发请求
-(NSInteger)checkIfNeedSendRequest
{
    if (last_dealsType_ != dealsType_) {
        return TypeDifferent;
    }else if (last_showBingoOrNot_ != showBingoOrNot_)
    {
        return BingoDiferent;
    }else if (last_currentPage_ != currentPage_)
    {
        return PageDifferent;
    }
    return NoneDifferent;
}

@end
