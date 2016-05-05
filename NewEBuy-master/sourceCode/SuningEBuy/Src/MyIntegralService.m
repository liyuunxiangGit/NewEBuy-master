//
//  MyIntegralService.m
//  SuningEBuy
//
//  Created by shasha on 12-9-19.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "MyIntegralService.h"
#import "AchievementExchangeDTO.h"

#define kHttpRequestCardInfoModifyUserName         @"name"
#define kHttpRequestCardInfoModifyGender           @"gender"
#define kHttpRequestCardInfoModifyIdCode           @"idCode"
#define kHttpRequestCardInfoModifyMobile           @"mobile"
#define kHttpRequestCardInfoModifyState            @"state"
#define kHttpRequestCardInfoModifyCity             @"city"
#define kHttpRequestCardInfoModifyAddressField1    @"addressField1"
#define kHttpRequestCardInfoModifyAddressField2    @"addressField2"
#define kHttpRequestCardInfoModifyDetAdd           @"detAdd"
#define kHttpRequestCardInfoModifyValidateCode     @"validateCode"
#define kHttpRequestCardInfoModifyCardType         @"cardType"
//获取云钻明细请求参数
#define KHttpRequestForAchDetailStoreId        @"storeId"
#define KHttpRequestForAchDetailcatalogId      @"catalogId"
#define KHttpRequestForAchDetailuserCardNo     @"userCardNo"
#define KHttpRequestForAchDetaillogonId        @"logonId"
#define KHttpRequestForAchDetailpageSize       @"pageSize"
#define KHttpRequestForAchDetailpageNum        @"currentPage"
#define KHttpRequestForAchDetailType           @"chgType"
//#define KHttpRequestForAchDetailpageSizeValue    @"5"
#define KHttpRequestForAchExchangeChange         @"change"
#define KHttpRequestForAchExchangeSubmitFlg      @"submitFlg"
#define KHttpRequestForAchExchangeChangeCount    @"changeCount"
#define KHttpRequestForAchExchangeAchievement    @"achivement"
#define KHttpRequestForAchDetailpageSizeValue    @"10"
#define KHttpRequestForAchExchangeSubmitFlgValue @"1"



@interface MyIntegralService()

- (void)didGetMyIntegerInfoRequestFinished:(BOOL)isSuccess;
- (void)didGetPreCardInfoRequestFinished:(BOOL)isSuccess;
- (void)didActiveIntegerRequestFinished:(BOOL)isSuccess;
- (void)didGetIntegerDatailInfoRequestFinished:(BOOL)isSuccess;
- (void)didExchageIntegerRequestFinished:(BOOL)isSuccess;

- (void)parseAchievementList:(NSDictionary *)items;
- (void)parseExchangeAch:(NSDictionary *)items;

@end

@implementation MyIntegralService
@synthesize delegate = _delegate;
@synthesize achievement = _achievement;
@synthesize actAchive = _actAchive;
@synthesize activateIntegralDto = _activateIntegralDto;
@synthesize integralDetailArr = _integralDetailArr;
@synthesize currentPage = _currentPage;
- (id)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)dealloc {
    TT_RELEASE_SAFELY(_actAchive);
    TT_RELEASE_SAFELY(_achievement);
    TT_RELEASE_SAFELY(_activateIntegralDto);
    TT_RELEASE_SAFELY(_integralDetailArr);
}

- (void)httpMsgRelease{

    HTTPMSG_RELEASE_SAFELY(_activeIntegerMsg);
    HTTPMSG_RELEASE_SAFELY(_preCardInfoMsg);
    HTTPMSG_RELEASE_SAFELY(_myIntegralMsg);
    HTTPMSG_RELEASE_SAFELY(_getIntegralDetailMsg);
    HTTPMSG_RELEASE_SAFELY(_exchangeIntegralMsg);
    
}

- (void)didGetMyIntegerInfoRequestFinished:(BOOL)isSuccess{

    if ([self.delegate respondsToSelector:@selector(myIntegralServiceHttpRequestCompletedWithService:isSucess:errorCode:)]) {
        
        [self.delegate myIntegralServiceHttpRequestCompletedWithService:self isSucess:isSuccess errorCode:self.errorMsg];
    }
}


- (void)didActiveIntegerRequestFinished:(BOOL)isSuccess{
        
    if ([self.delegate respondsToSelector:@selector(didActiveIntegerRequestCompletedWithService:isSucess:errorCode:)]) {
        
        if (isSuccess) {
            
            [self.delegate didActiveIntegerRequestCompletedWithService:self isSucess:YES errorCode:nil];
            
        }else{
            
            [self.delegate didActiveIntegerRequestCompletedWithService:self isSucess:NO errorCode:self.errorMsg];
        }
        
    }

}

- (void)didGetPreCardInfoRequestFinished:(BOOL)isSuccess{

    if ([self.delegate respondsToSelector:@selector(didGetPreCardInfoRequestCompletedWithService:isSucess:errorCode:)]) {
        
        if (isSuccess) {
            
            [self.delegate didGetPreCardInfoRequestCompletedWithService:self isSucess:YES errorCode:nil];
            
        }else{
            
            [self.delegate didGetPreCardInfoRequestCompletedWithService:self isSucess:YES errorCode:self.errorMsg];
        }
    }
}


- (void)didExchageIntegerRequestFinished:(BOOL)isSuccess{

    if ([self.delegate respondsToSelector:@selector(didExchangeIntegerRequestCompletedWithService:isSucess:errorCode:)]) {
        
        if (isSuccess) {
            
            [self.delegate didExchangeIntegerRequestCompletedWithService:self isSucess:YES errorCode:nil];
            
        }else{
            
            [self.delegate didExchangeIntegerRequestCompletedWithService:self isSucess:YES errorCode:self.errorMsg];
        }
    }

}

- (void)beginGetMyIntegerInfoRequest{

    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
    
    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];	
    
    [postDataDic setObject:kHttpRequestHomeCatalogIdValue forKey:kHttpRequestHomeCatalogIdKey];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttps,[@"SNMobileAchievementInquireView" passport]];
    
    HTTPMSG_RELEASE_SAFELY(_myIntegralMsg);
    
    _myIntegralMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:url postDataDic:postDataDic cmdCode:CC_MyIntegral];
    
    _myIntegralMsg.requestMethod = RequestMethodGet;
    [self.httpMsgCtrl sendHttpMsg:_myIntegralMsg];
    
    TT_RELEASE_SAFELY(postDataDic);

}


- (void)didGetIntegerDatailInfoRequestFinished:(BOOL)isSuccess{
    
    if ([self.delegate respondsToSelector:@selector(didGetIntegerDetailInfoRequestCompletedWithService:isSucess:errorCode:)]) {
        
        if (isSuccess) {
            
            [self.delegate didGetIntegerDetailInfoRequestCompletedWithService:self isSucess:YES errorCode:nil];
            
        }else{
            
            [self.delegate didGetIntegerDetailInfoRequestCompletedWithService:self isSucess:NO errorCode:self.errorMsg];
        
        }
    }
}


- (void)BeginGetPreCardInfoRequest{
    
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
    
    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
    [postDataDic setObject:kHttpRequestHomeCatalogIdValue forKey:kHttpRequestHomeCatalogIdKey];
    [postDataDic setObject:@"0" forKey:@"dealFlg"];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttps,[@"SNMobilePreCardInfoModify" passport]];
    
    HTTPMSG_RELEASE_SAFELY(_preCardInfoMsg);
    
    _preCardInfoMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:url postDataDic:postDataDic cmdCode:CC_PreCardInfo];
    
    [self.httpMsgCtrl sendHttpMsg:_preCardInfoMsg];
    
    TT_RELEASE_SAFELY(postDataDic);

}


- (void)BeginActiveIntegerRequest:(ActivateIntegralDTO *)activateIntegralDto withCheckCode:(NSString *)checkCode{
           
    NSDictionary *postDataDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 kHttpRequestHomeStoreValue,kHttpRequestHomeStoreKey,
                                 kHttpRequestHomeCatalogIdValue,kHttpRequestHomeCatalogIdKey,
                                 activateIntegralDto.integralName,kHttpRequestCardInfoModifyUserName,
                                 activateIntegralDto.integralCardType,kHttpRequestCardInfoModifyCardType,
                                 [activateIntegralDto.integralGender isEqualToString:@"M"]?@"M":@"F",kHttpRequestCardInfoModifyGender,
                                 activateIntegralDto.integralIdCode,kHttpRequestCardInfoModifyIdCode,
                                 activateIntegralDto.provinceName ,kHttpRequestCardInfoModifyState,
                                 activateIntegralDto.cityName,kHttpRequestCardInfoModifyCity,
                                 activateIntegralDto.integralAddressField1,kHttpRequestCardInfoModifyAddressField1,
                                 activateIntegralDto.integralAddressField2,kHttpRequestCardInfoModifyAddressField2,
                                 activateIntegralDto.integralDetAdd?activateIntegralDto.integralDetAdd:@"",kHttpRequestCardInfoModifyDetAdd,
                                 checkCode?checkCode : @"",kHttpRequestCardInfoModifyValidateCode,
                                 activateIntegralDto.integralMobile ?  activateIntegralDto.integralMobile  :@"",kHttpRequestCardInfoModifyMobile,
                                 nil];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttps,[@"SNMobileCardInfoModify" passport]];
    
    HTTPMSG_RELEASE_SAFELY(_activeIntegerMsg);
    
    _activeIntegerMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:url postDataDic:postDataDic cmdCode:CC_ActiveInteger];
    
    [self.httpMsgCtrl sendHttpMsg:_activeIntegerMsg];
    
    TT_RELEASE_SAFELY(postDataDic);

}


- (void)BeginGetIntegerDetailInfoRequest:(int)currentPage integralType:(NSString *)type lastRecord:(NSArray *)lastRecord{
    //组装请求参数
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
    
    self.lastRecordArray = lastRecord;
    
    [postDataDic setObject:KHttpRequestForAchDetailpageSizeValue forKey:KHttpRequestForAchDetailpageSize];
    
    [postDataDic setObject:[NSString stringWithFormat:@"%d",currentPage] forKey:KHttpRequestForAchDetailpageNum];
    
    [postDataDic setObject:type forKey:KHttpRequestForAchDetailType];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kEbuyWapHostURL,@"accountcenter/private/queryMyPoint.do"];
    
    HTTPMSG_RELEASE_SAFELY(_getIntegralDetailMsg);
    
    _getIntegralDetailMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:url postDataDic:postDataDic cmdCode:CC_IntegralDetail];
    
    [self.httpMsgCtrl sendHttpMsg:_getIntegralDetailMsg];
    
    TT_RELEASE_SAFELY(postDataDic);

}

- (void)BeginExchangeIntegerRequest:(NSString *)change changeCount:(NSString *)changeCount currentAchievement:(NSString *)currentAchievement{

    //组装请求参数  
	NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
    [postDataDic setObject:kHttpRequestHomeCatalogIdValue forKey:kHttpRequestHomeCatalogIdKey];
    [postDataDic setObject:change forKey:KHttpRequestForAchExchangeChange];
    [postDataDic setObject:KHttpRequestForAchExchangeSubmitFlgValue forKey:KHttpRequestForAchExchangeSubmitFlg];
    [postDataDic setObject:changeCount forKey:KHttpRequestForAchExchangeChangeCount];
    [postDataDic setObject:currentAchievement forKey:KHttpRequestForAchExchangeAchievement];    

    HTTPMSG_RELEASE_SAFELY(_exchangeIntegralMsg);
    
    NSString *url = [kHostAddressForHttps stringByAppendingFormat:@"/SNMobileMyAchievement"];
    
    _exchangeIntegralMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:url postDataDic:postDataDic cmdCode:CC_ExchangeIntegral];
    
    [self.httpMsgCtrl sendHttpMsg:_exchangeIntegralMsg];
    
    TT_RELEASE_SAFELY(postDataDic);


} 


- (void)receiveDidFailed:(HttpMessage *)receiveMsg{

    [super receiveDidFailed:receiveMsg];
    
    switch (receiveMsg.cmdCode) {
            
        case CC_MyIntegral:
            
            [self didGetMyIntegerInfoRequestFinished:NO];

            break;
            
        case CC_PreCardInfo:
            
            [self didGetPreCardInfoRequestFinished:NO ];
            
            break;
        case CC_ActiveInteger:{
        
            [self didActiveIntegerRequestFinished:NO];
        }
            break;
        case CC_IntegralDetail:{
        
            [self didGetIntegerDatailInfoRequestFinished:NO];
        }
            break;
            
        default:
            break;
    }
    
    
}


- (void)receiveDidFinished:(HttpMessage *)receiveMsg{
    
    switch (receiveMsg.cmdCode) {
            
        case CC_MyIntegral:{
        
            NSDictionary *items = receiveMsg.jasonItems;
            
            if (!items) {
                self.errorMsg = kHttpResponseJSONValueFailError;
                [self didGetMyIntegerInfoRequestFinished:NO];
            }else{
                NSString *achievementStr = [NSString stringWithFormat:@"%.2f",[[items objectForKey:@"achievement"] floatValue]];
                
                NSString *activeStr = [items objectForKey:@"actAchive"];
                
                self.actAchive = IsNilOrNull(activeStr)?@"0":activeStr;
                
                self.achievement = IsNilOrNull(achievementStr)?@"0":achievementStr;
                
                [self didGetMyIntegerInfoRequestFinished:YES];
            }
      
        }            
            break;
            
        case CC_PreCardInfo:{
            
            NSDictionary *items = receiveMsg.jasonItems;
            
            DLog(@"preCardInfoRequestOK from server  NSUrlString=%@\n",[items description]);
            
            if (!IsNilOrNull(items)) {
                
                if (!_activateIntegralDto) {
                    
                    _activateIntegralDto = [[ActivateIntegralDTO alloc] init];
                }
                
                [self.activateIntegralDto encodeFromDictionary:items];
                
                [self didGetPreCardInfoRequestFinished:YES];
                
            }
            else
            {
                self.errorMsg = kHttpResponseJSONValueFailError;
                [self didGetPreCardInfoRequestFinished:NO];

            }
            
            
          }
                        
            break;
            
        case CC_ActiveInteger:{
        
            NSDictionary *items = receiveMsg.jasonItems;
            DLog(@"cardInfoRequestOK from server  NSUrlString=%@\n",[items description]);
            
            if ([[items objectForKey:@"isSuccess"] isEqualToString:@"1"]) {
               
                [self didActiveIntegerRequestFinished:YES];
                
                
            }
            else if ([[items objectForKey:@"isSuccess"] isEqualToString:@"0"])
            {

                NSString *errorDesc = [NSString stringWithFormat:@"bindIntegral_%@",[items objectForKey:@"errorCode"]];
                
                NSString *errorMsg = [L(errorDesc) eq:errorDesc]?L(@"bindIntegral_Error_Default"):L(errorDesc);

                self.errorMsg = errorMsg;
                
                [self didActiveIntegerRequestFinished:NO];
                
            }
            else
            {
                self.errorMsg = kHttpResponseJSONValueFailError;
                [self didActiveIntegerRequestFinished:NO];

            }
            

        }
            break;
            
        case CC_IntegralDetail:{
            
            NSDictionary *items = receiveMsg.jasonItems;
            
            if (!items)
            {
                self.errorMsg = kHttpResponseJSONValueFailError;
                [self didGetIntegerDatailInfoRequestFinished:NO];
            }
            else
            {
                [self parseAchievementList:items];
                [self didGetIntegerDatailInfoRequestFinished:YES];
            }
            
        }
            break;
            
        case CC_ExchangeIntegral:{
            
            NSDictionary *items = receiveMsg.jasonItems;
            
            if (!items)
            {
                self.errorMsg = kHttpResponseJSONValueFailError;
                [self didExchageIntegerRequestFinished:NO];
            }
            else
            {
                [self parseExchangeAch:items];
            }
        
        }
            break;
            
        default:
            break;
    }
    
}

//云钻兑换易购券，解析接口返回字段
- (void)parseExchangeAch:(NSDictionary *)items
{    
    NSString *temp = [items objectForKey: @"isSuccess"];
    
    if (temp) {
        
        if ([temp isEqualToString:@"1"])
        {
            self.achievement = [items objectForKey:@"achivement"];
            
            [self didExchageIntegerRequestFinished:YES];
            
        }
        else
        {
            self.errorMsg = [items objectForKey:@"errorDesc"];
            
            [self didExchageIntegerRequestFinished:NO];

        }
    }
    
}
//解析云钻列表接口返回的数据
-(void)parseAchievementList:(NSDictionary *)items{
    
    if (items != nil && [items count] > 0)
    {
                
        self.totalNum = [[items objectForKey:@"totalNum"]intValue];
        
        self.currentPage = [[items objectForKey:@"currentPage"]intValue];
        
        NSArray *achiveList = [items objectForKey:@"pointList"];
        
        if (!_integralDetailArr) {
            
            _integralDetailArr = [[NSArray alloc] init];
        }
        
        self.integralDetailArr = [self packetAccordingToDate:achiveList];
    }
    
}

-(NSArray*)packetAccordingToDate:(NSArray*)originList
{
    NSMutableArray *totalList = [[NSMutableArray alloc]init];
    
    NSMutableArray *tempList;
    
    for (NSDictionary * dic in originList) {
        
        if ([dic isKindOfClass:[NSDictionary class]])
        {
            AchievementExchangeDTO *dto = [[AchievementExchangeDTO alloc] init];
            
            [dto encodeFromDictionary:dic];
            
            if ([totalList count] == 0)
            {
                if (_currentPage != 1)
                {
                    totalList = [NSMutableArray arrayWithArray:_lastRecordArray];
                    
                    AchievementExchangeDTO *compareDto = (AchievementExchangeDTO*)[[totalList lastObject] lastObject];
                    
                    if ([dto.processTime isEqualToString:compareDto.processTime])
                    {
                        [[totalList lastObject] addObject:dto];
                        
                        continue;
                    }
                }
                tempList = [[NSMutableArray alloc]init];
                
                [tempList addObject:dto];
                
                [totalList addObject:tempList];
            }else{
                
                AchievementExchangeDTO *compareDto = (AchievementExchangeDTO*)[[totalList lastObject] lastObject];
                
                if ([dto.processTime isEqualToString:compareDto.processTime])
                {
                    [[totalList lastObject] addObject:dto];
                    
                }else{
                    tempList = [[NSMutableArray alloc]init];
                    
                    [tempList addObject:dto];
                    
                    [totalList addObject:tempList];
                }
            }
        }
    }
    return totalList;
}

@end
