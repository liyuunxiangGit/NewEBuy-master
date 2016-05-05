//
//  HotelDetailViewControlller.m
//  SuningEBuy
//
//  Created by robin wang on 7/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HotelDetailViewControlller.h"
#import "HotelOrderSubmitViewController.h"
#import "NewHotelIntroduceViewController.h"

@implementation HotelDetailViewControlller

@synthesize titelView = _titelView;

@synthesize postDto = _postDto;

@synthesize parseDto = _parseDto;

@synthesize itemListArr = _itemListArr;

@synthesize titleBgView= _titleBgView;

@synthesize hotelDetailService = _hotelDetailService;

@synthesize hotelRoomTypeService = _hotelRoomTypeService;

- (id)init
{
    self = [super init];
    
    if (self) {
        
        self.title = L(@"HotelDetail");
        
        self.pageTitle = [NSString stringWithFormat:@"%@-%@%@",L(@"virtual_business"),self.title,L(@"Hotel_Order")];
        
        _itemListArr = [[NSMutableArray alloc] init];
        
        _postDto = [[HotelDataSourceDTO alloc] init];
        
        isLoaderOK = NO;
        
        isRoomTypeOK = NO;
        
    }
    
    return self;
}

- (void)dealloc
{
    TT_RELEASE_SAFELY(_titelView);
    
    // TT_RELEASE_SAFELY(_changeEventSegment);
    
    TT_RELEASE_SAFELY(_parseDto);
    
    TT_RELEASE_SAFELY(_postDto);
    
    TT_RELEASE_SAFELY(_itemListArr);
    
    TT_RELEASE_SAFELY(_titleBgView);
    
    SERVICE_RELEASE_SAFELY(_hotelDetailService);
    
    SERVICE_RELEASE_SAFELY(_hotelRoomTypeService);
    
}

- (void)HttpRelease
{
    DLog(@"Http Release \n");
    
    HTTP_RELEASE_SAFELY(sendCommendASIHTTPRequest);
    
    HTTP_RELEASE_SAFELY(sendRoomTypeASIHTTPRequest);
}


- (void)loadView
{
    [super loadView];
    
    //[self.view addSubview: self.titleBgView];
    
    //self.changeEventSegment.tag = 99;    
    UIView *contentView = self.view;
    
    CGRect frame = contentView.frame;
    
    frame.origin.x = 0;
    frame.origin.y = 120;
    if (IOS7_OR_LATER) {
        frame.size.height = contentView.bounds.size.height - 44-136;
    }else{
        frame.size.height = contentView.bounds.size.height - 44-120;
    }
    
    self.tableView.frame = frame;
    [self.tableView setSeparatorStyle:UITableViewCellSelectionStyleNone];
    self.tableView.backgroundColor=[UIColor whiteColor];
    
    self.hasSuspendButton=YES;
    //
    //    self.tableView.backgroundColor = [UIColor whiteColor];
    //
    //    [self.view addSubview:self.tableView];
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (isRoomTypeOK== NO) {
        [self sendRoomTypeHttpRequest];
    }else {
        if (isLoaderOK== NO) {
            [self sendListHttpRequest];
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
//    self.titelView.changeEventSegment.selectedSegmentIndex = -1;
}

-(HotelIntroduceTitelCell *)titelView
{
    if (_titelView ==nil) {
        
        _titelView  = [[HotelIntroduceTitelCell alloc] initWithFrame:CGRectMake(0, 0, 320, 120)];
        
//        _titelView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
        _titelView.backgroundColor = [UIColor clearColor];
//        [_titelView.changeEventSegment addTarget:self action:@selector(selectChageRange:) forControlEvents:UIControlEventValueChanged];
        
    }
    
    return _titelView;
}

-(HotelInfoService *)hotelDetailService
{
    if(nil == _hotelDetailService)
    {
        _hotelDetailService = [[HotelInfoService alloc] init];
        _hotelDetailService.delegate = self;
    }
    return _hotelDetailService;
}

-(HotelInfoService *)hotelRoomTypeService
{
    if(nil == _hotelRoomTypeService)
    {
        _hotelRoomTypeService = [[HotelInfoService alloc] init];
        _hotelRoomTypeService.delegate = self;
    }
    return _hotelRoomTypeService;
}

//-(void)ChangeSegmentFont:(UIView *)aView
//{
//    if ([aView isKindOfClass:[UILabel class]]) {
//        UILabel *lb = (UILabel    *)aView;
//        [lb setFont:[UIFont boldSystemFontOfSize:13]];
//        [lb setTextAlignment:UITextAlignmentCenter];
//        
//    }
//    NSArray *na = [aView subviews];
//    NSEnumerator *ne = [na objectEnumerator];
//    UIView *subView;
//    while (subView = [ne nextObject]) {
//        [self ChangeSegmentFont:subView];
//    }
//}
-(void)leftBtnAction:(UIButton*)btn
{
    NewHotelIntroduceViewController *nextController = [[NewHotelIntroduceViewController alloc] init];
    nextController.introduceDto = self.parseDto;
    [self.navigationController pushViewController:nextController animated:YES];
    TT_RELEASE_SAFELY(nextController);
}
-(void)centerBtnAction:(UIButton*)btn
{
    HotelFacilityViewController *nextController = [[HotelFacilityViewController alloc] init];
    nextController.postDto = self.parseDto;
    [self.navigationController pushViewController:nextController animated:YES];
    TT_RELEASE_SAFELY(nextController);
}
-(void)rightBtnAction:(UIButton*)btn
{
    if ([self.parseDto.imageUrlList count] <=0) {
        
        //                self.titelView.changeEventSegment.selectedSegmentIndex = -1;
        
        [self presentCustomDlg:L(@"NotHasHotelPhoto")];
        
        return;
    }
    
    MyPhotoSource *source = [[MyPhotoSource alloc] initWithPhotos:self.parseDto.imageUrlList];
    
    EGOPhotoViewController *photoController = [[EGOPhotoViewController alloc] initWithPhotoSource:source];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:photoController];
    
    navController.modalPresentationStyle = UIModalPresentationFullScreen;
    
    if (IOS5_OR_LATER)
    {
        [self presentViewController:navController animated:YES completion:^{
            
            photoController.scrollView.alpha = 1;
            [photoController moveToPhotoAtIndex:0 animated:NO];
        }];
    }
    else
    {
        [self presentModalViewController:navController animated:YES];
        
        photoController.scrollView.alpha = 1;
        [photoController moveToPhotoAtIndex:0 animated:NO];
    }
}
//-(void)selectChageRange:(UISegmentedControl *)send
//{
//    NSInteger inde = [send selectedSegmentIndex];
//    
//    switch (inde) {
//        case 0:
//        {
//            NewHotelIntroduceViewController *nextController = [[NewHotelIntroduceViewController alloc] init];
//            nextController.introduceDto = self.parseDto;
//            [self.navigationController pushViewController:nextController animated:YES];
//            TT_RELEASE_SAFELY(nextController);
//            break;
//        }
//            
//        case 1:
//        {
//            
//            HotelFacilityViewController *nextController = [[HotelFacilityViewController alloc] init];
//            nextController.postDto = self.parseDto;
//            [self.navigationController pushViewController:nextController animated:YES];
//            TT_RELEASE_SAFELY(nextController);
//            break;
//        }
//            
//        case 2:
//        {
//            
//            if ([self.parseDto.imageUrlList count] <=0) {
//                
////                self.titelView.changeEventSegment.selectedSegmentIndex = -1;
//                
//                [self presentCustomDlg:L(@"NotHasHotelPhoto")];
//                
//                return;
//            }
//            
//            MyPhotoSource *source = [[MyPhotoSource alloc] initWithPhotos:self.parseDto.imageUrlList];
//            
//            EGOPhotoViewController *photoController = [[EGOPhotoViewController alloc] initWithPhotoSource:source];
//            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:photoController];
//            
//            navController.modalPresentationStyle = UIModalPresentationFullScreen;
//            
//            if (IOS5_OR_LATER)
//            {
//                [self presentViewController:navController animated:YES completion:^{
//                    
//                    photoController.scrollView.alpha = 1;
//                    [photoController moveToPhotoAtIndex:0 animated:NO];
//                }];
//            }
//            else
//            {
//                [self presentModalViewController:navController animated:YES];
//                
//                photoController.scrollView.alpha = 1;
//                [photoController moveToPhotoAtIndex:0 animated:NO];
//            }
//            
//            break;
//        }
//        default:
//            break;
//    }
//}

#pragma mark -
#pragma mark Http Request

//- (void)sendListHttpRequest
//{
//    [self displayOverFlowActivityView];
//
//    self.tableView.userInteractionEnabled = NO;
//
//    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
//
//    [postDataDic setObject:self.postDto.hotelId forKey:@"hotelId"];
//    [postDataDic setObject:self.postDto.startDate forKey:@"checkInDate"];
//    [postDataDic setObject:self.postDto.endDate forKey:@"checkOutDate"];
//
//    HTTP_RELEASE_SAFELY(sendCommendASIHTTPRequest);
//
//    NSString *url = [NSString stringWithFormat:@"%@/%@", kHostHotelOrderForHttp,KHotelInfoDetail];
//
//    sendCommendASIHTTPRequest = [Http sendHttpRequest:@"get history recharge List"
//                                                  URL:url
//                                           UrlParaDic:postDataDic
//                                             Delegate:self
//                                       SucessCallback:@selector(requestListOk:)
//                                         FailCallback:@selector(requestListFail:)];
//
//    [sendCommendASIHTTPRequest retain];
//
//    TT_RELEASE_SAFELY(postDataDic);
//
//    if (!sendCommendASIHTTPRequest) {
//
//        [self removeOverFlowActivityView];
//
//        self.tableView.userInteractionEnabled = YES;
//
//        return;
//    }
//
//}

- (void)sendListHttpRequest
{
    [self displayOverFlowActivityView];
    
    self.tableView.userInteractionEnabled = NO;
    
    
    [self.hotelDetailService beginHotelDetail:self.postDto.hotelId
                                    startDate:self.postDto.startDate
                                      endDate:self.postDto.endDate];
    
}

-(void)getHotelDetailService:(HotelInfoService *)service Result:(BOOL)isSuccess errorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];
    self.tableView.userInteractionEnabled = YES;
    if(NO == isSuccess)
    {
        isLoaderOK = NO;
        
        [self presentCustomDlg:errorMsg?errorMsg:L(@"Please check your network")];
        
    }
    else
    {
        isLoaderOK = YES;
        
        self.parseDto = service.parseDto;
        
        self.parseDto.imageUrl = self.postDto.productImg;
        
//        self.parseDto.starLevel = self.postDto.starGrade;
        
        [self performSelectorOnMainThread:@selector(refreshTableView) withObject:nil waitUntilDone:YES];
    }
}


- (void)requestListOk:(ASIFormDataRequest *)request
{
    NSDictionary *items = request.jasonItems;
	
	DLog(@"requestMobilePayHistory from server  NSUrlString=%@\n",[items description]);
    
    //[self removeOverFlowActivityView];
    
    isLoaderOK = YES;
    
    self.tableView.userInteractionEnabled = YES;
    
    @autoreleasepool {
    
        [self performSelectorInBackground:@selector(parseHttpRequestList:) withObject:items];
    
    }
    
}

- (void)requestListFail:(ASIFormDataRequest *)request
{
    [self removeOverFlowActivityView];
    
    isLoaderOK = NO;
    
    self.tableView.userInteractionEnabled = YES;
    
    [self presentCustomDlg:L(@"Please check your network")];
    
}

- (void)showInfo:(NSString *)infomation
{
    if (infomation == nil || [infomation isEqualToString:@""])
    {
        [self presentSheet:@"error" posY:80];
        
        return;
    }
    
    [self presentSheet:infomation posY:80];
}

- (void)refreshTableView
{
    [self removeOverFlowActivityView];
    
    if (self.titelView.superview == nil) {
        
        [self.view addSubview: self.titelView];
    }
    
    if (self.tableView.superview == nil)
    {
        
        [self.view addSubview:self.tableView];
    }
    else
    {
        self.titelView.merchItemDTO= self.parseDto;
        
        [self.titelView.leftBtn addTarget:self action:@selector(leftBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.titelView.centerBtn addTarget:self action:@selector(centerBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.titelView.rightBtn addTarget:self action:@selector(rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        self.tableView.top = self.titelView.bottom;
        
        
        if (isLoaderOK ==YES) {
            NSString *title = [NSString stringWithFormat:@"%@(%d)", L(@"photoes"),[self.parseDto.imageUrlList count]];
            
//            [self.titelView.changeEventSegment setTitle:title forSegmentAtIndex:2];
            [self.titelView.rightBtn setTitle:title forState:UIControlStateNormal];
            [self.titelView.rightBtn setTitle:title forState:UIControlStateSelected];
        }
        
        [self.tableView reloadData];
    }
    
    
    
}

- (void)parseHttpRequestList:(NSDictionary *)items
{
    if (IsNilOrNull(items))
    {
        return;
    }
    
    NSDictionary *hotelInfoDic = [items objectForKey:@"hotelInfo"];
    
    if (hotelInfoDic ==nil) {
        return;
    }
    
    HotelIntroduceDTO *tempDto = [[HotelIntroduceDTO alloc] init];
    
    [tempDto encodeFromDictionary:hotelInfoDic];
    
    self.parseDto = tempDto;
    
    self.parseDto.imageUrl = self.postDto.productImg;
    self.parseDto.starLevel = self.postDto.starGrade;
    
    
    
    [self performSelectorOnMainThread:@selector(refreshTableView) withObject:nil waitUntilDone:YES];
}

#pragma mark -
#pragma mark Table View Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.itemListArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HotelDetalRoomTypeDTO *tempDto = [self.itemListArr objectAtIndex:indexPath.row];
    
    return [HotelDetalRoomTypeCell height: tempDto];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CustomCellIdentifier = @"CustomCellIdentifier";
    
    HotelDetalRoomTypeCell *cell = (HotelDetalRoomTypeCell *)[tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    
    if(cell == nil){
        
        cell = [[HotelDetalRoomTypeCell alloc]initWithReuseIdentifier:CustomCellIdentifier];
        
        cell.accessoryType =UITableViewCellAccessoryNone;
    }
//    UIView* bgView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];//ios6设置白底
//    [bgView setBackgroundColor:[UIColor whiteColor]];
//    [cell.contentView addSubview:bgView];
//    TT_RELEASE_SAFELY(bgView);
    
    HotelDetalRoomTypeDTO *tempDto = [self.itemListArr objectAtIndex: indexPath.row];
    
    if (tempDto ==nil) {
        return nil;
    }
    
    cell.merchItemDTO = tempDto;
    
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HotelDetalRoomTypeDTO *tempDto = [self.itemListArr objectAtIndex: indexPath.row];
    
    if (![tempDto.status isEqualToString:@"0"]) {
        
        [self presentSheet:L(@"Sorry,room is full!")];
        return;
    }
    
    self.postDto.roomTypeId = tempDto.uid;
    self.postDto.ratePlanId = tempDto.ratePlanId;
    self.postDto.roomTypeName = tempDto.name;
    self.postDto.totalPrice = tempDto.price;
	HotelOrderSubmitViewController *next = [[HotelOrderSubmitViewController alloc] init];
    next.datasource = self.postDto;
    
    [self.navigationController pushViewController: next animated:YES];
    
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//room type::
//- (void)sendRoomTypeHttpRequest
//{
//    [self displayOverFlowActivityView];
//
//    self.tableView.userInteractionEnabled = NO;
//
//    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
//
//    [postDataDic setObject:self.postDto.hotelId forKey:@"hotelId"];
//    [postDataDic setObject:self.postDto.startDate forKey:@"checkInDate"];
//    [postDataDic setObject:self.postDto.endDate forKey:@"checkOutDate"];
//
//    HTTP_RELEASE_SAFELY(sendRoomTypeASIHTTPRequest);
//
//    NSString *url = [NSString stringWithFormat:@"%@/%@", kHostHotelOrderForHttp,KHotelInfoRatePlans];
//    // NSString *url = [NSString stringWithFormat:@"%@", kHostHotelOrderForHttp];
//
//    sendRoomTypeASIHTTPRequest = [Http sendHttpRequest:@"get room type List"
//                                                  URL:url
//                                           UrlParaDic:postDataDic
//                                             Delegate:self
//                                       SucessCallback:@selector(requestRoomTypeOk:)
//                                         FailCallback:@selector(requestRoomTypeFail:)];
//
//    [sendRoomTypeASIHTTPRequest retain];
//
//    TT_RELEASE_SAFELY(postDataDic);
//
//    if (!sendRoomTypeASIHTTPRequest) {
//
//        [self removeOverFlowActivityView];
//
//        self.tableView.userInteractionEnabled = YES;
//
//        return;
//    }
//
//}

- (void)sendRoomTypeHttpRequest
{
    [self displayOverFlowActivityView];
    
    self.tableView.userInteractionEnabled = NO;
    
    [self.hotelRoomTypeService  beginRoomType:self.postDto.hotelId
                                    startDate:self.postDto.startDate
                                      endDate:self.postDto.endDate];
    
}

-(void)getHotelRoomTypeService:(HotelInfoService *)service Result:(BOOL)isSuccess errorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];
    self.tableView.userInteractionEnabled = YES;
    if(NO == isSuccess)
    {
        isRoomTypeOK = NO;
        
        [self presentCustomDlg:errorMsg?errorMsg:L(@"Please check your network")];
        
        return;
    }
    else
    {
        self.itemListArr = service.itemListArr;
        isRoomTypeOK = YES;
        if ([self.itemListArr count] <=0)
        {
            
            [self presentCustomDlg:L(@"tempNotHasRoom")];
            
            [self performSelectorOnMainThread:@selector(refreshTableView) withObject:nil waitUntilDone:YES];
            if (isLoaderOK== NO) {
                [self sendListHttpRequest];
            }
            
            return;
        }
        
        if (isLoaderOK== NO) {
            [self sendListHttpRequest];
        }
        
        [self performSelectorOnMainThread:@selector(refreshTableView) withObject:nil waitUntilDone:YES];
        
    }
    
}



- (void)requestRoomTypeOk:(ASIFormDataRequest *)request
{
    NSDictionary *items = request.jasonItems;
    
    isRoomTypeOK = YES;
	
	DLog(@"requestMobilePayHistory from server  NSUrlString=%@\n",[items description]);
    
    //[self removeOverFlowActivityView];
    if (isLoaderOK== NO) {
        [self sendListHttpRequest];
    }
    
    self.tableView.userInteractionEnabled = YES;
    
    @autoreleasepool {
    
        [self performSelectorInBackground:@selector(parseHttpRequestRoomType:) withObject:items];
    
    }
    
}

- (void)requestRoomTypeFail:(ASIFormDataRequest *)request
{
    [self removeOverFlowActivityView];
    
    isRoomTypeOK = NO;
    
    self.tableView.userInteractionEnabled = YES;
    
    [self presentCustomDlg:L(@"Please check your network")];
    
}

- (NSString *)trimString:(NSString *)beforeString{
    
    NSString *endString = [[beforeString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] replacedWhiteSpacsByString:@""];
    return endString;
}

- (void)parseHttpRequestRoomType:(NSDictionary *)items
{
    if (IsNilOrNull(items))
    {
        return;
    }
    
    NSNumber *status =  [items objectForKey:@"resultCode"];
    if ((status !=nil) && ([[status stringValue] isEqualToString:@"1"] ==YES)) {
        //[self presentCustomDlg:[items objectForKey:@"resultMessage"]];
        [self presentCustomDlg:L(@"load_failed")];
        return;
        
    }
    
    
    NSDictionary *hotelDic = [items objectForKey:@"hotel"];
    
    NSMutableArray *itemArray = [hotelDic objectForKey:@"YlRooms"];
    
    if ([itemArray count] <=0) {
        
        [self presentCustomDlg:L(@"tempNotHasRoom")];
        
        [self performSelectorOnMainThread:@selector(refreshTableView) withObject:nil waitUntilDone:YES];
        
        return;
    }
    
    for (NSDictionary *tempDic in itemArray) {
        
        NSMutableArray *roomTypeArray = [tempDic objectForKey:@"ratePlans"];
        
        NSString *roomTypeName = [tempDic objectForKey:@"roomTypeName"];
        
        NSString *roomTypeDesc =  [tempDic objectForKey:@"bedDescription"];
        
        NSString *areas = [tempDic objectForKey:@"area"];
        
        NSString *floors = [tempDic objectForKey:@"floor"];
        
        for (NSDictionary *roomTypeDic in roomTypeArray) {
            {
                HotelDetalRoomTypeDTO *dto = [[HotelDetalRoomTypeDTO alloc]init];
                
                [dto encodeFromDictionary:roomTypeDic];
                
                if (NotNilAndNull(roomTypeName)) {
                    dto.name = roomTypeName;
                }
                
                if (NotNilAndNull(roomTypeDesc)) {
                    dto.discribe = roomTypeDesc;
                }
                
                if (NotNilAndNull(areas)) {
                    dto.area = areas;
                }
                
                if (NotNilAndNull(floors)) {
                    dto.floor = floors;
                }
                
                [self.itemListArr addObject: dto];
                
                
            }    
            
        }
        
    }   
    [self performSelectorOnMainThread:@selector(refreshTableView) withObject:nil waitUntilDone:YES];
}

@end
