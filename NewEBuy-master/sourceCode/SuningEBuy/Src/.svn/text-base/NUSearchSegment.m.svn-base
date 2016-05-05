//
//  NUSearchSegment.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-4-16.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "NUSearchSegment.h"

#define kLeftButtonNomalImage       @"search_normal_new.png"
#define kLeftButtonHightlightImage  @"search_fouce_left.png"

#define kMiddleButtonNomalImage      @"search_normal_new.png"
#define kMiddleButtonHightlightImage @"search_fouce_middle.png"

#define kRightButtonNomalImage      @"search_normal_new.png"
#define kRightButtonHightlightImage @"search_fouce_right.png"

#define  kLineImage                  @"search_line.png"

@implementation NUSearchSegment

@synthesize selectIndex = selectIndex_;
@synthesize leftButton = _leftButton;
@synthesize rightButton = _rightButton;
@synthesize middleButton=_middleButton; //add by wangjiaxing 20130516
@synthesize lineView    = _lineView;

@synthesize delegate = _delegate;

- (void)dealloc {
    TT_RELEASE_SAFELY(_leftButton);
    TT_RELEASE_SAFELY(_rightButton);
    TT_RELEASE_SAFELY(_middleButton); //add by wangjiaxing 20130516
    TT_RELEASE_SAFELY(_lineView);
}

- (id)init {
    self = [super initWithFrame:CGRectMake(0, 0, 320, 31)];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageNamed:kRightButtonNomalImage];
        [self addSubview:self.leftButton];
        [self addSubview:self.middleButton];//add by wangjiaxing 20130516        
        [self addSubview:self.rightButton];
        self.lineView.frame = CGRectMake(self.middleButton.right, 0, 1, 31);
        self.selectIndex = 0;
    }
    return self;
}

- (void)setSelectIndex:(NSInteger)selectIndex
{
    if (selectIndex != selectIndex_) {
        selectIndex_ = selectIndex;
        [self refreshButtons];
    }
}

- (UIButton *)leftButton
{
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.frame = CGRectMake(0, 0, 107, 32.5);
        [_leftButton setBackgroundImage:[UIImage imageNamed:kLeftButtonHightlightImage]
                               forState:UIControlStateNormal];
        [_leftButton addTarget:self
                        action:@selector(buttonTapped:) 
              forControlEvents:UIControlEventTouchUpInside];
        _leftButton.tag = 0;
        [_leftButton setTitle:L(@"Hot_Search") forState:UIControlStateNormal];
        [_leftButton setTitleColor:[UIColor colorWithRGBHex:0x444444] forState:UIControlStateNormal];
        _leftButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
        
    }
    return _leftButton;
}

- (UIButton *)middleButton
{
    if (!_middleButton) {
        _middleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _middleButton.frame = CGRectMake(107, 0, 107, 32.5);
        [_middleButton setBackgroundImage:nil
                                 forState:UIControlStateNormal];
        [_middleButton addTarget:self
                          action:@selector(buttonTapped:)
                forControlEvents:UIControlEventTouchUpInside];
        _middleButton.tag = 1;
        [_middleButton setTitle:L(@"Search_History") forState:UIControlStateNormal];
        [_middleButton setTitleColor:RGBCOLOR(138, 128, 112) forState:UIControlStateNormal];

        _middleButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
        
    }
    return _middleButton;
}

- (UIButton *)rightButton
{
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.frame = CGRectMake(214, 0, 106, 32.5);
        [_rightButton setBackgroundImage:nil
                                forState:UIControlStateNormal];
        [_rightButton addTarget:self
                         action:@selector(buttonTapped:) 
               forControlEvents:UIControlEventTouchUpInside];
        _rightButton.tag = 2;
        [_rightButton setTitle:L(@"Scan_History") forState:UIControlStateNormal];
        [_rightButton setTitleColor:RGBCOLOR(138, 128, 112) forState:UIControlStateNormal];

        _rightButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];

    }
    return _rightButton;
}

- (UIImageView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:kLineImage]];
        _lineView.backgroundColor = [UIColor clearColor];
        [self addSubview:_lineView];
    }
    return _lineView;
}

- (void)refreshButtons
{
    if (selectIndex_ == 0) {
        [self.leftButton setBackgroundImage:[UIImage imageNamed:kLeftButtonHightlightImage] 
                                   forState:UIControlStateNormal];
        [self.leftButton setTitleColor:[UIColor colorWithRGBHex:0x444444] forState:UIControlStateNormal];
        [self.middleButton setBackgroundImage:nil
                                    forState:UIControlStateNormal];
        [self.middleButton setTitleColor:RGBCOLOR(138, 128, 112) forState:UIControlStateNormal];
        [self.rightButton setBackgroundImage:nil
                                    forState:UIControlStateNormal];
        [self.rightButton setTitleColor:RGBCOLOR(138, 128, 112) forState:UIControlStateNormal];
        self.lineView.frame = CGRectMake(self.middleButton.right, 0, 1, 31);

    }else if (selectIndex_ == 1){
        [self.leftButton setTitleColor:RGBCOLOR(138, 128, 112) forState:UIControlStateNormal];
        [self.middleButton setTitleColor:[UIColor colorWithRGBHex:0x444444] forState:UIControlStateNormal];
        [self.rightButton setTitleColor:RGBCOLOR(138, 128, 112) forState:UIControlStateNormal];
        [self.leftButton setBackgroundImage:nil
                                   forState:UIControlStateNormal];
        [self.middleButton setBackgroundImage:[UIImage imageNamed:kMiddleButtonHightlightImage]
                                     forState:UIControlStateNormal];
        [self.rightButton setBackgroundImage:nil
                                    forState:UIControlStateNormal];
        self.lineView.frame = CGRectMake(self.rightButton.right, 0, 1, 31);

    }else{
        [self.leftButton setTitleColor:RGBCOLOR(138, 128, 112) forState:UIControlStateNormal];
        [self.middleButton setTitleColor:RGBCOLOR(138, 128, 112) forState:UIControlStateNormal];
        [self.rightButton setTitleColor:[UIColor colorWithRGBHex:0x444444] forState:UIControlStateNormal];

        [self.leftButton setBackgroundImage:nil
                                   forState:UIControlStateNormal];
        [self.middleButton setBackgroundImage:nil
                                     forState:UIControlStateNormal];
        [self.rightButton setBackgroundImage:[UIImage imageNamed:kRightButtonHightlightImage]
                                    forState:UIControlStateNormal];
        self.lineView.frame = CGRectMake(self.leftButton.right, 0, 1, 31);

    }
}

- (void)buttonTapped:(id)sender
{
    UIButton *button = (UIButton *)sender;
    
    NSInteger index = button.tag;
    
    if (self.selectIndex == index) {
        return;
    }
    self.selectIndex = index;
    
    [self refreshButtons];

    if ([self.delegate conformsToProtocol:@protocol(NUSearchSegmentDelegate)])
    {
        if ([self.delegate respondsToSelector:@selector(didSelectSegmentAtIndex:)])
        {
            [self.delegate didSelectSegmentAtIndex:index];
        }
    }
}
@end
