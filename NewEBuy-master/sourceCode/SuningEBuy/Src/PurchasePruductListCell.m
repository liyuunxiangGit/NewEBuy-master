//
//  PurchasePruductListCell.m
//  SuningEBuy
//
//  Created by cui zl on 13-6-15.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "PurchasePruductListCell.h"
#import "SNGraphics.h"
#import "NSAttributedString+Attributes.h"

#define kTitleTextColor1     RGBCOLOR(0, 102, 102)
#define kTitleTextColor2     RGBCOLOR(0, 51, 102)

#define kReadyForSaleTextColor RGBCOLOR(102, 102, 0)

#define kSaleOutTextColor      RGBCOLOR(102, 102, 102)
#define kSaleOutTextColor2     RGBCOLOR(25, 25, 25)
#define kPurchaseTimeColor     RGBCOLOR(108, 43, 4)
#define KStateTitle            RGBCOLOR(246, 92, 9)
#define KProduceDec            RGBCOLOR(173, 101, 8)

@implementation PurchasePruductListCell

@synthesize backgroundImageView = _backgroundImageView;
@synthesize stateTitleLabel = _stateTitleLabel;
//@synthesize timeLabel = _timeLabel;
@synthesize productDescLabel = _productDescLabel;
@synthesize productImageView = _productImageView;
@synthesize leftQtyLbl = _leftQtyLbl;
@synthesize priceLbl = _priceLbl;
@synthesize panicPurchaseDTO = _panicPurchaseDTO;
@synthesize purchaseState = purchaseState_;
@synthesize calculagraph = _calculagraph;
@synthesize bottomBgImgView = _bottomBgImgView;
@synthesize priceBgImgView = _priceBgImgView;
@synthesize timeButtonOne =_timeButtonOne;
@synthesize timeButtonTwo =_timeButtonTwo;
@synthesize timeButtonThree =_timeButtonThree;
@synthesize purchasePicture = _purchasePicture;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.frame = CGRectMake(0, 0, 320, 273);
        
        self.contentView.frame = CGRectMake(0, 0, 320, 273);
       // self.contentView.backgroundColor=[UIColor whiteColor];
        UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 84, 306, 185)];
        // bgImageView.contentMode = UIViewContentModeCenter;
        bgImageView.image = [UIImage imageNamed:@"puechase_white_new.png"];
        [self.contentView addSubview:bgImageView];
        [self.contentView sendSubviewToBack:bgImageView];
        
//        [self.contentView addSubview:self.purchasePicture];
//        [self.contentView sendSubviewToBack:self.purchasePicture];
        
        
    }
    return self;
}

- (void)dealloc {
    
    TT_RELEASE_SAFELY(_backgroundImageView);
    TT_RELEASE_SAFELY(_stateTitleLabel);
    //TT_RELEASE_SAFELY(_timeLabel);
    TT_RELEASE_SAFELY(_productDescLabel);
    TT_RELEASE_SAFELY(_productImageView);
    TT_RELEASE_SAFELY(_leftQtyLbl)
    TT_RELEASE_SAFELY(_priceLbl);
    TT_RELEASE_SAFELY(_panicPurchaseDTO);
    TT_RELEASE_SAFELY(_bottomBgImgView);
    TT_RELEASE_SAFELY(_priceBgImgView);
    TT_RELEASE_SAFELY(_timeButtonOne);
    TT_RELEASE_SAFELY(_timeButtonTwo);
    TT_RELEASE_SAFELY(_timeButtonThree);
    [_calculagraph removeObserver:self forKeyPath:@"time"];
    TT_RELEASE_SAFELY(_calculagraph);
    
}


- (void)setItem:(PanicPurchaseDTO*)dto
{
    if (dto == nil) {
        return;
    }
        
    TT_RELEASE_SAFELY(_panicPurchaseDTO)
    
    _panicPurchaseDTO = dto;
    
    purchaseState_ = self.panicPurchaseDTO.purchaseState;
    
    self.productDescLabel.text = [NSString stringWithFormat:@"%@ %@", self.panicPurchaseDTO.catentryName, (self.panicPurchaseDTO.descriptions?self.panicPurchaseDTO.descriptions:@"")];
    self.productImageView.imageURL = self.panicPurchaseDTO.imageURL;
    self.leftQtyLbl.text = [NSString stringWithFormat:L(@"SK_surplus：%@piece"),self.panicPurchaseDTO.leftQty];
    self.priceLbl.text = [NSString stringWithFormat:@"￥%.2f", [(self.panicPurchaseDTO.rushPurPrice?self.panicPurchaseDTO.rushPurPrice:@"") floatValue]];
    
    if ([self.panicPurchaseDTO.leftQty isEqualToString:@"0"]) {
        
        purchaseState_ = SaleOut;
        
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
                leavingTime = (double)self.panicPurchaseDTO.startTimeSeconds- seconds;
                break;
            }
            case OnSale:
            {
                leavingTime = (double)self.panicPurchaseDTO.endTimeSeconds - seconds;
                break;
            }
            case SaleOut:
            {
                leavingTime = (double)self.panicPurchaseDTO.endTimeSeconds - seconds;
                break;
            }
            case TimeOver:
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
            self.stateTitleLabel.textColor = KStateTitle ;
            //self.timeLabel.text = [self.panicPurchaseDTO.startTime substringFromIndex:10];
            img = [UIImage imageNamed:@"Purchase_Yellow_new.png"];
            priceImg = [UIImage imageNamed:@"SK_LIST_price.png"];
            
            break;
        }
        case OnSale:
        {
           self.stateTitleLabel.text = L(@"Purchase is going");
            self.stateTitleLabel.textColor = KStateTitle ;
            img = [UIImage imageNamed:@"Purchase_Yellow_new.png"];
            priceImg = [UIImage imageNamed:@"SK_LIST_price.png"];
            
            break;
        }
        case SaleOut:
        {
            self.stateTitleLabel.text = L(@"SK without ant piece");
            img = [UIImage imageNamed:@"Purchase_Yellow_new.png"];
            priceImg = [UIImage imageNamed:@"SK_LIST_price_offtime.png"];
            
            break;
        }
        case TimeOver:
        {
            self.stateTitleLabel.text = L(@"SK is over");
            //            self.stateLabel.text = L(@"The time to end");
           // self.timeLabel.text = [NSString stringWithFormat:@"%@", @"00时00分00秒" ];
            img = [UIImage imageNamed:@"SK_LIST_BG_offtime.png"];
            priceImg = [UIImage imageNamed:@"SK_LIST_price_offtime.png"];
            
            break;
            
        }
        default:
            break;
    }
    
    UIImage *image = [img stretchableImageWithLeftCapWidth:img.size.width / 2 topCapHeight:0];
    
    self.bottomBgImgView.image = image;
    
    self.priceBgImgView.image = priceImg;
    
}

- (NSString *)insertWhiteSpaceInString:(NSString *)str
{
    NSUInteger len = [str length];
    
    NSMutableString *result = [NSMutableString string];
    for (int i = 0; i < len; i++)
    {
        NSString *part = [str substringWithRange:NSMakeRange(i, 1)];
        [result appendFormat:@"%@ ", part];
    }
    
    return [result substringToIndex:[result length]-1];
}
-(PurchasePictureView *)purchasePicture
{
    if (!_purchasePicture) {
        _purchasePicture =[[PurchasePictureView alloc] init];
        _purchasePicture.frame = CGRectMake(143, 43, 150, 30);
        _purchasePicture.backgroundColor= [UIColor clearColor];
        [self.contentView addSubview:_purchasePicture];
    }
    return _purchasePicture;
}

- (void)setTime:(double)seconds
{
    if (purchaseState_ == TimeOver) {
        
        return;
    }
    if (seconds < 1) {
        if (purchaseState_ == ReadyForSale) {
            purchaseState_ = OnSale;
            self.panicPurchaseDTO.purchaseState = OnSale;
        }else if (purchaseState_ == OnSale){
            purchaseState_ = TimeOver;
            self.panicPurchaseDTO.purchaseState = TimeOver;
        }
        else if (purchaseState_ == SaleOut)
        {
            purchaseState_ = TimeOver;
            self.panicPurchaseDTO.purchaseState = TimeOver;
        }
        [self reloadAllData];
    }
    
    NSInteger hour = seconds / 3600;
    
    NSInteger minute = (seconds - hour * 3600) / 60 >= 0 ? (seconds - hour * 3600) / 60 : 0;
    
    NSInteger second = (seconds - hour * 3600 - minute * 60) >= 0 ? (seconds - hour * 3600 - minute * 60) : 0;
    
    NSString *timeString = nil;
    
    
//    if(purchaseState_ == ReadyForSale)
//    {
//        timeString = [NSString stringWithFormat:@"%03d%02d%02d", hour, minute, second];
//        
//        NSString *string1 = [timeString substringWithRange:NSMakeRange(0, 1)];
//        
//        if (hour<100)
//        {
//            [self.purchasePicture setBtnTitle:@"" Tag:1];
//        }
//        else
//        {
//            [self.purchasePicture setBtnTitle:string1 Tag:1];
//
//        }
//        
//
//
//        //self.timeLabel.text = [self insertWhiteSpaceInString:timeString];
//        
//    }
//    
//    if(purchaseState_ == OnSale || purchaseState_ == SaleOut)
//    {
//        
//
//        
//    }
    
    timeString = [NSString stringWithFormat:@"%03d%02d%02d", hour, minute, second];
    
   
    [self.purchasePicture setTimeString:timeString];
    
    [self.bottomBgImgView addSubview:self.timeButtonOne];
    [self.bottomBgImgView addSubview:self.timeButtonTwo];
    [self.bottomBgImgView addSubview:self.timeButtonThree];

    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.stateTitleLabel.frame = CGRectMake(15, 28, 120, 20);
    
    //self.timeLabel.frame = CGRectMake(135,28, 150, 40);
    
    self.productImageView.frame = CGRectMake(10,75, 160, 160);
    CGSize size = [self.productDescLabel.text sizeWithFont:self.productDescLabel.font constrainedToSize:CGSizeMake(115, 80) lineBreakMode:UILineBreakModeCharacterWrap];
    self.productDescLabel.frame = CGRectMake(self.productImageView.right+8,89, size.width, size.height);
    
    self.leftQtyLbl.frame = CGRectMake(self.productImageView.right+25, 176, 100, 20);
    self.priceLbl.frame = CGRectMake(15,4, 110, 25);
    
    
    self.bottomBgImgView.frame = CGRectMake(8, 15, 306, 70);
    
    self.backgroundImageView.frame = CGRectMake(20, 9, 280, 15);
    
    self.priceBgImgView.frame = CGRectMake(self.productImageView.right+12, self.leftQtyLbl.bottom+19, 127, 37.5);
    
}

#pragma mark -
#pragma mark view getters

- (UIImageView *)backgroundImageView
{
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] init];
        
        UIImage *img = [UIImage imageNamed:@"SK_LIST_top_new.png"];
        
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
        
//        _bottomBgImgView.layer.shadowColor = [UIColor blackColor].CGColor;
//        
//        _bottomBgImgView.layer.shadowOffset = CGSizeMake(0.8, 0.8);
//        
//        _bottomBgImgView.layer.shadowOpacity = 0.3;
        
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
        
        _stateTitleLabel.textColor = [UIColor orangeColor];
        
        _stateTitleLabel.textAlignment = UITextAlignmentCenter;
        
        _stateTitleLabel.font = [UIFont boldSystemFontOfSize:16];
        
        [self.bottomBgImgView addSubview:_stateTitleLabel];
        
    }
    
    return  _stateTitleLabel;
}

//
//- (OHAttributedLabel *)timeLabel
//{
//    if (!_timeLabel) {
//        
//        _timeLabel = [[OHAttributedLabel alloc] init];
//        
//        _timeLabel.backgroundColor = [UIColor clearColor];
//        
//        _timeLabel.font = [UIFont systemFontOfSize:17.0];
//        //[priceStr setFont:[UIFont boldSystemFontOfSize:20.0f] range:NSMakeRange(3, [str length]-3)];
//        
//        _timeLabel.textColor = [UIColor whiteColor];
//        
//        _timeLabel.adjustsFontSizeToFitWidth = YES;
//        
//        _timeLabel.textAlignment = UITextAlignmentCenter;
//        
//		_timeLabel.autoresizingMask = UIViewAutoresizingNone;
//        
//        [self.bottomBgImgView addSubview:_timeLabel];
//    }
//    return _timeLabel;
//}
-(UIButton *)timeButtonOne
{
    if (!_timeButtonOne) {
        _timeButtonOne = [UIButton buttonWithType:UIButtonTypeCustom];
        _timeButtonOne.frame = CGRectMake(175, 30, 18,19.5);
        
        [_timeButtonOne setTitle:@"时" forState:UIControlStateNormal];
        [_timeButtonOne setBackgroundImage:[UIImage streImageNamed:@"Purchase_Yellow_new.png"]
                                  forState:UIControlStateNormal];
        
        [_timeButtonOne setTitleColor:kPurchaseTimeColor forState:UIControlStateNormal];
        
        _timeButtonOne.titleLabel.font = [UIFont boldSystemFontOfSize:11.0f];
        
    }
    return _timeButtonOne;
}

-(UIButton *)timeButtonTwo
{
    if (!_timeButtonTwo) {
        _timeButtonTwo = [UIButton buttonWithType:UIButtonTypeCustom];
        _timeButtonTwo.frame = CGRectMake(222, 30,18,19.5);
        
        [_timeButtonTwo setTitle:@"分" forState:UIControlStateNormal];
        [_timeButtonTwo setBackgroundImage:[UIImage streImageNamed:@"Purchase_Yellow_new.png"]
                                  forState:UIControlStateNormal];
        
        [_timeButtonTwo setTitleColor:kPurchaseTimeColor forState:UIControlStateNormal];
        
        _timeButtonTwo.titleLabel.font = [UIFont boldSystemFontOfSize:11.0f];
        
    }
    return _timeButtonTwo;
}

-(UIButton *)timeButtonThree
{
    if (!_timeButtonThree) {
        _timeButtonThree = [UIButton buttonWithType:UIButtonTypeCustom];
        _timeButtonThree.frame = CGRectMake(270, 30, 18,19.5);
        
        [_timeButtonThree setTitle:@"秒" forState:UIControlStateNormal];
        [_timeButtonThree setBackgroundImage:[UIImage streImageNamed:@"Purchase_Yellow_new.png"]
                                    forState:UIControlStateNormal];
        
        [_timeButtonThree setTitleColor:kPurchaseTimeColor forState:UIControlStateNormal];
        
        _timeButtonThree.titleLabel.font = [UIFont boldSystemFontOfSize:11.0f];
        
    }
    return _timeButtonThree;
}

- (FXLabel *)productDescLabel
{
    if (!_productDescLabel) {
        _productDescLabel = [[FXLabel alloc] init];
        
        _productDescLabel.backgroundColor = [UIColor clearColor];
        
        _productDescLabel.font = [UIFont systemFontOfSize:13];
        
        _productDescLabel.numberOfLines = 0;
        
        _productDescLabel.lineBreakMode = UILineBreakModeTailTruncation;
        
        _productDescLabel.textColor = KProduceDec ;
        
        [self.bottomBgImgView addSubview:_productDescLabel];
    }
    return _productDescLabel;
}

- (EGOImageViewEx *)productImageView
{
    if (!_productImageView) {
        
        _productImageView = [[EGOImageViewEx alloc] init];
        _productImageView.placeholderImage = [UIImage imageNamed:kProductImageViewDefultImage];

        _productImageView.frame = CGRectMake(10,75, 160, 160);

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
        
        _leftQtyLbl.textColor = [UIColor darkGrayColor];
        
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
        
        //_priceLbl.font = [UIFont systemFontOfSize:21];
        _priceLbl.font = [UIFont fontWithName:@"HelveticaNeue-BoldItalic" size:21];
        
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
