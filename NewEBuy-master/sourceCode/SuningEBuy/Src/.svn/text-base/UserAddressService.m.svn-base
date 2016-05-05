//
//  UserAddressService.m
//  SuningEBuy
//
//  Created by  on 12-9-25.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "UserAddressService.h"

@interface UserAddressService()

- (void)parseAddressList:(NSDictionary *)items;
- (void)parseAddedAddress:(NSDictionary *)items;
- (void)parseEditedAddress:(NSDictionary *)items;

@end

/*********************************************************************/

@implementation UserAddressService

@synthesize delegate = _delegate;

- (void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(getAddressListHttpMsg);
    HTTPMSG_RELEASE_SAFELY(addAddressHttpMsg);
    HTTPMSG_RELEASE_SAFELY(deleteAddressHttpMsg);
    HTTPMSG_RELEASE_SAFELY(editAddressHttpMsg);
}

#pragma mark -
#pragma mark service life

- (void)beginGetAddressListRequest
{
    NSString *userId = [UserCenter defaultCenter].userInfoDTO.userId;
    
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] initWithCapacity:3];
    
    [postDataDic setObject:kHttpRequestHomeStoreValue
                    forKey:kHttpRequestHomeStoreKey];
	[postDataDic setObject:kHttpRequestHomeCatalogIdValue
                    forKey:kHttpRequestHomeCatalogIdKey];
    [postDataDic setObject:(userId == nil ? @"" : userId) 
                    forKey:kHttpResponseUserId];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttps,[kHttpRequestAddressInfoListHome passport]];
    
    HTTPMSG_RELEASE_SAFELY(getAddressListHttpMsg);
    
    getAddressListHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                       requestUrl:url
                                                      postDataDic:postDataDic
                                                          cmdCode:CC_AddressList];
    getAddressListHttpMsg.requestMethod = RequestMethodGet;
    TT_RELEASE_SAFELY(postDataDic);
    
    [self.httpMsgCtrl sendHttpMsg:getAddressListHttpMsg];
}

- (void)beginAddAddressRequest:(AddressInfoDTO *)address
{
    NSString *userId = [UserCenter defaultCenter].userInfoDTO.userId;
    
    NSString *preferFlag = nil;
    if (YES == address.preferFlag) {
        preferFlag = @"100000000010";
    }else{
        preferFlag = @"100000000020";
    }

    NSDictionary *postDataDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 kHttpRequestHomeStoreValue,kHttpRequestHomeStoreKey,
                                 userId == nil ? @"" : userId,kHttpRequestAddAdressMemberId,
                                 address.province?address.province:@"",  kHttpRequestAddAdressProvince,
                                 address.city?address.city:@"",  kHttpRequestAddAdressCity,
                                 address.district?address.district:@"",  kHttpRequestAddAdressDistrict,
                                 address.town?address.town:@"",  kHttpRequestAddAdressTown,
                                 address.addressContent?address.addressContent:@"",  kHttpRequestAddAdressAddressContent,
                                 address.recipient?address.recipient:@"",  kHttpRequestAddAdressRecipient,
                                 address.tel?address.tel:@"",  kHttpRequestAddAdressTel,
                                 preferFlag,  kHttpRequestAddAdressPreferFlag,
                                 nil];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@", kHostAddressForHttps, [kHttpRequestAddAddressInfoHome passport]];
    
    HTTPMSG_RELEASE_SAFELY(addAddressHttpMsg);
    
    addAddressHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                   requestUrl:url
                                                  postDataDic:postDataDic
                                                      cmdCode:CC_AddAddress];
    addAddressHttpMsg.requestMethod = RequestMethodGet;
	TT_RELEASE_SAFELY(postDataDic);
    
    [self.httpMsgCtrl sendHttpMsg:addAddressHttpMsg];
}

- (void)beginEditAddressRequest:(AddressInfoDTO *)address
{
    NSString *addressNo = [address.addressNo replacedWhiteSpacsByString:@""];
    NSString *provinceCode = [address.province replacedWhiteSpacsByString:@""];
    NSString *cityCode = [address.city replacedWhiteSpacsByString:@""];
    NSString *areaCode = [address.district replacedWhiteSpacsByString:@""];
    NSString *townCode = [address.town replacedWhiteSpacsByString:@""];
    
    NSString *preferFlag = nil;
    if (YES == address.preferFlag) {
        preferFlag = @"100000000010";
    }else{
        preferFlag = @"100000000020";
    }
    
    NSDictionary *postDataDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 kIspTypeAndProviceValue,kIspTypeAndProviceKey,
                                 addressNo?addressNo:@"",kHttpRequestAddAdressId,
                                 provinceCode?provinceCode:@"",  kHttpRequestAddAdressProvince,
                                 cityCode?cityCode:@"",  kHttpRequestAddAdressCity,
                                 areaCode?areaCode:@"",  kHttpRequestAddAdressDistrict,
                                 townCode?townCode:@"",  kHttpRequestAddAdressTown,
                                 address.addressContent?address.addressContent:@"",  kHttpRequestAddAdressAddressContent,
                                 address.recipient?address.recipient:@"",  kHttpRequestAddAdressRecipient,
                                 address.tel?address.tel:@"",  kHttpRequestAddAdressTel,
                                 preferFlag,  kHttpRequestAddAdressPreferFlag,
                                 nil];
        
    NSString *url = [NSString stringWithFormat:@"%@/%@", kHostAddressForHttps, [kHttpRequestEditAddressInfoHome passport]];
    
    HTTPMSG_RELEASE_SAFELY(editAddressHttpMsg);
    
    editAddressHttpMsg = [[HttpMessage alloc] initWithDelegate:self 
                                                    requestUrl:url
                                                   postDataDic:postDataDic
                                                       cmdCode:CC_EditAddress];
	
	TT_RELEASE_SAFELY(postDataDic);
    [self.httpMsgCtrl sendHttpMsg:editAddressHttpMsg];
}

- (void)beginDeleteAddressRequest:(NSString *)addressNo
{
    NSMutableDictionary *postDataDic  = [[NSMutableDictionary alloc] initWithCapacity:2];
    
    [postDataDic setObject:addressNo?addressNo:@"" forKey:kHttpResponseShoppingCartToPayAddressId];
    
    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@", kHostAddressForHttps, [kHttpRequestShoppingcartAddressDelete passport]];
    
    HTTPMSG_RELEASE_SAFELY(deleteAddressHttpMsg);
    
    deleteAddressHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                      requestUrl:url
                                                     postDataDic:postDataDic
                                                         cmdCode:CC_DeleteAddress];
    
    TT_RELEASE_SAFELY(postDataDic);
    
    [self.httpMsgCtrl sendHttpMsg:deleteAddressHttpMsg];
}

#pragma mark -
#pragma mark final

- (void)getAddressListFinish:(BOOL)isSuccess list:(NSArray *)list
{
    if (_delegate && [_delegate respondsToSelector:@selector(getAddressListCompletionWithResult:errorMsg:addressList:)]) {
        [_delegate getAddressListCompletionWithResult:isSuccess errorMsg:self.errorMsg addressList:list];
    }
}

- (void)addAddressFinish:(BOOL)isSuccess address:(AddressInfoDTO *)address
{
    if (_delegate && [_delegate respondsToSelector:@selector(addAddressCompletionWithResult:errorMsg:address:)]) {
        [_delegate addAddressCompletionWithResult:isSuccess errorMsg:self.errorMsg address:address];
    }
}

- (void)editAddressFinish:(BOOL)isSuccess address:(AddressInfoDTO *)address
{
    if (_delegate && [_delegate respondsToSelector:@selector(editAddressCompletionWithResult:errorMsg:address:)]) {
        [_delegate editAddressCompletionWithResult:isSuccess errorMsg:self.errorMsg address:address];
    }
}

- (void)deleteAddressFinsh:(BOOL)isSuccess
{
    if (_delegate && [_delegate respondsToSelector:@selector(deleteAddressCompletionWithResult:errorMsg:)]) {
        [_delegate deleteAddressCompletionWithResult:isSuccess errorMsg:self.errorMsg];
    }
}

#pragma mark -
#pragma mark http message delegate

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    switch (receiveMsg.cmdCode) {
        case CC_AddressList:
        {
            [self getAddressListFinish:NO list:nil];
            break;
        }
        case CC_AddAddress:
        {
            [self addAddressFinish:NO address:nil];
            break;
        }
        case CC_EditAddress:
        {
            [self editAddressFinish:NO address:nil];
            break;
        }
        case CC_DeleteAddress:
        {
            [self deleteAddressFinsh:NO];
            break;
        }
        default:
            break;
    }
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    NSDictionary *items = receiveMsg.jasonItems;
    NSString     *errorCode = receiveMsg.errorCode;
    if (!items) {
        self.errorMsg = kHttpResponseJSONValueFailError;
    }
    switch (receiveMsg.cmdCode) {
        case CC_AddressList:
        {
            if (!items) {
                [self getAddressListFinish:NO list:nil];
            }else if (NotNilAndNull(errorCode) && [errorCode isEqualToString:@""]){
                [self parseAddressList:items];
            }else{
                self.errorMsg = L(@"Get_Address_List_Fail");
                [self getAddressListFinish:NO list:nil];
            }
            break;
        }
        case CC_AddAddress:
        {
            if (!items) {
                [self addAddressFinish:NO address:nil];
            }else if (NotNilAndNull(errorCode) && [errorCode isEqualToString:@""]){
                [self parseAddedAddress:items];
            }
            else
            {
                self.errorMsg = errorCode;
                [self addAddressFinish:NO address:nil];
            }
//            else if ([errorCode eq:@"E4700308"]){
//                self.errorMsg = @"最多只能保存20个有效地址";
//                [self addAddressFinish:NO address:nil];
//            }else if ([errorCode eq:@"E4700202"])
//            {
//                self.errorMsg = @"您的会员账号出现异常，请联系4008365365处理";
//                [self addAddressFinish:NO address:nil];
//            }
//            else if ([errorCode eq:@"E4700000"])
//            {
//                self.errorMsg = @"不好意思，系统繁忙，请重试";
//                [self addAddressFinish:NO address:nil];
//            }
//            else{
//                self.errorMsg = L(@"address add fail");
//                [self addAddressFinish:NO address:nil];
//            }
            break;
        }
        case CC_EditAddress:
        {
            if (!items) {
                [self editAddressFinish:NO address:nil];
            }else if (NotNilAndNull(errorCode) && [errorCode isEqualToString:@""]){
                [self parseEditedAddress:items];
            }else{
                self.errorMsg = L(@"address update fail");
                [self editAddressFinish:NO address:nil];
            }
            break;
        }
        case CC_DeleteAddress:
        {
            if (!items) {
                [self deleteAddressFinsh:NO];
            }else if (NotNilAndNull(errorCode) && [errorCode isEqualToString:@""]){
                [self deleteAddressFinsh:YES];
            }else{
                self.errorMsg = L(@"Delete_Address_Fail");
                [self deleteAddressFinsh:NO];
            }
            break;
        }
        default:
            break;
    }
}

- (void)parseAddressList:(NSDictionary *)items
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @autoreleasepool {
            
            NSArray *itemArr = [items objectForKey:@"address"];
            NSMutableArray *retList = nil;
            
            if (itemArr != nil && [itemArr count] > 0){
                retList = [[NSMutableArray alloc] init];
                for (int i = 0; i < [itemArr count]; i++)
                {
                    NSDictionary *dic = [itemArr objectAtIndex:i];
                    AddressInfoDTO *dto = [[AddressInfoDTO alloc] init];
                    [dto encodeFromDictionary:dic];
                    
                    //用户主地址为空不加入
                    if((dto.province == nil) || [dto.province isEqualToString:@""])
                    {
                        DLog(@"default address is empty!!");
                        
                    }else if (dto.addressType == EasilyBuyAddress){
                        //一键购地址不展示, 其实现在接口已经不会返回了,只是判断仍保留
                        DLog(@"Easily buy address");
                    }else if (i == 0){
                        //默认第一个为用户主地址
                        dto.addressType = MainAddress;
                        [retList addObject:dto];
                    }else{
                        [retList addObject:dto];
                    }
                    
                }
            }
             
            dispatch_async(dispatch_get_main_queue(), ^{
                [self getAddressListFinish:YES list:retList];
            });

        } 
    });
}

- (void)parseAddedAddress:(NSDictionary *)items
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @autoreleasepool {
            AddressInfoDTO *dto = [[AddressInfoDTO alloc] init];
            [dto encodeFromDictionary:items];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self addAddressFinish:YES address:dto];
            });

        } 
    });
}

- (void)parseEditedAddress:(NSDictionary *)items
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @autoreleasepool {
            AddressInfoDTO *dto = [[AddressInfoDTO alloc] init];
            [dto encodeFromDictionary:items];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self editAddressFinish:YES address:dto];
            });
            
        } 
    });
}

@end
