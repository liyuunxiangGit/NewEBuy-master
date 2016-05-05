//
//  GBGoodsDetialFirstCell.m
//  SuningEBuy
//
//  Created by  zhang jian on 13-2-26.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "GBGoodsDetialFirstCell.h"
#import "NSAttributedString+Attributes.h"

#define defaultFont   [UIFont boldSystemFontOfSize:15.0]

@interface GBGoodsDetialFirstCell()

@property (nonatomic, strong) EGOImageView                  *gbGoodsView;
@property (nonatomic, strong) UILabel                       *surplusTime;
@property (nonatomic, strong) UILabel                       *saleCount;
@property (nonatomic, strong) UIImageView                   *seperatorView;

@property (nonatomic, strong) Calculagraph                  *calculagraph;
@property (nonatomic, strong) StrikeThroughLabel            *originalPriceLabel;
@property (nonatomic, strong) OHAttributedLabel             *discountPriceLabel;
@property (nonatomic, strong) UIImageView                   *headImage;

@end


@implementation GBGoodsDetialFirstCell

@synthesize gbGoodsView             = _gbGoodsView;
@synthesize saleCount               = _saleCount;
@synthesize surplusTime             = _surplusTime;
@synthesize buyBtn                  = _buyBtn;
@synthesize seperatorView           = _seperatorView;

@synthesize gbGoodsDetailDto        = _gbGoodsDetailDto;
@synthesize calculagraph            = _calculagraph;
@synthesize originalPriceLabel      = _originalPriceLabel;
@synthesize discountPriceLabel      = _discountPriceLabel;
@synthesize headImage               = _headImage;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_gbGoodsView);
    TT_RELEASE_SAFELY(_saleCount);
    TT_RELEASE_SAFELY(_surplusTime);
    TT_RELEASE_SAFELY(_buyBtn);
    TT_RELEASE_SAFELY(_seperatorView);
    
    TT_RELEASE_SAFELY(_headImage);
    TT_RELEASE_SAFELY(_gbGoodsDetailDto);
    
    [_calculagraph stop];
    [_calculagraph removeObserver:self forKeyPath:@"time"];
    TT_RELEASE_SAFELY(_calculagraph);
    TT_RELEASE_SAFELY(_discountPriceLabel);
    TT_RELEASE_SAFELY(_originalPriceLabel);
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setGbGoodsDetailDto:(GBGoodsDetailDTO *)gbGoodsDetailDto
{
    if (_gbGoodsDetailDto != gbGoodsDetailDto) {
        _gbGoodsDetailDto = gbGoodsDetailDto;
        
        self.gbGoodsView.imageURL = _gbGoodsDetailDto.imgBUrl;
       
        [self setTime:[_gbGoodsDetailDto.surplusTime floatValue]];
        
        NSString *saleCount = [NSString stringWithFormat:@"%@%@",_gbGoodsDetailDto.saleCount,L(@"GBPeople")];
        self.saleCount.text = saleCount;
        CGSize size = [saleCount sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(280, 1000) lineBreakMode:UILineBreakModeCharacterWrap];
        self.saleCount.frame = CGRectMake(0, 0, size.width, 0);
        
        if ([_gbGoodsDetailDto.ifEnd isEqualToString:@"0"]) {
            self.buyBtn.userInteractionEnabled = YES;
        }else{
            self.buyBtn.userInteractionEnabled = NO;
            [self.buyBtn setTitle:L(@"SK is over") forState:UIControlStateNormal];
            [self.buyBtn setBackgroundImage:[UIImage imageNamed:@"button_white_disable.png"] forState:UIControlStateNormal];
            self.surplusTime.text = L(@"GBGroupBuyIsOver");
        }
        
        float discountP = [_gbGoodsDetailDto.presentPrice floatValue];
        NSString * discountPrice = [NSString stringWithFormat:@"¥%.2f", discountP];
        NSMutableAttributedString *discountPriceAttStr =[[NSMutableAttributedString alloc] initWithString:discountPrice];
        [discountPriceAttStr setFont:[UIFont boldSystemFontOfSize:18]];
        [discountPriceAttStr setTextColor:RGBCOLOR(245, 48, 9)];
        self.discountPriceLabel.attributedText = discountPriceAttStr;

        float orignalPrice = [_gbGoodsDetailDto.orignalPrice floatValue];
        NSString * orignalPriceStr = [NSString stringWithFormat:@"%.2f", orignalPrice];
        
        NSString * originalPrice = [NSString stringWithFormat:@"%@%@", L(@"GBOriginalPrice2"), orignalPriceStr];
        self.originalPriceLabel.text = originalPrice;
      
        [self.calculagraph start];
    }
}

- (Calculagraph *)calculagraph
{
    if (!_calculagraph) {
        _calculagraph = [[Calculagraph alloc] init];
        [_calculagraph addObserver:self
                        forKeyPath:@"time"
                           options:NSKeyValueObservingOptionNew
                           context:nil];
    }
    return _calculagraph;
}

#pragma mark -
#pragma mark calculagraph delegate methods

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"time"]) {
        CGFloat seconds = [[change objectForKey:@"new"] floatValue];
        double leavingTime = 0;
        leavingTime = [_gbGoodsDetailDto.surplusTime doubleValue] - seconds;
        [self setTime:leavingTime];
    }
    [self setNeedsLayout];
}

- (void)setTime:(double)seconds
{
    if (seconds <= 0)//团购结束时需要更改的ui
    {
        self.buyBtn.userInteractionEnabled = NO;
        [self.buyBtn setTitle:L(@"SK is over") forState:UIControlStateNormal];
        self.surplusTime.text = L(@"GBGroupBuyIsOver");
        return;
    }
    NSInteger day = seconds / 3600 / 24 ;
    
    NSInteger hour = (seconds - day * 3600 * 24)/ 3600 ;
    
    NSInteger minute = (seconds - day * 3600 * 24 -hour * 3600) / 60;
    
    NSString *timeString = [NSString stringWithFormat:@"%d%@%d%@%d%@",day , L(@"GBDay"),hour, L(@"GBHour"),minute,L(@"GBMinute")];
    self.surplusTime.text = [NSString stringWithFormat:@"%@%@",L(@"GBLeft"),timeString];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.gbGoodsView.frame = CGRectMake(15, 15, 290, 150);
    self.buyBtn.frame = CGRectMake(170, self.gbGoodsView.bottom + 15, 135, 35);
    
    self.discountPriceLabel.frame = CGRectMake(15, self.gbGoodsView.bottom + 13, self.discountPriceLabel.width, self.discountPriceLabel.height);
    self.originalPriceLabel.frame = CGRectMake(15, self.discountPriceLabel.bottom , self.originalPriceLabel.width, self.originalPriceLabel.height);
    
    self.surplusTime.frame = CGRectMake(15, self.buyBtn.bottom + 8, 150, 20);
    
    self.headImage.frame = CGRectMake(245, self.surplusTime.top + 2, 17, 14);
    self.saleCount.frame = CGRectMake(self.headImage.right + 4, self.surplusTime.top, self.saleCount.width, 20);
    
    
    self.seperatorView.frame = CGRectMake(15, self.bounds.size.height - 1, 305, 0.5);
}

- (OHAttributedLabel *)discountPriceLabel{
    
    if (!_discountPriceLabel) {
        _discountPriceLabel = [[OHAttributedLabel alloc] initWithFrame:CGRectMake(0, 0, 120, 25)];
      
        _discountPriceLabel.backgroundColor = [UIColor clearColor];
        
        _discountPriceLabel.shadowColor = [UIColor whiteColor];
        
        [self.contentView addSubview:_discountPriceLabel];
    }
    return _discountPriceLabel;
}


- (StrikeThroughLabel *)originalPriceLabel{
    
    if (!_originalPriceLabel) {
        
        _originalPriceLabel = [[StrikeThroughLabel alloc] initWithFrame:CGRectMake(0, 0, 120, 15)];
        
        _originalPriceLabel.backgroundColor = [UIColor clearColor];
        
        _originalPriceLabel.textColor = [UIColor lightGrayColor];
        
        _originalPriceLabel.textAlignment = UITextAlignmentLeft;
        
        _originalPriceLabel.font = [UIFont systemFontOfSize:15.0];
        
        _originalPriceLabel.shadowColor = [UIColor whiteColor];
        
        _originalPriceLabel.shadowOffset = CGSizeMake(1, 1);
        
        _originalPriceLabel.isWithStrikeThrough = YES;
        
        [self.contentView addSubview:_originalPriceLabel];
        
    }
    return _originalPriceLabel;
}


- (EGOImageView *)gbGoodsView
{
    if (!_gbGoodsView)
    {
        _gbGoodsView = [[EGOImageView alloc] init];
        
        _gbGoodsView.placeholderImage = [UIImage imageNamed:kProductImageViewDefultImage];
       
        _gbGoodsView.backgroundColor = [UIColor clearColor];
       
        _gbGoodsView.contentMode = UIViewContentModeScaleToFill;
       
        _gbGoodsView.layer.backgroundColor = [UIColor clearColor].CGColor;
      
        _gbGoodsView.layer.borderColor = RGBCOLOR(162, 162, 162).CGColor;
        
        _gbGoodsView.layer.borderWidth = 1;
       
        [_gbGoodsView.layer  setMasksToBounds:YES];
		
        [self.contentView addSubview:_gbGoodsView];
    }
    return _gbGoodsView;
}

- (UILabel *)surplusTime
{
    if (!_surplusTime)
    {
        _surplusTime = [[UILabel alloc] init];
        
        _surplusTime.backgroundColor = [UIColor clearColor];
                
        _surplusTime.font = defaultFont;
        
        _surplusTime.textColor = [UIColor grayColor];
        
        [self.contentView addSubview:_surplusTime];
    }
    return _surplusTime;
}

- (UILabel *)saleCount
{
    if (!_saleCount)
    {
        _saleCount = [[UILabel alloc] init];
        
        _saleCount.backgroundColor = [UIColor clearColor];
                
        _saleCount.textAlignment = UITextAlignmentRight;
        
        _saleCount.font = [UIFont systemFontOfSize:14.0];
        
        _saleCount.textColor = [UIColor grayColor];
        
        [self.contentView addSubview:_saleCount];
    }
    return _saleCount;
}

- (UIImageView *)seperatorView
{
    if (!_seperatorView)
    {
        _seperatorView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line.png"]];

        _seperatorView.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:_seperatorView];
    }
    return _seperatorView;
}

- (UIButton *)buyBtn
{
    if (!_buyBtn)
    {
        _buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _buyBtn.backgroundColor = [UIColor clearColor];
        
//        [_buyBtn setBackgroundImage:[UIImage imageNamed:@"GB_pay_submit.png"] forState:UIControlStateNormal];
        [_buyBtn setBackgroundImage:[UIImage imageNamed:@"submit_button_normal.png"] forState:UIControlStateNormal];

        [_buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_buyBtn setTitle:L(@"GBBuy") forState:UIControlStateNormal];
                
        [self.contentView addSubview:_buyBtn];
    }
    return _buyBtn;
}

- (UIImageView *)headImage
{
    if (!_headImage)
    {
        _headImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"GroupBuy_people_gray_normal.png"]];
        
        _headImage.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:_headImage];
    }
    return _headImage;
}

@end
