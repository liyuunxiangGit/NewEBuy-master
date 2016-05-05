//
//  CalendarView.m
//  ZhangBen
//
//  Created by tinyfool on 08-10-26.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "TdCalendarView.h"
#import <QuartzCore/QuartzCore.h>

const float headHeight=44;
const float itemHeight=44;
const float prevNextButtonSize=20;
const float prevNextButtonSpaceWidth=15;
const float prevNextButtonSpaceHeight=12;
const float titleFontSize=18;
const int	weekFontSize=18;

@implementation TdCalendarView

@synthesize currentMonthDate;
@synthesize currentSelectDate;
@synthesize currentTime;
@synthesize viewImageView;
@synthesize calendarViewDelegate;
@synthesize disableBeginDate, disableEndDate;

-(void)initCalView{
	currentTime=CFAbsoluteTimeGetCurrent();
    CFTimeZoneRef defaultTimeZone = CFTimeZoneCopyDefault();
	currentMonthDate=CFAbsoluteTimeGetGregorianDate(currentTime,defaultTimeZone);
    CFRelease(defaultTimeZone);
	currentMonthDate.day=1;
	currentSelectDate.year=0;
	monthFlagArray=malloc(sizeof(int)*31);
	[self clearAllDayFlag];	
}
- (id)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
		[self initCalView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
	
	if (self = [super initWithFrame:frame]) {
		[self initCalView];
	}
	return self;
}

-(int)getDayCountOfaMonth:(CFGregorianDate)date{
	switch (date.month) {
		case 1:
		case 3:
		case 5:
		case 7:
		case 8:
		case 10:
		case 12:
			return 31;
			
		case 2:
			if(date.year%4==0 && date.year%100!=0)
				return 29;
			else
				return 28;
		case 4:
		case 6:
		case 9:		
		case 11:
			return 30;
		default:
			return 31;
	}
}

-(void)drawPrevButton:(CGPoint)leftTop
{
	CGContextRef ctx=UIGraphicsGetCurrentContext();
	CGContextSetGrayStrokeColor(ctx,0,1);
	CGContextMoveToPoint	(ctx,  0 + leftTop.x, prevNextButtonSize/2 + leftTop.y);
	CGContextAddLineToPoint	(ctx, prevNextButtonSize + leftTop.x,  0 + leftTop.y);
	CGContextAddLineToPoint	(ctx, prevNextButtonSize + leftTop.x,  prevNextButtonSize + leftTop.y);
	CGContextAddLineToPoint	(ctx,  0 + leftTop.x,  prevNextButtonSize/2 + leftTop.y);
	CGContextFillPath(ctx);
}

-(void)drawNextButton:(CGPoint)leftTop
{
	CGContextRef ctx=UIGraphicsGetCurrentContext();
	CGContextSetGrayStrokeColor(ctx,0,1);
	CGContextMoveToPoint	(ctx,  0 + leftTop.x,  0 + leftTop.y);
	CGContextAddLineToPoint	(ctx, prevNextButtonSize + leftTop.x,  prevNextButtonSize/2 + leftTop.y);
	CGContextAddLineToPoint	(ctx,  0 + leftTop.x,  prevNextButtonSize + leftTop.y);
	CGContextAddLineToPoint	(ctx,  0 + leftTop.x,  0 + leftTop.y);
	CGContextFillPath(ctx);
}
-(int)getDayFlag:(int)day
{
	if(day>=1 && day<=31)
	{
		return *(monthFlagArray+day-1);
	}
	else 
		return 0;
}
-(void)clearAllDayFlag
{
	memset(monthFlagArray,0,sizeof(int)*31);
}
-(void)setDayFlag:(int)day flag:(int)flag
{
	if(day>=1 && day<=31)
	{
		if(flag>0)
			*(monthFlagArray+day-1)=1;
		else if(flag<0)
			*(monthFlagArray+day-1)=-1;
	}
	
}
-(void)drawTopGradientBar{
	
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	
	size_t num_locations = 3;
	CGFloat locations[3] = { 0.0, 0.5, 1.0};
	CGFloat components[12] = {  
		1.0, 1.0, 1.0, 1.0,
		0.8, 0.8, 0.9, 1.0,
		1.0, 1.0, 1.0, 1.0 
	};
	
	
	CGGradientRef myGradient;
	CGColorSpaceRef myColorspace = CGColorSpaceCreateDeviceRGB();
	myGradient = CGGradientCreateWithColorComponents (myColorspace, components,
													  locations, num_locations);
    CGColorSpaceRelease(myColorspace);
	CGPoint myStartPoint, myEndPoint;
	myStartPoint.x = headHeight;
	myStartPoint.y = 0.0;
	myEndPoint.x = headHeight;
	myEndPoint.y = headHeight+350;
	
	CGContextDrawLinearGradient(ctx,myGradient,myStartPoint, myEndPoint, 0);
	CGGradientRelease(myGradient);

//	[self drawPrevButton:CGPointMake(prevNextButtonSpaceWidth,prevNextButtonSpaceHeight)];
//	[self drawNextButton:CGPointMake(self.frame.size.width-prevNextButtonSpaceWidth-prevNextButtonSize,prevNextButtonSpaceHeight)];
}

-(void)drawTopBarWords{
	int width=self.frame.size.width;
	int s_width=width/7;

	[[UIColor blackColor] set];
//	NSString *title_Month   = [[NSString alloc] initWithFormat:@"%d年%d月",currentMonthDate.year,currentMonthDate.month];
	
	int weekLocationY = 14;
    int weekLocationX = 12;
//    UIFont   *font    = [UIFont systemFontOfSize:titleFontSize];
//	CGPoint  location = CGPointMake(width/2 -2.5*titleFontSize, 10);
//    [title_Month drawAtPoint:location withFont:font];
//	[title_Month release];
	
	
	UIFont *weekfont=[UIFont boldSystemFontOfSize:weekFontSize];

	
	[@"一" drawAtPoint:CGPointMake(s_width*0+weekLocationX,weekLocationY) withFont:weekfont];
	[@"二" drawAtPoint:CGPointMake(s_width*1+weekLocationX,weekLocationY) withFont:weekfont];
	[@"三" drawAtPoint:CGPointMake(s_width*2+weekLocationX,weekLocationY) withFont:weekfont];
	[@"四" drawAtPoint:CGPointMake(s_width*3+weekLocationX,weekLocationY) withFont:weekfont];
	[@"五" drawAtPoint:CGPointMake(s_width*4+weekLocationX,weekLocationY) withFont:weekfont];
	[[UIColor darkRedColor] set];
	[@"六" drawAtPoint:CGPointMake(s_width*5+weekLocationX,weekLocationY) withFont:weekfont];
	[@"日" drawAtPoint:CGPointMake(s_width*6+weekLocationX,weekLocationY) withFont:weekfont];
	[[UIColor blackColor] set];
	
}

-(void)drawGirdLines{
	
	CGContextRef ctx=UIGraphicsGetCurrentContext();
	int width=self.frame.size.width;
	
	int s_width=width/7;
	
	for(int i=1;i<7;i++){
		CGContextSetGrayStrokeColor(ctx,1,1);
		CGContextMoveToPoint(ctx, i*s_width-1, headHeight-60);
		CGContextAddLineToPoint( ctx, i*s_width-1,300);
		CGContextStrokePath(ctx);
	}
	
	for(int i = 1;i< 7;i++){
		CGContextSetGrayStrokeColor(ctx,1,1);
		CGContextMoveToPoint(ctx, 0, i*itemHeight);
		CGContextAddLineToPoint( ctx, width,i*itemHeight);
		CGContextStrokePath(ctx);
		
    }
}


-(int)getMonthWeekday:(CFGregorianDate)date
{
	CFTimeZoneRef tz = CFTimeZoneCopyDefault();
	CFGregorianDate month_date;
	month_date.year=date.year;
	month_date.month=date.month;
	month_date.day=1;
	month_date.hour=0;
	month_date.minute=0;
	month_date.second=1;
	int monthWeekday = (int)CFAbsoluteTimeGetDayOfWeek(CFGregorianDateGetAbsoluteTime(month_date,tz),tz);
    CFRelease(tz);
    return monthWeekday;
}

-(void)drawDateWords{
    
	CGContextRef ctx=UIGraphicsGetCurrentContext();

	int width=self.frame.size.width;
	
	int dayCount=[self getDayCountOfaMonth:currentMonthDate];
	int day=0;
	int x=0;
	int y=0;
	int s_width=width/7;
	int curr_Weekday=[self getMonthWeekday:currentMonthDate];
	UIFont *weekfont=[UIFont boldSystemFontOfSize:18.0];

    BOOL isActivityTag = NO;//是否是可以点击状态,0表示灰色不可点击，1表示黑色可点击
    
	for(int i=1;i<dayCount+1;i++)
	{
		day=i+curr_Weekday-2;
		x=day % 7;
		y=day / 7;

        isActivityTag = [self isActivity:i];
        
		NSString *date=[[NSString alloc] initWithFormat:@"%2d",i];
		if (!isActivityTag) {
            CGContextSetRGBFillColor(ctx, 0.4, 0.4, 0.4, 1);
        }else{
            CGContextSetRGBFillColor(ctx, 0, 0, 0, 1);

        }
        [date drawAtPoint:CGPointMake(x*s_width+13,y*itemHeight+itemHeight+13) withFont:weekfont];		

	}
}


- (void) movePrevNext:(int)isPrev{
	currentSelectDate.year=0;
	[calendarViewDelegate beforeMonthChange:self willto:currentMonthDate];
	int width= 320;
	int posX;
	if(isPrev==1)
	{
		posX=width;
	}
	else
	{
		posX=-width;
	}
	
	UIImage *viewImage;
	
	UIGraphicsBeginImageContext(self.bounds.size);
	[self.layer renderInContext:UIGraphicsGetCurrentContext()];	
	viewImage= UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	if(viewImageView==nil)
	{
		viewImageView=[[UIImageView alloc] initWithImage:viewImage];
		
		viewImageView.center=self.center;
		[[self superview] addSubview:viewImageView];
	}
	else
	{
		viewImageView.image=viewImage;
	}

	viewImageView.hidden=NO;
	viewImageView.transform=CGAffineTransformMakeTranslation(0, 0);
	self.hidden=YES;
	[self setNeedsDisplay];
	self.transform=CGAffineTransformMakeTranslation(posX,0);
	
	
	float height;
	int row_Count=([self getDayCountOfaMonth:currentMonthDate]+[self getMonthWeekday:currentMonthDate]-2)/7+1;
	height=row_Count*itemHeight+headHeight;
	//self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
	self.hidden=NO;
	[UIView beginAnimations:nil	context:nil];
	[UIView setAnimationDuration:0.5];
	self.transform=CGAffineTransformMakeTranslation(0,0);
	viewImageView.transform=CGAffineTransformMakeTranslation(-posX, 0);
	[UIView commitAnimations];
	[calendarViewDelegate monthChanged:currentMonthDate viewLeftTop:self.frame.origin height:height];
	
}
- (void)movePrevMonth{
	if(currentMonthDate.month>1)
		currentMonthDate.month-=1;
	else
	{
		currentMonthDate.month=12;
		currentMonthDate.year-=1;
	}
	[self movePrevNext:0];
}
- (void)moveNextMonth{
	if(currentMonthDate.month<12)
		currentMonthDate.month+=1;
	else
	{
		currentMonthDate.month=1;
		currentMonthDate.year+=1;
	}
	[self movePrevNext:1];	
}
- (void) drawToday{
	int x;
	int y;
	int day;
    CFTimeZoneRef defaultTimeZone = CFTimeZoneCopyDefault();
	CFGregorianDate today=CFAbsoluteTimeGetGregorianDate(currentTime, defaultTimeZone);
    CFRelease(defaultTimeZone);
	if(today.month==currentMonthDate.month && today.year==currentMonthDate.year)
	{
		int width=self.frame.size.width;
		int swidth=width/7;
		int weekday=[self getMonthWeekday:currentMonthDate];
		day=today.day+weekday-2;
		x=day%7;
		y=day/7;
		CGContextRef ctx=UIGraphicsGetCurrentContext(); 
		CGContextSetRGBFillColor(ctx, 1.0, 0.6, 0, 1);
		CGContextMoveToPoint(ctx, x*swidth, y*itemHeight+itemHeight);
		CGContextAddLineToPoint(ctx, x*swidth+swidth, y*itemHeight+itemHeight);
		CGContextAddLineToPoint(ctx, x*swidth+swidth, y*itemHeight+itemHeight+itemHeight);
		CGContextAddLineToPoint(ctx, x*swidth, y*itemHeight+itemHeight+itemHeight);
		CGContextFillPath(ctx);

		CGContextSetRGBFillColor(ctx, 1, 1, 1, 1);
		UIFont *weekfont=[UIFont boldSystemFontOfSize:18];
		NSString *date=[[NSString alloc] initWithFormat:@"%2d",today.day];
		[date drawAtPoint:CGPointMake(x*swidth+13,y*itemHeight+itemHeight+13) withFont:weekfont];
		if([self getDayFlag:today.day]==1)
		{
			CGContextSetRGBFillColor(ctx, 1, 0, 0, 1);
			[@"." drawAtPoint:CGPointMake(x*swidth+19,y*itemHeight+headHeight+6) withFont:[UIFont boldSystemFontOfSize:25]];
		}
		else if([self getDayFlag:today.day]==-1)
		{
			CGContextSetRGBFillColor(ctx, 0, 8.5, 0.3, 1);
			[@"." drawAtPoint:CGPointMake(x*swidth+19,y*itemHeight+headHeight+6) withFont:[UIFont boldSystemFontOfSize:25]];
		}
		
	}
}
- (void) drawCurrentSelectDate{
	int x;
	int y;
	int day;
	int todayFlag;
	if(currentSelectDate.year!=0)
	{
        CFTimeZoneRef defaultTimeZone = CFTimeZoneCopyDefault();
		CFGregorianDate today=CFAbsoluteTimeGetGregorianDate(currentTime, defaultTimeZone);
        CFRelease(defaultTimeZone);

		if(today.year==currentSelectDate.year && today.month==currentSelectDate.month && today.day==currentSelectDate.day)
			todayFlag=1;
		else
			todayFlag=0;
        
		int width=self.frame.size.width;
		int swidth=width/7;
		int weekday=[self getMonthWeekday:currentMonthDate];
		day=currentSelectDate.day+weekday-2;
		x=day%7;
		y=day/7;
		CGContextRef ctx=UIGraphicsGetCurrentContext();
		
		if(todayFlag==1)
			CGContextSetRGBFillColor(ctx, 0, 0, 0.7, 1);
		else
			CGContextSetRGBFillColor(ctx, 0, 0, 1, 1);
		CGContextMoveToPoint(ctx, x*swidth, y*itemHeight+itemHeight);
		CGContextAddLineToPoint(ctx, x*swidth+swidth, y*itemHeight+itemHeight);
		CGContextAddLineToPoint(ctx, x*swidth+swidth, y*itemHeight+itemHeight+itemHeight);
		CGContextAddLineToPoint(ctx, x*swidth, y*itemHeight+itemHeight+itemHeight);
		CGContextFillPath(ctx);	
		
		if(todayFlag==1)
		{
			CGContextSetRGBFillColor(ctx, 0, 0, 1, 1);
			CGContextMoveToPoint	(ctx, x*swidth,			y*itemHeight+itemHeight+3);
			CGContextAddLineToPoint	(ctx, x*swidth+swidth,	y*itemHeight+itemHeight+3);
			CGContextAddLineToPoint	(ctx, x*swidth+swidth,	y*itemHeight+itemHeight+itemHeight-3);
			CGContextAddLineToPoint	(ctx, x*swidth,			y*itemHeight+itemHeight+itemHeight-3);
			CGContextFillPath(ctx);	
		}
		
		CGContextSetRGBFillColor(ctx, 1, 1, 1, 1);

		UIFont *weekfont=[UIFont boldSystemFontOfSize:18];
		NSString *date=[[NSString alloc] initWithFormat:@"%2d",currentSelectDate.day];
		[date drawAtPoint:CGPointMake(x*swidth+12,y*itemHeight+itemHeight+12) withFont:weekfont];
		if([self getDayFlag:currentSelectDate.day]!=0)
		{
			[@"." drawAtPoint:CGPointMake(x*swidth+19,y*itemHeight+itemHeight+6) withFont:[UIFont boldSystemFontOfSize:25]];
		}		
	}
}
- (void) touchAtDate:(CGPoint) touchPoint{
	int x;
	int y;
	int width=self.frame.size.width;
	int weekday=[self getMonthWeekday:currentMonthDate];
	int monthDayCount=[self getDayCountOfaMonth:currentMonthDate];
	x=touchPoint.x*7/width;
	y=(touchPoint.y-headHeight)/itemHeight;
	int monthday=x+y*7-weekday+2;
    
    BOOL isActivity = NO;
    isActivity = [self isActivity:monthday];
    if(!isActivity){
        return; 
    }
	if(monthday>0 && monthday<monthDayCount+1)
	{
		currentSelectDate.year=currentMonthDate.year;
		currentSelectDate.month=currentMonthDate.month;
		currentSelectDate.day=monthday;
		currentSelectDate.hour=0;
		currentSelectDate.minute=0;
		currentSelectDate.second=1;
		[calendarViewDelegate selectDateChanged:currentSelectDate];
		[self setNeedsDisplay];
	}
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {

	UITouch* touch=[touches anyObject];
	CGPoint touchPoint=[touch locationInView:self];
	if(touchPoint.y>headHeight)
	{
		[self touchAtDate:touchPoint];
	}
}

- (void)drawRect:(CGRect)rect{

	static int once=0;
	currentTime=CFAbsoluteTimeGetCurrent();
	
	[self drawTopGradientBar];
	[self drawTopBarWords];
	[self drawGirdLines];
	
	if(once==0)
	{
		once=1;
		float height;
		int row_Count=([self getDayCountOfaMonth:currentMonthDate]+[self getMonthWeekday:currentMonthDate]-2)/7+1;
		height=row_Count*itemHeight+headHeight;
		[calendarViewDelegate monthChanged:currentMonthDate viewLeftTop:self.frame.origin height:height];
		[calendarViewDelegate beforeMonthChange:self willto:currentMonthDate];

	}
    
    [calendarViewDelegate returnCurrentYearAndMonth:currentMonthDate];

	[self drawDateWords];
	[self drawToday];
	[self drawCurrentSelectDate];
	
}
- (void)dealloc {
	free(monthFlagArray);
}


-(NSDate*)dateFromString:(NSString*)dateStr{
    
    if (IsNilOrNull(dateStr)) {
        return nil;
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-M-d"];
    NSDate *date = [formatter dateFromString:dateStr];
    DLog(@"%@", dateStr);
    TT_RELEASE_SAFELY(formatter);
    return date;

}

- (NSDate *)getDateOfFewDays:(NSInteger)dayCount{
    
    NSDate *today = [NSDate date];
    NSDate *fewsDayDate = [today dateByAddingTimeInterval:dayCount*24*3600];
    return fewsDayDate;
    
}

/************如果在今天之前或者从今天往后数364天，则不可以选择***************/
-(BOOL)isActivity:(int)i{
    BOOL isActivityTag = NO;
    //liukun modify
    CFAbsoluteTime beginTime;
    if (self.disableBeginDate) {
        beginTime = CFDateGetAbsoluteTime((CFDateRef)self.disableBeginDate);
    }else{
        beginTime = currentTime;
    }
    CFTimeZoneRef defaultTimeZone = CFTimeZoneCopyDefault();
    CFGregorianDate beginDate=CFAbsoluteTimeGetGregorianDate(beginTime, defaultTimeZone);
    
    CFAbsoluteTime endTime;
    if (self.disableEndDate) {
        endTime = CFDateGetAbsoluteTime((CFDateRef)self.disableEndDate);
    }else{
        CFDateRef endDateRef = (__bridge CFDateRef)[NSDate dateWithTimeIntervalSinceNow:364*24*3600];
        endTime = CFDateGetAbsoluteTime(endDateRef);
    }
    CFGregorianDate endDate =CFAbsoluteTimeGetGregorianDate(endTime, defaultTimeZone);
    CFRelease(defaultTimeZone);

    if (currentMonthDate.year < beginDate.year) {
        isActivityTag = NO;
    }else if(currentMonthDate.year == beginDate.year){
        if (currentMonthDate.month < beginDate.month){
            isActivityTag = NO;
        }else if(currentMonthDate.month == beginDate.month){
            if (i<beginDate.day) {
                isActivityTag = NO;
            }else{
                isActivityTag = YES;
            }
        }else{
            isActivityTag = YES;
        }
    }else{
        isActivityTag = YES;        
    }
    
    //判断结束时间
    if (currentMonthDate.year > endDate.year) {
        isActivityTag = NO;
    }else if(currentMonthDate.year == endDate.year){
        if (currentMonthDate.month > endDate.month) {
            isActivityTag = NO;
        }else if(currentMonthDate.month == endDate.month){
            if (i>endDate.day) {
                isActivityTag = NO;
            }else{
                //isActivityTag = YES;
            }
        }else{
            //isActivityTag = YES;
        }
        
    }else{
        //isActivityTag = YES;
    }
    
    return isActivityTag;
}
@end
