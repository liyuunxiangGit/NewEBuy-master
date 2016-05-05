//
//  DJGroupRuleViewController.m
//  SuningEBuy
//
//  Created by xie wei on 13-7-10.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "DJGroupRuleView.h"

@interface DJGroupRuleView ()

@property (nonatomic, strong) UIControl    *blackMask;
@property (nonatomic, strong) UIView       *contentView;
//@property (nonatomic, strong) UIImageView  *titleImageView;
@property (nonatomic, strong) UILabel      *titleLabel;
@property (nonatomic, strong) UIButton     *closeButton;
@property (nonatomic, strong) UITextView   *groupTipsTextView;

@property (nonatomic, strong) UIImageView  *line;

@property (nonatomic, strong) NSString     *title;
@property (nonatomic, strong) NSString     *text;

@end


@implementation DJGroupRuleView

- (void)dealloc
{
    _groupTipsTextView.delegate = nil;
}

//- (id)initWithFrame:(CGRect)frame{
//    
//    self = [super initWithFrame:frame];
//    
//    if (self)
//    {
//        CGRect bounds = self.bounds;
//        self.blackMask.frame = bounds;
//        [self addSubview:self.blackMask];
//        
//        self.contentView.frame = CGRectMake(0, bounds.size.height, self.contentView.width, self.contentView.height);
//        [self addSubview:self.contentView];
//
//    }
//    
//    return self;
//}

- (id)initWithFrame:(CGRect)frame andTitle:(NSString *)title andText:(NSString *)text
{
    self = [super init];
    
    if (self)
    {
        self.frame = frame;
        CGRect bounds = frame;
        self.blackMask.frame = bounds;
        [self addSubview:self.blackMask];
        
        self.contentView.frame = CGRectMake(0, bounds.size.height, self.contentView.width, self.contentView.height);
        [self addSubview:self.contentView];
        
        self.title =title;
        self.text =text;
        
    }
    
    return self;
}

#pragma mark ----------------------------- view lifecycle

- (void)showInView:(UIView *)view
{
    [self loadData];
    [view addSubview:self];
    [self beginAnimation];
}


- (void)hide
{
    [UIView animateWithDuration:0.4
                          delay:0.
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         self.contentView.top = self.frame.size.height;

                     } completion:^(BOOL finished) {
                         
                         [self removeFromSuperview];
                     }];
}

- (void)loadData
{
    self.titleLabel.text = self.title;
    
    self.groupTipsTextView.text = self.text;
}

- (void)beginAnimation
{
    [UIView animateWithDuration:0.4
                          delay:0.
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         self.contentView.top = self.frame.size.height - self.contentView.height;
                         
                     } completion:^(BOOL finished) {
                         
                         
                     }];
}

#pragma mark ----------------------------- views

- (UIControl *)blackMask
{
    if (!_blackMask) {
        _blackMask = [[UIControl alloc] init];
        _blackMask.frame = self.bounds;
        _blackMask.backgroundColor = RGBACOLOR(0, 0, 0, 0.5);
        [_blackMask addTarget:self
                       action:@selector(hide)
             forControlEvents:UIControlEventTouchUpInside];
    }
    return _blackMask;
}

- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.frame = CGRectMake(0, 0, 320, 320);
        _contentView.backgroundColor =[UIColor uiviewBackGroundColor];
        
        [_contentView addSubview:self.groupTipsTextView];
//        [_contentView addSubview:self.titleImageView];
        [_contentView addSubview:self.titleLabel];
        [_contentView addSubview:self.line];
        [_contentView addSubview:self.closeButton];
    }
    return _contentView;
}

//- (UIImageView *)titleImageView
//{
//    if (!_titleImageView) {
//        _titleImageView = [[UIImageView alloc] init];
//        _titleImageView.frame = CGRectMake(0, 0, 320, 40);
//        _titleImageView.backgroundColor = [UIColor clearColor];
//        _titleImageView.contentMode = UIViewContentModeScaleToFill;
//        _titleImageView.backgroundColor = RGBCOLOR(242, 238, 225);
//        
//        _titleImageView.layer.shadowOffset = CGSizeMake(0, 1);
//        _titleImageView.layer.shadowColor = [UIColor grayColor].CGColor;
//        _titleImageView.layer.shadowRadius = 2;
//        _titleImageView.layer.shadowOpacity = 0.5;
//    }
//    return _titleImageView;
//}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
		_titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 290, 50)];
		_titleLabel.backgroundColor = [UIColor clearColor];
        
//        _titleLabel.text = @"活动规则";
        _titleLabel.textAlignment = UITextAlignmentCenter;
        _titleLabel.textColor = [UIColor light_Black_Color];
        _titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
//        _titleLabel.shadowColor = [UIColor redColor];
//        _titleLabel.shadowOffset = CGSizeMake(1, 1);
    }
    return _titleLabel;
}

- (UITextView *)groupTipsTextView
{
    if (_groupTipsTextView == nil) {
        
        CGRect frame = CGRectMake(15, 50, 290, 270);
        
        _groupTipsTextView = [[UITextView alloc] initWithFrame:frame];

        _groupTipsTextView.textColor = [UIColor dark_Gray_Color];
        
        _groupTipsTextView.backgroundColor = [UIColor clearColor];
        
        _groupTipsTextView.font = [UIFont systemFontOfSize:15.0];
        
        _groupTipsTextView.userInteractionEnabled = YES;
                
        _groupTipsTextView.editable = NO;
    }
    
    return _groupTipsTextView;
}

- (UIButton *)closeButton
{
    if (!_closeButton) {
        
        _closeButton = [[UIButton alloc] initWithFrame:CGRectMake(280, -13, 26, 26)];
        _closeButton.backgroundColor = [UIColor clearColor];
        [_closeButton setImage:[UIImage imageNamed:@"button_closed_normal.png"]
                                forState:UIControlStateNormal];
        [_closeButton addTarget:self
                         action:@selector(hide)
               forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

- (UIImageView *)line
{
    if (!_line) {
        _line =[[UIImageView alloc]initWithFrame:CGRectMake(15, 49, 290, 1)];
        _line.backgroundColor =[UIColor clearColor];
        _line.image =[UIImage streImageNamed:@"line"];
    }
    return _line;
}
@end
