//
//  HeadCategoryView.m
//  SuningEBuy
//
//  Created by gexiangtong on 14-2-14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "HeadCategoryView.h"
#import "V2FristCategoryDTO.h"

@implementation HeadCategoryView
@synthesize nameLabel = _nameLabel;
@synthesize arrowView = _arrowView;

-(void)dealloc
{
    TTVIEW_RELEASE_SAFELY(_nameLabel);
    TTVIEW_RELEASE_SAFELY(_actionBtn);
}

-(UILabel *)nameLabel
{
    if (nil == _nameLabel)
    {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont boldSystemFontOfSize:18];
        [self.cellView addSubview:_nameLabel];
    }
    
    return _nameLabel;
}

-(UIImageView *)arrowView
{
    if (nil == _arrowView)
    {
        _arrowView = [[UIImageView alloc] init];
        _arrowView.image = [UIImage imageNamed:@"arrow_right_white.png"];
        _arrowView.backgroundColor = [UIColor clearColor];
        [self.cellView addSubview:_arrowView];
    }
    
    return _arrowView;
}

- (UIView *)cellView
{
    if (!_cellView) {
        _cellView = [[UIView alloc] init];
        _cellView.backgroundColor = [UIColor orange_Light_Color];
        _cellView.userInteractionEnabled = NO;
        [self addSubview:_cellView];
    }
    return _cellView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.nameLabel.frame = CGRectMake(30, 5, 228 - 60, 40);
        self.cellView.frame = CGRectMake(0, 0, 228, 50);
        self.arrowView.frame = CGRectMake(228 - 25, 11, 10, 18);
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)setDate:(V2FristCategoryDTO *)dto
{
    self.nameLabel.text = dto.kindName;
}

@end
