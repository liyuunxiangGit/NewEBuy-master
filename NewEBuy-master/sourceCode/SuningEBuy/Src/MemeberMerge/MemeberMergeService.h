//
//  MemeberMergeService.h
//  SuningEBuy
//
//  Created by  zhang jian on 13-10-12.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "DataService.h"
#import "MergeNewAccountDTO.h"
#import "MemeberMergeService.h"

@interface MemberInfoDto : BaseHttpDTO
{
    
}

@property (nonatomic, strong) NSString              *suningAccount;
@property (nonatomic, strong) NSString              *cardNum;
@property (nonatomic, strong) NSString              *cellphone;
@property (nonatomic, strong) NSString              *achieve;

@end


@protocol MemeberMergeServiceDelegate;

@interface MemeberMergeService : DataService
{
    HttpMessage             *SNMTSearchBindedInfoMsg;
    HttpMessage             *SNMTMbrCardBindAccountMsg;
    HttpMessage             *SNMTSearchMbrCardInfoMsg;
    HttpMessage             *SNMTGetBindMbrCardViewMsg;
    HttpMessage             *SNMTAccountBindMbrCardMsg;
    HttpMessage             *SNMTMergeNewAccountMsg;
}
@property (nonatomic, weak)    id<MemeberMergeServiceDelegate>         delegate;
@property (nonatomic, strong)               NSMutableArray                          *cardNoList;

@property (nonatomic, strong)               NSString                                *bindMbrCard;

@property (nonatomic, strong)               NSString                                *suningAccount;

@property (nonatomic, strong)               NSString                                *accountType;
@property (nonatomic, strong)               NSString                                *accountBindCellPhone;
@property (nonatomic, strong)               MemberInfoDto                           *memberInfoDto;


//2.3	验证短信验证码&&检索出易购账号+门店会员卡
- (void)beginSearchBindInfoHttpRequestCellphone:(NSString *)cellphone withCode:(NSString *)validateCode;

//2.4	绑定易购账号logonId=&logonPassword=&cardNum=&cardPsw=
- (void)beginMbrCardBindAccountLoginId:(NSString *)logonId logonPassword:(NSString *)logonPassword cardNum:(NSString *)cardNum cardPsw:(NSString *)cardPsw;

//2.11 新建易购账号并合并
- (void)beginMergeNewAccount:(MergeNewAccountDTO *)mergeNewAccountDto;

//2.12	登录状态查询门店卡绑定信息
- (void)beginSearchMbrCardInfoHttpRequest;

//2.13	登录状态绑定手机号查询门店卡信息
- (void)beginGetBindMbrCardViewHttpRequest;

//2.14	登录状态合并会员卡
- (void)beginAccountBindMbrCardWithCardNum:(NSString *)cardNum cardPsw:(NSString *)cardPsw;

@end

@protocol MemeberMergeServiceDelegate <NSObject>

@optional

- (void)searchBindInfoHttpComplete:(MemeberMergeService *)service
                         isSuccess:(BOOL)isSuccess;

- (void)mbrCardBindAccountHttpComplete:(MemeberMergeService *)service
                        isMergeSuccess:(BOOL)isMergeSuccess
                             isSuccess:(BOOL)isSuccess;

- (void)searchMbrCardInfoHttpComplete:(MemeberMergeService *)service
                            isSuccess:(BOOL)isSuccess;

- (void)getBindMbrCardViewHttpComplete:(MemeberMergeService *)service
                             isSuccess:(BOOL)isSuccess;

- (void)accountBindMbrCardHttpComplete:(MemeberMergeService *)service
                             isSuccess:(BOOL)isSuccess;

- (void)mergeNewAccountHttpComplete:(MemeberMergeService *)service
                          isSuccess:(BOOL)isSuccess;


@end


@interface CardNoListDTO : BaseHttpDTO
{
    
}
@property (nonatomic, strong) NSString          *ecoType;//业态类型
@property (nonatomic, strong) NSString          *cardNo;//会员卡号
@property (nonatomic, strong) NSString          *isBindB2CAccount;//该会员卡是否已经绑定  1已经绑定    0 未绑定
@property (nonatomic, assign) BOOL              isSelected;

@end

