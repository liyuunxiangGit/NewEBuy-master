//
//  UserInfoDTO.h
//  SuningEMall
//
//  Created by Wang Jia on 11-1-12.
//  Copyright 2011 IBM. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AddressInfoDTO.h"
#import "BaseHttpDTO.h"


@interface UserInfoDTO : BaseHttpDTO {
	
	NSString		*_userId;
	
	NSString		*_logonId;
	NSString		*_userLevel;
	NSString		*_userName;
	NSString		*_nickName;
	NSString		*_sex;
	NSString		*_birthDate;
	NSString		*_phnoneNo;
	NSString		*_memberCardNo;
	NSString		*_yifubaoBalance;
	
	NSMutableArray	*_addressArray;
    NSString        *_eppStatuss; //robin login
    NSString        *_isBindMobile;//added by shasha,used for active efubao
    NSString        *_accountNo;  //added by liukun
    NSString        *_emailStatus;//added by shasha,used for active efubao
    
    NSString        *_internalNum;//add by maxy 内卡号
    NSString        *_snTeck;
    
	
	BOOL			_hasOrderByAfterPay;	//含货到付款未支付订单
    NSString        *_custLevelCN;//
}

@property (nonatomic, strong) NSString			*userId;

@property (nonatomic, copy) NSString			*logonId;
@property (nonatomic, copy) NSString			*userLevel;
@property (nonatomic, copy) NSString			*userName;
@property (nonatomic, copy) NSString			*nickName;
@property (nonatomic, copy) NSString			*sex;
@property (nonatomic, copy) NSString			*birthDate;
@property (nonatomic, copy) NSString			*phoneNo;
@property (nonatomic, copy) NSString			*memberCardNo;
@property (nonatomic, copy) NSString			*yifubaoBalance;
@property (nonatomic, copy) NSString            *eppStatuss;
@property (nonatomic, copy) NSString            *isBindMobile;
@property (nonatomic, strong) NSMutableArray	*addressArray;
@property (nonatomic, copy) NSString            *accountNo;
@property (nonatomic, copy) NSString            *emailStatus;
@property (nonatomic, copy) NSString            *internalNum;
@property (nonatomic, copy) NSString            *snTeck;
@property (nonatomic, strong)NSString        *custNum;
@property (nonatomic, strong)NSString           *achive;
@property (nonatomic, copy) NSString            *custLevelCN;
@property (nonatomic, assign) BOOL				hasOrderByAfterPay;

- (void)parserAddress:(NSArray *)array;

@end
