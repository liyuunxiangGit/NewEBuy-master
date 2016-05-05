//
//  StoreHeadImageView.m
//  SuningEBuy
//
//  Created by xingxianping on 14-2-13.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "StoreHeadImageView.h"

@implementation StoreHeadImageView

@synthesize storeImage = _storeImage;
@synthesize backView = _backView;
@synthesize nameLabel =_nameLabel;
@synthesize dto =_dto;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_storeImage);
    TT_RELEASE_SAFELY(_backView);
    TT_RELEASE_SAFELY(_nameLabel);
}

- (EGOImageView *)storeImage
{
    if (!_storeImage) {
        _storeImage = [[EGOImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 172)];
        _storeImage.backgroundColor =[UIColor clearColor];
        _storeImage.clipsToBounds =YES;
        _storeImage.userInteractionEnabled =YES;
    }
    return _storeImage;
}

- (UIView *)backView
{
    if (!_backView) {
        _backView =[[UIView alloc]init];
        _backView.backgroundColor =[UIColor blackColor];
        _backView.alpha = 0.3;
    }
    return _backView;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.backgroundColor =[UIColor clearColor];
        _nameLabel.textColor =[UIColor whiteColor];
        _nameLabel.font=[UIFont systemFontOfSize:16];
        _nameLabel.numberOfLines=0;
        _nameLabel.lineBreakMode = UILineBreakModeCharacterWrap;
        _nameLabel.contentMode =UIViewContentModeCenter;
        _nameLabel.textAlignment =UITextAlignmentCenter;
    }
    return _nameLabel;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithDTO:(StoreDetailInfoDTO *)dto
{
    if (self =[super init]) {
        self.dto=[[StoreDetailInfoDTO alloc]init];
        //        self.dto =dto;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSString *str =[NSString stringWithFormat:@"%@%@",self.dto.storeName,L(@"NearbySuning_Welcome")];
    CGSize size1 = [str sizeWithFont:[UIFont boldSystemFontOfSize:16.0] constrainedToSize:CGSizeMake(290, 100)];

    
    CGFloat y =172-size1.height-10;
    
    self.backView.frame = CGRectMake(0, y, 320, size1.height+10);
    
    self.nameLabel.frame = CGRectMake(15, y+3, 290, size1.height);
    
    
    [self addSubview:self.storeImage];
    [self addSubview:self.backView];
    [self addSubview:self.nameLabel];
    
    _nameLabel.text=str;
    _storeImage.imageURL = [NSURL URLWithString:self.dto.storePicture];
    
}

@end
