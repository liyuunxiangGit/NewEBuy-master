//
//  PayServiceDTO.m
//  SuningEBuy
//
//  Created by 刘坤 on 11-10-21.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "PayServiceDTO.h"

@implementation PayServiceDTO
@synthesize typeCode = _typeCode;

@synthesize areaCode = _areaCode;
@synthesize areaName = _areaName;

@synthesize companyCode = _companyCode;
@synthesize companyId = _companyId;
@synthesize companyName = _companyName;

@synthesize modeCode = _modeCode;
@synthesize chargeAccount = _chargeAccount;

@synthesize model = _model;
@synthesize customerName = _customerName;
@synthesize balance = _balance;
@synthesize payAmount = _payAmount;
@synthesize contractNo = _contractNo;
@synthesize beginDate = _beginDate;
@synthesize endDate = _endDate;
@synthesize accountTerm = _accountTerm;

@synthesize accountNo = _accountNo;
@synthesize efubaoBalance = _efubaoBalance;

@synthesize payInfo = _payInfo;

- (id)init
{
    self = [super init];
    if (self)
    {
        self.typeCode = @"";
        
        self.areaCode = @"";
        self.areaName = @"";
        
        self.companyCode = @"";
        self.companyId =@"";
        self.companyName = @"";
        
        self.modeCode = @"";
        self.chargeAccount = @"";
        
        self.model = @"";
        self.customerName = @"";
        self.balance = @"";
        self.payAmount = @"";
        self.contractNo = @"";
        self.beginDate = @"";
        self.endDate = @"";
        self.accountTerm = @"";
        self.accountNo = @"";
        
        self.payInfo = @"";
        self.efubaoBalance = @"";
    }
    return self;
}

- (void)encodeFromDictionary:(NSDictionary *)dic
{
    NSString *areCode = [dic objectForKey:@"areaCode"];
    NSString *areName = [dic objectForKey:@"areaName"];
    
    NSString *comCode = [dic objectForKey:@"companyCode"];
    NSString *comId = [dic objectForKey:@"companyId"];
    NSString *comName = [dic objectForKey:@"companyName"];
    
    NSString *modCode = [dic objectForKey:@"modeCode"];
    
    NSString *cusName = [dic objectForKey:@"customerName"];
    NSString *balan = [dic objectForKey:@"balance"];
    NSString *pAmount = [dic objectForKey:@"payAmount"];
    NSString *conNo = [dic objectForKey:@"contractNo"];
    NSString *begDate = [dic objectForKey:@"beginDate"];
    NSString *eDate = [dic objectForKey:@"endDate"];
    NSString *accTerm = [dic objectForKey:@"accountTerm"];
    
    NSString *pInfo = [dic objectForKey:@"payInfo"];
    
    if (NotNilAndNull(areCode))
    {
        self.areaCode = areCode;
    }
    if (NotNilAndNull(areName))
    {
        self.areaName = areName;
    }
    if (NotNilAndNull(comCode))
    {
        self.companyCode = comCode;
    }
    if (NotNilAndNull(comId))
    {
        self.companyId = comId;
    }
    if (NotNilAndNull(comName))
    {
        self.companyName = comName;
    }
    if (NotNilAndNull(modCode))
    {
        self.modeCode = modCode;
    }
    
    if (NotNilAndNull(cusName))
    {
        self.customerName = cusName;
    }
    if (NotNilAndNull(balan))
    {
        self.balance = balan;
    }
    if (NotNilAndNull(pAmount))
    {
        self.payAmount = pAmount;
    }
    if (conNo != nil && ![conNo isEqualToString:@""])
    {
        self.contractNo = conNo;
    }
    if (NotNilAndNull(begDate))
    {
        self.beginDate = begDate;
    }
    if (NotNilAndNull(eDate))
    {
        self.endDate = eDate;
    }
    if (NotNilAndNull(accTerm))
    {
        self.accountTerm = accTerm;
    }
    if (NotNilAndNull(pInfo))
    {
        self.payInfo = pInfo;
    }
}

- (void)dealloc
{
    TT_RELEASE_SAFELY(_typeCode);
    
    TT_RELEASE_SAFELY(_areaCode);
    TT_RELEASE_SAFELY(_areaName);
    
    TT_RELEASE_SAFELY(_companyCode);
    TT_RELEASE_SAFELY(_companyId);
    TT_RELEASE_SAFELY(_companyName);
    
    TT_RELEASE_SAFELY(_modeCode);
    TT_RELEASE_SAFELY(_chargeAccount);
    
    TT_RELEASE_SAFELY(_model);
    TT_RELEASE_SAFELY(_customerName);
    TT_RELEASE_SAFELY(_balance);
    TT_RELEASE_SAFELY(_payAmount);
    TT_RELEASE_SAFELY(_contractNo);
    TT_RELEASE_SAFELY(_beginDate);
    TT_RELEASE_SAFELY(_endDate);
    TT_RELEASE_SAFELY(_accountTerm);
    
    TT_RELEASE_SAFELY(_accountNo);
    TT_RELEASE_SAFELY(_efubaoBalance);
    
    TT_RELEASE_SAFELY(_payInfo);
}
@end
