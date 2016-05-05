//
//  GiftCouponService.m
//  SuningEBuy
//
//  Created by  on 12-9-29.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "GiftCouponService.h"

@implementation GiftCouponService

@synthesize delegate = _delegate;
//@synthesize selectList = _selectList;

- (id)init
{
    self = [super init];
    if (self) {
        
        isFirstLag = YES;
    }
    return self;
}

- (NSMutableArray *)couponList
{
    if (!_couponList) {
        _couponList = [[NSMutableArray alloc] init];
    }
    return _couponList;
}

- (NSMutableArray *)cashCardList
{
    if (!_cashCardList) {
        _cashCardList = [[NSMutableArray alloc] init];
    }
    return _cashCardList;
}

- (NSMutableDictionary *)cCouponList
{
    if (!_cCouponList) {
        _cCouponList = [[NSMutableDictionary alloc] init];
    }
    return _cCouponList;
}


- (NSMutableArray *)normalCouponList
{
    if (!_normalCouponList) {
        _normalCouponList = [[NSMutableArray alloc] init];
    }
    return _normalCouponList;
}

- (void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(giftCouponListHttpMsg);
    HTTPMSG_RELEASE_SAFELY(activeGiftCouponHttpMsg);
}

#pragma mark -
#pragma mark service life

- (void)beginGetGiftCouponListRequest:(BOOL)isCOrder unUsable:(BOOL)isable
{
    //清空
    [self.cashCardList removeAllObjects];
    [self.normalCouponList removeAllObjects];
    [self.couponList removeAllObjects];
    NSMutableDictionary *postDataDic  = [[NSMutableDictionary alloc] initWithCapacity:3];
    
    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
    [postDataDic setObject:kHttpRequestHomeCatalogIdValue forKey:kHttpRequestHomeCatalogIdKey];
    if (isCOrder) {
        [postDataDic setObject:@"3" forKey:@"isCOrder"];
    }
    if (isable) {
        [postDataDic setObject:@"1" forKey:@"unUsable"];//1 不可用券
        
    }
    NSString *url = [NSString stringWithFormat:@"%@/%@", kHostAddressForHttps,
                     [@"SNMobileCardAndCouponsListView" passport]];
    
    HTTPMSG_RELEASE_SAFELY(giftCouponListHttpMsg);
    
    giftCouponListHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                       requestUrl:url
                                                      postDataDic:postDataDic
                                                          cmdCode:CC_GiftCouponList];
    giftCouponListHttpMsg.requestMethod =RequestMethodGet;
    [self.httpMsgCtrl sendHttpMsg:giftCouponListHttpMsg];
    
    TT_RELEASE_SAFELY(postDataDic);
}

- (void)beginActiveGiftCouponRequest:(NSString *)cardNo cardPwd:(NSString *)cardPwd phoneNo:(NSString *)phoneNo
{
    self.phoneNum = phoneNo;
    
    NSMutableDictionary *postDataDic  = [[NSMutableDictionary alloc] init];
    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
    [postDataDic setObject:cardNo?cardNo:@"" forKey:@"cardNo"];
    [postDataDic setObject:cardPwd?cardPwd:@"" forKey:@"cardPwd"];
    
    if (!IsStrEmpty(self.phoneNum)) {
        if (isFirstLag == YES) {
            [postDataDic setObject:@"" forKey:@"aFlag"];
        }
        else
        {
            [postDataDic setObject:@"Y" forKey:@"aFlag"];
        }
        [postDataDic setObject:phoneNo forKey:@"phoneNo"];
        [postDataDic setObject:@"xxtjj" forKey:@"action"];
        
    }
    
    
    
    NSString *url = [NSString stringWithFormat:@"%@/%@", kHostAddressForHttps,
                     [@"SNMTBindCardAndCoupons" passport]];
    
    HTTPMSG_RELEASE_SAFELY(activeGiftCouponHttpMsg);
    
    activeGiftCouponHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                         requestUrl:url
                                                        postDataDic:postDataDic
                                                            cmdCode:CC_ActiveGiftCoupon];
    [self.httpMsgCtrl sendHttpMsg:activeGiftCouponHttpMsg];
    
    TT_RELEASE_SAFELY(postDataDic);
}


#pragma mark -
#pragma mark final

- (void)getGiftCouponListOk:(BOOL)isSuccess
{
    if (_delegate && [_delegate respondsToSelector:@selector(getGiftCouponListCompletionWithResult:
                                                             errorMsg:)]) {
        [_delegate getGiftCouponListCompletionWithResult:isSuccess
                                                errorMsg:self.errorMsg];
    }
}

#pragma mark -
#pragma mark http message delegate

- (void)parseGiftCouponList:(NSDictionary *)items
{
    NSArray *itemArr = EncodeArrayFromDic(items, @"giftCouponList");
    
    if ([itemArr count] > 0){
        
        for (NSDictionary *dic in itemArr)
        {
            GiftCouponDTO *dto = [[GiftCouponDTO alloc]init];
            [dto encodeFromDictionary:dic];
            
            
            if (dto.couponType == CouponTypeTotal || dto.couponType == CouponTypeAdCoupon ||
                [dto.balance floatValue] <= 0)
            {
                //do nothing
            }
            else if (dto.couponType == CouponTypeCashCard)  //礼品卡
            {
                [self.cashCardList addObject:dto];
            }
            else
            {
                [self.normalCouponList addObject:dto];
            }
        }
    }
    
    
    /* add by gjf 新增c店节点  */
    //------beging
    NSArray *ccouplist = EncodeArrayFromDic(items, @"cCouponList");
    if ([ccouplist count] > 0){
        
        for (NSDictionary *dic in ccouplist)
        {
            NSString *__vendorCode = EncodeStringFromDic(dic, @"vendorCode");
            NSString *__vendorName = EncodeStringFromDic(dic, @"vendorName");
            NSString *__couponCount  = EncodeStringFromDic(dic, @"couponCount");
            NSMutableDictionary *coupon = [[NSMutableDictionary alloc] initWithCapacity:1];
            [coupon setValue:__vendorCode forKey:@"vendorCode"];
            [coupon setValue:__vendorName forKey:@"vendorName"];
            [coupon setValue:__couponCount forKey:@"couponCount"];
            NSArray *couponlist = EncodeArrayFromDic(dic, @"couponList");
            NSMutableArray *couponl = [[NSMutableArray alloc] initWithCapacity:0];
            for (NSDictionary *dic1 in couponlist) {
                GiftCouponDTO *dto = [[GiftCouponDTO alloc]init];
                [dto encodeFromDictionary:dic1];
                dto.exclusive=@"1";
                dto.vendorCode = __vendorCode;
                dto.vendorName = __vendorName;
                [couponl addObject:dto];
                TT_RELEASE_SAFELY(dto);
            }
            [coupon setObject:couponl forKey:@"couponlist"];
            [self.couponList addObject:coupon];
        }
    }
    //--------end
    
    [self getGiftCouponListOk:YES];
}

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    if (receiveMsg.cmdCode == CC_GiftCouponList) {
        [self getGiftCouponListOk:NO];
    }else{
        if (IsStrEmpty(self.phoneNum)) {
            //激活券
            [self getActiveGiftCouponOK:NO];
        }
        else{
            [self getRecommendNumOK:NO allianceName:nil allianceDiscount:nil];
        }
    }
    
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    NSDictionary *items = receiveMsg.jasonItems;
    if (receiveMsg.cmdCode == CC_GiftCouponList)
    {
        if (!items) {
            self.errorMsg = kHttpResponseJSONValueFailError;
            [self getGiftCouponListOk:NO];
        }else{
            [self parseGiftCouponList:items];
        }
    }else{
        
        if (IsStrEmpty(self.phoneNum)) {
            //激活券
            if ([[items objectForKey:@"isSuccess"] isEqualToString:@"1"]) {
                [self getActiveGiftCouponOK:YES];
            }else{
                self.errorMsg = [items objectForKey:@"errorMessage"];
                [self getActiveGiftCouponOK:NO];
            }
        }else{
            //联盟优惠
            if ([[items objectForKey:@"isSuccess"] isEqualToString:@"1"] && !IsStrEmpty([items objectForKey:@"allianceName"])) {
                isFirstLag = NO;
                NSString *allianceName = [items objectForKey:@"allianceName"];
                NSString *allianceDiscount = [items objectForKey:@"allianceDiscount"];
                [self getRecommendNumOK:YES allianceName:allianceName allianceDiscount:allianceDiscount];
            }
            else
            {
                self.errorMsg = [items objectForKey:@"returnMsg"];
                [self getRecommendNumOK:NO allianceName:nil allianceDiscount:nil];
            }
        }
        
    }
}


- (void)getActiveGiftCouponOK:(BOOL)isSuccess
{
    if (_delegate && [_delegate respondsToSelector:@selector(activeGiftCouponCompletionWithResult:errorMsg:)])
    {
        [_delegate activeGiftCouponCompletionWithResult:isSuccess errorMsg:self.errorMsg];
    }
}

- (void)getRecommendNumOK:(BOOL)isSuccess allianceName:(NSString *)name allianceDiscount:(NSString *)discount
{
    if (_delegate && [_delegate respondsToSelector:@selector(activeRecommendNumCompletionWithResult:allianceName:allianceDiscount:errorMsg:)]) {
        [_delegate activeRecommendNumCompletionWithResult:isSuccess allianceName:name allianceDiscount:discount errorMsg:self.errorMsg];
    }
}

+ (BOOL)validateMobileNo: (NSString *) mobileNo {
    NSString *mobileNoRegex = @"1[0-9]{10,10}";
    NSPredicate *mobileNoTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileNoRegex];
	
    return [mobileNoTest evaluateWithObject:mobileNo];
}

+ (BOOL)validateRegisterId:(NSString *)registerIdString{
	BOOL ret = NO;
	if ([self validateMobileNo:registerIdString ]) {
		ret = YES;
	}else{
        
        ret = NO;
    }
	return ret;
}

+ (BOOL)validateString:(NSString *)string
{
    NSString *verifyCodeRegex = [NSString stringWithFormat:@"([a-z,A-Z,0-9]+)"];
    NSPredicate *verifyCodeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", verifyCodeRegex];
    if ([verifyCodeTest evaluateWithObject:string]==NO)
    {
        return NO;
    }
    return YES;
}

@end
