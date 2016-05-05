//
//  ProductPriceCell.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-2-10.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "ProductPriceCell.h"


//@interface ProductPriceCell()
////商品详情
//@property (nonatomic, retain) DataProductBasic *productDetailDTO;
//
////地址选择控件
//@property (nonatomic, retain)   AddressInfoPickerView *addressPickerView;
//
//
//@end


////////////////////////////////////////////////////////////////////


@implementation ProductPriceCell

@synthesize productDetailDTO = _productDetailDTO;
@synthesize priceLbl = _priceLbl;
@synthesize arrivetimeLbl = _arrivetimeLbl;
@synthesize temContentLbl = _temContentLbl;
@synthesize defaultAddressButton = _defaultAddressButton;
@synthesize starView = _starView;

@synthesize addressPickerView = _addressPickerView;


- (void)dealloc
{
    TT_RELEASE_SAFELY(_productDetailDTO);
    TT_RELEASE_SAFELY(_priceLbl);
    TT_RELEASE_SAFELY(_arrivetimeLbl);
    TT_RELEASE_SAFELY(_temContentLbl);
    TT_RELEASE_SAFELY(_defaultAddressButton);
    TT_RELEASE_SAFELY(_starView);
    _addressPickerView.addressDelegate = nil;
    TT_RELEASE_SAFELY(_addressPickerView);
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (CGFloat)height:(DataProductBasic *)productDetail
{
    return 60;
}

- (void)setItem:(DataProductBasic *)productDetail
{
    if (productDetail == nil || productDetail == _productDetailDTO)
    {
        return;
    }
    
    self.productDetailDTO = productDetail;
    
    //送达时间
    NSString *arriveTime = @"";
    //价格
    NSString *priceString = @"¥  ";
    
    if([self.productDetailDTO.suningPrice doubleValue] > 0)
    {
        priceString = [self.productDetailDTO.suningPrice formatPriceString];
    }
    if (productDetail.cityCode && [AddressInfoDAO isUpdateAddressOk]) {
        AddressInfoDAO *dao = [[AddressInfoDAO alloc] init];
        AddressInfoDTO *addressInfo = [dao getProvinceAndCityInfoByCityCode:productDetail.cityCode];
        addressInfo.district = [Config currentConfig].defaultSection;
        self.addressPickerView.baseAddressInfo = addressInfo;
    }
    
    // 商品有货
    if ([[self.productDetailDTO hasStorage] isEqualToString:@"Y"])
    {
        //liukun 添加逻辑，如果商品价格为0，那么默认为商品暂停销售
        if ([self.productDetailDTO.suningPrice doubleValue] <= 0)
        {
            arriveTime = L(@"Sorry, Not enough stock");
            self.priceLbl.isWithStrikeThrough = YES;
            self.priceLbl.textColor = [UIColor lightGrayColor];
        }
        // 送达日期
        else if ([self.productDetailDTO shipOffset])
        {
            self.priceLbl.isWithStrikeThrough = NO;
            self.priceLbl.textColor = [UIColor darkRedColor];
            
            arriveTime = [L(@"Arrive Time") stringByAppendingFormat:@"  %@",
                          [self.productDetailDTO shipOffset]];
        }
    }
    else if ([self.productDetailDTO.hasStorage isEqualToString:@"Z"])
    {
        // 此地暂不销售
        arriveTime = L(@"Sorry, Not enough stock");
        self.priceLbl.isWithStrikeThrough = YES;
        self.priceLbl.textColor = [UIColor lightGrayColor];
    }
    else // 商品无货
    {
        // 此商品暂无货
        if([self.productDetailDTO.suningPrice doubleValue] > 0)
        {
            arriveTime = L(@"No Product");
            self.priceLbl.isWithStrikeThrough = NO;
            self.priceLbl.textColor = [UIColor darkRedColor];
        }
        else // 此地暂不销售
        {
            arriveTime = L(@"Sorry, Not enough stock");
            self.priceLbl.isWithStrikeThrough = YES;
            self.priceLbl.textColor = [UIColor lightGrayColor];
        }
    }
    
    self.priceLbl.text = priceString;
    self.arrivetimeLbl.text = arriveTime;
    
    //送至
    self.temContentLbl.text = L(@"Send to");
    
    //星级
    [self.starView setStarsImages:self.productDetailDTO.evaluation];
    
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.starView.frame = CGRectMake(self.temContentLbl.left, self.temContentLbl.bottom+10, self.starView.width, self.starView.height);
    
    if (2 != self.rowNum) {
        
        self.arrivetimeLbl.frame = CGRectMake(self.defaultAddressButton.right+5, self.temContentLbl.top+5, self.arrivetimeLbl.width, self.arrivetimeLbl.height);
    }
    else{
        
        self.arrivetimeLbl.frame = CGRectMake(self.defaultAddressButton.right+5, self.temContentLbl.top-5, self.arrivetimeLbl.width, self.arrivetimeLbl.height);
    }
    
    
    self.priceLbl.frame = CGRectMake(self.defaultAddressButton.right+40, self.arrivetimeLbl.bottom+5, self.priceLbl.width, self.priceLbl.height);
}

#pragma mark-
#pragma mark 价格
- (StrikeThroughLabel *)priceLbl
{
    if (nil == _priceLbl)
    {
        _priceLbl = [[StrikeThroughLabel alloc]init];
        
        _priceLbl.isWithStrikeThrough = NO;
        _priceLbl.textAlignment = UITextAlignmentLeft;
        
        _priceLbl.size = CGSizeMake(150, 25);
        
        _priceLbl.adjustsFontSizeToFitWidth = YES;
        _priceLbl.font = [UIFont systemFontOfSize:18.0];
        _priceLbl.textColor = [UIColor colorWithRed:137.0/255.0 green:37.0/255.0 blue:37.0/255.0 alpha:1.0];
        _priceLbl.backgroundColor = [UIColor clearColor];
        _priceLbl.textColor = [UIColor colorWithRed:176.0/255.0 green:44.0/255.0 blue:44.0/255.0 alpha:1.0];
        [self.contentView addSubview:_priceLbl];
    }
    return _priceLbl;
}
#pragma mark-
#pragma mark 送达时间
- (OHAttributedLabel *)arrivetimeLbl
{
    if (nil == _arrivetimeLbl)
    {
        _arrivetimeLbl = [[OHAttributedLabel alloc]init];
        _arrivetimeLbl.backgroundColor = [UIColor clearColor];
        _arrivetimeLbl.font = [UIFont systemFontOfSize:14];
        _arrivetimeLbl.size = CGSizeMake(160, 40);
        _arrivetimeLbl.shadowColor = [UIColor whiteColor];
        _arrivetimeLbl.shadowOffset = CGSizeMake(1, 1);
        _arrivetimeLbl.textAlignment = UITextAlignmentLeft;
        
        [self.contentView addSubview:_arrivetimeLbl];
    }
    return _arrivetimeLbl;
}

- (UILabel *)temContentLbl
{
    if (nil == _temContentLbl)
    {
        _temContentLbl = [[UILabel alloc]init];
        _temContentLbl.textAlignment = UITextAlignmentLeft;
        _temContentLbl.font = [UIFont systemFontOfSize:14.0];
        _temContentLbl.backgroundColor = [UIColor clearColor];
        _temContentLbl.frame = CGRectMake(13, 9, 40, 30);
        [self.contentView addSubview:_temContentLbl];
    }
    return _temContentLbl;
}

- (EvaluationView *)starView{
    
    if (!_starView) {
        
        _starView = [[EvaluationView alloc] init];
        
        _starView.backgroundColor = [UIColor clearColor];
        
        _starView.frame = CGRectMake(190, 60, 70, 19);
        
        [self.contentView addSubview:_starView];
    }
    return _starView;
    
}

#pragma mark -
#pragma mark Tool Bar Button

- (ToolBarButton *)defaultAddressButton
{
    if (!_defaultAddressButton)
    {
        _defaultAddressButton = [[ToolBarButton alloc] init];
        _defaultAddressButton.frame = CGRectMake(50, 9, 100, 30);
        _defaultAddressButton.delegate = self;
        _defaultAddressButton.backgroundColor = [UIColor clearColor];
        [_defaultAddressButton setBackgroundImage:[UIImage imageNamed:kProductDetailAddToShoppingCarWithNoStore] forState:UIControlStateNormal];
        _defaultAddressButton.titleLabel.font = [UIFont fontWithName:@"Heiti k" size:14.0];
        _defaultAddressButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        UIEdgeInsets inset = {0,4,0,0};
        _defaultAddressButton.titleEdgeInsets = inset;
        [_defaultAddressButton setTitleColor:RGBCOLOR(82, 92, 137) forState:UIControlStateNormal];
        _defaultAddressButton.inputView = self.addressPickerView;
        [self.contentView addSubview:_defaultAddressButton];
    }
    return _defaultAddressButton;
}

#pragma mark -
#pragma mark Tool Bar Delegate Methods

- (void)doneButtonClicked:(id)sender
{
    
    AddressInfoDTO *selectInfo = self.addressPickerView.selectAddressInfo;
    if (selectInfo.province == nil ||
        selectInfo.city == nil) {
        return;
    }
    
    [self.defaultAddressButton resignFirstResponder];
    
    //修改了默认城市
    [Config currentConfig].defaultProvince = selectInfo.province;
    [Config currentConfig].defaultCity = selectInfo.city;
    [Config currentConfig].defaultSection = selectInfo.district;
    [[NSNotificationCenter defaultCenter] postNotificationName:DEFAULT_CITY_CHANGE_NOTIFICATION object:nil];
}


#pragma mark -
#pragma mark Picker View

- (AddressInfoPickerView *)addressPickerView
{
    if (!_addressPickerView) {
        AddressInfoDTO *address = [[AddressInfoDTO alloc] init];
        address.province = [Config currentConfig].defaultProvince;
        address.city = [Config currentConfig].defaultCity;
        address.district = [Config currentConfig].defaultSection;
        _addressPickerView = [[AddressInfoPickerView alloc] initWithBaseAddressInfo:address compentCount:AddressPickerViewCompentThree];
        _addressPickerView.showsSelectionIndicator = YES;
        _addressPickerView.addressDelegate = self;
    }
    return _addressPickerView;
}

#pragma mark -
#pragma mark address picker view delegate

- (void)addressPickerLoadDataOkWithSelectInfo:(AddressInfoDTO *)addressInfo
{
    NSString *cityName = self.addressPickerView.selectAddressInfo.cityContent;
    
    NSString *sectionName = self.addressPickerView.selectAddressInfo.districtContent;
    
    NSString *buttonTitle = [NSString stringWithFormat:@"%@ %@ ",cityName,sectionName];
    
    [self.defaultAddressButton setTitle:buttonTitle forState:UIControlStateNormal];
    
    //    NSLog(@"-lxk---%@-",buttonTitle);
}
@end
