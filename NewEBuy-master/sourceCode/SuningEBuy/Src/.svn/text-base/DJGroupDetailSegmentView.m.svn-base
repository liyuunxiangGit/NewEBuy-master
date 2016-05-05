//
//  DJGroupDetailSegmentView.m
//  SuningEBuy
//
//  Created by xie wei on 13-7-11.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "DJGroupDetailSegmentView.h"

#define kLeftButtonNomalImage       @"DJ_Detail_Segment_Left.png"
#define kLeftButtonHightlightImage  @"search_fouce.png"

#define kMiddleButtonNomalImage      @"DJ_Detail_Segment_Middle.png"
#define kMiddleButtonHightlightImage @"search_fouce.png"

#define kRightButtonNomalImage      @"DJ_Detail_Segment_Right.png"
#define kRightButtonHightlightImage @"search_fouce.png"

#define kLineImage                  @"search_line.png"

@implementation DJGroupDetailSegmentView

@synthesize selectIndex = selectIndex_;
@synthesize leftButton = _leftButton;
@synthesize middleButton=_middleButton;
@synthesize segmentBackView = _segmentBackView;
@synthesize rightButton = _rightButton;
@synthesize delegate = _delegate;

- (void)dealloc {
    TT_RELEASE_SAFELY(_leftButton);
    TT_RELEASE_SAFELY(_middleButton); 
    TT_RELEASE_SAFELY(_rightButton);
    TT_RELEASE_SAFELY(_segmentBackView);
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (id)init {
    self = [super initWithFrame:CGRectMake(0, 4, 320, 31)];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectIndex = 0;
        
        self.leftButton.selected = YES;
        
        [self addSubview:self.segmentBackView];
        
        [self addSubview:self.leftButton];
        [self addSubview:self.middleButton];
        [self addSubview:self.rightButton];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changekAppraisalCount:) name:kAppraisalCount object:nil];
    }
    return self;
}

- (void)changekAppraisalCount:(NSNotification *)notification
{
    double appCount = [notification.object doubleValue];
    
    [self.rightButton setTitle:[NSString stringWithFormat:@"%@(%.0f)",L(@"Comment"),appCount] forState:UIControlStateNormal];
    [self.rightButton setTitle:[NSString stringWithFormat:@"%@(%.0f)",L(@"Comment"),appCount] forState:UIControlStateSelected];
}

- (void)changekAppCount:(NSString *)count
{
    [self.rightButton setTitle:[NSString stringWithFormat:@"%@(%@)",L(@"Comment"),count] forState:UIControlStateNormal];
    [self.rightButton setTitle:[NSString stringWithFormat:@"%@(%@)",L(@"Comment"),count] forState:UIControlStateSelected];
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
        _leftButton.frame = CGRectMake(0, 0, 107, 31);
        [_leftButton setBackgroundImage:[UIImage imageNamed:kLeftButtonNomalImage]
                               forState:UIControlStateSelected];
        [_leftButton addTarget:self
                        action:@selector(buttonTapped:)
              forControlEvents:UIControlEventTouchUpInside];
        _leftButton.tag = 0;
        [_leftButton setTitle:L(@"DJ_Good_BaseInfo") forState:UIControlStateNormal];
        [_leftButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        _leftButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
    }
    return _leftButton;
}

- (UIButton *)middleButton
{
    if (!_middleButton) {
        _middleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _middleButton.frame = CGRectMake(102, 0, 113, 31);
        [_middleButton setBackgroundImage:[UIImage imageNamed:kRightButtonNomalImage]
                                 forState:UIControlStateSelected];
        [_middleButton addTarget:self
                          action:@selector(buttonTapped:)
                forControlEvents:UIControlEventTouchUpInside];
        _middleButton.tag = 1;
        [_middleButton setTitle:L(@"DJ_Good_IntroduceInfo") forState:UIControlStateNormal];
        [_middleButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_middleButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        _middleButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
        
        UIImageView *leftLineImg = [[UIImageView alloc] initWithFrame:CGRectMake(1, 1, 1, 28)];
        leftLineImg.backgroundColor = [UIColor clearColor];
        leftLineImg.image = [UIImage imageNamed:@"DJ_Detail_Segment_Separtor.png"];
        [_middleButton addSubview:leftLineImg];
        TT_RELEASE_SAFELY(leftLineImg);
    }
    return _middleButton;
}

- (UIButton *)rightButton
{
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.frame = CGRectMake(214, 0, 106, 31);
        [_rightButton setBackgroundImage:[UIImage imageNamed:kRightButtonNomalImage]
                                forState:UIControlStateSelected];
        [_rightButton addTarget:self
                         action:@selector(buttonTapped:)
               forControlEvents:UIControlEventTouchUpInside];
        _rightButton.tag = 2;
        [_rightButton setTitle:L(@"DJ_Good_EstimateInfo") forState:UIControlStateNormal];
        [_rightButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        _rightButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
        
        UIImageView *lineImg = [[UIImageView alloc] initWithFrame:CGRectMake(2, 1, 1, 28)];
        lineImg.backgroundColor = [UIColor clearColor];
        lineImg.image = [UIImage imageNamed:@"DJ_Detail_Segment_Separtor.png"];
        [_rightButton addSubview:lineImg];
        TT_RELEASE_SAFELY(lineImg);
    }
    return _rightButton;
}

- (UIImageView *)segmentBackView
{
    if (!_segmentBackView) {
        _segmentBackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 31)];
        _segmentBackView.backgroundColor = [UIColor clearColor];
        _segmentBackView.image = [UIImage imageNamed:@"DJ_Detail_Segment_Back.png"];
    }
    return _segmentBackView;
}

- (void)refreshButtons
{
    if (selectIndex_ == 0) {
        self.leftButton.selected = YES;
        self.middleButton.selected = NO;
        self.rightButton.selected = NO;
    }else if (selectIndex_ == 1){
        self.leftButton.selected = NO;
        self.middleButton.selected = YES;
        self.rightButton.selected = NO;
    }else{
        self.leftButton.selected = NO;
        self.middleButton.selected = NO;
        self.rightButton.selected = YES;
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
    
    if ([self.delegate conformsToProtocol:@protocol(DJGroupDetailSegmentViewDelegate)])
    {
        if ([self.delegate respondsToSelector:@selector(didSelectSegmentAtIndex:)])
        {
            [self.delegate didSelectSegmentAtIndex:index];
        }
    }
}


@end

