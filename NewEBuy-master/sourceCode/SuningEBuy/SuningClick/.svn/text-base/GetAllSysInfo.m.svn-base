//
//  GetAllSysInfo.m
//  SuningEBuy
//
//  Created by xy ma on 11-12-27.
//  Copyright (c) 2011年 sn. All rights reserved.
//

#import "GetAllSysInfo.h"
#import "Preferences.h"
#import "AppDelegate.h"
//#import "SaveSuningUUID.h"   方案废弃
#import "OpenUDID.h"
#import "RegexKitLite.h"
#import <CommonCrypto/CommonDigest.h>
#import "InformationCollectService.h"

@implementation GetAllSysInfo

- (void)main
{
    [self saveSystemInfoDTO];
}

-(void) saveSystemInfoDTO{
    //组装所有的系统信息
    //    系统字段：应用版本号，iPhone/android，操作系统版本，硬件设备类型，来源IP，手机唯一串号，会话id ，来源渠道，登陆状态，用户账户（可选）
    
    // NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
    //    [postDataDic setObject:self.clientVersion forKey:@"app_version"];
    
    
    InformetionCollectDTO *_infoDTO = nil;
    
    _infoDTO = [[InformetionCollectDTO alloc]init];
    
    //1-应用版本号
    NSString *clientVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey];
    
    //DLog(@"clientVersion is = %@\n",clientVersion);
    
    if(clientVersion && clientVersion.length>0){
        
        [_infoDTO setAppVersion:clientVersion];
        
    }else
    {
        [_infoDTO setAppVersion:@"NO Version"];
    }
    
    
    //2-iPhone/android
    
    [_infoDTO setSysKind:@"iPhone"];
    
    
    //3-操作系统版本,eg @"iPhone OS 4.3"
    
    NSString *OsSysVersion =[NSString stringWithFormat:@"%@ %@",[UIDevice currentDevice].systemName,[UIDevice currentDevice].systemVersion];
    
   // DLog(@"OsSysVersion is = %@\n",OsSysVersion);
    
    if (OsSysVersion && OsSysVersion.length>0) {
        
        [_infoDTO setOsVersion:OsSysVersion];
    }else
    {
        [_infoDTO setOsVersion:@"NO OsVersion"];
    }
    
    
    //4-硬件设备类型 iPhone/iPad
    NSString *HardPlatform = [Preferences platform];
    
  //  DLog(@"HardPlatform is = %@\n",HardPlatform);
    
    if (HardPlatform && HardPlatform.length>0) {
        
        [_infoDTO setPlatform:HardPlatform];
    }else
    {
        [_infoDTO setPlatform:@"NO HardPlatform"];
    }
    
    
    //5-来源IP
        
    NSURL *ipURL = [NSURL URLWithString:@"http://iframe.ip138.com/ic.asp"];
    
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:ipURL];
    [request startSynchronous];
    
    NSString *resultStr = request.responseString;
    
    TT_RELEASE_SAFELY(request);
    
    NSString *regexStr = @"[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}";
    
    NSString *ipOut = [resultStr stringByMatching:regexStr];

    //默认取外网ip
    if (ipOut.length > 0) {
        
        [_infoDTO setUserIP:ipOut];
        
    }else
    {
        //取不到公网ip就用固定值
        [_infoDTO setUserIP:@"127.0.0.1"];
    }
    
    
    
    //6-手机唯一串号
    //生成唯一的串号保持到keychain中，有就读取出来，没有就生成，删除应用也不会改变
    //串号字符串类似“Suning-uuid-CCADA518-F794-4A6F-B127-7ABB3FB3F39B"
    
//    SaveSuningUUID * tempSaveUUID =  [SaveSuningUUID shareInstance];
//    
//    NSString *iNeedUUID = [tempSaveUUID saveIdentifier:@"SuningEbuy"];
//    
//   // DLog(@"iNeedUUID is %@\n",iNeedUUID);
//    
//    if (iNeedUUID && iNeedUUID.length>0) {
//        
//        [_infoDTO setUniqueId:iNeedUUID];
//    }else
//    {
//        [_infoDTO setUniqueId:@"No UUID"];
//    }
    
    //使用openUUID
    NSString *iNeedUUID = [OpenUDID value];
    if (iNeedUUID && iNeedUUID.length > 0) {
        [_infoDTO setUniqueId:iNeedUUID];
    }else{
        [_infoDTO setUniqueId:@"No UUID"];
    }
    
    //7-会话id 
    
    //取当前时间，MD5加密，保证唯一即可
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    
    NSTimeInterval a=[dat timeIntervalSince1970]*1000;
    
    NSString *timeString = [NSString stringWithFormat:@"%f", a];
    
    //DLog(@"timeString is %@\n",timeString);
    
    NSString * md5Timestring = [GetAllSysInfo md5:timeString];
    
    //DLog(@"md5Timestring is %@\n",md5Timestring);
    
    if (md5Timestring && md5Timestring.length>0) {
        
        [_infoDTO setSessionId:md5Timestring];
    }else
    {
        [_infoDTO setSessionId:@"NO session"];
    }
    
    //8-来源渠道
    [_infoDTO setAppDownWay:kDownloadChannelNum];
    
//    //9-登陆状态
//    if([SuningEBuyAppDelegate  currentAppDelegate].userInfoDTO==nil){
//        //访客
//        [_infoDTO setIsLogin:@"G"];
//        
//    }else{
//        //登陆用户
//        [_infoDTO setIsLogin:@"R"];
//    }
//    
//    //10-用户账户（可选,可以为空）
//    
//    NSString *loginName = [Config currentConfig].username;
//    
//    DLog(@"loginName is = %@\n",loginName);
//    
//    [_infoDTO setLoginName:loginName];
    //    
    //   self.clientVersion is = 1.2.3
    //   OsSysVersion is = iPhone OS 4.3.2
    //   HardPlatform is = iPhone Simulator
    //   ipOut is = 221.226.47.42
    //   iNeedUUID is Suning-uuid-2704A472-D23D-4239-B380-DB48093D8598
    //   md5Timestring is E62BB9F0A2773A48D2A478D35233C60B+1
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:SystemInfoStat], kInfoDataType, _infoDTO, kInfoDataValue, nil];
    
    InformationCollectService *collect=[[InformationCollectService alloc]init];
    
    [collect saveCollectedDataWithDic:dic];
    
    TT_RELEASE_SAFELY(collect);
    
    TT_RELEASE_SAFELY(_infoDTO);
        
}

+ (NSString *) md5:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr), result );
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3], 
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}




@end

