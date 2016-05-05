//
//  MergeNewAccountDTO.h
//  SuningEBuy
//
//  Created by  zhang jian on 13-10-16.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "BaseHttpDTO.h"

@interface MergeNewAccountDTO : BaseHttpDTO

@property (nonatomic, strong) NSString          *registerId;//易购账号
@property (nonatomic, strong) NSString          *registerPassword;//易购账号密码
@property (nonatomic, strong) NSString          *validateCode;//短信验证码
@property (nonatomic, strong) NSString          *cardNum;//会员卡号
@property (nonatomic, strong) NSString          *mbrcardPsw;//会员密码

@property (nonatomic, strong) NSString          *actionType;//步骤类型


@end
