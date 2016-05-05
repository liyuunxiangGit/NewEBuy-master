//
//  SecondCategoryMarkView.m
//  SuningEBuy
//
//  Created by li xiaokai on 13-4-10.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "SecondCategoryMarkView.h"

@implementation SecondCategoryMarkView


@synthesize secDto = _secDto;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_buttomLab);
    TT_RELEASE_SAFELY(_iconImageBtn);
    TT_RELEASE_SAFELY(_secDto);
}

- (id)initWithFrame:(CGRect)frame 
{    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

        _buttomLab = [[UILabel alloc] initWithFrame:CGRectMake(-11,
                                                               frame.size.height-8,
                                                               frame.size.width+22,
                                                               15)];
        _buttomLab.backgroundColor = [UIColor clearColor];
        _buttomLab.textAlignment = UITextAlignmentCenter;
        _buttomLab.font = [UIFont boldSystemFontOfSize:12];
    
        _buttomLab.textColor = [UIColor whiteColor];
        [self addSubview:_buttomLab];
        
        self.userInteractionEnabled = YES;
        
        
//		UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self
//                                                                             action:@selector(touchImage:)];
//		[self addGestureRecognizer:tap];
//		TT_RELEASE_SAFELY(tap);
        
    }
    return self;
}

- (EGOImageButton *)iconImageBtn
{
    if (!_iconImageBtn) {
        _iconImageBtn = [[EGOImageButton alloc] init];
        _iconImageBtn.backgroundColor = RGBCOLOR(248, 248, 248);
        CGRect frame = self.bounds;
        frame.size.height-=15;
        _iconImageBtn.frame = frame;
        _iconImageBtn.layer.cornerRadius = 5.0f;
        _iconImageBtn.layer.shadowColor = [UIColor lightTextColor].CGColor;
        _iconImageBtn.clipsToBounds = YES;
        [_iconImageBtn addTarget:self
                          action:@selector(touchBtn:)
                forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_iconImageBtn];
    }
    return _iconImageBtn;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

- (void)touchBtn:(UIButton *)btn
{
    if ( [_myDelegate respondsToSelector:@selector(topImageView:)] )
    {
        [_myDelegate topImageView:_secDto];
    }
}

-(void)setSecDto:(V2SecCategoryDTO *)secDto{
    
    
    if (secDto != _secDto) {
        
        _secDto = secDto;
        
        self.iconImageBtn.imageURL = [NSURL URLWithString:_secDto.categoryImageURL];
        _buttomLab.text = _secDto.categoryName;

    }
}

@end
