//
//  NProDetailFourthCell.m
//  SuningEBuy
//
//  Created by xmy on 18/12/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "NProDetailFourthCell.h"
#import "NSAttributedString+Attributes.h"
#import <SSA_IOS/SSAIOSSNDataCollection.h>

#define KFourOrightX 5
#define KFourOrightY 5

#define DefaltAddressTextColor [UIColor blackColor]

@implementation NProDetailFourthCell

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

- (void)setLblProtery:(UILabel*)lbl
{
    lbl.backgroundColor = [UIColor clearColor];
    
    lbl.font = [UIFont systemFontOfSize:14];
    
    lbl.textColor = DefaltAddressTextColor;//[UIColor colorWithRed:121.0/255 green:121.0/255 blue:121.0/255 alpha:1];
}

- (UILabel*)songZhiLbl
{
    if(!_songZhiLbl)
    {
        _songZhiLbl = [[UILabel alloc] init];
        
        [self setLblProtery:_songZhiLbl];
        
        _songZhiLbl.text = L(@"Send to");
        
    }
    
    return _songZhiLbl;
}
- (OHAttributedLabel*)deliveryFeeLbl
{
    if(!_deliveryFeeLbl)
    {        
        _deliveryFeeLbl = [[OHAttributedLabel alloc]init];
        
        _deliveryFeeLbl.backgroundColor = [UIColor clearColor];
        
        _deliveryFeeLbl.font = [UIFont systemFontOfSize:14];
        
        _deliveryFeeLbl.size = CGSizeMake(160, 30);
        
        _deliveryFeeLbl.shadowColor = [UIColor clearColor];
        
//        _deliveryFeeLbl.shadowOffset = CGSizeMake(1, 1);
        
        _deliveryFeeLbl.textAlignment = UITextAlignmentLeft;
        
        _deliveryFeeLbl.numberOfLines = 1;
        
    }
    
    return _deliveryFeeLbl;
}

- (UIImageView *)topLineImgView
{
    if (!_topLineImgView) {
        _topLineImgView = [[UIImageView alloc] init];
        _topLineImgView.image = [UIImage imageNamed:@"line.png"];
        [self.contentView addSubview:_topLineImgView];
    }
    return _topLineImgView;
}

#pragma mark-
#pragma mark 送达时间
- (UILabel *)arrivetimeLbl
{
    if (nil == _arrivetimeLbl)
    {
        _arrivetimeLbl = [[UILabel alloc]init];
        _arrivetimeLbl.backgroundColor = [UIColor clearColor];
        _arrivetimeLbl.font = [UIFont systemFontOfSize:12];
//        _arrivetimeLbl.size = CGSizeMake(160, 40);
//        _arrivetimeLbl.shadowColor = [UIColor whiteColor];
//        _arrivetimeLbl.shadowOffset = CGSizeMake(1, 1);
        _arrivetimeLbl.textColor = [UIColor colorWithRGBHex:0x707070];
        _arrivetimeLbl.textAlignment = NSTextAlignmentLeft;
        
        [self.contentView addSubview:_arrivetimeLbl];
    }
    return _arrivetimeLbl;
}



-(UIImageView *)thirdTopLine{
    
    if (!_thirdTopLine) {
        
        _thirdTopLine = [[UIImageView alloc]init];
        
        _thirdTopLine.backgroundColor = [UIColor clearColor];
        
        _thirdTopLine.image = [UIImage streImageNamed:@"line.png"];
        
        [self.contentView addSubview:_thirdTopLine];
    }
    return _thirdTopLine;
}



#pragma mark -
#pragma mark Tool Bar Button
-(void)buttonTapped:(id)sender
{
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"121302"], nil]];
}

- (ToolBarButton *)defaultAddressButton
{
    if (!_defaultAddressButton)
    {
        _defaultAddressButton = [[ToolBarButton alloc] init];
        _defaultAddressButton.frame = CGRectMake(40, KFourOrightY, 60, 30);
        _defaultAddressButton.delegate = self;
        _defaultAddressButton.backgroundColor = [UIColor clearColor];
        [_defaultAddressButton setBackgroundImage:[UIImage streImageNamed:@"city_select.png"] forState:UIControlStateNormal];
        [_defaultAddressButton setBackgroundImage:[UIImage streImageNamed:@"city_select.png"] forState:UIControlEventTouchUpInside];
        _defaultAddressButton.titleLabel.font = [UIFont fontWithName:@"Heiti k" size:13.0];
        _defaultAddressButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        UIEdgeInsets inset = {0,4,0,0};
        _defaultAddressButton.titleEdgeInsets = inset;
        [_defaultAddressButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _defaultAddressButton.inputView = self.addressPickerView;
        [_defaultAddressButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_defaultAddressButton];
    }
    return _defaultAddressButton;
}

- (void)setNProDetailFourCellInfo:(DataProductBasic *)dto WithType:(ProductDeatailType)type coloStr:(NSString *)colorStr

{
    
    self.productDetailDTO = dto;
    self.type = type;
    self.rowNum = 1;

    if(self.type == NormalProduct)
    {
        //是否为C店商品，1是，0不是
        if(dto.isCShop == 1)
        {
            [self setCShopProductStatus:dto];
        }
        else
        {
            [self setZIYINGProductStatus:dto];
        }
    }
    else
    {
        [self setZIYINGProductStatus:dto];

    }
    
    //送至
    self.songZhiLbl.text = L(@"Send to");
    
    if([self.productDetailDTO.fare doubleValue] > 0)
    {
        
        NSMutableAttributedString *timeContentAtt = nil;

        NSString *deliveryFee =[NSString stringWithFormat:@"%@: ¥ %.2f元",L(@"Product_DeliveryMoney"),[self.productDetailDTO.fare doubleValue]];
        NSString *fee = [NSString stringWithFormat:@"¥ %.2f",[self.productDetailDTO.fare doubleValue]];
        
        timeContentAtt = [[NSMutableAttributedString alloc] initWithString:deliveryFee];
        
        [timeContentAtt setTextColor:DefaltAddressTextColor];
        [timeContentAtt setTextColor:[UIColor colorWithRGBHex:0xff0000] range:[deliveryFee rangeOfString:fee]];
        [timeContentAtt setFont:[UIFont systemFontOfSize:14]];
        self.deliveryFeeLbl.attributedText = timeContentAtt;
    }
    else if(IsStrEmpty(self.productDetailDTO.fare))
    {
        NSMutableAttributedString *timeContentAtt = nil;
        NSString *deliveryFee = @"";
        timeContentAtt = [[NSMutableAttributedString alloc] initWithString:deliveryFee];
        self.deliveryFeeLbl.attributedText = timeContentAtt;
    }
    else
    {
        NSMutableAttributedString *timeContentAtt = nil;
        
        NSString *deliveryFee =L(@"Product_NoDeliveryMoney");
        
        timeContentAtt = [[NSMutableAttributedString alloc] initWithString:deliveryFee];
        
        [timeContentAtt setTextColor:DefaltAddressTextColor];
        [timeContentAtt setFont:[UIFont systemFontOfSize:14]];
        self.deliveryFeeLbl.attributedText = timeContentAtt;
    }
    
    
    

    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (!self.productDetailDTO) {
        return;
    }
    
    self.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.topLineImgView.frame = CGRectMake(15, 0, 305, 0.5);
    [self.contentView addSubview:self.songZhiLbl];
    [self.contentView addSubview:self.defaultAddressButton];
    [self.contentView addSubview:self.deliveryFeeLbl];
    [self.contentView addSubview:self.arrivetimeLbl];
    self.songZhiLbl.frame = CGRectMake(15, 15, 35, 20);
    self.defaultAddressButton.frame = CGRectMake(55, 12, 70, 30);

    
    self.deliveryFeeLbl.frame = CGRectMake(self.defaultAddressButton.right+30, 19, 100, 30);
    
    self.arrivetimeLbl.frame = CGRectMake(self.defaultAddressButton.left, self.defaultAddressButton.bottom + 7, 260, 20);
       
}

//设置C店铺商品送达状态
- (void)setCShopProductStatus:(DataProductBasic*)dto
{
    if (dto.cityCode && [AddressInfoDAO isUpdateAddressOk]) {
        AddressInfoDAO *dao = [[AddressInfoDAO alloc] init];
        AddressInfoDTO *addressInfo = [dao getProvinceAndCityInfoByCityCode:dto.cityCode];
        addressInfo.district = [Config currentConfig].defaultSection;
        self.addressPickerView.baseAddressInfo = addressInfo;
        [self.defaultAddressButton setTitle:addressInfo.cityContent forState:UIControlStateNormal];

    }
    
    self.arrivetimeLbl.hidden = YES;
    self.thirdTopLine.frame = CGRectMake(0, 55.5, 320, 0.5);

}
//设置自营店铺商品送达状态
- (void)setZIYINGProductStatus:(DataProductBasic*)dto
{
    if (dto.cityCode.length)
    {
        if (!self.addressPickerView.baseAddressInfo ||
            ![self.addressPickerView.baseAddressInfo.city isEqualToString:dto.cityCode] ||
            ![self.addressPickerView.baseAddressInfo.district isEqualToString:dto.xsection])
        {
            if ([AddressInfoDAO isUpdateAddressOk])
            {
                AddressInfoDAO *dao = [[AddressInfoDAO alloc] init];
                AddressInfoDTO *addressInfo = [dao getProvinceAndCityInfoByCityCode:dto.cityCode];
                addressInfo.district = [Config currentConfig].defaultSection;
                if (addressInfo) self.addressPickerView.baseAddressInfo = addressInfo;
                
                [self.defaultAddressButton setTitle:addressInfo.cityContent forState:UIControlStateNormal];
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
    self.arrivetimeLbl.hidden = NO;
    //送达时间
    NSString *arriveTime = @"";
    
    // 商品有货
    if ([[self.productDetailDTO hasStorage] isEqualToString:@"Y"])
    {
        //liukun 添加逻辑，如果商品价格为0，那么默认为商品暂停销售
        if ([self.productDetailDTO.suningPrice doubleValue] <= 0)
        {
            arriveTime = @"";
            self.thirdTopLine.frame = CGRectMake(0, 55.5, 320, 0.5);
        }
        // 送达日期
        else if ([self.productDetailDTO shipOffSetText])
        {
            self.thirdTopLine.frame = CGRectMake(0, 74.5, 320, 0.5);
            arriveTime = self.productDetailDTO.shipOffSetText;

            self.rowNum = 2;
        }
    }
    else
    {
        // 此地暂不销售
        arriveTime = @"";
        self.thirdTopLine.frame = CGRectMake(0, 55.5, 320, 0.5);

    }
        
    if (self.productDetailDTO.hasStorage) {
        
        self.arrivetimeLbl.text = arriveTime;
    }
}


- (CGFloat)cellHeight:(DataProductBasic *)dto WithType:(ProductDeatailType)type

{
    if(type == NormalProduct)
    {
        if (1 == dto.isCShop) {
            return 56;
        }
        else
        {
            if (IsStrEmpty(dto.shipOffset)) {
                return 56;
            }
            else
            {
                // 商品有货
                if ([[dto hasStorage] isEqualToString:@"Y"])
                {
                    //liukun 添加逻辑，如果商品价格为0，那么默认为商品暂停销售
                    if ([dto.suningPrice doubleValue] <= 0)
                    {
                        return 56;
                    }
                    // 送达日期
                    else
                    {
                        return 75;
                    }
                }
                else // 商品无货
                {
                    return 56;
                }
                
            }
        }
    }
    else
    {
        if (IsStrEmpty(dto.shipOffset)) {
            return 56;
        }
        else
        {
            // 商品有货
            if ([[dto hasStorage] isEqualToString:@"Y"])
            {
                //liukun 添加逻辑，如果商品价格为0，那么默认为商品暂停销售
                if ([dto.suningPrice doubleValue] <= 0)
                {
                    return 56;
                }
                // 送达日期
                else
                {
                    return 75;
                }
            }
            else // 商品无货
            {
                return 56;
            }
        }
    }
    
}

+ (CGFloat)NProDetailFourCellHeight:(DataProductBasic *)dto WithType:(ProductDeatailType)type
{
    return [[NProDetailFourthCell alloc] cellHeight:dto WithType:type];
}

//展示评价标签
- (void)setAppraisalLabel:(DataProductBasic*)dto
{
    
}

//展示评价
- (void)setAppraisal:(DataProductBasic *)dto
{
    
}

#pragma mark -
#pragma mark Picker View

- (AddressInfoPickerView *)addressPickerView
{
    if (!_addressPickerView) {
        
        AddressInfoDTO *address = nil;
        AddressInfoDAO *dao = [[AddressInfoDAO alloc] init];
        address = [dao getProvinceAndCityInfoByCityCode:self.productDetailDTO.cityCode];
        
        if (!address) {
            address = [[AddressInfoDTO alloc] init];
            address.province = [Config currentConfig].defaultProvince;
            address.city = [Config currentConfig].defaultCity;
            address.district = [Config currentConfig].defaultSection;
        }
        
        if (NormalProduct == self.type) {
        
            _addressPickerView = [[AddressInfoPickerView alloc] initWithBaseAddressInfo:address compentCount:AddressPickerViewCompentThree];
        }
        else{
            
            _addressPickerView = [[AddressInfoPickerView alloc] initWithBaseAddressInfo:address compentCount:AddressPickerViewCompentTwo];
        }
        
        _addressPickerView.showsSelectionIndicator = YES;
        _addressPickerView.addressDelegate = self;
    }
    if (NormalProduct == self.type) {
        _addressPickerView.compentCount = AddressPickerViewCompentThree;
    }
    else
    {
        _addressPickerView.compentCount = AddressPickerViewCompentTwo;
    }
    return _addressPickerView;
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
#pragma mark address picker view delegate

- (void)addressPickerLoadDataOkWithSelectInfo:(AddressInfoDTO *)addressInfo
{
    NSString *cityName = addressInfo.cityContent;
    
    DLog(@"city is %@, cityName is %@", addressInfo.city, addressInfo.cityContent);
    
    if (cityName.length) {
        NSString *buttonTitle = [NSString stringWithFormat:@"%@",cityName];
        
        [self.defaultAddressButton setTitle:buttonTitle forState:UIControlStateNormal];
    }
}


@end
