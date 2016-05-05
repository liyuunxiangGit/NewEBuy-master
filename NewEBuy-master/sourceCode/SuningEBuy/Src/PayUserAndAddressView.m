//
//  PayUserAndAddressView.m
//  SuningEBuy
//
//  Created by  zhang jian on 14-2-8.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "PayUserAndAddressView.h"

@implementation PayUserAndAddressView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (UILabel *)userName
{
    if (!_userName) {
        _userName = [[UILabel alloc] init];
        _userName.font = [UIFont boldSystemFontOfSize:15.0];
        _userName.backgroundColor = [UIColor clearColor];
        _userName.textColor = [UIColor light_Black_Color];
        [self addSubview:_userName];
    }
    return _userName;
}

- (UILabel *)phoneNum
{
    if (!_phoneNum) {
        _phoneNum = [[UILabel alloc] init];
        _phoneNum.backgroundColor = [UIColor clearColor];
        _phoneNum.textColor = [UIColor light_Black_Color];
        _phoneNum.textAlignment = NSTextAlignmentRight;
        _phoneNum.font = [UIFont boldSystemFontOfSize:15.0];
        [self addSubview:_phoneNum];
    }
    return _phoneNum;
}

- (UILabel *)addressInfo
{
    if (!_addressInfo) {
        _addressInfo = [[UILabel alloc] init];
        _addressInfo.backgroundColor = [UIColor clearColor];
        _addressInfo.textColor = [UIColor dark_Gray_Color];
        _addressInfo.font = [UIFont boldSystemFontOfSize:13.0];
        _addressInfo.numberOfLines = 0;
        [self addSubview:_addressInfo];
    }
    return _addressInfo;
}

- (void)setShipMode:(ShipMode)shipMode UserName:(NSString *)userName phoneNum:(NSString *)phoneNum addressInfo:(NSString *)addressInfo
{
    if (IsStrEmpty(addressInfo)) {
        self.userName.frame = CGRectMake(15, 20, 150, 30);
        self.userName.textColor = [UIColor dark_Gray_Color];
        if (shipMode == ShipModeSuningSend) {
            self.userName.text = L(@"PFPleaseSelectDeliveryAddress");
        }else{
            self.userName.text = L(@"PFPleaseSelectStore");
        }
        self.phoneNum.text = @"";
        self.addressInfo.text = @"";
    }else{
        self.userName.frame = CGRectMake(15, 5, 145, 30);
        self.userName.textColor = [UIColor light_Black_Color];
        self.userName.text = IsStrEmpty(userName)?@"":userName;
        self.phoneNum.frame = CGRectMake(self.userName.right, 5, 115, 30);
        self.phoneNum.text = IsStrEmpty(phoneNum)?@"":phoneNum;
        CGSize size = [addressInfo sizeWithFont:[UIFont boldSystemFontOfSize:13.0] constrainedToSize:CGSizeMake(260, 50)];
        self.addressInfo.frame = CGRectMake(15, self.userName.bottom + 5, 260, size.height);
        self.addressInfo.text = IsStrEmpty(addressInfo)?@"":addressInfo;
    }
}

+ (CGFloat)height:(NSString *)addressInfo
{
    CGSize size = [addressInfo sizeWithFont:[UIFont boldSystemFontOfSize:13.0] constrainedToSize:CGSizeMake(260, 50)];
    
    return size.height + 50;
}

@end
