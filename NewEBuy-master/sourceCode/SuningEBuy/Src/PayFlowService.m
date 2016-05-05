//
//  PayFlowService.m
//  SuningEBuy
//
//  Created by  on 12-9-28.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "PayFlowService.h"
#import "ShopCartV2DTO.h"
#import "UserCenter.h"
#import "PasswdUtil.h"
#import "ShopCartV2ViewController.h"
#import "OpenUDID.h"
#import "KCOpenUDID.h"
//参数加密盐
#define kSubmitOrderParamEncodeSalt  @"sn201209"
//参数加密的key
//#define kSubmitOrderParamEncodeKey   @"userId"


@interface PayFlowService()
{
    
}

@property (nonatomic, copy) NSString *receiverPhoneStr;     //用于保存用户手机号，保存到payFlowDTO中

- (void)parseSubmitOrderInfo:(NSDictionary *)items praseSubmitInfo:(ParseSubmitInfoType)type;
- (void)parseLastShipInfo:(NSDictionary *)items;
//收集版本渠道信息
- (NSString *)collectSystemInfo;

@end

/*********************************************************************/

@implementation PayFlowService

@synthesize delegate = _delegate;
@synthesize receiverPhoneStr = _receiverPhoneStr;

- (void)dealloc {
    TT_RELEASE_SAFELY(_receiverPhoneStr);
    
}

- (id)init {
    self = [super init];
    if (self) {
        self.canTake = YES;
    }
    return self;
}

- (void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(submitOrderHttpMsg);
    HTTPMSG_RELEASE_SAFELY(paySubmitHttpMsg);
    HTTPMSG_RELEASE_SAFELY(lastShipInfoHttpMsg);
   
    HTTPMSG_RELEASE_SAFELY(confirmDeliveryAddressHttpMsg);
    HTTPMSG_RELEASE_SAFELY(paymentChooseHttpMsg);
    HTTPMSG_RELEASE_SAFELY(savePayMethoHttpMsg);
    HTTPMSG_RELEASE_SAFELY(saveCardAndCouponHttpMsg);
    HTTPMSG_RELEASE_SAFELY(getAndUseCloudDiamondMsg);
    HTTPMSG_RELEASE_SAFELY(getDelAndInsTimeMsg);
    HTTPMSG_RELEASE_SAFELY(getInstallTimeMsg);
    
    SERVICE_RELEASE_SAFELY(_shopCartService);
}

- (ShopCartV2Service *)shopCartService
{
    if (!_shopCartService)
    {
        _shopCartService = [[ShopCartV2Service alloc] init];
        _shopCartService.delegate = self;
    }
    return _shopCartService;
}

- (StoreInfoDto *)storeInfoDto
{
    if (!_storeInfoDto) {
        _storeInfoDto = [[StoreInfoDto alloc] init];
    }
    return _storeInfoDto;
}

- (AddressInfoDTO *)addressInfoDto
{
    if (!_addressInfoDto) {
        _addressInfoDto = [[AddressInfoDTO alloc] init];
    }
    return _addressInfoDto;
}

#pragma mark -  SubmitOrder Methods
#pragma mark    支付请求

- (void)beginSubmitOrderRequest:(ShipMode)shipMode
                    addressInfo:(AddressInfoDTO *)addressInfo
                      storeInfo:(StoreInfoDto *)storeInfo
                        invoice:(NSString *)invoice
                    invoiceType:(NSString *)invoiceType
                        ecoupon:(NSArray *)couponList
                     codeString:(NSString *)codeString
                 orderRemarkStr:(NSString *)orderRemarkStr


{
    NSMutableDictionary *postDataDic  = [[NSMutableDictionary alloc] init];
    
    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
    [postDataDic setObject:kHttpRequestHomeCatalogIdValue forKey:kHttpRequestHomeCatalogIdKey];
    
    if (shipMode == ShipModeSuningSend)//配送
    {
        self.receiverPhoneStr = addressInfo.tel;
        [postDataDic setObject:addressInfo.addressNo?addressInfo.addressNo:@"" forKey:@"addressId"];
        [postDataDic setObject:@"-1" forKey:@"shipmode"];
    }
    else if (shipMode == ShipModeSelfTake)   //自提
    {
        self.receiverPhoneStr = storeInfo.receiptPhone;
        [postDataDic setObject:@"-2" forKey:@"shipmode"];
        [postDataDic setObject:storeInfo.storeCode?storeInfo.storeCode:@"" forKey:@"siteId"];//7612
        [postDataDic setObject:storeInfo.storeName?storeInfo.storeName:@"" forKey:@"site"];//自提点名称(编码) 南京市珠江路
        [postDataDic setObject:storeInfo.receiptPhone?storeInfo.receiptPhone:@"" forKey:@"telephone"];//固定电话
        [postDataDic setObject:storeInfo.districtId?storeInfo.districtId:@"" forKey:@"districtId"];//自提区id 玄武区id
        [postDataDic setObject:storeInfo.districtName?storeInfo.districtName:@"" forKey:@"district"];//玄武区
        [postDataDic setObject:storeInfo.receiptPhone?storeInfo.receiptPhone:@"" forKey:@"cellphone"];//手机号码
        [postDataDic setObject:storeInfo.receiptName?storeInfo.receiptName:@"" forKey:@"receiveName"];
        
    }
    //发票
    [postDataDic setObject:invoice?invoice:@""   forKey:@"taxTitle"];
    [postDataDic setObject:invoiceType?invoiceType:@"0" forKey:@"invoiceType"];
    
    //订单备注
    [postDataDic setObject:orderRemarkStr?orderRemarkStr:@"" forKey:@"orderRemarkStr"];
    
    //couponList不为空为使用易购券
    if (couponList && [couponList count] > 0) {
        
        int vipCard = 1;
        int cashCard = 1;
        int gcoupon = 1;
        
        [postDataDic setObject:@"1"   forKey:@"useCoupon"];
        [postDataDic setObject:codeString?codeString:@"" forKey:@"validateCode"];
        for (GiftCouponDTO *couponDTO in couponList){
            if (couponDTO.couponType == CouponTypePoint) {//电子券有值并且选择了电子卷
                [postDataDic setObject:couponDTO.balance?couponDTO.balance:@"" forKey:@"ecoupon"];
            }else if(couponDTO.couponType == CouponTypeVIPCard){    //贵宾券
                NSString *vipCardKey = [NSString stringWithFormat:@"vipCard_%d",vipCard];
                NSString *vipCardAmountKey = [NSString stringWithFormat:@"vipCardAmount_%d",vipCard];
                [postDataDic setObject:couponDTO.giftCouponId forKey:vipCardKey];
                [postDataDic setObject:couponDTO.balance forKey:vipCardAmountKey];
                vipCard ++;
            }else if (couponDTO.couponType == CouponTypeCashCard){ //礼品卡
                //礼品卡id ==== name_id
                NSString *cashCardKey = [NSString stringWithFormat:@"cashCard_%d",cashCard];
                NSString *cashCardAmountKey = [NSString stringWithFormat:@"cashCardAmount_%d",cashCard];
                [postDataDic setObject:[NSString stringWithFormat:@"%@_%@",couponDTO.name,couponDTO.giftCouponId] forKey:cashCardKey];
                [postDataDic setObject:couponDTO.balance forKey:cashCardAmountKey];
                cashCard ++;
            }else if (couponDTO.couponType == CouponTypeVoucherCode){ //礼品卡
                
            }else{ //心意券等
                NSString *gcouponKey = [NSString stringWithFormat:@"gcoupon_%d",gcoupon];
                NSString *gcouponAmountKey = [NSString stringWithFormat:@"gcouponAmount_%d",gcoupon];
                [postDataDic setObject:couponDTO.giftCouponId forKey:gcouponKey];
                [postDataDic setObject:couponDTO.balance forKey:gcouponAmountKey];
                gcoupon ++;
            }
        }
    }
    else    //不使用易购券
    {
        [postDataDic setObject:@"0"   forKey:@"useCoupon"];
    }
    
    //  add by 张健   支付渠道
    [postDataDic setObject:[self collectSystemInfo] forKey:@"orderChannel"];
    [postDataDic setObject:[self collectSystemInfo] forKey:@"alliancePhoneNo"];
    
    [postDataDic setObject:[KCOpenUDID value] forKey:@"deviceNo"];
//

#warning 下个版本加联盟追踪号   这个版本不需要   数据源从李小开那的微博获取
    [postDataDic setObject:@"" forKey:@"traceId"];
    //
    
    [postDataDic setObject:@"0" forKey:@"entiretySubmitFlag"];
#warning cps 优惠
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString *name =@"cipher";
    NSString *cipher =[defaults objectForKey:name];
    if (cipher) {
        [postDataDic setObject:cipher forKey:@"cipher"];
    }
    
    NSString *url = [NSString stringWithFormat:@"%@/%@", kHostAddressForHttps, [@"SNMobileSubmitOrder" passport]];
    HTTPMSG_RELEASE_SAFELY(submitOrderHttpMsg);
    submitOrderHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                    requestUrl:url
                                                   postDataDic:postDataDic
                                                       cmdCode:CC_SubmitOrder];
    [self.httpMsgCtrl sendHttpMsg:submitOrderHttpMsg];
    TT_RELEASE_SAFELY(postDataDic);
}

- (void)beginPaySubmitRequest:(payFlowDTO *)payDto
{
    NSMutableDictionary *postDataDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                        kHttpRequestHomeStoreValue,kHttpRequestHomeStoreKey,
                                        kHttpRequestHomeCatalogIdValue,kHttpRequestHomeCatalogIdKey,
                                        kHttpResponseShoppingCartPayLangValue,kHttpResponseShoppingCartPayLangId,
                                        nil];
    
    NSMutableDictionary *postDic = [[NSMutableDictionary alloc] init];
    [postDic setObject:payDto.orderId?payDto.orderId:@"" forKey:kHttpResponseShoppingCartPayOrderInfo];
    [postDic setObject:payDto.orderPlacerTel?payDto.orderPlacerTel:@"" forKey:kHttpResponseShoppingCartPayOrderPlacerTel];
    [postDic setObject:payDto.isPrepay?payDto.isPrepay:@"" forKey:kHttpResponseShoppingCartPayIsPrepay];
    [postDic setObject:payDto.policyId?payDto.policyId:@"" forKey:kHttpResponseShoppingCartPayPolicyId];
    
    switch (payDto.payMode) {
        case PayModeSNSDK:
        {
            [postDic setObject:@"12" forKey:@"sdkFlag"];
            [postDic setObject:@"20001" forKey:@"subpolicyid"];
            break;
        }
        case PayModeCashOnDelivery:
        {
            [postDic setObject:payDto.subCodpolicyId?payDto.subCodpolicyId:@"" forKey:kHttpResponseShoppingCartPaySubCodpolicyId];
            break;
        }
        case PayModeHuiFuWeb:
        {
            [postDic setObject:payDto.subpolicyid?payDto.subpolicyid:@"" forKey:kHttpResponseShoppingCartPaySubpolicyid];
            break;
        }
        case PayModeEfubao:
        {
            [postDic setObject:payDto.prepay?payDto.prepay:@"" forKey:kHttpResponseShoppingCartPayPrepay];
            [postDic setObject:payDto.eppPayPwd?payDto.eppPayPwd:@"" forKey:kHttpResponseShoppingCartPayPassword];
            [postDic setObject:payDto.subpolicyid?payDto.subpolicyid:@"" forKey:kHttpResponseShoppingCartPaySubpolicyid];
            if ([payDto.isNeedValidate boolValue]) {
                [postDic setObject:payDto.verifyCode?payDto.verifyCode:@""
                            forKey:@"validateCode"];
            }
            break;
        }
        case PayModeUPPay1_0:
        {
            [postDic setObject:payDto.prepay?payDto.prepay:@"" forKey:kHttpResponseShoppingCartPayPrepay];
            [postDic setObject:payDto.eppPayPwd?payDto.eppPayPwd:@"" forKey:kHttpResponseShoppingCartPayPassword];
            [postDic setObject:payDto.subpolicyid?payDto.subpolicyid:@"" forKey:kHttpResponseShoppingCartPaySubpolicyid];
        }
            break;
        case PayModeOnStore:
        {
            [postDic setObject:payDto.subCodpolicyId?payDto.subCodpolicyId:@"" forKey:kHttpResponseShoppingCartPaySubCodpolicyId];
        }
            break;
        case PayModeWebEfubao:
        {
            [postDic setObject:payDto.subpolicyid?payDto.subpolicyid:@"" forKey:kHttpResponseShoppingCartPaySubpolicyid];
            break;
        }
        case PayModeUPPay2_0:
        {
            [postDic setObject:payDto.subpolicyid?payDto.subpolicyid:@"" forKey:kHttpResponseShoppingCartPaySubpolicyid];
            break;
        }
        case PayModeCyberPay:
        {
            [postDic setObject:payDto.subpolicyid?payDto.subpolicyid:@"" forKey:kHttpResponseShoppingCartPaySubpolicyid];
            break;
        }
        default:
            break;
    }
    [postDic setObject:@"1" forKey:@"flag"];
    
    DLog(@"encrypted dic is %@", postDic);
    NSString *encryptMT = @"";
    
    encryptMT = [encryptMT queryStringNoEncodeFromDictionary:postDic];
    
    NSString *encodeStr = [PasswdUtil encryptString:encryptMT
                                             forKey:self.user.userId
                                               salt:kSubmitOrderParamEncodeSalt]; // encodeStr ＝ nil ？
    if (encodeStr == nil) {
        encodeStr = @"";
    }
    
    [postDataDic setObject:encodeStr forKey:@"encryptMT"];
    
    [postDataDic setObject:[self collectSystemInfo] forKey:@"paymentChannel"];
    

    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttps,[@"SNMobilePaySubmit" passport]];
    
    
    HTTPMSG_RELEASE_SAFELY(paySubmitHttpMsg);
    
    paySubmitHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                  requestUrl:url
                                                 postDataDic:postDataDic
                                                     cmdCode:CC_PaySubmit];
    
    [self.httpMsgCtrl sendHttpMsg:paySubmitHttpMsg];
}

- (void)beginGetLastShipInfoRequest
{
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] initWithCapacity:3];
	[postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
	[postDataDic setObject:@"10051" forKey:@"catalogId"];
    [postDataDic setObject:@"SNEasilyBuyAddressView" forKey:@"fromStep"];
    [postDataDic setObject:@"1" forKey:@"needLastShipInfo"];
    
	NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttp,
                     [@"SNMobileLastShipInfoView" passport]];
    
    HTTPMSG_RELEASE_SAFELY(lastShipInfoHttpMsg);
    
	lastShipInfoHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                     requestUrl:url
                                                    postDataDic:postDataDic
                                                        cmdCode:CC_LastShipInfo];
    lastShipInfoHttpMsg.addedCookies = nil;
    lastShipInfoHttpMsg.requestMethod = RequestMethodGet;
    [self.httpMsgCtrl sendHttpMsg:lastShipInfoHttpMsg];
	
	TT_RELEASE_SAFELY(postDataDic);
}

- (void)beginConfirmDeliveryAddressRequest:(ShipMode)shipMode addressInfo:(AddressInfoDTO *)addressInfo storeInfo:(StoreInfoDto *)storeInfo
{
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] initWithCapacity:3];
	[postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
	[postDataDic setObject:@"10051" forKey:@"catalogId"];
    //	[postDataDic setObject:@"2" forKey:@"channel"];
    if (shipMode == ShipModeSuningSend)//配送
    {
        self.addressInfoDto = addressInfo;
        [postDataDic setObject:addressInfo.addressNo?addressInfo.addressNo:@"" forKey:@"addressId"];
        [postDataDic setObject:@"-1" forKey:@"shipMode"];
        [postDataDic setObject:@"keep" forKey:@"selectWay"];
        [postDataDic setObject:addressInfo.tel?addressInfo.tel:@"" forKey:@"cellPhone"];
        [postDataDic setObject:addressInfo.tel?addressInfo.tel:@"" forKey:@"tellPhone"];
        [postDataDic setObject:addressInfo.recipient?addressInfo.recipient:@"" forKey:@"receiveName"];
        [postDataDic setObject:addressInfo.city?addressInfo.city:@"" forKey:@"cityId"];
        [postDataDic setObject:addressInfo.district?addressInfo.district:@"" forKey:@"districtId"];
        [postDataDic setObject:addressInfo.town?addressInfo.town:@"" forKey:@"townId"];
        [postDataDic setObject:addressInfo.addressContent?addressInfo.addressContent:@"" forKey:@"detail"];
    }
    else if (shipMode == ShipModeSelfTake)   //自提
    {
        self.storeInfoDto = storeInfo;
        [postDataDic setObject:@"-2" forKey:@"shipMode"];
        [postDataDic setObject:storeInfo.storeCode?storeInfo.storeCode:@"" forKey:@"siteId"];//7612
        [postDataDic setObject:storeInfo.storeAddress?storeInfo.storeAddress:@"" forKey:@"detail"];//自提点名称(编码) 南京市珠江路
        [postDataDic setObject:storeInfo.receiptPhone?storeInfo.receiptPhone:@"" forKey:@"telePhone"];//固定电话
        [postDataDic setObject:storeInfo.districtId?storeInfo.districtId:@"" forKey:@"districtId"];//自提区id 玄武区id
        [postDataDic setObject:storeInfo.cityId?storeInfo.cityId:@"" forKey:@"cityId"];
        [postDataDic setObject:storeInfo.receiptPhone?storeInfo.receiptPhone:@"" forKey:@"cellPhone"];//手机号码
        [postDataDic setObject:storeInfo.receiptName?storeInfo.receiptName:@"" forKey:@"receiveName"];
        
    }
    
	NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttp,
                     @"SNMTConfirmDeliveryAddress"];
    
    HTTPMSG_RELEASE_SAFELY(confirmDeliveryAddressHttpMsg);
    
	confirmDeliveryAddressHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                               requestUrl:url
                                                              postDataDic:postDataDic
                                                                  cmdCode:CC_ConfirmDelivery];
    
    [self.httpMsgCtrl sendHttpMsg:confirmDeliveryAddressHttpMsg];
}

- (void)beginGetPaymentChooseInfoRequest
{
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] initWithCapacity:3];
	[postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
	[postDataDic setObject:@"10051" forKey:@"catalogId"];
    
	NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttp,
                     @"SNMobilePaymentChoose"];
    
    HTTPMSG_RELEASE_SAFELY(paymentChooseHttpMsg);
    
	paymentChooseHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                      requestUrl:url
                                                     postDataDic:postDataDic
                                                         cmdCode:CC_PaymentChoose];
    paymentChooseHttpMsg.requestMethod =RequestMethodGet;

    [self.httpMsgCtrl sendHttpMsg:paymentChooseHttpMsg];
}

- (void)beginSavePayMethodRequest:(NSString *)payMethod subPayMethod:(NSString *)subPayMethod
{
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] initWithCapacity:3];
	[postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
	[postDataDic setObject:@"10051" forKey:@"catalogId"];
	[postDataDic setObject:IsStrEmpty(payMethod)?@"":payMethod forKey:@"payMethod"];
    [postDataDic setObject:IsStrEmpty(subPayMethod)?@"":subPayMethod forKey:@"subPayMethod"];
    
	NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttp,
                     @"SNMobileSavePayMethod" ];
    
    HTTPMSG_RELEASE_SAFELY(savePayMethoHttpMsg);
    
	savePayMethoHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                     requestUrl:url
                                                    postDataDic:postDataDic
                                                        cmdCode:CC_SavePayMethod];
    
    [self.httpMsgCtrl sendHttpMsg:savePayMethoHttpMsg];
}

- (void)beginSaveCardAndCouponRequest:(NSString *)allianceFlag ecoupon:(NSArray *)couponList codeString:(NSString *)codeString
{
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] initWithCapacity:3];
	[postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
	[postDataDic setObject:@"10051" forKey:@"catalogId"];
    //couponList不为空为使用易购券
    if (couponList && [couponList count] > 0) {
        
        int vipCard = 1;
        int cashCard = 1;
        int gcoupon = 1;
        
        [postDataDic setObject:codeString?codeString:@"" forKey:@"validateCode"];
        for (GiftCouponDTO *couponDTO in couponList){
            if (couponDTO.couponType == CouponTypePoint) {//电子券有值并且选择了电子卷
                [postDataDic setObject:couponDTO.balance?couponDTO.balance:@"" forKey:@"ecoupon"];
            }else if(couponDTO.couponType == CouponTypeVIPCard){    //贵宾券
                NSString *vipCardKey = [NSString stringWithFormat:@"vipCard_%d",vipCard];
                NSString *vipCardAmountKey = [NSString stringWithFormat:@"vipCardAmount_%d",vipCard];
                [postDataDic setObject:couponDTO.giftCouponId forKey:vipCardKey];
                [postDataDic setObject:couponDTO.balance forKey:vipCardAmountKey];
                vipCard ++;
            }else if (couponDTO.couponType == CouponTypeCashCard){ //礼品卡
                //礼品卡id ==== name_id
                NSString *cashCardKey = [NSString stringWithFormat:@"cashCard_%d",cashCard];
                NSString *cashCardAmountKey = [NSString stringWithFormat:@"cashCardAmount_%d",cashCard];
                [postDataDic setObject:[NSString stringWithFormat:@"%@_%@",couponDTO.name,couponDTO.giftCouponId] forKey:cashCardKey];
                [postDataDic setObject:couponDTO.balance forKey:cashCardAmountKey];
                cashCard ++;
            }else if (couponDTO.couponType == CouponTypeVoucherCode){ //礼品卡
                
            }else{ //心意券等
                NSString *gcouponKey = [NSString stringWithFormat:@"gcoupon_%d",gcoupon];
                NSString *gcouponAmountKey = [NSString stringWithFormat:@"gcouponAmount_%d",gcoupon];
                [postDataDic setObject:couponDTO.giftCouponId forKey:gcouponKey];
                [postDataDic setObject:couponDTO.balance forKey:gcouponAmountKey];
                gcoupon ++;
            }
        }
    }
    [postDataDic setObject:@"1"   forKey:@"useCoupon"];
//    [postDataDic setObject:IsStrEmpty(allianceFlag)?@"":allianceFlag forKey:@"allianceFlag"];
    
	NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttp,
                     @"SNMobileSaveCardAndCoupons" ];
    
    HTTPMSG_RELEASE_SAFELY(saveCardAndCouponHttpMsg);
    
	saveCardAndCouponHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                          requestUrl:url
                                                         postDataDic:postDataDic
                                                             cmdCode:CC_SaveCardAndCoupon];
    
    [self.httpMsgCtrl sendHttpMsg:saveCardAndCouponHttpMsg];
}

- (void)beginGetCloudDiamond:(NSString *)isCloudDiamondUsed
{
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] initWithCapacity:1];
	[postDataDic setObject:isCloudDiamondUsed forKey:@"isCloudDiamondUsed"];
    [postDataDic setObject:@"2" forKey:@"channel"];
	
	NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttp,
                     @"SNMobileCloudDiamond" ];
    
    HTTPMSG_RELEASE_SAFELY(getAndUseCloudDiamondMsg);
    
	getAndUseCloudDiamondMsg = [[HttpMessage alloc] initWithDelegate:self
                                                     requestUrl:url
                                                    postDataDic:postDataDic
                                                        cmdCode:CC_CloudDiamond];
    
    [self.httpMsgCtrl sendHttpMsg:getAndUseCloudDiamondMsg];
}

- (void)beginGetDelAndInsTime
{
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] initWithCapacity:2];
    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
    [postDataDic setObject:kHttpRequestHomeCatalogIdValue forKey:kHttpRequestHomeCatalogIdKey];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttp,
                     @"SNMobileDelAndInsTimeCmd" ];
    
    HTTPMSG_RELEASE_SAFELY(getDelAndInsTimeMsg);
    
    getDelAndInsTimeMsg = [[HttpMessage alloc] initWithDelegate:self
                                                     requestUrl:url
                                                    postDataDic:postDataDic
                                                        cmdCode:CC_DelAndInsend];
    getDelAndInsTimeMsg.requestMethod =RequestMethodGet;
    [self.httpMsgCtrl sendHttpMsg:getDelAndInsTimeMsg];
}

- (void)beginGetInstallDateWithdeliverTime:(NSString *)deliverTime dayTime:(NSString *)dayTime orderItemIds:(NSString *)orderItemIds
{
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] initWithCapacity:5];
    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
    [postDataDic setObject:kHttpRequestHomeCatalogIdValue forKey:kHttpRequestHomeCatalogIdKey];
    [postDataDic setObject:deliverTime forKey:@"deliverTime"];
    [postDataDic setObject:dayTime forKey:@"dayTime"];
    [postDataDic setObject:orderItemIds forKey:@"orderItemIds"];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttp,
                     @"SNMobileGetInstallDateCmd" ];
    
    HTTPMSG_RELEASE_SAFELY(getInstallTimeMsg);
    
    getInstallTimeMsg = [[HttpMessage alloc] initWithDelegate:self
                                                     requestUrl:url
                                                    postDataDic:postDataDic
                                                        cmdCode:CC_InstallDate];
    getInstallTimeMsg.requestMethod =RequestMethodGet;

    [self.httpMsgCtrl sendHttpMsg:getInstallTimeMsg];
}

#pragma mark -
#pragma mark final

- (void)submitOrderOk:(BOOL)isSuccess payDto:(payFlowDTO *)dto
{
    if (_delegate && [_delegate respondsToSelector:@selector(submitOrderCompletionWithResult:
                                                             errorMsg:
                                                             payDTO:)]) {
        [_delegate submitOrderCompletionWithResult:isSuccess
                                          errorMsg:self.errorMsg
                                            payDTO:dto];
    }
}

- (void)getCloudDiamondOk:(BOOL)isSuccess cloudDiamond:(NSString *)cloudDiamond cloudDiamondPay:(NSString *)cloudDiamondPay
{
    if (_delegate && [_delegate respondsToSelector:@selector(getCloudDiamondCompletionWithResult:service:cloudDiamond:cloudDiamondPay:errorMsg:)]) {
        [_delegate getCloudDiamondCompletionWithResult:isSuccess
                                               service:self
                                          cloudDiamond:cloudDiamond
                                       cloudDiamondPay:cloudDiamondPay
                                              errorMsg:self.errorMsg];
    }
}

- (void)paySubmitOk:(BOOL)isSuccess url:(NSURL *)url xml:(NSString *)xml sdkstring:(NSString *)sdkstring
{
    if (_delegate && [_delegate respondsToSelector:@selector(paySubmitCompletionWithResult:
                                                             errorMsg:
                                                             punchoutUrl:
                                                             punchoutForm:
                                                             sdkstring:)]) {
        [_delegate paySubmitCompletionWithResult:isSuccess
                                        errorMsg:self.errorMsg
                                     punchoutUrl:url
                                    punchoutForm:xml
                                       sdkstring:sdkstring
         ];
    }
}

- (void)getLastShipInfoOk:(BOOL)isSuccess
             lastShipMode:(ShipMode)mode
             lastPickInfo:(StoreInfoDto *)pickInfo
             lastShipInfo:(AddressInfoDTO *)shipInfo
{
    if (_delegate &&
        [_delegate respondsToSelector:@selector(getLastShipInfoCompletionWithResult:
                                                errorMsg:
                                                lastShipMode:
                                                lastPickUpInfo:
                                                lastShipInfo:)])
    {
        [_delegate getLastShipInfoCompletionWithResult:isSuccess
                                              errorMsg:self.errorMsg
                                          lastShipMode:mode
                                        lastPickUpInfo:pickInfo
                                          lastShipInfo:shipInfo];
    }
}

- (void)saveDeliveryAndAddressOk:(BOOL)isSuccess payDto:(payFlowDTO *)dto errorCode:(NSString *)errorCode;
{
    if (_delegate && [_delegate respondsToSelector:@selector(saveDeliveryAndAddressCompletionWithResult:service:payDTO:errorCode:)]) {
        [_delegate saveDeliveryAndAddressCompletionWithResult:isSuccess
                                                     service:self
                                                       payDTO:dto
                                                    errorCode:errorCode];
    }
}

- (void)paymentChooseOk:(BOOL)isSuccess payDto:(payFlowDTO *)dto
{
    if (_delegate && [_delegate respondsToSelector:@selector(paymentChooseCompletionWithResult:errorMsg:payDTO:)]) {
        [_delegate paymentChooseCompletionWithResult:isSuccess
                                            errorMsg:self.errorMsg
                                              payDTO:dto];
    }
}

- (void)savePayMethodOk:(BOOL)isSuccess payDto:(payFlowDTO *)dto
{
    if (_delegate && [_delegate respondsToSelector:@selector(savePayMethodCompletionWithResult:errorMsg:payDTO:)]) {
        [_delegate savePayMethodCompletionWithResult:isSuccess
                                            errorMsg:self.errorMsg
                                              payDTO:dto];

        
    }
}

- (void)saveCardAndCouponOk:(BOOL)isSuccess payDto:(payFlowDTO *)dto
{
    if (_delegate && [_delegate respondsToSelector:@selector(saveCardAndCouponCompletionWithResult:errorMsg:payDTO:)]) {
        [_delegate saveCardAndCouponCompletionWithResult:isSuccess
                                            errorMsg:self.errorMsg
                                              payDTO:dto];
    }
}

- (void)getDelAndTiemOk:(BOOL)isSuccess insendDto:(InsendTimeDTO *)dto
{
    if (_delegate && [_delegate respondsToSelector:@selector(getDelAndTimeCompletionWithResult:insendTimeDto:errorMsg:)]) {
        [_delegate getDelAndTimeCompletionWithResult:isSuccess
                                       insendTimeDto:dto
                                            errorMsg:self.errorMsg];
    }
}

- (void)getInstallDateOk:(BOOL)isSuccess installDateArr:(NSArray *)installArr
{
    if (_delegate && [_delegate respondsToSelector:@selector(getInstallDateCompletionWithResult:installDateArr:errorMsg:)]) {
        [_delegate getInstallDateCompletionWithResult:isSuccess
                                       installDateArr:installArr
                                             errorMsg:self.errorMsg];
    }
}

#pragma mark -
#pragma mark http message delegate

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    switch (receiveMsg.cmdCode) {
        case CC_SubmitOrder:
        {
            [self submitOrderOk:NO payDto:nil];
            break;
        }
        case CC_PaySubmit:
        {
            [self paySubmitOk:NO url:nil xml:nil sdkstring:nil];
            break;
        }
        case CC_LastShipInfo:
        {
            if (KPerformance)
            {
                PerformanceStatisticsHttp* temp = [[PerformanceStatisticsHttp alloc] init];
                temp.startTime = [NSDate date];
                temp.functionId = @"6";
                temp.interfaceId = @"601";
                temp.errorType = @"02";
                temp.errorCode = [NSString stringWithFormat:@"%@",receiveMsg.errorCode];
                [[PerformanceStatistics sharePerformanceStatistics]sendCustomNetData:temp];
            }
            [self getLastShipInfoOk:NO
                       lastShipMode:0
                       lastPickInfo:nil
                       lastShipInfo:nil];
            break;
        }
        case CC_ConfirmDelivery:{
            if (KPerformance)
            {
                PerformanceStatisticsHttp* temp = [[PerformanceStatisticsHttp alloc] init];
                temp.startTime = [NSDate date];
                temp.functionId = @"6";
                temp.interfaceId = @"603";
                temp.errorType = @"02";
                temp.errorCode = [NSString stringWithFormat:@"%@",receiveMsg.errorCode];
                [[PerformanceStatistics sharePerformanceStatistics]sendCustomNetData:temp];
            }
            self.canUseEleInvoice = NO;
            [self saveDeliveryAndAddressOk:NO payDto:nil errorCode:nil];
        }
            break;
        case CC_SavePayMethod:{
            [self savePayMethodOk:NO payDto:nil];
        }
            break;
        case CC_PaymentChoose:{
            [self paymentChooseOk:NO payDto:nil];
        }
            break;
        case CC_SaveCardAndCoupon:{
            [self savePayMethodOk:NO payDto:nil];
        }
            break;
        case CC_CloudDiamond:{
            if (KPerformance)
            {
                PerformanceStatisticsHttp* temp = [[PerformanceStatisticsHttp alloc] init];
                temp.startTime = [NSDate date];
                temp.functionId = @"6";
                temp.interfaceId = @"602";
                temp.errorType = @"02";
                temp.errorCode = [NSString stringWithFormat:@"%@",receiveMsg.errorCode];
                [[PerformanceStatistics sharePerformanceStatistics]sendCustomNetData:temp];
            }
            [self getCloudDiamondOk:NO cloudDiamond:nil cloudDiamondPay:nil];
        }
        case CC_DelAndInsend:{
            
            [self getDelAndTiemOk:NO insendDto:nil];
        }
            break;
        case CC_InstallDate:
        {
            [self getInstallDateOk:NO installDateArr:nil];
        }
            break;
        default:
            break;
    }
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    NSDictionary *items = receiveMsg.jasonItems;
    NSString *errorCode = receiveMsg.errorCode;
    
    if (!items) {
        self.errorMsg = kHttpResponseJSONValueFailError;
    }
    
    switch (receiveMsg.cmdCode) {
        case CC_SubmitOrder:    //提交订单
        {
            if (!items) {
                [self submitOrderOk:NO payDto:nil];
            }else if([errorCode isEqualToString:@""]){
                [self parseSubmitOrderInfo:items praseSubmitInfo:submitInfo];
                if([[items objectForKey:@"validCipher"] isEqualToString:@"0"]){
                    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
                    NSString *name =@"cipher";
                    [defaults setObject:@"" forKey:name];
                }

            }else
            {
                NSString *errorMsg = [items objectForKey:@"errorMessage"];//L(formatErrorCode);
                if ([errorMsg isEqualToString:@"productLevelVoucherIsNotEnough"]) {
                    errorMsg=L(@"SorryOrderPreferenceOutTime");
                }
                if (errorMsg.length == 0 || [errorMsg hasPrefix:@"CMN"])
                {
                    self.errorMsg = L(@"ORDER_SUBMIT_DEFAULT_ERROR");
                }
                else
                {
                    self.errorMsg = errorMsg;
                }
                
                NSString *errorCode = EncodeStringFromDic(items, @"errorCode");
                
                if ([errorCode isEqualToString:@"ORDER_CHECK_ERR"])
                {
                    //去购物车同步接口获取错误信息
                    [self.shopCartService requestSyncShopCart:self.shoppingCartBoard.logic.shopCartList
                                                      isMerge:NO];
                }
                else
                {
                    [self submitOrderOk:NO payDto:nil];
                }
                
            }
            break;
        }
        case CC_PaySubmit:
        {
            if (!items) {
                [self paySubmitOk:NO url:nil xml:nil sdkstring:nil];
            }
            else if (errorCode && [errorCode isEqualToString:@""])
            {
                NSString *isSuccess = EncodeStringFromDic(items, @"isSuccess");
                if ([isSuccess isEqualToString:@"1"])
                {
                    NSString *urlString = EncodeStringFromDic(items, @"punchoutURL");
                    
                    NSString *sdkstring =EncodeStringFromDic(items, @"sdkString");

                    NSString *xml = EncodeStringFromDic(items, @"punchoutForm");
                    //替换引号
                    xml = [xml stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
                    //替换斜杠
                    xml = [xml stringByReplacingOccurrencesOfString:@"&#92;" withString:@"\\"];
                    DLog(@"replace xml:%@",xml);
                    
                    [self paySubmitOk:YES url:[NSURL URLWithString:urlString] xml:xml sdkstring:sdkstring];
                    
                }
                else
                {
                    NSString *errorMsg = [items objectForKey:@"errorDesc"];
                    
                    self.errorMsg = IsStrEmpty(errorMsg) ? L(@"Order_Pay_Fail") : errorMsg;
                    [self paySubmitOk:NO url:nil xml:nil sdkstring:nil];
                }
                
            }
            else if ([errorCode isEqualToString:@"PasswordError"])
            {
                NSString *errorNum  = [items objectForKey:@"errorNum"];
                NSString *errorInfo = nil;
                if ([errorNum intValue] < 3) {
                    errorInfo =
                    [NSString stringWithFormat:L(@"Efubao_Password_Error%d"), 3-[errorNum intValue]];
                }else{
                    errorInfo = L(@"Password_Error_Three_Times_Error");
                }
                self.errorMsg = errorInfo;
                [self paySubmitOk:NO url:nil xml:nil sdkstring:nil];
            }
            else if ([errorCode isEqualToString:@"ERR_SIMPLEGROUP_ACT_STATU"])
            {
                self.errorMsg = L(@"GroupBuyActivityOutTime");
                [self paySubmitOk:NO url:nil xml:nil sdkstring:nil];
            }
            else if ([errorCode isEqualToString:@"ERR_SIMPLEGROUP_TOTAL_AMT"])
            {
                self.errorMsg = L(@"GroupBuyMarginLack");
                [self paySubmitOk:NO url:nil xml:nil sdkstring:nil];
            }
            else if ([errorCode isEqualToString:@"ERR_SIMPLEGROUP_USER_AMT"])
            {
                self.errorMsg = L(@"BeyondEveryoneQuota");
                [self paySubmitOk:NO url:nil xml:nil sdkstring:nil];
            }
            else if ([errorCode isEqualToString:@"checkgrpException"])
            {
                self.errorMsg = L(@"GroupBuyActivityCheckException");
                [self paySubmitOk:NO url:nil xml:nil sdkstring:nil];
            }else if ([errorCode isEqualToString:@"productLevelVoucherIsNotEnough"]){
                self.errorMsg = L(@"SorryOrderPreferenceOutTime2");
                [self paySubmitOk:NO url:nil xml:nil sdkstring:nil];
            }else if ([errorCode isEqualToString:@"CHECK_ORDER_SHIPPING_CHARGE_ERROR"]){
                self.errorMsg = L(@"SorryOrderNoFreightOut");
                [self paySubmitOk:NO url:nil xml:nil sdkstring:nil];
            }
            else if ([errorCode isEqualToString:@"GROUP_OUT_SIMPLE_LIMIT"]){
                self.errorMsg = L(@"OrderForBigPreferenceNumberOverQuota");
                [self paySubmitOk:NO url:nil xml:nil sdkstring:nil];
            }
            else if ([errorCode isEqualToString:@"GROUP_TATAL_AMOUT_SHORT"]){
                self.errorMsg = L(@"BigPreferenceGoodMargineLack");
                [self paySubmitOk:NO url:nil xml:nil sdkstring:nil];
            }
            else if ([errorCode isEqualToString:@"GROUP_ACT_TIME_OUT"]){
                self.errorMsg = L(@"BigPreferenceJoinedActivityEnded");
                [self paySubmitOk:NO url:nil xml:nil sdkstring:nil];
            }
            else if ([errorCode isEqualToString:@"GROUP_PARAM_ERROR"]){
                self.errorMsg = L(@"ORDER_PAY_CHECK_ORDER_STATUS_ERROR");
                [self paySubmitOk:NO url:nil xml:nil sdkstring:nil];
            }
            else if ([errorCode isEqualToString:@"CHECK_RUSH_PURCH_TIMEOUT"]) {
                self.errorMsg = L(@"OrderNotPayedInTimeLoseSnapUpChance");
                [self paySubmitOk:NO url:nil xml:nil sdkstring:nil];
            }
            else if ([errorCode isEqualToString:@"CHECK_CLOUDDIAMOND_ERROR"]) {
                self.errorMsg = L(@"CloudDiamondUsedToEarn");
                [self paySubmitOk:NO url:nil xml:nil sdkstring:nil];
            }
            else if ([errorCode isEqualToString:@"CHECK_VOUCHER_ERROR"]) {
                self.errorMsg = L(@"PreferenceInfoInvalidReselect");
                [self paySubmitOk:NO url:nil xml:nil sdkstring:nil];
            }
            else if ([errorCode isEqualToString:@"CHECK_RUSH_PURCH_ERROR"]) {
                self.errorMsg = L(@"OrderNotPayedInTimeLoseSnapUpChance");
                [self paySubmitOk:NO url:nil xml:nil sdkstring:nil];
            }
            else
            {
//                NSString *formatErrorCode = [NSString stringWithFormat:@"ORDER_PAY_%@",errorCode];
//                NSString *errorMsg = L(formatErrorCode);
                NSString *errorMsg = [items objectForKey:@"errorDesc"];
                self.errorMsg = IsStrEmpty(errorMsg) ? L(@"Order_Pay_Fail") : errorMsg;
                [self paySubmitOk:NO url:nil xml:nil sdkstring:nil];
            }
            break;
        }
        case CC_LastShipInfo:
        {
            if (!items) {
                [self getLastShipInfoOk:NO lastShipMode:0 lastPickInfo:nil lastShipInfo:nil];
            }else{
                [self parseLastShipInfo:items];
            }
            break;
        }
        case CC_ConfirmDelivery:{
            if (!items) {
                self.canUseEleInvoice = NO;
                [self saveDeliveryAndAddressOk:NO payDto:nil errorCode:errorCode];
            }else if([errorCode isEqualToString:@""]){
//                [self saveDeliveryAndAddressOk:YES payDto:nil];
                [self saveDeliveryAndAddress:items];
            }
            else if ([errorCode isEqualToString:@"priceChange"])
            {
                self.canUseEleInvoice = NO;
                [self saveDeliveryAndAddressOk:NO payDto:nil errorCode:errorCode];
            }
            else if ([errorCode isEqualToString:@"updateAddressFail"])
            {
                self.canUseEleInvoice = NO;
                self.errorMsg = [items objectForKey:@"errorMessage"];
                [self saveDeliveryAndAddressOk:NO payDto:nil errorCode:errorCode];
            }
            else if ([errorCode isEqualToString:@"cannotTake"])
            {
                self.canUseEleInvoice = NO;
                self.errorMsg = [items objectForKey:@"errorMessage"];
                [self saveDeliveryAndAddressOk:NO payDto:nil errorCode:errorCode];
            }
            else if ([errorCode isEqualToString:@"wrongParams"])
            {
                self.canUseEleInvoice = NO;
                self.errorMsg = [items objectForKey:@"errorMessage"];
                [self saveDeliveryAndAddressOk:NO payDto:nil errorCode:errorCode];
            }
            else if ([errorCode isEqualToString:@"cantsale"])
            {
                self.canUseEleInvoice = NO;
                self.errorMsg = [items objectForKey:@"errorMessage"];
                [self saveDeliveryAndAddressOk:NO payDto:nil errorCode:errorCode];
            }
            else if ([errorCode isEqualToString:@"hasErrCode"])
            {
                self.canUseEleInvoice = NO;
                self.errorMsg = [items objectForKey:@"errorMessage"];
                [self saveDeliveryAndAddressOk:NO payDto:nil errorCode:errorCode];
            }
            else
            {
                self.errorMsg = [items objectForKey:@"errorMessage"];
                self.canUseEleInvoice = NO;
                [self saveDeliveryAndAddressOk:NO payDto:nil errorCode:nil];
            }
        }
            break;
        case CC_SavePayMethod:{
            if (!items) {
                [self savePayMethodOk:NO payDto:nil];
            }else if([[items objectForKey:@"isSuccess"] isEqualToString:@"1"]){
                [self savePayMethodOk:YES payDto:nil];
            }else
            {
                self.errorMsg = [items objectForKey:@"errorDesc"];
                [self savePayMethodOk:NO payDto:nil];
            }
        }
            break;
        case CC_PaymentChoose:{
            if (!items) {
                [self paymentChooseOk:NO payDto:nil];
            }else if([errorCode isEqualToString:@""]){
                [self parseSubmitOrderInfo:items praseSubmitInfo:paymentChoose];
            }else
            {
                NSString *errorMsg = [items objectForKey:@"errorMessage"];//L(formatErrorCode);
                if (errorMsg.length == 0 || [errorMsg hasPrefix:@"CMN"])
                {
                    self.errorMsg = L(@"ORDER_SUBMIT_DEFAULT_ERROR");
                }
                else
                {
                    self.errorMsg = errorMsg;
                }
                [self paymentChooseOk:NO payDto:nil];
            }
        }
            break;
        case CC_SaveCardAndCoupon:{
            if (!items) {
                [self savePayMethodOk:NO payDto:nil];
            }else if([errorCode isEqualToString:@""]){
                [self saveCardAndCoupon:items];
            }else
            {
                NSString *errorMsg = [items objectForKey:@"errorCode"];//L(formatErrorCode);
                if (errorMsg.length == 0 || [errorMsg hasPrefix:@"CMN"])
                {
                    self.errorMsg = L(@"ORDER_SUBMIT_DEFAULT_ERROR");
                }
                else
                {
                    self.errorMsg = errorMsg;
                }
                [self saveCardAndCouponOk:NO payDto:nil];
            }
        }
            break;
        case CC_CloudDiamond:{
            if (!items) {
                [self getCloudDiamondOk:NO cloudDiamond:nil cloudDiamondPay:nil];
            }else
            {
                NSString *isSuccuss = EncodeStringFromDic(items, @"isSuccess");
                if ([isSuccuss isEqualToString:@"1"]) {
                    NSString *cloudDiamond = EncodeStringFromDic(items, @"cloudDiamQty");
                    NSString *cloudDiamondPay = EncodeStringFromDic(items, @"cloudDiamAmt");
                    self.productAllPrice = EncodeNumberFromDic(items, @"totalPrice");
                    self.userPayAllPrice = EncodeNumberFromDic(items, @"shouldPay");
                    self.totalDiscount = EncodeNumberFromDic(items, @"totalDiscount");
                    self.totalShipPrice = EncodeNumberFromDic(items, @"totalShipPrice");
                    [self getCloudDiamondOk:YES cloudDiamond:cloudDiamond cloudDiamondPay:cloudDiamondPay];
                }else
                {
                    [self getCloudDiamondOk:NO cloudDiamond:nil cloudDiamondPay:nil];
                }
            }
        }
            break;
        case CC_DelAndInsend:{
            if (!items) {
                [self getDelAndTiemOk:NO insendDto:nil];
            }else
            {
                NSString *isSuccuss = EncodeStringFromDic(items, @"isSuccess");
                if ([isSuccuss isEqualToString:@"1"]) {
                    InsendTimeDTO *dto = [[InsendTimeDTO alloc] init];
                    [dto encodeFromDictionary:items];
                    [self getDelAndTiemOk:YES insendDto:dto];
                }
                else
                {
                    [self getDelAndTiemOk:NO insendDto:nil];
                }
            }
        }
            break;
        case CC_InstallDate:
        {
            if (!items) {
                [self getInstallDateOk:NO installDateArr:nil];
            }else
            {
                NSString *isSuccuss = EncodeStringFromDic(items, @"isSuccess");
                if ([isSuccuss isEqualToString:@"1"]) {
                    NSMutableArray *installArr = [[NSMutableArray alloc] init];
                    NSArray *dateList = EncodeArrayFromDic(items, @"installItemVo");
                    if (dateList !=nil && [dateList count]>0) {
                        
                        for(NSDictionary *dic in dateList){
                            
                            InstallDateDTO *dto = [[InstallDateDTO alloc] init];
                            
                            [dto encodeFromDictionary:dic];
                            
                            [installArr addObject:dto];
                        }
                    }
                    [self getInstallDateOk:YES installDateArr:installArr];
                }
                else
                {
                    [self getInstallDateOk:NO installDateArr:nil];
                }
            }
        }
            break;
        default:
            break;
    }
}

- (void)saveDeliveryAndAddress:(NSDictionary *)items
{

    //购物车列表
    NSMutableArray *resultList = [NSMutableArray array];

    //苏宁自营
    NSMutableArray *suningItemList = (NSMutableArray *)EncodeArrayFromDicUsingParseBlock(items, @"itemList", ^id(NSDictionary *innerDic) {
        
        ShopCartV2DTO *dto = [[ShopCartV2DTO alloc] init];
        [dto encodeFromDictionary:innerDic];
        return dto;
    });
    if (suningItemList.count)
    {
        ShopCartShopDTO *suningShop = [[ShopCartShopDTO alloc] init];
        suningShop.shopName = L(@"MyEBuy_SuningSelf");
        suningShop.shipPrice = EncodeNumberFromDic(items, @"snShipCharge");
        suningShop.itemList = suningItemList;
        [resultList addObject:suningShop];
    }

    //C店
    NSArray *cShopList = EncodeArrayFromDicUsingParseBlock(items, @"cShopList", ^id(NSDictionary *innerDic) {
        
        ShopCartShopDTO *dto = [[ShopCartShopDTO alloc] init];
        [dto encodeFromDictionary:innerDic];
        return dto;
    });
    if ([cShopList count])
    {
        [resultList addObjectsFromArray:cShopList];
    }

    self.shopCartItemList = resultList;

    self.productAllPrice = EncodeNumberFromDic(items, @"productAllPrice");
    self.userPayAllPrice = EncodeNumberFromDic(items, @"userPayAllPrice");
    self.sunpgkPrice = EncodeNumberFromDic(items, @"sunpgkPrice");
    self.totalShipPrice = EncodeNumberFromDic(items, @"totalShipPrice");
    self.totalDiscount = EncodeNumberFromDic(items, @"totalDiscount");
    
    NSString *isCanUseEleInvoice = EncodeStringFromDic(items, @"canUseEleInvoice");
    BOOL canUseEleInvoice = [isCanUseEleInvoice isEqualToString:@"1"]?YES:NO;
    self.canUseEleInvoice = canUseEleInvoice;
    
    NSString *isEleInvoiceIsDefault = EncodeStringFromDic(items, @"eleInvoiceIsDefault");
    self.eleInvoiceIsDefault = [isEleInvoiceIsDefault isEqualToString:@"1"]?YES:NO;
    
    [self saveDeliveryAndAddressOk:YES payDto:nil errorCode:nil];
}

- (void)saveCardAndCoupon:(NSDictionary *)items
{
    self.productAllPrice = EncodeNumberFromDic(items, @"productPrice");
    self.userPayAllPrice = EncodeNumberFromDic(items, @"shouldPay");
    self.totalDiscount = EncodeNumberFromDic(items, @"orderDiscount");
    self.totalShipPrice = EncodeNumberFromDic(items, @"portage");
    [self saveCardAndCouponOk:YES payDto:nil];
}

#pragma mark -
#pragma mark parse data

- (void)parseSubmitOrderInfo:(NSDictionary *)items praseSubmitInfo:(ParseSubmitInfoType)type
{
    Background_Begin
    NSString *orderId = [items objectForKey:@"orderId"];
    
    //收集订单数据
    if (NotNilAndNull(orderId) && ![orderId isEqualToString:@""]) {
        [[SuningMainClick sharedInstance] getOrderAndSave:orderId];
    }
    
    NSString *shouldPay = [items objectForKey:@"shouldPay"];
//    NSString *eprice = NotNilAndNull(shouldPay)?shouldPay:@"";
    
    float productPrice = [[items objectForKey:@"productPrice"] floatValue];//B2C 回过来的优惠前的价格
    float sunpackPrice = [[items objectForKey:@"sunpackPrice"] floatValue];//B2C 回过来的阳光包价格
    float portage = [[items objectForKey:@"portage"] floatValue];//B2C 回过来的运费
    
    NSString *portageStr = nil;
    
    if (portage == 0) {
        portageStr = L(@"NoFreight");
    }else{
        portageStr = [NSString stringWithFormat:L(@"FreightIs"),portage];
    }
    
    float minusPrice = [[items objectForKey:@"orderDiscount"] floatValue];//优惠的价格
    
    float totalPrice = productPrice + sunpackPrice +  portage - minusPrice;
    
    NSString *prepayStr = [[NSNumber numberWithFloat:totalPrice] stringValue];
    
    payFlowDTO *orderDTO = [[payFlowDTO alloc]  init];
    
    [orderDTO encodeFromDictionary:items];
    
    orderDTO.orderId = [items objectForKey:@"orderId"];
    orderDTO.prepay = NotNilAndNull(shouldPay)?shouldPay:prepayStr;
    orderDTO.eppPayPwd = @"";
    orderDTO.isPrepay = @"true"; // default yifuabo, other false
    orderDTO.langId = @"-7";
    orderDTO.orderPlacerTel = self.receiverPhoneStr;
    orderDTO.policyId = @"";
    orderDTO.catalogId = @"10051";
    orderDTO.storeId = @"10052";
    orderDTO.subpolicyid = @"";
    orderDTO.subCodpolicyId = @"";
    orderDTO.portage = portageStr;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (type == paymentChoose) {
            [self paymentChooseOk:YES payDto:orderDTO];
        }else if (type == submitInfo){
            [self submitOrderOk:YES payDto:orderDTO];
        }else if (type == saveCardAndCoupon){
            [self saveCardAndCouponOk:YES payDto:orderDTO];
        }
    });
    Background_End
}

- (void)parseLastShipInfo:(NSDictionary *)items
{
    Background_Begin
    NSString *canTake = [items objectForKey:@"canTake"];
    self.canTake = [canTake isEqualToString:@"1"]?YES:NO;
    //最近选择的配送方式
    NSString *lastShipModeStr = [items objectForKey:@"lastShipMode"];
    ShipMode lastShipMode =
    (NotNilAndNull(lastShipModeStr) && [lastShipModeStr isEqualToString:@"-2"]) ? ShipModeSelfTake : ShipModeSuningSend;
    
    //最近自提信息
    StoreInfoDto *lastPickUpInfoDTO = nil;
    NSArray *lastPickUpInfoArray = [items objectForKey:@"lastPickUpInfo"];
    if (NotNilAndNull(lastPickUpInfoArray) && [lastPickUpInfoArray count] > 0) {
        NSDictionary *tempDic = [lastPickUpInfoArray objectAtIndex:0];
        
        StoreInfoDto *dto = [[StoreInfoDto alloc] init];
        [dto encodeLastPickUpInfoFromDictionary:tempDic];
        
        //如果最近自提信息的“districtId”字段为空或者是不存在，说明用户还没有自提记录”
        if (dto.districtId == nil || [dto.districtId isEmptyOrWhitespace]) {
            //do nothing
        }else{
            lastPickUpInfoDTO = dto;
        }
    }
    
    //最近配送地址
    AddressInfoDTO *lastShipInfoDTO = nil;
    NSArray *lastShipInfoArray = [items objectForKey:@"lastShipInfo"];
    if (NotNilAndNull(lastShipInfoArray) && [lastShipInfoArray count] > 0) {
        NSDictionary *tempDic = [lastShipInfoArray objectAtIndex:0];
        
        AddressInfoDTO *dto = [[AddressInfoDTO alloc] init];
        [dto encodeLastShipInfoFromDictionary:tempDic];
        
        lastShipInfoDTO = dto;
        //addressNo为空，则无地址信息
        if (dto.addressNo == nil || [dto.addressNo isEmptyOrWhitespace]) {
            //do nothing
        }else{
            //                    lastShipInfoDTO = [[dto retain] autorelease];
            //因接口有时返回不正确，有时返回省市为空，故使用addressId到userInfo里面匹配，
            //匹配到正确的就使用，没有就不使用
            NSArray *addressList = [[UserCenter defaultCenter] userInfoDTO].addressArray;
            for (AddressInfoDTO *temp in addressList){
                if ([temp.addressNo isEqualToString:dto.addressNo]) {
                    lastShipInfoDTO = temp;
                }
            }
        }
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self getLastShipInfoOk:YES
                   lastShipMode:lastShipMode
                   lastPickInfo:lastPickUpInfoDTO
                   lastShipInfo:lastShipInfoDTO];
    });
    
    Background_End
}

- (NSString *)collectSystemInfo
{
    //    MOBILE|01|01|2.2.3|01     终端类型 01 iphone 应用类型  01 易购客户端  市场版本号  2.2.3 应用市场  01 苹果应用商店
    NSString *systemInfo = [NSString stringWithFormat:@"MOBILE|01|01|%@|%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"],kDownloadChannelNum];
    
    return systemInfo;
}

#pragma mark -
#pragma mark  shop cart service response

- (void)service:(ShopCartV2Service *)service syncShopCartComplete:(BOOL)isSuccess
{
    if (!isSuccess && [service.exceptionList count])
    {
        ShopCartV2DTO *errorItem = [service errorItemFromExceptionList:service.exceptionList];
        NSString *errorDesc = [NSString stringWithFormat:L(@"ShopCart_OrderCheck_Product_Error%@%@"),
                               errorItem.productName, errorItem.errorDesc];
        self.errorMsg = errorDesc;
    }
    
    [self submitOrderOk:NO payDto:nil];
}

@end
