//
//  SearchSectionHeaderView.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-8-30.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "SearchSectionHeaderView.h"
#import "OHAttributedLabel.h"
#import "NSAttributedString+Attributes.h"


@interface SearchSectionHeaderView()

//@property (nonatomic, retain) UIImageView *backGroundImageView;

@property (nonatomic, strong) UIButton *button;

@property (nonatomic, strong) OHAttributedLabel *titleLabel;

@property (nonatomic, strong) UILabel *accessoryLabel;

@end

/****************************************************************/

@implementation SearchSectionHeaderView

//@synthesize backGroundImageView = _backGroundImageView;
@synthesize button = _button;
@synthesize titleLabel = _titleLabel;
@synthesize accessoryLabel = _accessoryLabel;

@synthesize delegate = _delegate;
@synthesize keyword = _keyword;

- (void)dealloc
{
//    TT_RELEASE_SAFELY(_backGroundImageView);
    TT_RELEASE_SAFELY(_button);
    TT_RELEASE_SAFELY(_titleLabel);
    TT_RELEASE_SAFELY(_accessoryLabel);
    TT_RELEASE_SAFELY(_keyword);
    
}

- (id)init {
    self = [super initWithFrame:CGRectMake(0, 44, 320, 30)];
    self.backgroundColor=RGBCOLOR(239, 234, 215);
    if (self) {
//        [self addSubview:self.backGroundImageView];
//        [self addSubview:self.button];
        [self addSubview:self.titleLabel];
        [self addSubview:self.accessoryLabel];
    }
    return self;
}

- (void)setKeyword:(NSString *)keyword
{
    if (keyword != _keyword) {
        _keyword = [keyword copy];
    }
    self.titleLabel.text = [NSString stringWithFormat:@"\"%@\"", keyword];
}

- (void)setSearchKeyword:(NSString *)keyword resultNumber:(NSInteger)result
{
    if (NotNilAndNull(keyword)) {
        //self.titleLabel.text = [NSString stringWithFormat:@"\"%@\" 共搜到%d个商品", keyword,result];
        if (keyword.length > 10) {
            keyword = [[keyword substringToIndex:10] stringByAppendingString:@"..."];
        }
        
        NSString *str =[NSString stringWithFormat:@"\"%@\" %@%d%@%@", keyword,L(@"Search_SearchTotal"),result,L(@"Unit"),L(@"Search_Goods")];
                

        NSMutableAttributedString *proStr=[[NSMutableAttributedString alloc]initWithString:str];
        [proStr setTextColor:[UIColor colorWithRGBHex:0x444444]];
        [proStr setTextColor:[UIColor colorWithRGBHex:0xff0000] range:NSMakeRange(keyword.length+6, proStr.length-3-keyword.length-6)];
//        [proStr setTextColor:[UIColor colorWithRGBHex:0x444444] range:NSMakeRange(proStr.length-3, 2)];
//        [proStr setTextColor:[UIColor colorWithRGBHex:0x444444] range:NSMakeRange(0, keyword.length)];
        self.titleLabel.attributedText =proStr;
    }
//    self.accessoryLabel.text = [NSString stringWithFormat:@"共搜到%d个商品", result];
//    self.accessoryLabel.textColor=[UIColor colorWithRGBHex:0x444444];

}

//- (UIImageView *)backGroundImageView
//{
//    if (!_backGroundImageView) {
//        _backGroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
//        _backGroundImageView.image = [UIImage imageNamed:@"search_section_header_bg.png"];
//    }
//    return _backGroundImageView;
//}

- (UIButton *)button
{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(5, 2.5+2, 106, 25);
        [_button setImage:[UIImage imageNamed:@"search_section_header_button.png"] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(buttonTouched) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

- (OHAttributedLabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[OHAttributedLabel alloc] init];
        _titleLabel.textAlignment = UITextAlignmentCenter;
//        _titleLabel.textColor = [UIColor skyBlueColor];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont systemFontOfSize:12.0];
        _titleLabel.frame = CGRectMake(22, 5+2+3, 320, 16);
    }
    return _titleLabel;
}

- (UILabel *)accessoryLabel
{
    if (!_accessoryLabel) {
        _accessoryLabel = [[UILabel alloc] init];
        _accessoryLabel.backgroundColor = [UIColor clearColor];
        _accessoryLabel.font = [UIFont systemFontOfSize:12.0];
        _accessoryLabel.textAlignment = UITextAlignmentRight;
        _accessoryLabel.frame = CGRectMake(110, 5+2, 200, 20);
    }
    return _accessoryLabel;
}

- (void)buttonTouched
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didTouchTheButtonOnSectionHeader:)]) {
        [self.delegate didTouchTheButtonOnSectionHeader:self.keyword];
    }
}

@end
