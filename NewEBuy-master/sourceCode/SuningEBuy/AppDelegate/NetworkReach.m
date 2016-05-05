//
//  NetworkReach.m
//  Dtouching
//
//  Created by 刘坤 on 12-5-12.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "NetworkReach.h"
#import "Reachability.h"

@interface NetworkReach()
{
    NetworkStatus lastNetworkStatus;
}

@property (nonatomic, strong) BBAlertView  *networkAlert;

- (void)updateInterfaceWithReachability:(Reachability *)curReach;

@end

/*********************************************************************/

@implementation NetworkReach

@synthesize isNetReachable = _isNetReachable;
@synthesize isHostReach = _isHostReach;

@synthesize hostReach = _hostReach;
@synthesize networkAlert = _networkAlert;
@synthesize reachableCount = _reachableCount;

- (void)dealloc
{
   
    TT_RELEASE_SAFELY(_hostReach);
    TT_RELEASE_SAFELY(_networkAlert);
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
}

#pragma mark -
#pragma mark Reachability


- (void)initNetwork
{
    _isHostReach= NO;
		
	[[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(reachabilityChanged:)
												 name: kReachabilityChangedNotification
                                               object: nil];
	
	
	
	_hostReach = [Reachability reachabilityWithHostName:kNetworkTestAddress];
	[_hostReach startNotifier];
	
}

- (void)reachabilityChanged: (NSNotification*)note
{
    
	Reachability* curReach = [note object];
	NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
	[self updateInterfaceWithReachability:curReach];
}

-(void)updateInterfaceWithReachability:(Reachability *)curReach
{
	SNLogInfo(@"\n ======Reachable === <%d>=== \n",_hostReach.currentReachabilityStatus);
    
    
    _reachableCount++;
    
    if (1 == _reachableCount) {
        
        return;
    }
    
//    [NSObject cancelPreviousPerformRequestsWithTarget:self
//                                             selector:@selector(showNetworkAlertMessage)
//                                               object:nil];
    [NSObject cancelPreviousPerformRequestsWithTarget:self
                                             selector:@selector(changeStatus)
                                               object:nil];
    
    if (NotReachable == _hostReach.currentReachabilityStatus)
    {
        
//       if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
//       {
//           [self performSelector:@selector(showNetworkAlertMessage) withObject:nil afterDelay:2];
//       }
    }
    else
    {
        
        if (AUTO_QUAILTY == [[Config currentConfig].imageQuailty intValue]) {
            //提示网络切换
            
            [self performSelector:@selector(changeStatus) withObject:nil afterDelay:2];
        }
    }


}

- (void)changeStatus
{
    UIView *contentView = APP_DELEGATE.tabBarViewController.view;
    
    if (_hostReach.currentReachabilityStatus != lastNetworkStatus)
    {
        if (ReachableViaWiFi == _hostReach.currentReachabilityStatus){
            
            [contentView showTipViewAtCenter:L(@"APPDelegate_ChangedToWifi")];
            
        }
        else
        {
            [contentView showTipViewAtCenter:L(@"APPDelegate_ChangedToNormal")];
        }
        
        lastNetworkStatus = _hostReach.currentReachabilityStatus;
    }
}


-(BOOL)isNetReachable
{
	_isNetReachable = self.isHostReach;
	return _isNetReachable;
}


- (BOOL)isHostReach
{
    
	_isHostReach = [_hostReach currentReachabilityStatus] != NotReachable;
    
    return _isHostReach;
}

- (BBAlertView *)networkAlert
{
    if (!_networkAlert) {
        _networkAlert = [[BBAlertView alloc] initWithTitle:L(@"system-error")
                                                   message:L(@"NotReachable")
                                                  delegate:nil 
                                         cancelButtonTitle:L(@"Ok") 
                                         otherButtonTitles:nil];
        __weak NetworkReach *weakSelf = self;
        [_networkAlert setCancelBlock:^{
            [weakSelf setNetworkAlert:nil];
        }];
    }
    return _networkAlert;
}

- (void)showNetworkAlertMessage
{
    //modify by liukun at 2014/5/13, 不提示网络弹框
    return;
//    if (![self.networkAlert isVisible]) {
//        [self.networkAlert show];
//    }
}

@end
