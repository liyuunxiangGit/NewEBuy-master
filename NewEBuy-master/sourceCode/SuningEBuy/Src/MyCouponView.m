//
//  MyCouponView.m
//  SuningEBuy
//
//  Created by 正来 崔 on 12-9-12.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "MyCouponView.h"

@implementation MyCouponView

@synthesize  headerView = _headerView;
@synthesize  footView = _footView;
@synthesize desLabel = _desLabel;
@synthesize  loadMoreView=_loadMoreView;
@synthesize leftButton = _leftButton;
@synthesize rightButton = _rightButton;
@synthesize segCate = _segCate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(UIView *)footView{
    
    if (_footView == nil) {
        
        _footView = [[UIView alloc ]initWithFrame:CGRectMake(0, 0, 320, 75)];
        
        _footView.backgroundColor = [UIColor clearColor];
        
        [_footView addSubview:self.leftButton];
        
        [_footView addSubview:self.rightButton];
        
        [_footView addSubview:self.desLabel];
    }
    
    return _footView;
    
}

-(UISegmentedControl *)segCate{
    
    if (_segCate == nil) {
        
        NSArray *item = [[NSArray alloc] initWithObjects:L(@"coupon unUse"),L(@"coupon used"),L(@"coupon outOfUse"),nil];
        
        _segCate = [[UISegmentedControl alloc] initWithItems:item];
        
        _segCate.selectedSegmentIndex = 0;
        
        _segCate.multipleTouchEnabled=NO; 
        
        _segCate.segmentedControlStyle = UISegmentedControlStyleBar;
        
        _segCate.tintColor = RGBCOLOR(30, 196, 236);
        
//        [_segCate addTarget:self action:@selector(segmentedControl:) forControlEvents:UIControlEventValueChanged]; 
        
        [_segCate setFrame:CGRectMake(10, self.desLabel.bottom+5, 300, 35)];
        
        TT_RELEASE_SAFELY(item);
        
        [_footView addSubview:_segCate];
        
    }    
    return _segCate;
}


-(UILabel *)desLabel{
    
    if (_desLabel == nil) {
        
        _desLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, self.leftButton.bottom+5, 150, 30)];
        
        _desLabel.textAlignment = UITextAlignmentLeft;
        
        _desLabel.font = [UIFont systemFontOfSize:16];
        
        _desLabel.textColor = [UIColor grayColor];
        
        _desLabel.text = L(@"MyEBuy_CouponDetails");
        
        [_desLabel setAdjustsFontSizeToFitWidth:NO];
        
        [_desLabel setNumberOfLines:0];
        
        _desLabel.backgroundColor = [UIColor clearColor];
        
        _desLabel.lineBreakMode = UILineBreakModeCharacterWrap;
    }
    
    return _desLabel;
}

- (UIButton *)leftButton
{
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.frame = CGRectMake(8, 5, 153, 32);
        [_leftButton setBackgroundImage:[UIImage imageNamed:kLeftButtonHightlightImage] forState:UIControlStateNormal];
//        [_leftButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        _leftButton.tag = 0;
        [_leftButton setTitle:L(@"MyEBuy_Coupons") forState:UIControlStateNormal];
        _leftButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
    }
    return _leftButton;
}

- (UIButton *)rightButton
{
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.frame = CGRectMake(160, 5, 153, 32);
        [_rightButton setBackgroundImage:[UIImage imageNamed:kRightButtonNomalImage] forState:UIControlStateNormal];
//        [_rightButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        _rightButton.tag = 1;
        [_rightButton setTitle:L(@"MyEBuy_IntegralCoupons") forState:UIControlStateNormal];
//        [_rightButton setTitle:@"云钻兑换券" forState:UIControlStateNormal];
        _rightButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
    }
    return _rightButton;
}


@end
