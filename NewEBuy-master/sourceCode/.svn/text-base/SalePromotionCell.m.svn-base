//
//  SalePromotionCell.m
//  SuningEBuy
//
//  Created by GUO on 14-9-19.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "SalePromotionCell.h"

@interface SalePromotionCell()
{
    NSString *_saleModel;
}
@property (nonatomic, strong) EGOImageButton                *titleImageView;
@property (nonatomic, strong) EGOImageButton                *firstImageView;
@property (nonatomic, strong) EGOImageButton                *secondImageView;
@property (nonatomic, strong) EGOImageButton                *thirdImageView;
@property (nonatomic, strong) EGOImageButton                *forthImageView;
@property (nonatomic, strong) EGOImageButton                *fifthImageView;
@property (nonatomic, strong) EGOImageButton                *sixthImageView;
@property (nonatomic, strong) UIImageView                   *backImageView;

@end

@implementation SalePromotionCell

- (instancetype)initWithFloorModel:(NSString *)floorModel reuseIdentifier:(NSString *)reuseIdentifier

{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        _saleModel = floorModel;
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.selectionStyle = UITableViewCellStyleDefault;
    }
    return self;
}

- (EGOImageButton *)titleImageView
{
    if(!_titleImageView)
    {
        _titleImageView = [[EGOImageButton alloc] init];
        _titleImageView.delegate = self;
        [_titleImageView addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        _titleImageView.tag = 0;
        _titleImageView.backgroundColor = [UIColor greenColor];
//        _titleImageView.placeholderImage = [];
        _titleImageView.layer.masksToBounds = YES;
        _titleImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _titleImageView;
}

- (EGOImageButton *)firstImageView
{
    if(!_firstImageView)
    {
        _firstImageView = [[EGOImageButton alloc] init];
        _firstImageView.delegate = self;
        [_firstImageView addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        _firstImageView.tag = 1;
        _firstImageView.backgroundColor = [UIColor redColor];
//        _firstImageView.placeholderImage = [];
        _firstImageView.layer.masksToBounds = YES;
        _firstImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _firstImageView;
}

- (EGOImageButton *)secondImageView
{
    if(!_secondImageView)
    {
        _secondImageView = [[EGOImageButton alloc] init];
        _secondImageView.delegate = self;
        [_secondImageView addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        _secondImageView.tag = 2;
        _secondImageView.backgroundColor = [UIColor blueColor];
//        _secondImageView.placeholderImage = [];
        _secondImageView.layer.masksToBounds = YES;
        _secondImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _secondImageView;
}

- (EGOImageButton *)thirdImageView
{
    if(!_thirdImageView)
    {
        _thirdImageView = [[EGOImageButton alloc] init];
        _thirdImageView.delegate = self;
        [_thirdImageView addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        _thirdImageView.tag = 3;
        _thirdImageView.backgroundColor = [UIColor redColor];
//        _thirdImageView.placeholderImage = [];
        _thirdImageView.layer.masksToBounds = YES;
        _thirdImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _thirdImageView;
}

- (EGOImageButton *)forthImageView
{
    if(!_forthImageView)
    {
        _forthImageView = [[EGOImageButton alloc] init];
        _forthImageView.delegate = self;
        [_forthImageView addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        _forthImageView.tag = 4;
        _forthImageView.backgroundColor = [UIColor blueColor];
//        _forthImageView.placeholderImage = [];
        _forthImageView.layer.masksToBounds = YES;
        _forthImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _forthImageView;
}

- (EGOImageButton *)fifthImageView
{
    if(!_fifthImageView)
    {
        _fifthImageView = [[EGOImageButton alloc] init];
        _fifthImageView.delegate = self;
        [_fifthImageView addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        _fifthImageView.tag = 5;
        _fifthImageView.backgroundColor = [UIColor redColor];
//        _fifthImageView.placeholderImage = [];
        _fifthImageView.layer.masksToBounds = YES;
        _fifthImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _fifthImageView;
}

- (EGOImageButton *)sixthImageView
{
    if(!_sixthImageView)
    {
        _sixthImageView = [[EGOImageButton alloc] init];
        _sixthImageView.delegate = self;
        [_sixthImageView addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        _sixthImageView.tag = 6;
        _sixthImageView.backgroundColor = [UIColor blueColor];
        _sixthImageView.layer.masksToBounds = YES;
        _sixthImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _sixthImageView;
}

- (UIImageView *)backImageView
{
    if(!_backImageView)
    {
        _backImageView = [[UIImageView alloc] init];
        _backImageView.backgroundColor = [UIColor redColor];
        _backImageView.layer.masksToBounds = YES;
        _backImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _backImageView;
}

#pragma mark
#pragma mark - setViews

- (void)setViewsForModel:(NSString *)model
{
    _saleModel = model;
    if(self.tag == 0){
        [self.contentView addSubview:self.titleImageView];
    }
    else{
        if ([_saleModel isEqualToString:@"1"])
        {
            [self.contentView addSubview:self.firstImageView];
            [self.contentView addSubview:self.secondImageView];
            [self.contentView addSubview:self.thirdImageView];
            [self.contentView addSubview:self.forthImageView];
            [self.contentView addSubview:self.fifthImageView];
            
        }else if ([_saleModel isEqualToString:@"2"])
        {
            [self.contentView addSubview:self.firstImageView];
        }else if ([_saleModel isEqualToString:@"3"])
        {
            [self.contentView addSubview:self.firstImageView];
            [self.contentView addSubview:self.secondImageView];
        }else if ([_saleModel isEqualToString:@"4"])
        {
            [self.contentView addSubview:self.firstImageView];
            [self.contentView addSubview:self.secondImageView];
            [self.contentView addSubview:self.thirdImageView];
            [self.contentView addSubview:self.forthImageView];
            [self.contentView addSubview:self.fifthImageView];
            [self.contentView addSubview:self.sixthImageView];
        }
        else if ([_saleModel isEqualToString:@"5"])
        {
            [self.contentView addSubview:self.firstImageView];
            [self.contentView addSubview:self.secondImageView];
            [self.contentView addSubview:self.thirdImageView];
            [self.contentView addSubview:self.forthImageView];
        }
        else if ([_saleModel isEqualToString:@"6"])
        {
            [self.contentView addSubview:self.firstImageView];
            [self.contentView addSubview:self.secondImageView];
            [self.contentView addSubview:self.thirdImageView];
            [self.contentView addSubview:self.forthImageView];
            [self.contentView addSubview:self.fifthImageView];
        }
    }
    //设置图片位置及URL
    [self setImageFrame];
}

- (void)setImageFrame
{
    if(self.tag == 0){
        if(![_saleModel isEqualToString:@"2"]){
            self.titleImageView.frame = CGRectMake(0, 0, 320, 160);
//            self.titleImageView.imageURL = ;
        }
        else
        {
            self.titleImageView.frame = CGRectMake(10, 10, 300, 140);
//            self.titleImageView.imageURL = ;
        }
    }
    else{
        if ([_saleModel isEqualToString:@"1"])
        {
            self.firstImageView.frame = CGRectMake(10, 10, 145, 180);
            self.secondImageView.frame = CGRectMake(165, 10, 145, 85);
            self.thirdImageView.frame = CGRectMake(165, 105, 145, 85);
            self.forthImageView.frame = CGRectMake(10, 200, 145, 85);
            self.fifthImageView.frame = CGRectMake(165, 200, 145, 85);
            
//            self.firstImageView.imageURL = ;
//            self.secondImageView.imageURL = ;
//            self.thirdImageView.imageURL = ;
//            self.forthImageView.imageURL = ;
//            self.fifthImageView.imageURL = ;
        }else if ([_saleModel isEqualToString:@"2"])
        {
            //            self.titleImageView.frame = CGRectMake(10, 10, 300, 140);
            self.firstImageView.frame = CGRectMake(10, 10, 300, 140);
//            self.firstImageView.imageURL = ;
        }else if ([_saleModel isEqualToString:@"3"])
        {
            self.firstImageView.frame = CGRectMake(0, 0, 160, 130);
            self.secondImageView.frame = CGRectMake(160, 0, 160, 130);
            
//            self.firstImageView.imageURL = ;
//            self.secondImageView.imageURL = ;
        }else if ([_saleModel isEqualToString:@"4"])
        {
            self.firstImageView.frame = CGRectMake(10, 10, 100, 150);
            self.secondImageView.frame = CGRectMake(110, 10, 100, 150);
            self.thirdImageView.frame = CGRectMake(210, 10, 100, 150);
            self.forthImageView.frame = CGRectMake(10, 160, 100, 150);
            self.fifthImageView.frame = CGRectMake(110, 160, 100, 150);
            self.sixthImageView.frame = CGRectMake(210, 160, 100, 150);
            
//            self.firstImageView.imageURL = ;
//            self.secondImageView.imageURL = ;
//            self.thirdImageView.imageURL = ;
//            self.forthImageView.imageURL = ;
//            self.fifthImageView.imageURL = ;
//            self.sixthImageView.imageURL = ;
        }
        else if ([_saleModel isEqualToString:@"5"])
        {
            self.firstImageView.frame = CGRectMake(10, 10, 100, 150);
            self.secondImageView.frame = CGRectMake(110, 10, 200, 75);
            self.thirdImageView.frame = CGRectMake(110, 85, 100, 75);
            self.forthImageView.frame = CGRectMake(210, 85, 100, 75);
            
//            self.firstImageView.imageURL = ;
//            self.secondImageView.imageURL = ;
//            self.thirdImageView.imageURL = ;
//            self.forthImageView.imageURL = ;
        }
        else if ([_saleModel isEqualToString:@"6"])
        {
            self.firstImageView.frame = CGRectMake(10, 10, 100, 75);
            self.secondImageView.frame = CGRectMake(110, 10, 200, 75);
            self.thirdImageView.frame = CGRectMake(10, 85, 100, 75);
            self.forthImageView.frame = CGRectMake(110, 85, 100, 75);
            self.fifthImageView.frame = CGRectMake(210, 85, 100, 75);
            
//            self.firstImageView.imageURL = ;
//            self.secondImageView.imageURL = ;
//            self.thirdImageView.imageURL = ;
//            self.forthImageView.imageURL = ;
//            self.fifthImageView.imageURL = ;
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark
#pragma mark - buttonClicked
- (void)buttonClick:(id)sender
{
//    EGOImageButton *btn = (EGOImageButton *)sender;
//    if (_delegate && [_delegate respondsToSelector:@selector(didSelectPromotionImage:)])
//    {
//        
//    }
//    else
//    {
//        
//    }
}

@end
