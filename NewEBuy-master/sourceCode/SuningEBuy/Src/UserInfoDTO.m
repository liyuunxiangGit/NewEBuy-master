//
//  UserInfoDTO.m
//  SuningEMall
//
//  Created by Wang Jia on 11-1-12.
//  Copyright 2011 IBM. All rights reserved.
//

#import "UserInfoDTO.h"
#import "HttpConstant.h"
@implementation UserInfoDTO

@synthesize userId = _userId;
@synthesize logonId = _logonId;
@synthesize userLevel = _userLevel;
@synthesize userName = _userName;
@synthesize nickName = _nickName;
@synthesize sex = _sex;
@synthesize birthDate = _birthDate;
@synthesize phoneNo = _phoneNo;
@synthesize memberCardNo = _memberCardNo;
@synthesize yifubaoBalance = _yifubaoBalance;
@synthesize addressArray = _addressArray;
@synthesize hasOrderByAfterPay = _hasOrderByAfterPay;
@synthesize eppStatuss = _eppStatuss;
@synthesize isBindMobile = _isBindMobile;
@synthesize emailStatus = _emailStatus;
@synthesize snTeck = _snTeck;

@synthesize accountNo = _accountNo;

@synthesize internalNum = _internalNum;
@synthesize custNum = _custNum;
@synthesize custLevelCN = _custLevelCN;

- (id)init
{
    self = [super init];
    
    if (self)
    {
        @autoreleasepool {
            self.userId = @"";
            self.logonId = @"";
            self.userLevel = @"";
            self.userName = @"";
            self.nickName = @"";
            self.sex = @"";
            self.birthDate = @"";
            self.phoneNo = @"";
            self.memberCardNo = @"";
            self.yifubaoBalance = @"";
            self.eppStatuss = @"";
            self.isBindMobile = @"";
            self.accountNo = @"";
            self.emailStatus = @"";
            self.snTeck = @"";
            self.internalNum = @"";
            self.custNum = @"";
            self.achive = @"";
            self.custLevelCN = @"";
            if (self.addressArray == nil)
            {
                NSMutableArray *temp = [[NSMutableArray alloc] initWithCapacity:1];
                self.addressArray = temp;
                TT_RELEASE_SAFELY(temp);
            }
        }
    }
    return self;
}

- (void)dealloc{
    
    TT_RELEASE_SAFELY(_custNum);
	
}

- (void)encodeFromDictionary:(NSDictionary *)dic{
	if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }

    if(NotNilAndNull([dic objectForKey:kHttpResponseUserId])){
        self.userId=[dic objectForKey:kHttpResponseUserId];
    }
    if(NotNilAndNull([dic objectForKey:kRequestLoginUserId])){
        self.logonId=[dic objectForKey:kRequestLoginUserId];
    }
    if(NotNilAndNull([dic objectForKey:kHttpResponseUserLevel])){
        self.userLevel=[dic objectForKey:kHttpResponseUserLevel];
    }
    
    if(NotNilAndNull( [dic objectForKey:kHttpResponseLoginName])){
        self.userName= [dic objectForKey:kHttpResponseLoginName];
    }
    if(NotNilAndNull([dic objectForKey:kHttpResponseLoginNickName])){
        self.nickName=[dic objectForKey:kHttpResponseLoginNickName];
    }
    if(NotNilAndNull([dic objectForKey:kHttpResponseLoginSex])){
        self.sex=[dic objectForKey:kHttpResponseLoginSex];
    }
    if(NotNilAndNull([dic objectForKey:kHttpResponseLoginBirthDate])){
        self.birthDate=[dic objectForKey:kHttpResponseLoginBirthDate];
    }
    if(NotNilAndNull([dic objectForKey:kHttpResponseLoginPhone])){
        self.phoneNo=[dic objectForKey:kHttpResponseLoginPhone];
    }
    if(NotNilAndNull([dic objectForKey:kHttpResponseLoginMemberCard])){
        self.memberCardNo=[dic objectForKey:kHttpResponseLoginMemberCard];
    }
    if(NotNilAndNull([dic objectForKey:kHttpResponseLoginYifubao])){
        self.yifubaoBalance=[dic objectForKey:kHttpResponseLoginYifubao];
    }
    if(NotNilAndNull([dic objectForKey:khttpResponseLoginInternalNum])){
        self.internalNum=[dic objectForKey:khttpResponseLoginInternalNum];
    }

    if(NotNilAndNull([dic objectForKey:@"custNum"])){
        self.internalNum=[dic objectForKey:@"custNum"];
        self.memberCardNo=[dic objectForKey:@"custNum"];
    }
    
    NSString *tmep = [dic objectForKey:kHttpResponseLoginEppStatus];
    if (NotNilAndNull(tmep)) {
        self.eppStatuss = tmep;
    }
    
    NSString* tempCustLevelCN = [dic objectForKey:kHttpResponseLogincustLevelCN];
    if (NotNilAndNull(tempCustLevelCN))
    {
        self.custLevelCN = tempCustLevelCN;
    }
    
    NSString *isBind = [dic objectForKey:kHttpResponseLoginIsBindMobile];
    if (NotNilAndNull(isBind)) {
        self.isBindMobile = isBind;
    }
    
    NSString *isEmailActive = [dic objectForKey:kHttpResponseLoginEmailStatus];
    if (NotNilAndNull(isEmailActive)) {
        self.emailStatus = isEmailActive;
    }
	
    NSString *hasOrder = [dic objectForKey:kHttpResponseHasOrderByAfterPay];
	if(NotNilAndNull(hasOrder) && [hasOrder isEqualToString:@"L"]){
		self.hasOrderByAfterPay = YES;
    }
	
    NSArray *addresses = [dic objectForKey:kHttpResponseLoginAddress];
	if (NotNilAndNull(addresses)) {
        [self parserAddress:addresses];
    }
    
    
	//DLog(@"parserAddress count:%d",[self.addressArray count]);
    
    NSString *account = [dic objectForKey:khttpResponseLoginAccountNo];
    if (NotNilAndNull(account))   self.accountNo = account;
    
    self.snTeck = EncodeStringFromDic(dic, kHttpResponseLoginSnTeck);
	self.custNum = EncodeStringFromDic(dic, @"custNum");
    self.achive = EncodeStringFromDic(dic, @"achive");
}

- (void)parserAddress:(NSArray *)array{
	if (array == nil) {
		return;
	}
	
	@autoreleasepool {
        NSMutableArray *tempArray = [[NSMutableArray alloc] initWithCapacity:1];
        for (NSDictionary *dic in array) 
        {
            AddressInfoDTO *addressInfoDTO = [[AddressInfoDTO alloc] init];
            [addressInfoDTO encodeFromDictionary:dic];
            if ([@"" isEqualToString:[addressInfoDTO province]] || 
                addressInfoDTO.addressType == EasilyBuyAddress)
            {
                continue;
            }
            [tempArray addObject:addressInfoDTO];
        }
        self.addressArray = tempArray;
    }
}

@end
