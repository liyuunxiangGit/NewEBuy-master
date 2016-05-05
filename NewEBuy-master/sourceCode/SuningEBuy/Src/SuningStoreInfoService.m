//
//  SuningStoreInfoService.m
//  SuningEBuy
//
//  Created by xingxianping on 14-2-13.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "SuningStoreInfoService.h"
#import "StoreServiceDTO.h"

@implementation SuningStoreInfoService

@synthesize storeListArr = _storeListArr;
@synthesize floorInfoArr = _floorInfoArr;
@synthesize storeServiceArr = _storeServiceArr;
@synthesize storeInfoDTO = _storeInfoDTO;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_storeListArr);
    
    TT_RELEASE_SAFELY(_floorInfoArr);
    
    TT_RELEASE_SAFELY(_storeServiceArr);
    
    TT_RELEASE_SAFELY(_storeInfoDTO);
    
    _serviceDelegate = nil;
}

- (void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(storeListHttpMsg);
    
    HTTPMSG_RELEASE_SAFELY(storeInfoHttpMsg);
    
}

- (id)init
{
    self = [super init];
    if (self) {
        _storeListArr = [[NSMutableArray alloc]init];

        _floorInfoArr = [[NSMutableArray alloc]init];
        
        _storeServiceArr = [[NSMutableArray alloc]init];
        
        _storeInfoDTO = [[StoreDetailInfoDTO alloc]init];
    }
    return self;
}

- (void)getNearBySuningStoreListWithToken:(NSString *)token longitude:(NSString *)longitude latitude:(NSString *)latitude cityName:(NSString *)city
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    
    [dic setObject:@"" forKey:@"token"];
    [dic setObject:IsStrEmpty(city)?@"":city forKey:@"cityName"];
    [dic setObject:IsStrEmpty(longitude)?@"":longitude forKey:@"gpsLongitude"];
    [dic setObject:IsStrEmpty(latitude)?@"":latitude forKey:@"gpsLatitude"];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostSuningMobts,kSNStoreList];
    
    HTTPMSG_RELEASE_SAFELY(storeListHttpMsg);
    
    storeListHttpMsg = [[HttpMessage alloc]initWithDelegate:self requestUrl:url postDataDic:dic cmdCode:CC_StoreList];
    //    storeListHttpMsg.requestMethod =RequestMethodGet;
    
    [self.httpMsgCtrl sendHttpMsg:storeListHttpMsg];
    
    TT_RELEASE_SAFELY(dic);
    
}

-(void)getVoiceCodeActivity:(NSString *)voicecode{
    
  

    
    NSString *url = [NSString stringWithFormat:@"%@/%@/%@.html",kEbuyWapHostURL,@"sound/soundwave",voicecode];
    
    
    HTTPMSG_RELEASE_SAFELY(storeListHttpMsg);
    
    storeListHttpMsg = [[HttpMessage alloc]initWithDelegate:self requestUrl:url postDataDic:nil cmdCode:CC_VoiceActity];
    
    [self.httpMsgCtrl sendHttpMsg:storeListHttpMsg];
    
}

- (void)getSuningStoreDetailInfoWithStoreId:(NSString *)storeId
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:IsStrEmpty(storeId)?@"":storeId forKey:@"storeId"];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostSuningMobts,kSNStoreDetailInfo];
    
    
    HTTPMSG_RELEASE_SAFELY(storeInfoHttpMsg);
    
    storeInfoHttpMsg = [[HttpMessage alloc]initWithDelegate:self
                                                 requestUrl:url
                                                postDataDic:dic
                                                    cmdCode:CC_StoreDetailInfo];
    //    storeInfoHttpMsg.requestMethod = RequestMethodGet;
    
    [self.httpMsgCtrl sendHttpMsg:storeInfoHttpMsg];
    
    TT_RELEASE_SAFELY(dic);
}

-(void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    if (receiveMsg.cmdCode ==CC_StoreDetailInfo) {
        [_serviceDelegate getNearBySuningStoreDetailInfo:nil isSuccess:NO errorMsg:self.errorMsg];
    }
    else if (receiveMsg.cmdCode == CC_StoreList)
    {
        [_serviceDelegate getNearBySuningStoreList:nil isSuccess:NO errorMsg:self.errorMsg];
    }
    else if(receiveMsg.cmdCode == CC_VoiceActity){
        [_serviceDelegate getVoiceCodeActivity:nil];
    }
    
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    NSDictionary *item = receiveMsg.jasonItems;
    
    self.errorMsg =[item objectForKey:@"errorMsg"];
    
    if (receiveMsg.cmdCode == CC_StoreDetailInfo)
    {
        if ([[item objectForKey:@"successFlg" ]isEqualToString:@"1"]) {
            NSMutableDictionary *dic = [item objectForKey:@"storeInfo"];
            
            [self.storeInfoDTO encodeFromDictionary:dic];
            
            NSMutableArray *serviceArr = [dic objectForKey:@"storeServiceList"];
            
            [self.storeServiceArr removeAllObjects];
            
            for (int i =0; i <[serviceArr count]; i++) {
                StoreServiceDTO *dto=[[StoreServiceDTO alloc]init];
                [dto encodeFromDictionary:[serviceArr objectAtIndex:i]];
                [self.storeServiceArr addObject:dto];
            }
            
            NSMutableArray *floorArr = [dic objectForKey:@"storeFloorList"];
            [self.floorInfoArr removeAllObjects];
            for (int j =0; j<[floorArr count]; j++) {
                FloorInfoDTO *dto = [[FloorInfoDTO alloc]init];
                [dto encodeFromDictionary:[floorArr objectAtIndex:j]];
                [self.floorInfoArr addObject:dto];
            }
            [_serviceDelegate getNearBySuningStoreDetailInfo:self isSuccess:YES errorMsg:self.errorMsg];
        }
        else
        {
            [_serviceDelegate getNearBySuningStoreDetailInfo:nil isSuccess:NO errorMsg:self.errorMsg];
        }
    }
    else if (receiveMsg.cmdCode == CC_StoreList)
    {
        if ([[item objectForKey:@"successFlg"] isEqualToString:@"1"]) {
            NSMutableArray *list = [item objectForKey:@"storeList"];
            if (IsArrEmpty(list)) {
                self.errorMsg =L(@"NearbySuning_NoStoreInLocalArea");
                [_serviceDelegate getNearBySuningStoreList:self isSuccess:NO errorMsg:self.errorMsg];
            }
            else
            {
                [self.storeListArr removeAllObjects];
                for (int i =0; i<[list count]; i++) {
                    StoreListDTO *dto  =[[StoreListDTO alloc]init];
                    [dto encodeFromDictionary:[list objectAtIndex:i]];
                    [self.storeListArr addObject:dto];
                }
                
                [_serviceDelegate getNearBySuningStoreList:self isSuccess:YES errorMsg:self.errorMsg];
            }
        }
        else
        {
            [_serviceDelegate getNearBySuningStoreList:self isSuccess:NO errorMsg:self.errorMsg];
        }
    }
    else if(receiveMsg.cmdCode == CC_VoiceActity){
        if ([[item objectForKey:@"IsSuccessFlag"] isEqualToString:@"True"]) {
            VoiceActiveDTO *voiceDTO = [[VoiceActiveDTO alloc] init];
            [voiceDTO encodeFromDictionary:item];
            [_serviceDelegate getVoiceCodeActivity:voiceDTO];
        }
        else{
            VoiceActiveDTO *voiceDTO = [VoiceActiveDTO new];
            if(NotNilAndNull(EncodeStringFromDic(item,@"errorInfo")))
            {
                voiceDTO.errmsg = [item objectForKey:@"errorInfo"];
            }
            if ([[item objectForKey:@"errorCode"] isEqualToString:@"0001"]) {
                voiceDTO.errmsg=L(@"timeOverState");
            }
            
            [_serviceDelegate getVoiceCodeActivity:voiceDTO];
        }
    }
}


@end
