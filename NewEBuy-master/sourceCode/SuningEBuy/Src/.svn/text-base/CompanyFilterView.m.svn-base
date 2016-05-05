//
//  CompanyFilterView.m
//  SuningEBuy
//
//  Created by shasha on 12-5-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CompanyFilterView.h"
#import "CompanyFilterCell.h"
#import "ChooseDate.h"
#import "ImageManipulator.h"


@implementation CompanyFilterView

@synthesize backButon = _backButon;
@synthesize backGroudView = _backGroudView;

@synthesize tableBackView = _tableBackView;
@synthesize companyFilterTableView = _companyFilterTableView;

@synthesize companyList = _companyList;
@synthesize companyId = _companyId;

@synthesize timeButton  = _timeButton;
@synthesize backDayButton = _backDayButton;
@synthesize nextDayButtton = _nextDayButtton;

@synthesize filterDelegate = _filterDelegate;

@synthesize queryDTO = _queryDTO;


- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}


- (void)dealloc {
    
    TT_RELEASE_SAFELY(_companyFilterTableView);
    TT_RELEASE_SAFELY(_tableBackView);
    TT_RELEASE_SAFELY(_companyList);
    TT_RELEASE_SAFELY(_backButon);
    TT_RELEASE_SAFELY(_companyId);
    TT_RELEASE_SAFELY(_timeButton);
    TT_RELEASE_SAFELY(_backDayButton);
    TT_RELEASE_SAFELY(_nextDayButtton);
    TT_RELEASE_SAFELY(_queryDTO);
    
}

- (void)setCompanyList:(NSArray *)companyList{
    //0,45,320,323

    if (_companyList != companyList) {
        
        TT_RELEASE_SAFELY(_companyList);
        
        _companyList = companyList;
                
        [self.companyFilterTableView reloadData];
        
        [self setNeedsLayout]; 
        
    }
}


- (void)setQueryDTO:(QueryConditionDTO *)queryDTO{

    if (_queryDTO != queryDTO ) {
        
        TT_RELEASE_SAFELY(_queryDTO);
        
        _queryDTO = queryDTO;
        
        [self.timeButton setTitle:self.queryDTO.orgTime forState:UIControlStateNormal];        
     
        [self changeTime:self.queryDTO.orgTime];
        
    }

}

- (void)layoutSubviews{

    self.backButon.frame = CGRectMake(0, 0, self.width, self.height);

    self.backGroudView.frame = CGRectMake(30, (self.height-320)/2.0, 260, 260);

    self.backDayButton.frame = CGRectMake(10, 5, 50, 30);

    self.timeButton.frame = CGRectMake(self.backDayButton.right+25 , 5, 90, 30);

    self.nextDayButtton.frame = CGRectMake(self.timeButton.right+25, 5, 50, 30);
    
    self.tableBackView.frame = CGRectMake(0, 40, 260, 220);
    
    self.companyFilterTableView.frame = CGRectMake(0, 0, 260, 220);
}


#pragma mark - 
#pragma mark TableView Delegate Datasource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    if (!IsNilOrNull(self.companyList)) {
        
        DLog(@"%d", [self.companyList count]);
        
        return 1;
        
    }else{
        
        return 0;
        
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!IsNilOrNull(self.companyList)) {
        
        DLog(@"%d", [self.companyList count]);
        
        return [self.companyList count]+1;
        
    }else{
        
        return 0;
        
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (!IsNilOrNull(self.companyList)) {
        
        DLog(@"%d", [self.companyList count]);
        
        return 44;
        
    }else{
    
        return 0;
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *compayListCell = @"compayListCell";
    
    CompanyFilterCell  *cell = [tableView dequeueReusableCellWithIdentifier:compayListCell];
    
    if (cell == nil)
    {
        cell = [[CompanyFilterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:compayListCell];
        
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    if (indexPath.row == 0) {
        
        CompanyDTO *dto = [[CompanyDTO alloc] init];
        
        dto.airCompanyId = @"";
        
        dto.airCompanyShortName = L(@"BTIrrestriction");
        
        [cell setItem: dto];
        
        TT_RELEASE_SAFELY(dto);
        
    }else{
        
        CompanyDTO *dto = [self.companyList objectAtIndex:indexPath.row - 1];
        
        [cell setItem: dto];

    }
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        self.companyId = @"";
        
    }else{
    
        CompanyDTO *dto = [self.companyList objectAtIndex:indexPath.row-1];
        
        if (IsNilOrNull(dto)) {
            
            return;
            
        }
        
        self.companyId = dto.airCompanyId;

    }
    
    DLog(@"%@", self.companyId);
    
    if ([self.filterDelegate conformsToProtocol:@protocol(CompanyFilterViewDelegate)])
    {
        if ([self.filterDelegate respondsToSelector:@selector(chooseCompanyFilter:)])
        {
                        
            [self.filterDelegate chooseCompanyFilter:self.companyId];
            
        }
    }
    
    [self removeFromSuperview];

}

- (void)companyViewDisappear:(id)sender{

    [self removeFromSuperview];

}


#pragma mark - 
#pragma mark Button Action Methods


- (void)getNextDate:(id)sender{
    
    NSDate *todayDate = [ChooseDate dateFromString:self.timeButton.titleLabel.text withFormatString:@"yyyy-MM-dd"];
    
    NSDate *tommorowDate = [ChooseDate getTomorowDate:todayDate];
    
    NSString *str = [ChooseDate stringFromDate:tommorowDate withFormatString:@"yyyy-MM-dd"];
    
    [self changeTime:str];
    
    TT_RELEASE_SAFELY(todayDate);
    
    [self sendProductDetailHttpReqeust];
    
}


- (void)getBackDate:(id)sender{
    
    NSDate *todayDate = [ChooseDate dateFromString:self.timeButton.titleLabel.text withFormatString:@"yyyy-MM-dd"];
    
    NSDate *yesterDayDate = [ChooseDate getYesterdayDate:todayDate];
    
    NSString *str = [ChooseDate stringFromDate:yesterDayDate withFormatString:@"yyyy-MM-dd"];
    
    [self changeTime:str];
    
    TT_RELEASE_SAFELY(todayDate);
    
    [self sendProductDetailHttpReqeust];
    
}


//验证时间时间是否符合搜索的条件
- (void)changeTime:(NSString *)dateStr{
    
    NSDate *nextLimitDate = [ChooseDate getDateOfFewDays:363];
    
    NSString *backLmitDate = [ChooseDate stringFromDate:[NSDate date] withFormatString:@"yyyy-MM-dd"];
    
    //如果搜索的时间大于今天的时间加上364天，那么不可以请求。
    if ([[nextLimitDate earlierDate:[ChooseDate dateFromString:dateStr withFormatString:@"yyyy-MM-dd"]] isEqualToDate:nextLimitDate]) {
        
        self.nextDayButtton.enabled = NO;
        self.nextDayButtton.isSelected = YES;
        self.nextDayButtton.isIndicatorUp = NO;
        
    }else{
        
        self.nextDayButtton.enabled = YES;
        self.nextDayButtton.isSelected = NO;
        self.nextDayButtton.isIndicatorUp = YES;
        [self.timeButton setTitle:dateStr forState:UIControlStateNormal];
        self.queryDTO.orgTime = dateStr;
        
    }
    
    //如果搜索的时间小于当天的时间，不可以请求数据。
    if ([backLmitDate isEqualToString:dateStr]||[[[NSDate date]  earlierDate:[ChooseDate dateFromString:dateStr withFormatString:@"yyyy-MM-dd"] ]isEqualToDate:[ChooseDate dateFromString:dateStr withFormatString:@"yyyy-MM-dd"]]) {
        
        self.backDayButton.enabled = NO;
        self.backDayButton.isSelected = YES;
        self.backDayButton.isIndicatorUp = NO;
        
    }else{
        
        self.backDayButton.enabled = YES;
        self.backDayButton.isSelected = NO;
        self.backDayButton.isIndicatorUp = YES;
        
        [self.timeButton setTitle:dateStr forState:UIControlStateNormal];
        self.queryDTO.orgTime = dateStr;
        
    }
    
}

- (void)sendProductDetailHttpReqeust{
    
    if ([self.filterDelegate conformsToProtocol:@protocol(CompanyFilterViewDelegate)])
    {
        if ([self.filterDelegate respondsToSelector:@selector(chooseFlightDate)])
        {
            //发送通知：调用主页面的sendHttp请求，重新布局页面
            [self.filterDelegate chooseFlightDate];
            
        }
    }
    
    [self removeFromSuperview];
    
}

#pragma mark - 
#pragma mark Customize UI Methods


- (UIButton *)backButon{
    
    if (!_backButon ) {
        
        _backButon = [[UIButton alloc] init];
        
        _backButon.backgroundColor = [UIColor colorWithRed:27/255 green:27/255 blue:27/255 alpha:0.5];
        
        [_backButon addTarget:self action:@selector(companyViewDisappear:) forControlEvents:UIControlEventTouchDown];
        
        [self addSubview:_backButon];
        
    }
    
    return _backButon;
    
}


-(UIImageView *)backGroudView{

    if (!_backGroudView) {

        _backGroudView = [[UIImageView alloc] init];
        
        _backGroudView.backgroundColor = [UIColor whiteColor];
        
        _backGroudView.userInteractionEnabled = YES;
        
        [self.backButon addSubview:_backGroudView];
        
    }
    
    return _backGroudView;

}

-(UIView *)tableBackView{
    if (!_tableBackView) {
        _tableBackView = [[UIView alloc]init];
        _tableBackView.backgroundColor = RGBCOLOR(247, 247, 247);
        [self.backGroudView addSubview:_tableBackView];
    }
    return _tableBackView;
}


- (UITableView *)companyFilterTableView{
    
    if (!_companyFilterTableView ) {
        
        
		_companyFilterTableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                               style:UITableViewStylePlain];    
						
		_companyFilterTableView.userInteractionEnabled = YES;
		
		_companyFilterTableView.delegate =self;
        
        _companyFilterTableView.dataSource = self;
        		
		_companyFilterTableView.backgroundColor = [UIColor clearColor];
        
        [self.tableBackView addSubview:_companyFilterTableView];
        
    }
    
    return _companyFilterTableView;
    
}



-(IndicatorButton *)timeButton{
    
    if (!_timeButton ) {
        
        _timeButton = [[IndicatorButton alloc] initWithFrame:CGRectZero];
        
        [_timeButton setTitle:L(@"chooseTime") forState:UIControlStateNormal];
        
        [_timeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        _timeButton.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:14];
        
        _timeButton.titleLabel.textAlignment = UITextAlignmentCenter;
        
        _timeButton.enabled = NO;
        
        [self.backGroudView addSubview:_timeButton];
    }
    
    return _timeButton;
    
}

-(IndicatorButton *)nextDayButtton{
    
    if (!_nextDayButtton ) {
        
        _nextDayButtton = [[IndicatorButton alloc] initWithFrame:CGRectZero];
                
        [_nextDayButtton addTarget:self action:@selector(getNextDate:) forControlEvents:UIControlEventTouchUpInside];
        
        _nextDayButtton.isSelected = NO;
        
        [_nextDayButtton setTitle:L(@"nextDay") forState:UIControlStateNormal];
        
        [_nextDayButtton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_nextDayButtton setTitleColor:[UIColor orange_Light_Color] forState:UIControlStateHighlighted];
                
        _nextDayButtton.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:14];
        
        _nextDayButtton.titleLabel.textAlignment = UITextAlignmentCenter;
        
        _nextDayButtton.backgroundColor = [UIColor clearColor];
        
        [self.backGroudView addSubview:_nextDayButtton];
        
    }
    
    return _nextDayButtton;
    
}


-(IndicatorButton *)backDayButton{
    
    if (!_backDayButton ) {
        
        _backDayButton = [[IndicatorButton alloc] initWithFrame:CGRectZero];
                
        [_backDayButton addTarget:self action:@selector(getBackDate:) forControlEvents:UIControlEventTouchUpInside];
        
        _backDayButton.isSelected = NO;
        
        [_backDayButton setTitle:L(@"backDay") forState:UIControlStateNormal];
        
        [_backDayButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        [_backDayButton setTitleColor:[UIColor orange_Light_Color] forState:UIControlStateHighlighted];

        _backDayButton.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:14];
        
        _backDayButton.titleLabel.textAlignment = UITextAlignmentCenter;
        
        _backDayButton.backgroundColor = [UIColor clearColor];
        
        [self.backGroudView addSubview:_backDayButton];
    }
    
    return _backDayButton;
    
}



@end
