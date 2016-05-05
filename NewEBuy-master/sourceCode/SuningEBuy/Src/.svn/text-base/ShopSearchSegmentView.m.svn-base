//
//  ShopSearchSegmentView.m
//  SuningEBuy
//
//  Created by chupeng on 14-7-16.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "ShopSearchSegmentView.h"
#import <QuartzCore/QuartzCore.h>
#import "SNGraphics.h"
#import <SSA_IOS/SSAIOSSNDataCollection.h>

@interface ShopSearchSegmentView()
- (void)setButtonsBackground;
- (void)setImagesState;
@end

@implementation ShopSearchSegmentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        _selectedSort = 0;
        
        [self addSubview:self.button1];
        
        UIView *vSeplineV = [[UIView alloc] initWithFrame:CGRectMake(self.button1.frame.size.width, 25 / 2, 0.5, 15)];
        vSeplineV.backgroundColor = [UIColor colorWithRGBHex:0xdcdcdc];
        [self addSubview:vSeplineV];
        
        [self addSubview:self.button2];
        
        UIView *vSeplineV2 = [[UIView alloc] initWithFrame:CGRectMake(self.button2.frame.size.width + self.button2.origin.x, 25 / 2, 0.5, 15)];
        vSeplineV2.backgroundColor = [UIColor colorWithRGBHex:0xdcdcdc];
        [self addSubview:vSeplineV2];
        
        [self addSubview:self.button3];
        
        //分隔按钮的线
        [self bringSubviewToFront:vSeplineV];
        [self bringSubviewToFront:vSeplineV2];
        
        //底部分隔线
        UIView *vBottomGrayLine = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, 320, 0.5)];
        vBottomGrayLine.backgroundColor = [UIColor colorWithRGBHex:0xdcdcdc];
        
        [self addSubview:vBottomGrayLine];
        
        [self setButtonsBackground];
        [self setImagesState];
    }
    return self;
}

- (void)setSelectedSort:(int)selectedSort
{
    _selectedSort = selectedSort;
    [self setButtonsBackground];
    [self setImagesState];
}

#pragma mark - 控件
- (UIButton *)button1
{
    if (!_button1)
    {
        _button1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 106, 40)];
        
        _button1.backgroundColor = [UIColor clearColor];
        
        _button1.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [_button1 setTitle:L(@"BTComprehensive") forState:UIControlStateNormal];
        [_button1 setTitleColor:RGBCOLOR(139, 139, 139) forState:UIControlStateNormal];
        _button1.tag = 100;
        
        
        [_button1 addTarget:self
                     action:@selector(buttonPressed:)
           forControlEvents:UIControlEventTouchUpInside];
        
        [_button1 setBackgroundColor:[UIColor whiteColor]];
    }
    return _button1;
}

- (UIButton *)button2
{
    if (!_button2)
    {
        _button2 = [[UIButton alloc] initWithFrame:CGRectMake(106, 0, 107, 40)];
        
        _button2.backgroundColor = [UIColor clearColor];
        
        _button2.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [_button2 setTitle:L(@"SalesVolume") forState:UIControlStateNormal];
        [_button2 setTitleColor:RGBCOLOR(139, 139, 139) forState:UIControlStateNormal];
        _button2.tag = 101;
        
        [_button2 addTarget:self
                     action:@selector(buttonPressed:)
           forControlEvents:UIControlEventTouchUpInside];
        
        [_button2 setBackgroundColor:[UIColor whiteColor]];
        
    }
    return _button2;
}

- (UIButton *)button3
{
    if (!_button3)
    {
        _button3 = [[UIButton alloc] initWithFrame:CGRectMake(213, 0, 107, 40)];
        
        _button3.backgroundColor = [UIColor clearColor];
        
        _button3.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [_button3 setTitle:L(@"Evaluate") forState:UIControlStateNormal];
        [_button3 setTitleColor:RGBCOLOR(139, 139, 139) forState:UIControlStateNormal];
        _button3.tag = 102;
        
        [_button3 addTarget:self
                     action:@selector(buttonPressed:)
           forControlEvents:UIControlEventTouchUpInside];
        
        [_button3 setBackgroundColor:[UIColor whiteColor]];
        
    }
    return _button3;
}

- (UIImageView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 38.5, 106, 1.5)];
        _lineView.backgroundColor = RGBCOLOR(252, 124, 38);
        [self addSubview:_lineView];
    }
    return _lineView;
}

- (UIImageView *)arrawImageView
{
    if (!_arrawImageView)
    {
        _arrawImageView = [[UIImageView alloc] init];
        
        _arrawImageView.hidden = YES;
        
        _arrawImageView.image = [UIImage imageNamed:@"SearchSegment_downArrowRed"];
        
        [self addSubview:_arrawImageView];
    }
    return _arrawImageView;
}


- (void)buttonPressed:(id)sender
{
    NSInteger index = [(UIButton *)sender tag];
    index -= 100;
    if (index != _selectedSort)
    {
        _selectedSort = index;
        [self didSelectSortType];
        
    }
}

- (void)didSelectSortType
{
    [self setButtonsBackground];
    [self setImagesState];
//    [self flowStat];
    if (_delegate && [_delegate respondsToSelector:@selector(searchSegmentDidChangeSortType:)]) {
        [_delegate searchSegmentDidChangeSortType:_selectedSort];
    }
}

- (void)setButtonsBackground
{
    for (int i = 0; i < 3; i++)
    {
        int selectIndex = _selectedSort;
        
        if (selectIndex == 0) {
            [self.button1 setTitleColor:[UIColor btnTitleHotColor] forState:UIControlStateNormal];
            [self.button2 setTitleColor:[UIColor btnTitleNormalColor] forState:UIControlStateNormal];
            [self.button3 setTitleColor:[UIColor btnTitleNormalColor] forState:UIControlStateNormal];
            
            [UIView animateWithDuration:0.3 animations:^{
                self.lineView.frame = CGRectMake(0, 38.5, self.button1.frame.size.width, 1.5);
            }];
            
        }else if (selectIndex == 1){
            [self.button2 setTitleColor:[UIColor btnTitleHotColor] forState:UIControlStateNormal];
            [self.button1 setTitleColor:[UIColor btnTitleNormalColor] forState:UIControlStateNormal];
            [self.button3 setTitleColor:[UIColor btnTitleNormalColor] forState:UIControlStateNormal];
         
            [UIView animateWithDuration:0.3 animations:^{
                self.lineView.frame = CGRectMake(self.button2.origin.x, 38.5, self.button2.frame.size.width, 1.5);
            }];
        }else if (selectIndex == 2)
        {
            [self.button3 setTitleColor:[UIColor btnTitleHotColor] forState:UIControlStateNormal];
            [self.button1 setTitleColor:[UIColor btnTitleNormalColor] forState:UIControlStateNormal];
            [self.button2 setTitleColor:[UIColor btnTitleNormalColor] forState:UIControlStateNormal];
          
            [UIView animateWithDuration:0.3 animations:^{
                self.lineView.frame = CGRectMake(self.button3.origin.x, 38.5, self.button3.frame.size.width, 1.5);
            }];
        }
    }
}
#define arrawImage_leftPadding 16.5
- (void)setImagesState
{
    switch (_selectedSort) {
        case 0:
        {
            self.arrawImageView.hidden = YES;
            break;
        }
        case 1:
        {
            self.arrawImageView.hidden = NO;
            self.arrawImageView.frame = CGRectMake(213 - arrawImage_leftPadding, (40 - 6.5) / 2, 8.5, 6.5);
            self.arrawImageView.image = [UIImage imageNamed:@"SearchSegment_downArrowRed"];
            break;
        }
        case 2:
        {
            self.arrawImageView.hidden = NO;
            self.arrawImageView.frame = CGRectMake(320 - arrawImage_leftPadding, (40 - 6.5) / 2, 8.5, 6.5);
            self.arrawImageView.image = [UIImage imageNamed:@"SearchSegment_downArrowRed"];

            break;
        }
        default:
            break;
    }
}
@end
