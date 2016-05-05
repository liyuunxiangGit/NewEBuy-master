//
//  QueryPlaneViewController.m
//  SuningEBuy
//
//  Created by lanfeng on 12-5-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "QueryPlaneViewController.h"
#import "TPKeyboardAvoidingTableView.h"
#import "ChooseDate.h"

@interface QueryPlaneViewController()

- (void)registerKVO;
- (void)unRegisterKVO;

@end

/*********************************************************************/


@implementation QueryPlaneViewController

@synthesize segement = _segement;
@synthesize footView = _footView;
@synthesize queryBtn  = _queryBtn;
@synthesize queryDate = _queryDate;

@synthesize itemsArray = _itemsArray;
@synthesize itemsValueArray = _itemsValueArray;
@synthesize beginDate = _beginDate;
@synthesize backDate = _backDate;

- (void)dealloc {
    
    TT_RELEASE_SAFELY(_segement);
    TT_RELEASE_SAFELY(_footView);
    TT_RELEASE_SAFELY(_queryBtn);
    TT_RELEASE_SAFELY(_itemsArray);
    TT_RELEASE_SAFELY(_itemsValueArray);
    TT_RELEASE_SAFELY(_queryDate);
    TT_RELEASE_SAFELY(_beginDate);
    TT_RELEASE_SAFELY(_backDate);
    
    [self unRegisterKVO];
    
    [super dealloc];
}

- (id)init {
    self = [super init];
    if (self)
    {
        self.title = L(@"Plane Query Title");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"virtual_business"),self.title];
        NSMutableArray *tempArray = [[NSMutableArray alloc]initWithObjects:L(@"BTOriginalCity"),L(@"BTArriveCity"),L(@"BTOriginalDate"),L(@"BTBackDate"), nil];
        self.itemsArray = tempArray;
        TT_RELEASE_SAFELY(tempArray);
        
        NSMutableArray *tempArray2 = [[NSMutableArray alloc]initWithObjects:[Config currentConfig].businessFromCity,[Config currentConfig].businessToCity,@"",@"", nil];
        self.itemsValueArray = tempArray2;
        TT_RELEASE_SAFELY(tempArray2);
        
        isRoundTripTicket = NO;
        
        NSDate *today = [NSDate date];
        CFAbsoluteTime abTime = CFDateGetAbsoluteTime((CFDateRef)today);
        CFTimeZoneRef timeZone = CFTimeZoneCopyDefault();
        CFGregorianDate gDate = CFAbsoluteTimeGetGregorianDate(abTime, timeZone);
        gDate.hour = 0, gDate.minute = 0; gDate.second = 1;
        CFAbsoluteTime beginABTime = CFGregorianDateGetAbsoluteTime(gDate, timeZone);
        CFRelease(timeZone);
        CFDateRef beginDateRef = CFDateCreate(kCFAllocatorDefault, beginABTime);

        self.beginDate = (NSDate *)beginDateRef;
        TT_RELEASE_SAFELY(beginDateRef);
        
        self.backDate = [NSDate dateWithTimeInterval:24*3600 sinceDate:self.beginDate];
        
        [self registerKVO];
    }
    return self;
}

#pragma mark - View lifecycle


- (void)loadView
{
    [super loadView];
	   
    self.hasSuspendButton = YES;
    
    [self.view addSubview:self.segement];
    
    CGRect frame = [self visibleBoundsShowNav:YES showTabBar:NO];
    
    frame.origin.y += 40;
    
    frame.size.height-=40;
    
	self.tpTableView.frame = frame;
	
	[self.view addSubview:self.tpTableView];
}

#pragma mark - UIView

- (UITableView *)tpTableView
{
	if(!tpTableView_)
    {
		
		tpTableView_ = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectZero
                                                                    style:UITableViewStylePlain];
        
		[tpTableView_ setSeparatorStyle:UITableViewCellSeparatorStyleNone];
		
		[tpTableView_ setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
		
		tpTableView_.scrollEnabled = YES;
		
		tpTableView_.userInteractionEnabled = YES;
		
		tpTableView_.delegate =self;
		
		tpTableView_.dataSource =self;
		
		tpTableView_.backgroundColor =[UIColor clearColor];
        
        tpTableView_.backgroundView = nil;
	}
	
	return tpTableView_;
}

#pragma mark -
#pragma mark 顶部的tab切
-(PlaneSegement *)segement{
    
    if (_segement == nil) {
        _segement = [[PlaneSegement alloc]initWithLeftItem:L(@"BTSingleTicket") rightItem:L(@"BTRoundTripTicket")];
        _segement.frame = CGRectMake(0, 0, 320, 40);
        _segement.delegate = self;
    }
    return _segement;
}

-(void)planeSegement:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0) {
        
        isRoundTripTicket = NO;
    }else{
        isRoundTripTicket = YES;
    }
    
    [self.tpTableView reloadData];
}



-(UIView *)footView{
    
    if (_footView == nil) {
        _footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
        _footView.backgroundColor = [UIColor clearColor];
        [_footView addSubview:self.queryBtn];
    }
    return _footView;
}

- (UIButton *)queryBtn
{
    if (!_queryBtn)
    {
        _queryBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 20, 280, 35)];
        [_queryBtn addTarget:self action:@selector(presentViewController) forControlEvents:UIControlEventTouchUpInside];
        
        [_queryBtn setTitle:L(@"Plane Query") forState:UIControlStateNormal];
        _queryBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
        [_queryBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        UIImage *image = [UIImage imageNamed:@"submit_button_normal.png"];
        [_queryBtn setBackgroundImage:image forState:UIControlStateNormal];
        
        UIImage *image1 = [UIImage imageNamed:@"submit_button_touched.png"];
        [_queryBtn setBackgroundImage:image1 forState:UIControlStateHighlighted];

    }
    return _queryBtn;
}



-(void)presentViewController{
    
    QueryConditionDTO *dto = [[QueryConditionDTO alloc]init];
    
    dto.orgCity = [self.itemsValueArray objectAtIndex:0];
    dto.desCity = [self.itemsValueArray objectAtIndex:1];

    dto.orgTime = [NSDate stringFromDate:self.beginDate withFormat:@"yyyy-MM-dd"];
    dto.returnTime = [NSDate stringFromDate:self.backDate withFormat:@"yyyy-MM-dd"];

    
    NSString *errorMSG = nil;
    
    if ([dto.orgCity isEqualToString:@""]) {
        errorMSG = @"Please Choose Origin City";
        goto finally;
    }else {
        [Config currentConfig].businessFromCity = dto.orgCity;
    }
    
    if ([dto.desCity isEqualToString:@""]) {
        errorMSG = @"Please Choose Destination City";
        goto finally;
    }else{
        [Config currentConfig].businessToCity = dto.desCity;
    }
    
    if ([dto.orgCity isEqualToString:dto.desCity]) {
        errorMSG = @"Can Not Choose The Same City";
        goto finally;
    }
    
    if ([dto.orgTime isEqualToString:@""]) {
        errorMSG = @"Please Choose Start Time";
        goto finally;
    }
    
    if ([dto.returnTime isEqualToString:@""] && isRoundTripTicket) {
        errorMSG = @"Please Choose Return Time";
        goto finally;
        
    }else if(isRoundTripTicket){
        
        dto.isRoundTicket = YES;
        NSArray *orgArray = [dto.orgTime componentsSeparatedByString:@"-"];
        NSArray *desArray = [dto.returnTime componentsSeparatedByString:@"-"];
        int     orgYear  = [[orgArray objectAtIndex:0]intValue];
        int     orgMonth = [[orgArray objectAtIndex:1]intValue];
        int     orgDay   = [[orgArray objectAtIndex:2]intValue];
        int     desYear  = [[desArray objectAtIndex:0]intValue];
        int     desMonth = [[desArray objectAtIndex:1]intValue];
        int     desDay   = [[desArray objectAtIndex:2]intValue];
        
        /*************时间判断************/
        if (orgYear > desYear) {
            errorMSG = @"ChooseReturnTimeError";
            goto finally;
        }else if(orgYear == desYear){
            if (orgMonth > desMonth) {
                errorMSG = @"ChooseReturnTimeError";
                goto finally;
            }else if(orgMonth == desMonth){
                if (orgDay > desDay) {
                    errorMSG = @"ChooseReturnTimeError";
                    goto finally;
                }
            }
        }
        /*************时间判断************/
    }
    
    //页面跳转
    self.hidesBottomBarWhenPushed = YES;
    FlightListViewController *flightListViewController = [[FlightListViewController alloc]initWithQueryDTO:dto];
    [self.navigationController pushViewController:flightListViewController animated:YES];
    TT_RELEASE_SAFELY(flightListViewController);
    TT_RELEASE_SAFELY(dto);
    return;
    
finally:
    TT_RELEASE_SAFELY(dto);
    [self presentSheet:L(errorMSG) posY:100];
    
}


#pragma mark - TableView

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (section == 1)
    {
        return self.footView;
    }
    
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1)
    {
        return 60;
    }
    return 0.0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 1) {
        if (isRoundTripTicket) {
            return 2;
        }else{
            return 1;
        }
    }
    
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   return  [QueryPlaneCell height:indexPath.row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0)
    {
        static NSString *citySelectCell = @"citySelectCell";
        
        QueryPlaneCell *cell = [tableView dequeueReusableCellWithIdentifier:citySelectCell];
        
        if (cell == nil)
        {
            cell = [[[QueryPlaneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:citySelectCell] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        NSString *des = [self.itemsArray objectAtIndex:indexPath.row];
        
        NSString *value = [self.itemsValueArray objectAtIndex:indexPath.row];
        
        [cell setItem:indexPath.row leftItem:des rightItem:value];
        
        return cell;
    }
    
    
    static NSString *timeSelectCell = @"timeSelectCell";
    
    QueryPlaneCell *cell = [tableView dequeueReusableCellWithIdentifier:timeSelectCell];
    
    if (cell == nil)
    {
        cell = [[[QueryPlaneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:timeSelectCell] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (indexPath.row == 0) {
        
        NSString *beginTime = [NSDate stringFromDate:self.beginDate withFormat:@"yyyy-MM-dd"];
        [cell setItem:indexPath.row leftItem:L(@"BTOriginalDate") rightItem:beginTime];
    }else{
        NSString *backTime = [NSDate stringFromDate:self.backDate withFormat:@"yyyy-MM-dd"];
        [cell setItem:indexPath.row leftItem:L(@"BTBackDate") rightItem:backTime];
    }
    
    return cell;
    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0)
    {
        CityListViewController *cityListViewController = [[CityListViewController alloc]init];
        cityListViewController.delegate = self;
        
        if (indexPath.row == 0){
            cityListViewController.view.tag = 0;
        }
        else if(indexPath.row == 1){
            cityListViewController.view.tag = 1;
        }
        AuthManagerNavViewController *nav = [[AuthManagerNavViewController alloc] initWithRootViewController:cityListViewController];
        [self.navigationController presentModalViewController:nav animated:YES];
        TT_RELEASE_SAFELY(cityListViewController);
        
    }else{
        
        if (indexPath.row == 0) {
            NSString* str = [NSString stringWithFormat:@"%@%@",L(@"BTFlight"),L(@"ChooseStartTime")];
            CalendarViewController *calendarViewController = [[CalendarViewController alloc] initWithNavigationItemTitle:str];
            calendarViewController.calendarViewControllerDelegate = self;
            calendarViewController.view.tag = 0;
            calendarViewController.calendarView.disableBeginDate =
            [NSDate date];
            calendarViewController.calendarView.disableEndDate =
            [NSDate dateWithTimeIntervalSinceNow:364*24*3600];
            
            if (self.beginDate) {
                CFAbsoluteTime currentTime = CFDateGetAbsoluteTime((CFDateRef)self.beginDate);
                CFTimeZoneRef timeZone = CFTimeZoneCopyDefault();
                CFGregorianDate currentDate = CFAbsoluteTimeGetGregorianDate(currentTime, timeZone);
                CFRelease(timeZone);
                calendarViewController.calendarView.currentMonthDate = currentDate;
            }
            
            AuthManagerNavViewController *nav = [[AuthManagerNavViewController alloc] initWithRootViewController:calendarViewController];
            
            [self.navigationController presentModalViewController:nav animated:YES];
            TT_RELEASE_SAFELY(calendarViewController);
            [nav release];
            
        }else{
            NSString* str = [NSString stringWithFormat:@"%@%@",L(@"BTFlight"),L(@"ChooseReturnTime")];
            CalendarViewController *calendarViewController = [[CalendarViewController alloc]initWithNavigationItemTitle:str];
            calendarViewController.calendarViewControllerDelegate = self;
            calendarViewController.view.tag = 1;
            calendarViewController.calendarView.disableBeginDate =
            self.beginDate;
            calendarViewController.calendarView.disableEndDate =
            [NSDate dateWithTimeIntervalSinceNow:364*24*3600];
            
            if (self.backDate) {
                CFAbsoluteTime currentTime = CFDateGetAbsoluteTime((CFDateRef)self.backDate);
                CFTimeZoneRef timeZone = CFTimeZoneCopyDefault();
                CFGregorianDate currentDate = CFAbsoluteTimeGetGregorianDate(currentTime, timeZone);
                CFRelease(timeZone);
                calendarViewController.calendarView.currentMonthDate = currentDate;
            }
            
            AuthManagerNavViewController *nav = [[AuthManagerNavViewController alloc] initWithRootViewController:calendarViewController];
            
            [self.navigationController presentModalViewController:nav animated:YES];
            TT_RELEASE_SAFELY(calendarViewController);
            [nav release];
        }
    }
}


#pragma mark CityListViewControllerProtocol delegate

- (void) citySelectionUpdate:(NSString*)selectedCity andViewController:(id)controller
{
    NSInteger tag = 0;
    
    if([controller isKindOfClass:NSClassFromString(@"CityListViewController")]){
        CityListViewController *tempController = (CityListViewController *)controller;
        tag = tempController.view.tag;
    }
    if (tag == 0) {
        NSString *tempString = [NSString stringWithFormat:@"%@",selectedCity];
        
        NSString *currCity = [self.itemsValueArray objectAtIndex:1];
        if (![tempString isEqualToString:currCity]) {
            [self.itemsValueArray replaceObjectAtIndex:0 withObject:tempString];
          //  [Config currentConfig].businessFromCity = tempString;
        }
        else{
            
            [self presentCustomDlg:L(@"BTStartAndArriveCanNotBeSameCity")];
        }
        
    }else{
        
        NSString *tempString = [NSString stringWithFormat:@"%@",selectedCity];
        NSString *currCity = [self.itemsValueArray objectAtIndex:0];
        if (![tempString isEqualToString:currCity]) {
            [self.itemsValueArray replaceObjectAtIndex:1 withObject:tempString];
         //   [Config currentConfig].businessToCity = tempString;
        }else{
            [self presentCustomDlg:L(@"BTStartAndArriveCanNotBeSameCity")];
        }
    }
    
    [self.tpTableView reloadData];
    
}


- (NSString*) getDefaultCity
{
    return L(@"GBChooseCity");
}


#pragma mark - CalendarViewControllerDelegate

- (void) selectDateChanged:(CFGregorianDate) selectDate andViewController:(id)controller{
    
    CFTimeZoneRef timeZone = CFTimeZoneCopyDefault();
    CFAbsoluteTime abTime = CFGregorianDateGetAbsoluteTime(selectDate, timeZone);
    CFAllocatorRef allocator = CFAllocatorGetDefault();
    CFDateRef date = CFDateCreate(allocator, abTime);
    CFRelease(timeZone);
    
 
    NSInteger tag = 0;
    
    if([controller isKindOfClass:NSClassFromString(@"CalendarViewController")]){
        CalendarViewController *tempController = (CalendarViewController *)controller;
        tag = tempController.view.tag;
    }
    
    if (tag == 0)
    {
        self.beginDate = (NSDate *)date;
        
    }else{
        
        self.backDate = (NSDate *)date;
    }
    
    TT_RELEASE_SAFELY(date);
    
    [self.tpTableView reloadData];
}

#pragma mark -
#pragma mark KVO

- (NSArray *)observersOfKVO
{
    return [NSArray arrayWithObjects:@"beginDate", nil];
}

- (void)registerKVO
{
    for (NSString *keyPath in [self observersOfKVO])
    {
        [self addObserver:self
               forKeyPath:keyPath
                  options:NSKeyValueObservingOptionNew
                  context:NULL];
    }
}

- (void)unRegisterKVO
{
    for (NSString *keyPath in [self observersOfKVO])
    {
        [self removeObserver:self forKeyPath:keyPath];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"beginDate"]) {
        
        NSComparisonResult comRes = [self.backDate compare:self.beginDate];
        if (comRes == NSOrderedAscending || comRes == NSOrderedSame) {
            
            NSTimeInterval times = [self.beginDate timeIntervalSinceDate:[NSDate date]];
            
            if (times >= 24*3600*363) {
                self.backDate = self.beginDate;
            }else{
                self.backDate = [NSDate dateWithTimeInterval:24*3600 sinceDate:self.beginDate];
            }
        }
    }
}

@end
