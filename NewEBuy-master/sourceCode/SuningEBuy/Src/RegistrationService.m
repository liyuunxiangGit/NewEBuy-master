//
//  RegistrationService.m
//  SuningEBuy
//
//  Created by 王家兴 on 13-7-13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "RegistrationService.h"

@implementation RegistrationService

@synthesize registPrepareDto = _registPrepareDto;
@synthesize registDetailDto = _registDetailDto;
@synthesize storeRegistDto = _storeRegistDto;
@synthesize delegate = _delegate;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_registPrepareDto);
    TT_RELEASE_SAFELY(_registDetailDto);
    TT_RELEASE_SAFELY(_storeRegistDto);
    
}

- (void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(registrationPrepareMsg);
    HTTPMSG_RELEASE_SAFELY(registrationDetailMsg);
    HTTPMSG_RELEASE_SAFELY(storesRegistrationMsg);
}

-(void)beginSendRegistrationPrepareRequest:(NSString *)userId
{
     NSMutableDictionary *postDic = [[NSMutableDictionary alloc] init];
    
    if (NotNilAndNull(userId)) {
        [postDic setObject:userId forKey:@"userId"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"userId"];
    }
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kMobileHostAddress, @"getCheckRuleInfo.do"];
    
    HTTPMSG_RELEASE_SAFELY(registrationPrepareMsg);
    
    registrationPrepareMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:url postDataDic:postDic cmdCode:CC_RegistrationPrepare];
    TT_RELEASE_SAFELY(postDic);
    
    [self.httpMsgCtrl sendHttpMsg:registrationPrepareMsg];
}

- (void)beginSendRegistrationDetailRequest:(RegistrationDetailBaseDTO *)dto
{
    NSMutableDictionary *postDic = [[NSMutableDictionary alloc] init];
    
    if (!IsStrEmpty(dto.userId)) {
        [postDic setObject:dto.userId forKey:@"userId"];
    }
    
    if (!IsStrEmpty(dto.checkType)) {
        [postDic setObject:dto.checkType forKey:@"checkType"];
    }
    
    if (NotNilAndNull(dto.checkCodeId)) {
        [postDic setObject:dto.checkCodeId forKey:@"checkCodeId"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"checkCodeId"];
    }
    
    [postDic setObject:dto.distance forKey:@"distance"];
    
    if (NotNilAndNull(dto.latitudeAndLongitude)) {
        [postDic setObject:dto.latitudeAndLongitude forKey:@"latitudeAndLongitude"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"latitudeAndLongitude"];
    }
    
    [postDic setObject:dto.storeId forKey:@"storeId"];
    
    if (NotNilAndNull(dto.custNum)) {
        [postDic setObject:dto.custNum forKey:@"custNum"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"custNum"];
    }
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kMobileHostAddress, @"checkin.do"];
    
    HTTPMSG_RELEASE_SAFELY(registrationDetailMsg);
    
    registrationDetailMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:url postDataDic:postDic cmdCode:CC_RegistrationDetail];
    
    TT_RELEASE_SAFELY(postDic);
    
    [self.httpMsgCtrl sendHttpMsg:registrationDetailMsg];
}

- (void)beginSendStoresRegistrationRequest:(StoresRegistrationBaseDTO *)dto
{
    NSMutableDictionary *postDic = [[NSMutableDictionary alloc] init];
    
//    if (!IsStrEmpty(dto.userId)) {
//        [postDic setObject:dto.userId forKey:@"userId"];
//    }
    [postDic setObject:IsStrEmpty(dto.userId)?@"":dto.userId forKey:@"userId"];
    
    [postDic setObject:dto.distance forKey:@"distance"];
    
    if (!IsStrEmpty(dto.latitudeAndLongitude)) {
        [postDic setObject:dto.latitudeAndLongitude forKey:@"latitudeAndLongitude"];
    }
    
    [postDic setObject:dto.storeId forKey:@"storeId"];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kMobileHostAddress, @"isStroreCheckin.do"];
    
    HTTPMSG_RELEASE_SAFELY(storesRegistrationMsg);
    
    storesRegistrationMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:url postDataDic:postDic cmdCode:CC_StoresRegistration];
    
    TT_RELEASE_SAFELY(postDic);
    
    [self.httpMsgCtrl sendHttpMsg:storesRegistrationMsg];
}

#pragma mark -
#pragma mark http message delegate

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    if (receiveMsg.cmdCode == CC_RegistrationPrepare) {
        [self getRegistrationPrepareFinish:NO];
    }
    
    if (receiveMsg.cmdCode == CC_RegistrationDetail) {
        [self getRegistrationDetailFinish:NO];
    }
    
    if (receiveMsg.cmdCode == CC_StoresRegistration) {
        [self getStoresRegistrationFinish:NO];
    }
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{    
    NSArray *array = [receiveMsg.jasonItems objectForKey:@"resultInfo"];
    
    if (receiveMsg.cmdCode == CC_RegistrationPrepare) {
        if (NotNilAndNull(array) && 1 == [array count]) {            
            RegistrationPrepareDTO *dto = [[RegistrationPrepareDTO alloc] init];
            [dto encodeFromDictionary:(NSDictionary*)[array objectAtIndex:0]];
            self.registPrepareDto = dto;
            TT_RELEASE_SAFELY(dto);
            
            CheckInDTO *cDto = [[CheckInDTO alloc] init];
            [cDto encodeFromDictionary:(NSDictionary*)[array objectAtIndex:0]];
            self.checkInDto = cDto;
            
            [self getRegistrationPrepareFinish:YES];
        }else{
            
            [self getRegistrationPrepareFinish:NO];
        }
    }
    
    if (receiveMsg.cmdCode == CC_RegistrationDetail) {
        if (NotNilAndNull(array) && 1 == [array count]) {
            
            NSDictionary *dic = [array objectAtIndex:0];
            
            self.errorMsg = NotNilAndNull([dic objectForKey:@"errorMessage"])?[dic objectForKey:@"errorMessage"]:L(@"NWRequestFail");
            
            RegistrationDetailDTO *dto = [[RegistrationDetailDTO alloc] init];
            [dto encodeFromDictionary:dic];
            self.registDetailDto = dto;
            TT_RELEASE_SAFELY(dto);
            
            [self getRegistrationDetailFinish:YES];
        }else{
            
            [self getRegistrationDetailFinish:NO];
        }
    }
    
    if (receiveMsg.cmdCode == CC_StoresRegistration) {
        if (NotNilAndNull(array) && 1 == [array count]) {
            
            NSDictionary *dic = [array objectAtIndex:0];
            
            self.errorMsg = NotNilAndNull([dic objectForKey:@"errorMessage"])?[dic objectForKey:@"errorMessage"]:L(@"NWRequestFail");
            StoresRegistrationDTO *dto = [[StoresRegistrationDTO alloc] init];
            [dto encodeFromDictionary:dic];
            self.storeRegistDto = dto;
            TT_RELEASE_SAFELY(dto);
            
            [self getStoresRegistrationFinish:YES];
        }else{
            
            [self getStoresRegistrationFinish:NO];
        }
    }
}

- (void)getRegistrationPrepareFinish:(BOOL)isSuccess
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (_delegate && [_delegate respondsToSelector:@selector(didSendRegistrationPrepareRequestComplete:Result:)]) {
            [_delegate didSendRegistrationPrepareRequestComplete:self Result:isSuccess];
        }
    });
}

- (void)getRegistrationDetailFinish:(BOOL)isSuccess
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (_delegate && [_delegate respondsToSelector:@selector(didSendRegistrationDetailRequestComplete:Result:)]) {
            [_delegate didSendRegistrationDetailRequestComplete:self Result:isSuccess];
        }
    });
}

- (void)getStoresRegistrationFinish:(BOOL)isSuccess
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (_delegate && [_delegate respondsToSelector:@selector(didSendStoresRegistrationRequestComplete:Result:)]) {
            [_delegate didSendStoresRegistrationRequestComplete:self Result:isSuccess];
        }
    });
}


@end
