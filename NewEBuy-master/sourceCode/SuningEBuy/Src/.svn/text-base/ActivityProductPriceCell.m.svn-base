//
//  ActivityProductPriceCell.m
//  SuningEBuy
//
//  Created by shasha on 12-4-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ActivityProductPriceCell.h"

@implementation ActivityProductPriceCell
@synthesize backView = _backView;


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.clipsToBounds = YES;
    }
    return self;
}

+ (CGFloat)height:(DataProductBasic *)productDetail
{
    return 83;
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


- (void)setItem:(DataProductBasic *)productDetail{
    
    [super setItem:productDetail];
    
    if ([self.starView superview]!=nil ) {
        
        [self.starView removeFromSuperview];
    }
    
    [self setNeedsDisplay];
    
    self.backView.frame = CGRectMake(7, -3, 306, 83);
    
}


-(void)layoutSubviews{

    [super layoutSubviews];
    
    self.defaultAddressButton.frame = CGRectMake(50, 25, 94, 30);
    
    self.temContentLbl.frame = CGRectMake(13, 25, 40, 30);
    
    self.arrivetimeLbl.frame = CGRectMake(self.defaultAddressButton.right+20, 16, self.arrivetimeLbl.width, self.arrivetimeLbl.height);
    
    self.priceLbl.frame = CGRectMake(self.defaultAddressButton.right+40, self.arrivetimeLbl.bottom+5, self.priceLbl.width, self.priceLbl.height);
    

}

//- (void)addressPickerLoadDataOkWithSelectInfo:(AddressInfoDTO *)addressInfo
//{
//    NSString *cityName = self.addressPickerView.selectAddressInfo.cityContent;
//    
//    NSString *sectionName = self.addressPickerView.selectAddressInfo.districtContent;
//    
//    NSString *buttonTitle = [NSString stringWithFormat:@"%@ %@ ",cityName,sectionName];
//    
//    if (_purchaseType == PanicPurchase) {
//        [self.defaultAddressButton setTitle:cityName forState:UIControlStateNormal];
//        
//    }else{
//        
//        [self.defaultAddressButton setTitle:buttonTitle forState:UIControlStateNormal];
//
//    }
       

//}

@end
