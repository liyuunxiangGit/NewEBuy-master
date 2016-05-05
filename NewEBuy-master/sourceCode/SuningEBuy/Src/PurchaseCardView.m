//
//  PurchaseCardView.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-4-18.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "PurchaseCardView.h"
#import "GroupPurchaseDTO.h"
#import "PanicPurchaseDTO.h"
#import "FXLabel.h"

#define kTitleTextColor1     RGBCOLOR(0, 102, 102)
#define kTitleTextColor2     RGBCOLOR(0, 51, 102)

#define kReadyForSaleTextColor RGBCOLOR(102, 102, 0)

#define kSaleOutTextColor      RGBCOLOR(102, 102, 102)
#define kSaleOutTextColor2     RGBCOLOR(25, 25, 25)

@interface PurchaseCardView()

@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, strong) FXLabel *stateLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UIButton *joinPurchaseButton;
@property (nonatomic, strong) UIButton *willBeginButton;


@property (nonatomic, strong) FXLabel *productDescLabel;
@property (nonatomic, strong) EGOImageViewEx *productImageView;

@property (nonatomic, strong) FXLabel *leftLabel;
@property (nonatomic, strong) UILabel *leftContentLabel;

@property (nonatomic, strong) FXLabel *centerLabel;
@property (nonatomic, strong) UILabel *centerContentLabel;

@property (nonatomic, strong) FXLabel *rightLabel;
@property (nonatomic, strong) UILabel *rightContentLabel;


- (void)reloadAllData;

@end

/*********************************************************************/

@implementation PurchaseCardView

@synthesize backgroundImageView = _backgroundImageView;

@synthesize stateLabel = _stateLabel;
@synthesize timeLabel = _timeLabel;
@synthesize joinPurchaseButton = _joinPurchaseButton;
@synthesize willBeginButton = _willBeginButton;
@synthesize productDescLabel = _productDescLabel;
@synthesize productImageView = _productImageView;
@synthesize leftLabel = _leftLabel;
@synthesize leftContentLabel = _leftContentLabel;
@synthesize centerLabel = _centerLabel;
@synthesize centerContentLabel = _centerContentLabel;
@synthesize rightLabel = _rightLabel;
@synthesize rightContentLabel = _rightContentLabel;

@synthesize groupPurchaseDTO = _groupPurchaseDTO;
@synthesize panicPurchaseDTO = _panicPurchaseDTO;

@synthesize delegate = _delegate;
@synthesize purchaseType = purchaseType_;
@synthesize purchaseState = purchaseState_;

@synthesize contentView = _contentView;

- (void)dealloc {
    TT_RELEASE_SAFELY(_backgroundImageView);
    TT_RELEASE_SAFELY(_stateLabel);
    TT_RELEASE_SAFELY(_timeLabel);
    TT_RELEASE_SAFELY(_joinPurchaseButton);
    TT_RELEASE_SAFELY(_willBeginButton);
    TT_RELEASE_SAFELY(_productDescLabel);
    TT_RELEASE_SAFELY(_productImageView);
    TT_RELEASE_SAFELY(_leftLabel);
    TT_RELEASE_SAFELY(_leftContentLabel);
    TT_RELEASE_SAFELY(_centerLabel);
    TT_RELEASE_SAFELY(_centerContentLabel);
    TT_RELEASE_SAFELY(_rightLabel);
    TT_RELEASE_SAFELY(_rightContentLabel);
    
    TT_RELEASE_SAFELY(_groupPurchaseDTO);
    TT_RELEASE_SAFELY(_panicPurchaseDTO);
    TT_RELEASE_SAFELY(_contentView);
}

- (id)init {
    self = [super init];
    if (self) {
        
        if ([SystemInfo is_iPhone_5]) {
            self.frame = CGRectMake(0, 0, 261, 344+kIphone5Fix);
        }else{
            self.frame = CGRectMake(0, 0, 261, 344);
        }
    }
    return self;
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        if ([SystemInfo is_iPhone_5]) {
            self.frame = CGRectMake(0, 0, 261, 344+kIphone5Fix);
            self.contentView.frame = CGRectMake(10, 10+kIphone5Fix/4, 261, 344+kIphone5Fix/2);

        }else{
            self.frame = CGRectMake(0, 0, 280, 354);
            self.contentView.frame = CGRectMake(10, 10, 261, 344);
        }
        
    }
    return self;
}

- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor clearColor];
        [self addSubview:_contentView];
    }
    return _contentView;
}

- (void)setItem:(id)dto
{
    if (dto == nil) {
        return;
    }
    if ([dto isKindOfClass:[GroupPurchaseDTO class]]) {
        purchaseType_ = GroupPurchase;
        self.groupPurchaseDTO = dto;
        purchaseState_ = self.groupPurchaseDTO.purchaseState;
    }else{
        purchaseType_ = PanicPurchase;
        self.panicPurchaseDTO = dto;
        purchaseState_ = self.panicPurchaseDTO.purchaseState;
    }
    [self reloadAllData];
}

- (void)reloadAllData
{
    @autoreleasepool {
        [self.timeLabel removeFromSuperview];
        [self.willBeginButton removeFromSuperview];
        [self.joinPurchaseButton removeFromSuperview];
        switch (purchaseState_) {
            case ReadyForSale:
            {
                self.backgroundImageView.image = [UIImage imageNamed:kPurchaseCardViewReadyForSaleBG];
                self.stateLabel.text = L(@"PRReadyToStart");
                self.stateLabel.textColor = kReadyForSaleTextColor;
                self.productDescLabel.textColor = kReadyForSaleTextColor;
                self.leftLabel.textColor = kReadyForSaleTextColor;
                self.centerLabel.textColor = kReadyForSaleTextColor;
                self.rightLabel.textColor = kReadyForSaleTextColor;
                
                self.willBeginButton.frame = CGRectMake(0, 0, 96, 37);
                [self.contentView addSubview:self.willBeginButton];
                self.timeLabel.text = @"00:00:00";
                [self.contentView addSubview:self.timeLabel];
                break;
            }
            case OnSale:
            {
                self.backgroundImageView.image = [UIImage imageNamed:kPurchaseCardViewOnSaleBG];
                self.stateLabel.text = L(@"PRReadyToEnd");
                
                if (purchaseType_ == GroupPurchase) {
                    [self.joinPurchaseButton setTitle:L(@"Group Purchase") forState:UIControlStateNormal];
                }else{
                    [self.joinPurchaseButton setTitle:L(@"QuickBuy") forState:UIControlStateNormal];
                }
                self.stateLabel.textColor = kTitleTextColor1;
                self.productDescLabel.textColor = kTitleTextColor1;
                self.leftLabel.textColor = kTitleTextColor2;
                self.centerLabel.textColor = kTitleTextColor2;
                self.rightLabel.textColor = kTitleTextColor2;
                
                self.timeLabel.text = @"00:00:00";
                [self.contentView addSubview:self.timeLabel];
                [self.contentView addSubview:self.joinPurchaseButton];
                break;
            }
            case SaleOut:
            {
                self.backgroundImageView.image = [UIImage imageNamed:kPurchaseCardViewSaleOutBG];
                if (purchaseType_ == GroupPurchase) {
                    self.stateLabel.text = L(@"Group Over");
                }else{
                    self.stateLabel.text = L(@"Panic Over");
                }
                self.stateLabel.textColor = kSaleOutTextColor;
                self.productDescLabel.textColor = kSaleOutTextColor;
                self.leftLabel.textColor = kSaleOutTextColor2;
                self.centerLabel.textColor = kSaleOutTextColor2;
                self.rightLabel.textColor = kSaleOutTextColor2;
                break;
            }
            default:
                break;
        }
        
        if (purchaseType_ == GroupPurchase) {
            self.productDescLabel.text = [NSString stringWithFormat:@"%@ %@", self.groupPurchaseDTO.partName, (self.groupPurchaseDTO.productDesc?self.groupPurchaseDTO.productDesc:@"")];
            self.productImageView.imageURL = self.groupPurchaseDTO.imageURL;
            //self.leftLabel.text = @"易购价";
            self.leftLabel.text = L(@"PRHaveGroup");
            self.rightLabel.text = L(@"Maximum discount");
            self.centerLabel.text = L(@"PRHaveGroup");
            //self.leftContentLabel.text = [NSString stringWithFormat:@"￥%.2f", [(self.groupPurchaseDTO.entryPrices?self.groupPurchaseDTO.entryPrices:@"") floatValue]];
            self.leftContentLabel.text = self.groupPurchaseDTO.subscribeAmount;
            self.rightContentLabel.text = [NSString stringWithFormat:@"￥%.2f", [(self.groupPurchaseDTO.maxReward?self.groupPurchaseDTO.maxReward:@"") floatValue]];
            self.centerContentLabel.text = self.groupPurchaseDTO.subscribeAmount;
        }else{
            self.productDescLabel.text = [NSString stringWithFormat:@"%@ %@", self.panicPurchaseDTO.catentryName, (self.panicPurchaseDTO.descriptions?self.panicPurchaseDTO.descriptions:@"")];
            self.productImageView.imageURL = self.panicPurchaseDTO.imageURL;
            self.leftLabel.text = L(@"PREbuyPrice1");
//        self.leftLabel.text = @"";
            self.rightLabel.text = L(@"discount");
            self.centerLabel.text = L(@"subCount");
            self.leftContentLabel.text = [NSString stringWithFormat:@"￥%.2f", [(self.panicPurchaseDTO.netPrice?self.panicPurchaseDTO.netPrice:@"") floatValue]];
//        self.leftContentLabel.text = self.panicPurchaseDTO.leftQty;
            self.rightContentLabel.text = [NSString stringWithFormat:@"￥%.2f", [(self.panicPurchaseDTO.rushPurPrice?self.panicPurchaseDTO.rushPurPrice:@"") floatValue]];
            self.centerContentLabel.text = self.panicPurchaseDTO.leftQty;
        }
    
    }
    [self setNeedsLayout];
}

- (void)setTime:(NSTimeInterval)seconds
{
    if (purchaseState_ == SaleOut) {
        return;
    }
    if (seconds < 1) {
        if (purchaseState_ == ReadyForSale) {
            purchaseState_ = OnSale;
            if (purchaseType_ == GroupPurchase) {
                self.groupPurchaseDTO.purchaseState = OnSale;
            }else{
                self.panicPurchaseDTO.purchaseState = OnSale;
            }
        }else if (purchaseState_ == OnSale){
            purchaseState_ = SaleOut;
            if (purchaseType_ == GroupPurchase) {
                self.groupPurchaseDTO.purchaseState = SaleOut;
            }else{
                self.panicPurchaseDTO.purchaseState = SaleOut;
            }
        }
        [self reloadAllData];
        return;
    }
    
    NSInteger hour = seconds / 3600;
    
    NSInteger minute = (seconds - hour * 3600) / 60;
    
    NSInteger second = (seconds - hour * 3600 - minute * 60);
    
    NSString *timeString = nil;
    
    if (hour >= 100) {
        timeString = [NSString stringWithFormat:@"%03d:%02d:%02d", hour, minute, second];
    }else{
        timeString = [NSString stringWithFormat:@"%02d:%02d:%02d", hour, minute, second];
    }
    self.timeLabel.text = timeString;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat fixPixel = 0;
    if ([SystemInfo is_iPhone_5]) {
        fixPixel= kIphone5Fix / 8;
    }else{
        fixPixel= 0;
    }
    
    switch (purchaseState_) {
        case ReadyForSale:
        {
            self.stateLabel.frame = CGRectMake(10, 8+fixPixel, 70, 32);
            self.stateLabel.font = [UIFont boldSystemFontOfSize:15];
            self.stateLabel.textAlignment = UITextAlignmentLeft;
            self.timeLabel.frame = CGRectMake(self.stateLabel.right, self.stateLabel.top, 80, 32);
            self.willBeginButton.frame = CGRectMake(169, self.stateLabel.top, 96, 37);
            break;
        }
        case OnSale:
        {
            self.stateLabel.frame = CGRectMake(10, 8 + fixPixel, 70, 32);
            self.stateLabel.font = [UIFont boldSystemFontOfSize:15];
            self.stateLabel.textAlignment = UITextAlignmentLeft;
            self.timeLabel.frame = CGRectMake(self.stateLabel.right, self.stateLabel.top, 80, 32);
            self.joinPurchaseButton.frame = CGRectMake(178, self.stateLabel.top, 73, 32);
            
            break;
        }
        case SaleOut:
        {
            self.stateLabel.frame = CGRectMake(0, 8+fixPixel, 260, 32);
            self.stateLabel.font = [UIFont boldSystemFontOfSize:22.0];
            self.stateLabel.textAlignment = UITextAlignmentCenter;
            break;
        }
        default:
            break;
    }
   // self.productDescLabel.frame = CGRectMake(9, 47, 242, 40);
    self.productDescLabel.frame = CGRectMake(9, self.stateLabel.bottom+7, 242, 40);

    //self.productImageView.frame = CGRectMake(20, 96, 220, 170);
    self.productImageView.frame = CGRectMake(20, self.productDescLabel.bottom + 10, 220, 170);

    
//    self.leftLabel.frame = CGRectMake(0, 270, 87, 25);
//    self.centerLabel.frame = CGRectMake(87, 270, 87, 25);
//    self.rightLabel.frame = CGRectMake(173, 270, 87, 25);
    self.leftLabel.frame = CGRectMake(0,  self.productImageView.bottom + 2*fixPixel, 87, 25);
    self.centerLabel.frame = CGRectMake(87, self.productImageView.bottom + 2*fixPixel, 87, 25);
    self.rightLabel.frame = CGRectMake(173,  self.productImageView.bottom + 2*fixPixel, 87, 25);
    
//    self.leftContentLabel.frame = CGRectMake(0, 293, 87, 25);
//    self.centerContentLabel.frame = CGRectMake(87, 293, 87, 25);
//    self.rightContentLabel.frame = CGRectMake(173, 293, 87, 25);
    self.leftContentLabel.frame = CGRectMake(0, self.leftLabel.bottom, 87, 25);
    self.centerContentLabel.frame = CGRectMake(87, self.leftLabel.bottom, 87, 25);
    self.rightContentLabel.frame = CGRectMake(173, self.leftLabel.bottom, 87, 25);
    
    
}

#pragma mark -
#pragma mark action

- (void)joinPurchase:(id)sender
{
    id dto = (purchaseType_ == GroupPurchase) ? self.groupPurchaseDTO : self.panicPurchaseDTO;
    if (_delegate && [_delegate conformsToProtocol:@protocol(PurchaseCardViewDelegate)]) {
        if ([_delegate respondsToSelector:@selector(joinPurchase:)]) {
            [_delegate joinPurchase:dto];
        }
    }
}

#pragma mark -
#pragma mark ego image view delegate

- (void)imageExViewDidOk:(EGOImageViewEx *)imageViewEx
{
    id dto = (purchaseType_ == GroupPurchase) ? self.groupPurchaseDTO : self.panicPurchaseDTO;
    if (_delegate && [_delegate conformsToProtocol:@protocol(PurchaseCardViewDelegate)]) {
        if ([_delegate respondsToSelector:@selector(touchTheImageView:)]) {
            [_delegate touchTheImageView:dto];
        }
    }
}

#pragma mark -
#pragma mark view getters

- (UIImageView *)backgroundImageView
{
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] init];
        _backgroundImageView.frame = CGRectMake(0, 0, self.contentView.width, self.contentView.height);
        [self.contentView addSubview:_backgroundImageView];
    }
    return _backgroundImageView;
}

- (FXLabel *)stateLabel
{
    if (!_stateLabel) {
        _stateLabel = [[FXLabel alloc] init];
        _stateLabel.backgroundColor = [UIColor clearColor];
        _stateLabel.font = [UIFont boldSystemFontOfSize:15.0];
        _stateLabel.shadowColor = [UIColor colorWithWhite:1.0f alpha:0.8f];
        _stateLabel.shadowOffset = CGSizeMake(0.5f, 1.0f);
        _stateLabel.shadowBlur = 1.0f;
        _stateLabel.innerShadowColor = [UIColor colorWithWhite:0.0f alpha:0.8f];
        _stateLabel.innerShadowOffset = CGSizeMake(0.5f, 1.0f);
        [self.contentView addSubview:_stateLabel];
    }
    return _stateLabel;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.backgroundColor = [UIColor clearColor];
        _timeLabel.font = [UIFont systemFontOfSize:20.0];
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.shadowColor = [UIColor grayColor];
		_timeLabel.shadowOffset = CGSizeMake(0.8,0.8);
        _timeLabel.adjustsFontSizeToFitWidth = YES;
		_timeLabel.autoresizingMask = UIViewAutoresizingNone;
        //[self.contentView addSubview:_timeLabel];
    }
    return _timeLabel;
}

- (UIButton *)joinPurchaseButton
{
    if (!_joinPurchaseButton) {
        _joinPurchaseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_joinPurchaseButton setAdjustsImageWhenHighlighted:YES];
        [_joinPurchaseButton setBackgroundImage:[UIImage imageNamed:kPurchaseCardViewOnSaleButton] forState:UIControlStateNormal];
        _joinPurchaseButton.titleLabel.font = [UIFont boldSystemFontOfSize:19];

        [_joinPurchaseButton addTarget:self action:@selector(joinPurchase:) forControlEvents:UIControlEventTouchUpInside];
        //[self.contentView addSubview:_joinPurchaseButton];
    }
    return _joinPurchaseButton;
}

- (UIButton *)willBeginButton
{
    if (!_willBeginButton) {
        _willBeginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_willBeginButton setBackgroundImage:[UIImage imageNamed:kPurchaseCardViewReadyForSaleMark] forState:UIControlStateNormal];
        [_willBeginButton setTitle:L(@"readyForSaleState") forState:UIControlStateNormal];
        _willBeginButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [_willBeginButton setContentEdgeInsets:UIEdgeInsetsMake(0, 10, 5, 0)];
        //[self.contentView addSubview:_willBeginButton];
    }
    return _willBeginButton;
}

- (FXLabel *)productDescLabel
{
    if (!_productDescLabel) {
        _productDescLabel = [[FXLabel alloc] init];
        _productDescLabel.backgroundColor = [UIColor clearColor];
        _productDescLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:14];
        _productDescLabel.numberOfLines = 2;
        _productDescLabel.shadowColor = [UIColor colorWithWhite:1.0f alpha:0.8f];
        _productDescLabel.shadowOffset = CGSizeMake(0.5f, 1.0f);
        _productDescLabel.shadowBlur = 1.0f;
        _productDescLabel.innerShadowColor = [UIColor colorWithWhite:0.0f alpha:0.8f];
        _productDescLabel.innerShadowOffset = CGSizeMake(0.5f, 1.0f);
        [self.contentView addSubview:_productDescLabel];
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
        _productImageView.frame = CGRectMake(20, 100, 220, 160);
        _productImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_productImageView];
    }
    return _productImageView;
}

- (FXLabel *)leftLabel
{
    if (!_leftLabel)
    {
        _leftLabel = [[FXLabel alloc] initWithFrame:CGRectMake(0, 245, 87, 25)];
        _leftLabel.backgroundColor = [UIColor clearColor];
        _leftLabel.textAlignment = UITextAlignmentCenter;
        _leftLabel.font = [UIFont boldSystemFontOfSize:15.0];
        _leftLabel.shadowColor = [UIColor colorWithWhite:1.0f alpha:0.8f];
        _leftLabel.shadowOffset = CGSizeMake(0.5f, 1.0f);
        _leftLabel.shadowBlur = 1.0f;
        _leftLabel.innerShadowColor = [UIColor colorWithWhite:0.0f alpha:0.8f];
        _leftLabel.innerShadowOffset = CGSizeMake(0.5f, 1.0f);
        [self.contentView addSubview:_leftLabel];
    }
    return _leftLabel;
}

- (FXLabel *)rightLabel
{
    if (!_rightLabel)
    {
        _rightLabel = [[FXLabel alloc] initWithFrame:CGRectMake(173, 245, 87, 25)];
        _rightLabel.backgroundColor = [UIColor clearColor];
        _rightLabel.textAlignment = UITextAlignmentCenter;
        _rightLabel.font = [UIFont boldSystemFontOfSize:15.0];
        _rightLabel.shadowColor = [UIColor colorWithWhite:1.0f alpha:0.8f];
        _rightLabel.shadowOffset = CGSizeMake(0.5f, 1.0f);
        _rightLabel.shadowBlur = 1.0f;
        _rightLabel.innerShadowColor = [UIColor colorWithWhite:0.0f alpha:0.8f];
        _rightLabel.innerShadowOffset = CGSizeMake(0.5f, 1.0f);
        [self.contentView addSubview:_rightLabel];
    }
    return _rightLabel;
}

- (FXLabel *)centerLabel
{
    if (!_centerLabel)
    {
        _centerLabel = [[FXLabel alloc] initWithFrame:CGRectMake(87, 245, 87, 25)];
        _centerLabel.backgroundColor = [UIColor clearColor];
        _centerLabel.textAlignment = UITextAlignmentCenter;
        _centerLabel.font = [UIFont boldSystemFontOfSize:15.0];
        _centerLabel.shadowColor = [UIColor colorWithWhite:1.0f alpha:0.8f];
        _centerLabel.shadowOffset = CGSizeMake(0.5f, 1.0f);
        _centerLabel.shadowBlur = 1.0f;
        _centerLabel.innerShadowColor = [UIColor colorWithWhite:0.0f alpha:0.8f];
        _centerLabel.innerShadowOffset = CGSizeMake(0.5f, 1.0f);
        //[self.contentView addSubview:_centerLabel];
    }
    return _centerLabel;
}

- (UILabel *)leftContentLabel
{
    if (!_leftContentLabel) {
        _leftContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 87, 25)];
        _leftContentLabel.backgroundColor = [UIColor clearColor];
        _leftContentLabel.textAlignment = UITextAlignmentCenter;
        _leftContentLabel.font = [UIFont systemFontOfSize:16.0];
        _leftContentLabel.textColor = [UIColor whiteColor];
        _leftContentLabel.shadowColor = [UIColor grayColor];
		_leftContentLabel.shadowOffset = CGSizeMake(0.8,0.8);
		_leftContentLabel.autoresizingMask = UIViewAutoresizingNone;
        _leftContentLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_leftContentLabel];
    }
    return _leftContentLabel;
}

- (UILabel *)centerContentLabel
{
    if (!_centerContentLabel) {
        _centerContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 87, 25)];
        _centerContentLabel.backgroundColor = [UIColor clearColor];
        _centerContentLabel.textAlignment = UITextAlignmentCenter;
        _centerContentLabel.font = [UIFont systemFontOfSize:16.0];
        _centerContentLabel.textColor = [UIColor whiteColor];
        _centerContentLabel.shadowColor = [UIColor grayColor];
		_centerContentLabel.shadowOffset = CGSizeMake(0.8,0.8);
		_centerContentLabel.autoresizingMask = UIViewAutoresizingNone;
        _centerContentLabel.adjustsFontSizeToFitWidth = YES;
        //[self.contentView addSubview:_centerContentLabel];
    }
    return _centerContentLabel;
}

- (UILabel *)rightContentLabel
{
    if (!_rightContentLabel) {
        _rightContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 87, 25)];
        _rightContentLabel.backgroundColor = [UIColor clearColor];
        _rightContentLabel.textAlignment = UITextAlignmentCenter;
        _rightContentLabel.font = [UIFont systemFontOfSize:16.0];
        _rightContentLabel.textColor = [UIColor whiteColor];
        _rightContentLabel.shadowColor = [UIColor grayColor];
		_rightContentLabel.shadowOffset =CGSizeMake(0.8,0.8);
		_rightContentLabel.autoresizingMask = UIViewAutoresizingNone;
        _rightContentLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_rightContentLabel];
    }
    return _rightContentLabel;
}
@end
