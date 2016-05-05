//
//  GBCityService.m
//  SuningEBuy
//
//  Created by shasha on 13-2-26.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "GBCityService.h"
#import "GBCityDTO.h"

@implementation GBCityService
@synthesize hotCityList = _hotCityList;
@synthesize allCityList = _allCityList;
@synthesize letterList = _letterList;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_hotCityList);
    TT_RELEASE_SAFELY(_allCityList);
    TT_RELEASE_SAFELY(_letterList);
}


- (void)httpMsgRelease{
    [super httpMsgRelease];
    HTTPMSG_RELEASE_SAFELY(__allCityListMsg);
    HTTPMSG_RELEASE_SAFELY(__hotCityListMsg);
    HTTPMSG_RELEASE_SAFELY(__allAndHotCityListMsg);
    
}
- (void)beginSendAllCityListHttpRequest{
    
    NSDictionary *postDic =[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:eALLCityType],@"hot", nil];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostGroupBuyAddressForHttp, @"groupbuy/mobileclient/getCityList.htm"];
    
    HTTPMSG_RELEASE_SAFELY(__allCityListMsg);
    
    __allCityListMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:url postDataDic:postDic cmdCode:CC_GBAllCityList];
    
    TT_RELEASE_SAFELY(postDic);
    
    [self.httpMsgCtrl sendHttpMsg:__allCityListMsg];
    
}

- (void)beginSendHotCityListHttpRequest{
    
    NSDictionary *postDic =[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",eHotCityType],@"hot", nil];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostGroupBuyAddressForHttp, @"groupbuy/mobileclient/getCityList.htm"];
    
    HTTPMSG_RELEASE_SAFELY(__hotCityListMsg);
    
    __hotCityListMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:url postDataDic:postDic cmdCode:CC_GBHotCityList];
    
    TT_RELEASE_SAFELY(postDic);
    
    [self.httpMsgCtrl sendHttpMsg:__hotCityListMsg];
}

- (void)beginSendAllAndHotCityListHttpRequest{
    
    NSDictionary *postDic =[[NSDictionary alloc] initWithObjectsAndKeys:__INT(eAllAndHotCityType),@"hot", nil];
    
    
    NSString *sendString = [@"" queryStringNoEncodeFromDictionary:postDic];
    
    NSString *encodeStr = [PasswdUtil encryptString:sendString
                                             forKey:@"SuningTG"
                                               salt:@"SuningTG"];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostGroupBuyAddressForHttp, @"getCityList.htm"];
    
    NSDictionary *sendDic =[[NSDictionary alloc] initWithObjectsAndKeys:encodeStr,@"data", nil];
    HTTPMSG_RELEASE_SAFELY(__allAndHotCityListMsg);
    
    __allAndHotCityListMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:url postDataDic:sendDic cmdCode:CC_GBAllandHotCityList];
    
    TT_RELEASE_SAFELY(postDic);
    TT_RELEASE_SAFELY(sendDic);
    
    [self.httpMsgCtrl sendHttpMsg:__allAndHotCityListMsg];
}


- (void)receiveDataFinished:(HttpMessage *)recieveMsg Data:(NSDictionary *)dataDic Result:(BOOL)isSuccess{
    
    if (isSuccess) {
        NSArray *hotCityArr = [dataDic objectForKey:@"hotCityList"];
        NSArray *allCityArr = [dataDic objectForKey:@"allCityList"];
        
        Background_Begin
        
        if (!IsArrEmpty(hotCityArr)) {
            [self parseHotCityList:hotCityArr CMDCode:recieveMsg.cmdCode];
        }else{
            self.hotCityList = nil;
        }
        
        if (!IsArrEmpty(allCityArr)) {
            [self parseAllCityList:allCityArr CMDCode:recieveMsg.cmdCode];
        }else{
            self.allCityList = nil;
        }
        
        if (!IsArrEmpty(self.hotCityList)) {
            [self handleLettersList:recieveMsg.cmdCode];
        }
        Background_End
        
    }else{
        [self didGetCityListComplete:NO CMDCode:recieveMsg.cmdCode];
    }
    
}

- (void)handleLettersList:(E_CMDCODE)cmdCode{
    
    NSDictionary *hotDic = [[NSDictionary alloc] initWithObjectsAndKeys:self.hotCityList,L(@"GBTop"), nil];
    
    NSMutableArray *hotTempArr = [[NSMutableArray alloc] initWithArray:self.allCityList];
    
    [hotTempArr insertObject:hotDic atIndex:0];
    
    self.allCityList = hotTempArr;
    
    TT_RELEASE_SAFELY(hotDic);
    TT_RELEASE_SAFELY(hotTempArr);
    
    NSMutableArray *tempLettersArr = [[NSMutableArray alloc] initWithArray:self.letterList];
    [tempLettersArr insertObject:L(@"GBTop") atIndex:0];
    self.letterList = tempLettersArr;
    TT_RELEASE_SAFELY(tempLettersArr);
    
    Foreground_Begin
    [self didGetCityListComplete:YES CMDCode:cmdCode];
    Foreground_End
    
}

- (void)parseHotCityList:(NSArray *)CityArr CMDCode:(E_CMDCODE)cmdCode{
    self.hotCityList = [self parseCityList:CityArr];
    
}

- (void)parseAllCityList:(NSArray *)CityArr CMDCode:(E_CMDCODE)cmdCode{
    self.allCityList = [self parseAllCityList:CityArr];
    
}

- (NSMutableArray *)parseAllCityList:(NSArray *)CityArr{
    
    NSMutableArray *allCityArr = [[NSMutableArray alloc] init];
    
    NSMutableArray *letterListTemp = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dic in CityArr) {
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] init];
        NSMutableArray *tempArr = [[NSMutableArray alloc] init];
        NSString *letter = EncodeStringFromDic(dic, @"letter");
        [letterListTemp addObject:letter];
        NSArray  *letterList = [dic objectForKey:@"letterList"];
        for (NSDictionary *letterDic in letterList) {
            GBCityDTO *dto = [[GBCityDTO alloc] init];
            dto.letter = letter;
            [dto encodeFromDictionary:letterDic];
            [tempArr addObject:dto];
            TT_RELEASE_SAFELY(dto);
        }
        [tempDic setObject:tempArr forKey:letter];
        [allCityArr addObject:tempDic];
        TT_RELEASE_SAFELY(tempArr);
        TT_RELEASE_SAFELY(tempDic);
    }
    self.letterList = letterListTemp;
    TT_RELEASE_SAFELY(letterListTemp);
    return allCityArr;
}
- (NSMutableArray *)parseCityList:(NSArray *)CityArr{
    
    NSMutableArray *tempArr = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in CityArr) {
        GBCityDTO *dto = [[GBCityDTO alloc] init];
        [dto encodeFromDictionary:dic];
        [tempArr addObject:dto];
        TT_RELEASE_SAFELY(dto);
    }
    return tempArr;
}

- (void)didGetCityListComplete:(BOOL)isSuccess CMDCode:(E_CMDCODE)cmdCode{
    switch (cmdCode) {
        case CC_GBAllCityList:{
            if ([self.delegate respondsToSelector:@selector(didSendAllCityListFinished:isSuccess:)]) {
                [self.delegate didSendAllCityListFinished:self isSuccess:isSuccess];
            }
        }
            break;
        case CC_GBHotCityList:{
            if ([self.delegate respondsToSelector:@selector(didSendHotCityListFinished:isSuccess:)]) {
                [self.delegate didSendHotCityListFinished:self isSuccess:isSuccess];
            }
        }
            break;
        case CC_GBAllandHotCityList:{
            if ([self.delegate respondsToSelector:@selector(didSendAllAndHotCityListFinished:isSuccess:)]) {
                [self.delegate didSendAllAndHotCityListFinished:self isSuccess:isSuccess];
            }
        }
            break;
            
        default:
            break;
    }
}
@end
