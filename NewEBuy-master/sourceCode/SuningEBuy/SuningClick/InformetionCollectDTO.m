//
//  InformetionCollectDTO.m
//  SuningEBuy
//
//  Created by xy ma on 11-12-22.
//  Copyright (c) 2011年 sn. All rights reserved.
//

#import "InformetionCollectDTO.h"

@implementation InformetionCollectDTO



@synthesize appVersion = _appVersion;
@synthesize sysKind = _sysKind;
@synthesize osVersion = _osVersion;
@synthesize platform = _platform;
@synthesize userIP = _userIP;
@synthesize uniqueId = _uniqueId;
@synthesize sessionId = _sessionId;
@synthesize appDownWay = _appDownWay;
@synthesize isLogin = _isLogin;
@synthesize loginName = _loginName;
@synthesize field1 = _field1;
@synthesize field2 = _field2;
@synthesize appStartTime = _appStartTime;
@synthesize appStopTime = _appStopTime;
@synthesize registerName = _registerName;
@synthesize orderNum = _orderNum;
@synthesize searchKey = _searchKey;
@synthesize searchResult = _searchResult;
@synthesize pageKey = _pageKey;
@synthesize pageName = _pageName;
@synthesize pageInTime = _pageInTime;
@synthesize pageOutTime = _pageOutTime;
@synthesize crashInfo = _crashInfo;



-(void)dealloc{
    
    TT_RELEASE_SAFELY(_appVersion);
    TT_RELEASE_SAFELY(_sysKind);
    TT_RELEASE_SAFELY(_osVersion);
    TT_RELEASE_SAFELY(_platform);
    TT_RELEASE_SAFELY(_userIP);
    TT_RELEASE_SAFELY(_uniqueId);
    TT_RELEASE_SAFELY(_sessionId);
    TT_RELEASE_SAFELY(_appDownWay);
    TT_RELEASE_SAFELY(_isLogin);
    TT_RELEASE_SAFELY(_loginName);
    TT_RELEASE_SAFELY(_field1);
    TT_RELEASE_SAFELY(_field2);
    TT_RELEASE_SAFELY(_appStartTime);
    TT_RELEASE_SAFELY(_appStopTime);
    TT_RELEASE_SAFELY(_registerName);
    TT_RELEASE_SAFELY(_orderNum);
    TT_RELEASE_SAFELY(_searchKey);
    TT_RELEASE_SAFELY(_searchResult);
    TT_RELEASE_SAFELY(_pageKey);
    TT_RELEASE_SAFELY(_pageName);
    TT_RELEASE_SAFELY(_pageInTime);
    TT_RELEASE_SAFELY(_pageOutTime);
    TT_RELEASE_SAFELY(_crashInfo);
}


@end
