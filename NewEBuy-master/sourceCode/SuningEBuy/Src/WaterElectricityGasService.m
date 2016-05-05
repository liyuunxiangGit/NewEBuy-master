//
//  WaterElectricityGasService.m
//  SuningEBuy
//
//  Created by 谢 伟 on 12-10-7.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "WaterElectricityGasService.h"
#import "SNCityFirstLetterDTO.h"

@interface WaterElectricityGasService () 

- (void)sendRegionInfoHttpRequest:(PayServiceDTO *)payServiceDTO;
- (void)getRegionInfoDidFinish:(BOOL)isSuccess;

- (void)sendCompanyListHttpRequest:(PayServiceDTO *)payServiceDTO;
- (void)getCompanyListDidFinish:(BOOL)isSuccess;

- (void)sendFeeModeHttpRequest:(PayServiceDTO *)payServiceDTO;
- (void)getFeeModeDidFinish:(BOOL)isSuccess;

- (void)sendAccountInfoHttpRequest:(PayServiceDTO *)payServiceDTO;
- (void)getAccountInfoDidFinish:(BOOL)isSuccess;

@end


@implementation WaterElectricityGasService

@synthesize regionList = _regionList;
@synthesize companyList = _companyList;
@synthesize payServiceDTO = _payServiceDTO;
@synthesize payAccountNum = _payAccountNum;
@synthesize customerName = _customerName;
@synthesize payBalance = _payBalance;
@synthesize isGetAccount = _isGetAccount;
@synthesize requestFail = _requestFail;
@synthesize errorCode = _errorCode;
@synthesize delegate = _delegate;

- (void)dealloc
{
    HTTPMSG_RELEASE_SAFELY(regionInfoHttpMsg);
    HTTPMSG_RELEASE_SAFELY(chargeModeHttpMsg);
    HTTPMSG_RELEASE_SAFELY(cityListHttpMsg);
    HTTPMSG_RELEASE_SAFELY(companyListHttpMsg);
    HTTPMSG_RELEASE_SAFELY(feeModeHttpMsg);
    HTTPMSG_RELEASE_SAFELY(accountInfoHttpMsg);
    
    TT_RELEASE_SAFELY(_regionList);
    TT_RELEASE_SAFELY(_companyList);
    TT_RELEASE_SAFELY(_payServiceDTO);
    TT_RELEASE_SAFELY(_payAccountNum);
    TT_RELEASE_SAFELY(_customerName);
    TT_RELEASE_SAFELY(_payBalance);
    TT_RELEASE_SAFELY(_errorCode);
    
}

- (PayServiceDTO *)payServiceDTO
{
    if (!_payServiceDTO) {
        _payServiceDTO = [[PayServiceDTO alloc] init];
    }
    
    return _payServiceDTO;
}


- (void)beginGetRegionInfo:(PayServiceDTO *)payServiceDTO
{
    [self sendRegionInfoHttpRequest:payServiceDTO];
}

- (void)beginGetCompanyList:(PayServiceDTO *)payServiceDTO
{
    [self sendCompanyListHttpRequest:payServiceDTO];
}

- (void)beginGetFeeMode:(PayServiceDTO *)payServiceDTO
{
    [self sendFeeModeHttpRequest:payServiceDTO];
}

- (void)beginGetAccountInfo:(PayServiceDTO *)payServiceDTO
{
    [self sendAccountInfoHttpRequest:payServiceDTO];
}

#pragma mark GetChargeCityList 获取所有地区

- (void)beginGetChargeCityList:(PayServiceDTO *)payServiceDTO
{
    self.payServiceDTO = payServiceDTO;
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
    
    [postDataDic setObject:payServiceDTO.typeCode forKey:KHttpRequestTypeCode];
    [postDataDic setObject:kPartnerValue forKey:kPartnerKey];
    
    NSString *url = [NSString stringWithFormat:@"%@", kChargeCityListURL];
    
    HTTPMSG_RELEASE_SAFELY(cityListHttpMsg);
    
    cityListHttpMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:url postDataDic:postDataDic cmdCode:CC_ChargeCityList];
    cityListHttpMsg.requestMethod = RequestMethodGet;
    
    [self.httpMsgCtrl sendHttpMsg:cityListHttpMsg];
}

- (void)parseCityList:(NSDictionary *)dic
{
    NSDictionary * dataDic = EncodeDicFromDic(dic, @"data");
    
    if ([[dic objectForKey:@"code"] isEqualToString:@""])
    {
        NSDictionary *cityDic0 = [dataDic objectForKey:@"cityMap"];
        
        NSArray *allKeys = [cityDic0 allKeys];
        
        NSMutableDictionary *cityDic = [NSMutableDictionary dictionaryWithCapacity:1];
        NSMutableArray *cityList = [[NSMutableArray alloc] init];
        
        for (NSString *key in allKeys)
        {
            NSMutableArray *cityArr = [NSMutableArray array];
            NSArray *citys = [cityDic0 objectForKey:key];
            for (NSDictionary *dic1 in citys) {
               SNCityFirstLetterDTO *cityDTO = [SNCityFirstLetterDTO new];
                [cityDTO  parseFromDict:dic1];
                [cityArr addObject:cityDTO];
                [cityList addObject:cityDTO];
            }
            
            [cityDic setObject:cityArr forKey:key];
            
        }
        self.cityDic = cityDic;
        self.regionList = cityList;
        
        [self getCityListDidFinish:YES];
    }
    else
    {
        self.errorCode = [dic objectForKey:@"code"];
        self.requestFail = YES;
        
        [self getCityListDidFinish:NO];
    }
}

#pragma mark charge mode Request 缴费账户信息
- (void)beginGetChargeMode:(PayServiceDTO *)payServiceDTO
{
    self.payServiceDTO = payServiceDTO;
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
    
    [postDataDic setObject:payServiceDTO.companyId forKey:KHttpRequestcompanyId];
    [postDataDic setObject:kPartnerValue forKey:kPartnerKey];
    
    NSString *url = [NSString stringWithFormat:@"%@", kChargeModeQueryURl];
    
    HTTPMSG_RELEASE_SAFELY(chargeModeHttpMsg);
    
    chargeModeHttpMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:url postDataDic:postDataDic cmdCode:CC_ChargeMode];
    chargeModeHttpMsg.requestMethod = RequestMethodGet;
    
    [self.httpMsgCtrl sendHttpMsg:chargeModeHttpMsg];
    
    
}

- (void)parseChargeModeInfo:(NSDictionary *)dic
{
    NSDictionary * dataDic = EncodeDicFromDic(dic, @"data");

    if ([[dic objectForKey:@"code"] isEqualToString:@""])
    {
        NSDictionary *modeList = [(NSArray *)[dataDic objectForKey:@"modeList"] objectAtIndex:0];
        
        self.payServiceDTO.modeCode = EncodeStringFromDic(modeList, @"modeCode");
        self.payServiceDTO.isChargeTime = EncodeStringFromDic(modeList, @"isChargeTime");
        self.payServiceDTO.chargeTimeMessage = EncodeStringFromDic(modeList, @"chargeTimeMessage");
        
        [self getChargeModeInfoDidFinish:YES];
    }
    else
    {
        self.errorCode = [dic objectForKey:@"code"];
        self.requestFail = YES;
        
        [self getChargeModeInfoDidFinish:NO];
    }
}

#pragma mark -
#pragma mark region Http Request 获取所有地区

- (void)sendRegionInfoHttpRequest:(PayServiceDTO *)payServiceDTO
{
    self.payServiceDTO = payServiceDTO;
    
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
    
    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
    
    [postDataDic setObject:self.payServiceDTO.typeCode forKey:KHttpRequestTypeCode];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@", kHostAddressForHttps, kHttpRequestGetAreaRequireKey];
    
    HTTPMSG_RELEASE_SAFELY(regionInfoHttpMsg);
    
    regionInfoHttpMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:url postDataDic:postDataDic cmdCode:CC_RegionInfo];
    regionInfoHttpMsg.requestMethod=RequestMethodGet;
    [self.httpMsgCtrl sendHttpMsg:regionInfoHttpMsg];
    
    TT_RELEASE_SAFELY(postDataDic);
}

- (void)parseResionInfo:(NSDictionary *)dic
{
    if ([[dic objectForKey:@"errorCode"] isEqualToString:@""])
    {
        NSArray *array = [dic objectForKey:@"areaList"];
        
        NSMutableArray *_areaList = [[NSMutableArray alloc] init];
        
        for (NSDictionary *areas in array)
        {
            PayServiceDTO *_regionTemp = [[PayServiceDTO alloc] init];
            
            [_regionTemp encodeFromDictionary:areas];
            
            [_areaList addObject:_regionTemp];
            
            TT_RELEASE_SAFELY(_regionTemp);
        }
        
        self.regionList = _areaList;
        
        TT_RELEASE_SAFELY(_areaList);
        
        [self getRegionInfoDidFinish:YES];
    }
    else
    {
        self.errorCode = [dic objectForKey:@"errorCode"];
        self.requestFail = YES;
        
        [self getRegionInfoDidFinish:NO];
    }
}

#pragma mark -
#pragma mark Company Http Request 根据合肥算出合肥自来水公司

- (void)sendCompanyListHttpRequest:(PayServiceDTO *)payServiceDTO
{
    self.payServiceDTO = payServiceDTO;
    
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
    
    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
    
    [postDataDic setObject:self.payServiceDTO.typeCode forKey:KHttpRequestTypeCode];
    
    [postDataDic setObject:self.payServiceDTO.areaCode forKey:KHttpRequestAreaCode];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttps, kHttpRequestGetCompanyByAreaRequireKey];
    
    HTTPMSG_RELEASE_SAFELY(companyListHttpMsg);
    
    companyListHttpMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:url postDataDic:postDataDic cmdCode:CC_CompanyList];
    companyListHttpMsg.requestMethod=RequestMethodGet;
    [self.httpMsgCtrl sendHttpMsg:companyListHttpMsg];
    
    TT_RELEASE_SAFELY(postDataDic);
}

- (void)parseCompanyList:(NSDictionary *)dic
{
    if ([[dic objectForKey:@"errorCode"] isEqualToString:@""])
    {
        NSArray *array = [dic objectForKey:@"companyList"];
        
        NSMutableArray *_comList = [[NSMutableArray alloc] init];
        
        for (NSDictionary *companyes in array)
        {
            PayServiceDTO *_companyTemp = [[PayServiceDTO alloc] init];
            
            [_companyTemp encodeFromDictionary:companyes];
            
            [_comList addObject:_companyTemp];
            
            TT_RELEASE_SAFELY(_companyTemp);
        }
        
        self.companyList = _comList;
        
        DLog(@"company list is %@", self.companyList);
        
        [self getCompanyListDidFinish:YES];
        
        TT_RELEASE_SAFELY(_comList);
        
    }
    else
    {
        self.errorCode = [dic objectForKey:@"errorCode"];
        self.requestFail = YES;
        
        [self getCompanyListDidFinish:NO];
    }
}

#pragma mark -
#pragma mark Fee Mode Http Request根据自来水公司获取缴费类型ModeCode
- (void)sendFeeModeHttpRequest:(PayServiceDTO *)payServiceDTO
{
    self.payServiceDTO = payServiceDTO;
    
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
    
    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
    
    [postDataDic setObject:self.payServiceDTO.typeCode forKey:KHttpRequestTypeCode];
    
    [postDataDic setObject:self.payServiceDTO.areaCode forKey:KHttpRequestAreaCode];
    
    [postDataDic setObject:self.payServiceDTO.companyId forKey:KHttpRequestcompanyId];
    
    [postDataDic setObject:self.payServiceDTO.companyCode forKey:kHttpRequestcompanyCode];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttps, kHttpRequestGetCompanyModeRequireKey];
    
    HTTPMSG_RELEASE_SAFELY(feeModeHttpMsg);
    
    feeModeHttpMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:url postDataDic:postDataDic cmdCode:CC_FeeMode];
    feeModeHttpMsg.requestMethod=RequestMethodGet;
    [self.httpMsgCtrl sendHttpMsg:feeModeHttpMsg];
    
    TT_RELEASE_SAFELY(postDataDic);
}

- (void)parseFeeMode:(NSDictionary *)dic
{
    if ([[dic objectForKey:@"errorCode"] isEqualToString:@""])
    {
        self.payServiceDTO.modeCode = [dic objectForKey:@"modeCode"];
        [self getFeeModeDidFinish:YES];
    }
    else
    {
        self.errorCode = [dic objectForKey:@"errorCode"];
        self.requestFail = YES;
        
        [self getFeeModeDidFinish:NO];
    }
}

#pragma mark -
#pragma mark AccountInfo Http Request 获取账户信息

- (void)sendAccountInfoHttpRequest:(PayServiceDTO *)payServiceDTO
{
    self.payServiceDTO = payServiceDTO;
    
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
    
    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
	
	[postDataDic setObject:self.payServiceDTO.typeCode forKey:KHttpRequestTypeCode]; 
    
	[postDataDic setObject:self.payServiceDTO.areaCode forKey:KHttpRequestAreaCode];
	
	[postDataDic setObject:self.payServiceDTO.companyId forKey:KHttpRequestcompanyId];
    
	[postDataDic setObject:self.payServiceDTO.chargeAccount forKey:@"chargeAccount"];	
	
    [postDataDic setObject:self.payServiceDTO.modeCode forKey:@"modeCode"];	
    
    [postDataDic setObject:@"1"  forKey:@"beginNum"];
    
    [postDataDic setObject:@"1"  forKey:@"queryNum"];
    
    DLog(@"xiewei  %@",postDataDic);
    
    self.payAccountNum = self.payServiceDTO.chargeAccount;//把查询后的账户传给payAccountNum，避免重复查询
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttps, kHttpRequestGetAccountInfoRequireKey];
    
    HTTPMSG_RELEASE_SAFELY(accountInfoHttpMsg);
    
    accountInfoHttpMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:url postDataDic:postDataDic cmdCode:CC_AccountInfo];
    accountInfoHttpMsg.requestMethod =RequestMethodGet;
    [self.httpMsgCtrl sendHttpMsg:accountInfoHttpMsg];
    
    TT_RELEASE_SAFELY(postDataDic);
}

- (void)parseAccountInfo:(NSDictionary *)dic
{
    if ([[dic objectForKey:@"errorCode"] isEqualToString:@""])
    {
        NSString *model = [dic objectForKey:@"model"];
        
        NSArray *accountInfoArray = [dic objectForKey:@"accountInfo"];
        
        if (accountInfoArray == nil || [accountInfoArray count] == 0)
        {
            self.errorCode =  L(@"Account information does not exist");
            self.requestFail = YES;
            
            [self getAccountInfoDidFinish:NO];
            
            return;
        }
        
        NSDictionary *accountInfo = [accountInfoArray objectAtIndex:0];
        
        self.payServiceDTO.model = model;
        
        self.payServiceDTO.accountNo = [UserCenter defaultCenter].userInfoDTO.accountNo;
        
        self.payServiceDTO.efubaoBalance = [UserCenter defaultCenter].userInfoDTO.yifubaoBalance;
        
        self.payServiceDTO.customerName = [accountInfo objectForKey:@"customerName"];
        
        self.customerName = [accountInfo objectForKey:@"customerName"];
        
        self.payServiceDTO.balance = [accountInfo objectForKey:@"balance"];
        
        self.payServiceDTO.payAmount = [accountInfo objectForKey:@"payAmount"];
        
        float temp = [[accountInfo objectForKey:@"payAmount"] floatValue] / 100;
        
        NSString *payMoney = [NSString stringWithFormat:@"%.2f",temp];
        
        self.payBalance = [payMoney stringByAppendingString:L(@" yuan")];
        
        self.payServiceDTO.contractNo = [accountInfo objectForKey:@"contractNo"];
        
        self.payServiceDTO.beginDate = [accountInfo objectForKey:@"beginDate"];
        
        self.payServiceDTO.endDate = [accountInfo objectForKey:@"endDate"];
        
        self.payServiceDTO.accountTerm = [accountInfo objectForKey:@"accountTerm"];
        
        self.isGetAccount = YES;
        
        [self getAccountInfoDidFinish:YES];
    }
    else
    {
        self.errorCode = [dic objectForKey:@"errorCode"];
        self.requestFail = YES;
        
        [self getAccountInfoDidFinish:NO];
    }
}

#pragma mark -
#pragma mark 网络请求回调

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    switch (receiveMsg.cmdCode) {
            
        case CC_ChargeCityList:
        {
            DLog(@"requestCityList from server  NSUrlString=%@\n",[receiveMsg.jasonItems description]);
            [self getCityListDidFinish:NO];
        }
            break;
            
        case CC_ChargeMode:
        {
            DLog(@"chargeMode from server  NSUrlString=%@\n",[receiveMsg.jasonItems description]);
            [self getChargeModeInfoDidFinish:NO];
        }
            break;


            
        case CC_RegionInfo:
        {
            DLog(@"requestRegion from server  NSUrlString=%@\n",[receiveMsg.jasonItems description]);
            [self getRegionInfoDidFinish:NO];
        }
            break;
            
        case CC_CompanyList:
        {
            DLog(@"requestCompanyList from server  NSUrlString=%@\n",[receiveMsg.jasonItems description]);	
            [self getCompanyListDidFinish:NO];
        }
            break;
            
        case CC_FeeMode:
        {
            DLog(@"requestFeeMode from server  NSUrlString=%@\n",[receiveMsg.jasonItems description]);	
            [self getFeeModeDidFinish:NO];
        }
            break;
            
        case CC_AccountInfo:
        {
            DLog(@"requestAccountInfo from server  NSUrlString=%@\n",[receiveMsg.jasonItems description]);	
            [self getAccountInfoDidFinish:NO];
        }
            break;
            
        default:
            break;
    }
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    NSDictionary *items = receiveMsg.jasonItems;

    switch (receiveMsg.cmdCode) {
            
        case CC_ChargeCityList:
        {
            [self parseCityList:items];
        }
            break;
            
        case CC_ChargeMode:
        {
            [self parseChargeModeInfo:items];
        }
            break;

            
        case CC_RegionInfo:
        {
            [self parseResionInfo:items];         
        }
            break;
            
        case CC_CompanyList:
        {
            [self parseCompanyList:items];
        }
            break;
            
        case CC_FeeMode:
        {
            [self parseFeeMode:items];
        }
            break;
            
        case CC_AccountInfo:
        {
            [self parseAccountInfo:items];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark -
#pragma mark 调用回调函数

- (void)getCityListDidFinish:(BOOL)isSuccess
{
    if (_delegate && [_delegate respondsToSelector:@selector(getCityListCompleteWithService:Result:errorMsg:)]) {
        [_delegate getCityListCompleteWithService:self Result:isSuccess errorMsg:self.errorMsg];
        }
}

- (void)getChargeModeInfoDidFinish:(BOOL)isSuccess
{
    if (_delegate && [_delegate respondsToSelector:@selector(getChargeModeCompleteWithService:Result:errorMsg:)]) {
        [_delegate getChargeModeCompleteWithService:self Result:isSuccess errorMsg:self.errorMsg];
    }
    
}

- (void)getRegionInfoDidFinish:(BOOL)isSuccess
{
    if (_delegate && [_delegate respondsToSelector:@selector(getRegionInfoCompleteWithService:Result:errorMsg:)]) {
        [_delegate getRegionInfoCompleteWithService:self Result:isSuccess errorMsg:self.errorMsg];
    }
}

- (void)getCompanyListDidFinish:(BOOL)isSuccess
{
    if (_delegate && [_delegate respondsToSelector:@selector(getCompanyListCompleteWithService:Result:errorMsg:)]) {
        [_delegate getCompanyListCompleteWithService:self Result:isSuccess errorMsg:self.errorMsg];
    }
}

- (void)getFeeModeDidFinish:(BOOL)isSuccess
{
    if (_delegate && [_delegate respondsToSelector:@selector(getFeeModeCompleteWithService:Result:errorMsg:)]) {
        [_delegate getFeeModeCompleteWithService:self Result:isSuccess errorMsg:self.errorMsg];
    }
}

- (void)getAccountInfoDidFinish:(BOOL)isSuccess
{
    if (_delegate && [_delegate respondsToSelector:@selector(getAccountInfoCompleteWithService:Result:errorMsg:)]) {
        [_delegate getAccountInfoCompleteWithService:self Result:isSuccess errorMsg:self.errorMsg];
    }
}

@end
