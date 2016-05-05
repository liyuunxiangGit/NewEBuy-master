//
//  CICalendarView.m
//  SuningEBuy
//
//  Created by  liukun on 13-9-3.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CICalendarView.h"
#import "CICalendarLogic.h"
#import "ScreenShotNavViewController.h"
#import "CheckInViewController.h"

@interface CICalendarView()
{
    //重用列表
    NSUInteger numWeeks;
}

@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, strong) UIImageView *back;
@end

/*********************************************************************/

@implementation CICalendarView

- (id)initWithDelegate:(id<CICalendarViewDelegate>)theDelegate dataSource:(CheckInDTO *)dto
{
    self = [super initWithFrame:CGRectMake(0, 0, kCICalendarWidth, kCICalendarHeight)];
    if (self)
    {
        self.delegate = theDelegate;
    
        
        //init views
        self.opaque = NO;
        self.backgroundColor = [UIColor clearColor];
        [self headerView];
        CGFloat leftMargin = 0.5;
        for (int row=0; row<6; row++)
        {
            for (int line=0; line<7; line++)
            {
                CGRect r = CGRectMake(leftMargin+line*kCICalGridWidth, row*kCICalGridHeight, kCICalGridWidth, kCICalGridHeight);
                CICalendarGridView *gridView = [[CICalendarGridView alloc] init];
                gridView.delegate = self;
                gridView.frame = r;
                [self.gridContentView addSubview:gridView];
            }
        }
        
        [self reloadWithDatasource:dto];
        
        //添加手势
        UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
        leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
        [self addGestureRecognizer:leftSwipe];
        
        UISwipeGestureRecognizer *upSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
        upSwipe.direction = UISwipeGestureRecognizerDirectionUp;
        [self addGestureRecognizer:upSwipe];
        
        UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
        rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
        [self addGestureRecognizer:rightSwipe];
        
        UISwipeGestureRecognizer *downSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
        downSwipe.direction = UISwipeGestureRecognizerDirectionDown;
        [self addGestureRecognizer:downSwipe];
        
        
        CheckInViewController *v = (CheckInViewController *)self.delegate;
        ScreenShotNavViewController *nav = (ScreenShotNavViewController*)v.navigationController;
        [nav.panGes requireGestureRecognizerToFail:leftSwipe];
        [nav.panGes requireGestureRecognizerToFail:upSwipe];
        [nav.panGes requireGestureRecognizerToFail:rightSwipe];
        [nav.panGes requireGestureRecognizerToFail:downSwipe];
    }
    
    return self;
}

- (void)swipe:(UISwipeGestureRecognizer *)gesture
{
    if ((gesture.direction == UISwipeGestureRecognizerDirectionLeft) ||
        (gesture.direction == UISwipeGestureRecognizerDirectionUp))
    {
        [self nextMonth];
    }
    else if ((gesture.direction == UISwipeGestureRecognizerDirectionRight) ||
             (gesture.direction == UISwipeGestureRecognizerDirectionDown))
    {
        [self previousMonth];
    }
}

- (id)initWithFrame:(CGRect)frame
{
    [NSException raise:@"Incomplete initializer" format:@"CICalendarView must be initialized with a delegate and a CICalendarLogic. Use the initWithFrame:delegate:logic: method."];
    return nil;
}

- (UIView *)headerView
{
    if (!_headerView)
    {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(-0.5, 0, kCICalendarWidth+1, kCICalHeaderHeight)];
        
        //bgImage
        UIImageView *bgView = [[UIImageView alloc] initWithFrame:_headerView.bounds];
        bgView.image = [UIImage streImageNamed:@"Sign-top.png"];
        [_headerView addSubview:bgView];
        
        //title
        NSArray *titles = @[L(@"CheckIn_Seven"), L(@"CheckIn_One"), L(@"CheckIn_Two"), L(@"CheckIn_Three"), L(@"CheckIn_Four"), L(@"CheckIn_Five"), L(@"CheckIn_Six")];
        CGFloat width = _headerView.width/7;
        CGFloat marginX = 0;
        for (NSInteger i = 0; i < 7; i++)
        {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(marginX, 0, width, _headerView.height)];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor whiteColor];
            label.font = [UIFont systemFontOfSize:14];
            label.text = [titles objectAtIndex:i];
            label.backgroundColor = [UIColor clearColor];
            [_headerView addSubview:label];
            marginX += width;
        }
        
        [self addSubview:_headerView];
    }
    return _headerView;
}

- (UIView *)gridContentView
{
    if (!_gridContentView)
    {
        _gridContentView = [[UIView alloc] initWithFrame:CGRectMake(-0.5, 0, kCICalendarWidth+1, kCICalGridHeight * 5 + 0.5)];
        _gridContentView.clipsToBounds = YES;
        _gridContentView.backgroundColor = [UIColor clearColor];
        
        [self.back addSubview:_gridContentView];
    }
    return _gridContentView;
}

- (UIImageView *)back
{
    if (!_back) {
        _back = [[UIImageView alloc]initWithFrame:CGRectMake(-0.5, kCICalHeaderHeight, kCICalendarWidth+1, self.gridContentView.height+2)];
        _back.image = [UIImage streImageNamed:@"Sign-BG.png"];
        _back.backgroundColor = [UIColor clearColor];
        _back.userInteractionEnabled =YES;
        
        [self addSubview:_back];
    }
    return _back;
}

#pragma mark -
#pragma mark refresh views

- (void)nextMonth
{
    if ([self.currentMonth isEqualToMonth:dataSource.currentDate])
    {
        //当月
        self.currentMonth = self.currentMonth.followingMonth;
        [self animationChangeMonth:YES];
    }
    else if ([self.currentMonth isEqualToMonth:dataSource.currentDate.previousMonth])
    {
        //上月
        self.currentMonth = self.currentMonth.followingMonth;
        [self animationChangeMonth:YES];
    }
    else
    {
        //下月
    }

}

- (void)previousMonth
{
    if ([self.currentMonth isEqualToMonth:dataSource.currentDate])
    {
        //当月， 如果未登录，则不跳转
        if (![UserCenter defaultCenter].isLogined)
        {
            return;
        }
        
        self.currentMonth = self.currentMonth.previousMonth;
        [self animationChangeMonth:NO];
    }
    else if ([self.currentMonth isEqualToMonth:dataSource.currentDate.followingMonth])
    {
        //下月
        self.currentMonth = self.currentMonth.previousMonth;
        [self animationChangeMonth:NO];
    }
    else
    {
        //上月
    }
}

- (void)animationChangeMonth:(BOOL)next
{
    UIViewAnimationTransition options;
    if (next){
        options = UIViewAnimationTransitionCurlUp;
    }
    else {
        options = UIViewAnimationTransitionCurlDown;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        [UIView setAnimationTransition:options forView:self.gridContentView cache:TRUE];
        [self reloadVisibleCalView];
        
    } completion:^(BOOL finished)
     {
         
     }];
    
//    [UIView transitionWithView:self.gridContentView
//                      duration:0.4
//                       options:options
//                    animations:^{
//                        
//                        [self reloadVisibleCalView];
//
//                    } completion:^(BOOL finished) {
//                        
//                        
//                    }];

}


- (void)reloadWithDatasource:(CheckInDTO *)dto
{
    dataSource = dto;
    
    if (dataSource) {
        self.currentMonth = dto.currentDate;
        [self reloadVisibleCalView];
    }
}

- (void)reloadVisibleCalView
{
    if (!dataSource) {
        return;
    }
    
    logic = [[CICalendarLogic alloc] initForDate:self.currentMonth.NSDate];
    
    [self showDates:logic.daysInSelectedMonth leadingAdjacentDates:logic.daysInFinalWeekOfPreviousMonth trailingAdjacentDates:logic.daysInFirstWeekOfFollowingMonth];
}

- (void)showDates:(NSArray *)mainDates leadingAdjacentDates:(NSArray *)leadingAdjacentDates trailingAdjacentDates:(NSArray *)trailingAdjacentDates
{
    int tileNum = 0;
    NSArray *dates[] = { leadingAdjacentDates, mainDates, trailingAdjacentDates };
    
    for (int i=0; i<3; i++)
    {
        for (CIDate *d in dates[i])
        {
            CICalendarGridView *gridView = [self.gridContentView.subviews objectAtIndex:tileNum];
            gridView.dto = dataSource;
            gridView.date = d;
            tileNum++;
        }
    }
    
    numWeeks = ceilf(tileNum / 7.f);
    [self sizeToFit];
    [self setNeedsDisplay];
}

- (void)sizeToFit
{
    self.gridContentView.height = kCICalGridHeight * numWeeks + 0.5;
    self.back.height = self.gridContentView.height+2;
    
    if (self.gridContentHeightChangeBlock) {
        self.gridContentHeightChangeBlock();
    }
}

#pragma mark -
#pragma mark grid view delegate

- (void)gridView:(CICalendarGridView *)gridView didSelectWithDate:(CIDate *)date
{
    if ([_delegate respondsToSelector:@selector(didSelectGridView:forDate:)])
    {
        [_delegate didSelectGridView:gridView forDate:date];
    }
}

@end
