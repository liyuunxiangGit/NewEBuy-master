//
//  HomePageService244.m
//  SuningEBuy
//
//  Created by zhangbeibei on 14-9-18.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "HomePageService244.h"
#import "KCOpenUDID.h"
#import "HomeFloorDTO.h"
#import "HomeModuleDTO.h"

@implementation HomePageService244

- (void)dealloc {
    
    HTTPMSG_RELEASE_SAFELY(homeDataHttpMsg);
    HTTPMSG_RELEASE_SAFELY(homeDataVersionHttpMsg);
    HTTPMSG_RELEASE_SAFELY(secondPageHttpMsg);
}

- (NSMutableArray *)floorArray
{
    if (!_floorArray) {
        _floorArray=[[NSMutableArray alloc]init];
    }
    return _floorArray;
}


/**
 *  获取客户端首页版本号信息
 *
 */
- (void)queryHomeVersion {
    //http://api.m.suning.com/data-v.do
    NSString *url = [NSString stringWithFormat:@"%@data-v.do",
                     KNewHomeAPIURL];
    
    HTTPMSG_RELEASE_SAFELY(homeDataVersionHttpMsg);
    
    homeDataVersionHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                        requestUrl:url
                                                       postDataDic:nil
                                                           cmdCode:CC_HomeVersion];
    homeDataVersionHttpMsg.requestMethod = RequestMethodGet;

    homeDataVersionHttpMsg.timeout = 5.0f;
    
    [self.httpMsgCtrl sendHttpMsg:homeDataVersionHttpMsg];
}


/**
 *  获取首页楼层数据
 *  接口只需要terminalID、channnelID、versionNumber
 *  方法内部自动获取这些参数
 */
- (void)queryHomePageData {
    //get请求需要在url上传递一个参数 v=2.4.4
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[GlobalDataCenter defaultCenter].homeDataVersion, @"v", nil];

    NSString *url = [NSString stringWithFormat:@"%@wapdata/homepage/get_%@_%@_%@.html",
                     KNewHomeAPIURL,
                     @"30000",
                     getDownloadChannelId() ? getDownloadChannelId() : @"",
                     [SystemInfo appVersion]];
    
    HTTPMSG_RELEASE_SAFELY(homeDataHttpMsg);
    
    homeDataHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                        requestUrl:url
                                                       postDataDic:dic
                                                           cmdCode:CC_HomePage];
    homeDataHttpMsg.requestMethod = RequestMethodGet;
    TT_RELEASE_SAFELY(dic);
    
    [self.httpMsgCtrl sendHttpMsg:homeDataHttpMsg];
}


/**
 *  获取聚合页信息(二级页面)
 *
 *  @param pageID 聚合页ID
 */
- (void)querySecondPageWithPageID:(NSString *)pageID {
    
    if (IsStrEmpty(pageID)) {
        return;
    }

    NSString *url = [NSString stringWithFormat:@"%@wapdata/secondpage/get_%@.html", KNewHomeAPIURL, pageID];
    
    HTTPMSG_RELEASE_SAFELY(secondPageHttpMsg);
    
    secondPageHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                 requestUrl:url
                                                postDataDic:nil
                                                    cmdCode:CC_HomeSecondPage];
    secondPageHttpMsg.requestMethod = RequestMethodGet;
    
    [self.httpMsgCtrl sendHttpMsg:secondPageHttpMsg];
}


#pragma mark - HttpRequset代理回调方法
- (void)receiveDidFinished:(HttpMessage *)receiveMsg {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        switch (receiveMsg.cmdCode) {
            case CC_HomePage: {
                //解析首页楼层数据
                [self parseMessage:receiveMsg];
                break;
            }
            case CC_HomeVersion: {
                //解析客户端版本信息
                [self parseVersionMessage:receiveMsg];
                break;
            }
            case CC_HomeSecondPage: {
                //解析聚合页数据，页面集数据和首页一样，都是楼层
                [self parseMessage:receiveMsg];
                break;
            }
            default:
                break;
        }
    });
}


- (void)receiveDidFailed:(HttpMessage *)receiveMsg {
    //初始化异常提示文字
    if (receiveMsg.responseStatusCode == 0) {
        self.errorMsg = L(@"NWFailTryLater");
    }
    else if (receiveMsg.responseStatusCode > 400) {
        self.errorMsg = L(@"NWBusyTryLater");
    }

    switch (receiveMsg.cmdCode) {
        case CC_HomeSecondPage:
        case CC_HomePage: {
            if (KPerformance)
            {
                PerformanceStatisticsHttp* temp = [[PerformanceStatisticsHttp alloc] init];
                temp.startTime = [NSDate date];
                temp.functionId = @"2";
                temp.interfaceId = @"101";
                temp.errorType = @"02";
                temp.errorCode = [NSString stringWithFormat:@"%@",receiveMsg.errorCode];
                [[PerformanceStatistics sharePerformanceStatistics]sendCustomNetData:temp];
            }
            [self parseResult:NO];
            break;
        }
        case CC_HomeVersion: {
            //版本号接口失败
            [self parseVersionResultHomeDataVersion:nil homeSwitchVersion:nil];
            break;
        }
        default:
            break;
    }
}


/**
 *  解析版本号接口数据
 *
 *  @param receiveMsg HttpMessage对象
 */
- (void)parseVersionMessage:(HttpMessage *)receiveMsg {
    //获取json字典
    NSDictionary *jsonObject = receiveMsg.jasonItems;
    
    //初始定义版本号的值
    NSString *homeDataVersion = @"-2";
    NSString *homeSwitchVersion = @"-2";
    
    if (NotNilAndNull(jsonObject)) {
        NSString *resultCode = [receiveMsg.jasonItems objectForKey:@"code"];
        if ([resultCode isEqualToString:@"0"]) {
            //成功
            NSDictionary *dataDcit = (NSDictionary *)[receiveMsg.jasonItems objectForKey:@"data"];
            if (NotNilAndNull(dataDcit)) {
                homeDataVersion = EncodeStringFromDic(dataDcit, @"v1");
                homeSwitchVersion = EncodeStringFromDic(dataDcit, @"v2");
            }
        }
    }
    
    //json解析完成，后面处理更新相关的逻辑判断
    [self parseVersionResultHomeDataVersion:homeDataVersion homeSwitchVersion:homeSwitchVersion];
}


/**
 *  版本号接口逻辑处理
 *
 *  @param v1 首页楼层数据版本号
 *  @param v2 开关数据版本号
 */
- (void)parseVersionResultHomeDataVersion:(NSString *)v1 homeSwitchVersion:(NSString *)v2 {
    //标识位，默认需要更新
    BOOL needRefreshHomeData = YES;
    BOOL needRefreshSwitchData = YES;
    
    //判断是否需要更新
    if (!IsStrEmpty(v1) && [v1 isEqualToString:[GlobalDataCenter defaultCenter].homeDataVersion]) {
        needRefreshHomeData = NO;
    }
    
    if (!IsStrEmpty(v2) && [v2 isEqualToString:[GlobalDataCenter defaultCenter].homeSwitchVersion]) {
        needRefreshSwitchData = NO;
    }
    
    //为单例里的版本号赋值
    if (IsStrEmpty(v1) || [v1 isEqualToString:@"-2"]) {
        //出现异常之后，设置版本号为0，便于首页直接请求数据
        [GlobalDataCenter defaultCenter].homeDataVersion = @"0";
    }
    else {
        [GlobalDataCenter defaultCenter].homeDataVersion = v1;
    }
    
    if (IsStrEmpty(v2) || [v2 isEqualToString:@"-2"]) {
        [GlobalDataCenter defaultCenter].homeSwitchVersion = @"0";
    }
    else {
        [GlobalDataCenter defaultCenter].homeSwitchVersion = v2;
    }
    
    //处理结束，代理返回到controller
    dispatch_async(dispatch_get_main_queue(), ^{
        if (_delegate && [_delegate respondsToSelector:@selector(homeVersionServiceComplete:homeDataFlag:homeSwitchFlag:)]) {
            [_delegate homeVersionServiceComplete:self homeDataFlag:needRefreshHomeData homeSwitchFlag:needRefreshSwitchData];
        }
    });
}


/**
 *  解析首页、聚合页的楼层数据
 *
 *  @param receiveMsg HttpMessage对象
 */
- (void)parseMessage:(HttpMessage *)receiveMsg {
    NSDictionary *jsonObject = receiveMsg.jasonItems;
    
    //是否解析出有效的json对象
    if (NotNilAndNull(jsonObject)) {
        NSString *resultCode = [receiveMsg.jasonItems objectForKey:@"code"];
        
        //接口标志位是否是成功
        if ([resultCode isEqualToString:@"0"]) {
            //成功
            NSDictionary *dataDcit = (NSDictionary *)[receiveMsg.jasonItems objectForKey:@"data"];
            
            if (NotNilAndNull(dataDcit)) {
                self.pageName = (NSString *)[dataDcit objectForKey:@"pagename"];
                NSArray *floorArray = (NSArray *)[dataDcit objectForKey:@"floorlist"];
                
                //处理楼层数据
                if (!IsArrEmpty(floorArray)) {
                    NSMutableArray *tempResultArray = [[NSMutableArray alloc] initWithCapacity:[floorArray count]];
                    @autoreleasepool {
                        
                        for (int i = 0; i < [floorArray count]; i++) {
                            NSDictionary *floorDict = (NSDictionary *)[floorArray objectAtIndex:i];
                            
                            HomeFloorDTO *floorDTO = [[HomeFloorDTO alloc] init];
                            floorDTO.orderNO = (NSString *)[floorDict objectForKey:@"orderno"];
                            floorDTO.floorName = (NSString *)[floorDict objectForKey:@"floorname"];
                            floorDTO.templateID = (NSString *)[floorDict objectForKey:@"templateid"];
                            
                            NSArray *moduleArray = (NSArray *)[floorDict objectForKey:@"modulelist"];
                            
                            //处理楼层里的模块
                            if (!IsArrEmpty(moduleArray)) {
                                NSMutableArray *moduleResultArray = [[NSMutableArray alloc] initWithCapacity:[moduleArray count]];
                                
                                for (int j = 0; j < [moduleArray count]; j++) {
                                    NSDictionary *moduleDict = (NSDictionary *)[moduleArray objectAtIndex:j];
                                    
                                    HomeModuleDTO *moduleDTO = [[HomeModuleDTO alloc] init];
                                    [moduleDTO parseFromDict:moduleDict];
                                    [moduleResultArray addObject:moduleDTO];
                                }
                                floorDTO.moduleList = moduleResultArray;
                            }
                            
                            [tempResultArray addObject:floorDTO];
                        }
                    }

                    self.floorArray = tempResultArray;
                }
            }
            //接口成功
            [self parseResult:YES];
        }
        else {
            self.errorMsg = L(@"NWErrorTryLater");
            [self parseResult:NO];
        }
    }
    else {
        self.errorMsg = L(@"NWErrorTryLater");
        [self parseResult:NO];
    }
}


/**
 *  解析首页、聚合页的最终结果
 *
 *  @param result 成功、失败标志位
 */
- (void)parseResult:(BOOL )result {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (_delegate && [_delegate respondsToSelector:@selector(homePageServiceComplete:isSuccess:)]) {
            [_delegate homePageServiceComplete:self isSuccess:result];
        }
    });

}


/**
 *  取消二级页的请求
 */
- (void)cancelSecondPageRequest {
    [homeDataHttpMsg cancelDelegateAndCancel];
}

@end
