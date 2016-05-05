//
//  CouponInfoCell.m
//  SuningEBuy
//
//  Created by 周俊杰 on 14-3-12.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "CouponInfoCell.h"

@implementation CouponInfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self addSubview:self.stateButton];
        [self addSubview:self.moneyInfoLabel];
        [self addSubview:self.timeInfoLabel];
        [self addSubview:self.typeInfoLabel];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)dealloc {
    TT_RELEASE_SAFELY(_moneyInfoLabel);
    TT_RELEASE_SAFELY(_timeInfoLabel);
    TT_RELEASE_SAFELY(_typeInfoLabel);

    _delegate = nil;

}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

- (UILabel *)moneyInfoLabel{
    
    if (_moneyInfoLabel == nil) {
        _moneyInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(33, 10, 60, 15)];
        _moneyInfoLabel.font = [UIFont systemFontOfSize:12];
        _moneyInfoLabel.backgroundColor = [UIColor clearColor];
        _moneyInfoLabel.textColor = [UIColor redColor];
    }
    
    return _moneyInfoLabel;
    
}

- (UILabel *)timeInfoLabel{
    
    if (_timeInfoLabel == nil) {
        _timeInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 10, 160, 15)];
        _timeInfoLabel.font = [UIFont systemFontOfSize:12];
        _timeInfoLabel.backgroundColor = [UIColor clearColor];
        _timeInfoLabel.textColor = [UIColor blackColor];
    }
    
    return _timeInfoLabel;
    
}

- (UILabel *)typeInfoLabel{
    
    if (_typeInfoLabel == nil) {
        _typeInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(250, 10, 60, 15)];
        _typeInfoLabel.font = [UIFont systemFontOfSize:12];
        _typeInfoLabel.backgroundColor = [UIColor clearColor];
        _typeInfoLabel.textColor = [UIColor blackColor];
    }
    
    return _typeInfoLabel;
    
}

- (UIButton *)stateButton {
    if (!_stateButton) {
        _stateButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _stateButton.frame = CGRectMake(15, 10, 15, 15);
        [_stateButton setImage:[UIImage imageNamed:@"coupon_button.png"] forState:UIControlStateNormal];
        [_stateButton setImage:[UIImage imageNamed:@"coupon_button_selected.png"] forState:UIControlStateSelected];
        [_stateButton addTarget:self action:@selector(couponButotnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _stateButton;
}

- (void)couponButotnClick:(UIButton *)button {
    if ([_delegate respondsToSelector:@selector(couponButtonClicked:withClickedButton:)]) {
        [_delegate couponButtonClicked:self withClickedButton:button];
    }
}

@end
