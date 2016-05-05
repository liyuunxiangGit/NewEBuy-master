//
//  PurchaseTimeItemCell.m
//  SuningEBuy
//
//  Created by xingxianping on 14-2-18.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "PurchaseTimeItemCell.h"
#import "OHAttributedLabel.h"
#import "NSAttributedString+Attributes.h"

#import "ProductUtil.h"
#import "StrikeThroughLabel.h"

#define kNormalBoldFont  [UIFont boldSystemFontOfSize:13.0]
#define kBigBoldFont     [UIFont boldSystemFontOfSize:17.0]

@interface PurchaseTimeItemCell()

@property (nonatomic, strong)   OHAttributedLabel *timeLabel;
@property (nonatomic, strong)   EGOImageView *productImageView;

@property (nonatomic, strong)   UILabel  *productNameLbl;
@property (nonatomic, strong)   OHAttributedLabel  *priceLbl;
@property (nonatomic, strong)   StrikeThroughLabel  *yigouPriceLbl;

@property (nonatomic,strong)    UILabel *statusLabel;


@end

@implementation PurchaseTimeItemCell
- (void)dealloc
{
    TT_RELEASE_SAFELY(_yigouPriceLbl);
    TT_RELEASE_SAFELY(_timeLabel);
    TT_RELEASE_SAFELY(_productImageView);
    TT_RELEASE_SAFELY(_productNameLbl);
    TT_RELEASE_SAFELY(_priceLbl);
    //    TT_RELEASE_SAFELY(_qiangButton);
    
    TT_RELEASE_SAFELY(_item);
    TT_RELEASE_SAFELY(_statusLabel);
    [_cal removeObserver:self forKeyPath:@"time"];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //时间下的线
        UIView *view =[[UIView alloc]initWithFrame:CGRectMake(12, 29, 298, 1)];
        view.backgroundColor = [UIColor colorWithHexString:@"#DCDCDC"];
        [self.contentView addSubview:view];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setCal:(Calculagraph *)cal
{
    if (cal != _cal) {
        [_cal removeObserver:self forKeyPath:@"time"];
        _cal = cal;
        [_cal addObserver:self
               forKeyPath:@"time"
                  options:NSKeyValueObservingOptionNew context:NULL];
    }
}

- (void)setItem:(PanicPurchaseDTO *)item
{
    if (_item != item)
    {
        _item = item;
        
        [self reloadAllData];
    }
}


- (void)reloadAllData
{
    
    self.productImageView.imageURL = [ProductUtil getImageUrlWithProductCode:self.item.partNumber size:ProductImageSize120x120];
    
    self.productNameLbl.text = self.item.catentryName;

    
    NSString *str = [NSString stringWithFormat:@"%@:￥%.2f",L(@"discount"), [self.item.rushPurPrice doubleValue]];
    NSMutableAttributedString *priceStr = [[NSMutableAttributedString alloc] initWithString:str];
    [priceStr setFont:[UIFont boldSystemFontOfSize:13.0f]];
    [priceStr setTextColor:[UIColor light_Black_Color] range:NSMakeRange(0, 4)];
    [priceStr setTextColor:[UIColor orange_Red_Color] range:NSMakeRange(4, [str length]-4)];
    [priceStr setFont:[UIFont fontWithName:@"HelveticaNeue-BoldItalic" size:13] range:NSMakeRange(4,[str length]-4)];
    
    
    self.priceLbl.attributedText = priceStr;
    
    NSString *yigouStr;
    if (IsStrEmpty(_item.netPrice)) {
        self.yigouPriceLbl.hidden = YES;
    }
    else
    {
        yigouStr = [NSString stringWithFormat:@"%@:￥%.2f",L(@"Purchase_OriginalPrice"), [self.item.netPrice doubleValue]];
        self.yigouPriceLbl.hidden = NO;
    }
    
    self.yigouPriceLbl.text = yigouStr;
    
    NSString *status=nil;
    if (self.item.purchaseState ==ReadyForSale) {
        status =[NSString stringWithFormat:@"%@%@%@",L(@"Purchase_LimitedAmount"),self.item.totalQtyLmt,L(@"Purchase_Jian")];
    }
    else if (self.item.purchaseState == TimeOver) {
        status = L(@"Panic_Purchase_Finished");
    }else if (self.item.purchaseState == SaleOut)
    {
        status = L(@"Purchase_PurchaseOut");
    }
    else
    {
        int amount =[self.item.leftQty intValue];
        
        if (amount>3) {
            status = [NSString stringWithFormat:@"%@%@%@",L(@"subCount"),self.item.leftQty,L(@"Purchase_Jian")];
        }
        else if (amount <1)
        {
            status =@"抢光了";
        }
        else
        {
            status = [NSString stringWithFormat:@"%@%@%@",L(@"Purchase_OnlyRemain"),self.item.leftQty,L(@"Purchase_Jian")];
        }
    }
    self.statusLabel.text = status;
    
    [self setNeedsLayout];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
}

+ (CGFloat)height
{
    return 140.0f;
}

#pragma mark -
#pragma mark kvo

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"time"]) {
        
        
        NSTimeInterval leavingTime = 0;
        switch (self.item.purchaseState) {
            case ReadyForSale:
            {
                leavingTime = self.item.startTimeSeconds - self.cal.seconds;
                [self setTime:leavingTime];
                break;
            }
            case OnSale:
            {
                leavingTime = self.item.endTimeSeconds - self.cal.seconds;
                [self setTime:leavingTime];
                break;
            }
            case SaleOut:
            {
                leavingTime = self.item.endTimeSeconds - self.cal.seconds;
                [self setTime:leavingTime];
                break;
            }
            case TimeOver:
            {
                leavingTime = 0;
                [self setTime:leavingTime];
                break;
            }
            default:
                break;
        }
        
    }
}

- (void)setTime:(NSTimeInterval)seconds
{
    NSInteger day;
    NSInteger hour;
    NSInteger minute;
    NSInteger second;
    
    if (self.item.purchaseState == TimeOver) {
        
        day = 0;
        
        hour = 0;
        
        minute = 0;
        
        second = 0;
    }
    else
    {
        day = seconds / (3600 * 24);
        hour = (seconds - day * 3600 * 24) / 3600 >=0 ? (seconds - day * 3600 * 24) / 3600 : 0;
        minute = (seconds - day * 3600 * 24 - hour * 3600) / 60 >= 0 ? (seconds - day * 3600 * 24 - hour * 3600) / 60 : 0;
        second = (seconds - day * 3600 * 24 - hour * 3600 - minute * 60) >= 0 ? (seconds - day * 3600 * 24 - hour * 3600 - minute * 60) : 0;
    }
    
    if (seconds < 1) {
        if (self.item.purchaseState == ReadyForSale) {
            self.item.purchaseState = OnSale;
            
        }else if (self.item.purchaseState == OnSale){
            self.item.purchaseState = TimeOver;
            
        }
        else if (self.item.purchaseState == SaleOut)
        {
            self.item.purchaseState = TimeOver;
        }
        [self reloadAllData];
    }
    
    NSString *timeString = nil;
    
    if (day >= 100) {
        timeString = [NSString stringWithFormat:@"%03d天%02d时%02d分%02d秒", day, hour, minute, second];
    }else{
        timeString = [NSString stringWithFormat:@"%02d天%02d时%02d分%02d秒", day, hour, minute, second];
    }
    
    NSString *stateString = nil;
    if (self.item.purchaseState == ReadyForSale)
    {
        stateString = [NSString stringWithFormat:@"%@：%@",L(@"Purchase_LeftToBegin"), timeString];
    }
    else if (self.item.purchaseState == OnSale)
    {
        stateString = [NSString stringWithFormat:@"%@：%@",L(@"Purchase_LeftToEnd"), timeString];
    }
    else
    {
        stateString = [NSString stringWithFormat:@"%@：%@",L(@"Purchase_LeftToEnd"), timeString];
    }
    
    self.timeLabel.text = stateString;
}

#pragma mark -
#pragma mark views

- (EGOImageView *)productImageView
{
    if (!_productImageView) {
		
		_productImageView = [[EGOImageView alloc] initWithFrame:CGRectMake(12, 42, 85, 85)];
		_productImageView.backgroundColor =[UIColor whiteColor];
        _productImageView.contentMode = UIViewContentModeScaleAspectFill;
        _productImageView.layer.masksToBounds = YES;
        
        [self.contentView addSubview:_productImageView];
	}
	return _productImageView;
}

- (OHAttributedLabel *)timeLabel
{
    if (!_timeLabel) {
        
        _timeLabel = [[OHAttributedLabel alloc] init];
        _timeLabel.frame = CGRectMake(20, 6, 280, 23);
        _timeLabel.backgroundColor = [UIColor clearColor];
        _timeLabel.font = [UIFont boldSystemFontOfSize:14.0];
        _timeLabel.textColor = [UIColor light_Black_Color];
        _timeLabel.adjustsFontSizeToFitWidth = YES;
        _timeLabel.textAlignment = UITextAlignmentCenter;
		_timeLabel.autoresizingMask = UIViewAutoresizingNone;
        [self.contentView addSubview:_timeLabel];
    }
    return _timeLabel;
}


- (UILabel *)productNameLbl
{
    if (!_productNameLbl)
    {
        _productNameLbl = [[UILabel alloc] init];
        _productNameLbl.frame = CGRectMake(110, 45, 200,40);
        _productNameLbl.textColor = [UIColor light_Black_Color];
        _productNameLbl.backgroundColor = [UIColor clearColor];
        _productNameLbl.shadowColor = [UIColor whiteColor];
        _productNameLbl.shadowOffset = CGSizeMake(1, 1);
        _productNameLbl.font = kNormalBoldFont;
        _productNameLbl.lineBreakMode = UILineBreakModeTailTruncation;
        _productNameLbl.numberOfLines = 0;
        
        [self.contentView addSubview:_productNameLbl];
    }
    return _productNameLbl;
}
- (UILabel *)statusLabel
{
    if (!_statusLabel)
    {
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.frame = CGRectMake(110, 112, 80, 20);
        _statusLabel.backgroundColor = [UIColor clearColor];
        _statusLabel.shadowColor = [UIColor whiteColor];
        _statusLabel.shadowOffset = CGSizeMake(1, 1);
        _statusLabel.textColor = [UIColor dark_Gray_Color];
        _statusLabel.font = kNormalBoldFont;
        _statusLabel.numberOfLines = 1;
        
        [self.contentView addSubview:_statusLabel];
    }
    return _statusLabel;
}

- (OHAttributedLabel *)priceLbl
{
    if(_priceLbl == nil)
    {
        _priceLbl = [[OHAttributedLabel alloc] init];
        _priceLbl.frame = CGRectMake(110, 93, 110, 25);
        _priceLbl.backgroundColor = [UIColor clearColor];
        _priceLbl.textColor = [UIColor dark_Gray_Color];
        _priceLbl.textAlignment = UITextAlignmentLeft;
        _priceLbl.font = [UIFont boldSystemFontOfSize:12];
        _priceLbl.shadowOffset = CGSizeMake(1, 1);
        _priceLbl.shadowColor = [UIColor whiteColor];
        [self.contentView addSubview:_priceLbl];
    }
    
    return _priceLbl;
}

- (StrikeThroughLabel *)yigouPriceLbl
{
    if(_yigouPriceLbl == nil)
    {
        _yigouPriceLbl = [[StrikeThroughLabel alloc] init];
        _yigouPriceLbl.frame = CGRectMake(220, 90, 90, 25);
        _yigouPriceLbl.backgroundColor = [UIColor clearColor];
        _yigouPriceLbl.textColor = [UIColor dark_Gray_Color];
        _yigouPriceLbl.textAlignment = UITextAlignmentLeft;
        _yigouPriceLbl.font = [UIFont fontWithName:@"HelveticaNeue-BoldItalic" size:12];
        _yigouPriceLbl.shadowOffset = CGSizeMake(1, 1);
        _yigouPriceLbl.shadowColor = [UIColor whiteColor];
        [self.contentView addSubview:_yigouPriceLbl];
    }
    
    return _yigouPriceLbl;
}

@end
