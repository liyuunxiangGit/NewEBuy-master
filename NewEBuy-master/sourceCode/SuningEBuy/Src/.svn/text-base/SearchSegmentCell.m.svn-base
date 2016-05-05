//
//  SearchSegmentCell.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-8-30.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "SearchSegmentCell.h"

#define kSearchSegmentButtonNomalColor          RGBCOLOR(238, 238, 238)
#define kSearchSegmentButtonHighlightColor      RGBCOLOR(146, 154, 168)

#define kLeftButtonNomalImage       @"search_normal_new.png"
#define kLeftButtonHightlightImage  @"search_fouce_left.png"

#define kMiddleButtonNomalImage      @"search_normal_new.png"
#define kMiddleButtonHightlightImage @"search_fouce_middle.png"

#define kRightButtonNomalImage      @"search_normal_new.png"
#define kRightButtonHightlightImage @"search_fouce_right.png"

@interface SearchSegmentCell()

@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) UIButton *button2;
@property (nonatomic, strong) UIButton *button3;
@property (nonatomic, strong) UIImageView *lineView;

@property (nonatomic, strong) UIImageView *arrawImageView;


- (void)setButtonsBackground;

- (void)setImagesState;

@end

/*********************************************************************/

@implementation SearchSegmentCell

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

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = RGBCOLOR(239, 234, 215);
        UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:kLeftButtonNomalImage]];
        image.frame = CGRectMake(0, 4, 320, 31);
        image.backgroundColor = [UIColor clearColor];
        image.userInteractionEnabled = YES;
        [self.contentView addSubview:image];
        
        _selectedSort = SortTypeDefault;
        
        [self.contentView addSubview:self.button1];
        [self.contentView addSubview:self.button2];
        [self.contentView addSubview:self.button3];
        
        [self setButtonsBackground];
        
        [self setImagesState];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setSelectedSort:(SortType)selectedSort
{
    _selectedSort = selectedSort;
    [self setButtonsBackground];
    [self setImagesState];
}

#pragma mark -
#pragma mark action

//更改了sortType之后调用
- (void)didSelectSortType
{
    [self setButtonsBackground];
    [self setImagesState];
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
        _lineView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search_line.png"]];
        _lineView.backgroundColor = [UIColor clearColor];
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
        
//        NSString *selecter = [NSString stringWithFormat:@"button%d", buttonIndex+1];
//        UIButton *button = [self performSelector:NSSelectorFromString(selecter)];
        
//        if (selectIndex == buttonIndex) {
////            button.backgroundColor = kSearchSegmentButtonHighlightColor;
//            [button setBackgroundImage:[UIImage imageNamed:kButtonHightlightImage]
//                                       forState:UIControlStateNormal];
//            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        }
//        else
//        {
////            button.backgroundColor = kSearchSegmentButtonNomalColor;
//            [button setBackgroundImage:[UIImage imageNamed:kButtonNomalImage] forState:UIControlStateNormal];
//            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        }
        if (selectIndex == 0) {
            [self.button1 setBackgroundImage:[UIImage imageNamed:kLeftButtonHightlightImage]
                                       forState:UIControlStateNormal];
            [self.button1 setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
            [self.button2 setBackgroundImage:nil
                                         forState:UIControlStateNormal];
            [self.button2 setTitleColor:RGBCOLOR(138, 128, 112) forState:UIControlStateNormal];
            [self.button3 setBackgroundImage:nil
                                        forState:UIControlStateNormal];
            [self.button3 setTitleColor:[UIColor lightTextColor] forState:UIControlStateNormal];
            self.lineView.frame = CGRectMake(self.button2.right, 4, 1, 31);
            
        }else if (selectIndex == 1){
            [self.button1 setTitleColor:[UIColor lightTextColor] forState:UIControlStateNormal];
            [self.button2 setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
            [self.button3 setTitleColor:[UIColor lightTextColor] forState:UIControlStateNormal];
            [self.button1 setBackgroundImage:nil
                                       forState:UIControlStateNormal];
            [self.button2 setBackgroundImage:[UIImage imageNamed:kMiddleButtonHightlightImage]
                                         forState:UIControlStateNormal];
            [self.button3 setBackgroundImage:nil
                                        forState:UIControlStateNormal];
            self.lineView.frame = CGRectMake(self.button3.right, 4, 1, 31);
            
        }else{
            [self.button1 setTitleColor:[UIColor lightTextColor] forState:UIControlStateNormal];
            [self.button2 setTitleColor:[UIColor lightTextColor] forState:UIControlStateNormal];
            [self.button3 setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
            
            [self.button1 setBackgroundImage:nil
                                       forState:UIControlStateNormal];
            [self.button2 setBackgroundImage:nil
                                         forState:UIControlStateNormal];
            [self.button3 setBackgroundImage:[UIImage imageNamed:kRightButtonHightlightImage]
                                        forState:UIControlStateNormal];
            self.lineView.frame = CGRectMake(self.button1.right, 4, 1, 31);
            
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
            self.arrawImageView.frame = CGRectMake(179, 8.5+4, 8, 14);
            self.arrawImageView.image = [UIImage imageNamed:@"search_downArrow.png"];
            break;
        }
        case SortTypePriceUp:
        {
            self.arrawImageView.hidden = NO;
            self.arrawImageView.frame = CGRectMake(285, 8.5+4, 8, 14);
            self.arrawImageView.image = [UIImage imageNamed:@"search_upArrow.png"];
            break;
        }
        case SortTypePriceDown:
        {
            self.arrawImageView.hidden = NO;
            self.arrawImageView.frame = CGRectMake(285, 8.5+4, 8, 14);
            self.arrawImageView.image = [UIImage imageNamed:@"search_downArrow.png"];
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
        _button1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 4, 107, 32.5)];
        
        _button1.backgroundColor = [UIColor clearColor];
        
        _button1.titleLabel.font = [UIFont systemFontOfSize:14.0];        
//        _button1.layer.borderColor = [UIColor lightGrayColor].CGColor;
//        _button1.layer.borderWidth = 1;
        [_button1 setTitle:L(@"Default") forState:UIControlStateNormal];
        [_button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _button1.tag = 0;
        
        [_button1 addTarget:self
                     action:@selector(buttonPressed:) 
           forControlEvents:UIControlEventTouchUpInside];
    }
    return _button1;
}

- (UIButton *)button2
{
    if (!_button2)
    {
        _button2 = [[UIButton alloc] initWithFrame:CGRectMake(108, 4, 107, 32.5)];
        
        _button2.backgroundColor = [UIColor clearColor];
        
        _button2.titleLabel.font = [UIFont systemFontOfSize:14.0];        
//        _button2.layer.borderColor = [UIColor lightGrayColor].CGColor;
//        _button2.layer.borderWidth = 1;
        [_button2 setTitle:L(@"SalesVolume") forState:UIControlStateNormal];
        [_button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _button2.tag = 1;
        
        [_button2 addTarget:self
                     action:@selector(buttonPressed:)
           forControlEvents:UIControlEventTouchUpInside];
    }
    return _button2;
}

- (UIButton *)button3
{
    if (!_button3)
    {
        _button3 = [[UIButton alloc] initWithFrame:CGRectMake(215, 4, 107, 32.5)];
        
        _button3.backgroundColor = [UIColor clearColor];
        
        _button3.titleLabel.font = [UIFont systemFontOfSize:14.0];        
//        _button3.layer.borderColor = [UIColor lightGrayColor].CGColor;
//        _button3.layer.borderWidth = 1;
        [_button3 setTitle:L(@"price") forState:UIControlStateNormal];
        [_button3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _button3.tag = 2;
        
        [_button3 addTarget:self
                     action:@selector(buttonPressed:) 
           forControlEvents:UIControlEventTouchUpInside];
    }
    return _button3;
}

- (UIImageView *)arrawImageView
{
    if (!_arrawImageView)
    {
        _arrawImageView = [[UIImageView alloc] init];
                
        _arrawImageView.hidden = YES;
                
        [self.contentView addSubview:_arrawImageView];
    }
    return _arrawImageView;
}


@end
