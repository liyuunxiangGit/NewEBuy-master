//
//  PanicPurchasePriceCell.m
//  SuningEBuy
//
//  Created by 漫 王 on 12-12-27.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "PanicPurchasePriceCell.h"

@implementation PanicPurchasePriceCell
@synthesize backView = _backView;
@synthesize panicPriceLbl = _panicPriceLbl;
@synthesize panicPriceTextLbl = _panicPriceTextLbl;
@synthesize priceTextLbl = _priceTextLbl;
@synthesize addressPickerView = addressPickerView_;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.clipsToBounds = YES;
    }
    return self;
}

-(void)dealloc
{
    TT_RELEASE_SAFELY(_panicPriceLbl);
    TT_RELEASE_SAFELY(_panicPriceTextLbl);
    TT_RELEASE_SAFELY(_priceTextLbl);
}

- (AddressInfoPickerView *)addressPickerView
{
    if (!addressPickerView_) {
        AddressInfoDTO *address = [[AddressInfoDTO alloc] init];
        address.province = [Config currentConfig].defaultProvince;
        address.city = [Config currentConfig].defaultCity;
        address.district = [Config currentConfig].defaultSection;
        addressPickerView_ = [[AddressInfoPickerView alloc] initWithBaseAddressInfo:address compentCount:AddressPickerViewCompentTwo];
        addressPickerView_.showsSelectionIndicator = YES;
        addressPickerView_.addressDelegate = self;
    }
    return addressPickerView_;
}

-(UILabel*)panicPriceLbl
{
    if(nil == _panicPriceLbl)
    {
        _panicPriceLbl = [[UILabel alloc]init];
        
        _panicPriceLbl.backgroundColor = [UIColor clearColor];
        
        _panicPriceLbl.textColor = [UIColor darkRedColor];
        
        _panicPriceLbl.font = [UIFont systemFontOfSize:16.0];
        
        [self.contentView addSubview:_panicPriceLbl];
        
        
    }
    
    return _panicPriceLbl;
}

-(UILabel *)panicPriceTextLbl
{
    if (!_panicPriceTextLbl)
    {
        _panicPriceTextLbl = [[UILabel alloc] init];
        
        _panicPriceTextLbl.backgroundColor = [UIColor clearColor];
        
        _panicPriceTextLbl.text = [NSString stringWithFormat:@"%@:",L(@"discount")];
        
        _panicPriceTextLbl.font = [UIFont systemFontOfSize:16.0];
        
        [self.contentView addSubview:_panicPriceTextLbl];
    }
    return _panicPriceTextLbl;
}

-(UILabel *)priceTextLbl
{
    if (!_priceTextLbl) {
        
        _priceTextLbl = [[UILabel alloc] init];
        
        _priceTextLbl.backgroundColor = [UIColor clearColor];
        
        _priceTextLbl.text = [NSString stringWithFormat:@"%@:",L(@"yigouPrice")];
        
        _priceTextLbl.font = [UIFont systemFontOfSize:16.0];
        
        [self.contentView addSubview:_priceTextLbl];
    }
    return _priceTextLbl;
}


+ (CGFloat)height:(DataProductBasic *)productDetail
{
    return 95;
}

-(UIView *)backView{
    
    if (!_backView) {
        
        _backView = [[UIView alloc] init];
        _backView.layer.backgroundColor = [UIColor whiteColor].CGColor;
        [_backView.layer setCornerRadius:5.0];
        //        [_backView.layer setShadowOffset:CGSizeMake(0, 0)];
        //        [_backView.layer setShadowRadius:2.0];
        //        [_backView.layer setShadowOpacity:0.6];
        _backView.layer.borderWidth = 0.5;
        _backView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [self.contentView insertSubview:_backView atIndex:0];
        
    }
    return _backView;
}

- (void)setItem:(DataProductBasic *)productDetail panicPrice:(float )panicPrice{
    
    [super setItem:productDetail];
    
    if ([self.starView superview]!=nil ) {
        
        [self.starView removeFromSuperview];
    }
    
    [self setNeedsDisplay];
    
    self.panicPriceLbl.text = [NSString stringWithFormat:@"￥%0.2f",panicPrice];
    
    
    self.backView.frame = CGRectMake(7, -3, 306, 95);
    
    
}


-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.defaultAddressButton.frame = CGRectMake(50, 15, 94, 30);
    
    self.temContentLbl.frame = CGRectMake(13, 15, 40, 30);
    
    self.arrivetimeLbl.font = [UIFont systemFontOfSize:16.0];
    
    self.arrivetimeLbl.frame = CGRectMake(self.defaultAddressButton.right+10, 20, self.arrivetimeLbl.width, self.arrivetimeLbl.height);
    
    self.priceLbl.isWithStrikeThrough = YES;
    
    self.priceLbl.textColor = [UIColor blackColor];
    
    self.priceLbl.font = [UIFont systemFontOfSize:16.0];
    
    self.priceLbl.frame = CGRectMake(73, self.arrivetimeLbl.bottom+15, self.priceLbl.width, self.priceLbl.height);
    
    self.panicPriceTextLbl.frame = CGRectMake(self.defaultAddressButton.right+18, self.arrivetimeLbl.bottom+15, 60, 25);
    
    self.priceTextLbl.frame = CGRectMake(13, self.arrivetimeLbl.bottom+15, 60, 25);
    
    self.panicPriceLbl.frame = CGRectMake(self.defaultAddressButton.right+78, self.arrivetimeLbl.bottom+15, 150, 25);
    
    
}

- (void)addressPickerLoadDataOkWithSelectInfo:(AddressInfoDTO *)addressInfo{
 
    NSString *cityName = self.addressPickerView.selectAddressInfo.cityContent;
    
    [self.defaultAddressButton setTitle:cityName forState:UIControlStateNormal];
    
}

@end

