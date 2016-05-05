//
//  SNSwitch.m
//  SuningEBuy
//
//  Created by  liukun on 13-8-20.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "SNSwitch.h"
#import "ActivitySwitchService.h"

@interface SNSwitch() <ActivitySwitchServiceDelegate>
{
    NSMutableArray *_callBacks;
    BOOL            _isLoadingSwitch;
}

@property (nonatomic, strong) ActivitySwitchService *service;

@end

/*********************************************************************/

@implementation SNSwitch

DEF_SINGLETON(SNSwitch);

- (void)dealloc
{
    [_callBacks removeAllObjects];
    _callBacks = nil;
    _service.delegate = nil;
}

+ (void)updateWithCallBack:(SNBasicBlock)callBack
{
    [[SNSwitch sharedInstance] updateWithCallBack:callBack];
}

+ (BOOL)isLoadOk
{
    return [GlobalDataCenter defaultCenter].activitySwitchMap?YES:NO;
}

- (ActivitySwitchService *)service
{
    if (!_service) {
        _service = [[ActivitySwitchService alloc] init];
        _service.delegate = self;
    }
    return _service;
}

- (void)updateWithCallBack:(SNBasicBlock)callBack
{
    if (callBack)
    {
        if (!_callBacks)
        {
            _callBacks = [[NSMutableArray alloc] init];
        }
        SNBasicBlock callBackObserver = [callBack copy];
        [_callBacks addObject:callBackObserver];
        callBackObserver = nil;
    }
    
//    if (_isLoadingSwitch)
//    {
//        return;
//    }
    
    _isLoadingSwitch = YES;
    
    //add by zhangbeibei:20141016
    [self.service beginGetSwitchListWithVersion:[GlobalDataCenter defaultCenter].homeSwitchVersion];
}

- (void)getSwitchListCompletionWithResult:(BOOL)isSuccess map:(NSDictionary *)swithMap
{
    _isLoadingSwitch = NO;
    //开启数据收集  只调用一次
    if (![SuningMainClick sharedInstance].isSuningMainClickStart) {
        [self.appDelegate startSuningBI];
    }
    if (isSuccess)
    {
        //持久化存储
        [GlobalDataCenter defaultCenter].activitySwitchMap = swithMap;
    }
    
    //回调
    if (_callBacks)
    {
        for (SNBasicBlock callBack in _callBacks)
        {
            callBack();
        }
        [_callBacks removeAllObjects];
        _callBacks = nil;
    }
    
    self.service = nil;
}

+ (NSArray *)homeBtIosList
{
    NSArray *array = nil;
    
    NSDictionary *switchMap = [GlobalDataCenter defaultCenter].activitySwitchMap;
    NSDictionary *searchDic = [switchMap objectForKey:@"HomeBtIOSList237"];
    NSString *searchStr = [searchDic objectForKey:@"switchValue"];
    
    //add by zhangbeibei 20140829:在首页的加载过程中，在新的接口数据没返回前默认加载上一次的功能区按钮
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    if (searchStr.trim.length == 0)
    {

        if ([userDefaults objectForKey:@"FunctionViewBtnArray"] == nil) {
            array = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8"];
            [userDefaults setObject:array forKey:@"FunctionViewBtnArray"];
            [userDefaults synchronize];
        }
        else {
            array = (NSArray *)[userDefaults objectForKey:@"FunctionViewBtnArray"];
        }

    }
    else{
        NSArray *list = [[searchStr trim] componentsSeparatedByString:@";"];
        NSString *lifeString = [list objectAtIndex:0];
        array = [[lifeString trim] componentsSeparatedByString:@","];
        
        [userDefaults setObject:array forKey:@"FunctionViewBtnArray"];
        [userDefaults synchronize];
    }
    return array;
}

+ (NSMutableDictionary *)homeBtIosListImage
{
    NSArray *array = nil;
    
    NSDictionary *switchMap = [GlobalDataCenter defaultCenter].activitySwitchMap;
    NSDictionary *searchDic = [switchMap objectForKey:@"HomeBtIOSList237"];
    NSString *searchStr = [searchDic objectForKey:@"switchDetail"];
    NSMutableDictionary *detailUrl = [[NSMutableDictionary alloc] init];
    
    //add by zhangbeibei 20140829:在首页的加载过程中，在新的接口数据没返回前默认加载上一次的功能区按钮
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (searchStr == nil || [searchStr isEqualToString:@""]) {
        if ([userDefaults objectForKey:@"homeBtIosListImageDict"] == nil) {
            detailUrl = nil;
        }
        else {
            detailUrl = (NSMutableDictionary *)[userDefaults objectForKey:@"homeBtIosListImageDict"];
        }

    }
    else
    {
        array = [[searchStr trim] componentsSeparatedByString:@"<br />"];
        for (NSString *str in array)
        {
            NSArray *arrayTmp = [[str trim] componentsSeparatedByString:@"|"];
            [detailUrl setValue:arrayTmp forKey:[arrayTmp objectAtIndex:0]];
        }
        
        [userDefaults setObject:detailUrl forKey:@"homeBtIosListImageDict"];
        [userDefaults synchronize];
        
    }
    return detailUrl;
}

+ (NSString *)orderTopPicture
{
    NSArray *array = nil;
    NSString *pictureUrl = nil;
    NSDictionary *switchMap = [GlobalDataCenter defaultCenter].activitySwitchMap;
    NSDictionary *searchDic = [switchMap objectForKey:@"zhifuyemain"];
    NSString *searchStr = [searchDic objectForKey:@"switchDetail"];

    array = [[searchStr trim] componentsSeparatedByString:@"<br />"];
    pictureUrl = [array safeObjectAtIndex:0];
    if (IsStrEmpty(pictureUrl)) {
        pictureUrl = @"";
    }
    return pictureUrl;

}

+ (NSString *)orderTopPictureToWapUrl
{
    NSArray *array = nil;
    NSString *orderTopPictureToWapUrl = nil;
    NSDictionary *switchMap = [GlobalDataCenter defaultCenter].activitySwitchMap;
    NSDictionary *searchDic = [switchMap objectForKey:@"zhifuyemain"];
    NSString *searchStr = [searchDic objectForKey:@"switchDetail"];
    
    array = [[searchStr trim] componentsSeparatedByString:@"<br />"];
    orderTopPictureToWapUrl = [array safeObjectAtIndex:1];
    if (IsStrEmpty(orderTopPictureToWapUrl)) {
        orderTopPictureToWapUrl = @"";
    }
    return orderTopPictureToWapUrl;

}

+ (NSString *)isShowOrderTopPicture
{
    NSDictionary *switchMap = [GlobalDataCenter defaultCenter].activitySwitchMap;
    NSDictionary *searchDic = [switchMap objectForKey:@"zhifuyemain"];
    NSString *isShowOrderTopPicture = [searchDic objectForKey:@"switchValue"];
    if (IsStrEmpty(isShowOrderTopPicture)) {
        isShowOrderTopPicture = @"0";
    }
    return isShowOrderTopPicture;
    
}




+ (NSArray *)homeBtIosListForLife
{
    NSArray *array = nil;
    
    NSDictionary *switchMap = [GlobalDataCenter defaultCenter].activitySwitchMap;
    //XZoscar,2014-04-18 HomeBtIOSList237 (HomeBtIOSList236)
    NSString *searchStr = [[switchMap objectForKey:@"HomeBtIOSList237"] objectForKey:@"switchValue"];
    
    if (searchStr.trim.length == 0)
    {
        array = @[@"9",@"10",@"11"];
    }
    else
    {
        NSArray *list = [[searchStr trim] componentsSeparatedByString:@";"];
        if ([list count] >= 1)
        {
            NSString *lifeString = [list objectAtIndex:1];
            array = [[lifeString trim] componentsSeparatedByString:@","];
        }
        else
        {
            array = @[@"9",@"10",@"11"];
        }
    }
    return array;
}

+ (NSArray *)homeModeList
{
    NSArray *_floorOrder = nil;
    
    NSDictionary *switchMap = [GlobalDataCenter defaultCenter].activitySwitchMap;
    
    NSString *searchStr= [[switchMap objectForKey:@"HomeModeList"] trim];
    if (searchStr.trim.length == 0)
    {
        _floorOrder = @[@"m1",@"m2",@"m3"];
    }
    else
    {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        NSArray *floorList = [[searchStr trim] componentsSeparatedByString:@","];
        for (NSString *string in floorList) {
            [array addObject:string];
        }
        _floorOrder = array;
    }
    return _floorOrder;
}

+ (BOOL)isNeedGetSignPic
{
    BOOL _isNeedGetSignPic = NO;
    
    NSArray *array = [SNSwitch homeModeList];
    
    for (NSString *string in array) {
        if ([string isEqualToString:@"m3"]) {
            _isNeedGetSignPic = YES;
            break;
        }
    }
    
    return _isNeedGetSignPic;
}


+ (NSURL *)homeHotUrl
{
    NSDictionary *switchMap = [GlobalDataCenter defaultCenter].activitySwitchMap;
    
    NSString *listString= [switchMap objectForKey:@"HomeHotUrl"];
    
    if (listString) {
        if (listString.length > 8) {
           NSString *urlString = [NSString stringWithFormat:@"%@_236%@",
                        [listString substringWithRange:NSMakeRange(0, listString.length - 4)],
                        [listString substringWithRange:NSMakeRange(listString.length - 4,4)]];

            return [NSURL URLWithString:[urlString URLEncoding]];
        }
        return nil;
    } else {
        return nil;
    }
}

+ (NSURL *)myEbuyUrl
{
    NSString *string = [[GlobalDataCenter defaultCenter].activitySwitchMap objectForKey:@"MyEbuyUrl"];
    
    if (string) {
        return [NSURL URLWithString:string];
    } else {
        return nil;
    }
}

+ (BOOL)isOpenLottery
{
    NSString *lotterySwitch =
    [[GlobalDataCenter defaultCenter].activitySwitchMap objectForKey:@"lotteryicon_ios"];
    NSString *clientVersion =
    [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    if (![lotterySwitch isEqualToString:clientVersion])
    {
        return YES;
    }else{
        return NO;
    }
}

+ (NSString *)groupbuyChannel
{
    NSDictionary *dic = [GlobalDataCenter defaultCenter].activitySwitchMap;
    NSString *chanId = [dic objectForKey:@"groupbuyChan"];
    return chanId.length?chanId:@"2";
}

+ (NSString *)groupbuyMyChannelOnly
{
    NSDictionary *dic = [GlobalDataCenter defaultCenter].activitySwitchMap;
    NSString *grpPurType = [dic objectForKey:@"grpPurType"];
    return grpPurType.length?grpPurType:@"1";
}

+ (NSString *)rushPurchaseChannel
{
    NSString *chanId = [[GlobalDataCenter defaultCenter].activitySwitchMap objectForKey:@"onsale"];
    return [chanId isEqualToString:@"2"]?@"2":@"1";
}


+ (NSArray *)rushPurchaseList
{
    NSString *listString;
    if ([[SNSwitch rushPurchaseChannel] isEqualToString:@"1"]) {
        listString = [[GlobalDataCenter defaultCenter].activitySwitchMap objectForKey:@"Onsale1"];
        
    }else if ([[SNSwitch rushPurchaseChannel] isEqualToString:@"2"]){
        listString = [[GlobalDataCenter defaultCenter].activitySwitchMap objectForKey:@"Onsale2"];
    }
    NSMutableArray *array = [NSMutableArray arrayWithArray:[listString componentsSeparatedByString:@";"]];
    NSRange range = [listString rangeOfString:@"；"];
    if (IsStrEmpty(listString) || ![SNSwitch checkListRightOrNot:array] || range.length > 0) {
        return nil;
    }
    NSString *newString =@"0,限时抢购";
    [array insertObject:newString atIndex:[array count]];
    return array;
}

+ (NSArray *)groupList
{
    NSString *listString;
    if ([[SNSwitch groupbuyChannel] isEqualToString:@"1"]) {
        listString = @"";//[[GlobalDataCenter defaultCenter].activitySwitchMap objectForKey:@"groupbuyChan1"];
        
    }else if ([[SNSwitch groupbuyChannel] isEqualToString:@"2"]){
        listString = [[GlobalDataCenter defaultCenter].activitySwitchMap objectForKey:@"groupbuyChan2"];
    }
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:[listString componentsSeparatedByString:@";"]];
    NSRange range = [listString rangeOfString:@"；"];
    if (IsStrEmpty(listString) || ![SNSwitch checkListRightOrNot:array] || range.length > 0) {
        return nil;
    }
    NSString *firstString =@",全部";
    [array insertObject:firstString atIndex:[array count]];
    return array;
}

+ (BOOL)isOpenWebEppPay
{
    NSDictionary *switchMap = [GlobalDataCenter defaultCenter].activitySwitchMap;
    
    //2.2.7使用新逻辑onlinePayment
    NSArray *statusArr = nil;
    
    NSString *onlinePayment = EncodeStringFromDic(switchMap, @"OnlinePayment_i");
    if (onlinePayment.length)
    {
        NSArray *compents = [onlinePayment componentsSeparatedByString:@"<br />"];
        for (NSString *part in compents)
        {
            if ([part hasPrefix:@"EppWap"])
            {
                NSArray *subCompents = [part componentsSeparatedByString:@"|"];
                if ([subCompents count] > 1)
                {
                    NSString *subPart = [subCompents objectAtIndex:1];
                    statusArr = [subPart componentsSeparatedByString:@","];
                }
                
                break;
            }
        }
    }
    else //2.2.6的逻辑
    {
        statusArr = @[@"1", @"1", @"1"];
        //        NSDictionary *isOpenEppWap = EncodeDicFromDic(switchMap, @"isOpenEppWap");
        //        NSString *switchValue = EncodeStringFromDic(isOpenEppWap, @"switchValue");
        //        statusArr = [switchValue componentsSeparatedByString:@","];
    }
    
    if ([statusArr count] == 3)
    {
        return [[statusArr objectAtIndex:0] isEqualToString:@"1"];
    }
    return NO;
}

+ (BOOL)isOpenWebEppMyEpp
{
    NSDictionary *switchMap = [GlobalDataCenter defaultCenter].activitySwitchMap;
    
    //2.2.7使用新逻辑onlinePayment
    NSArray *statusArr = nil;
    
    NSString *onlinePayment = EncodeStringFromDic(switchMap, @"OnlinePayment_i");
    if (onlinePayment.length)
    {
        NSArray *compents = [onlinePayment componentsSeparatedByString:@"<br />"];
        for (NSString *part in compents)
        {
            if ([part hasPrefix:@"EppWap"])
            {
                NSArray *subCompents = [part componentsSeparatedByString:@"|"];
                if ([subCompents count] > 1)
                {
                    NSString *subPart = [subCompents objectAtIndex:1];
                    statusArr = [subPart componentsSeparatedByString:@","];
                }
                
                break;
            }
        }
    }
    else //2.2.6的逻辑
    {
        statusArr = @[@"1", @"1", @"1"];
        //        NSDictionary *isOpenEppWap = EncodeDicFromDic(switchMap, @"isOpenEppWap");
        //        NSString *switchValue = EncodeStringFromDic(isOpenEppWap, @"switchValue");
        //        statusArr = [switchValue componentsSeparatedByString:@","];
    }
    
    if ([statusArr count] == 3)
    {
        return [[statusArr objectAtIndex:1] isEqualToString:@"1"];
    }
    return NO;
}

+ (BOOL)isOpenWebEppCharge
{
    NSDictionary *switchMap = [GlobalDataCenter defaultCenter].activitySwitchMap;
    
    //2.2.7使用新逻辑onlinePayment
    NSArray *statusArr = nil;
    
    NSString *onlinePayment = EncodeStringFromDic(switchMap, @"OnlinePayment_i");
    if (onlinePayment.length)
    {
        NSArray *compents = [onlinePayment componentsSeparatedByString:@"<br />"];
        for (NSString *part in compents)
        {
            if ([part hasPrefix:@"EppWap"])
            {
                NSArray *subCompents = [part componentsSeparatedByString:@"|"];
                if ([subCompents count] > 1)
                {
                    NSString *subPart = [subCompents objectAtIndex:1];
                    statusArr = [subPart componentsSeparatedByString:@","];
                }
                
                break;
            }
        }
    }
    else //2.2.6的逻辑
    {
        statusArr = @[@"1", @"1", @"1"];
        
        //        NSDictionary *isOpenEppWap = EncodeDicFromDic(switchMap, @"isOpenEppWap");
        //        NSString *switchValue = EncodeStringFromDic(isOpenEppWap, @"switchValue");
        //        statusArr = [switchValue componentsSeparatedByString:@","];
    }
    
    if ([statusArr count] == 3)
    {
        return [[statusArr objectAtIndex:2] isEqualToString:@"1"];
    }
    return NO;
}


+ (BOOL)isOpenWebEppPayCheckEppStatus
{
    NSDictionary *switchMap = [GlobalDataCenter defaultCenter].activitySwitchMap;
    
    //2.2.7使用新逻辑onlinePayment
    NSString *status = nil;
    
    NSString *onlinePayment = EncodeStringFromDic(switchMap, @"OnlinePayment_i");
    if (onlinePayment.length)
    {
        NSArray *compents = [onlinePayment componentsSeparatedByString:@"<br />"];
        for (NSString *part in compents)
        {
            if ([part hasPrefix:@"EppWap"])
            {
                NSArray *subCompents = [part componentsSeparatedByString:@"|"];
                if ([subCompents count] > 2)
                {
                    status = [subCompents objectAtIndex:2];
                }
                
                break;
            }
        }
    }
    else //2.2.6的逻辑
    {
        NSDictionary *isOpenEppWap = EncodeDicFromDic(switchMap, @"isOpenEppWap");
        status = EncodeStringFromDic(isOpenEppWap, @"switchContent");
    }
    
    return [status isEqualToString:@"1"];
}

//是否开启易付宝支付
+(BOOL)isOpenSNPaySDK
{
    NSDictionary *switchMap = [GlobalDataCenter defaultCenter].activitySwitchMap;
    
    NSString *onlinePayment = EncodeStringFromDic(switchMap, @"OnlinePayment_i");
    
    if (onlinePayment.length)
    {
        NSArray *compents = [onlinePayment componentsSeparatedByString:@"<br />"];
        for (NSString *part in compents)
        {
            if ([part hasPrefix:@"EppSDK"])
            {
                NSArray *subCompents = [part componentsSeparatedByString:@"|"];
                if ([subCompents count] > 1)
                {
                    NSString *subPart = [subCompents objectAtIndex:1];
                    return subPart.boolValue;
                }
                
                break;
            }
        }
    }
    else
    {
        //没维护默认开启
        return YES;
    }
    
    return NO;
    
}

//add by gjf 开关判断是否判断易付宝状态
+(BOOL)isOpenSDKEppPayCheckEppStatus{
    NSDictionary *switchMap = [GlobalDataCenter defaultCenter].activitySwitchMap;
    

    NSString *status = nil;
    
    NSString *onlinePayment = EncodeStringFromDic(switchMap, @"OnlinePayment_i");
    if (onlinePayment.length)
    {
        NSArray *compents = [onlinePayment componentsSeparatedByString:@"<br />"];
        for (NSString *part in compents)
        {
            if ([part hasPrefix:@"EppSDK"])
            {
                NSArray *subCompents = [part componentsSeparatedByString:@"|"];
                if ([subCompents count] > 2)
                {
                    status = [subCompents objectAtIndex:2];
                }
                
                break;
            }
        }
        return [status isEqualToString:@"1"];

    }
    return NO;
}

+(NSString *)SNPaySDKDesc{
    NSDictionary *switchMap = [GlobalDataCenter defaultCenter].activitySwitchMap;
    
    NSString *onlinePayment = EncodeStringFromDic(switchMap, @"OnlinePayment_i");
    if (onlinePayment.length)
    {
        NSArray *compents = [onlinePayment componentsSeparatedByString:@"<br />"];
        for (NSString *part in compents)
        {
            if ([part hasPrefix:@"EppSDK"])
            {
                NSArray *subCompents = [part componentsSeparatedByString:@"|"];
                if ([subCompents count] > 3)
                {
                    NSString *subPart = [subCompents lastObject];
                    return subPart.trim;
                }
                
                break;
            }
        }
    }
    return nil;
}

+ (BOOL)isOpenUnionPay  //是否开启银联支付
{
    NSDictionary *switchMap = [GlobalDataCenter defaultCenter].activitySwitchMap;
    
    NSString *onlinePayment = EncodeStringFromDic(switchMap, @"OnlinePayment_i");
    if (onlinePayment.length)
    {
        NSArray *compents = [onlinePayment componentsSeparatedByString:@"<br />"];
        for (NSString *part in compents)
        {
            if ([part hasPrefix:@"UnionPay"])
            {
                NSArray *subCompents = [part componentsSeparatedByString:@"|"];
                if ([subCompents count] > 1)
                {
                    NSString *subPart = [subCompents objectAtIndex:1];
                    return subPart.boolValue;
                }
                
                break;
            }
        }
    }
    else
    {
        //没维护默认开启
        return YES;
    }
    
    return NO;
}

+ (BOOL)isOpenCyberPay
{
    NSDictionary *switchMap = [GlobalDataCenter defaultCenter].activitySwitchMap;
    
    NSString *onlinePayment = EncodeStringFromDic(switchMap, @"OnlinePayment_i");
    if (onlinePayment.length)
    {
        NSArray *compents = [onlinePayment componentsSeparatedByString:@"<br />"];
        for (NSString *part in compents)
        {
            if ([part hasPrefix:@"CyberPayment"])
            {
                NSArray *subCompents = [part componentsSeparatedByString:@"|"];
                if ([subCompents count] > 1)
                {
                    NSString *subPart = [subCompents objectAtIndex:1];
                    return subPart.boolValue;
                }
                
                break;
            }
        }
    }
    else
    {
        //没维护默认开启
        return YES;
    }
    
    return NO;
}

+ (NSString *)webEppPaymodeDesc //易付宝web支付支付描述
{
    NSDictionary *switchMap = [GlobalDataCenter defaultCenter].activitySwitchMap;
    
    NSString *onlinePayment = EncodeStringFromDic(switchMap, @"OnlinePayment_i");
    if (onlinePayment.length)
    {
        NSArray *compents = [onlinePayment componentsSeparatedByString:@"<br />"];
        for (NSString *part in compents)
        {
            if ([part hasPrefix:@"EppWap"])
            {
                NSArray *subCompents = [part componentsSeparatedByString:@"|"];
                if ([subCompents count] > 3)
                {
                    NSString *subPart = [subCompents lastObject];
                    return subPart.trim;
                }
                
                break;
            }
        }
    }
    return nil;
}

+ (NSString *)unionPaymodeDesc //银联支付描述
{
    NSDictionary *switchMap = [GlobalDataCenter defaultCenter].activitySwitchMap;
    
    NSString *onlinePayment = EncodeStringFromDic(switchMap, @"OnlinePayment_i");
    if (onlinePayment.length)
    {
        NSArray *compents = [onlinePayment componentsSeparatedByString:@"<br />"];
        for (NSString *part in compents)
        {
            if ([part hasPrefix:@"UnionPay"])
            {
                NSArray *subCompents = [part componentsSeparatedByString:@"|"];
                if ([subCompents count] > 3)
                {
                    NSString *subPart = [subCompents lastObject];
                    return subPart.trim;
                }
                
                break;
            }
        }
    }
    return nil;
}

+ (NSString *)cyberPaymodeDesc //异度支付描述
{
    NSDictionary *switchMap = [GlobalDataCenter defaultCenter].activitySwitchMap;
    
    NSString *onlinePayment = EncodeStringFromDic(switchMap, @"OnlinePayment_i");
    if (onlinePayment.length)
    {
        NSArray *compents = [onlinePayment componentsSeparatedByString:@"<br />"];
        for (NSString *part in compents)
        {
            if ([part hasPrefix:@"CyberPayment"])
            {
                NSArray *subCompents = [part componentsSeparatedByString:@"|"];
                if ([subCompents count] > 3)
                {
                    NSString *subPart = [subCompents lastObject];
                    return subPart.trim;
                }
                
                break;
            }
        }
    }
    return nil;
}

+ (BOOL)canRegistSendCounponActionKey:(NSArray **)actions
{
    NSDictionary *activityMap = [GlobalDataCenter defaultCenter].activitySwitchMap;
    
    NSMutableArray *actionArr = [NSMutableArray array];
    for (NSString *actionName in [activityMap allKeys])
    {
        if ([actionName hasPrefix:@"Register"]) {
            NSString *switchValue = [activityMap objectForKey:actionName];
            if ([switchValue isKindOfClass:[NSString class]])
            {
                NSArray *list = [switchValue componentsSeparatedByString:@","];
                
                for (NSString *dc in list)
                {
                    if ([dc isEqualToString:kDownloadChannel]) {
                        [actionArr addObject:actionName];
                    }
                }
            }
        }
    }
    
    if ([actionArr count] > 0)
    {
        *actions = actionArr;
        return YES;
    }
    else
    {
        return NO;
    }
}

+ (BOOL)canLoginSendCounponActionKey:(NSString **)actionKey
{
    NSDictionary *activityMap = [GlobalDataCenter defaultCenter].activitySwitchMap;
    
    for (NSString *actionName in [activityMap allKeys])
    {
        if ([actionName hasPrefix:@"Mobileloginios"]) {
            NSString *switchValue = [activityMap objectForKey:actionName];
            NSArray *list = [switchValue componentsSeparatedByString:@","];
            
            for (NSString *dc in list)
            {
                if ([dc isEqualToString:kDownloadChannel]) {
                    *actionKey = actionName;
                    return YES;
                }
            }
        }
    }
    return NO;
}

+ (NSString *)randomSearchPlaceholder
{
    NSDictionary *switchMap = [GlobalDataCenter defaultCenter].activitySwitchMap;
    
    NSString *searchStr = [switchMap objectForKey:@"SearchTextField"];
    
    if ([searchStr length])
    {
        NSArray *searchFieldArr = [searchStr componentsSeparatedByString:@";"];
        return [searchFieldArr objectAtIndex:arc4random()%[searchFieldArr count]];
    }
    return L(@"Search Product");
}

+ (NSString *)goAround
{
    NSDictionary *switchMap = [GlobalDataCenter defaultCenter].activitySwitchMap;
    return [switchMap objectForKey:@"GoAround"];
}

+ (NSURL *)gameUrl
{
    NSDictionary *switchMap = [GlobalDataCenter defaultCenter].activitySwitchMap;
    NSString *urlStr = [switchMap objectForKey:@"MobilePlaying"];
    return [NSURL URLWithString:[urlStr URLEncoding]];
}

//团购抢购开关校验
+ (BOOL)checkListRightOrNot:(NSArray *)array
{
    for (NSString *dic in array) {
        NSArray *listArr = [dic componentsSeparatedByString:@","];
        if (IsArrEmpty(listArr) || [listArr count] < 2) {
            return NO;
        }else if (IsStrEmpty([listArr objectAtIndex:1])){
            return NO;
        }
    }
    return YES;
}

//是否有送券活动
+ (BOOL)isOnCouponForImageUrl:(NSURL **)imageUrl webUrl:(NSURL **)webUrl
{
    NSDictionary *switchMap = [GlobalDataCenter defaultCenter].activitySwitchMap;
    NSDictionary *onCouponDic = EncodeDicFromDic(switchMap, @"ON_Coupon");
    if (onCouponDic)
    {
        NSString *urlStr1 = EncodeStringFromDic(onCouponDic, @"switchValue");
        NSString *urlStr2 = EncodeStringFromDic(onCouponDic, @"switchDetail");

        NSURL *url1 = [NSURL URLWithString:urlStr1];
        NSURL *url2 = [NSURL URLWithString:urlStr2];
        
        if (url1 && url2 && urlStr1.trim.length && urlStr2.trim.length)
        {
            if (imageUrl) *imageUrl = url2;
            if (webUrl) *webUrl = url1;
            return YES;
        }
        else
        {
            return NO;
        }
    }
    else
    {
        return NO;
    }
}

+ (BOOL)isYunXinON
{
    return NO;
    NSDictionary *switchMap = [GlobalDataCenter defaultCenter].activitySwitchMap;
    NSString *urlStr = [switchMap objectForKey:@"YunxinOn"];
    
    if ([urlStr isEqualToString:@"0"]) {
        return NO;
    }else{
        return YES;
    }
}

+ (BOOL)isOpenSharePromoteWithTitle:(NSString **)title imageUrl:(NSURL **)url
{
    NSDictionary *switchMap = [GlobalDataCenter defaultCenter].activitySwitchMap;
    NSDictionary *showDic = [switchMap objectForKey:@"sharePromote_ios"];
    
    if ([showDic isKindOfClass:[NSDictionary class]])
    {
        //取出switchContent
        NSString *switchContent = EncodeStringFromDic(showDic, @"switchContent");
        NSString *switchValue = EncodeStringFromDic(showDic, @"switchValue");
        NSString *switchTitle = EncodeStringFromDic(showDic, @"switchTitle");
        
        //从switchContent字段中取出支持的下载渠道列表
        NSArray *channelList = [switchContent componentsSeparatedByString:@","];
        NSString *currentChannel = kDownloadChannelNum;
        if ([currentChannel isValueOf:channelList])
        {
            if (title) {
                *title = switchTitle;
            }
            if (url) {
                *url = [NSURL URLWithString:switchValue];
            }
            return YES;
        }
        else
        {
            return NO;
        }
    }
    else
    {
        return NO;
    }
    
}
//+(NSString *)getSwithValue:(NSString *)key{
//
//    NSDictionary *switchMap = [GlobalDataCenter defaultCenter].activitySwitchMap;
//    NSString *urlStr = [switchMap objectForKey:@"sharePromote"];
//    
//    if ([urlStr isEqualToString:@"1"]) {
//        return YES;
//    }else{
//        return YES;
//    }
//}
//是否打开在线客服
+ (BOOL)isOpenOnlineService
{
    NSDictionary *switchMap = [GlobalDataCenter defaultCenter].activitySwitchMap;
    NSDictionary *infoDic = [switchMap objectForKey:@"isneedcustom"];
    
    NSString *value = EncodeStringFromDic(infoDic, @"switchValue");
    NSString *content = EncodeStringFromDic(infoDic, @"switchContent");
    NSArray *contentVersions = [content componentsSeparatedByString:@";"];
    
    if ([value isEqualToString:@"1"] && [[SystemInfo appVersion] isValueOf:contentVersions]) {
        return YES;
    }else{
        return NO;
    }
}

//是否打开门店订单入口

+ (BOOL)isOpenShopOrderList
{
    NSDictionary *switchMap = [GlobalDataCenter defaultCenter].activitySwitchMap;
    NSString *showShopOrder = [switchMap objectForKey:@"StoreOrder"];
    
    if([showShopOrder isEqualToString:@"1"])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

//是否打开进入店铺
+ (BOOL)isOpenGoToShopExit
{
    NSDictionary *switchMap = [GlobalDataCenter defaultCenter].activitySwitchMap;
    NSString *showShopOrder = [switchMap objectForKey:@"Cshop"];
    
    if([showShopOrder isEqualToString:@"1"])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


//是否passport登陆
+(BOOL)isPassportLogin
{
//#ifdef kSitTest
//    return NO;
//#elif kReleaseH
//    return NO;
//#else
//    return YES;
    
    return YES;
//    NSDictionary *switchMap = [GlobalDataCenter defaultCenter].activitySwitchMap;
//    NSString *urlStr = [switchMap objectForKey:@"LoginPassport"];
//    
//    if (urlStr)
//    {
//        if ([urlStr isEqualToString:@"0"]) {
//            return NO;
//        }else{
//            return YES;
//        }
//    }
//    
//    return NO;
//#endif
}

+ (BOOL)isSuningBISDKOn
{
    NSDictionary *switchMap = [GlobalDataCenter defaultCenter].activitySwitchMap;
    NSString *urlStr = [switchMap objectForKey:@"iphoneBI"];
    
    if (urlStr)
    {
        if ([urlStr isEqualToString:@"0"]) {
            return NO;
        }else{
            return YES;
        }
    }
    return YES;
}

+ (NSString *)ISwdygyqxs
{
    NSDictionary *switchMap = [GlobalDataCenter defaultCenter].activitySwitchMap;
    NSDictionary *showwdygyqxs = [switchMap objectForKey:@"wdygyqxs"];
    NSString *isshow = [showwdygyqxs objectForKey:@"switchValue"];
    if([isshow isEqualToString:@"1"])
    {
        return [showwdygyqxs objectForKey:@"switchTitle"];
    }
    else
    {
        return nil;
    }
}

+(NSString *)checklqxrhbtk{
    NSDictionary *map =[GlobalDataCenter defaultCenter].activitySwitchMap;
    if (map == nil || [map count] == 0) {
        return nil;
    }
    NSDictionary *updateInfoDic = [map objectForKey:@"lqxrhbtk"];
    if (NotNilAndNull(updateInfoDic) && [updateInfoDic isKindOfClass:[NSDictionary class]]) {
        if ([[updateInfoDic objectForKey:@"switchValue"] isEqualToString:@"1"]) {
            return [updateInfoDic objectForKey:@"switchTitle"];
        }
    }
    return nil;
}


+(NSString *)ISwdyglqxs{
    NSDictionary *switchMap = [GlobalDataCenter defaultCenter].activitySwitchMap;
    NSDictionary *showwdyglqxs = [switchMap objectForKey:@"wdyglqxs"];
    NSString *isshow = [showwdyglqxs objectForKey:@"switchValue"];
    if([isshow isEqualToString:@"1"])
    {
        return [showwdyglqxs objectForKey:@"switchTitle"];
    }
    else
    {
        return nil;
    }
    
}


//--------begin add by gjf cpa cps 新开关
+(NSString *)shouyexinren244{
    NSDictionary *map =[GlobalDataCenter defaultCenter].activitySwitchMap;
    if (map == nil || [map count] == 0) {
        return nil;
    }
    NSDictionary *shouyexinren244 = [map objectForKey:@"shouyexinrenios"];
    if (NotNilAndNull(shouyexinren244) && [shouyexinren244 isKindOfClass:[NSDictionary class]]) {
        if ([[shouyexinren244 objectForKey:@"switchValue"] isEqualToString:@"1"]) {
            return [shouyexinren244 objectForKey:@"switchTitle"];
        }
    }
    return nil;
}

+(NSString *)yaoqinghaoyou244{
    NSDictionary *map =[GlobalDataCenter defaultCenter].activitySwitchMap;
    if (map == nil || [map count] == 0) {
        return nil;
    }
    NSDictionary *yaoqinghaoyou244 = [map objectForKey:@"yaoqinghaoyouios"];
    if (NotNilAndNull(yaoqinghaoyou244) && [yaoqinghaoyou244 isKindOfClass:[NSDictionary class]]) {
        if ([[yaoqinghaoyou244 objectForKey:@"switchValue"] isEqualToString:@"1"]) {
            return [yaoqinghaoyou244 objectForKey:@"switchTitle"];
        }
    }
    return nil;
}

+(NSString *)lingquhongbao244{
    NSDictionary *map =[GlobalDataCenter defaultCenter].activitySwitchMap;
    if (map == nil || [map count] == 0) {
        return nil;
    }
    NSDictionary *lingquhongbao244 = [map objectForKey:@"lingquhongbaoios"];
    if (NotNilAndNull(lingquhongbao244) && [lingquhongbao244 isKindOfClass:[NSDictionary class]]) {
        if ([[lingquhongbao244 objectForKey:@"switchValue"] isEqualToString:@"1"]) {
            return [lingquhongbao244 objectForKey:@"switchTitle"];
        }
    }
    return nil;
}
//--------end add by gjf cpa cps 新开关


+(BOOL)Isneedupdate{
    NSDictionary *switchMap = [GlobalDataCenter defaultCenter].activitySwitchMap;

    if (switchMap == nil || [switchMap count] == 0) {
            return NO;
    }
        
    NSDictionary *updateInfoDic = [switchMap objectForKey:@"iPhone"];
        
    if (NotNilAndNull(updateInfoDic) && [updateInfoDic isKindOfClass:[NSDictionary class]]) {
            
            NSString *serverVersion = [updateInfoDic objectForKey:@"switchValue"];
            NSString *clientVersion =
            [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
            
            //需要更新
            if (NotNilAndNull(serverVersion) &&[self checkVersionIsNeedUpdateClientV:clientVersion serverV:serverVersion])
            {
                return NO;
            }
    }
    return YES;
}


    //判断是否需要更新的算法
+(BOOL)checkVersionIsNeedUpdateClientV:(NSString *)clientVer serverV:(NSString *)serverVer
{
        if (IsNilOrNull(clientVer) ||
            [clientVer isEmptyOrWhitespace] ||
            IsNilOrNull(serverVer) ||
            [serverVer isEmptyOrWhitespace])
        {
            return NO;
        }
        NSArray *clientArray = [clientVer componentsSeparatedByString:@"."];
        NSArray *serverArray = [serverVer componentsSeparatedByString:@"."];
        NSInteger count =
        ([clientArray count] > [serverArray count]) ? [clientArray count] : [serverArray count];
        
        for (int i = 0; i < count; i++) {
            NSString *clientString = i < [clientArray count] ? [clientArray objectAtIndex:i] : @"0";
            NSString *serverString = i < [serverArray count] ? [serverArray objectAtIndex:i] : @"0";
            if ([clientString intValue] < [serverString intValue]) {
                return YES;
            }else if ([clientString intValue] > [serverString intValue]){
                return NO;
            }
        }
        return NO;
    }

/*
 // Function    : yaoYiYaoEntranceAtQianDao
 // Description : 摇易摇在签到页面的入口
 // return      : 对应的图片路径
 // Date        : 2014-04-03 11:00:00
 // Author      : XZoscar
*/

+ (NSString *)yaoYiYaoEntranceAtQianDao {
    
     NSDictionary *switchMap = [GlobalDataCenter defaultCenter].activitySwitchMap;
    if (nil != switchMap) {
        NSDictionary *qdtyaoDic = [switchMap objectForKey:@"qdtyao"];
        if (nil != qdtyaoDic) {
            return [qdtyaoDic objectForKey:@"switchValue"];
        }
    }
    
    return nil;
}

/*
 // Function    : soundMonitor
 // Description : 声波促销活动开关
 // return      : 声波促销分享的url
 // Date        : 2014-04-17 11:00:00
 // Author      : gjf
 */
+(BOOL)soundsdk{
    NSDictionary *switchMap = [GlobalDataCenter defaultCenter].activitySwitchMap;
    if (nil != switchMap) {
        NSDictionary *qdtyaoDic = [switchMap objectForKey:@"soundsdkIOS"];
        if (nil != qdtyaoDic) {
            NSString *switchvalue = [qdtyaoDic objectForKey:@"switchValue"];
            NSArray *qudao = [switchvalue componentsSeparatedByString:@","];
            NSString *title = [qdtyaoDic objectForKey:@"switchTitle"];
            if (title) {
                NSArray *array = [title componentsSeparatedByString:@","];
                NSString *clientVersion =
                [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
                if (![array containsObject:clientVersion]) {
                    return NO;
                }
                else{
                    NSString   *channel =kDownloadChannelNum;
                    if ([qudao containsObject:channel]) {
                        return YES;
                    }
                }
            }
        }
    }
    
    return NO;
}

+ (NSString *)soundMonitor {
    
    NSDictionary *switchMap = [GlobalDataCenter defaultCenter].activitySwitchMap;
    if (nil != switchMap) {
        //edit by gjf 之前开关不用了 用storeSoundIOS
        NSDictionary *qdtyaoDic = [switchMap objectForKey:@"storeSoundIOS"];
        if (nil != qdtyaoDic) {
            if ([self isNearbySuningVoiceSign]) {
                return [qdtyaoDic objectForKey:@"switchContent"];
            }
        }
    }
    
    return nil;
}


+ (NSString *)soundMonitorShareContent
{
    NSDictionary *switchMap = [GlobalDataCenter defaultCenter].activitySwitchMap;
    if (nil != switchMap) {
        //edit by gjf 之前开关不用了 用storeSoundIOS
        NSDictionary *qdtyaoDic = [switchMap objectForKey:@"storeSoundIOS"];
        if (nil != qdtyaoDic) {
            if ([self isNearbySuningVoiceSign]) {
                return [qdtyaoDic objectForKey:@"switchDetail"];
            }
        }
    }
    
    return nil;

}

//判断是否显示支付方式提示语

+ (BOOL)isShowPayTypeAlert
{
    
    NSDictionary *switchMap = [GlobalDataCenter defaultCenter].activitySwitchMap;
    NSDictionary *showShopOrder = [switchMap objectForKey:@"payment_i"];
    NSString *showType = [showShopOrder objectForKey:@"switchValue"];
    NSArray *showTypeArray = [showType componentsSeparatedByString:@","];
    
    NSString *version = [SystemInfo appVersion];
    
    BOOL isSameVersion = NO;
    for (NSString *show in showTypeArray) {
        if([show isEqualToString:version])
        {
            isSameVersion = YES;
            break;
        }
    }
    if (YES == isSameVersion) {
        return YES;
    }
    return NO;
}

+ (NSString *)showPayTypeAlertString
{
    
    NSDictionary *switchMap = [GlobalDataCenter defaultCenter].activitySwitchMap;
    NSDictionary *showShopOrder = [switchMap objectForKey:@"payment_i"];
    NSString *showTipString = [showShopOrder objectForKey:@"switchDetail"];
    if (IsStrEmpty(showTipString)) {
        return @"";
    }
    return showTipString;
}

//我的易购界面是否展示关联我的互联账号入口
+(BOOL)isShowMyHulianAccount
{
    NSDictionary *switchMap = [GlobalDataCenter defaultCenter].activitySwitchMap;
    if ([switchMap objectForKey:@"InternetAccount"])
    {
        NSDictionary *tempMap = [switchMap objectForKey:@"InternetAccount"];
        if ([switchMap objectForKey:@"InternetAccount"])
        {
            NSString *str = [tempMap objectForKey:@"switchValue"];
            if ([str isEqualToString:@"1"])
                return YES;
            else
                return NO;
        }
    }

    return NO;
}

+(NSString *)getHulianUrl
{
    NSDictionary *switchMap = [GlobalDataCenter defaultCenter].activitySwitchMap;
    if ([switchMap objectForKey:@"InternetAccount"])
    {
        NSDictionary *tempMap = [switchMap objectForKey:@"InternetAccount"];
        if ([tempMap objectForKey:@"switchDetail"])
        {
            NSString *url = [tempMap objectForKey:@"switchDetail"];
            return url;
        }
    }
    return nil;
}

//有促销价的情况下是否展示易购价
+ (BOOL)isNeednetPrice
{
    NSDictionary *switchMap = [GlobalDataCenter defaultCenter].activitySwitchMap;
    NSString *showNetPrice = [switchMap objectForKey:@"isneednetprice"];
    if([showNetPrice isEqualToString:@"1"])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+ (BOOL)isNearbySuningVoiceSignStore{
    NSDictionary *switchMap = [GlobalDataCenter defaultCenter].activitySwitchMap;
    NSDictionary *storeSoundIOS = [switchMap objectForKey:@"storeSoundIOS"];
    NSString *switchContent = [storeSoundIOS objectForKey:@"switchTitle"];
    if ([switchContent isEqualToString:@"1"]) {
        return YES;
    }
    return NO;
}

//是否在身边苏宁中显示声波签到
+ (BOOL)isNearbySuningVoiceSign{
    
    NSDictionary *switchMap = [GlobalDataCenter defaultCenter].activitySwitchMap;
    NSDictionary *dic = [switchMap objectForKey:@"storeSoundIOS"];
    NSString *storeSoundIOS = [dic objectForKey:@"switchValue"];
    
    if (IsStrEmpty(storeSoundIOS)) {
        return NO;
    }else{
        if ([storeSoundIOS rangeOfString:[SystemInfo appVersion]].length>0) {
            return YES;
        }else{
            return NO;
        }
    }
    
    return NO;
    
}


//身边苏宁活动开关（预充值）
+ (NSDictionary *)getNearbySuningPrecash:(NSString *)cityName{
    NSDictionary *switchMap = [GlobalDataCenter defaultCenter].activitySwitchMap;
    NSDictionary *dic = nil;
    if ([switchMap objectForKey:@"precash"])
    {
        NSDictionary *tempMap = [switchMap objectForKey:@"precash"];
        if (!tempMap) {
            return nil;
        }else{
//            if (IsStrEmpty(cityName)) {
//                return nil;
//            }
            if ([[tempMap objectForKey:@"switchTitle"] rangeOfString:[SystemInfo appVersion]].length>0) {
                dic = [[NSDictionary alloc] initWithObjectsAndKeys:[tempMap objectForKey:@"switchValue"],@"url",[tempMap objectForKey:@"switchContent"],@"imageUrl",[tempMap objectForKey:@"switchDetail"],@"text", nil];
                return dic;
            }else{
                return nil;
            }
        }
    }
    return nil;
}

//身边苏宁活动开关（预约）
+ (NSDictionary *)getNearbySuningReserve:(NSString *)cityName{
    NSDictionary *switchMap = [GlobalDataCenter defaultCenter].activitySwitchMap;
    NSDictionary *dic = nil;
    if ([switchMap objectForKey:@"reserve"])
    {
        NSDictionary *tempMap = [switchMap objectForKey:@"reserve"];
        if (!tempMap) {
            return nil;
        }else{
            if (IsStrEmpty(cityName)) {
                return nil;
            }
            if ([[tempMap objectForKey:@"switchTitle"] rangeOfString:cityName].length>0) {
                dic = [[NSDictionary alloc] initWithObjectsAndKeys:[tempMap objectForKey:@"switchValue"],@"url",[tempMap objectForKey:@"switchContent"],@"imageUrl",[tempMap objectForKey:@"switchDetail"],@"text", nil];
                return dic;
            }else{
                return nil;
            }
        }
    }
    return nil;
}


+(BOOL)isSearchPromotionOpen
{
//    return YES;
    //@"sscxkg"
    NSDictionary *switchMap = [GlobalDataCenter defaultCenter].activitySwitchMap;
    
    if ([switchMap objectForKey:@"sscxkg"])
    {
        NSDictionary *dic = [switchMap objectForKey:@"sscxkg"];
        NSString *isSearchPromotionOpen = [dic objectForKey:@"switchValue"];
        
        if (IsStrEmpty(isSearchPromotionOpen)) {
            return NO;
        }else{
            if ([isSearchPromotionOpen isEqualToString:@"1"]) {
                return YES;
            }else if ([isSearchPromotionOpen isEqualToString:@"0"]){
                return NO;
            }
        }
    }
    
    return NO;
}

+(NSString *)getSearchPromotionValue
{
//#ifdef DEBUG
//    return @"2";
//#endif
    NSDictionary *switchMap = [GlobalDataCenter defaultCenter].activitySwitchMap;
    
    if ([switchMap objectForKey:@"sscxkg"])
    {
        NSDictionary *dic = [switchMap objectForKey:@"sscxkg"];
        NSString *sscxkg = [dic objectForKey:@"switchValue"];
        
        return sscxkg;
    }
    
    return nil;
}

+(BOOL)isSearchUseClientChannel
{
    NSDictionary *switchMap = [GlobalDataCenter defaultCenter].activitySwitchMap;
    
    if ([switchMap objectForKey:@"sscxkg"])
    {
        NSDictionary *dic = [switchMap objectForKey:@"sscxkg"];
        NSString *isSearchUseClientChannel = [dic objectForKey:@"switchContent"];
        if (IsStrEmpty(isSearchUseClientChannel))
            return NO;
        else
        {
            if ([isSearchUseClientChannel isEqualToString:@"0"])
            {
                return NO;
            }
            else if ([isSearchUseClientChannel isEqualToString:@"1"])
            {
                return YES;
            }
                
        }
    }
    
    return NO;
}

+ (NSString *)getsscxkgSwitchContent
{
    
//#ifdef DEBUG
//    return @"1";
//#endif
    NSDictionary *switchMap = [GlobalDataCenter defaultCenter].activitySwitchMap;
    
    if ([switchMap objectForKey:@"sscxkg"])
    {
        NSDictionary *dic = [switchMap objectForKey:@"sscxkg"];
        NSString *sscxkgSwitchContent = [dic objectForKey:@"switchContent"];
        if (IsStrEmpty(sscxkgSwitchContent))
            return nil;
        else
        {
            return sscxkgSwitchContent;
        }
    }
    return nil;
}

//四级页服务自提促销及是否展示门店自提
+(NSString *)serverCuxiaoDesc
{
    NSDictionary *switchMap = [GlobalDataCenter defaultCenter].activitySwitchMap;
    NSDictionary *showShopOrder = [switchMap objectForKey:@"isneedcuxiao"];
    NSString *showTipString = [showShopOrder objectForKey:@"switchDetail"];
    if (IsStrEmpty(showTipString)) {
        return @"";
    }
    return showTipString;
}
+ (BOOL)isShowServerZiti
{
    NSDictionary *switchMap = [GlobalDataCenter defaultCenter].activitySwitchMap;
    NSDictionary *showShopOrder = [switchMap objectForKey:@"isneedcuxiao"];
    NSString *showType = [showShopOrder objectForKey:@"switchValue"];
    if ([showType isEqualToString:@"1"]) {
        return YES;
    }else
    {
        return NO;
    }
}

+(BOOL)isM2DaJuHuiVersionMatch:(NSString*)version
{
    NSString *clientVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey];
    NSArray *versionArray = [version componentsSeparatedByString:@";"];
    for (NSString *v in versionArray) {
        if ([v isEqualToString:clientVersion]) {
            return YES;
        }
    }
    return NO;
}

+ (BOOL)isM2QiangGouToEight{
    
    /*
     开关：两个，“isneedM2A”和“isneedM2I”分别表示android和iPhone
     值：以英文分号相隔两个数位，第一个数位表示抢购，第二个数位表示团购，每个数位只能用0和1表示是否切换调用八连版，0表示维持原状，1表示调用八连版
     */
    
    NSDictionary *switchMap = [GlobalDataCenter defaultCenter].activitySwitchMap;
    NSDictionary *m2Order = [switchMap objectForKey:@"isneedM2I"];
    NSString *isNeedM2I = [m2Order strValue:@"switchValue"];
    if (!IsStrEmpty(isNeedM2I) && ([isNeedM2I isEqualToString:@"1;0"] || [isNeedM2I isEqualToString:@"1;1"])) {
        if ([self isM2DaJuHuiVersionMatch:[m2Order strValue:@"switchDetail"]]) {
            return YES;
        }
    }
    return NO;
}

+ (BOOL)isM2TuanGouToEight
{
    NSDictionary *switchMap = [GlobalDataCenter defaultCenter].activitySwitchMap;
    NSDictionary *m2Order = [switchMap objectForKey:@"isneedM2I"];
    NSString *isNeedM2I = [m2Order strValue:@"switchValue"];
    if (!IsStrEmpty(isNeedM2I) && ([isNeedM2I isEqualToString:@"0;1"] || [isNeedM2I isEqualToString:@"1;1"])) {
        if ([self isM2DaJuHuiVersionMatch:[m2Order strValue:@"switchDetail"]]) {
            return YES;
        }
    }
    return NO;
}

//是否需要调用四级页大聚惠接口
+ (BOOL)isNeedJuhui
{
    NSDictionary *switchMap = [GlobalDataCenter defaultCenter].activitySwitchMap;
    NSDictionary *infoDic = [switchMap objectForKey:@"isneedjuhui"];
    
    NSString *value = EncodeStringFromDic(infoDic, @"switchValue");
    NSString *content = EncodeStringFromDic(infoDic, @"switchContent");
    NSArray *contentVersions = [content componentsSeparatedByString:@";"];
    NSString *detail = EncodeStringFromDic(infoDic, @"switchDetail");
    NSArray *detailArray = [detail componentsSeparatedByString:@";"];
    
    if ([value isEqualToString:@"1"]
        && [[SystemInfo appVersion] isValueOf:contentVersions]
        && [@"iPhone" isValueOf:detailArray]) {
        return YES;
    }else{
        return NO;
    }
}
@end
