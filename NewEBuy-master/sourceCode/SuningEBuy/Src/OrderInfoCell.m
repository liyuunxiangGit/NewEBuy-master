//
//  OrderInfoCell.m
//  SuningEBuy
//
//  Created by jian  zhang on 12-7-2.
//  Copyright (c) 2012年 nanjing. All rights reserved.
//

#import "OrderInfoCell.h"
#import "NSAttributedString+Attributes.h"

@implementation OrderInfoCell

@synthesize orderPrice = _orderPrice;
@synthesize selectBtn = _selectBtn;
@synthesize hasAddLine=_hasAddLine;
- (void)dealloc {
    
    TT_RELEASE_SAFELY(_orderPrice);
    TT_RELEASE_SAFELY(_selectBtn);
    
}




- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
		
        self.backgroundColor = [UIColor whiteColor];        
        
		self.autoresizesSubviews = YES;
        
    }
    
    return self;
}

- (OHAttributedLabel *)orderPrice{
    
    if (!_orderPrice) {
        _orderPrice = [[OHAttributedLabel alloc] initWithFrame:CGRectMake(10, 15, 280, 30)];
        _orderPrice.backgroundColor = [UIColor clearColor];
//        _orderPrice.textAlignment = UITextAlignmentCenter;
        [self.contentView addSubview:_orderPrice];
    }
    return _orderPrice;
}

- (void)setDiscountAttrText:(NSString *)orderPrice{
   
    NSString *string = [NSString stringWithFormat:@"%@ %@",L(@"BTOrderNumber"),orderPrice];
    
    NSMutableAttributedString *mutaString = [[NSMutableAttributedString alloc] initWithString:string];
    
    [mutaString setFont:[UIFont boldSystemFontOfSize:15.0]];
    
    [mutaString setTextAlignment:kCTCenterTextAlignment lineBreakMode:kCTLineBreakByWordWrapping];
        
    [mutaString setTextColor:[UIColor blackColor]];
    
    [mutaString setTextColor:[UIColor orange_Red_Color] range:[string rangeOfString:orderPrice]];
    
    self.orderPrice.attributedText = mutaString;
    
    TT_RELEASE_SAFELY(mutaString);
}

- (UIButton *)selectBtn{
    
    if (!_selectBtn) {
        _selectBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _selectBtn.frame = CGRectMake(0, 30, 15+8, 9+30);
        
        _selectBtn.backgroundColor = [UIColor clearColor];
        
        [_selectBtn addSubview:self.selectImage];
        
        [self.contentView addSubview:_selectBtn];
    }
    
    return _selectBtn;
}
- (UIImageView *)selectImage
{
    if (!_selectImage) {

        _selectImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"unchecked_icon.png"]];
        
        _selectImage.frame = CGRectMake(8, 20, 15, 9);
        
        _selectImage.userInteractionEnabled = NO;
    }
    return _selectImage;
}

- (UIButton *)helpBtn{
    
    if (!_helpBtn) {
        _helpBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.selectBtn.right+5, 40, 230, 30)];
        _helpBtn.backgroundColor = [UIColor clearColor];
        _helpBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13.0];
        [_helpBtn setTitle:L(@"Already read and agree Suning_Hotel_Deal") forState:UIControlStateNormal] ;
        [_helpBtn setTitle:L(@"Already read and agree Suning_Hotel_Deal") forState:UIControlEventTouchUpInside] ;
//        _helpBtn.titleLabel.textColor=[UIColor dark_Gray_Color];
        [_helpBtn setTitleColor:[UIColor dark_Gray_Color] forState:UIControlStateNormal];
        [self.contentView addSubview:_helpBtn];
    }

    return _helpBtn;
}

-(UIImageView*)newLineImageView
{
    UIImageView* lineImage=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.5)];
    UIImage* img=[UIImage newImageFromResource:@"category_cellSeparatorLine.png"];
    [lineImage setImage:img];
    
    return lineImage;
}
- (void)initOrderPrice:(NSString *)orderPrice isSelect:(BOOL)isSelect{
    
    if (!self.hasAddLine) {
        UIImageView* topLineImage=[self newLineImageView];
        [self.contentView addSubview:topLineImage];
    }
    
    
    if (isSelect) {
        self.selectImage.image = [UIImage imageNamed:@"unchecked_icon.png"];
//        [self.selectBtn setBackgroundImage:[UIImage imageNamed:@"unchecked_icon.png"] forState:UIControlStateNormal];
    }
    else{
        self.selectImage.image = [UIImage imageNamed:@"checked_icon.png"];
//        [self.selectBtn setBackgroundImage:[UIImage imageNamed:@"checked_icon.png"] forState:UIControlStateNormal];

    }
    [self setDiscountAttrText:orderPrice];
    [self.helpBtn setTitle:L(@"Already read and agree Suning_Hotel_Deal") forState:UIControlStateNormal] ;
    [self.helpBtn setTitle:L(@"Already read and agree Suning_Hotel_Deal") forState:UIControlEventTouchUpInside] ;
    self.selectBtn.tag = 1;
    
    if (!self.hasAddLine) {
        UIImageView* lineImage=[[UIImageView alloc] initWithFrame:CGRectMake(0, 74, 320, 1)];
        UIImage* img=[UIImage newImageFromResource:@"category_cellSeparatorLine.png"];
        [lineImage setImage:img];
        [self.contentView addSubview:lineImage];
    }
    self.hasAddLine=1;
    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.helpBtn.frame = CGRectMake(self.selectBtn.right+5, 40, 195, 30);
}

@end
