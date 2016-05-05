//
//  QuickBuyProductTimerView.m
//  SuningEBuy
//
//  Created by shasha on 12-1-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "QuickBuyProductTimerView.h"

@implementation QuickBuyProductTimerView

@synthesize panicDTO = panicDTO_;
@synthesize calenderTip = calenderTip_;
@synthesize subCount = subCount_;

@synthesize colockView = _colockView;

- (id)init{

    self = [super init];
    
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;

}


- (void)dealloc
{
    TT_RELEASE_SAFELY(panicDTO_);
    TT_RELEASE_SAFELY(calenderTip_);
    TT_RELEASE_SAFELY(subCount_);
    TT_RELEASE_SAFELY(_colockView);
    
    
}

- (void)setItem:(PanicPurchaseDTO *)panic{

    if (panic == nil) {
        return;
    }
    
    self.panicDTO = panic;
    
    switch (panic.purchaseState) {
        case ReadyForSale:
        {
            self.calenderTip.text = L(@"Away from begin time");
            break;
        }
        case OnSale:
        {
            self.calenderTip.text = L(@"Left time to end");
            break;
        }
        case SaleOut:
        {
            self.calenderTip.text = L(@"Panic_Purchase_Finished");
            break;
        }
        default:
            break;
    }
    
    self.subCount.text = [NSString stringWithFormat:@"%@%@",L(@"Product_RemainAmount"), self.panicDTO.leftQty];
    
    [self.colockView setTime:0];
    
    [self setNeedsDisplay];
}

- (void)reloadView
{
    if (self.panicDTO.purchaseState == OnSale) {
        
        self.calenderTip.text = L(@"Left time to end");
        
    }else if (self.panicDTO.purchaseState == SaleOut){
        
        self.calenderTip.text = L(@"Panic_Purchase_Finished");
        
    }
    
    self.subCount.text = [NSString stringWithFormat:@"%@%@",L(@"Product_RemainAmount"), self.panicDTO.leftQty];
    
    [self.colockView setTime:0];
    
    [self setNeedsDisplay];
}

- (void)setTime:(NSTimeInterval)seconds
{
    if (self.colockView) {
        [self.colockView setTime:seconds];
    }
}

- (UILabel *)calenderTip{
    
    if (!calenderTip_) {
        
        calenderTip_ = [[UILabel alloc] init];
        
        calenderTip_.textAlignment = UITextAlignmentRight;
        
        calenderTip_.font = [UIFont fontWithName:@"DBLCDTempBlack" size:15];
        
        calenderTip_.textColor = [UIColor darkGrayColor];
        
        calenderTip_.backgroundColor = [UIColor clearColor];
        
        [self addSubview:calenderTip_];
    }
    
    return calenderTip_;
}


- (UILabel *)subCount{

    if (!subCount_) {
        
        subCount_ = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 140, 25)];
        
        subCount_.textAlignment = UITextAlignmentCenter;
        
        subCount_.backgroundColor = [UIColor clearColor];
        
        subCount_.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:17];
        
        subCount_.textColor = RGBCOLOR(176, 44, 44);
        
        [self addSubview:subCount_];
    }
    
    return subCount_;
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

- (void)layoutSubviews{

    [super layoutSubviews];
    
    self.calenderTip.frame = CGRectMake(40, 20, 110, 25);    
            
    self.colockView.frame = CGRectMake(self.calenderTip.right, 8, self.colockView.width, self.colockView.height);
    
    self.subCount.frame = CGRectMake(90, self.colockView.bottom + 5, self.subCount.width, self.subCount.height);
}



@end
