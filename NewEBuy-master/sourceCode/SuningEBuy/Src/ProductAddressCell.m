//
//  ProductAddressCell.m
//  SuningEBuy
//
//  Created by li xiaokai on 13-7-31.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "ProductAddressCell.h"

#import "NSAttributedString+Attributes.h"

@interface ProductAddressCell()
{
    BOOL        isRushProduct;
}

@end

@implementation ProductAddressCell

- (void)dealloc
{
    TT_RELEASE_SAFELY(_productDetailDTO);
    TT_RELEASE_SAFELY(_arrivetimeLbl);
    TT_RELEASE_SAFELY(_temContentLbl);
    TT_RELEASE_SAFELY(_defaultAddressButton);
    _addressPickerView.addressDelegate = nil;
    TT_RELEASE_SAFELY(_addressPickerView);
    
}

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
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    CGSize favourSize = CGSizeMake(0, 0);
    CGFloat heightAdd = 0;
    if (IsStrEmpty(self.productDetailDTO.favourDesc)) {
        self.favourImage.hidden = YES;
        self.favourLabel.hidden = YES;
    }else{
        self.favourLabel.hidden = NO;
        self.favourImage.hidden = NO;
         favourSize = [self.productDetailDTO.favourDesc sizeWithFont:[UIFont boldSystemFontOfSize:14.0] constrainedToSize:CGSizeMake(280, 100)];
        if (([self.productDetailDTO.tuangouFlag isEqualToString:@"1"] || [self.productDetailDTO.qianggouFlag isEqualToString:@"1"]) && !isRushProduct) {
            self.favourImage.frame = CGRectMake(0, 5, 18, 21);
            self.favourLabel.frame = CGRectMake(self.favourImage.right + 5, 6, 280, favourSize.height);
        }else{
            self.favourImage.frame = CGRectMake(0, -7, 18, 21);
            self.favourLabel.frame = CGRectMake(self.favourImage.right + 5, -6, 280, favourSize.height);
        }
    }    
    heightAdd = favourSize.height + 10;

    self.temContentLbl.frame = CGRectMake(0, heightAdd, 40, 30);
    self.defaultAddressButton.frame = CGRectMake(40, heightAdd, 100, 30);

    if (2 != self.rowNum) {
        
        self.arrivetimeLbl.frame = CGRectMake(self.defaultAddressButton.right+5, self.temContentLbl.top+5, self.arrivetimeLbl.width, self.arrivetimeLbl.height);
    }
    else{
        
        self.arrivetimeLbl.frame = CGRectMake(self.defaultAddressButton.right+5, self.temContentLbl.top-5, self.arrivetimeLbl.width, self.arrivetimeLbl.height);
    }
    
    
    self.priceLbl.frame = CGRectMake(self.defaultAddressButton.right+40, self.arrivetimeLbl.bottom+5, self.priceLbl.width, self.priceLbl.height);
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
        _temContentLbl.frame = CGRectMake(0, 0, 40, 30);
        _temContentLbl.textColor = [UIColor colorWithRed:121.0/255 green:121.0/255 blue:121.0/255 alpha:1];
        [self.contentView addSubview:_temContentLbl];
    }
    return _temContentLbl;
}


#pragma mark -
#pragma mark Tool Bar Button

- (ToolBarButton *)defaultAddressButton
{
    if (!_defaultAddressButton)
    {
        _defaultAddressButton = [[ToolBarButton alloc] init];
        _defaultAddressButton.frame = CGRectMake(40, 0, 100, 30);
        _defaultAddressButton.delegate = self;
        _defaultAddressButton.backgroundColor = [UIColor clearColor];
        [_defaultAddressButton setBackgroundImage:[UIImage streImageNamed:@"product_address_select.png"] forState:UIControlStateNormal];
        [_defaultAddressButton setBackgroundImage:[UIImage streImageNamed:@"product_address_select.png"] forState:UIControlEventTouchUpInside];
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


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (CGFloat)height:(DataProductBasic *)productDetail
{
    if (!IsStrEmpty(productDetail.favourDesc)) {
        CGSize favourSize = [productDetail.favourDesc sizeWithFont:[UIFont boldSystemFontOfSize:14.0] constrainedToSize:CGSizeMake(280, 100)];
        return 40 + (favourSize.height > 20 ? favourSize.height : 20);
    }
    return 40;
}
- (void)setItem:(DataProductBasic *)productDetail qiang:(PanicPurchaseDTO*)dto{
    
    isRushProduct = YES;
    if (productDetail == nil || productDetail == self.productDetailDTO)
    {
        return;
    }
    
    self.rowNum = 1;
    self.productDetailDTO = productDetail;
    
    //送达时间
    NSString *arriveTime = @"";
    //价格
    NSString *priceString = @"¥  ";
    
    //    BOOL
    self.favourLabel.text = self.productDetailDTO.favourDesc;

    if([self.productDetailDTO.suningPrice doubleValue] > 0)
    {
        priceString = [self.productDetailDTO.suningPrice formatPriceString];
    }
    
    if (productDetail.cityCode.length)
    {
        if (!self.addressPickerView.baseAddressInfo ||
            ![self.addressPickerView.baseAddressInfo.city isEqualToString:productDetail.cityCode] ||
            ![self.addressPickerView.baseAddressInfo.district isEqualToString:productDetail.xsection])
        {
            if ([AddressInfoDAO isUpdateAddressOk])
            {
                AddressInfoDAO *dao = [[AddressInfoDAO alloc] init];
                AddressInfoDTO *addressInfo = [dao getProvinceAndCityInfoByCityCode:productDetail.cityCode];
                addressInfo.district = [Config currentConfig].defaultSection;
                if (addressInfo) self.addressPickerView.baseAddressInfo = addressInfo;
            }
            else
            {
                AddressInfoDTO *addressInfo = [[AddressInfoDTO alloc] init];
                addressInfo.province = [Config currentConfig].defaultProvince;
                addressInfo.city = [Config currentConfig].defaultCity;
                addressInfo.district = [Config currentConfig].defaultSection;
                self.addressPickerView.baseAddressInfo = addressInfo;
            }
        }
    }
    
    NSMutableAttributedString *timeContentAtt = nil;
    
    if([dto.isSale isEqualToString:@"0"]){
    
        arriveTime = L(@"Sorry, Not enough stock");
        
        timeContentAtt = [[NSMutableAttributedString alloc] initWithString:arriveTime];
        [timeContentAtt setTextColor:[UIColor colorWithRed:121.0/255 green:121.0/255 blue:121.0/255 alpha:1]];
        [timeContentAtt setFont:[UIFont systemFontOfSize:15]];
    }
    // 商品有货
    else if ([[self.productDetailDTO hasStorage] isEqualToString:@"Y"])
    {
        //liukun 添加逻辑，如果商品价格为0，那么默认为商品暂停销售
        if ([self.productDetailDTO.suningPrice doubleValue] <= 0)
        {
            arriveTime = L(@"Sorry, Not enough stock");
            
            timeContentAtt = [[NSMutableAttributedString alloc] initWithString:arriveTime];
            [timeContentAtt setTextColor:[UIColor colorWithRed:121.0/255 green:121.0/255 blue:121.0/255 alpha:1]];
            [timeContentAtt setFont:[UIFont systemFontOfSize:15]];
            //self.timeContent.attributedText = timeContentAtt;
            self.priceLbl.isWithStrikeThrough = YES;
            self.priceLbl.textColor = [UIColor lightGrayColor];
        }
        // 送达日期
        else if ([self.productDetailDTO shipOffset])
        {
            self.priceLbl.isWithStrikeThrough = NO;
            self.priceLbl.textColor = [UIColor darkRedColor];
            
            //            arriveTime = [L(@"Arrive Time") stringByAppendingFormat:@"  %@",
            //                          [self.productDetailDTO shipOffset]];
            
            
            arriveTime =[NSString stringWithFormat:@"%@\n%@%@%@",L(@"DJGroup_NowOrder"),L(@"DJGroup_FaHuoHou"),[self.productDetailDTO shipOffset],L(@"DJGroup_NeiDaoDa")];
            timeContentAtt = [[NSMutableAttributedString alloc] initWithString:arriveTime];
            [timeContentAtt setTextColor:[UIColor colorWithRed:121.0/255 green:121.0/255 blue:121.0/255 alpha:1]];
            [timeContentAtt setTextColor:RGBCOLOR(0, 141, 219) range:[arriveTime rangeOfString:[self.productDetailDTO shipOffset]]];
            [timeContentAtt setFont:[UIFont boldSystemFontOfSize:15]];
            self.rowNum = 2;
            
        }
    }
    else if ([self.productDetailDTO.hasStorage isEqualToString:@"Z"])
    {
        // 此地暂不销售
        arriveTime = L(@"Sorry, Not enough stock");
        
        timeContentAtt = [[NSMutableAttributedString alloc] initWithString:arriveTime];
        [timeContentAtt setTextColor:[UIColor colorWithRed:121.0/255 green:121.0/255 blue:121.0/255 alpha:1]];
        [timeContentAtt setFont:[UIFont systemFontOfSize:15]];
        self.priceLbl.isWithStrikeThrough = YES;
        self.priceLbl.textColor = [UIColor lightGrayColor];
    }
    else // 商品无货
    {
        // 此商品暂无货
        if([self.productDetailDTO.suningPrice doubleValue] > 0)
        {
            arriveTime = L(@"No Product");
            timeContentAtt = [[NSMutableAttributedString alloc] initWithString:arriveTime];
            [timeContentAtt setTextColor:[UIColor colorWithRed:121.0/255 green:121.0/255 blue:121.0/255 alpha:1]];
            [timeContentAtt setFont:[UIFont systemFontOfSize:15]];
            self.priceLbl.isWithStrikeThrough = NO;
            self.priceLbl.textColor = [UIColor darkRedColor];
        }
        else // 此地暂不销售
        {
            arriveTime = L(@"Sorry, Not enough stock");
            timeContentAtt = [[NSMutableAttributedString alloc] initWithString:arriveTime];
            [timeContentAtt setTextColor:[UIColor colorWithRed:121.0/255 green:121.0/255 blue:121.0/255 alpha:1]];
            [timeContentAtt setFont:[UIFont systemFontOfSize:15]];
            self.priceLbl.isWithStrikeThrough = YES;
            self.priceLbl.textColor = [UIColor lightGrayColor];
        }
    }
    
    self.priceLbl.text = priceString;
    
    if (self.productDetailDTO.hasStorage) {
        
        self.arrivetimeLbl.attributedText = timeContentAtt;
    }
    
    TT_RELEASE_SAFELY(timeContentAtt);
    
    
    //送至
    self.temContentLbl.text = L(@"Send to");
    
    self.priceLbl.hidden = YES;
    
    [self setNeedsLayout];

}
- (void)setItem:(DataProductBasic *)productDetail
{
    isRushProduct = NO;
    if (productDetail == nil || productDetail == self.productDetailDTO)
    {
        return;
    }
    
    self.rowNum = 1;
    self.productDetailDTO = productDetail;
    
    self.favourLabel.text = self.productDetailDTO.favourDesc;
    //送达时间
    NSString *arriveTime = @"";
    //价格
    NSString *priceString = @"¥  ";
    
    //    BOOL
    
    if([self.productDetailDTO.suningPrice doubleValue] > 0)
    {
        priceString = [self.productDetailDTO.suningPrice formatPriceString];
    }
    
    if (!self.addressPickerView.baseAddressInfo ||
        ![self.addressPickerView.baseAddressInfo.city isEqualToString:productDetail.cityCode] ||
        ![self.addressPickerView.baseAddressInfo.district isEqualToString:productDetail.xsection])
    {
        if ([AddressInfoDAO isUpdateAddressOk])
        {
            AddressInfoDAO *dao = [[AddressInfoDAO alloc] init];
            AddressInfoDTO *addressInfo = [dao getProvinceAndCityInfoByCityCode:productDetail.cityCode];
            addressInfo.district = [Config currentConfig].defaultSection;
            self.addressPickerView.baseAddressInfo = addressInfo;
        }
        else
        {
            AddressInfoDTO *addressInfo = [[AddressInfoDTO alloc] init];
            addressInfo.province = [Config currentConfig].defaultProvince;
            addressInfo.city = [Config currentConfig].defaultCity;
            addressInfo.district = [Config currentConfig].defaultSection;
            self.addressPickerView.baseAddressInfo = addressInfo;
        }
    }
    
    NSMutableAttributedString *timeContentAtt = nil;
    // 商品有货
    if ([[self.productDetailDTO hasStorage] isEqualToString:@"Y"])
    {
        //liukun 添加逻辑，如果商品价格为0，那么默认为商品暂停销售
        if ([self.productDetailDTO.suningPrice doubleValue] <= 0)
        {
            arriveTime = L(@"Sorry, Not enough stock");
            
            timeContentAtt = [[NSMutableAttributedString alloc] initWithString:arriveTime];
            [timeContentAtt setTextColor:[UIColor grayColor]];
            [timeContentAtt setFont:[UIFont systemFontOfSize:15]];
            //self.timeContent.attributedText = timeContentAtt;
            self.priceLbl.isWithStrikeThrough = YES;
            self.priceLbl.textColor = [UIColor lightGrayColor];
        }
        // 送达日期
        else if ([self.productDetailDTO shipOffset])
        {
            self.priceLbl.isWithStrikeThrough = NO;
            self.priceLbl.textColor = [UIColor darkRedColor];
            
            //            arriveTime = [L(@"Arrive Time") stringByAppendingFormat:@"  %@",
            //                          [self.productDetailDTO shipOffset]];
            
            
            arriveTime =[NSString stringWithFormat:@"%@\n%@%@%@",L(@"DJGroup_NowOrder"),L(@"DJGroup_FaHuoHou"),[self.productDetailDTO shipOffset],L(@"DJGroup_NeiDaoDa")];
            timeContentAtt = [[NSMutableAttributedString alloc] initWithString:arriveTime];
            [timeContentAtt setTextColor:[UIColor grayColor]];
            [timeContentAtt setTextColor:RGBCOLOR(32, 153, 232) range:[arriveTime rangeOfString:[self.productDetailDTO shipOffset]]];
            [timeContentAtt setFont:[UIFont boldSystemFontOfSize:15]];
            self.rowNum = 2;
            
        }
    }
    else if ([self.productDetailDTO.hasStorage isEqualToString:@"Z"])
    {
        // 此地暂不销售
        arriveTime = L(@"Sorry, Not enough stock");
        
        timeContentAtt = [[NSMutableAttributedString alloc] initWithString:arriveTime];
        [timeContentAtt setTextColor:[UIColor grayColor]];
        [timeContentAtt setFont:[UIFont systemFontOfSize:15]];
        self.priceLbl.isWithStrikeThrough = YES;
        self.priceLbl.textColor = [UIColor lightGrayColor];
    }
    else // 商品无货
    {
        // 此商品暂无货
        if([self.productDetailDTO.suningPrice doubleValue] > 0)
        {
            arriveTime = L(@"No Product");
            timeContentAtt = [[NSMutableAttributedString alloc] initWithString:arriveTime];
            [timeContentAtt setTextColor:[UIColor grayColor]];
            [timeContentAtt setFont:[UIFont systemFontOfSize:15]];
            self.priceLbl.isWithStrikeThrough = NO;
            self.priceLbl.textColor = [UIColor darkRedColor];
        }
        else // 此地暂不销售
        {
            arriveTime = L(@"Sorry, Not enough stock");
            timeContentAtt = [[NSMutableAttributedString alloc] initWithString:arriveTime];
            [timeContentAtt setTextColor:[UIColor grayColor]];
            [timeContentAtt setFont:[UIFont systemFontOfSize:15]];
            self.priceLbl.isWithStrikeThrough = YES;
            self.priceLbl.textColor = [UIColor lightGrayColor];
        }
    }
    
    self.priceLbl.text = priceString;
    
    if (self.productDetailDTO.hasStorage) {
        
        self.arrivetimeLbl.attributedText = timeContentAtt;
    }
    
    TT_RELEASE_SAFELY(timeContentAtt);
    
    
    //送至
    self.temContentLbl.text = L(@"Send to");
    
    self.priceLbl.hidden = YES;
    
    [self setNeedsLayout];
}
- (void)doneButtonClicked:(id)sender
{
    
    AddressInfoDTO *selectInfo = self.addressPickerView.selectAddressInfo;
    if (selectInfo.province == nil ||
        selectInfo.city == nil) {
        return;
    }
    
    [self.defaultAddressButton resignFirstResponder];
    
    //刷新button
    [self addressPickerLoadDataOkWithSelectInfo:selectInfo];
    
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
        
        if (1 == self.type) {
            
            _addressPickerView = [[AddressInfoPickerView alloc] initWithBaseAddressInfo:address compentCount:AddressPickerViewCompentThree];
        }
        else{
            
            _addressPickerView = [[AddressInfoPickerView alloc] initWithBaseAddressInfo:address compentCount:AddressPickerViewCompentTwo];
        }

        _addressPickerView.showsSelectionIndicator = YES;
        _addressPickerView.addressDelegate = self;
    }
    return _addressPickerView;
}

- (UIImageView *)favourImage
{
    if (!_favourImage)
    {
        _favourImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"product_favour_iamge.png"]];
        _favourImage.backgroundColor = [UIColor clearColor];
        _favourImage.frame = CGRectMake(0, 0, 18, 21);
        UILabel *title = [[UILabel alloc] init];
        title.frame = CGRectMake(2, -1, 18, 21);
        title.text = L(@"DJGroup_Cu");
        title.backgroundColor = [UIColor clearColor];
        title.textColor = [UIColor whiteColor];
        title.font = [UIFont boldSystemFontOfSize:14.0];
        [_favourImage addSubview:title];
        [self.contentView addSubview:_favourImage];
    }
    return _favourImage;
}

- (UILabel *)favourLabel
{
    if (!_favourLabel)
    {
        _favourLabel = [[UILabel alloc] init];
        _favourLabel.backgroundColor = [UIColor clearColor];
        _favourLabel.numberOfLines = 0;
        _favourLabel.font = [UIFont boldSystemFontOfSize:14.0];
        _favourLabel.textColor = [UIColor colorWithRed:121.0/255 green:121.0/255 blue:121.0/255 alpha:1];
        [self.contentView addSubview:_favourLabel];
    }
    return _favourLabel;
}

#pragma mark -
#pragma mark address picker view delegate

- (void)addressPickerLoadDataOkWithSelectInfo:(AddressInfoDTO *)addressInfo
{
    NSString *cityName = self.addressPickerView.selectAddressInfo.cityContent;
    
    NSString *sectionName = self.addressPickerView.selectAddressInfo.districtContent;
    
    NSString *buttonTitle = nil;//= [NSString stringWithFormat:@"%@ %@ ",cityName,sectionName];
    
    if (1 == self.type) {
        
        buttonTitle = [NSString stringWithFormat:@"%@ %@ ",cityName,sectionName];
    }
    else{
        
        buttonTitle = [NSString stringWithFormat:@"%@",cityName];
    }
    
    [self.defaultAddressButton setTitle:buttonTitle forState:UIControlStateNormal];
    
}

@end
