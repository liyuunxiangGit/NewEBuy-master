//
//  SearchHotelViewController.m
//  SuningEBuy
//
//  Created by 芳奎 赵 on 12-7-2.
//  Copyright (c) 2012年 苏宁. All rights reserved.
//

#import "SearchHotelViewController.h"
#import <UIKit/UIKit.h>
#import "HotelListViewController.h"

#define kVerticaltLineImage               @"segment_line_vertical_gray.png"


@implementation SearchHotelViewController


@synthesize footView = _footView;
@synthesize queryBtn  = _queryBtn;
@synthesize queryDate = _queryDate;
@synthesize cityLable=_cityLable;
@synthesize cityBtn =_cityBtn;
@synthesize locationLable=_locationLable;
@synthesize locationBtn=_locationBtn;
@synthesize nameLable=_nameLable;
@synthesize nameTextField=_nameTextField;
@synthesize dataLable =_dataLable;
@synthesize dateBtn=_dateBtn;
@synthesize numberOfDateLable=_numberOfDateLable;
@synthesize numberOfDateTextField =_numberOfDateTextField;
@synthesize priceLable =_priceLable;
@synthesize starLable =_starLable;
@synthesize itemsValueArray = _itemsValueArray;
@synthesize priceList = _priceList;
@synthesize priceTextField = _priceTextField;
@synthesize pricePicker=_pricePicker;
@synthesize starList=_starList;
@synthesize starPicker=_starPicker;
@synthesize starTextField=_starTextField;

/*******
 init:1 标题-酒店搜索
 init:2 空格-“   ”
 init:3 数组{北京、不限、不限、当天、1、不限、不限、“”}
 init:4 数组{不限、150以下、150-300、300-600、600以上}
 init:5 数组{不限、公寓、经济客栈、三星舒适、四星高档、五星豪华}
 */
- (id)init {
    self = [super init];
    if (self) 
    {
        self.title = L(@"BTHotelQuery");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"virtual_business"),self.title];

        NSString *tempStr=[self getDate];
        //初始化传值数组
        NSMutableArray *tempArray2 = [[NSMutableArray alloc]initWithObjects:L(@"BTBeijing"),L(@"BTIrrestriction"),L(@"BTIrrestriction"),tempStr,@"1",L(@"BTIrrestriction"),L(@"BTIrrestriction"),@"", nil];
        self.itemsValueArray = tempArray2;
        TT_RELEASE_SAFELY(tempArray2);
        if (!_priceList) {
            //初始化价格数组
            _priceList = [[NSArray alloc] initWithObjects:L(@"BTIrrestriction"),@"0-150",@"150-300",@"300-600",@"600-*",nil];
        }
        if (!_starList) {
            //初始化星级数组
            _starList = [[NSArray alloc] initWithObjects:L(@"BTIrrestriction"),L(@"BTHotel"),L(@"BTBenefitHotel"),L(@"BTThreeStar"),L(@"BTFourStar"),L(@"BTFiveStar"),nil];
        }
    }
    return self;
}


- (void)loadView
{
    [super loadView];
    
    CGRect frame =[self visibleBoundsShowNav:YES showTabBar:NO];
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7) {
        frame.origin.y=frame.origin.y;
        frame.size.height=frame.size.height;
    }
	self.tpTableView.frame =frame;
    
    
//    UIView *contentView = self.view;
//	CGRect frame = contentView.frame;
//	frame.origin.x = 0;
//	frame.origin.y = 0;
//	frame.size.height = contentView.bounds.size.height - 92;
    
//	self.tpTableView.frame = frame;
    
	[self.view addSubview:self.tpTableView];
    self.hasSuspendButton=YES;
}

- (void)dealloc {
    TT_RELEASE_SAFELY(_priceLable);
    TT_RELEASE_SAFELY(_locationLable);
    TT_RELEASE_SAFELY(_locationBtn);
    TT_RELEASE_SAFELY(_nameLable);
    TT_RELEASE_SAFELY(_nameTextField);
    TT_RELEASE_SAFELY(_dataLable);
    TT_RELEASE_SAFELY(_dateBtn);
    TT_RELEASE_SAFELY(_numberOfDateLable);
    TT_RELEASE_SAFELY(_numberOfDateTextField);
    TT_RELEASE_SAFELY(_priceLable);
    TT_RELEASE_SAFELY(_starLable);
    TT_RELEASE_SAFELY(_itemsValueArray);
    TT_RELEASE_SAFELY(_footView);
    TT_RELEASE_SAFELY(_queryBtn);
    TT_RELEASE_SAFELY(_queryDate);
    TT_RELEASE_SAFELY(_priceList)
    TT_RELEASE_SAFELY(_priceTextField);
    TT_RELEASE_SAFELY(_pricePicker);
    TT_RELEASE_SAFELY(_starList);
    TT_RELEASE_SAFELY(_starPicker);
    TT_RELEASE_SAFELY(_starTextField);
}

/*********************************ping itemsValueArray objectAtIndex(1 2 3 4 5)************************************/

//itemsValueArray param 1;
#pragma mark CityListViewControllerProtocol delegate
- (void) citySelectionUpdate:(NSString*)selectedCity andViewController:(id)controller
{
    //替换数组
    [self.itemsValueArray replaceObjectAtIndex:0 withObject:selectedCity];
    //替换标题
    [self.cityBtn setTitle:[@"" stringByAppendingString:[self.itemsValueArray objectAtIndex:0]]
                  forState:UIControlStateNormal];
    [self.cityBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    //替换数组
    [self.itemsValueArray replaceObjectAtIndex:1 withObject:L(@"BTIrrestriction")];
    //替换标题
    [self.locationBtn setTitle:[@"" stringByAppendingString:[self.itemsValueArray objectAtIndex:1]]
                      forState:UIControlStateNormal];
}

//itemsValueArray param 2;
#pragma mark SearchHotelLocationViewControllerProtocol delegate
-(void) locationID:(NSString *)locationID andLocationName:(NSString *)locationName
{
    if (locationID!=nil && locationName!=nil ) {
        //替换数组
        [self.itemsValueArray replaceObjectAtIndex:1 withObject:locationID];
        //替换标题
        [self.locationBtn setTitle:[@"" stringByAppendingString:locationName]
                          forState:UIControlStateNormal];
        [self.locationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}
- (NSString*) getDefaultCity
{
    return L(@"GBChooseCity");
}

//itemsValueArray param 4;
#pragma mark - CalendarViewControllerDelegate
- (void) selectDateChanged:(CFGregorianDate) selectDate andViewController:(id)controller{
    
    NSString *month = [NSString stringWithFormat:@"%d",selectDate.month];
    NSString *day = [NSString stringWithFormat:@"%d",selectDate.day];
    //标准格式2012-04-06 小于10，月份前加0
    if (selectDate.month < 10) {
        month = [NSString stringWithFormat:@"%@%d",@"0",selectDate.month];
    }
    //标准格式2012-04-06 小于10，日期前加0
    if (selectDate.day < 10) {
        day = [NSString stringWithFormat:@"%@%d",@"0",selectDate.day];
    }
    self.queryDate = [NSString stringWithFormat:@"%li-%@-%@",selectDate.year,month,day];
    DLog(@"----%@", self.queryDate);
    //更换数组
    [self.itemsValueArray replaceObjectAtIndex:3 withObject:self.queryDate]; 
    //替换标题
    [self.dateBtn setTitle:[@"" stringByAppendingString:[self.itemsValueArray objectAtIndex:3]]
                  forState:UIControlStateNormal];
    [self.dateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

//itemsValueArray param 3 5;
-(void)textFieldDidEndEditing:(UITextField *)textField{
    //tag：2对应酒店名称；4对应入住天数
    if (textField.tag==2) 
    {
        //更换数组
        [self.itemsValueArray replaceObjectAtIndex:2 withObject:[textField.text stringByReplacingOccurrencesOfString:@" " withString:@""]];
    } 
    if (textField.tag == 4) 
    {
        //更换数组
        [self.itemsValueArray replaceObjectAtIndex:4 withObject:[textField.text stringByReplacingOccurrencesOfString:@" " withString:@""]];
    }
    
    DLog(@"%@", [self.itemsValueArray objectAtIndex:2]);
    DLog(@"%@", [self.itemsValueArray objectAtIndex:4]);
}

/*********************************ping itemsValueArray objectAtIndex(1 2 3 4 5)************************************/
///////////////////////////////// ----getter/setter/Target of prperties -----///////////////////////////////////////
//城市标题
-(UILabel *)cityLable{
    if (_cityLable == nil) {
        _cityLable = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 80, 40)];
        _cityLable.backgroundColor = [UIColor clearColor];
        _cityLable.font = [UIFont systemFontOfSize:16.0];
        _cityLable.text=L(@"BTMoveIntoCity");
    }
    return _cityLable;
}
//位置标题
-(UILabel *)locationLable{
    if (_locationLable == nil) {
        _locationLable = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 80, 40)];
        _locationLable.backgroundColor = [UIColor clearColor];
        _locationLable.font = [UIFont systemFontOfSize:16.0];
        _locationLable.text=L(@"BTHotelPosition");
    }
    return _locationLable;
}
//名称标题
-(UILabel *)nameLable{
    
    if (_nameLable == nil) {
        _nameLable = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 80, 40)];
        _nameLable.backgroundColor = [UIColor clearColor];
        _nameLable.font = [UIFont systemFontOfSize:16.0];
        _nameLable.text=L(@"hotalName");
    }
    return _nameLable;
}
//日期标题
-(UILabel *)dataLable{
    
    if (_dataLable == nil) {
        _dataLable = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 80, 40)];
        _dataLable.backgroundColor = [UIColor clearColor];
        _dataLable.font = [UIFont systemFontOfSize:16.0];
        _dataLable.text=L(@"Arrive_Date");
    }
    return _dataLable;
}
//天数标题
-(UILabel *)numberOfDateLable{
    
    if (_numberOfDateLable == nil) {
        _numberOfDateLable = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 80, 40)];
        _numberOfDateLable.backgroundColor = [UIColor clearColor];
        _numberOfDateLable.font = [UIFont systemFontOfSize:16.0];
        _numberOfDateLable.text=L(@"BTLivingDays");
    }
    return _numberOfDateLable;
}
//价格标题
-(UILabel *)priceLable{
    
    if (_priceLable == nil) {
        _priceLable = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 80, 40)];
        _priceLable.backgroundColor = [UIColor clearColor];
        _priceLable.font = [UIFont systemFontOfSize:16.0];
        _priceLable.text=L(@"BTPriceSection");
    }
    return _priceLable;
}
//星级标题
-(UILabel *)starLable{
    
    if (_starLable == nil) {
        _starLable = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 80, 40)];
        _starLable.backgroundColor = [UIColor clearColor];
        _starLable.font = [UIFont systemFontOfSize:16.0];
        _starLable.text=L(@"hotelStarLevel");
    }
    return _starLable;
}
//城市按钮
-(UIButton *)cityBtn{
    if (_cityBtn == nil) {
        _cityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cityBtn.frame = CGRectMake(120, 5, 180, 30);
//        [_cityBtn setBackgroundImage:[UIImage streImageNamed:@"HotelSearchTextField.png"] forState:UIControlStateNormal];
        [_cityBtn setBackgroundColor:[UIColor clearColor]];
        _cityBtn.titleLabel.font=[UIFont systemFontOfSize:16.0];
        [_cityBtn setTitleColor:[UIColor colorWithRGBHex:0xcbcaca] forState:UIControlStateNormal];//通过打印UITextField的placeHoler颜色值得出。
        [_cityBtn addTarget:self action:@selector(cityBtnSelect) forControlEvents:UIControlEventTouchUpInside];
        [_cityBtn setTitle:[@"" stringByAppendingString:[self.itemsValueArray objectAtIndex:0] ]
                  forState:UIControlStateNormal];
        [_cityBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        
    }
    return _cityBtn;
}
//城市按钮触发事件
-(void)cityBtnSelect{
    SearchCityListViewController *cityListViewController = [[SearchCityListViewController alloc]init];
    cityListViewController.delegate = self;
    cityListViewController.view.tag = 0;
    AuthManagerNavViewController *nav = [[AuthManagerNavViewController alloc] initWithRootViewController:cityListViewController];
    [self.navigationController presentModalViewController:nav animated:YES];
    TT_RELEASE_SAFELY(cityListViewController);
}
//位置按钮
-(UIButton *)locationBtn{
    if (_locationBtn == nil) {
        _locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _locationBtn.frame = CGRectMake(120, 5, 180, 30);
//        [_locationBtn setBackgroundImage:[UIImage streImageNamed:@"HotelSearchTextField.png"] forState:UIControlStateNormal];
        [_locationBtn setBackgroundColor:[UIColor clearColor]];
        _locationBtn.titleLabel.font=[UIFont systemFontOfSize:16.0];
        [_locationBtn setTitleColor:[UIColor colorWithRGBHex:0xcbcaca] forState:UIControlStateNormal];
        [_locationBtn addTarget:self action:@selector(locationBtnSelect) forControlEvents:UIControlEventTouchUpInside];
        [_locationBtn setTitle:[@"" stringByAppendingString:[self.itemsValueArray objectAtIndex:1]]
                      forState:UIControlStateNormal];
        [_locationBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    }
    return _locationBtn;
}
//位置按钮触发事件
-(void)locationBtnSelect{
    if ([[[self.itemsValueArray objectAtIndex:0]stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:L(@"BTIrrestriction")])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:L(@"BTPleaseChooseCityFirst") delegate:self cancelButtonTitle:L(@"BTOk") otherButtonTitles: nil];
        [alert show];
    }else
    {
        SearchHotelLocationByCityNameViewController *locationListViewController = [[SearchHotelLocationByCityNameViewController alloc] initWithCityName:[self.itemsValueArray objectAtIndex:0]];
        locationListViewController.delegate = self;
        locationListViewController.view.tag = 0;
        AuthManagerNavViewController *nav = [[AuthManagerNavViewController alloc] initWithRootViewController:locationListViewController];
        [self.navigationController presentModalViewController:nav animated:YES];
        TT_RELEASE_SAFELY(locationListViewController);
    }
}
//名称对话框
-(UITextField  *)nameTextField{
    
    if (_nameTextField == nil) {
        _nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(120, 5, 180, 30)];
        _nameTextField.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
        _nameTextField.font=[UIFont boldSystemFontOfSize:16.0];
        _nameTextField.textColor=[UIColor blackColor];
        _nameTextField.placeholder=[@"" stringByAppendingString:[self.itemsValueArray objectAtIndex:2]];
        _nameTextField.delegate=self;
//        _nameTextField.text=[@"  " stringByAppendingString:[self.itemsValueArray objectAtIndex:2]];
        _nameTextField.backgroundColor = [UIColor clearColor];
        _nameTextField.returnKeyType = UIReturnKeyDone;
        _nameTextField.borderStyle=UITextBorderStyleNone;
        _nameTextField.keyboardType = UIKeyboardTypeEmailAddress;
//        _nameTextField.background=[UIImage streImageNamed:@"HotelSearchTextField.png"];
        _nameTextField.tag=2;
    }
    return _nameTextField;
}


//天数对话框
-(UITextField  *)numberOfDateTextField{
    
    if (_numberOfDateTextField == nil) {
        _numberOfDateTextField = [[UITextField alloc]initWithFrame:CGRectMake(120, 5, 180, 30)];
        _numberOfDateTextField.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
        _numberOfDateTextField.font=[UIFont boldSystemFontOfSize:16.0];
//        _numberOfDateTextField.textColor=[UIColor blackColor];
        _numberOfDateTextField.delegate=self;
        _numberOfDateTextField.placeholder=[@"" stringByAppendingString:[self.itemsValueArray objectAtIndex:4] ];
        _numberOfDateTextField.backgroundColor = [UIColor clearColor];
        _numberOfDateTextField.returnKeyType = UIReturnKeyDone;
//        _numberOfDateTextField.background=[UIImage streImageNamed:@"HotelSearchTextField.png"];
        _numberOfDateTextField.borderStyle=UITextBorderStyleNone;

        _numberOfDateTextField.keyboardType = UIKeyboardTypeNumberPad;

        
        _numberOfDateTextField.tag=4;
    }
    return _numberOfDateTextField;
}

//日期按钮
-(UIButton *)dateBtn{
    if (_dateBtn == nil) {
        _dateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _dateBtn.frame = CGRectMake(120,5, 180, 30);
//        [_dateBtn setBackgroundImage:[UIImage streImageNamed:@"HotelSearchTextField.png"] forState:UIControlStateNormal];
        [_dateBtn setBackgroundColor:[UIColor clearColor]];
        _dateBtn.titleLabel.font=[UIFont boldSystemFontOfSize:16.0];
//        [_dateBtn setTitleColor:[UIColor colorWithRed:0 green:0 blue:0.0980392 alpha:0.22] forState:UIControlStateNormal];
        [_dateBtn setTitleColor:[UIColor colorWithRGBHex:0xcbcaca] forState:UIControlStateNormal];
        [_dateBtn addTarget:self action:@selector(dataBtnSelect) forControlEvents:UIControlEventTouchUpInside];
        [_dateBtn setTitle:[@"" stringByAppendingString:[self.itemsValueArray objectAtIndex:3] ]
                  forState:UIControlStateNormal];
        [_dateBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    }
    return _dateBtn;
}
//日期按钮触发事件
-(void)dataBtnSelect{
    CalendarViewController *calendarViewController = [[CalendarViewController alloc]initWithNavigationItemTitle:L(@"BTChooseArriveTime")];
    calendarViewController.calendarViewControllerDelegate = self;
    calendarViewController.view.tag = 0;
    AuthManagerNavViewController *nav = [[AuthManagerNavViewController alloc] initWithRootViewController:calendarViewController];
    [self.navigationController presentModalViewController:nav animated:YES];
    TT_RELEASE_SAFELY(calendarViewController);
}
//价格输入框
- (ToolBarTextField *)priceTextField{
    
    if (!_priceTextField) {
        _priceTextField = [[ToolBarTextField alloc] initWithFrame:CGRectMake(120, 5, 180, 30)];
        _priceTextField.backgroundColor = [UIColor clearColor];
//        _priceTextField.background=[UIImage streImageNamed:@"HotelSearchTextField.png"];
        _priceTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _priceTextField.inputView = self.pricePicker;
        _priceTextField.delegate = self;
        _priceTextField.tag = 3;
        _priceTextField.toolBarDelegate = self;
        _priceTextField.placeholder=[@"" stringByAppendingString:[self.itemsValueArray objectAtIndex:5]];
        _priceTextField.font = [UIFont boldSystemFontOfSize:16.0];
    }
    return _priceTextField;
}
//价格picker
- (UIPickerView *)pricePicker{
    if (!_pricePicker) {
        _pricePicker = [[UIPickerView alloc] init];
        _pricePicker.hidden = NO;
        _pricePicker.tag = 1;
        _pricePicker.delegate = self;
        _pricePicker.dataSource = self;
        _pricePicker.showsSelectionIndicator = YES;
    }
    return _pricePicker;
}
//星级输入框
- (ToolBarTextField *)starTextField{
    
    if (!_starTextField) {
        _starTextField = [[ToolBarTextField alloc] initWithFrame:CGRectMake(120, 5, 180, 30)];
        _starTextField.backgroundColor = [UIColor clearColor];
//        _starTextField.background=[UIImage streImageNamed:@"HotelSearchTextField.png"];
        _starTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _starTextField.inputView = self.starPicker;
        _starTextField.delegate = self;
        _starTextField.tag = 5;
        _starTextField.toolBarDelegate = self;
        _starTextField.placeholder=[@"" stringByAppendingString:[self.itemsValueArray objectAtIndex:6]];
        _starTextField.font = [UIFont boldSystemFontOfSize:16.0];
    }
    
    return _starTextField;
}
- (UIPickerView *)starPicker{
    if (!_starPicker) {
        _starPicker = [[UIPickerView alloc] init];
        _starPicker.hidden = NO;
        _starPicker.tag = 2;
        _starPicker.delegate = self;
        _starPicker.dataSource = self;
        _starPicker.showsSelectionIndicator = YES;
    }
    return _starPicker;
}


//尾部视图，包含提交按钮
-(UIView *)footView{
    
    if (_footView == nil) {
        _footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 60)];
        _footView.backgroundColor = [UIColor clearColor];
        [_footView addSubview:self.queryBtn];
    }
    return _footView;
}
//提交按钮
- (UIButton *)queryBtn
{
    if (!_queryBtn)
    {
        _queryBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 25, 280, 30)];
        //[_queryBtn addTarget:self action:@selector(presentViewController) forControlEvents:UIControlEventTouchUpInside];
        [_queryBtn setTitle:L(@"Plane Query") forState:UIControlStateNormal]; 
        UIImage *image = [UIImage streImageNamed:@"orange_button.png"];
        [_queryBtn setBackgroundImage:image forState:UIControlStateNormal];
        UIImage *clickedImage = [UIImage streImageNamed:@"orange_button_clicked.png"];
        [_queryBtn setBackgroundImage:clickedImage forState:UIControlStateSelected];
        _queryBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
        [_queryBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_queryBtn addTarget:self action:@selector(queryBtnSelect) forControlEvents:UIControlEventTouchUpInside];
    }
    return _queryBtn;    
}

-(void)queryBtnSelect{
    
    
    [self.numberOfDateTextField resignFirstResponder];
    
    [self.nameTextField resignFirstResponder];
    
    //表单验证
    if ([self validateHTTPReqestParam:self.itemsValueArray]) {
        //itemsValueArray param 8;
        NSString *leaveDate=[self calculateLeaveTime:[self.itemsValueArray objectAtIndex:3] date:[self.itemsValueArray objectAtIndex:4]];
        [self.itemsValueArray replaceObjectAtIndex:7 withObject:leaveDate];
        /**
         zhangjian do something here!
         the param pass to you is :self.itemsValueArray 
         入住城市：objectAtIndex 1
         酒店位置：objectAtIndex 2
         酒店名称：objectAtIndex 3
         入住日期：objectAtIndex 4
         住几晚上：objectAtIndex 5
         价格区间：objectAtIndex 6
         酒店星级：objectAtIndex 7
         离开时间：objectAtIndex 8
         */
        HotelListViewController *next = [[HotelListViewController alloc] initWithSearchData:self.itemsValueArray];
        [self.navigationController pushViewController:next animated:YES];
        
    }
 
}
//自定义tableview
- (UITableView *)tpTableView
{
	if(!tpTableView_)
    {
		
        if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7) {
            tpTableView_ = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectZero
                                                                        style:UITableViewStyleGrouped];
        }else{
            tpTableView_ = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectZero
                                                                        style:UITableViewStylePlain];
        }
        [tpTableView_ setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
		[tpTableView_ setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
		tpTableView_.scrollEnabled = YES;
		tpTableView_.userInteractionEnabled = YES;
		tpTableView_.delegate =self;
		tpTableView_.dataSource =self;
		tpTableView_.backgroundColor =self.view.backgroundColor;
//        tpTableView_.backgroundColor =[UIColor clearColor];
        tpTableView_.tableFooterView=self.footView;

	}
	return tpTableView_;
}

#pragma mark - TableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 5;
    }else{
        return 2;
    }
}
-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* headerView=[[UIView alloc] init];
    [headerView setBackgroundColor:[UIColor clearColor]];
    if (section==0) {
        [headerView setFrame:CGRectMake(0, 0, 320, 30)];
        return headerView;
    }
    [headerView setFrame:CGRectMake(0, 0, 320, 30)];
    return headerView;
}

////最后一个section 加载尾部试图“确定按钮”
//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    if (section == 1) 
//    {
//        return self.footView;
//    }
//    return nil;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 20;
    }
    return 30;
}
////最后一个section 尾试图的高度60
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    if (section == 1) 
//    {
//        return 60;
//    }
//    return 0.0;
//}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];          

    if (cell == nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        UIImage* lineImage=[UIImage newImageFromResource:kVerticaltLineImage];
        UIImageView* verticalLine=[[UIImageView alloc] initWithFrame:CGRectMake(103, 8, 1, 22)];
        [verticalLine setImage:lineImage];
        TT_RELEASE_SAFELY(lineImage);
        [cell.contentView addSubview:verticalLine];
        TT_RELEASE_SAFELY(verticalLine);
        
        UIView* bgView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];//保证ios6白底
        [bgView setBackgroundColor:[UIColor whiteColor]];
        [cell.contentView insertSubview:bgView atIndex:0];
        TT_RELEASE_SAFELY(bgView);
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    
    
    
    if (indexPath.section==0) {
        switch (indexPath.row) {
            case 0:
            {
                [cell.contentView addSubview:self.cityLable];
                [cell.contentView addSubview:self.cityBtn]; 
                break;
            }
            case 1:
            {
                [cell.contentView addSubview:self.locationLable];
                [cell.contentView addSubview:self.locationBtn];
                break;
            }
            case 2:
            {
                [cell.contentView addSubview:self.nameLable];
                [cell.contentView addSubview:self.nameTextField];
                break;
            }
            case 3:
            {
                [cell.contentView addSubview:self.dataLable];
                [cell.contentView addSubview:self.dateBtn];
                break;
            }
            case 4:
            {
                [cell.contentView addSubview:self.numberOfDateLable];
                [cell.contentView addSubview:self.numberOfDateTextField];
                break;
            }
            default:
                return nil;
                break;
        }
    }else{
        
        switch (indexPath.row) {
            case 0:
            {
                [cell.contentView addSubview:self.priceLable];
                [cell.contentView addSubview:self.priceTextField]; 
                break;
            }
            case 1:
            {
                [cell.contentView addSubview:self.starLable];
                [cell.contentView addSubview:self.starTextField];
                break;
            }
            default:
                return nil;
                break;
                
        }
    }
    return cell;
}

#pragma mark -
#pragma mark Picker Data Source Methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView.tag==1) {
        return [self.priceList count];
    }else{
        return [self.starList count];
    }
	
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView rowSizeForComponent:component].width, [pickerView rowSizeForComponent:component].height)];
    label.adjustsFontSizeToFitWidth = YES;
    label.backgroundColor = [UIColor clearColor];
    label.font  = [UIFont boldSystemFontOfSize:16.0];
    [label setTextAlignment:UITextAlignmentCenter];
    if (pickerView.tag==1) {
        [label setText:[self.priceList objectAtIndex:row]];
    }else{
        [label setText:[self.starList objectAtIndex:row]];
    }
    return label;
}

- (void)cancelButtonClicked:(id)sender{
    if ([self.priceTextField isFirstResponder]) {
        [self.priceTextField resignFirstResponder];        
    }
    if ([self.starTextField isFirstResponder]) {
        [self.starTextField resignFirstResponder];
    }
}
//itemsValueArray param 6 7;
- (void)doneButtonClicked:(id)sender{
    if ([self.priceTextField isFirstResponder]) {
        NSInteger certificateTypeRow = [self.pricePicker selectedRowInComponent:0];
        [self.itemsValueArray replaceObjectAtIndex:5 withObject:[NSString stringWithFormat:@"%@",[self.priceList objectAtIndex:certificateTypeRow]]];
        self.priceTextField.text = [@"" stringByAppendingString:[self.priceList objectAtIndex:certificateTypeRow]];
        [self.priceTextField resignFirstResponder];        
    }
    if ([self.starTextField isFirstResponder]) {
        NSInteger certificateTypeRow = [self.starPicker selectedRowInComponent:0];
        [self.itemsValueArray replaceObjectAtIndex:6 withObject:[NSString stringWithFormat:@"%d",certificateTypeRow]];
        
        self.starTextField.text = [@"" stringByAppendingString:[self.starList objectAtIndex:certificateTypeRow]];
        [self.starTextField resignFirstResponder];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (self.starTextField == textField) {
        return NO;
    }
    if (self.priceTextField == textField) {
        return NO;
    }
    return YES;
}

//add by zhangjian   点击完成键盘消失
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField == self.nameTextField) {
        
        [self.nameTextField resignFirstResponder];
    }
    return NO;
}

#pragma mark - UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    //tag：2对应酒店名称；4对应入住天数
    if (textField.tag==2) 
    {
        //若用户第一次填写，将系统初始化的“不限”移除
        if ([[textField.text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:L(@"BTIrrestriction")])
        {
            textField.text=@"  ";
        }
    }else
    {
        //若用户第一次填写，将系统初始化的“1”移除
        if ([[textField.text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@"1"]) {
            textField.text=@"  ";
        }
    }
}
//-----------------------------------delegate of tabelView textField pickerVier Etc-------------------------------//
//################################## self function for gettng the current time Etc ###############################//
/**
 验证1：入住时间是否为3个月吼
 验证2：预定周期是否超过20天
 */
-(BOOL) validateHTTPReqestParam:(NSArray *)arr{
    
    //验证是否超过3个月

    //BOOL temp=[self outOfDate:[self getDate] :@"90"];
    BOOL temp=[self outOfdate];
    if (temp) 
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:L(@"BTOnlyCanOrderWithinThreeMonth") delegate:self cancelButtonTitle:L(@"BTOk") otherButtonTitles: nil];
        [alert show];
        return NO;
        
    }
    //如果用户输入的数字以“0”开头，提醒用户“请输入正确的入住天数”
    if ([[self.itemsValueArray objectAtIndex:4] hasPrefix:@"0"]&&[[self.itemsValueArray objectAtIndex:4] length]>1 ) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:L(@"BTMustArriveWithin1-20Days") delegate:self cancelButtonTitle:L(@"BTOk")otherButtonTitles: nil];
        [alert show];
        return NO;
    }
    //如果用户输入的数字大于20，提醒用户“对不起，房间最多预定20天”
    if ([[self.itemsValueArray objectAtIndex:4] intValue]>20) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:L(@"BTMustArriveWithin1-20Days") delegate:self cancelButtonTitle:L(@"BTOk") otherButtonTitles: nil];
        [alert show];
        return NO;
    }
    if ([[self.itemsValueArray objectAtIndex:4] intValue]<1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:L(@"BTMustArriveWithin1-20Days") delegate:self cancelButtonTitle:L(@"BTOk") otherButtonTitles: nil];
        [alert show];
        return NO;
    }
    return YES;
}
//判断选择的时间是否在3个月之内
-(BOOL)outOfdate{
    
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd"];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setMonth:3];
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *dateAffterThreeMonth = [calender dateByAddingComponents:comps toDate:[NSDate date] options:0];
    NSDate *reallyDate =[formater dateFromString:[self.itemsValueArray objectAtIndex:3]];
    //超过3个月
    if ([[dateAffterThreeMonth earlierDate:reallyDate]isEqualToDate:dateAffterThreeMonth]) {
        return YES;
    }else{
        return NO;
    }
}
//根据入住日期、入住天数，计算出退房时间，初始化数组第七个参数
- (NSString *)calculateLeaveTime:(NSString *)arriveTime date:(NSString *)date{
    
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *arriveDate = [formater dateFromString:arriveTime]; 
    
    NSDate *leaveDate = [arriveDate dateByAddingTimeInterval:[date intValue]*24*3600];  
    
    NSString *leaveTime = [formater stringFromDate:leaveDate];
    
    return leaveTime;
}
//获取系统当前时间
-(NSString *)getDate{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    return currentDateStr;
}
//################################## self function for gettng the current time Etc ###############################//

@end
