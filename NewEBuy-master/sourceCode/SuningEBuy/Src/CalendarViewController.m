//
//  CalendarViewController.m
//  SuningEBuy
//
//  Created by lanfeng on 12-5-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CalendarViewController.h"


@implementation CalendarViewController

//@synthesize navigationBar = _navigationBar;
@synthesize calendarView  = _calendarView;
@synthesize backgroundImageView = _backgroundImageView;
@synthesize calendarViewControllerDelegate;
@synthesize leftImageView = _leftImageView;
@synthesize rightImageView = _rightImageView;
@synthesize leftBtn  = _leftBtn;
@synthesize rightBtn = _rightBtn;
@synthesize dateLbl = _dateLbl;
@synthesize headView = _headView;
@synthesize navigationItemTitle = _navigationItemTitle;

- (id)initWithNavigationItemTitle:(NSString *)title {
    self = [super init];
    if (self) {
        self.title = title;
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"virtual_business"),title];
        self.bSupportPanUI = NO;
    }
    return self;
}

- (void)dealloc {
    
    TT_RELEASE_SAFELY(_navigationBar);
    TT_RELEASE_SAFELY(_calendarView);
    TT_RELEASE_SAFELY(_backgroundImageView);
    TT_RELEASE_SAFELY(_headView);
    TT_RELEASE_SAFELY(_leftImageView);
    TT_RELEASE_SAFELY(_rightImageView);
    TT_RELEASE_SAFELY(_leftBtn);
    TT_RELEASE_SAFELY(_rightBtn);
    TT_RELEASE_SAFELY(_dateLbl);
    TT_RELEASE_SAFELY(_navigationItemTitle);
}

-(void)loadView{
    
    [super loadView];
    
    UIView *contentView = self.view;
	
	CGRect frame = contentView.frame;
	
	frame.origin.x = 0;
	
	frame.origin.y = 0;
	
	frame.size.height = contentView.bounds.size.height - 44;
	
//    [self.view addSubview:self.navigationBar];
    
    //[self.view addSubview:self.backgroundImageView];
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_system_background.png"]];;
    self.view.backgroundColor = [UIColor view_Back_Color];
    
    [self.view addSubview:self.headView];

    [self.view addSubview:self.calendarView];
    
}

- (void)backForePage
{
    [self pressReturn:nil];
}
//-(UINavigationBar *)navigationBar{
//    
//    if (_navigationBar == nil) {
//        
//        _navigationBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
//        
//        _navigationBar.tintColor = [UIColor navTintColor];
//        
//        UINavigationItem *navigationItem = [[UINavigationItem alloc]initWithTitle:self.navigationItemTitle];
//        
////        UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(pressReturn:)];
////        
////        [navigationItem setLeftBarButtonItem:cancelBtn];
//        
//        UILabel *_titleViewLabel = [[UILabel alloc] init];
//        _titleViewLabel.textColor = [UIColor colorWithRGBHex:0x776D61];
//        _titleViewLabel.shadowColor = [UIColor navTintColor];
//        _titleViewLabel.backgroundColor = [UIColor clearColor];
//        _titleViewLabel.font = [UIFont boldSystemFontOfSize:21.0];
//        _titleViewLabel.textAlignment = NSTextAlignmentCenter;
//        _titleViewLabel.frame = CGRectMake(0, 5, 200, 34);
//        _titleViewLabel.contentMode = UIViewContentModeScaleAspectFit;
//        self.navigationItem.titleView = _titleViewLabel;
//
//
//        UIBarButtonItem *item = [UIBarButtonItem initWithImage:@"home_back_btn.png"];// wihtSel:nil];
//        if (item.customView) {
//            UIButton *btn = (UIButton *)item.customView;
//            [btn addTarget:self action:@selector(pressReturn:) forControlEvents:UIControlEventTouchUpInside];
//        }
//        self.navigationItem.leftBarButtonItem = item;
//        [item release];
//
//        
//        if ([_navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
//            
//            UIImage *image = [UIImage imageNamed:@"system_nav_bg.png"];
//            
//            [_navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
//        }
//        
//        TT_RELEASE_SAFELY(item);
//        
//        [_navigationBar pushNavigationItem:navigationItem animated:NO];
//        
//        TT_RELEASE_SAFELY(navigationItem);
//        
//    }
//    
//    return _navigationBar;
//}



-(UIView *)headView{

    if (_headView == nil) {
        _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 60)];
        _headView.backgroundColor = [UIColor clearColor];
        [_headView addSubview:self.leftImageView];
        [_headView addSubview:self.rightImageView];
        [_headView addSubview:self.leftBtn];
        [_headView addSubview:self.rightBtn];
        [_headView addSubview:self.dateLbl];
    }
    return  _headView ;
}


-(UIImageView *)leftImageView{

    if (_leftImageView == nil) {
        _leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(30, 15, 21, 32)];
        UIImage *image = [UIImage imageNamed:@"plane_left_arrow.png"];
        _leftImageView.image = image;
        _leftImageView.backgroundColor = [UIColor clearColor];
    }
    return _leftImageView;
}

-(UIImageView *)rightImageView{
    
    if (_rightImageView == nil) {
        _rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(270, 15, 21, 32)];
        UIImage *image = [UIImage imageNamed:@"plane_right_arrow.png"];
        _rightImageView.image = image;
        _rightImageView.backgroundColor = [UIColor clearColor];
    }
    return _rightImageView;
}

-(UIButton *)leftBtn{
    if (_leftBtn == nil) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.backgroundColor = [UIColor clearColor];
        _leftBtn.frame = CGRectMake(30, 15, 32, 32);
        [_leftBtn addTarget:self action:@selector(goToLastMonth) forControlEvents:UIControlEventTouchUpInside];
    }   
    return _leftBtn;
}

-(UIButton *)rightBtn{
    if (_rightBtn == nil) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.backgroundColor = [UIColor clearColor];
        _rightBtn.frame = CGRectMake(270, 15, 32, 32);
        [_rightBtn addTarget:self action:@selector(goToNextMonth) forControlEvents:UIControlEventTouchUpInside];
    }   
    return _rightBtn;
}

-(UILabel *)dateLbl{
    if (_dateLbl == nil) {
        _dateLbl = [[UILabel alloc]initWithFrame:CGRectMake(100, 0, 120, 60)];
        _dateLbl.textAlignment = UITextAlignmentCenter;
        _dateLbl.textColor = [UIColor grayColor];
        _dateLbl.font = [UIFont systemFontOfSize:20.0];
        _dateLbl.backgroundColor = [UIColor clearColor];
    }
    return _dateLbl;
}


-(UIView *)calendarView{
    if (_calendarView == nil) {
        _calendarView = [[TdCalendarView alloc]initWithFrame:CGRectMake(6, 104 - 44, 308, 308)];
        _calendarView.calendarViewDelegate = self;
        _calendarView.alpha = 0.8;
        _calendarView.layer.shadowColor = [UIColor blackColor].CGColor;
        _calendarView.layer.shadowOffset = CGSizeMake(5, 3);
        _calendarView.layer.shadowOpacity = 0.7;
        _calendarView.layer.shadowRadius = 8.0;
        
    }
    return _calendarView;
}

- (UIImageView *)backgroundImageView
{
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_system_background.png"]];
        _backgroundImageView.frame = CGRectMake(0, 44, _backgroundImageView.width, _backgroundImageView.height);
        
    }
    return _backgroundImageView;
}


#pragma mark - action

-(void)pressReturn:(id)sender{
    
    [self dismissModalViewControllerAnimated:YES];

}

-(void)goToLastMonth{

    [self.calendarView movePrevMonth];

}

-(void)goToNextMonth{
    
    [self.calendarView moveNextMonth];

}


#pragma mark - delegate

- (void) selectDateChanged:(CFGregorianDate) selectDate{
    
    [self dismissModalViewControllerAnimated:YES];

    if ([calendarViewControllerDelegate conformsToProtocol:@protocol(CalendarViewControllerDelegate)])
    {
        if ([calendarViewControllerDelegate respondsToSelector:@selector(selectDateChanged:andViewController:)])
        {
            [calendarViewControllerDelegate selectDateChanged:selectDate andViewController:self];
        }
    }
    
}


- (void) monthChanged:(CFGregorianDate) currentMonth viewLeftTop:(CGPoint)viewLeftTop height:(float)height{
    
    if ([calendarViewControllerDelegate conformsToProtocol:@protocol(CalendarViewControllerDelegate)])
    {
        if ([calendarViewControllerDelegate respondsToSelector:@selector(monthChanged:viewLeftTop:height:)])
        {
            [calendarViewControllerDelegate monthChanged:currentMonth viewLeftTop:viewLeftTop height:height];
        }
    }
        
    
}

- (void) returnCurrentYearAndMonth:(CFGregorianDate)currentMonth{
    
    NSString    *str = [NSString stringWithFormat:L(@"BTYearAndMonth"),currentMonth.year,currentMonth.month];
    
    self.dateLbl.text = str;
           
}

- (void) beforeMonthChange:(TdCalendarView*) tdCalendarView willto:(CFGregorianDate) currentMonth{
            
    if ([calendarViewControllerDelegate conformsToProtocol:@protocol(CalendarViewControllerDelegate)])
    {
        if ([calendarViewControllerDelegate respondsToSelector:@selector(beforeMonthChange:willto:)])
        {
            [calendarViewControllerDelegate beforeMonthChange:tdCalendarView willto:currentMonth];
        }
    }
}
@end
