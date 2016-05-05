//
//  GBGoodsDetailSecondCell.m
//  SuningEBuy
//
//  Created by  zhang jian on 13-2-26.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "GBGoodsDetailSecondCell.h"

#define defaultFont   [UIFont boldSystemFontOfSize:15.0]

@interface GBGoodsDetailSecondCell()

@property (nonatomic, strong) UILabel                   *productTitle;
@property (nonatomic, strong) UILabel                   *refundMode;
@property (nonatomic, strong) UIImageView               *refundModeImage;
@property (nonatomic, strong) UILabel                   *expireRefundType;
@property (nonatomic, strong) UIImageView               *expireRefundTypeImage;

@end

@implementation GBGoodsDetailSecondCell

@synthesize productTitle                = _productTitle;
@synthesize refundMode                  = _refundMode;
@synthesize refundModeImage             = _refundModeImage;
@synthesize expireRefundType            = _expireRefundType;
@synthesize expireRefundTypeImage       = _expireRefundTypeImage;
@synthesize gbGoodsDetailDto            = _gbGoodsDetailDto;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_gbGoodsDetailDto);
    TT_RELEASE_SAFELY(_productTitle);
    TT_RELEASE_SAFELY(_refundModeImage);
    TT_RELEASE_SAFELY(_refundMode);
    TT_RELEASE_SAFELY(_expireRefundType);
    TT_RELEASE_SAFELY(_expireRefundTypeImage);
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

+ (CGFloat)height:(NSString *)textString{
    
    CGSize size = [textString sizeWithFont:defaultFont constrainedToSize:CGSizeMake(280, 1000) lineBreakMode:UILineBreakModeCharacterWrap];
    
    return size.height + 55;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize size = [self.refundMode.text sizeWithFont:defaultFont];
    
    self.productTitle.frame = CGRectMake(20, 5, 280, self.bounds.size.height - 40);
    self.refundModeImage.frame = CGRectMake(15, self.productTitle.bottom + 8, 15, 15);
    self.refundMode.frame = CGRectMake(self.refundModeImage.right + 5, self.refundModeImage.top-3, size.width, 20);
    self.expireRefundTypeImage.frame = CGRectMake(180, self.refundModeImage.top , 15, 15);
    self.expireRefundType.frame = CGRectMake(self.expireRefundTypeImage.right + 5, self.expireRefundTypeImage.top-3, 140, 20);
}

- (void)setGbGoodsDetailDto:(GBGoodsDetailDTO *)gbGoodsDetailDto
{
    if (_gbGoodsDetailDto != gbGoodsDetailDto) {
        _gbGoodsDetailDto = gbGoodsDetailDto;
        if (IsStrEmpty(_gbGoodsDetailDto.titlePrefix)) {
            _gbGoodsDetailDto.titlePrefix = L(@"GBOther");
        }
        self.productTitle.text = [NSString stringWithFormat:@"[%@]%@",_gbGoodsDetailDto.titlePrefix,_gbGoodsDetailDto.goodsTitle];
        if ([_gbGoodsDetailDto.refundType isEqualToString:@"1"]) {
            self.refundMode.text = L(@"GB_Support_No consumer refund");
            self.refundModeImage.image = [UIImage imageNamed:@"GroupBuy_Consumption_green.png"];
        }else{
            self.refundMode.text = L(@"GB_Unsupport_No consumer refund");
            self.refundModeImage.image = [UIImage imageNamed:@"GroupBuy_Consumption_gray.png"];
        }
        if ([_gbGoodsDetailDto.expireRefundType isEqualToString:@"1"]) {
            self.expireRefundType.text = L(@"GBAgreeToRefund");
            self.expireRefundTypeImage.image = [UIImage imageNamed:@"Group_expired_green.png"];
        }else{
            self.expireRefundType.text = L(@"GBNotAgreeTorefund");
            self.expireRefundTypeImage.image = [UIImage imageNamed:@"Group_expired_gray.png"];
        }
        
        [self setNeedsLayout];
    }
}

- (UILabel *)productTitle
{
    if (!_productTitle)
    {
        _productTitle = [[UILabel alloc] init];

        _productTitle.backgroundColor = [UIColor clearColor];
        
        _productTitle.numberOfLines = 0;
                
        _productTitle.font = [UIFont systemFontOfSize:15];
        
        [self.contentView addSubview:_productTitle];
    }
    return _productTitle;
}

- (UILabel *)refundMode
{
    if (!_refundMode)
    {
        _refundMode = [[UILabel alloc] init];
        
        _refundMode.backgroundColor = [UIColor clearColor];
                
        _refundMode.font = [UIFont systemFontOfSize:14];
        
        _refundMode.textColor = RGBCOLOR(94, 94, 94);
        
        [self.contentView addSubview:_refundMode];
    }
    return _refundMode;
}

- (UIImageView *)refundModeImage
{
    if (!_refundModeImage)
    {
        _refundModeImage = [[UIImageView alloc] init];
        
        _refundModeImage.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:_refundModeImage];
    }
    return _refundModeImage;
}

- (UILabel *)expireRefundType
{
    if (!_expireRefundType)
    {
        _expireRefundType = [[UILabel alloc] init];
        
        _expireRefundType.backgroundColor = [UIColor clearColor];
        
        _expireRefundType.font = [UIFont systemFontOfSize:14];
        
        _expireRefundType.textColor = RGBCOLOR(94, 94, 94);
        
        [self.contentView addSubview:_expireRefundType];
    }
    return _expireRefundType;
}

- (UIImageView *)expireRefundTypeImage
{
    if (!_expireRefundTypeImage)
    {
        _expireRefundTypeImage = [[UIImageView alloc] init];
        
        _expireRefundTypeImage.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:_expireRefundTypeImage];
    }
    return _expireRefundTypeImage;
}


@end