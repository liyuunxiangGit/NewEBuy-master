//
//  GroupProductSimpleView.m
//  SuningEBuy
//
//  Created by 刘坤 on 11-12-29.
//  Copyright (c) 2011年 Suning. All rights reserved.
//

#import "GroupProductSimpleView.h"
#import "GroupProductColockView.h"
#import "GroupProductProgressView.h"

@interface GroupProductSimpleView()


@property (nonatomic, strong) GroupProductColockView *colockView;
@property (nonatomic, strong) UILabel *groupNumberLabel;
@property (nonatomic, strong) UILabel *groupNumberContentLabel;
@property (nonatomic, strong) UILabel *totalCountLabel;
@property (nonatomic, strong) UILabel *totalCountContentLabel;
@property (nonatomic, strong) UILabel *discountLabel;
@property (nonatomic, strong) UILabel *discountContentLabel;
@property (nonatomic, strong) UILabel *maxDiscountLabel;
@property (nonatomic, strong) UILabel *maxDiscountContentLabel;
@property (nonatomic, strong) GroupProductProgressView *progressView;

- (void)addSubviewsNeeded;
@end

//////////////////////////////////////////////////////////////////

@implementation GroupProductSimpleView

@synthesize leavingTimeLabel = leavingTimeLabel_;

@synthesize colockView = _colockView;
@synthesize groupNumberLabel = _groupNumberLabel;
@synthesize groupNumberContentLabel = _groupNumberContentLabel;
@synthesize discountLabel = _discountLabel;
@synthesize discountContentLabel = _discountContentLabel;
@synthesize progressView = _progressView;

@synthesize totalCountLabel = _totalCountLabel;
@synthesize totalCountContentLabel = _totalCountContentLabel;
@synthesize maxDiscountLabel = _maxDiscountLabel;
@synthesize maxDiscountContentLabel = _maxDiscountContentLabel;

- (void)dealloc
{
    TT_RELEASE_SAFELY(groupDTO_);

    TT_RELEASE_SAFELY(leavingTimeLabel_);
    TT_RELEASE_SAFELY(_colockView);
    TT_RELEASE_SAFELY(_groupNumberLabel);
    TT_RELEASE_SAFELY(_groupNumberContentLabel);
    TT_RELEASE_SAFELY(_discountLabel);
    TT_RELEASE_SAFELY(_discountContentLabel);
    TT_RELEASE_SAFELY(_progressView);
    
    TT_RELEASE_SAFELY(_totalCountLabel);
    TT_RELEASE_SAFELY(_totalCountContentLabel);
    TT_RELEASE_SAFELY(_maxDiscountLabel);
    TT_RELEASE_SAFELY(_maxDiscountContentLabel);
    
}

- (id)init
{
    self = [super init];
    
    if (self)
    {        
        self.frame = CGRectMake(0, 0, 320, 208);
        
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubviewsNeeded];
    }
    return self;
}

- (void)addSubviewsNeeded
{    
    self.groupNumberLabel.text = L(@"Group number");
    
    self.discountLabel.text = L(@"Discount Price");
}

- (void)setItem:(GroupPurchaseDTO *)groupDTO
{
    if (groupDTO_ != groupDTO)
    {
        TT_RELEASE_SAFELY(groupDTO_);
        
        groupDTO_ = groupDTO;
    }
                
    if (groupDTO_.purchaseState == ReadyForSale)
    {
        self.leavingTimeLabel.text = L(@"Away from begin time");
    }
    else
    {
        self.leavingTimeLabel.text = L(@"Away from end time");
    }
    
    self.totalCountContentLabel.text = [NSString stringWithFormat:@"%d%@", [groupDTO_.limitQty intValue]-[groupDTO_.subscribeAmount intValue], L(@"Item")];
    
    self.groupNumberContentLabel.text = [NSString stringWithFormat:@"%@%@", groupDTO_.subscribeAmount, L(@"Item")];
    
    self.discountContentLabel.text = [NSString stringWithFormat:@"%.2f%@", [groupDTO_.adjustAmount floatValue], L(@"RMB")];
    
    self.maxDiscountContentLabel.text = [NSString stringWithFormat:@"%.2f%@", [groupDTO_.maxReward floatValue], L(@"RMB")];
    
    [self.progressView setItem:groupDTO_];
    
    [self setNeedsLayout];
}

- (void)reloadView
{
    [self.colockView setTime:0];
}


- (void)setTime:(CGFloat)seconds
{
    if (self.colockView) {
        [self.colockView setTime:seconds];
    }
}


- (UILabel *)leavingTimeLabel
{
    if (!leavingTimeLabel_)
    {
        leavingTimeLabel_ = [[UILabel alloc] init];
        
        leavingTimeLabel_.frame = CGRectMake(15, 10, 110, 25);
        
        leavingTimeLabel_.textAlignment = UITextAlignmentLeft;
        
        leavingTimeLabel_.font = [UIFont systemFontOfSize:15.0];
        
        leavingTimeLabel_.backgroundColor = [UIColor clearColor];
        
        leavingTimeLabel_.textColor = [UIColor darkGrayColor];
        
        [self addSubview:leavingTimeLabel_];
        
    }
    return leavingTimeLabel_;
}

- (GroupProductColockView *)colockView
{
    if (!_colockView)
    {
        _colockView = [[GroupProductColockView alloc] init];
        
        [self addSubview:_colockView];
    }
    return _colockView;
}

- (GroupProductProgressView *)progressView
{
    if (!_progressView)
    {
        _progressView = [[GroupProductProgressView alloc] init];
        
        [self addSubview:_progressView];
    }
    return _progressView;
}

- (UILabel *)groupNumberLabel
{
    if (!_groupNumberLabel)
    {
        _groupNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 25)];
        
        _groupNumberLabel.backgroundColor = [UIColor clearColor];
        
        _groupNumberLabel.textColor = [UIColor darkGrayColor];
        
        _groupNumberLabel.font = [UIFont systemFontOfSize:15];
        
        _groupNumberLabel.textAlignment = UITextAlignmentRight;
        
        [self addSubview:_groupNumberLabel];
    }
    return _groupNumberLabel;
}

- (UILabel *)groupNumberContentLabel
{
    if (!_groupNumberContentLabel)
    {
        _groupNumberContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 25)];
        
        _groupNumberContentLabel.backgroundColor = [UIColor clearColor];
        
        _groupNumberContentLabel.textColor = [UIColor skyBlueColor];
        
        _groupNumberContentLabel.font = [UIFont boldSystemFontOfSize:17.0];
        
        [self addSubview:_groupNumberContentLabel];
    }
    return _groupNumberContentLabel;
}

- (UILabel *)totalCountLabel
{
    if (!_totalCountLabel)
    {
        _totalCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 25)];
        
        _totalCountLabel.backgroundColor = [UIColor clearColor];
        
        _totalCountLabel.textColor = [UIColor darkGrayColor];
        
        _totalCountLabel.textAlignment = UITextAlignmentRight;
        
        _totalCountLabel.font = [UIFont systemFontOfSize:15];
        
        _totalCountLabel.text = L(@"gb_TotalCount");
        
        [self addSubview:_totalCountLabel];
    }
    return _totalCountLabel;
}

- (UILabel *)totalCountContentLabel
{
    if (!_totalCountContentLabel)
    {
        _totalCountContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 25)];
        
        _totalCountContentLabel.backgroundColor = [UIColor clearColor];
        
        _totalCountContentLabel.textColor = [UIColor skyBlueColor];
        
        _totalCountContentLabel.font = [UIFont boldSystemFontOfSize:17.0];
        
        _totalCountContentLabel.adjustsFontSizeToFitWidth = YES;
        
        _totalCountContentLabel.textAlignment = UITextAlignmentCenter;
        
        [self addSubview:_totalCountContentLabel];
    }
    return _totalCountContentLabel;
}


- (UILabel *)discountLabel
{
    if (!_discountLabel)
    {
        _discountLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 110, 25)];
        
        _discountLabel.backgroundColor = [UIColor clearColor];
        
        _discountLabel.font = [UIFont systemFontOfSize:15];
        
        _discountLabel.textColor = [UIColor darkGrayColor];
        
        _discountLabel.textAlignment = UITextAlignmentRight;
        
        [self addSubview:_discountLabel];
    }
    return _discountLabel;
}

- (UILabel *)discountContentLabel
{
    if (!_discountContentLabel)
    {
        _discountContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 90, 25)];
        
        _discountContentLabel.backgroundColor = [UIColor clearColor];
        
        _discountContentLabel.textColor = [UIColor darkRedColor];
        
        _discountContentLabel.font = [UIFont boldSystemFontOfSize:17.0];
        
        [self addSubview:_discountContentLabel];
    }
    return _discountContentLabel;
}

- (UILabel *)maxDiscountLabel
{
    if (!_maxDiscountLabel)
    {
        _maxDiscountLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 25)];
        _maxDiscountLabel.text = L(@"gb_MaxDiscount");
        
        _maxDiscountLabel.backgroundColor = [UIColor clearColor];
        
        _maxDiscountLabel.font = [UIFont systemFontOfSize:15];
        
        _maxDiscountLabel.textColor = [UIColor darkGrayColor];
        
        _maxDiscountLabel.textAlignment = UITextAlignmentRight;
        
        [self addSubview:_maxDiscountLabel];
    }
    return _maxDiscountLabel;
}

- (UILabel *)maxDiscountContentLabel
{
    if (!_maxDiscountContentLabel)
    {
        _maxDiscountContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 90, 25)];
        
        _maxDiscountContentLabel.backgroundColor = [UIColor clearColor];
        
        _maxDiscountContentLabel.textColor = [UIColor darkRedColor];
        
        _maxDiscountContentLabel.font = [UIFont boldSystemFontOfSize:17.0];
        
        [self addSubview:_maxDiscountContentLabel];
    }
    return _maxDiscountContentLabel;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    self.beginTimeContentLabel.frame = CGRectMake(self.beginTimeLabel.right+10, self.beginTimeLabel.top, self.beginTimeContentLabel.width, self.beginTimeContentLabel.height);
    
    self.leavingTimeLabel.frame =CGRectMake(40, 32, 100, 25);
    
    self.colockView.frame = CGRectMake(self.leavingTimeLabel.right, 20, self.colockView.width, self.colockView.height);
    
    self.groupNumberLabel.frame = CGRectMake(self.leavingTimeLabel.left-20, self.leavingTimeLabel.bottom+10, self.groupNumberLabel.width, self.groupNumberLabel.height);
    
    self.groupNumberContentLabel.frame = CGRectMake(self.groupNumberLabel.right+3, self.groupNumberLabel.top, self.groupNumberContentLabel.width, self.groupNumberContentLabel.height);
    
    self.totalCountLabel.frame = CGRectMake(self.groupNumberLabel.left , self.groupNumberLabel.bottom + 5, self.groupNumberLabel.width, self.groupNumberLabel.height);
    
    self.totalCountContentLabel.frame = CGRectMake(self.groupNumberContentLabel.left, self.totalCountLabel.top, self.groupNumberContentLabel.width, self.groupNumberContentLabel.height);
    
    self.discountLabel.frame = CGRectMake(self.groupNumberContentLabel.right+25, self.groupNumberContentLabel.top, self.discountLabel.width, self.discountLabel.height);
    
    self.discountContentLabel.frame = CGRectMake(self.discountLabel.right, self.discountLabel.top, self.discountContentLabel.width, self.discountContentLabel.height);
    
    self.maxDiscountLabel.frame = CGRectMake(self.discountLabel.left, self.discountLabel.bottom + 5, self.discountLabel.width, self.discountLabel.height);
    
    self.maxDiscountContentLabel.frame = CGRectMake(self.discountContentLabel.left, self.maxDiscountLabel.top, self.discountContentLabel.width, self.discountContentLabel.height);
    
    self.progressView.top = self.totalCountLabel.bottom+5;
}

@end
