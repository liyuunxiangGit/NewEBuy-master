//
//  UserInfoCell.h
//  SuningEBuy
//
//  Created by cw on 12-4-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoDTO.h"

@interface UserInfoView : UIView
//我的账户
@property (nonatomic,strong) UILabel *myAccountLbl;
//我的昵称
@property (nonatomic,strong) UILabel *myNickName;
//易付宝
//@property (nonatomic,retain) UILabel *myEfbaoLbl;


//我的账户名称
@property (nonatomic,strong) UILabel *myAccountValLbl;
//我的昵称
@property (nonatomic,strong) UIButton *myNickNameValBtn;
@property (nonatomic,strong) UILabel  *myNickNameValLbl;
//易付宝账户值
//@property (nonatomic,retain) UILabel *myEfbaoValLbl;
//用户信息dto
@property (nonatomic,strong) UserInfoDTO *userInfoDTO;

//@property (nonatomic,retain) UIButton *activeEfbaoBtn;


- (void)setItem:(UserInfoDTO *)dto withCoupon:(NSString *)coupon 
                                   andAdvance:(NSString *)advance;

-(NSString *)getFormatNum:(NSString *)num;
@end
