//
//  GuessYouLikeCell.m
//  SuningEBuy
//
//  Created by GUO on 14-10-27.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "GuessYouLikeCell.h"
#import "ProductUtil.h"

@implementation GuessYouLikeCell

@synthesize leftBackgroundImageView  = _leftBackgroundImageView;
@synthesize rightBackgroundImageView = _rightBackgroundImageView;
@synthesize leftImageView        = _leftImageView;
@synthesize rightImageView       = _rightImageView;
@synthesize leftNameLabel        = _leftNameLabel;
@synthesize rightNameLabel       = _rightNameLabel;
@synthesize leftPriceLabel       = _leftPriceLabel;
@synthesize rightPriceLabel      = _rightPriceLabel;
@synthesize leftButton           = _leftButton;
@synthesize rightButton          = _rightButton;
@synthesize leftDto              = _leftDto;
@synthesize rightDto             = _rightDto;
@synthesize leftHintLabel        = _leftHintLabel;
@synthesize rightHintLabel       = _rightHintLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return  self;
}

- (EGOImageViewEx *)leftBackgroundImageView
{
    if(!_leftBackgroundImageView)
    {
        _leftBackgroundImageView = [[EGOImageViewEx alloc] init];
        _leftBackgroundImageView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_leftBackgroundImageView];
    }
    return _leftBackgroundImageView;
}

- (EGOImageViewEx *)rightBackgroundImageView
{
    if(!_rightBackgroundImageView)
    {
        _rightBackgroundImageView = [[EGOImageViewEx alloc] init];
        _rightBackgroundImageView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_rightBackgroundImageView];
    }
    return _rightBackgroundImageView;
}

- (EGOImageViewEx *)leftImageView
{
    if(!_leftImageView)
    {
        _leftImageView = [[EGOImageViewEx alloc] init];
        _leftImageView.delegate = self;
        _leftImageView.exDelegate = self;
        _leftImageView.tag = 0;
        _leftImageView.backgroundColor = [UIColor clearColor];
        _leftImageView.layer.masksToBounds = YES;
        [self.leftBackgroundImageView addSubview:_leftImageView];
    }
    return _leftImageView;
}

- (EGOImageViewEx *)rightImageView
{
    if(!_rightImageView)
    {
        _rightImageView = [[EGOImageViewEx alloc] init];
        _rightImageView.delegate = self;
        _rightImageView.exDelegate = self;
        _rightImageView.tag = 1;
        _rightImageView.backgroundColor = [UIColor clearColor];
        _rightImageView.layer.masksToBounds = YES;
        [self.rightBackgroundImageView addSubview:_rightImageView];
    }
    return _rightImageView;
}

- (UILabel *)leftNameLabel
{
    if(!_leftNameLabel)
    {
        _leftNameLabel = [[UILabel alloc] init];
        _leftNameLabel.backgroundColor = [UIColor clearColor];
        //        _leftNameLabel.textAlignment = UITextAlignmentLeft;
        _leftNameLabel.font = [UIFont systemFontOfSize:13];
        _leftNameLabel.numberOfLines = 2;
        [self.leftBackgroundImageView addSubview:_leftNameLabel];
    }
    return _leftNameLabel;
}

- (UILabel *)rightNameLabel
{
    if(!_rightNameLabel)
    {
        _rightNameLabel = [[UILabel alloc] init];
        _rightNameLabel.backgroundColor = [UIColor clearColor];
        //        _rightNameLabel.textAlignment = UITextAlignmentLeft;
        _rightNameLabel.font = [UIFont systemFontOfSize:13];
        _rightNameLabel.numberOfLines = 2;
        [self.rightBackgroundImageView addSubview:_rightNameLabel];
    }
    return _rightNameLabel;
}

- (UILabel *)leftPriceLabel
{
    if(!_leftPriceLabel)
    {
        _leftPriceLabel = [[UILabel alloc] init];
        _leftPriceLabel.backgroundColor = [UIColor clearColor];
        _leftPriceLabel.textAlignment = UITextAlignmentLeft;
        _leftPriceLabel.font = [UIFont systemFontOfSize:15];
        _leftPriceLabel.textColor = [UIColor redColor];
        [self.leftBackgroundImageView addSubview:_leftPriceLabel];
    }
    return _leftPriceLabel;
}

- (UILabel *)rightPriceLabel
{
    if(!_rightPriceLabel)
    {
        _rightPriceLabel = [[UILabel alloc] init];
        _rightPriceLabel.backgroundColor = [UIColor clearColor];
        _rightPriceLabel.textAlignment = UITextAlignmentLeft;
        _rightPriceLabel.font = [UIFont systemFontOfSize:15];
        _rightPriceLabel.textColor = [UIColor redColor];
        [self.rightBackgroundImageView addSubview:_rightPriceLabel];
    }
    return _rightPriceLabel;
}

- (UIButton *)leftButton
{
    if(!_leftButton)
    {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.backgroundColor = [UIColor clearColor];
        _leftButton.tag = 0;
        [_leftButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_leftButton];
    }
    return _leftButton;
}

- (UIButton *)rightButton
{
    if(!_rightButton)
    {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.backgroundColor = [UIColor clearColor];
        _rightButton.tag = 1;
        [_rightButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_rightButton];
    }
    return _rightButton;
}

- (UILabel *)leftHintLabel
{
    if(!_leftHintLabel){
        _leftHintLabel = [[UILabel alloc] init];
        _leftHintLabel.text = @"￥";
        _leftHintLabel.textAlignment =  NSTextAlignmentLeft;
        _leftHintLabel.backgroundColor = [UIColor clearColor];
        _leftHintLabel.textColor = [UIColor redColor];
        _leftHintLabel.font = [UIFont systemFontOfSize:14];
        [self.leftBackgroundImageView addSubview:_leftHintLabel];
    }
    return _leftHintLabel;
}

- (UILabel *)rightHintLabel
{
    if(!_rightHintLabel){
        _rightHintLabel = [[UILabel alloc] init];
        _rightHintLabel.text = @"￥";
        _rightHintLabel.textAlignment =  NSTextAlignmentLeft;
        _rightHintLabel.backgroundColor = [UIColor clearColor];
        _rightHintLabel.textColor = [UIColor orange_Red_Color];
        _rightHintLabel.font = [UIFont systemFontOfSize:14];
        [self.rightBackgroundImageView addSubview:_rightHintLabel];
    }
    return _rightHintLabel;
}

- (void)setViewWithleftDto:(GuessDataDTO *)aLeftDto rightDto:(GuessDataDTO *)aRightDto
{
    
    _leftDto = aLeftDto;
    _rightDto = aRightDto;
    
    if(NotNilAndNull(_leftDto)){
        self.leftBackgroundImageView.frame = CGRectMake(10, 10, 145, 210);
        self.leftImageView.frame = CGRectMake(0.5, 0.5, 144, 144);
        self.leftNameLabel.frame = CGRectMake(5, 150, 135, 35);
        self.leftPriceLabel.frame = CGRectMake(20, 187, 80, 15);
        self.leftButton.frame = CGRectMake(10, 10, 145, 210);
        self.leftHintLabel.frame = CGRectMake(5, 189, 15, 15);
        [self.leftBackgroundImageView addFullLine];
        
        self.leftNameLabel.text = _leftDto.productName;
        self.leftPriceLabel.text = _leftDto.productPrice;
        self.leftImageView.imageURL = [ProductUtil getImageUrlWithProductCode:_leftDto.productCode size:ProductImageSize400x400];
    }
    if(NotNilAndNull(_rightDto)){
        self.rightBackgroundImageView.frame = CGRectMake(165, 10, 145, 210);
        self.rightImageView.frame = CGRectMake(0.5, 0.5, 144, 144);
        self.rightNameLabel.frame = CGRectMake(5, 150, 135, 35);
        self.rightPriceLabel.frame = CGRectMake(20, 187, 80, 15);
        self.rightButton.frame = CGRectMake(165, 10, 145, 210);
        self.rightHintLabel.frame = CGRectMake(5, 189, 15, 15);
        [self.rightBackgroundImageView addFullLine];
        
        self.rightNameLabel.text = _rightDto.productName;
        self.rightPriceLabel.text = _rightDto.productPrice;
        self.rightImageView.imageURL = [ProductUtil getImageUrlWithProductCode:_rightDto.productCode size:ProductImageSize400x400];
    }
}

- (void)buttonClick:(UIButton *)button
{
    UIButton *bt = button;
    GuessDataDTO *dto = nil;
    if(bt.tag == 0){
        dto = _leftDto;
    }else if(bt.tag == 1){
        dto = _rightDto;
    }
    NSString *position = [NSString stringWithFormat:@"%d",self.tag*2+bt.tag+1];
    NSString *productCode = dto.productCode;
    if([dto.productCode length] == 18){
        productCode = [dto.productCode substringFromIndex:9];
    }
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray:[NSArray arrayWithObjects:@"pagetype",@"productid",@"module",@"position",@"picortext",@"recstoreid",@"recproductid",@"recsource", nil] valueArray:[NSArray arrayWithObjects:@"appHome",@"none",@"recAppHome",position,@"p",dto.supplierId,productCode,dto.handWork, nil]];
    if(self.delegate && [self.delegate respondsToSelector:@selector(didSelectGuessYouLikeList:)]){
        [self.delegate didSelectGuessYouLikeList:dto];
    }
}


@end
