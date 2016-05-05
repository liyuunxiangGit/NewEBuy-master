//
//  DMOrderService.m
//  SuningEBuy
//
//  Created by li xiaokai on 13-5-8.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "DMOrderService.h"
#import <SDWebImageDownloader.h>
#import <sys/utsname.h>

@implementation DMOrderService


-(void)dealloc{
    
   
    HTTPMSG_RELEASE_SAFELY(DMHttpMsg);
    
}

-(void)getDMOrderRequest:(DMOrderDTO *)dmDto{
    
  //  [self retain];
    
    NSDictionary *postDataDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 dmDto.platform?dmDto.platform:@"",@"platform",
                                 dmDto.appId?dmDto.appId:@"",@"appId",
                                 dmDto.provinceId?dmDto.provinceId:@"e",@"provinceId",
                                 dmDto.cityId?dmDto.cityId:@"",@"cityId",
                                 dmDto.districtId?dmDto.districtId:@"",@"districtId",
                                 dmDto.storeId?dmDto.storeId:@"",@"storeId",
                                 dmDto.dmType?dmDto.dmType:@"",@"dmType",
                                 
                                 nil];
    
#if DM_DEBUG
    NSString *url = @"http://sn-cnhq-6594t.sn.suning.ad:8081/log/SNDMTest";
#else
    NSString *url = [NSString stringWithFormat:@"%@/dealWithDm.do",kMobileHostAddress];
//    NSString *url = [NSString stringWithFormat:@"%@/dealWithDm.do",@"http://10.22.3.155:8080/mms"];
#endif
    
    
    HTTPMSG_RELEASE_SAFELY(DMHttpMsg);
    
    DMHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                       requestUrl:url
                                                      postDataDic:postDataDic
                                                          cmdCode:CC_DMOrder];
    
    [self.httpMsgCtrl sendHttpMsg:DMHttpMsg];
    TT_RELEASE_SAFELY(postDataDic);

}

//迁移系统后新的启动页Dms获取接口
-(void)getDMArrayRequest:(NSString*)cityId
{
    NSString *versionId = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    versionId = [versionId stringByReplacingOccurrencesOfString:@"." withString:@""];
    
    NSString *url = [NSString stringWithFormat:@"%@dm/getEffectDM_Iphone_SNEBUY_%@_%@.html",KNewHomeAPIURL,versionId,cityId];
    
    HTTPMSG_RELEASE_SAFELY(DMHttpMsg);
    
    DMHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                           requestUrl:url
                                          postDataDic:nil
                                              cmdCode:CC_DMArray];
    
    DMHttpMsg.requestMethod = RequestMethodGet;
    
    [self.httpMsgCtrl sendHttpMsg:DMHttpMsg];
}

- (void)receiveDidFailed:(HttpMessage *)receiveMsg{
    
    [super receiveDidFailed:receiveMsg];
    
    if (receiveMsg.cmdCode == CC_DMOrder)
    {
        if (KPerformance)
        {
            NSLog(@"%@",receiveMsg.errorCode);
        }
        
        if ([_delegate respondsToSelector:@selector(service:result:)])
        {
            [_delegate service:self result:nil];
        }
    }
}
- (void)receiveDidFinished:(HttpMessage *)receiveMsg{
    
    if (receiveMsg.cmdCode == CC_DMOrder) {
        if (receiveMsg.jasonItems == nil) {
            
            self.errorMsg = kHttpResponseJSONValueFailError;
            
            if ([_delegate respondsToSelector:@selector(service:result:)])
            {
                [_delegate service:self result:nil];
            }
            
        }else{
            
            
            
            NSArray *array = [receiveMsg.jasonItems objectForKey:@"dmInfoList"];
            
            if (NotNilAndNull(array) && 1 == [array count]) {
                
                DMOrderResultDTO *dto = [[DMOrderResultDTO alloc] init];
                
                [dto encodeFromDictionary:(NSDictionary*)[array objectAtIndex:0]];
                
                if ([_delegate respondsToSelector:@selector(service:result:)])
                {
                    [_delegate service:self result:dto];
                }
                
            }
            else
            {
                self.errorMsg = L(@"get category unsuccess");
                
                if ([_delegate respondsToSelector:@selector(service:result:)])
                {
                    [_delegate service:self result:nil];
                }
            }
        }
    }else{
        if (receiveMsg.jasonItems != nil&&!IsArrEmpty([receiveMsg.jasonItems objectForKey:@"data"]))
        {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                NSArray *DMarray = [receiveMsg.jasonItems objectForKey:@"data"];
                
                NSMutableArray *localSaveDmArray = [Config currentConfig].launchDms;
            
                
                if (IsArrEmpty(localSaveDmArray))
                {
                    [self  downloadDmInLocal:DMarray];
                }else{
                    
                    localSaveDmArray = [self removeOutDateDM:localSaveDmArray dmArray:DMarray];
                    
                    NSArray *needDownloadArray = [self needDownloadDMs:DMarray localArray:localSaveDmArray];
                    
                    if (!IsArrEmpty(needDownloadArray))
                    {
                        [self downloadDmInLocal:needDownloadArray];
                    }
                }
            });
        }else{
            
            if (!IsArrEmpty([Config currentConfig].launchDms))
            {
                [Config currentConfig].launchDms = [NSMutableArray arrayWithArray:nil];
            }
        }
    }
}

//移除本地已过期的dm
-(NSMutableArray*)removeOutDateDM:(NSMutableArray*)localArray dmArray:(NSArray*)dmArray
{
    NSMutableArray *array = [NSMutableArray arrayWithArray:localArray];
    
    for (NSDictionary *item in localArray)
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
        
        NSDate *endTime = [dateFormatter dateFromString:[item objectForKey:@"dmEndTime"]];
        
        //移除过期dm
        if ([[NSDate date] compare:endTime] == NSOrderedDescending)
        {
            [array removeObject:item];
            
        }else{
            
            for (NSDictionary *dict in dmArray)
            {
                if ([[item objectForKey:[self getDMUrlModeOfMyIphone]] isEqualToString:[dict objectForKey:[self getDMUrlModeOfMyIphone]]])
                {
                    //更新除图片数据以外的其他数据
                    NSData *imageData = [item objectForKey:@"imagedata"];
                    
                    NSMutableDictionary *dmDict = [NSMutableDictionary dictionaryWithDictionary:dict];
                    
                    [array addObject:dmDict];
                    
                    [array removeObject:item];
                    
                    [dmDict setObject:imageData forKey:@"imagedata"];
                    
                    break;
                    
                }else{
                    //移除服务端已删除dm
                    if ([dmArray lastObject] == dict)
                    {
                        [array removeObject:item];
                        
                        break;
                    }
                }
            }
            
        }
    }
    
    [Config currentConfig].launchDms = [NSMutableArray arrayWithArray:array];
    
    return array;
}

//判断从服务端取回的dm是否有本地没有的
-(NSArray*)needDownloadDMs:(NSArray*)dmArray localArray:(NSMutableArray*)localArray
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:10];
    
    for (NSDictionary *item in dmArray)
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
        
        NSDate *endTime = [dateFormatter dateFromString:[item objectForKey:@"dmEndTime"]];
        
        //服务端过期dm不下载
        if ([[NSDate date] compare:endTime] == NSOrderedDescending)
        {
            break;
            
        }else{
            if (IsArrEmpty(localArray))
            {
                [array addObject:item];
                
                break;
            }else{
                
                for (NSDictionary *dict in localArray)
                {
                    //本地已缓存的dm不下载
                    if ([[item objectForKey:[self getDMUrlModeOfMyIphone]] isEqualToString:[dict objectForKey:[self getDMUrlModeOfMyIphone]]])
                    {
                        break;
                    }else{
                        if ([localArray lastObject] == dict)
                        {
                            [array addObject:item];
                            
                            break;
                        }
                    }
                }
                
            }
        }
    }
    
    return array;
}

-(void)downloadDmInLocal:(NSArray*)dms
{
    [[SDWebImageDownloader sharedDownloader] setMaxConcurrentDownloads:1];
    
    for (NSDictionary *item in dms)
    {
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:item];
        
        NSString *urlString = [item objectForKey:[self getDMUrlModeOfMyIphone]];
        
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:urlString] options:0 progress:nil completed:^(UIImage *image,NSData *data,NSError *error,BOOL finished){

            if (finished && data)
            {
                [dict setObject:data forKey:@"imagedata"];
                
                if (IsArrEmpty([Config currentConfig].launchDms))
                {
                    [Config currentConfig].launchDms = [NSMutableArray arrayWithObject:dict];
                    
                }else
                {
                    NSMutableArray *array = [NSMutableArray arrayWithArray:[Config currentConfig].launchDms];
                    
                    [array addObject:dict];
                    
                    [Config currentConfig].launchDms = [NSMutableArray arrayWithArray:array];
                }
                
                //NSLog(@"launchDms >><<>><><><%@",[Config currentConfig].launchDms);
            }
        }];
    }
}

//获取本机对应的dm url的key
-(NSString*)getDMUrlModeOfMyIphone
{
    NSString *DMUrlMode;
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString *device = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([device isEqualToString:@"iPhone7,1"])
    {
        DMUrlMode = @"picUrld";
        
    }else if ([device isEqualToString:@"iPhone7,2"])
    {
        DMUrlMode = @"picUrlc";
        
    }else if (isIPhone5)
    {
        DMUrlMode = @"picUrlb";
        
    }else{
        
        DMUrlMode = @"picUrla";
    }
    
    return DMUrlMode;
}

@end
