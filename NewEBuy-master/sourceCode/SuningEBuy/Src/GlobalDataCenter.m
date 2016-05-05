//
//  GlobalDataCenter.m
//  SuningEBuy
//
//  Created by  liukun on 12-11-9.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "GlobalDataCenter.h"
#import "Reachability.h"

#define kTimeInterval       0.6

@interface GlobalDataCenter()


@end

/*********************************************************************/

@implementation GlobalDataCenter

@synthesize activitySwitchMap = _activitySwitchMap;

@synthesize isMultiTouch = _isMultiTouch;
@synthesize homeDataVersion;
@synthesize homeSwitchVersion;

- (void)dealloc
{
    
    TT_RELEASE_SAFELY(_activitySwitchMap);
    
}

-(void)setIsMultiTouch:(BOOL)isMultiTouch
{
    _isMultiTouch = YES;
    
    [NSTimer scheduledTimerWithTimeInterval:kTimeInterval
                                     target:self
                                   selector:@selector(setMultiTouchEvent)
                                   userInfo:nil
                                    repeats:NO];
}

-(void)setMultiTouchEvent
{
    _isMultiTouch = NO;
}


- (id)init
{
    self = [super init];
    if (self) {
        self.homeDataVersion = [NSString stringWithFormat:@"-1"];
        self.homeSwitchVersion = [NSString stringWithFormat:@"0"];
        
        self.floorID_TypeDict = @{@"-88"   : @"1",
                             @"20024" : @"2",
                             @"20001" : @"3",
                             @"20002" : @"4",
                             @"20003" : @"5",
                             @"20004" : @"6",
                             @"20005" : @"7",
                             @"20006" : @"8",
                             @"20007" : @"9",
                             @"20008" : @"10",
                             @"20009" : @"11",
                             @"20020" : @"12",
                             @"20026" : @"13",
                             @"20021" : @"14",
                             @"20010" : @"15",
                             @"20022" : @"16",
                             @"20023" : @"17",
                             @"20011" : @"18",
                             @"20012" : @"19",
                             @"20013" : @"20",
                             @"20014" : @"21",
                             @"20015" : @"22"};
        
        self.homeCellHeightDict = [[NSMutableDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"FloorHeightDict" ofType:@"plist"]];
        
        self.hasShownFloatingView = NO;
    }
    return self;
}

#pragma mark Singleton methods
#pragma mark 单例方法

static GlobalDataCenter *instance = nil;

+ (GlobalDataCenter *)defaultCenter
{
    @synchronized(self){
        if (instance == nil) {
            instance = [[GlobalDataCenter alloc] init];
            
        }
    }
    return instance;
}



@end
