//
//  NBNUnreadView.m
//  SuningEBuy
//
//  Created by suning on 14-9-3.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "NBNUnreadView.h"

@interface NBNUnreadView ()
@property (nonatomic,strong) UILabel *numLbl;
@end

@implementation NBNUnreadView

- (void)initialzieUI {
    
    self.userInteractionEnabled = YES;
    self.image = [UIImage imageNamed:@"nb_unread"];
    
    CGRect frame = self.frame;
    
    CGRect f = CGRectMake(.0f,.0f,frame.size.width,frame.size.height);
    self.numLbl = [[UILabel alloc] initWithFrame:f];
    _numLbl.backgroundColor = [UIColor clearColor];
    _numLbl.textColor = [UIColor whiteColor];
    _numLbl.textAlignment = NSTextAlignmentCenter;
    _numLbl.font = [UIFont systemFontOfSize:10.0f];
    _numLbl.adjustsFontSizeToFitWidth = YES;
    _numLbl.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    _numLbl.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self addSubview:_numLbl];
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialzieUI];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        
    }
    return self;
}

- (void)awakeFromNib {
    [self initialzieUI];
}

- (void)setBadgeValue:(NSString *)badgeValue {
    _badgeValue = badgeValue;
    
    if (nil != _badgeValue
        && _badgeValue.intValue > 0) {
        _numLbl.text    = _badgeValue;
        self.hidden  = NO;
        
    }else {
        _numLbl.text    = nil;
        self.hidden  = YES;
    }
}

@end
