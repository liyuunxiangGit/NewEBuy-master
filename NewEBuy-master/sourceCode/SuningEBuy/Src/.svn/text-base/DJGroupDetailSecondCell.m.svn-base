//
//  DJGroupDetailSecondCell.m
//  SuningEBuy
//
//  Created by xie wei on 13-7-15.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "DJGroupDetailSecondCell.h"
#import "DataProductBasic.h"

#define kNormalFont  [UIFont systemFontOfSize:12.0]
#define kBigFont     [UIFont systemFontOfSize:14.0]

@interface DJGroupDetailSecondCell()
{
    DataProductBasic *productDto;
    DJGroupDetailDTO *detailDto;
    
    BOOL isClick;
    CGSize heightSize;
}
@end

@implementation DJGroupDetailSecondCell

@synthesize productName = _productName;
@synthesize productDes = _productDes;
@synthesize accessImg = _accessImg;
@synthesize desBackImg = _desBackImg;
@synthesize showDetailBtn = _showDetailBtn;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_productName);
    TT_RELEASE_SAFELY(_productDes);
    TT_RELEASE_SAFELY(_accessImg);
    TT_RELEASE_SAFELY(_desBackImg);
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGSize size = [productDto.productName sizeWithFont:kBigFont constrainedToSize:CGSizeMake(310, MAXFLOAT)];
    self.productName.frame = CGRectMake(0, 10.0, 310, size.height);
    if (!isClick) {

        size = [productDto.productFeature sizeWithFont:kNormalFont constrainedToSize:CGSizeMake(274, MAXFLOAT)];
        
        CGFloat twoRowHeight = [@"a" sizeWithFont:kNormalFont constrainedToSize:CGSizeMake(274, MAXFLOAT)].height*2;
        
        
        CGFloat textViewHeight;

        if (size.height > twoRowHeight)
        {
            [self.desBackImg addSubview:self.accessImg];
            textViewHeight = twoRowHeight;
            self.showDetailBtn.hidden=NO;
        }
        else
        {
            
            textViewHeight = size.height;
            self.showDetailBtn.hidden=YES;
            
        }
        
        //textView修偏
        textViewHeight+=16;
        
        self.desBackImg.frame = CGRectMake(0, self.productName.bottom + 5, 304, textViewHeight);
        self.accessImg.frame = CGRectMake(290, 20, 10, 10);
        
        self.productDes.frame = CGRectMake(0, 0, 290, textViewHeight-8);
        [self.desBackImg addSubview:self.productDes];
        
        //内容为空判断
        if (IsStrEmpty(productDto.productFeature)) {
            self.productDes.hidden = YES;
            self.desBackImg.hidden = YES;
        }
        else{
            self.productDes.hidden = NO;
            self.desBackImg.hidden = NO;
            self.showDetailBtn.frame = CGRectMake(0, 0, 304, textViewHeight);
            [self.desBackImg addSubview:self.showDetailBtn];
            [self.showDetailBtn bringSubviewToFront:self.productDes];
        }
        
        
    }else {
       
        self.showDetailBtn.hidden = YES;
        size = [productDto.productFeature sizeWithFont:kNormalFont constrainedToSize:CGSizeMake(274, MAXFLOAT)];
        if (size.height <= 0) {
            self.desBackImg.frame = CGRectMake(0, self.productName.bottom + 5, 304, size.height + 10 + 40 > 46 ? size.height + 10 + 40 : 46);
//            self.accessImg.frame = CGRectMake(290, (size.height-10 + 40)/2, 10, 10);
        }else {
            self.desBackImg.frame = CGRectMake(0, self.productName.bottom + 5, 304, size.height > 30 ? size.height + 10 + 5: 46);
//            self.accessImg.frame = CGRectMake(290, (size.height-10)/2, 10, 10);
        }
        [self.desBackImg addSubview:self.accessImg];
        self.productDes.frame = CGRectMake(0, 0, 290, self.desBackImg.height);
        [self.desBackImg addSubview:self.productDes];
    }
}

+ (CGFloat)height:(DataProductBasic *)productDetail
{
    CGSize size = [productDetail.productFeature sizeWithFont:kNormalFont constrainedToSize:CGSizeMake(274, MAXFLOAT)];
    
    CGSize nameSize = [productDetail.productName sizeWithFont:kBigFont constrainedToSize:CGSizeMake(310, MAXFLOAT)];
    
    CGFloat nameHeight = nameSize.height > 23 ?nameSize.height : 23;
    
    if (size.height <= 0) {
         return 40 + 6 + 28 + 5 + nameHeight - 23;
    }
    return size.height + 6 + 28  + 5 > 79 ? size.height + 6 + 28 + 5 + nameHeight - 23: 79 + nameHeight - 23;
}

- (void)setItem:(DataProductBasic *)productDetail detailDto:(DJGroupDetailDTO *)dto Click:(BOOL)click
{
    productDto = productDetail;
    detailDto = dto;
    isClick = click;
    
    self.productName.text = productDetail.productName;
    self.productDes.text = productDetail.productFeature;
    if (!isClick) {
        self.accessImg.image = [UIImage imageNamed:@"DJ_Detail_ProDes_Down.png"];
    }else {
        self.accessImg.hidden = YES;
//        self.accessImg.image = [UIImage imageNamed:@"DJ_Detail_ProDes_UP.png"];
    }
    
    [self setNeedsLayout];
}

- (UILabel *)productName
{
    if(_productName == nil){
        _productName = [[UILabel alloc]init];
        _productName.textColor = [UIColor colorWithRGBHex:0x444444];
        _productName.backgroundColor = [UIColor clearColor];
        _productName.numberOfLines = 0;
        _productName.font = kBigFont;
        _productName.textAlignment = UITextAlignmentLeft;
        [self.contentView addSubview:_productName];
    }
    return _productName;
}

- (RuleCopyTextView *)productDes
{
    if(_productDes == nil){
        _productDes = [[RuleCopyTextView alloc]init];
        _productDes.textColor = RGBCOLOR(216, 138, 46);
        _productDes.backgroundColor = [UIColor clearColor];
//        _productDes.numberOfLines = 0;
        _productDes.font = kNormalFont;
        _productDes.editable = NO;
        _productDes.scrollEnabled = NO;
        _productDes.userInteractionEnabled = YES;
        _productDes.textAlignment = UITextAlignmentLeft;
//        _productDes.shadowColor = [UIColor whiteColor];
//        _productDes.shadowOffset = CGSizeMake(1, 1);
        _productDes.userInteractionEnabled = YES;
        
    }
    return _productDes;
}

- (UIImageView *)accessImg
{
    if (!_accessImg) {
        _accessImg = [[UIImageView alloc] init];
        _accessImg.backgroundColor = [UIColor clearColor];
        _accessImg.image = [UIImage imageNamed:@"DJ_Detail_ProDes_Down.png"];
        [_accessImg setContentMode:UIViewContentModeScaleToFill];
        _accessImg.userInteractionEnabled = YES;
    }
    return _accessImg;
}

- (UIImageView *)desBackImg
{
    if (!_desBackImg) {
        _desBackImg = [[UIImageView alloc] init];
        _desBackImg.backgroundColor = [UIColor clearColor];
        _desBackImg.image = [UIImage streImageNamed:@"DJ_Detail_ProDes_Back.png"];
        [_desBackImg setContentMode:UIViewContentModeScaleToFill];
        _desBackImg.userInteractionEnabled = YES;
        [self.contentView addSubview:_desBackImg];
    }
    return _desBackImg;
}

- (UIButton *)showDetailBtn
{
    if (!_showDetailBtn) {
        _showDetailBtn = [[UIButton alloc] init];
        _showDetailBtn.backgroundColor = [UIColor clearColor];
    }
    return _showDetailBtn;
}

@end