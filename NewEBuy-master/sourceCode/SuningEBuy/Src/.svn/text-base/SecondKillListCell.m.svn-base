//
//  SecondKillListCell.m
//  SuningEBuy
//
//  Created by cui zl on 13-2-26.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "SecondKillListCell.h"
#import "SNGraphics.h"
#import "NSAttributedString+Attributes.h"

#define kTitleTextColor1     RGBCOLOR(0, 102, 102)
#define kTitleTextColor2     RGBCOLOR(0, 51, 102)

#define kReadyForSaleTextColor RGBCOLOR(102, 102, 0)

#define kSaleOutTextColor      RGBCOLOR(102, 102, 102)
#define kSaleOutTextColor2     RGBCOLOR(25, 25, 25)

@implementation SecondKillListCell
{
    BOOL isTomorrow;
}

@synthesize backgroundImageView = _backgroundImageView;
@synthesize stateTitleLabel = _stateTitleLabel;
@synthesize timeLabel = _timeLabel;
@synthesize productDescLabel = _productDescLabel;
@synthesize productImageView = _productImageView;
@synthesize leftQtyLbl = _leftQtyLbl;
@synthesize priceLbl = _priceLbl;
@synthesize panicPurchaseDTO = _panicPurchaseDTO;
@synthesize purchaseState = purchaseState_;
@synthesize calculagraph = _calculagraph;
@synthesize bottomBgImgView = _bottomBgImgView;
@synthesize priceBgImgView = _priceBgImgView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        self.frame = CGRectMake(0, 0, 320, 273);
        
        self.contentView.frame = CGRectMake(0, 0, 320, 273);
        
        isTomorrow = NO;

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}

- (void)dealloc {
    
    TT_RELEASE_SAFELY(_backgroundImageView);
    TT_RELEASE_SAFELY(_stateTitleLabel);
    TT_RELEASE_SAFELY(_timeLabel);
    TT_RELEASE_SAFELY(_productDescLabel);
    TT_RELEASE_SAFELY(_productImageView);
    TT_RELEASE_SAFELY(_leftQtyLbl)
    TT_RELEASE_SAFELY(_priceLbl);
    TT_RELEASE_SAFELY(_panicPurchaseDTO);
    TT_RELEASE_SAFELY(_bottomBgImgView);
    TT_RELEASE_SAFELY(_priceBgImgView);

    [_calculagraph removeObserver:self forKeyPath:@"time"];
    
    TT_RELEASE_SAFELY(_calculagraph);

}


- (void)setItem:(PanicPurchaseDTO*)dto
{
    if (dto == nil) {
        return;
    }
    
    self.panicPurchaseDTO = dto;
    
    purchaseState_ = self.panicPurchaseDTO.purchaseState;
    
    self.productDescLabel.text = [NSString stringWithFormat:@"%@ %@", self.panicPurchaseDTO.catentryName, (self.panicPurchaseDTO.descriptions?self.panicPurchaseDTO.descriptions:@"")];
    self.productImageView.imageURL = self.panicPurchaseDTO.imageURL;
    self.leftQtyLbl.text = [NSString stringWithFormat:L(@"SK_surplus：%@piece"),self.panicPurchaseDTO.leftQty];
    self.priceLbl.text = [NSString stringWithFormat:@"￥%.2f", [(self.panicPurchaseDTO.rushPurPrice?self.panicPurchaseDTO.rushPurPrice:@"") floatValue]];
    
    if ([self.panicPurchaseDTO.leftQty isEqualToString:@"0"]) {
        
        purchaseState_ = TimeOver;
        
    }
    
    //判断开始时间是否为第二天
    
   NSString *currentDate =  [NSDate stringFromDate:[NSDate date] withFormat:@"yyyy-MM-dd"] ;

    NSString *startDate = [dto.startTime substringToIndex:10];
    
    if(![currentDate isEqualToString:startDate])
    {
        isTomorrow = YES;
        
    }
    
    [self reloadAllData];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"time"]) {
            
            double seconds = [[change objectForKey:@"new"] floatValue];
            
            double leavingTime = 0;
            
            switch (self.purchaseState) {
                case ReadyForSale:
                {
                    leavingTime = (double)self.panicPurchaseDTO.startTimeSeconds - seconds;
                    break;
                }
                case OnSale:
                {
                    leavingTime = (double)self.panicPurchaseDTO.endTimeSeconds - seconds;
                    break;
                }
                case SaleOut:
                {
                    break;
                }
                default:
                    break;
            }
         [self setTime:leavingTime];
    
    }
}

- (void)reloadAllData
{
    
    UIImage *img = nil;
    UIImage *priceImg = nil;
    switch (purchaseState_) {
        case ReadyForSale:
        {
            self.stateTitleLabel.text = L(@"Ready to start");
            if(isTomorrow)
            {
                NSString *time  = [self.panicPurchaseDTO.startTime substringFromIndex:10];
                NSString *timeStr = [NSString stringWithFormat:@"%@%@%@",L(@"start time"),time,L(@"SecondKill_NextDay")];
                NSMutableAttributedString *timeAtt = [[NSMutableAttributedString alloc]initWithString:timeStr];
                
                [timeAtt setTextAlignment:kCTTextAlignmentCenter lineBreakMode:kCTLineBreakByWordWrapping];
                
                [timeAtt setFont:[UIFont systemFontOfSize:18]];
                
                [timeAtt setTextColor:[UIColor whiteColor]];
                
                NSRange  timerang =  [timeStr rangeOfString:L(@"SecondKill_NextDay")];
                
                [timeAtt setFont:[UIFont systemFontOfSize:13] range:timerang];
                
                self.timeLabel.attributedText = timeAtt;
                
                TT_RELEASE_SAFELY(timeAtt);
                
                
            }else{
                self.timeLabel.text = [self.panicPurchaseDTO.startTime substringFromIndex:10]; 
            }
            img = [UIImage imageNamed:@"SK_LIST_BG_future.png"];
            priceImg = [UIImage imageNamed:@"SK_LIST_price.png"];
            
            break;
        }
        case OnSale:
        {
            self.stateTitleLabel.text = L(@"SK is going");
            img = [UIImage imageNamed:@"SK_LIST_BG_ontime.png"];
            priceImg = [UIImage imageNamed:@"SK_LIST_price.png"];
            
            break;
        }
        case SaleOut:
        {
            self.stateTitleLabel.text = L(@"SK is over");
//            self.stateLabel.text = L(@"The time to end");
            self.timeLabel.text = [NSString stringWithFormat:@"%@%@", L(@"The time to end"),@"00:00:00" ];
            img = [UIImage imageNamed:@"SK_LIST_BG_offtime.png"];
            priceImg = [UIImage imageNamed:@"SK_LIST_price_offtime.png"];
            
            break;
        }
        case TimeOver:
        {
            self.stateTitleLabel.text = L(@"SK without ant piece");
            self.timeLabel.text = [NSString stringWithFormat:@"%@%@", L(@"The time to end"),@"00:00:00" ];
            img = [UIImage imageNamed:@"SK_LIST_BG_offtime.png"];
            priceImg = [UIImage imageNamed:@"SK_LIST_price_offtime.png"];
            
            [self.calculagraph stop];
            
            break;
            
        }
        default:
            break;
    }
    
    UIImage *image = [img stretchableImageWithLeftCapWidth:img.size.width / 2 topCapHeight:0];
    
    self.bottomBgImgView.image = image;
    
    self.priceBgImgView.image = priceImg;

}

- (void)setTime:(double)seconds
{
    if (purchaseState_ == SaleOut) {
        
        return;
    }
    if (seconds < 1) {
        if (purchaseState_ == ReadyForSale) {
            purchaseState_ = OnSale;
            self.panicPurchaseDTO.purchaseState = OnSale;
        }else if (purchaseState_ == OnSale){
            purchaseState_ = SaleOut;
            self.panicPurchaseDTO.purchaseState = SaleOut;

        }
        [self reloadAllData];
    }
    
    if(purchaseState_ == ReadyForSale)
    {
        return;
    }
    
    if(purchaseState_ == OnSale)
    {
         NSInteger hour = seconds / 3600;
    
         NSInteger minute = (seconds - hour * 3600) / 60;
    
         NSInteger second = (seconds - hour * 3600 - minute * 60);
    
         NSString *timeString = nil;
    
        if (hour >= 100) {
            timeString = [NSString stringWithFormat:@"%03d:%02d:%02d", hour, minute, second];
        }else{
            timeString = [NSString stringWithFormat:@"%02d:%02d:%02d", hour, minute, second];
        }
        self.timeLabel.text = [NSString stringWithFormat:@"%@%@",L(@"The time to end"),timeString];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    CGFloat fixPixel = 0;
//    if ([SystemInfo is_iPhone_5]) {
//        fixPixel= kIphone5Fix / 8;
//    }else{
//        fixPixel= 0;
//    }
    
    self.stateTitleLabel.frame = CGRectMake(0, 15, 300, 20);
    
    self.timeLabel.frame = CGRectMake(0,self.stateTitleLabel.bottom+5, 320, 25);
    
    self.productImageView.frame = CGRectMake(10,75, 160, 160);
    CGSize size = [self.productDescLabel.text sizeWithFont:self.productDescLabel.font constrainedToSize:CGSizeMake(130, 80) lineBreakMode:UILineBreakModeCharacterWrap];
    self.productDescLabel.frame = CGRectMake(self.productImageView.right+10,85, 115, size.height);

    self.leftQtyLbl.frame = CGRectMake(self.productImageView.right+25, 172, 100, 20);
    self.priceLbl.frame = CGRectMake(15,4, 100, 25);
    
    
    self.bottomBgImgView.frame = CGRectMake(9, 15, 302, 250);
    
    self.backgroundImageView.frame = CGRectMake(20, 10, 280, 15);
    
    self.priceBgImgView.frame = CGRectMake(self.productImageView.right+7, self.leftQtyLbl.bottom+3, 127, 37.5);
    
}

#pragma mark -
#pragma mark view getters

- (UIImageView *)backgroundImageView
{
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] init];
        
        UIImage *img = [UIImage imageNamed:@"SK_LIST_top.png"];
        
        _backgroundImageView.image = img;
        
        [self.contentView addSubview:_backgroundImageView];
    }
    return _backgroundImageView;
}



-(UIImageView *)bottomBgImgView
{
    
    if(_bottomBgImgView== nil)
    {
        _bottomBgImgView = [[UIImageView alloc]init];
        
        _bottomBgImgView.contentMode = UIViewContentModeScaleToFill;
    
        _bottomBgImgView.layer.shadowColor = [UIColor blackColor].CGColor;
        
        _bottomBgImgView.layer.shadowOffset = CGSizeMake(0.8, 0.8);
        
        _bottomBgImgView.layer.shadowOpacity = 0.3;
        
        [self.contentView addSubview:_bottomBgImgView];
    
    }
    return _bottomBgImgView;
}

-(UIImageView *)priceBgImgView
{
    if(_priceBgImgView == nil)
    {
        _priceBgImgView = [[UIImageView alloc]init];
        
        [self.bottomBgImgView addSubview:_priceBgImgView];
    }
    return _priceBgImgView;
}

-(FXLabel *)stateTitleLabel
{
    if(_stateTitleLabel == nil)
    {
        _stateTitleLabel = [[FXLabel alloc]init];
        
        _stateTitleLabel.backgroundColor = [UIColor clearColor];
        
        _stateTitleLabel.textColor = [UIColor whiteColor];
        
        _stateTitleLabel.textAlignment = UITextAlignmentCenter;
        
        _stateTitleLabel.font = [UIFont boldSystemFontOfSize:18];
        
        [self.bottomBgImgView addSubview:_stateTitleLabel];
        
    }
    
    return  _stateTitleLabel;
}


- (OHAttributedLabel *)timeLabel
{
    if (!_timeLabel) {
        
        _timeLabel = [[OHAttributedLabel alloc] init];
        
        _timeLabel.backgroundColor = [UIColor clearColor];
        
        _timeLabel.font = [UIFont systemFontOfSize:18.0];
        
        _timeLabel.textColor = [UIColor whiteColor];
        
        _timeLabel.adjustsFontSizeToFitWidth = YES;
        
        _timeLabel.textAlignment = UITextAlignmentCenter;
        
		_timeLabel.autoresizingMask = UIViewAutoresizingNone;
        
        [self.bottomBgImgView addSubview:_timeLabel];
    }
    return _timeLabel;
}


- (FXLabel *)productDescLabel
{
    if (!_productDescLabel) {
        _productDescLabel = [[FXLabel alloc] init];
        
        _productDescLabel.backgroundColor = [UIColor clearColor];
        
        _productDescLabel.font = [UIFont systemFontOfSize:13];
        
        _productDescLabel.numberOfLines = 0;
        
        _productDescLabel.lineBreakMode = UILineBreakModeCharacterWrap;
        
        _productDescLabel.textColor = [UIColor whiteColor];
        
        [self.bottomBgImgView addSubview:_productDescLabel];
    }
    return _productDescLabel;
}

- (EGOImageViewEx *)productImageView
{
    if (!_productImageView) {
        
        _productImageView = [[EGOImageViewEx alloc] init];
        _productImageView.placeholderImage = [UIImage imageNamed:kProductImageViewDefultImage];
        _productImageView.exDelegate = self;
        
        _productImageView.userInteractionEnabled = YES;
        
        CALayer *layer = [_productImageView layer];
        
        [layer setMasksToBounds:YES];
        
        [layer setCornerRadius:5.0];
        
        [layer setBorderWidth:1.0];
        
        [layer setBorderColor:[UIColor clearColor].CGColor];
        
        _productImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.bottomBgImgView addSubview:_productImageView];
    }
    return _productImageView;
}

-(UILabel *)leftQtyLbl
{
    if(_leftQtyLbl == nil)
    {
        _leftQtyLbl = [[UILabel alloc]init];
        
        _leftQtyLbl.backgroundColor = [UIColor clearColor];
        
        _leftQtyLbl.textColor = [UIColor whiteColor];
        
        _leftQtyLbl.textAlignment = UITextAlignmentLeft;

        _leftQtyLbl.font = [UIFont systemFontOfSize:13];
        
        [self.bottomBgImgView addSubview:_leftQtyLbl];
        
    }
    return _leftQtyLbl;
}

-(UILabel *)priceLbl
{
    if(_priceLbl == nil)
    {
        _priceLbl = [[UILabel alloc]init];
        
        _priceLbl.backgroundColor = [UIColor clearColor];
        
        _priceLbl.textColor = [UIColor whiteColor];
        
        _priceLbl.textAlignment = UITextAlignmentLeft;
        
        _priceLbl.font = [UIFont systemFontOfSize:21];
        
        [self.priceBgImgView addSubview:_priceLbl];
    }
    
    return _priceLbl;
}

- (void)setCalculagraph:(Calculagraph *)calculagraph
{
    if (_calculagraph != calculagraph) {
        [_calculagraph removeObserver:self forKeyPath:@"time"];
        _calculagraph = calculagraph;
        [_calculagraph addObserver:self
                        forKeyPath:@"time"
                           options:NSKeyValueObservingOptionNew
                           context:nil];
    }
}

@end

