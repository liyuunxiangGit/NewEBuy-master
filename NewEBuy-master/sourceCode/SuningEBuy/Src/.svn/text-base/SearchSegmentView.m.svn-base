//
//  SearchSegmentView.m
//  SuningEBuy
//
//  Created by chupeng on 13-12-12.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "SearchSegmentView.h"
#import <QuartzCore/QuartzCore.h>
#import "SNGraphics.h"
#import <SSA_IOS/SSAIOSSNDataCollection.h>

#define kSearchSegmentButtonNomalColor          RGBCOLOR(238, 238, 238)
#define kSearchSegmentButtonHighlightColor      RGBCOLOR(146, 154, 168)

#define kLeftButtonNomalImage       @"search_normal_new.png"
#define kLeftButtonHightlightImage  @"search_fouce_left.png"

#define kMiddleButtonNomalImage      @"search_normal_new.png"
#define kMiddleButtonHightlightImage @"search_fouce_middle.png"

#define kRightButtonNomalImage      @"search_normal_new.png"
#define kRightButtonHightlightImage @"search_fouce_right.png"
#define arrawImage_leftPadding 16.5

@interface SearchSegmentView()
@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) UIButton *button2;
@property (nonatomic, strong) UIButton *button3;
@property (nonatomic, strong) UIButton *button4; //评价排序
@property (nonatomic, strong) UIImageView *lineView;

@property (nonatomic, strong) UIImageView *arrawImageView;


- (void)setButtonsBackground;

- (void)setImagesState;
@end


@implementation SearchSegmentView
@synthesize selectedSort = _selectedSort;
@synthesize delegate = _delegate;

@synthesize button1 = _button1;
@synthesize button2 = _button2;
@synthesize button3 = _button3;
@synthesize lineView = _lineView;
@synthesize arrawImageView = _arrawImageView;

- (void)dealloc {
    TT_RELEASE_SAFELY(_button1);
    TT_RELEASE_SAFELY(_button2);
    TT_RELEASE_SAFELY(_button3);
    TT_RELEASE_SAFELY(_arrawImageView);
    TT_RELEASE_SAFELY(_lineView);
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGBCOLOR(232, 232, 232);
//        UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:kLeftButtonNomalImage]];
//        image.frame = CGRectMake(0, 4, 320, 31);
//        image.backgroundColor = [UIColor clearColor];
//        image.userInteractionEnabled = YES;
//        [self addSubview:image];
        
        _selectedSort = SortTypeDefault;
        
        
        
        [self addSubview:self.button1];
        UIView *vSeplineV = [[UIView alloc] initWithFrame:CGRectMake(self.button1.frame.size.width, 25 / 2, 0.5, 15)];
        vSeplineV.backgroundColor = [UIColor colorWithRGBHex:0xdcdcdc];
        [self addSubview:vSeplineV];
        [self addSubview:self.button2];
        
        UIView *vSeplineV2 = [[UIView alloc] initWithFrame:CGRectMake(self.button2.frame.size.width + self.button2.origin.x, 25 / 2, 0.5, 15)];
        vSeplineV2.backgroundColor = [UIColor colorWithRGBHex:0xdcdcdc];
        [self addSubview:vSeplineV2];
        [self addSubview:self.button3];
        
        UIView *vSeplineV3 = [[UIView alloc] initWithFrame:CGRectMake(self.button3.frame.size.width + self.button3.origin.x, 25 / 2, 0.5, 15)];
        vSeplineV3.backgroundColor = [UIColor colorWithRGBHex:0xdcdcdc];
        [self addSubview:vSeplineV3];
        [self addSubview:self.button4];
        
        UIView *vBottomGrayLine = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, 320, 0.5)];
        vBottomGrayLine.backgroundColor = [UIColor colorWithRGBHex:0xdcdcdc];
        [self addSubview:vBottomGrayLine];
        
        [self bringSubviewToFront:vSeplineV];
        [self bringSubviewToFront:vSeplineV2];
        [self bringSubviewToFront:vSeplineV3];
        
        [self setButtonsBackground];
        [self setImagesState];
    }
    return self;
}

- (void)setSelectedSort:(SortType)selectedSort
{
    _selectedSort = selectedSort;
    [self setButtonsBackground];
    [self setImagesState];
}

-(void)collectionFun:(NSString*)aStr
{
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:aStr, nil]];
}
- (void)flowStat
{
    switch (_selectedSort) {
        case SortTypeDefault:
        {
            [self collectionFun:@"820201"];
            break;
        }
        case SortTypeSalevolume:
        {
            [self collectionFun:@"820202"];
            break;
        }
        case SortTypePriceUp:
        {
            [self collectionFun:@"820203"];
            break;
        }
        case SortTypePriceDown:
        {
            [self collectionFun:@"820204"];
            break;
        }
        case SortTypeEvaluate:
        {
            [self collectionFun:@"820205"];
            break;
        }
        default:
            break;
    }
}

#pragma mark -
#pragma mark action
//更改了sortType之后调用
- (void)didSelectSortType
{
    [self setButtonsBackground];
    [self setImagesState];
    [self flowStat];
    if (_delegate && [_delegate respondsToSelector:@selector(searchSegmentDidChangeSortType:)]) {
        [_delegate searchSegmentDidChangeSortType:_selectedSort];
    }
}

- (void)buttonPressed:(id)sender
{
    NSInteger index = [(UIButton *)sender tag];
    
    NSInteger selectIndex = _selectedSort / 2;// ? 2 : _selectedSort;
    
    if (index == selectIndex) {         //点击已经选择的按钮
        
        if (index == 2) {               //如果是点击价格，切换状态，其他的返回
            
            _selectedSort = ((_selectedSort == SortTypePriceUp) ? SortTypePriceDown : SortTypePriceUp);
            [self didSelectSortType];
            
            //        }else if(index == 1){
            //            _selectedSort = ((_selectedSort == SortTypeEvaluDown) ? SortTypeEvaluUp : SortTypeEvaluDown);
            //            [self didSelectSortType];
            //        }
        }
        else{
            return;
        }
        
    }else{
        
        _selectedSort = index * 2;
        [self didSelectSortType];
    }
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

#pragma mark -
#pragma mark layout views

- (void)setButtonsBackground
{
    for (int i = 0; i < 4; i++)
    {
        //        int buttonIndex = i>2 ? 2 : i;
        int selectIndex = _selectedSort / 2;
        
        if (selectIndex == 0) {
            [self.button1 setTitleColor:[UIColor btnTitleHotColor] forState:UIControlStateNormal];
            [self.button2 setTitleColor:[UIColor btnTitleNormalColor] forState:UIControlStateNormal];
            [self.button3 setTitleColor:[UIColor btnTitleNormalColor] forState:UIControlStateNormal];
            [self.button4 setTitleColor:[UIColor btnTitleNormalColor] forState:UIControlStateNormal];
            

            [UIView animateWithDuration:0.3 animations:^{
                self.lineView.frame = CGRectMake(0, 38.5, self.button1.frame.size.width, 1.5);
            }];
            
        }else if (selectIndex == 1){
            [self.button2 setTitleColor:[UIColor btnTitleHotColor] forState:UIControlStateNormal];
            [self.button1 setTitleColor:[UIColor btnTitleNormalColor] forState:UIControlStateNormal];
            [self.button3 setTitleColor:[UIColor btnTitleNormalColor] forState:UIControlStateNormal];
            [self.button4 setTitleColor:[UIColor btnTitleNormalColor] forState:UIControlStateNormal];
            
            [UIView animateWithDuration:0.3 animations:^{
                self.lineView.frame = CGRectMake(self.button2.origin.x, 38.5, self.button2.frame.size.width, 1.5);
            }];
        }else if (selectIndex == 2)
        {
            [self.button3 setTitleColor:[UIColor btnTitleHotColor] forState:UIControlStateNormal];
            [self.button1 setTitleColor:[UIColor btnTitleNormalColor] forState:UIControlStateNormal];
            [self.button2 setTitleColor:[UIColor btnTitleNormalColor] forState:UIControlStateNormal];
            [self.button4 setTitleColor:[UIColor btnTitleNormalColor] forState:UIControlStateNormal];
           
            [UIView animateWithDuration:0.3 animations:^{
                self.lineView.frame = CGRectMake(self.button3.origin.x, 38.5, self.button3.frame.size.width, 1.5);
            }];
        }
        else if (selectIndex == 3)
        {
            [self.button4 setTitleColor:[UIColor btnTitleHotColor] forState:UIControlStateNormal];
            [self.button1 setTitleColor:[UIColor btnTitleNormalColor] forState:UIControlStateNormal];
            [self.button2 setTitleColor:[UIColor btnTitleNormalColor] forState:UIControlStateNormal];
            [self.button3 setTitleColor:[UIColor btnTitleNormalColor] forState:UIControlStateNormal];
            
            [UIView animateWithDuration:0.3 animations:^{
                self.lineView.frame = CGRectMake(self.button4.origin.x, 38.5, self.button4.frame.size.width, 1.5);
            }];
        }
    }
}


- (void)setImagesState
{
    switch (_selectedSort) {
        case SortTypeDefault:
        {
            self.arrawImageView.hidden = YES;
            break;
        }
        case SortTypeSalevolume:
        {
            self.arrawImageView.hidden = NO;
            self.arrawImageView.frame = CGRectMake(160 - arrawImage_leftPadding, (40 - 6.5) / 2, 8.5, 6.5);
            self.arrawImageView.image = [UIImage imageNamed:@"SearchSegment_downArrowRed"];
            break;
        }
        case SortTypePriceUp:
        {
            self.arrawImageView.hidden = NO;
            self.arrawImageView.frame = CGRectMake(240 - arrawImage_leftPadding, (40 - 6.5) / 2, 8.5, 6.5);
            self.arrawImageView.image = [UIImage imageNamed:@"SearchSegment_upArrowRed"];
            break;
        }
        case SortTypePriceDown:
        {
            self.arrawImageView.hidden = NO;
            self.arrawImageView.frame = CGRectMake(240 - arrawImage_leftPadding, (40 - 6.5) / 2, 8.5, 6.5);
            self.arrawImageView.image = [UIImage imageNamed:@"SearchSegment_downArrowRed"];
            break;
        }
        case SortTypeEvaluate:
        {
            self.arrawImageView.hidden = NO;
            self.arrawImageView.frame = CGRectMake(320 - arrawImage_leftPadding, (40 - 6.5) / 2, 8.5, 6.5);
            self.arrawImageView.image = [UIImage imageNamed:@"SearchSegment_downArrowRed"];
            break;
        }
            //        case SortTypeEvaluUp:
            //        {
            //            self.arrawImageView.hidden = NO;
            //            self.arrawImageView.frame = CGRectMake(179 + 179 - 285, 8.5+4, 8, 14);
            //            self.arrawImageView.image = [UIImage imageNamed:@"search_upArrow.png"];
            //            break;
            //        }
            //        case SortTypeEvaluDown:
            //        {
            //            self.arrawImageView.hidden = NO;
            //            self.arrawImageView.frame = CGRectMake(179 + 179 - 285, 8.5+4, 8, 14);
            //            self.arrawImageView.image = [UIImage imageNamed:@"search_downArrow.png"];
            //            break;
            //        }
            
        default:
            break;
    }
}


#pragma mark -
#pragma mark subviews

- (UIButton *)button1
{
    if (!_button1)
    {
        _button1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
        
        _button1.backgroundColor = [UIColor clearColor];
        
        _button1.titleLabel.font = [UIFont systemFontOfSize:14.0];
        //        _button1.layer.borderColor = [UIColor lightGrayColor].CGColor;
        //        _button1.layer.borderWidth = 1;
        [_button1 setTitle:L(@"BTComprehensive") forState:UIControlStateNormal];
        [_button1 setTitleColor:RGBCOLOR(139, 139, 139) forState:UIControlStateNormal];
        _button1.tag = 0;
        
        
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
        _button2 = [[UIButton alloc] initWithFrame:CGRectMake(80, 0, 80, 40)];
        
        _button2.backgroundColor = [UIColor clearColor];
        
        _button2.titleLabel.font = [UIFont systemFontOfSize:14.0];
        //        _button2.layer.borderColor = [UIColor lightGrayColor].CGColor;
        //        _button2.layer.borderWidth = 1;
        [_button2 setTitle:L(@"SalesVolume") forState:UIControlStateNormal];
        [_button2 setTitleColor:RGBCOLOR(139, 139, 139) forState:UIControlStateNormal];
        _button2.tag = 1;
        
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
        _button3 = [[UIButton alloc] initWithFrame:CGRectMake(160, 0, 80, 40)];
        
        _button3.backgroundColor = [UIColor clearColor];
        
        _button3.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [_button3 setTitle:L(@"price") forState:UIControlStateNormal];
        [_button3 setTitleColor:RGBCOLOR(139, 139, 139) forState:UIControlStateNormal];
        _button3.tag = 2;
        
        [_button3 addTarget:self
                     action:@selector(buttonPressed:)
           forControlEvents:UIControlEventTouchUpInside];
        
        [_button3 setBackgroundColor:[UIColor whiteColor]];
        
    }
    return _button3;
}

- (UIButton *)button4
{
    if (!_button4)
    {
        _button4 = [[UIButton alloc] initWithFrame:CGRectMake(240, 0, 80, 40)];
        _button4.backgroundColor = [UIColor clearColor];
        _button4.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [_button4 setTitle:L(@"Evaluation") forState:UIControlStateNormal];
        [_button4 setTitleColor:RGBCOLOR(139, 139, 139) forState:UIControlStateNormal];
        _button4.tag = 3;
        
        [_button4 addTarget:self
                     action:@selector(buttonPressed:)
           forControlEvents:UIControlEventTouchUpInside];
        
        [_button4 setBackgroundColor:[UIColor whiteColor]];
    }
    return _button4;
}

- (UIImageView *)arrawImageView
{
    if (!_arrawImageView)
    {
        _arrawImageView = [[UIImageView alloc] init];
        
        _arrawImageView.hidden = YES;
        
        [self addSubview:_arrawImageView];
    }
    return _arrawImageView;
}


@end
