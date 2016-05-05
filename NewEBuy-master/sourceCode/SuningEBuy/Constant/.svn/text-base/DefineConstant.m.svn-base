

#import "DefineConstant.h"

extern SNPageInfo
SNPageInfoMake(NSInteger currentPage, NSInteger totalPage, NSInteger pageSize)
{
    return (SNPageInfo){currentPage, totalPage, pageSize};
}

const SNPageInfo SNPageInfoZero = {0,0,0};

static NSDictionary *getInstanceDCDictionary()
{
    static NSDictionary *__instanceDic = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"DC" ofType:@"plist"];
        NSDictionary *dcDic = [NSDictionary dictionaryWithContentsOfFile:path];
        if ([dcDic isKindOfClass:[NSDictionary class]]) {
            __instanceDic = [dcDic copy];
        }
    });
    return __instanceDic;
}

NSString *getDownloadChannelId(void)
{
    NSDictionary *dcDic = getInstanceDCDictionary();
    NSInteger index = [[dcDic objectForKey:@"itemIndex"] integerValue];
    NSArray *list = [dcDic objectForKey:@"list"];
    
    NSDictionary *infoDic = [list safeObjectAtIndex:index];
    return [infoDic objectForKey:@"id"];
}

NSString *getDownloadChannelName(void)
{
    NSDictionary *dcDic = getInstanceDCDictionary();
    NSInteger index = [[dcDic objectForKey:@"itemIndex"] integerValue];
    NSArray *list = [dcDic objectForKey:@"list"];
    
    NSDictionary *infoDic = [list safeObjectAtIndex:index];
    
    //239开始使用id，否则修改活动名后收不到送券 by chupeng 2014-5-30
    return [infoDic objectForKey:@"id"]; //[infoDic objectForKey:@"name"]
}

#pragma mark wbUrl
NSString *WBHeadUrlString(NSString *sysHeadPicFlag,NSString *sysHeadPicNum, CGSize size,NSString *custNum){
    
    
    if ([sysHeadPicFlag isEqualToString:@""])
    {
        return @"";
    }
    else if([sysHeadPicFlag isEqualToString:@"100000000010"]){
        NSString *urlStr = [NSString stringWithFormat:@"%@/%@_%@_%.fx%.f.jpg",kWBCardPhotoHostAddressHost,@"0000000000",sysHeadPicNum,120.0,120.0];
        return urlStr;
    }
    else if ([sysHeadPicFlag isEqualToString:@"100000000020"])
    {
        if (IsStrEmpty(sysHeadPicNum)) {
            sysHeadPicNum = @"00000000";
        }
        NSString *urlStr = [NSString stringWithFormat:@"%@/%@_%@_%.fx%.f.jpg",kWBCardPhotoHostAddressHost,custNum,@"00",size.width,size.height];
//        NSString *urlStr = [NSString stringWithFormat:@"%@/%@_%@_%.fx%.f.jpg",kWBCardPhotoHostAddressHost,custNum,sysHeadPicNum,size.width,size.height];

        //        NSString *urlStr;
        //        if ([userId isEqualToString:[UserCenter defaultCenter].userInfoDTO.custNum]) {
        //            urlStr = [NSString stringWithFormat:@"%@/%@_%@_%.fx%.f.jpg?v=%f",kWBCardPhotoHostAddressHost,userId,@"00",size.width,size.height,[[Config currentConfig].lastUpdateCardDetail doubleValue]];
        //
        //        }else{
        //             urlStr = [NSString stringWithFormat:@"%@/%@_%@_%.fx%.f.jpg",kWBCardPhotoHostAddressHost,userId,@"00",size.width,size.height];
        //
        //        }
        //        DLog(@"11111111111%@",urlStr);
        //        DLog(@"2222222222%@",userId);
        //        DLog(@"3333333333%@",[UserCenter defaultCenter].userInfoDTO.custNum);
        return urlStr;
    }
    else
    {
        return @"";
    }
    return @"";
}

#ifdef kReleaseH
NSString* const suningCookieDomain = @".suning.com";
#else
NSString* const suningCookieDomain = @".cnsuning.com";
#endif


NSString* EncodeStringFromDic(NSDictionary *dic, NSString *key)
{
    id temp = [dic objectForKey:key];
    if ([temp isKindOfClass:[NSString class]])
    {
        return temp;
    }
    else if ([temp isKindOfClass:[NSNumber class]])
    {
        return [temp stringValue];
    }
    return nil;
}

NSNumber* EncodeNumberFromDic(NSDictionary *dic, NSString *key)
{
    id temp = [dic objectForKey:key];
    if ([temp isKindOfClass:[NSString class]])
    {
        return [NSNumber numberWithDouble:[temp doubleValue]];
    }
    else if ([temp isKindOfClass:[NSNumber class]])
    {
        return temp;
    }
    return nil;
}

NSDictionary *EncodeDicFromDic(NSDictionary *dic, NSString *key)
{
    id temp = [dic objectForKey:key];
    if ([temp isKindOfClass:[NSDictionary class]])
    {
        return temp;
    }
    return nil;
}

NSArray      *EncodeArrayFromDic(NSDictionary *dic, NSString *key)
{
    id temp = [dic objectForKey:key];
    if ([temp isKindOfClass:[NSArray class]])
    {
        return temp;
    }
    return nil;
}

NSArray      *EncodeArrayFromDicUsingParseBlock(NSDictionary *dic, NSString *key, id(^parseBlock)(NSDictionary *innerDic))
{
    NSArray *tempList = EncodeArrayFromDic(dic, key);
    if ([tempList count])
    {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:[tempList count]];
        for (NSDictionary *item in tempList)
        {
            id dto = parseBlock(item);
            if (dto) {
                [array addObject:dto];
            }
        }
        return array;
    }
    return nil;
}

