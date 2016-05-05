//
//  ProductCustomCell.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-2-10.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "PurchaseProductCustomCell.h"
#import "PanicPurchaseDTO.h"


@interface PurchaseProductCustomCell()

@property (nonatomic, strong) GroupProductSimpleView *groupView;
@property (nonatomic, strong) QuickBuyProductTimerView *buyingView;

@property (nonatomic, strong) GroupPurchaseDTO *groupDTO;
@property (nonatomic, strong) PanicPurchaseDTO *panicDTO;

@end

////////////////////////////////////////////////////////////////////////////////

@implementation PurchaseProductCustomCell

@synthesize purchaseState = _purchaseState;
@synthesize purchaseType = _purchaseType;

@synthesize groupView = _groupView;
@synthesize buyingView = _buyingView;
@synthesize groupDTO = _groupDTO;
@synthesize panicDTO = _panicDTO;

@synthesize calculagraph = _calculagraph;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_groupView);
    TT_RELEASE_SAFELY(_buyingView);
    TT_RELEASE_SAFELY(_groupDTO);
    TT_RELEASE_SAFELY(_panicDTO);
    [_calculagraph removeObserver:self forKeyPath:@"time"];
    TT_RELEASE_SAFELY(_calculagraph);
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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

- (void)setItem:(id)dto
{
    if (dto == nil)
    {
        return;
    }
    
    if ([dto isKindOfClass:[GroupPurchaseDTO class]])
    {
        self.purchaseType = GroupPurchase;
        
        self.groupDTO = dto;
        
        self.purchaseState = self.groupDTO.purchaseState;
            
        [self.groupView setItem:self.groupDTO];
    }
    else if ([dto isKindOfClass:[PanicPurchaseDTO class]])
    {
        self.panicDTO = dto;
        
        self.purchaseType = PanicPurchase;
        
        self.purchaseState = self.panicDTO.purchaseState;
        
        [self.buyingView setItem:self.panicDTO];
    }
}

#pragma mark - 
#pragma mark BuyingProductView Methods


- (QuickBuyProductTimerView *)buyingView
{
    if (!_buyingView)
    {
        _buyingView = [[QuickBuyProductTimerView alloc] init];
        
        _buyingView.frame = CGRectMake(0, 10, 320, 95);
        
        [self.contentView addSubview:_buyingView];
    }
    return _buyingView;    
}

- (GroupProductSimpleView *)groupView
{
    if (!_groupView) {
        
        _groupView = [[GroupProductSimpleView alloc] init];
                
        [self.contentView addSubview:_groupView];
    }
    return _groupView;
}

+ (CGFloat)height:(PurchaseType)purchaseType
{
    if (purchaseType == GroupPurchase)
    {
        return 220;
    }
    else if (purchaseType == PanicPurchase)
    {
        return 90;
    }
    return 0;
}

#pragma mark -
#pragma mark calculagraph delegate methods

- (void)observeValueForKeyPath:(NSString *)keyPath 
                      ofObject:(id)object 
                        change:(NSDictionary *)change 
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"time"]) {
        if (self.purchaseState == SaleOut) {
            return;
        }
        CGFloat seconds = [[change objectForKey:@"new"] floatValue];
        double leavingTime = 0;
        
        if (self.purchaseType == GroupPurchase) {
            switch (self.purchaseState) {
                case ReadyForSale:
                {
                    if ([self.groupDTO.startTimeMilliSecond isEmptyOrWhitespace]) {
                        break;
                    }
                    leavingTime = [self.groupDTO.startTimeMilliSecond doubleValue]/1000-seconds;
                    break;
                }
                case OnSale:
                {
                    if ([self.groupDTO.endTimeMilliSecond isEmptyOrWhitespace]) {
                        break;
                    }
                    leavingTime = [self.groupDTO.endTimeMilliSecond doubleValue]/1000 - seconds;
                    
                    break;
                }
                case SaleOut:
                {
                    
                    break;
                }
                default:
                    break;
            }
            
            if (leavingTime < 1) {
                if (self.purchaseState == OnSale) {
                    self.purchaseState = SaleOut;
                    self.groupDTO.purchaseState = SaleOut;
                    [self.groupView reloadView];
                    
                    return;
                }
                
            }
            
            [self.groupView setTime:leavingTime];
            
        }else{
            
            switch (self.purchaseState) {
                case ReadyForSale:
                {
                    leavingTime = self.panicDTO.startTimeSeconds - seconds;
                    break;
                }
                case OnSale:
                {
                    leavingTime = self.panicDTO.endTimeSeconds - seconds;
                    break;
                }
                case SaleOut:
                {
                    break;
                }
                default:
                    break;
            }
            
            if (leavingTime < 1) {
                if (self.purchaseState == OnSale) {
                    self.purchaseState = SaleOut;
                    self.panicDTO.purchaseState = SaleOut;
                    [self.buyingView reloadView];
                    return;
                }  
                if (self.purchaseType == ReadyForSale) {
                    self.purchaseState = OnSale;
                    self.panicDTO.purchaseState = OnSale;
                    [self.buyingView reloadView];
                    return;
                }
            }   
            [self.buyingView setTime:leavingTime];
        }
    }
}

@end
