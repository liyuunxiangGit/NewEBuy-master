//
//  MyCouponViewController.m
//  SuningEBuy
//
//  Created by xingxianping on 13-8-23.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "MyCouponViewController.h"
#import "InviteFriendViewController.h"
@interface MyCouponViewController ()

@end

@implementation MyCouponViewController

- (CustomSegment *)segment
{
    if (!_segment) {
        _segment = [[CustomSegment alloc] init];
        
        _segment.delegate = self;
        
        [_segment setItems:[NSArray arrayWithObjects:L(@"MyEBuy_Coupons"),L(@"MyEBuy_IntegralCoupons"), nil]];
        
    }
    return _segment;
}


- (void)dealloc
{
    SERVICE_RELEASE_SAFELY(_myCouponService);
    SERVICE_RELEASE_SAFELY(_userDiscountService);
}

//init :当前页码：1  标题：“我的易购券”；
- (id)initWithTotalAmount:(NSString *)totalAmount{
    self = [super init];
    if (self) {
        self.title = L(@"MyCoupon");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"member_myEbuy"),self.title];
        self.currentPage=1;
        self.totalAmount = totalAmount;
        
        NSMutableArray *tempArray = [[NSMutableArray alloc]init];
        self.myCouponList = tempArray;
        TT_RELEASE_SAFELY(tempArray);
        self.hidesBottomBarWhenPushed = YES;

	}
	return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //self.navigationController.navigationBarHidden = YES;
    [self.userDiscountService beginGetUserDiscountInfo];
    [self.view addSubview:self.segment];
    [self.view addSubview:self.segmentView];
}

//edit by gjf
- (void)backForePage
{
    //self.navigationController.navigationBarHidden = NO;
    for (UINavigationController *ctrl in [self.navigationController viewControllers]) {
        if ([ctrl isKindOfClass:[GetRedPackSuccessViewController class]]) {
            [self.navigationController popToRootViewControllerAnimated:YES];
            return;
        }
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadView
{
    [super loadView];

    //self.navigationController.navigationBarHidden = YES;

    //self.hasNav = NO;
	//UIView *contentView = self.view;
    
	CGRect frame = [self visibleBoundsShowNav:YES showTabBar:!self.hidesBottomBarWhenPushed];
	
	frame.origin.x = 0;
	
	frame.origin.y = 102;
	
	frame.size.height = frame.size.height - 102;
	
    
    self.tableView = self.groupTableView;
    
	self.tableView.frame = frame;
    
    [self.tableView addSubview:self.refreshHeaderView];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.tableView];
    
    self.hasSuspendButton = YES;
    
    [self refreshData];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

#pragma mark-service
//获取券余额
- (UserDiscountService *)userDiscountService
{
    if (!_userDiscountService) {
        _userDiscountService = [[UserDiscountService alloc] init];
        _userDiscountService.delegate = self;
    }
    return _userDiscountService;
}


- (void)didGetUserDiscountCompleted:(BOOL)isSuccess errorMsg:(NSString *)errorMsg
{
    if (isSuccess) {
        [self.tableView reloadData];
    }else{
        //do something
    }
}

- (MyCouponSerivce *)myCouponService
{
    if (!_myCouponService) {
        _myCouponService=[[MyCouponSerivce alloc]init];
        _myCouponService.delegate=self;
    }
    return _myCouponService;
}

- (void)myCouponHttpRequestCompletedWithService:(MyCouponSerivce *)service isSucess:(BOOL)isSucess errorCode:(NSString *)errorCode
{
    [self removeOverFlowActivityView];
    
    if (isSucess) {
        self.totalPage = service.totalPage;
        self.currentPage = service.currentPage;
        
        if (service.totalAmount) {
            self.totalAmount = service.totalAmount;
        }
        
        if (self.isFromHead) {
            [self.myCouponList removeAllObjects];

            self.myCouponList = [NSMutableArray arrayWithArray:service.ticketDataList];
            [self refreshDataComplete];
        }else{
            [self.myCouponList addObjectsFromArray:service.ticketDataList];
            [self loadMoreDataComplete];
        }
        
        
        
        if (self.totalPage>self.currentPage) {
            self.currentPage ++;
            self.isLastPage=NO;
        }else{
            self.isLastPage=YES;
        }
        [self.tableView reloadData];
        
        if (!_myCouponList || [_myCouponList count] == 0) {
            
           // [self.footView addSubview:self.norecordLbl];
            [self presentSheet:L(@"no record of coupon")];
        }else{
            [self.norecordLbl removeFromSuperview];
        }
  
    }else{
        [self presentSheet:errorCode?errorCode:@""];
    }
}



- (void)myExCouponHttpRequestCompletedWithService:(MyCouponSerivce *)service  isSucess:(BOOL)isSucess errorCode:(NSString *)errorCode
{
    [self removeOverFlowActivityView];
    
    if (isSucess) {
        self.totalPage = service.totalPage;
        self.currentPage = service.currentPage;
        
        self.totalAmount = service.totalAmount;
        
        if (self.isFromHead) {
            [self.myCouponList removeAllObjects];

            self.myCouponList = [NSMutableArray arrayWithArray:service.ticketDataList];
            [self refreshDataComplete];
        }else{
            [self.myCouponList addObjectsFromArray:service.ticketDataList];
            [self loadMoreDataComplete];
        }
        
        if (self.totalPage>self.currentPage) {
            self.currentPage ++;
            self.isLastPage=NO;
        }else{
            self.isLastPage=YES;
        }
        [self.tableView reloadData];
        if (!_myCouponList || [_myCouponList count] == 0) {
            
           // [self.footView addSubview:self.norecordLbl];
            [self presentSheet:L(@"no message")];
        }else{
            [self.norecordLbl removeFromSuperview];
        }
    }else{
        [self presentSheet:errorCode?errorCode:@""];
        
    }
    
}
#pragma mark- ebuyQuanCellDelegate

-(void)expendCell{
    
    [self.tableView reloadData];
}

#pragma mark- views and actions

- (void)segment:(CustomSegment *)segment didSelectAtIndex:(NSInteger)index
{
    self.currentPage = 1;
    
    CGRect frame = [self visibleBoundsShowNav:YES showTabBar:!self.hidesBottomBarWhenPushed];
	
	frame.origin.x = 0;
	

    
//    UIView *contentView = self.view;
//    
//    CGRect frame = contentView.frame;
//    
//    frame.origin.x = 0;
    
    if (index == 0 && self.segmentView.hidden)//优惠券
    {
        [self.myCouponList removeAllObjects];
        
        [self.tableView reloadData];
        
        self.segmentView.selectNum=10;
        self.segmentView.leftBtn.selected=YES;
        self.segmentView.middleBtn.selected=NO;
        self.segmentView.rightBtn.selected=NO;
        
        [self.segmentView selectLeftBtn];
        
        self.segmentView.hidden = NO;
        
//        frame.origin.y = 82;
//        
//        frame.size.height = contentView.frame.size.height - 82;
        
        frame.origin.y =102;
        
        frame.size.height = frame.size.height - 102 ;

        
        self.tableView.frame = frame;
    }
    else if (index == 1 && !self.segmentView.hidden)//电子券
    {
        [self.myCouponList removeAllObjects];
        
        [self.tableView reloadData];
        
        
        [self displayOverFlowActivityView];
        
        [self.myCouponService sendExMyCouponHttpRequest:self.currentPage];
        
        self.segmentView.hidden = YES;
        
        frame.origin.y = 83-30;
        
        frame.size.height = frame.size.height - 83 + 30;

        
        self.tableView.frame = frame;
        

    }

}
- (void)requestWithSegmentBtnClicked:(NSInteger)state
{
    SERVICE_RELEASE_SAFELY(_myCouponService);
    [self displayOverFlowActivityView];
    [self.myCouponList removeAllObjects];
    self.state=state;
    self.currentPage=1;
    [self.myCouponService sendMyCouponHttpRequest:self.currentPage state:state];
}


- (void)buttonClickedAtIndex:(NSInteger)index
{
    self.currentPage = 1;
    
    [self.myCouponList removeAllObjects];
    
    if (self.upSegement.index ==0) {
        self.segmentView.selectNum=10;
        self.segmentView.leftBtn.selected=YES;
        self.segmentView.middleBtn.selected=NO;
        self.segmentView.rightBtn.selected=NO;
        
        self.state = 3;
        
        [self displayOverFlowActivityView];
        
        [self.myCouponService sendMyCouponHttpRequest:self.currentPage state:self.state];
        
    }else{
        
        [self displayOverFlowActivityView];
        
        [self.myCouponService sendExMyCouponHttpRequest:self.currentPage];
    }
    
    [self.upSegement refreshButtons];
}

- (UpSegmentView *)upSegement
{
    if (!_upSegement) {
        _upSegement =[[UpSegmentView alloc]initWithFrame:CGRectMake(0, 10, 320, 82)];
        _upSegement.delegate=self;
    }
    return _upSegement;
}

- (SegmentedView *)segmentView
{
    if (!_segmentView) {
        _segmentView=[[SegmentedView alloc]initWithFrame:CGRectMake(20, self.segment.bottom+20, 280, 30)];
        _segmentView.delegate=self;
    }
    return _segmentView;
}

-(UIView *)footView{
    
    if (_footView == nil) {
        
        _footView = [[UIView alloc ]initWithFrame:CGRectMake(0, 0, 320, 75)];
        
        _footView.backgroundColor = [UIColor clearColor];
        
        [_footView addSubview:self.upSegement];

    }
    
    return _footView;
    
}

-(UIView *)loadMoreView{
    if(_loadMoreView == nil){
        
        _loadMoreView =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50) ];
        
        UIButton *_loadMoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _loadMoreBtn.frame = CGRectMake(10, 0, 300, 40);
        
        [_loadMoreBtn setTitle:L(@"loadMore") forState:UIControlStateNormal];
        
        [_loadMoreBtn.titleLabel setFont:[UIFont systemFontOfSize:16.0]];
        
        [_loadMoreBtn.titleLabel setHighlightedTextColor:([UIColor grayColor])];
        
        [_loadMoreBtn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
        
        [_loadMoreBtn.titleLabel setTextAlignment:UITextAlignmentCenter];
        
        [_loadMoreBtn addTarget:self action:@selector(loadMoreData) forControlEvents:UIControlEventTouchUpInside];
        
        [_loadMoreView addSubview:_loadMoreBtn];
        
        TT_RELEASE_SAFELY(_loadMoreBtn);
        
    }
    return _loadMoreView;
}


- (UILabel *)norecordLbl
{
    if (!_norecordLbl) {
        _norecordLbl = [[UILabel alloc] init];
        _norecordLbl.frame = CGRectMake(0, 180, 320, 20);
        _norecordLbl.textAlignment = UITextAlignmentCenter;
        _norecordLbl.backgroundColor = [UIColor clearColor];
        _norecordLbl.font = [UIFont boldSystemFontOfSize:18.0];
        _norecordLbl.textColor = [UIColor darkGrayColor];
        _norecordLbl.text = L(@"no record of coupon");
        
        [self.footView addSubview:_norecordLbl];
    }
    return _norecordLbl;
}


#pragma mark-tableview datasource and delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
//    if ([self.myCouponList count]>0) {
//        
//        return [self.myCouponList count]+1;
//    }
//    //else{
//        return 0;
//    //}
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if ([self.myCouponList count]>0 ) {

        if ([self hasMore]) {
            
            return [self.myCouponList count]+1;
        }
        return [self.myCouponList count];
    }
    
    return 0;

}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
//    if ([self hasMore] && [self.myCouponList count]>0) {
//        
//        return self.loadMoreView;
//        
//    }
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.00001)];
    
    v.backgroundColor = [UIColor clearColor];
    
    return v;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    

    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.00001)];
    
    v.backgroundColor = [UIColor clearColor];
    
    return v;
}
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.00001;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{

    
//    if ([self hasMore])  /// && (section== [self.myCouponList count])
//    {
//        return 50;
//    }
//    else{
        return 0.00001;
//    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self hasMore] && indexPath.row == [self.myCouponList count]) {
        
        static  NSString *identifier = @"identifier";
        UITableViewCell *moreCell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
        if (moreCell == nil) {
            moreCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            moreCell.selectionStyle = UITableViewCellSelectionStyleNone;
             moreCell.backgroundColor = [UIColor clearColor];
            [moreCell.contentView addSubview:self.loadMoreView];
        }

        
        return moreCell;
    }
    

    static NSString *loadCouponIdentifier = @"loadCouponIdentifier";
    EbuyQuanCell *moreCell = (EbuyQuanCell *)[tableView dequeueReusableCellWithIdentifier:loadCouponIdentifier];
    if (moreCell == nil) {
        moreCell = [[EbuyQuanCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:loadCouponIdentifier];
        moreCell.myDelegate = self;
        moreCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    
    
    id dto = [self.myCouponList objectAtIndex:indexPath.row];
    //ExCouponDto

    [moreCell setUIItem:dto];
  
    return moreCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == [self.myCouponList count]) {
        
        return 50;
    }
    
    MYEbuyCoumonDTO *dto = [self.myCouponList objectAtIndex:indexPath.row];
    
    return [EbuyQuanCell heightOfCell:dto];

    
}

//下拉刷新
- (void)refreshData
{
    
    [super refreshData];
        
    self.currentPage = 1;
    
    //    self.appDelegate.isShowNetworkAlert = YES;
    
    if (self.segment.currentIndex == 0) {
        
        [self displayOverFlowActivityView];
        
        [self.myCouponService sendMyCouponHttpRequest:self.currentPage state:self.state];
        
    }else{
        
        [self displayOverFlowActivityView];
        
        [self.myCouponService sendExMyCouponHttpRequest:self.currentPage];
    }
}
// 加载更多
- (void)loadMoreData
{
    [super loadMoreData];
        
    if (self.segment.currentIndex == 0) {
        
        [self displayOverFlowActivityView];
        
        [self.myCouponService sendMyCouponHttpRequest:self.currentPage state:self.state];
        
    }else{
        
        [self displayOverFlowActivityView];
        
        [self.myCouponService sendExMyCouponHttpRequest:self.currentPage];
    }
    
}
//是否最后一页
- (BOOL)hasMore
{
    if (!self.isLastPage)
    {
        return YES;
    }
    
    return NO;
}

@end
