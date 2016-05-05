//
//  DJGroupDetailThirdCell.m
//  SuningEBuy
//
//  Created by xie wei on 13-7-15.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "DJGroupDetailThirdCell.h"
#import "DataProductBasic.h"
#import "NSAttributedString+Attributes.h"

#define kNormalFont  [UIFont systemFontOfSize:15.0]
#define kBigFont     [UIFont systemFontOfSize:16.0]
#define kNormalBoldFont  [UIFont boldSystemFontOfSize:15.0]
#define kBigBoldFont     [UIFont boldSystemFontOfSize:16.0]

@interface DJGroupDetailThirdCell()
{
    DataProductBasic *productDto;
    DJGroupDetailDTO *detailDto;
}
@end

@implementation DJGroupDetailThirdCell

@synthesize sendTo = _sendTo;
@synthesize defaultAddressButton = _defaultAddressButton;
@synthesize addressPickerView = _addressPickerView;
@synthesize timeTitle = _timeTitle;
@synthesize timeContent = _timeContent;
@synthesize saleOutCoutBack = _saleOutCoutBack;
@synthesize saleOutText = _saleOutText;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_sendTo);
    TT_RELEASE_SAFELY(_defaultAddressButton);
    _addressPickerView.addressDelegate = nil;
    TT_RELEASE_SAFELY(_addressPickerView);
    TT_RELEASE_SAFELY(_timeTitle);
    TT_RELEASE_SAFELY(_timeContent);
    TT_RELEASE_SAFELY(_saleOutCoutBack);
    TT_RELEASE_SAFELY(_saleOutText);
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize favourSize = CGSizeMake(0, 0);
    if (IsStrEmpty(productDto.favourDesc)) {
        self.favourImage.hidden = YES;
        self.favourLabel.hidden = YES;
    }else{
        self.favourLabel.hidden = NO;
        self.favourImage.hidden = NO;
        favourSize = [productDto.favourDesc sizeWithFont:[UIFont boldSystemFontOfSize:14.0] constrainedToSize:CGSizeMake(275, 100)];
        self.favourImage.frame = CGRectMake(0, 5, 18, 21);
        self.favourLabel.frame = CGRectMake(self.favourImage.right + 5, 7, 275, favourSize.height);
    }

    
    self.sendTo.frame = CGRectMake(0, 15 + favourSize.height, 40, 23);
    self.defaultAddressButton.frame = CGRectMake(self.sendTo.right, 10 + favourSize.height,  75, 31);
    self.timeTitle.frame = CGRectMake(self.defaultAddressButton.right + 30, self.defaultAddressButton.top-2, 150, 20);
    self.timeContent.frame = CGRectMake(self.defaultAddressButton.right + 30, self.timeTitle.bottom, 220, 23);
    
    self.saleOutCoutBack.frame = CGRectMake(0, self.timeContent.bottom, 302, 39);
    self.saleOutText.frame = CGRectMake(0, 7, 302, 25);
}

- (void)setItem:(DataProductBasic *)productDetail detailDto:(DJGroupDetailDTO *)dto
{
    productDto = productDetail;
    detailDto = dto;
    
    self.favourLabel.text = productDto.favourDesc;
    //送达时间
    NSString *arriveTime = @"";
    
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
    
    // 商品有货
    if ([[productDto hasStorage] isEqualToString:@"Y"])
    {
        //liukun 添加逻辑，如果商品价格为0，那么默认为商品暂停销售
        if ([productDto.suningPrice doubleValue] <= 0)
        {
            arriveTime = L(@"No Product");
            NSMutableAttributedString *timeContentAtt = [[NSMutableAttributedString alloc] initWithString:arriveTime];
            [timeContentAtt setTextColor:[UIColor grayColor]];
            [timeContentAtt setFont:kNormalBoldFont];
            self.timeContent.attributedText = timeContentAtt;
            TT_RELEASE_SAFELY(timeContentAtt);
        }        // 送达日期
        else if ([productDto shipOffset])
        {
            arriveTime =[NSString stringWithFormat:L(@"%@%@%@"),L(@"DJGroup_FaHuoHou"),[productDto shipOffset],L(@"DJGroup_NeiDaoDa")];
            NSMutableAttributedString *timeContentAtt = [[NSMutableAttributedString alloc] initWithString:arriveTime];
            [timeContentAtt setTextColor:[UIColor grayColor]];
            [timeContentAtt setTextColor:RGBCOLOR(32, 153, 232) range:[arriveTime rangeOfString:[productDto shipOffset]]];
            [timeContentAtt setFont:kNormalBoldFont];
            self.timeContent.attributedText = timeContentAtt;
            TT_RELEASE_SAFELY(timeContentAtt);
        }
    }
    else if ([productDto.hasStorage isEqualToString:@"Z"])
    {
        // 此地暂不销售
        arriveTime = L(@"DJGroup_NotOnSale");
        NSMutableAttributedString *timeContentAtt = [[NSMutableAttributedString alloc] initWithString:arriveTime];
        [timeContentAtt setTextColor:[UIColor grayColor]];
        [timeContentAtt setFont:kNormalBoldFont];
        self.timeContent.attributedText = timeContentAtt;
        TT_RELEASE_SAFELY(timeContentAtt);
    }
    else // 商品无货
    {
        // 此商品暂无货
        if([productDto.suningPrice doubleValue] > 0)
        {
            arriveTime = L(@"No Product");
            NSMutableAttributedString *timeContentAtt = [[NSMutableAttributedString alloc] initWithString:arriveTime];
            [timeContentAtt setTextColor:[UIColor grayColor]];
            [timeContentAtt setFont:kNormalBoldFont];
            self.timeContent.attributedText = timeContentAtt;
            TT_RELEASE_SAFELY(timeContentAtt);
        }
        else // 此地暂不销售
        {
            arriveTime = L(@"DJGroup_NotOnSale");
            NSMutableAttributedString *timeContentAtt = [[NSMutableAttributedString alloc] initWithString:arriveTime];
            [timeContentAtt setTextColor:[UIColor grayColor]];
            [timeContentAtt setFont:kNormalBoldFont];
            self.timeContent.attributedText = timeContentAtt;
            TT_RELEASE_SAFELY(timeContentAtt);
        }
    }
    
    if(IsStrEmpty(detailDto.totalQty))
    {
        detailDto.totalQty = @"0";
    }
    self.saleOutText.text = [NSString stringWithFormat:@"%@%@%@",L(@"DJGroup_AlreadyGroupBuy"),detailDto.totalQty,L(@"DJGroup_QuickOrder")];
    
    [self setNeedsLayout];
}

- (UILabel *)sendTo
{
    if(_sendTo == nil){
        _sendTo = [[UILabel alloc]init];
        _sendTo.textColor = [UIColor darkGrayColor];
        _sendTo.backgroundColor = [UIColor clearColor];
        _sendTo.font = kNormalFont;
        _sendTo.textAlignment = UITextAlignmentLeft;
        _sendTo.shadowColor = [UIColor whiteColor];
        _sendTo.shadowOffset = CGSizeMake(1, 1);
        _sendTo.text = L(@"DJGroup_SendTo");
        [self.contentView addSubview:_sendTo];
    }
    return _sendTo;
}

- (ToolBarButton *)defaultAddressButton
{
    if (!_defaultAddressButton)
    {
        _defaultAddressButton = [[ToolBarButton alloc] init];
        _defaultAddressButton.delegate = self;
        _defaultAddressButton.backgroundColor = [UIColor clearColor];
        [_defaultAddressButton setBackgroundImage:[UIImage imageNamed:@"product_address_select.png"] forState:UIControlStateNormal];
        [_defaultAddressButton setBackgroundImage:[UIImage imageNamed:@"product_address_select.png"] forState:UIControlEventTouchUpInside];
        
        _defaultAddressButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
        
        [_defaultAddressButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        _defaultAddressButton.inputView = self.addressPickerView;
        _defaultAddressButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_defaultAddressButton];
    }
    return _defaultAddressButton;
}

- (AddressInfoPickerView *)addressPickerView
{
    if (!_addressPickerView) {
        AddressInfoDTO *address = [[AddressInfoDTO alloc] init];
        address.province = [Config currentConfig].defaultProvince;
        address.city = [Config currentConfig].defaultCity;
        address.district = [Config currentConfig].defaultSection;
        _addressPickerView = [[AddressInfoPickerView alloc] initWithBaseAddressInfo:address compentCount:AddressPickerViewCompentTwo];
        _addressPickerView.showsSelectionIndicator = YES;
        _addressPickerView.addressDelegate = self;
    }
    return _addressPickerView;
}

- (UILabel *)timeTitle
{
    if(_timeTitle == nil){
        _timeTitle = [[UILabel alloc]init];
        _timeTitle.textColor = [UIColor darkGrayColor];
        _timeTitle.backgroundColor = [UIColor clearColor];
        _timeTitle.font = kNormalFont;
        _timeTitle.textAlignment = UITextAlignmentLeft;
        _timeTitle.shadowColor = [UIColor whiteColor];
        _timeTitle.shadowOffset = CGSizeMake(1, 1);
        _timeTitle.text = L(@"DJGroup_NowOrder");
        [self.contentView addSubview:_timeTitle];
    }
    return _timeTitle;
}

- (OHAttributedLabel*)timeContent
{
    if(_timeContent == nil){
        _timeContent = [[OHAttributedLabel alloc]init];
        _timeContent.backgroundColor = [UIColor clearColor];
        _timeContent.font = kNormalFont;
        _timeContent.shadowColor = [UIColor whiteColor];
        _timeContent.shadowOffset = CGSizeMake(1, 1);
        _timeContent.textAlignment = UITextAlignmentLeft;
        [self.contentView addSubview:_timeContent];
    }
    return _timeContent;
}

- (UIImageView *)saleOutCoutBack
{
    if(_saleOutCoutBack == nil){
        _saleOutCoutBack = [[UIImageView alloc]init];
        _saleOutCoutBack.image = [UIImage imageNamed:@"DJ_Detail_ProDes_Back.png"];;
        [self.contentView addSubview:_saleOutCoutBack ];
    }
    return _saleOutCoutBack;
}

- (UILabel *)saleOutText
{
    if(_saleOutText == nil){
        _saleOutText = [[UILabel alloc]init];
        _saleOutText.textColor =  RGBCOLOR(216, 138, 46);
        _saleOutText.backgroundColor = [UIColor clearColor];
        _saleOutText.font = kBigBoldFont;
        _saleOutText.textAlignment = UITextAlignmentCenter;
        [self.saleOutCoutBack addSubview:_saleOutText];
    }
    return _saleOutText;
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
#pragma mark Picker View

- (void)addressPickerLoadDataOkWithSelectInfo:(AddressInfoDTO *)addressInfo
{
    NSString *cityName = self.addressPickerView.selectAddressInfo.cityContent;
    [self.defaultAddressButton setTitle:cityName forState:UIControlStateNormal];
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
    
    [self addressPickerLoadDataOkWithSelectInfo:selectInfo];
    
    //修改了默认城市
    [Config currentConfig].defaultProvince = selectInfo.province;
    [Config currentConfig].defaultCity = selectInfo.city;
    [Config currentConfig].defaultSection = selectInfo.district;
    [[NSNotificationCenter defaultCenter] postNotificationName:DEFAULT_CITY_CHANGE_NOTIFICATION object:nil];
}

+ (CGFloat)height:(DataProductBasic *)productDetail
{
    if (!IsStrEmpty(productDetail.favourDesc)) {
        CGSize favourSize = [productDetail.favourDesc sizeWithFont:[UIFont boldSystemFontOfSize:14.0] constrainedToSize:CGSizeMake(275, 100)];
        return 100 + (favourSize.height > 20 ? favourSize.height : 20);
    }
    return 100;
}

@end
