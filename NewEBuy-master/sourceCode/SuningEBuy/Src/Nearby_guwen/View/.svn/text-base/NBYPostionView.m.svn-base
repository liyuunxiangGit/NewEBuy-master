//
//  NBYPostionView.m
//  SuningEBuy
//
//  Created by XZoscar on 14-10-13.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "NBYPostionView.h"

@interface NBYPosIndictorView: UIView
@property (nonatomic,strong) UIImageView *bkImgView;
@property (nonatomic,strong) UILabel     *titleLabel;
@end

@implementation NBYPosIndictorView

// size = (120.0f,52.0f);
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.bkImgView = [[UIImageView alloc] initWithFrame:CGRectMake(.0f,.0f,60.0f,26.0f)];
        _bkImgView.image = [UIImage imageNamed:@"nnby_distance"];
        [self addSubview:_bkImgView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(19.0f,.0f,38.0f,24.0f)];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font      = [UIFont systemFontOfSize:12.0f];
        _titleLabel.backgroundColor = [UIColor clearColor];
        //_titleLabel.textAlignment = NSTextAlignmentCenter;
        //_titleLabel.adjustsFontSizeToFitWidth = YES;
        //[_titleLabel setText:@"000m"];
        [self addSubview:_titleLabel];
    }
    
    return self;
}

@end


@interface NBYPostionView ()

@property (nonatomic,strong) NBYPosIndictorView *posIndictorView;

@end

@implementation NBYPostionView

- (void)setUp {
    CGSize sz = [UIScreen mainScreen].bounds.size;
    self.posIndictorView = [[NBYPosIndictorView alloc] initWithFrame:
                            CGRectMake(sz.width-60.0f,sz.height/2,60.0f,26.0f)];
    [self addSubview:_posIndictorView];
}

- (void)awakeFromNib {
    [self setUp];
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (void)addSubview:(UIView *)view {
    [super addSubview:view];
    
    [self bringSubviewToFront:_posIndictorView];
}

- (void)setTitle:(NSString *)title {
    _posIndictorView.titleLabel.text = title;
}

@end
