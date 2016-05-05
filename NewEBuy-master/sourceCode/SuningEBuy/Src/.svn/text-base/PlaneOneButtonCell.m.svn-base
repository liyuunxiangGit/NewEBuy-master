//
//  PlaneOneButtonCell.m
//  SuningEBuy
//
//  Created by david on 14-2-18.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "PlaneOneButtonCell.h"

#define leftPadding 15

@interface PlaneOneButtonCell()

@property(nonatomic,strong) UIButton       *button;

@end


@implementation PlaneOneButtonCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        self.backgroundColor = [UIColor clearColor];
        self.backgroundView = nil;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

#pragma mark -
#pragma mark Action

+(CGFloat)height{
    
    return 80;
}


-(void)refreshCell:(PlaneButtonType)type{
    
    self.buttonType = type;
    
    if (self.buttonType == PlaneButtonTypeRefund) {
        
        [self.button setTitle:L(@"BTEndorse") forState:UIControlStateNormal];
        
    }else{
        
        [self.button setTitle:L(@"Cancel Order") forState:UIControlStateNormal];
    }
}

-(void)buttonAction{
    
    if ([_delegate respondsToSelector:@selector(planeOneButtonCell:buttonType:)]) {
        
        [_delegate planeOneButtonCell:self buttonType:self.buttonType];
    }
}


#pragma mark -
#pragma mark UIView
-(UIButton *)button{
    
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.backgroundColor = [UIColor whiteColor];
        [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _button.frame = CGRectMake(leftPadding, 20, (320-leftPadding*2), 30);
        _button.titleLabel.font = [UIFont systemFontOfSize:15];
        [_button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_button];
    }
    
    return _button;
}


@end
