//
//  TotalPriceView.m
//  SuningEBuy
//
//  Created by  zhang jian on 14-1-26.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "TotalPriceView.h"

#define defaultFont         [UIFont boldSystemFontOfSize:16.0]

@implementation TotalPriceView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = RGBACOLOR(255, 255, 255, 0.9);
        
//        UIImageView *line = [[UIImageView alloc] init];
//        line.frame = CGRectMake(0, 0, 320, 0.5);
//        line.image = [UIImage streImageNamed:@"line.png"];
//        [self addSubview:line];
        
    }
    return self;
}

- (UILabel *)totalNameLabel
{
    if (!_totalNameLabel) {
        _totalNameLabel = [[UILabel alloc] init];
        _totalNameLabel.backgroundColor = [UIColor clearColor];
        _totalNameLabel.textColor = [UIColor light_Black_Color];
        _totalNameLabel.font = defaultFont;
        [self addSubview:_totalNameLabel];
    }
    return _totalNameLabel;
}

- (UILabel *)totalPriceLabel
{
    if (!_totalPriceLabel) {
        _totalPriceLabel = [[UILabel alloc] init];
        _totalPriceLabel.backgroundColor = [UIColor clearColor];
        _totalPriceLabel.textColor = [UIColor orange_Red_Color];
        _totalPriceLabel.font = defaultFont;
        _totalPriceLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_totalPriceLabel];
    }
    return _totalPriceLabel;
}

- (UILabel *)farPriceLabel
{
    if (!_farPriceLabel) {
        _farPriceLabel = [[UILabel alloc] init];
        _farPriceLabel.backgroundColor = [UIColor clearColor];
        _farPriceLabel.textColor = [UIColor dark_Gray_Color];
        _farPriceLabel.font = [UIFont boldSystemFontOfSize:14.0];
        [self addSubview:_farPriceLabel];
    }
    return _farPriceLabel;
}

- (void)setTotalPrice:(NSString *)totalPrice farPrice:(NSString *)farPrice
{
    self.totalNameLabel.text = @"共计：";
    self.totalPriceLabel.text = totalPrice;
    self.farPriceLabel.text = [NSString stringWithFormat:@"含运费%@",farPrice];
 
    self.totalNameLabel.frame = CGRectMake(15, 4, 50, 20);
//    self.totalNameLabel.text = [NSString stringWithFormat:@"总额（含运费）%@",totalPrice];
//    CGSize size = [totalPrice sizeWithFont:defaultFont];
    
    self.totalPriceLabel.frame = CGRectMake(self.totalNameLabel.right - 5, 5, 106, 20);
    
    self.farPriceLabel.frame = CGRectMake(15, self.totalNameLabel.bottom, 150, 20);
    
}

+ (CGFloat)heightOfView
{
    return 44;
}

@end
