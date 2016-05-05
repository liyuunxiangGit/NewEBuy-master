//
//  LBZTTableHeaderView.m
//  SuningEBuy
//
//  Created by zhangbeibei on 14-9-26.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "LBZTTableHeaderView.h"

@implementation LBZTTableHeaderView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        ;
    }
    return self;
}

- (EGOImageViewEx *)bgImage {
    if (!_bgImage) {
        _bgImage = [[EGOImageViewEx alloc] initWithFrame:self.frame];
        _bgImage.backgroundColor = [UIColor clearColor];
        _bgImage.hidden = YES;
        [self addSubview:_bgImage];
    }
    return _bgImage;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.frame.size.height)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor light_Black_Color];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.hidden = YES;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}


- (void)updateViewWithDTO:(LianBanFloorDTO *)dto {
    if ([dto.showStyle isEqualToString:@"1"]) {
        //显示图片
        self.backgroundColor = [UIColor clearColor];
        self.bgImage.hidden = NO;
        self.titleLabel.hidden = YES;
        self.bgImage.imageURL = [NSURL URLWithString:dto.bgImg];
    }
    else {
        //显示文字和背景色
        self.bgImage.hidden = YES;
        self.titleLabel.hidden = NO;
        self.titleLabel.text = dto.title ? dto.title : @"";
        if (dto.bgColor&&![dto.bgColor isEqualToString:@""]) {
            self.backgroundColor = [UIColor colorWithHexString:dto.bgColor];
        }else{
            self.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        }
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
