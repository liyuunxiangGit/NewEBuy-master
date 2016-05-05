//
//  DJGroupItemCell.m
//  SuningEBuy
//
//  Created by xie wei on 13-7-8.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "DJGroupItemCell.h"
#import "OHAttributedLabel.h"
#import "NSAttributedString+Attributes.h"

#import "ProductUtil.h"
#import "MarqueeLabel.h"
#import "StrikeThroughLabel.h"

//1：即将开始 2：已开始 3：已团完 4：已结束
#define kWillStart @"1"
#define kHaveStart @"2"
#define kNOGood @"3"
#define kHaveEnd @"4"

#define kNormalBoldFont  [UIFont boldSystemFontOfSize:13.0]
#define kBigBoldFont     [UIFont boldSystemFontOfSize:17.0]

#define kDefaultFont  [UIFont systemFontOfSize:15.0]

@interface DJGroupItemCell()

@property (nonatomic, strong)   OHAttributedLabel *timeLabel;
@property (nonatomic, strong)   EGOImageView *productImageView;
@property (nonatomic, strong)   UILabel *productNameLbl;
@property (nonatomic, strong)   UILabel *status;
@property (nonatomic, strong)   StrikeThroughLabel *originPriceLbl;
@property (nonatomic, strong)   UILabel *percentageLbl;
@property (nonatomic, strong)   OHAttributedLabel *priceLbl;

@property (nonatomic, strong)   DJGroupListItemDTO *item;

@end


@implementation DJGroupItemCell

@synthesize cal = _cal;
@synthesize delegate = _delegate;

@synthesize timeLabel = _timeLabel;
@synthesize productImageView = _productImageView;
@synthesize productNameLbl = _productNameLbl;
@synthesize status = _status;
@synthesize originPriceLbl = _originPriceLbl;
@synthesize percentageLbl = _percentageLbl;
@synthesize priceLbl = _priceLbl;


@synthesize item = _item;

- (void)dealloc
{
    [_cal removeObserver:self forKeyPath:@"time"];
    TT_RELEASE_SAFELY(_cal);
    
    TT_RELEASE_SAFELY(_timeLabel);

    TT_RELEASE_SAFELY(_status);
    TT_RELEASE_SAFELY(_productImageView);
    TT_RELEASE_SAFELY(_productNameLbl);

    TT_RELEASE_SAFELY(_originPriceLbl);
    TT_RELEASE_SAFELY(_percentageLbl);
    TT_RELEASE_SAFELY(_priceLbl);
    
    TT_RELEASE_SAFELY(_item);
    
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

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.timeLabel.frame = CGRectMake(70, 6, 180, 23);
    
    self.productImageView.frame = CGRectMake(12, 42, 85, 85);
    
    self.productNameLbl.frame = CGRectMake(110, 45, 200, 40);
    
    self.percentageLbl.frame = CGRectMake(110, 112, 150, 20);
    
    CGSize size =[self.item.displayPrice sizeWithFont:[UIFont boldSystemFontOfSize:12] constrainedToSize:CGSizeMake(110, 25)];
    
    self.priceLbl.frame = CGRectMake(110, 93, size.width>110?size.width:110, 25);
    
    self.originPriceLbl.frame = CGRectMake(self.priceLbl.right, 90, 90, 25);

    self.status.frame = CGRectMake(230, 112, 80, 20);
}

- (void)setItem:(DJGroupListItemDTO *)item
{
    if (_item != item){
        _item = item;
        
        [self reloadAllData];
    }
}

- (void)reloadAllData
{
    self.productImageView.imageURL = [ProductUtil getImageUrlWithProductCode:self.item.partnumber size:ProductImageSize160x160];
    self.productNameLbl.text = self.item.productName;
    
    NSString *str = [NSString stringWithFormat:@"%@:￥%.2f",L(@"DJGroup_GroupBuyPrice"), [self.item.displayPrice doubleValue]];
    NSMutableAttributedString *priceStr = [[NSMutableAttributedString alloc] initWithString:str];
    [priceStr setFont:[UIFont systemFontOfSize:13] range:NSMakeRange(0, 4)];
    [priceStr setFont:[UIFont fontWithName:@"HelveticaNeue-BoldItalic" size:13] range:NSMakeRange(4, [str length]-4)];
    [priceStr setTextColor:[UIColor light_Black_Color] range:NSMakeRange(0, 4)];
    [priceStr setTextColor:[UIColor orange_Red_Color] range:NSMakeRange(4, [str length]-4)];
    
    self.priceLbl.attributedText = priceStr;
    
    NSString *yigouStr;
    if (IsStrEmpty(self.item.netPrice)) {
//        yigouStr =@"原价:--";
        self.originPriceLbl.hidden = YES;
    }else
    {
      yigouStr = [NSString stringWithFormat:@"%@:￥%.2f",L(@"Purchase_OriginalPrice"), [self.item.netPrice doubleValue]];
        self.originPriceLbl.hidden = NO;
    }
    self.originPriceLbl.text = yigouStr;
    
    
    NSString *percent;
    if (IsStrEmpty(self.item.adjustAmount)) {
        percent =@"节省：--";
        self.percentageLbl.hidden = YES;
    }else
    {
        percent = [NSString stringWithFormat:@"%@:%.2f元",L(@"DJGroup_SaveMoney"),[self.item.adjustAmount floatValue]];
        self.percentageLbl.hidden = NO;
    }
    
    self.percentageLbl.text = percent;
    
    NSString *stateString = nil;
    if ([self.item.startFlag isEqualToString:kWillStart]) {
        stateString = [NSString stringWithFormat:@"%@%@%@",L(@"DJGroup_AlreadyGroupBuy"),self.item.totalQty,L(@"Purchase_Jian")];
        
    } else if ([self.item.startFlag isEqualToString:kHaveStart]) {
        stateString =[NSString stringWithFormat:@"%@%@%@",L(@"DJGroup_AlreadyGroupBuy"),self.item.totalQty,L(@"Purchase_Jian")] ;
    }
    else if ([self.item.startFlag isEqualToString:kNOGood]) {
        
        stateString = L(@"Purchase_PurchaseOut");
    }
    else if ([self.item.startFlag isEqualToString:kHaveEnd])
    {
        stateString =L(@"Group buy is over");
    }
    self.status.text =stateString;
    
    [self setNeedsLayout];
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

+ (CGFloat)height
{
    return 140.0f;
}

#pragma mark -
#pragma mark actions

#pragma mark -
#pragma mark kvo

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"time"]) {
        
        if ([self.item.startFlag isEqualToString:kNOGood] || [self.item.startFlag isEqualToString:kHaveEnd]) {
            [self setTime:0];
            return;
        }
        
        NSTimeInterval leavingTime = 0;
        
        if ([self.item.startFlag isEqualToString:kWillStart]) {
            leavingTime = self.item.startTimeSeconds - self.cal.seconds;
        } else if ([self.item.startFlag isEqualToString:kHaveStart]){
            leavingTime = self.item.endTimeSeconds - self.cal.seconds;
        }else if ([self.item.startFlag isEqualToString:kNOGood]){
            leavingTime = self.item.endTimeSeconds - self.cal.seconds;
        } else {
            [self setTime:0];
            return;
        }
        
        if (leavingTime < 1) {
            if ([self.item.startFlag isEqualToString:kWillStart]) {
                self.item.startFlag = kHaveStart;
            }else if ([self.item.startFlag isEqualToString:kHaveStart]){
                self.item.startFlag = kHaveEnd;
            }
            [self reloadAllData];
            return;
        }
        
        [self setTime:leavingTime];
    }
}

- (void)setTime:(NSTimeInterval)seconds
{
    if ([self.item.startFlag isEqualToString:@"3"] || [self.item.startFlag isEqualToString:@"4"] || (seconds == 0)){
        self.timeLabel.text = L(@"Group buy is over");
        return;
    }
    NSInteger day = seconds / (3600 * 24);
    NSInteger hour = (seconds - day * 3600 * 24) / 3600;
    NSInteger minute = (seconds - day * 3600 * 24 - hour * 3600) / 60;
    NSInteger second = (seconds - day * 3600 * 24 - hour * 3600 - minute * 60);
    
    NSString *timeString = nil;
    if (day >= 100) {
        timeString = [NSString stringWithFormat:@"%03d天%02d时%02d分%02d秒", day, hour, minute, second];
    }else{
        timeString = [NSString stringWithFormat:@"%02d天%02d时%02d分%02d秒", day, hour, minute, second];
    }
    
    NSString *stateString = nil;
    if ([self.item.startFlag isEqualToString:kWillStart]) {
        stateString = [NSString stringWithFormat:@"%@：%@",L(@"Purchase_LeftToBegin"), timeString];

    } else if ([self.item.startFlag isEqualToString:kHaveStart]) {
        stateString = [NSString stringWithFormat:@"%@：%@",L(@"Purchase_LeftToEnd"), timeString];
    }
    else if ([self.item.startFlag isEqualToString:kNOGood]) {
        
        stateString = [NSString stringWithFormat:@"%@：%@",L(@"Purchase_LeftToEnd"), timeString];

    }
    
    self.timeLabel.text = stateString;
}

#pragma mark -
#pragma mark views

- (OHAttributedLabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[OHAttributedLabel alloc] init];
        _timeLabel.backgroundColor = [UIColor clearColor];
        _timeLabel.font = kNormalBoldFont;
        _timeLabel.textColor = [UIColor light_Black_Color];
//        _timeLabel.shadowColor = [UIColor whiteColor];
//        _timeLabel.shadowOffset = CGSizeMake(1, 1);
        _timeLabel.adjustsFontSizeToFitWidth = YES;
        _timeLabel.textAlignment = UITextAlignmentCenter;
        [self.contentView addSubview:_timeLabel];
    }
    return _timeLabel;
}

- (EGOImageView *)productImageView
{
    if (!_productImageView) {
		_productImageView = [[EGOImageView alloc] init];
        _productImageView.frame = CGRectMake(10, 34, 84, 84);
		_productImageView.backgroundColor =[UIColor whiteColor];
        _productImageView.contentMode = UIViewContentModeScaleAspectFill;
        _productImageView.layer.cornerRadius = 5;
        _productImageView.layer.masksToBounds = YES;
        _productImageView.placeholderImage = [UIImage imageNamed:kProductImageViewDefultImage];
        [self.contentView addSubview:_productImageView];
	}
	return _productImageView;
}

- (UILabel *)productNameLbl
{
    if (!_productNameLbl){
        _productNameLbl = [[UILabel alloc] initWithFrame:CGRectMake(110, 35, 200, 40)];
        _productNameLbl.numberOfLines = 0;
        _productNameLbl.textColor = [UIColor darkGrayColor];
        _productNameLbl.textAlignment = UITextAlignmentLeft;
        _productNameLbl.backgroundColor = [UIColor clearColor];
        _productNameLbl.shadowColor = [UIColor whiteColor];
        _productNameLbl.shadowOffset = CGSizeMake(1, 1);
        _productNameLbl.font = kNormalBoldFont;
        
        [self.contentView addSubview:_productNameLbl];
    }
    return _productNameLbl;
}

- (UILabel *)status
{
    if (!_status){
        _status = [[UILabel alloc] init];
        _status.textColor = [UIColor dark_Gray_Color];
        _status.textAlignment = UITextAlignmentRight;
        _status.backgroundColor = [UIColor clearColor];
        _status.shadowColor = [UIColor whiteColor];
        _status.shadowOffset = CGSizeMake(1, 1);
        _status.font = [UIFont systemFontOfSize:13];
        
        [self.contentView addSubview:_status];
    }
    return _status;
}

- (StrikeThroughLabel *)originPriceLbl
{
    if (!_originPriceLbl) {
        _originPriceLbl = [[StrikeThroughLabel alloc] init];
        _originPriceLbl.backgroundColor = [UIColor clearColor];
        _originPriceLbl.textColor = [UIColor dark_Gray_Color];
        _originPriceLbl.textAlignment = UITextAlignmentLeft;
        _originPriceLbl.font = [UIFont fontWithName:@"HelveticaNeue-BoldItalic" size:13];
        _originPriceLbl.shadowColor = [UIColor whiteColor];
        _originPriceLbl.shadowOffset = CGSizeMake(1, 1);
        _originPriceLbl.isWithStrikeThrough = YES;
        
        [self.contentView addSubview:_originPriceLbl];
    }
    return _originPriceLbl;
}

- (UILabel *)percentageLbl
{
    if (!_percentageLbl){
        _percentageLbl = [[UILabel alloc] init];
        _percentageLbl.backgroundColor = [UIColor clearColor];
        _percentageLbl.textAlignment = UITextAlignmentLeft;
        _percentageLbl.font = kNormalBoldFont;
        _percentageLbl.textColor = [UIColor dark_Gray_Color];
        
        [self.contentView addSubview:_percentageLbl];
    }
    return _percentageLbl;
}

- (OHAttributedLabel *)priceLbl
{
    if(_priceLbl == nil){
        _priceLbl = [[OHAttributedLabel alloc] init];
        _priceLbl.backgroundColor = [UIColor clearColor];
        _priceLbl.textColor = [UIColor dark_Gray_Color];
        _priceLbl.textAlignment = UITextAlignmentLeft;
        _priceLbl.font = [UIFont boldSystemFontOfSize:12.0];
        _priceLbl.shadowOffset = CGSizeMake(1, 1);
        _priceLbl.shadowColor = [UIColor whiteColor];
        
        [self.contentView addSubview:_priceLbl];
    }
    
    return _priceLbl;
}

@end
