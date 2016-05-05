//
//  SearchHotelLocationByCityNameViewController.m
//  SuningEBuy
//
//  Created by 芳奎 赵 on 12-7-4.
//  Copyright (c) 2012年 苏宁. All rights reserved.
//

#import "SearchHotelLocationByCityNameViewController.h"



@implementation SearchHotelLocationByCityNameViewController
@synthesize bottomView=_bottomView;
@synthesize backBtn=_backBtn;
@synthesize yiGouBtn=_yiGouBtn;

@synthesize tableView = tableView_;
//@synthesize navigationBar = navigationBar_;
@synthesize backgroundImageView = backgroundImageView_;
@synthesize businessCircleList=_businessCircleList;
@synthesize SARList=_SARList;
@synthesize cityName=cityName_;
@synthesize leftBtn=_leftBtn;
@synthesize rightBtn=_rightBtn;
@synthesize  headView = _headView;
@synthesize selectIndex = _selectIndex;
@synthesize delegate=_delegate;
@synthesize locationService = _locationService;

//获取位置列表(商业圈列表、行政区列表)
#pragma mark - 
#pragma mark HTTPMehtods
//- (void)sendlocationHttpRequest{
//    [self displayOverFlowActivityView];
//    NSDictionary *postDic = [[NSDictionary alloc] initWithObjectsAndKeys:cityName_,@"cityName", nil];//请求参数
//    HTTP_RELEASE_SAFELY(locationASIHttpRequest);
//    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostHotelOrderForHttp,@"retrieveLandMark.htm"];
//    locationASIHttpRequest = [Http sendHttpRequest:@"send location httpRequest " URL:url UrlParaDic:postDic Delegate:self  SucessCallback:@selector(requestLocationAdOk:) FailCallback:@selector(requestLocationFail:)];
//    [locationASIHttpRequest retain];
//    TT_RELEASE_SAFELY(postDic);
//    if (!locationASIHttpRequest) {
//        [self removeOverFlowActivityView];
//    }
//}

- (void)sendlocationHttpRequest
{
    [self displayOverFlowActivityView];
    [self.locationService beginLocationHttpRequest:cityName_];        
}

-(void)getHotelLocationListService:(HotelLocationService *)service Result:(BOOL)isSuccess errorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];
    if(NO == isSuccess)
    {
        [self presentSheet:L(@"Sorry loading failed")];         
    }
    else
    {
        self.businessCircleList = service.businessCircleList;
        self.SARList = service.SARList;
       [self performSelectorOnMainThread:@selector(updateTableView) withObject:nil waitUntilDone:NO];

    }

}

-(void)requestLocationFail:(ASIHTTPRequest*)request{
    DLog(@"responseString is %@", [request responseString]);
    [self removeOverFlowActivityView];
    [self presentSheet:L(@"Sorry loading failed")];
}

-(void)requestLocationAdOk:(ASIHTTPRequest*)request{
    //打印请求结果
    NSString *responseString = [request responseString];
    DLog(@"responseString is %@", responseString);
    
    NSDictionary *items = [responseString JSONValue2];
    if (!items) {
        DLog(@"No Data");
        [self removeOverFlowActivityView];
        return;
    }else{
        [self performSelectorOnMainThread:@selector(parseInnerList:) withObject:items waitUntilDone:NO];
        [self removeOverFlowActivityView];
    }
    DLog(@"requestHotelLocationr Ok from server  NSUrlString=%@\n",[items description]);
}


- (void)parseInnerList:(NSDictionary*)items{
    @autoreleasepool 
    {
        //商圈
        NSArray *businessCircleListTemp = [items objectForKey: @"commerceList"];
        if(businessCircleListTemp && [businessCircleListTemp count]>0){
            
            //增加“不限”位置选项
            HotelBusinessCircleDTO *hotelBusinessCircleDTO = [[HotelBusinessCircleDTO alloc] init];
            hotelBusinessCircleDTO.locationId=L(@"BTIrrestriction");
            hotelBusinessCircleDTO.locationName=L(@"BTIrrestriction");
            hotelBusinessCircleDTO.loactionType=L(@"BTIrrestriction");
            
            //定义一个临时可变数组
            NSMutableArray *tempList = [[NSMutableArray alloc]init]; 
            
            [tempList addObject:hotelBusinessCircleDTO];

            for (NSDictionary *dic in businessCircleListTemp) {
                
                if ([dic isKindOfClass:[NSDictionary class]])
                {
                    HotelBusinessCircleDTO *dto = [[HotelBusinessCircleDTO alloc] init];
                    
                    [dto encodeFromDictionary:dic];
                                        
                    [tempList addObject:dto];
                    
                    //TT_RELEASE_SAFELY(dto);
                }
                
            }
            
            [self.businessCircleList addObjectsFromArray:tempList]; 
            DLog(@"%d", [self.businessCircleList count]);
            
        }
        //行政区
        NSArray *SARListTemp = [items objectForKey: @"districtList"];
        if(SARListTemp && [SARListTemp count]>0){
            
            //增加“不限”位置选项
            HotelSARDTO *dtoNO = [[HotelSARDTO alloc] init];
            dtoNO.locationId=L(@"BTIrrestriction");
            dtoNO.locationName=L(@"BTIrrestriction");
            dtoNO.loactionType=L(@"BTIrrestriction");
        
            
            NSMutableArray *tempList = [[NSMutableArray alloc]init]; 
            
            [tempList addObject:dtoNO];

            for (NSDictionary *dic in SARListTemp) {
                
                if ([dic isKindOfClass:[NSDictionary class]])
                {
                    HotelSARDTO *dto = [[HotelSARDTO alloc] init];
                    
                    [dto encodeFromDictionary:dic];
                                        
                    [tempList addObject:dto];
                    
                    //                    TT_RELEASE_SAFELY(dto);
                }
            }
            
            [self.SARList addObjectsFromArray:tempList]; 
            DLog(@"%d", [self.SARList count]);
            
        }
        
        [self performSelectorOnMainThread:@selector(updateTableView) withObject:nil waitUntilDone:NO];
    }
}

-(void)updateTableView
{
    if (!self.tableView.superview) 
    {
        [self.view addSubview:self.tableView];
    }
    else
    {
        [self.tableView reloadData];
    }
    
}

- (id)initWithCityName:(NSString *) cityName{
    self = [super init];
    if (self) {
        self.title = L(@"BTHotelPosition");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"virtual_business"),self.title];

        self.cityName=cityName;
        self.selectIndex=1;
        DLog(@"%@", self.cityName);
        DLog(@"%d", self.selectIndex);
        //初始化两个可变数组，这里只init，不回收，在dealloc方法中回收
//        self.businessCircleList=[[NSMutableArray alloc]init];
        if (!_businessCircleList) {
            _businessCircleList = [[NSMutableArray alloc] init];
        }
//        self.SARList=[[NSMutableArray alloc]init];
        if (!_SARList) {
            _SARList = [[NSMutableArray alloc] init];
        }
        
        self.bSupportPanUI = NO;
    }
    return self;
}


- (void)dealloc
{
    TT_RELEASE_SAFELY(_bottomView);
    TT_RELEASE_SAFELY(_backBtn);
    TT_RELEASE_SAFELY(_yiGouBtn);

    TT_RELEASE_SAFELY(_businessCircleList)
    TT_RELEASE_SAFELY(_SARList)
    TT_RELEASE_SAFELY(_headView);
    TT_RELEASE_SAFELY(_rightBtn);
    TT_RELEASE_SAFELY(_leftBtn);
    SERVICE_RELEASE_SAFELY(_locationService);
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

-(void)loadView{
    
    [super loadView];
//    self.hasNav=NO;
    
//    CGRect frame =[self visibleBoundsShowNav:NO showTabBar:YES];
//    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7) {
//        frame.origin.y=frame.origin.y;
//        frame.size.height=frame.size.height;
//    }
//	self.tableView.frame =frame;
    
    UIView *contentView = self.view;
	
	CGRect frame = contentView.frame;
	
	frame.origin.x = 0;
	
	frame.origin.y = 0;
	
    frame.size.height = contentView.bounds.size.height-44;
	
	self.tableView.frame = frame;
	
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_system_background.png"]];
    
	[self.view addSubview:self.tableView];
//    [self.view addSubview:self.bottomView];
    [self sendlocationHttpRequest];
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    self.tableView = nil;
}

-(UIButton*)leftBtn{

    if (_leftBtn==nil) {
        _leftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_leftBtn setFrame:CGRectMake(20, 18, 140, 30)];
        _leftBtn.selected=YES;
        [_leftBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        
        [_leftBtn setTitle:L(@"BTCommerceCircle") forState:UIControlStateNormal];
        [_leftBtn setTitle:L(@"BTCommerceCircle") forState:UIControlStateSelected];
        
        [_leftBtn setTitleColor:[UIColor dark_Gray_Color] forState:UIControlStateNormal];
        [_leftBtn setTitleColor:[UIColor light_Black_Color] forState:UIControlStateSelected];
        
        UIImage* normalImg=[UIImage newImageFromResource:@"button_white_normal@2x.png"];
        [_leftBtn setBackgroundImage:normalImg forState:UIControlStateNormal];
        TT_RELEASE_SAFELY(normalImg);
        
        UIImage* selectedImage=[UIImage newImageFromResource:@"button_white_clicked@2x.png"];
        [_leftBtn setBackgroundImage:selectedImage forState:UIControlStateSelected];
        TT_RELEASE_SAFELY(selectedImage);
        [_leftBtn addTarget:self action:@selector(leftBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}
-(UIButton*)rightBtn{

    if (_rightBtn==nil) {
        _rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn setFrame:CGRectMake(160, 18, 140, 30)];
        _rightBtn.selected=NO;
        [_rightBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        
        [_rightBtn setTitle:L(@"BTAdministrativeRegion") forState:UIControlStateNormal];
        [_rightBtn setTitle:L(@"BTAdministrativeRegion") forState:UIControlStateSelected];
        
        [_rightBtn setTitleColor:[UIColor dark_Gray_Color] forState:UIControlStateNormal];
        [_rightBtn setTitleColor:[UIColor light_Black_Color] forState:UIControlStateSelected];
        
        [_rightBtn setBackgroundImage:[UIImage imageNamed:@"button_white_normal@2x"] forState:UIControlStateNormal];
        [_rightBtn setBackgroundImage:[UIImage imageNamed:@"button_white_clicked@2x"] forState:UIControlStateSelected];
        [_rightBtn addTarget:self action:@selector(rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}
- (void)segmentedControl:(id)sender {
    
    NSInteger index = [(UISegmentedControl*)sender selectedSegmentIndex];
    DLog(@"%d", index);
    
    switch (index) {            
        case 0:
        {
            self.selectIndex=1;           
        }
            break;
        case 1:
        {
            self.selectIndex=2;            
        }
            break;
        default:
        {
            self.selectIndex=1;        
        }
            break;
    }	
    [self updateTableView];
}


-(UIView *)headView{
    
    if (_headView == nil) {
        
        _headView = [[UIView alloc ]initWithFrame:CGRectMake(0, 0, 320, 60)];
        
        _headView.backgroundColor = [UIColor clearColor];
//        [_footView addSubview:self.segCate];
        
        [_headView addSubview:self.leftBtn];
        [_headView addSubview:self.rightBtn];
        
        
    }
    
    return _headView;
    
}


- (UITableView *)tableView
{
	if(!tableView_)
    {
        if (IOS7_OR_LATER) {
            tableView_ = [[UITableView alloc] initWithFrame:CGRectZero
                                                      style:UITableViewStyleGrouped];
        }else
            tableView_ = [[UITableView alloc] initWithFrame:CGRectZero
                                                      style:UITableViewStylePlain];
		
		
        
		[tableView_ setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
		
		[tableView_ setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
		
		tableView_.scrollEnabled = YES;
		
		tableView_.userInteractionEnabled = YES;
		
		tableView_.delegate = self;
		
		tableView_.dataSource = self;
		
		tableView_.backgroundColor =[UIColor clearColor];
        
        tableView_.backgroundView = nil;
        
//        UIView *view = [UIView new];
//        
//        view.backgroundColor = [UIColor clearColor];
        
        tableView_.tableHeaderView = self.headView;
		
	}
	
	return tableView_;
}



- (void)backForePage
{
    [self pressReturn:nil];
}

- (void)pressReturn:(id)sender {
    
    [self dismissModalViewControllerAnimated:YES];
}


- (UIImageView *)backgroundImageView
{
    if (!backgroundImageView_) {
        backgroundImageView_ = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_system_background.png"]];
        backgroundImageView_.frame = CGRectMake(0, 44, backgroundImageView_.width, backgroundImageView_.height);
        
    }
    return backgroundImageView_;
}

-(HotelLocationService *)locationService
{
    if(nil == _locationService)
    {
        _locationService = [[HotelLocationService alloc] init];
        _locationService.delegate = self;
    }
    return _locationService;
}
#pragma mark - bottomView
- (UIView*)bottomView
{
    if(!_bottomView)
    {
        _bottomView = [[UIView alloc] init];
        
        _bottomView.backgroundColor = [UIColor whiteColor];
        
        _bottomView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height -55-20, self.view.frame.size.width, 55);
        [_bottomView addSubview:self.yiGouBtn];
        [_bottomView addSubview:self.backBtn];
        
        UIImageView* lineImage=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
        UIImage* img=[UIImage newImageFromResource:@"category_cellSeparatorLine.png"];
        [lineImage setImage:img];
        TT_RELEASE_SAFELY(img);
        [_bottomView addSubview:lineImage];
        TT_RELEASE_SAFELY(lineImage);
        
    }
    
    return _bottomView;
}

- (UIButton*)backBtn
{
    if(!_backBtn)
    {
        _backBtn = [[UIButton alloc] init];
        
        _backBtn.backgroundColor = [UIColor clearColor];
        
        _backBtn.frame = CGRectMake(0, 6, 44, 44);
        
        [_backBtn setImage:[UIImage imageNamed:@"nav_back_normal.png"] forState:UIControlStateNormal];
        
        [_backBtn setImage:[UIImage imageNamed:@"nav_back_select.png"] forState:UIControlStateHighlighted];
        
        [_backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
        
        
        [self.bottomView addSubview:_backBtn];
    }
    
    return _backBtn;
}

- (UIButton*)yiGouBtn
{
    if(!_yiGouBtn)
    {
        _yiGouBtn = [[UIButton alloc] init];
        
        _yiGouBtn.backgroundColor = [UIColor clearColor];
        
        _yiGouBtn.frame = CGRectMake(self.view.frame.size.width-57, 10, 57, 35);
        
        [_yiGouBtn setImage:[UIImage imageNamed:@"yigou.png"] forState:UIControlStateNormal];
        [_yiGouBtn setImage:[UIImage imageNamed:@"yigouDown.png"] forState:UIControlStateHighlighted];
        
        [_yiGouBtn addTarget:self action:@selector(goToFirstPage) forControlEvents:UIControlEventTouchUpInside];
        
        [self.bottomView addSubview:_yiGouBtn];
        
    }
    
    return _yiGouBtn;
}

- (void)goToFirstPage
{
    
    [[AppDelegate currentAppDelegate].tabBarViewController setSelectedIndex:0];
    
    [(UINavigationController*)[[AppDelegate currentAppDelegate].tabBarViewController.viewControllers objectAtIndex:0] popToRootViewControllerAnimated:NO];
    
    
}

- (void)backBtnAction
{
    [self backForePage];
}

#pragma mark - action

-(void)leftBtnAction:(UIButton*)button
{
    self.leftBtn.selected=YES;
    self.rightBtn.selected=NO;
    self.selectIndex=1;
    
    [self updateTableView];

}

-(void)rightBtnAction:(UIButton*)button
{
    self.leftBtn.selected=NO;
    self.rightBtn.selected=YES;
    self.selectIndex=2;
    
    [self updateTableView];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.selectIndex==1) {
        return [self.businessCircleList count];
    }else{
        return [self.SARList count];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    } 
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:18];
    
    if (self.selectIndex==1) {
        HotelBusinessCircleDTO *dto=[self.businessCircleList objectAtIndex:indexPath.row];
        cell.textLabel.text =dto.locationName;
    }else{
        HotelSARDTO *dto=[self.SARList objectAtIndex:indexPath.row];
        cell.textLabel.text =dto.locationName;
    }
    return cell;
}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    return self.footView;
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 60;
//}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectIndex==1) {
        HotelBusinessCircleDTO *dto=[self.businessCircleList objectAtIndex:indexPath.row];
        //NSString *cityType=dto.locationId;
        DLog(@"%@%@ %@%@", L(@"BTCommerceCircleChoosePartOne"),dto.locationId,L(@"BTCommerceCircleChoosePartTwo"),dto.locationName);
        //将获取到的位置id反馈给搜索首页
        if ([self.delegate respondsToSelector:@selector(locationID:andLocationName:)]) 
        {
            [self.delegate locationID:dto.locationId andLocationName:dto.locationName];
        }  
        [self dismissModalViewControllerAnimated:YES];
        
        
    }else{
        HotelSARDTO *dto=[self.SARList objectAtIndex:indexPath.row];
        DLog(@"%@%@ %@%@",L(@"BTAdministrativeRegionChoosePartOne"),dto.locationId,L(@"BTAdministrativeRegionChoosePartTwo"),dto.locationName);
        //将获取到的位置id反馈给搜索首页
        if ([self.delegate respondsToSelector:@selector(locationID:andLocationName:)]) 
        {
            [self.delegate locationID:dto.locationId andLocationName:dto.locationName];
        }  
        [self dismissModalViewControllerAnimated:YES];
        
    }
}
- (BOOL)checkHardWareIsSupportCallHotLine
{
    
    BOOL isSupportTel = NO;
    
    NSURL *telURL = [NSURL URLWithString:@"tel://4006766766"];
    
    isSupportTel = [[UIApplication sharedApplication] canOpenURL:telURL];
    
    return isSupportTel;
    
}

- (void)callHotLine
{
    if ([self checkHardWareIsSupportCallHotLine]) {
        
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"tel://4006766766"]]];
        
    }else{
        BBAlertView *alert = [[BBAlertView alloc]
                              initWithTitle:L(@"Tips")
                              message:L(@"Sorry, Unsupport call tel \n hotline:4006766766")
                              delegate:nil
                              cancelButtonTitle:L(@"Ok")
                              otherButtonTitles:nil];             
        [alert show];
    }
}



@end
