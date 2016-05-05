//
//  GroupProductProgressView.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-2-8.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "GroupProductProgressView.h"

@interface GroupProductProgressView()

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UILabel *groupNumberLabel;

@property (nonatomic, strong) UILabel *numberLabel1;
@property (nonatomic, strong) UILabel *numberLabel2;
@property (nonatomic, strong) UILabel *numberLabel3;
@property (nonatomic, strong) UILabel *numberLabel4;
@property (nonatomic, strong) UILabel *numberLabel5;

@property (nonatomic, strong) UILabel *unitLabel;

@property (nonatomic, strong) UILabel *discountLabel;
@property (nonatomic, strong) UILabel *discountUnitLabel;
@property (nonatomic, strong) UILabel *discountLowLabel;
@property (nonatomic, strong) UILabel *discountHighLabel;

@property (nonatomic, strong) UIImageView *image1;
@property (nonatomic, strong) UIImageView *image2;
@property (nonatomic, strong) UIImageView *image3;
@property (nonatomic, strong) UIImageView *image4;
@property (nonatomic, strong) UIImageView *image5;
@property (nonatomic, strong) UIImageView *image6;

@property (nonatomic, strong) UIView *progressBackground;
@property (nonatomic, strong) UIImageView *progressImageView;


- (void)addSubviewsNeeded;
@end



/*---------------------------------------------------------*/

@implementation GroupProductProgressView

@synthesize groupDTO = _groupDTO;

@synthesize contentView = _contentView;
@synthesize groupNumberLabel = _groupNumberLabel;
@synthesize numberLabel1 = _numberLabel1;
@synthesize numberLabel2 = _numberLabel2;
@synthesize numberLabel3 = _numberLabel3;
@synthesize numberLabel4 = _numberLabel4;
@synthesize numberLabel5 = _numberLabel5;
@synthesize unitLabel = _unitLabel;
@synthesize discountLabel = _discountLabel;
@synthesize discountUnitLabel = _discountUnitLabel;
@synthesize discountLowLabel = _discountLowLabel;
@synthesize discountHighLabel = _discountHighLabel;

@synthesize image1 = _image1;
@synthesize image2 = _image2;
@synthesize image3 = _image3;
@synthesize image4 = _image4;
@synthesize image5 = _image5;
@synthesize image6 = _image6;

@synthesize progressBackground = _progressBackground;
@synthesize progressImageView = _progressImageView;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_contentView);
    TTVIEW_RELEASE_SAFELY(_groupNumberLabel);
    TTVIEW_RELEASE_SAFELY(_numberLabel1);
    TTVIEW_RELEASE_SAFELY(_numberLabel2);
    TTVIEW_RELEASE_SAFELY(_numberLabel3);
    TTVIEW_RELEASE_SAFELY(_numberLabel4);
    TTVIEW_RELEASE_SAFELY(_numberLabel5);
    TTVIEW_RELEASE_SAFELY(_unitLabel);
    TTVIEW_RELEASE_SAFELY(_discountLabel);
    TTVIEW_RELEASE_SAFELY(_discountUnitLabel);
    TTVIEW_RELEASE_SAFELY(_discountHighLabel);
    TTVIEW_RELEASE_SAFELY(_discountLowLabel);
    
    TTVIEW_RELEASE_SAFELY(_image1);
    TTVIEW_RELEASE_SAFELY(_image2);
    TTVIEW_RELEASE_SAFELY(_image3);
    TTVIEW_RELEASE_SAFELY(_image4);
    TTVIEW_RELEASE_SAFELY(_image5);
    TTVIEW_RELEASE_SAFELY(_image6);
    
    TTVIEW_RELEASE_SAFELY(_progressBackground);
    TTVIEW_RELEASE_SAFELY(_progressImageView);
    
    TT_RELEASE_SAFELY(_groupDTO);
}

- (id)init
{
    self = [super init];
    if (self) 
    {
        self.frame = CGRectMake(7.5, 10, 305, 83);
        
        //self.backgroundColor = [UIColor lightGrayColor];
        self.backgroundColor = RGBCOLOR(247, 247, 247);
        
//        self.layer.shadowOffset = CGSizeMake(0.5, 0.5);
//        
//        self.layer.shadowRadius = 1.0;
//        self.layer.shadowColor = [UIColor blackColor].CGColor;
//        self.layer.shadowOpacity = 0.8;
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.layer.cornerRadius = 5.0;
        
        [self addSubviewsNeeded];
    }
    return self;
}

//test
/*
- (void)setItem:(GroupPurchaseDTO *)dto
{
    self.groupDTO = dto;
    
    self.numberLabel2.text = @"1";
    self.numberLabel3.text = @"2";
    self.numberLabel4.text = @"3";
    self.numberLabel5.text = @"5";
    
    
    
    self.discountHighLabel.text = @"60.00";
    [self setNeedsLayout];
    
    
}
*/

int intpart(float xx)  
{
    int yy=0;
    yy=(int)(xx+0.5);
    return yy;
}


- (void)setItem:(GroupPurchaseDTO *)dto
{
    if (dto == nil)
    {
        return;
    }
 
    self.groupDTO = dto;
    
    CGFloat maxNum = [self.groupDTO.limitQty floatValue];
    
    CGFloat average = maxNum / 4;
    
    DLog(@"average is : %f", average);
    
    self.numberLabel2.text = [NSString stringWithFormat:@"%d", intpart(average)];
    
    self.numberLabel3.text = [NSString stringWithFormat:@"%d", intpart(average*2)];
    
    self.numberLabel4.text = [NSString stringWithFormat:@"%d", intpart(average*3)];

    self.numberLabel5.text = self.groupDTO.limitQty;
    
    self.discountHighLabel.text = [NSString stringWithFormat:@"%.2f", [self.groupDTO.maxReward floatValue]];
    
    CGFloat applyNum = [self.groupDTO.subscribeAmount floatValue];
    
    if (maxNum == 0.0)
    {
        self.progressImageView.width = self.progressBackground.width;
    }
    else
    {
        self.progressImageView.width = self.progressBackground.width * applyNum / maxNum;
    }
    
    [self setNeedsLayout];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.numberLabel1.frame = CGRectMake(self.groupNumberLabel.right, self.groupNumberLabel.top, self.numberLabel1.size.width, self.numberLabel1.size.height);
    
    self.numberLabel2.frame = CGRectMake(self.numberLabel1.left + 45, self.groupNumberLabel.top, self.numberLabel2.size.width, self.numberLabel2.size.height);
    
    self.numberLabel3.frame = CGRectMake(self.numberLabel2.left + 45, self.groupNumberLabel.top, self.numberLabel3.size.width, self.numberLabel3.size.height);
    
    self.numberLabel4.frame = CGRectMake(self.numberLabel3.left + 45, self.groupNumberLabel.top, self.numberLabel4.size.width, self.numberLabel4.size.height);
    
    self.numberLabel5.frame = CGRectMake(self.numberLabel4.left + 45, self.groupNumberLabel.top, self.numberLabel5.size.width, self.numberLabel5.size.height);
    
    self.unitLabel.frame = CGRectMake(self.numberLabel5.right+5, self.groupNumberLabel.top, self.unitLabel.size.width, self.unitLabel.size.height);
    
    self.image1.frame = CGRectMake(self.numberLabel1.left-5, self.numberLabel1.bottom, self.image1.size.width, self.image1.size.height);
    
    self.image2.frame = CGRectMake(self.image1.right, self.numberLabel1.bottom, self.image2.size.width, self.image2.size.height);
    
    self.image3.frame = CGRectMake(self.image2.right, self.numberLabel1.bottom, self.image3.size.width, self.image3.size.height);
    
    self.image4.frame = CGRectMake(self.image3.right, self.numberLabel1.bottom, self.image4.size.width, self.image4.size.height);
    
    self.image5.frame = CGRectMake(self.image4.right, self.numberLabel1.bottom, self.image5.size.width, self.image5.size.height);
    
    self.image6.frame = CGRectMake(self.image5.right, self.numberLabel1.bottom, self.image6.size.width, self.image6.size.height);
    
    self.progressBackground.frame = CGRectMake(self.image2.left, self.image1.bottom, self.progressBackground.size.width, self.progressBackground.size.height);
    
    self.progressImageView.frame = CGRectMake(self.progressBackground.left, self.progressBackground.top, self.progressImageView.size.width, self.progressImageView.size.height);
    
    self.discountLabel.frame = CGRectMake(self.groupNumberLabel.left, self.progressImageView.bottom+5, self.discountLabel.size.width, self.discountLabel.size.height);
    
    self.discountLowLabel.frame = CGRectMake(self.discountLabel.right, self.discountLabel.top, self.discountLowLabel.size.width, self.discountLowLabel.size.height);
    
    self.discountHighLabel.top = self.discountLabel.top;
    
    self.discountHighLabel.right = self.progressBackground.right;
    
    self.discountUnitLabel.frame = CGRectMake(self.unitLabel.left, self.discountLabel.top, self.discountUnitLabel.size.width, self.discountUnitLabel.size.height);
}

- (void)addSubviewsNeeded
{
    self.groupNumberLabel.text = L(@"Group_Purchase_Count");
    
    self.numberLabel1.text = @"0";
    self.unitLabel.text = L(@"Item");
    
    self.discountLabel.text = L(@"Discount Price");
    self.discountLowLabel.text = @"0.00";
    self.discountUnitLabel.text = L(@"RMB");
    
    self.progressBackground.backgroundColor = RGBCOLOR(63, 73, 83);
    
    UIImage *image = [UIImage imageNamed:@"product_gp_progressBar.png"];    
    UIImage *im = [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:0];    
    self.progressImageView.image = im;
    
    self.image1.image = [UIImage imageNamed:@"product_gp_curve_left.png"];
    self.image2.image = [UIImage imageNamed:@"product_gp_curve_center.png"];
    self.image3.image = [UIImage imageNamed:@"product_gp_curve_center.png"];
    self.image4.image = [UIImage imageNamed:@"product_gp_curve_center.png"];
    self.image5.image = [UIImage imageNamed:@"product_gp_curve_center.png"];
    self.image6.image = [UIImage imageNamed:@"product_gp_curve_right.png"];

}

- (UIView *)contentView
{
    if (!_contentView)
    {
        _contentView = [[UIView alloc] initWithFrame:self.bounds];
        
        _contentView.layer.cornerRadius = 5.0;
        
        _contentView.layer.masksToBounds = YES;
        
        [self.layer addSublayer:_contentView.layer];
    }
    return _contentView;
}

- (UILabel *)groupNumberLabel
{
    if (!_groupNumberLabel)
    {
        _groupNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 67, 25)];
        
        _groupNumberLabel.backgroundColor = [UIColor clearColor];
        
        _groupNumberLabel.font = [UIFont systemFontOfSize:14.0];
        
        [self addSubview:_groupNumberLabel];
    }
    return _groupNumberLabel;
}

- (UILabel *)numberLabel1
{
    if (!_numberLabel1)
    {
        _numberLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 25, 25)];
        
        _numberLabel1.backgroundColor = [UIColor clearColor];
        
        _numberLabel1.font = [UIFont systemFontOfSize:14.0];
        
        [self addSubview:_numberLabel1];
    }
    return _numberLabel1;
}

- (UILabel *)numberLabel2
{
    if (!_numberLabel2)
    {
        _numberLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 25, 25)];
        
        _numberLabel2.backgroundColor = [UIColor clearColor];
        
        _numberLabel2.font = [UIFont systemFontOfSize:14.0];
        
        _numberLabel2.text = @"0";
        
        [self addSubview:_numberLabel2];
    }
    return _numberLabel2;
}

- (UILabel *)numberLabel3
{
    if (!_numberLabel3)
    {
        _numberLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 25, 25)];
        
        _numberLabel3.backgroundColor = [UIColor clearColor];
        
        _numberLabel3.font = [UIFont systemFontOfSize:14.0];
        
        _numberLabel3.text = @"0";
        
        [self addSubview:_numberLabel3];
    }
    return _numberLabel3;
}

- (UILabel *)numberLabel4
{
    if (!_numberLabel4)
    {
        _numberLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 25, 25)];
        
        _numberLabel4.backgroundColor = [UIColor clearColor];
        
        _numberLabel4.font = [UIFont systemFontOfSize:14.0];
        
        _numberLabel4.text = @"0";
        
        [self addSubview:_numberLabel4];
    }
    return _numberLabel4;
}

- (UILabel *)numberLabel5
{
    if (!_numberLabel5)
    {
        _numberLabel5 = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 25, 25)];
        
        _numberLabel5.backgroundColor = [UIColor clearColor];
        
        _numberLabel5.font = [UIFont systemFontOfSize:14.0];
        
        _numberLabel5.text = @"0";
        
        [self addSubview:_numberLabel5];
    }
    return _numberLabel5;
}

- (UILabel *)unitLabel
{
    if (!_unitLabel)
    {
        _unitLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 25, 25)];
        
        _unitLabel.backgroundColor = [UIColor clearColor];
        
        _unitLabel.font = [UIFont systemFontOfSize:14.0];
        
        [self addSubview:_unitLabel];
    }
    return _unitLabel;
}

- (UILabel *)discountLabel
{
    if (!_discountLabel)
    {
        _discountLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 67, 25)];
        
        _discountLabel.backgroundColor = [UIColor clearColor];
        
        _discountLabel.font = [UIFont systemFontOfSize:14.0];
        
        [self addSubview:_discountLabel];
    }
    return _discountLabel;
}

- (UILabel *)discountLowLabel
{
    if (!_discountLowLabel)
    {
        _discountLowLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 40, 25)];
        
        _discountLowLabel.backgroundColor = [UIColor clearColor];
        
        _discountLowLabel.font = [UIFont systemFontOfSize:14.0];
            
        [self addSubview:_discountLowLabel];
    }
    return _discountLowLabel;
}

- (UILabel *)discountHighLabel
{
    if (!_discountHighLabel)
    {
        _discountHighLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 50, 25)];
        
        _discountHighLabel.backgroundColor = [UIColor clearColor];
        
        _discountHighLabel.font = [UIFont systemFontOfSize:14.0];
        
        _discountHighLabel.textAlignment = UITextAlignmentRight;
        
        _discountHighLabel.text = @"60.00";
        
        [self addSubview:_discountHighLabel];
    }
    return _discountHighLabel;
}

- (UILabel *)discountUnitLabel
{
    if (!_discountUnitLabel)
    {
        _discountUnitLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 50, 25)];
        
        _discountUnitLabel.backgroundColor = [UIColor clearColor];
        
        _discountUnitLabel.font = [UIFont systemFontOfSize:14.0];
        
        [self addSubview:_discountUnitLabel];
    }
    return _discountUnitLabel;
}

- (UIView *)progressBackground
{
    if (!_progressBackground)
    {
        _progressBackground = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 180, 11)];
                
        [self addSubview:_progressBackground];
    }
    return _progressBackground;
}

- (UIImageView *)progressImageView
{
    if (!_progressImageView)
    {
        _progressImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 45, 11)];
        
        [self addSubview:_progressImageView];
    }
    return _progressImageView;
}

- (UIImageView *)image1
{
    if (!_image1)
    {
        _image1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 8, 7)];
        
        [self addSubview:_image1];
    }
    return _image1;
}

- (UIImageView *)image2
{
    if (!_image2)
    {
        _image2 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 45, 7)];
                
        [self addSubview:_image2];
    }
    return _image2;
}

- (UIImageView *)image3
{
    if (!_image3)
    {
        _image3 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 45, 7)];
                
        [self addSubview:_image3];
    }
    return _image3;
}

- (UIImageView *)image4
{
    if (!_image4)
    {
        _image4 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 45, 7)];
                
        [self addSubview:_image4];
    }
    return _image4;
}

- (UIImageView *)image5
{
    if (!_image5)
    {
        _image5 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 45, 7)];
                
        [self addSubview:_image5];
    }
    return _image5;
}

- (UIImageView *)image6
{
    if (!_image6)
    {
        _image6 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 8, 7)];
                
        [self addSubview:_image6];
    }
    return _image6;
}
@end
