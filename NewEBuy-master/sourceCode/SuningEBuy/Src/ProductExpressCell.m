//
//  ProductExpressCell.m
//  SuningEBuy
//
//  Created by li xiaokai on 13-7-15.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "ProductExpressCell.h"
#import "NSAttributedString+Attributes.h"

@implementation ProductExpressCell


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
    return 30;
}

- (void)setItem:(DataProductBasic *)productDetail
{
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
            
            self.arrivetimeLbl.attributedText = timeContentAtt;
            
            TT_RELEASE_SAFELY(timeContentAtt);
        }
        // 送达日期
        else if ([self.productDetailDTO shipOffset])
        {
            self.priceLbl.isWithStrikeThrough = NO;
            self.priceLbl.textColor = [UIColor darkRedColor];
            
//            arriveTime = [L(@"Arrive Time") stringByAppendingFormat:@"  %@",
//                          [self.productDetailDTO shipOffset]];
            
            
            arriveTime =[NSString stringWithFormat:L(@"%@\n%@%@%@"),L(@"DJGroup_NowOrder"),L(@"DJGroup_FaHuoHou"),[self.productDetailDTO shipOffset],L(@"DJGroup_NeiDaoDa")];
            timeContentAtt = [[NSMutableAttributedString alloc] initWithString:arriveTime];
            [timeContentAtt setTextColor:[UIColor grayColor]];
            [timeContentAtt setTextColor:RGBCOLOR(32, 153, 232) range:[arriveTime rangeOfString:[self.productDetailDTO shipOffset]]];
            [timeContentAtt setFont:[UIFont boldSystemFontOfSize:15]];
            self.rowNum = 2;
            
            self.arrivetimeLbl.attributedText = timeContentAtt;
            
            TT_RELEASE_SAFELY(timeContentAtt);
            
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
        self.arrivetimeLbl.attributedText = timeContentAtt;
        
        TT_RELEASE_SAFELY(timeContentAtt);
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
            
            self.arrivetimeLbl.attributedText = timeContentAtt;
            
            TT_RELEASE_SAFELY(timeContentAtt);
        }
        else // 此地暂不销售
        {
            arriveTime = L(@"Sorry, Not enough stock");
            timeContentAtt = [[NSMutableAttributedString alloc] initWithString:arriveTime];
            [timeContentAtt setTextColor:[UIColor grayColor]];
            [timeContentAtt setFont:[UIFont systemFontOfSize:15]];
            self.priceLbl.isWithStrikeThrough = YES;
            self.priceLbl.textColor = [UIColor lightGrayColor];
            
            self.arrivetimeLbl.attributedText = timeContentAtt;
            
            TT_RELEASE_SAFELY(timeContentAtt);
        }
    }
    
    self.priceLbl.text = priceString;

//    if (self.productDetailDTO.hasStorage) {
//        
//        self.arrivetimeLbl.attributedText = timeContentAtt;
//    }
    
    
    //送至
    self.temContentLbl.text = L(@"Send to");
    
    //星级
   // [self.starView setStarsImages:self.productDetailDTO.evaluation];
    self.starView.hidden = YES;
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
    
    //修改了默认城市
    [Config currentConfig].defaultProvince = selectInfo.province;
    [Config currentConfig].defaultCity = selectInfo.city;
    [Config currentConfig].defaultSection = selectInfo.district;
    [[NSNotificationCenter defaultCenter] postNotificationName:DEFAULT_CITY_CHANGE_NOTIFICATION object:nil];
}
@end
