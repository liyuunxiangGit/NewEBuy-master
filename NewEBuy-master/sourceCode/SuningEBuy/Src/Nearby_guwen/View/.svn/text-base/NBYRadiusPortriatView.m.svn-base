//
//  NBYRadiusPortriatView.m
//  SuningEBuy
//
//  Created by suning on 14-9-26.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "NBYRadiusPortriatView.h"

@interface NBYRadiusPortriatView ()
@property (nonatomic,strong) UIImageView    *maskView;
@end

@implementation NBYRadiusPortriatView

- (void)setUpUI {
    
    CGSize sz = self.frame.size;
    
    self.maskView = [[UIImageView alloc] initWithFrame:CGRectMake(.0f,.0f,sz.width,sz.height)];
    _maskView.image = [UIImage imageNamed:@"nnby_portriatMask"];
    [self addSubview:_maskView];

}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self setUpUI];
    }
    return self;
}

- (void)awakeFromNib {
    [self setUpUI];
}

@end
