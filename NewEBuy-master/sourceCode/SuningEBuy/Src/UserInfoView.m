//
//  UserInfoCell.m
//  SuningEBuy
//
//  Created by cw on 12-4-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UserInfoView.h"
#import "UserCenter.h"

#define DefaultHeight           30
#define DefaultValueLblLeft     100


@implementation UserInfoView

@synthesize myAccountLbl = _myAccountLbl;
@synthesize myNickName = _myNickName;
//@synthesize myEfbaoLbl = _myEfbaoLbl;

@synthesize myAccountValLbl = _myAccountValLbl;
@synthesize myNickNameValBtn = _myNickNameValBtn;
@synthesize myNickNameValLbl = _myNickNameValLbl;
//@synthesize myEfbaoValLbl = _myEfbaoValLbl;
@synthesize userInfoDTO = _userInfoDTO;

//@synthesize activeEfbaoBtn = _activeEfbaoBtn;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_myAccountLbl);
    TT_RELEASE_SAFELY(_myNickName);
//    TT_RELEASE_SAFELY(_myEfbaoLbl);
    
    TT_RELEASE_SAFELY(_myAccountValLbl);
    TT_RELEASE_SAFELY(_myNickNameValBtn);
    TT_RELEASE_SAFELY(_myNickNameValLbl);
//    TT_RELEASE_SAFELY(_myEfbaoValLbl);
    
    TT_RELEASE_SAFELY(_userInfoDTO);
    
//    TT_RELEASE_SAFELY(_activeEfbaoBtn);
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)setItem:(UserInfoDTO *)dto withCoupon:(NSString *)coupon
                                   andAdvance:(NSString *)advance
{
    //登录后接口返回的值
    if (dto == nil)
    {
        
        self.myAccountValLbl.text = @"--";

        
    }else{
    
        self.userInfoDTO = dto; 
        
        NSString *str1 = (dto.logonId == nil || [dto.logonId  isEqualToString:@""]) ?@"***":dto.logonId;
                        
        self.myAccountValLbl.text = str1;
    }
    
//    if ([dto.eppStatuss isEqualToString:@"0"]) {
//        [self addSubview:self.activeEfbaoBtn];
//        [self.myEfbaoValLbl removeFromSuperview];
//    }
//    else{
//        if (advance == nil) {
//            self.myEfbaoValLbl.text = @"--";
//        }else{
//            self.myEfbaoValLbl.text = [self getFormatNum:advance];
//        }
//        [self addSubview:self.myEfbaoValLbl];
//        [self.activeEfbaoBtn removeFromSuperview];
//    }
//
    NSString *nickname = [UserCenter defaultCenter].userInfoDTO.nickName;
    
    if (IsNilOrNull(nickname) || [nickname isEqualToString:@""]) {
        [self addSubview:self.myNickNameValBtn];
        [self.myNickNameValLbl removeFromSuperview];
    }
    else{
        self.myNickNameValLbl.text = nickname;
        [self addSubview:self.myNickNameValLbl];
        [self.myNickNameValBtn removeFromSuperview];
    } 
    
    [super setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    [self addSubview:self.myNickName];
    [self addSubview:self.myAccountLbl];
//    [self addSubview:self.myEfbaoLbl];
    [self addSubview:self.myAccountValLbl];
}

-(UILabel *)myNickName{
    if (_myNickName == nil) {
        _myNickName = [[UILabel alloc]initWithFrame:CGRectMake(22, 2, 61, DefaultHeight)];
        _myNickName.backgroundColor = [UIColor clearColor];
        _myNickName.text = L(@"MyEBuy_Nickname");
        _myNickName.font = [UIFont systemFontOfSize:15.0];
    }
    return _myNickName;
}

-(UILabel *)myAccountLbl{
    if (_myAccountLbl == nil) {
        _myAccountLbl = [[UILabel alloc]initWithFrame:CGRectMake(22, self.myNickName.bottom, 61, DefaultHeight)];
        _myAccountLbl.backgroundColor = [UIColor clearColor];
        _myAccountLbl.text = L(@"MyEBuy_Account2");
        _myAccountLbl.font = [UIFont systemFontOfSize:15.0];
    }
    return _myAccountLbl;
}
//
//-(UILabel *)myEfbaoLbl{
//    if (_myEfbaoLbl == nil) {
//        _myEfbaoLbl = [[UILabel alloc]initWithFrame:CGRectMake(22, self.myAccountLbl.bottom, 61, DefaultHeight)];
//        _myEfbaoLbl.backgroundColor = [UIColor clearColor];
//        _myEfbaoLbl.text = @"易付宝";
//        _myEfbaoLbl.font = [UIFont systemFontOfSize:15.0];
//    }
//    return _myEfbaoLbl;
//}

-(UILabel *)myNickNameValLbl{
    if (_myNickNameValLbl == nil) {
        _myNickNameValLbl = [[UILabel alloc]initWithFrame:CGRectMake(DefaultValueLblLeft, 2, 175, DefaultHeight)];
        _myNickNameValLbl.text = @"--";
        _myNickNameValLbl.backgroundColor = [UIColor clearColor];
        _myNickNameValLbl.font = [UIFont systemFontOfSize:15.0];
        [self addSubview:_myNickNameValLbl];
    }
    return _myNickNameValLbl;
}

-(UILabel *)myAccountValLbl{
    if (_myAccountValLbl == nil) {
        _myAccountValLbl = [[UILabel alloc]initWithFrame:CGRectMake(DefaultValueLblLeft, self.myAccountLbl.top, 175, DefaultHeight)];
        _myAccountValLbl.text = @"--";
        _myAccountValLbl.backgroundColor = [UIColor clearColor];
        _myAccountValLbl.font = [UIFont systemFontOfSize:15.0];
    }
    return _myAccountValLbl;
}


- (UIButton *)myNickNameValBtn{
    
    if (!_myNickNameValBtn) {
        
        _myNickNameValBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_myNickNameValBtn setBackgroundImage:[UIImage imageNamed:@"edit_nickName_icon.png"] forState:UIControlStateNormal];
        
        _myNickNameValBtn.frame = CGRectMake(DefaultValueLblLeft, self.myNickName.top+5, 23, 23);
        
        _myNickNameValBtn.backgroundColor = [UIColor clearColor];
    }
    
    return _myNickNameValBtn;
}

//- (UIButton *)activeEfbaoBtn{
//    
//    if (!_activeEfbaoBtn) {
//        
//        _activeEfbaoBtn = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
//        
//        [_activeEfbaoBtn setTitle:@"去激活" forState:UIControlStateNormal];
//        
//        [_activeEfbaoBtn setTitleColor:RGBCOLOR(52, 73, 124) forState:UIControlStateNormal];
//        
//        [_activeEfbaoBtn setBackgroundImage:[UIImage imageNamed:@"active_efubao.png"] forState:UIControlStateNormal];
//        
//        [_activeEfbaoBtn setBackgroundImage:[UIImage imageNamed:@"active_efubao_click.png"] forState:UIControlStateHighlighted];
//        
//        _activeEfbaoBtn.frame = CGRectMake(DefaultValueLblLeft, self.myEfbaoLbl.top, 84, 30);
//        
//        _activeEfbaoBtn.backgroundColor = [UIColor clearColor];
//    }
//    
//    return _activeEfbaoBtn;
//}


//-(UILabel *)myEfbaoValLbl{
//    if (_myEfbaoValLbl == nil) {
//        _myEfbaoValLbl = [[UILabel alloc]initWithFrame:CGRectMake(DefaultValueLblLeft, self.myEfbaoLbl.top, 175, DefaultHeight)];
//        _myEfbaoValLbl.backgroundColor = [UIColor clearColor];
//        _myEfbaoValLbl.text = @"--";
//        _myEfbaoValLbl.font = [UIFont systemFontOfSize:15.0];
//    }
//    return _myEfbaoValLbl;
//}

-(NSString *)getFormatNum:(NSString *)num{
    
    double temp = [num doubleValue];
    
    NSString *tempString = [NSString stringWithFormat:@"%0.2f",temp];
    
    return tempString;

}

@end
