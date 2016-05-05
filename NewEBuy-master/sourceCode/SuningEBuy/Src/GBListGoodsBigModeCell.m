//
//  GBListGoodsBigModeCell.m
//  SuningEBuy
//
//  Created by shasha on 13-3-1.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "GBListGoodsBigModeCell.h"
#import "OHAttributedLabel.h"

#import "StrikeThroughLabel.h"

@interface GBListGoodsBigModeCell() {
    
}

@property (nonatomic, strong) EGOImageView       *goodsImageView;
@property (nonatomic, strong) UILabel            *infoLabel;
@property (nonatomic, strong) StrikeThroughLabel  *originalPriceLabel;
@property (nonatomic, strong) OHAttributedLabel  *discountPriceLabel;
@property (nonatomic, strong) UIImageView        *memberCountIcon;
@property (nonatomic, strong) UIImageView        *locationIcon;
@property (nonatomic, strong) UILabel            *memberLabel;
@property (nonatomic, strong) UILabel            *locationLabel;

@property (nonatomic, strong) GBListGoodsDTO     *item;

@end

@implementation GBListGoodsBigModeCell
@synthesize goodsImageView = _goodsImageView;
@synthesize infoLabel = _infoLabel;
@synthesize originalPriceLabel = _originalPriceLabel;
@synthesize discountPriceLabel = _discountPriceLabel;
@synthesize memberCountIcon = _memberCountIcon;
@synthesize locationIcon = _locationIcon;
@synthesize memberLabel = _memberLabel;
@synthesize locationLabel = _locationLabel;

@synthesize item = _item;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_goodsImageView);
    TT_RELEASE_SAFELY(_infoLabel);
    TT_RELEASE_SAFELY(_originalPriceLabel);
    TT_RELEASE_SAFELY(_discountPriceLabel);
    TT_RELEASE_SAFELY(_memberCountIcon);
    TT_RELEASE_SAFELY(_locationIcon);
    TT_RELEASE_SAFELY(_memberLabel);
    TT_RELEASE_SAFELY(_locationLabel);
    TT_RELEASE_SAFELY(_item);

}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
    
}

+ (CGFloat)height{

    return 246;
    
}

- (void)setItem:(GBListGoodsDTO *)dto{
    
    if (_item != dto) {
        TT_RELEASE_SAFELY(_item);
        _item =dto;
        self.goodsImageView.imageURL = [NSURL URLWithString:dto.bimg];
        
        self.infoLabel.text = self.item.goodName;
        
        NSString * originalPrice = [NSString stringWithFormat:@"%@%@", L(@"GBOriginalPrice"),self.item.originPrice];
        self.originalPriceLabel.text = originalPrice;
        
        float discountP = [self.item.presentPrice floatValue];
        NSString * discountPrice = [NSString stringWithFormat:@"¥%.2f",discountP];
        NSMutableAttributedString *discountPriceAttStr =[[NSMutableAttributedString alloc] initWithString:discountPrice];
        
        [discountPriceAttStr setFont:[UIFont boldSystemFontOfSize:16] range:NSMakeRange(0, 1)];
        [discountPriceAttStr setFont:[UIFont boldSystemFontOfSize:17] range:NSMakeRange(1, discountPriceAttStr.length-1)];
        [discountPriceAttStr setTextColor:RGBCOLOR(245, 56, 21)];
        self.discountPriceLabel.attributedText = discountPriceAttStr;
        TT_RELEASE_SAFELY(discountPriceAttStr);
        
        self.memberLabel.text = [NSString stringWithFormat:@"%@%@",self.item.saleCount,L(@"GBPeople")];
        
        self.locationLabel.text = IsStrEmpty(self.item.titlePrefix)?L(@"GBOther"):self.item.titlePrefix;
        
        [self setNeedsLayout];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGSize locationSize = [self.locationLabel.text sizeWithFont:self.locationLabel.font];
    
    self.goodsImageView.frame = CGRectMake(15, 13, self.goodsImageView.width, self.goodsImageView.height);
    self.locationIcon.frame = CGRectMake(self.goodsImageView.left + 10, self.goodsImageView.bottom + 15, self.locationIcon.width, self.locationIcon.height);
    self.locationLabel.frame = CGRectMake(self.locationIcon.right + 5, self.locationIcon.top + 2, locationSize.width, self.locationLabel.height);
    self.infoLabel.frame = CGRectMake(self.locationLabel.right + 10, self.locationLabel.top, self.infoLabel.width, self.infoLabel.height);
    CGSize size = [[self.discountPriceLabel.attributedText string] sizeWithFont:self.discountPriceLabel.font];
    self.discountPriceLabel.frame = CGRectMake(self.locationIcon.left, self.infoLabel.bottom + 15, size.width + 10, self.discountPriceLabel.height);
    self.originalPriceLabel.frame = CGRectMake(self.discountPriceLabel.right, 0, self.originalPriceLabel.width, self.originalPriceLabel.height);
    self.originalPriceLabel.center = CGPointMake(self.originalPriceLabel.center.x, self.discountPriceLabel.center.y);
    
    self.memberCountIcon.frame = CGRectMake(245, self.originalPriceLabel.top - 2, self.memberCountIcon.width, self.memberCountIcon.height);
    self.memberLabel.frame = CGRectMake(self.memberCountIcon.right + 10, self.memberCountIcon.top, self.memberLabel.width, self.memberLabel.height);
}

- (EGOImageView *)goodsImageView{
    if (!_goodsImageView) {
        _goodsImageView = [[EGOImageView alloc] initWithFrame:CGRectMake(0, 0, 290, 150)];
        _goodsImageView.layer.borderColor = RGBCOLOR(162, 162, 162).CGColor;
        _goodsImageView.layer.borderWidth = 1;
        _goodsImageView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_goodsImageView];
    }
    return _goodsImageView;
}

- (UILabel *)infoLabel{
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
        _infoLabel.backgroundColor = [UIColor clearColor];
        _infoLabel.shadowColor = [UIColor whiteColor];
        _infoLabel.shadowOffset = CGSizeMake(1, 1);
        _infoLabel.numberOfLines = 1;
        _infoLabel.font = [UIFont boldSystemFontOfSize:15];
        [self.contentView addSubview:_infoLabel];
    }
    return _infoLabel;
}


- (OHAttributedLabel *)discountPriceLabel{
    
    if (!_discountPriceLabel) {
//        _discountPriceLabel = [[OHAttributedLabel alloc] initWithFrame:CGRectMake(0, 0, 50, 25)];
        _discountPriceLabel = [[OHAttributedLabel alloc] initWithFrame:CGRectMake(0, 0, 120, 25)];
        _discountPriceLabel.backgroundColor = [UIColor clearColor];
        _discountPriceLabel.shadowColor = [UIColor whiteColor];
        _discountPriceLabel.shadowOffset = CGSizeMake(1, 1);
        [self.contentView addSubview:_discountPriceLabel];
    }
    return _discountPriceLabel;
}


- (StrikeThroughLabel *)originalPriceLabel{
    
    if (!_originalPriceLabel) {
        _originalPriceLabel = [[StrikeThroughLabel alloc] initWithFrame:CGRectMake(0, 0, 80, 15)];
        _originalPriceLabel.backgroundColor = [UIColor clearColor];
        _originalPriceLabel.textColor = [UIColor lightGrayColor];
        _originalPriceLabel.textAlignment = UITextAlignmentLeft;
        _originalPriceLabel.font = [UIFont systemFontOfSize:13];
        _originalPriceLabel.shadowColor = [UIColor whiteColor];
        _originalPriceLabel.shadowOffset = CGSizeMake(1, 1);
        _originalPriceLabel.isWithStrikeThrough = YES;
//        [self.contentView addSubview:_originalPriceLabel];
        
    }
    return _originalPriceLabel;
}

- (UIImageView *)memberCountIcon{
    
    if (!_memberCountIcon) {
        _memberCountIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 17, 14)];
        _memberCountIcon.image = [UIImage imageNamed:@"GroupBuy_people_gray_normal.png"];
        [self.contentView addSubview:_memberCountIcon];
    }
    return _memberCountIcon;
}

- (UIImageView *)locationIcon{
    if (!_locationIcon) {
        _locationIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 15, 21)];
        _locationIcon.image = [UIImage imageNamed:@"GroupBuy_Location_orange_normal.png"];
        [self.contentView addSubview:_locationIcon];
    }
    return _locationIcon;
}

- (UILabel *)memberLabel{
    
    if (!_memberLabel) {
        _memberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, self.memberCountIcon.height)];
        _memberLabel.backgroundColor = [UIColor clearColor];
        _memberLabel.shadowColor = [UIColor whiteColor];
        _memberLabel.shadowOffset = CGSizeMake(1, 1);
        _memberLabel.textColor = [UIColor lightGrayColor];
        _memberLabel.textAlignment = UITextAlignmentLeft;
        _memberLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_memberLabel];
    }
    return _memberLabel;
}

- (UILabel *)locationLabel{
    
    if (!_locationLabel) {
        _locationLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,50, 20)];
        _locationLabel.backgroundColor = [UIColor clearColor];
        _locationLabel.textColor = [UIColor lightGrayColor];
        _locationLabel.shadowColor = [UIColor  whiteColor];
        _locationLabel.shadowOffset = CGSizeMake(1, 1);
        _locationLabel.textAlignment = UITextAlignmentLeft;
        _locationLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_locationLabel];
    }
    
    return _locationLabel;
}
@end
