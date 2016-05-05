//
//  NQiangGouThridCell.m
//  SuningEBuy
//
//  Created by xmy on 26/12/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "NQiangGouThridCell.h"
#import "SuNingSellDao.h"
#define NKOrigionX 15
#define NKOrigionY 5

#define NKLblWidth 100
#define NKLblHeight 30

@implementation NQiangGouThridCell

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
    
    lbl.font = [UIFont systemFontOfSize:12];
    
    lbl.textColor = [UIColor colorWithRGBHex:0x666666];
    
    lbl.textAlignment = UITextAlignmentLeft;
    
    lbl.hidden = NO;
    
}

-(UILabel *)sellPointLab{
    
    if (!_sellPointLab) {
        
        _sellPointLab = [[UILabel alloc] initWithFrame:CGRectMake(204, 85, 100, 75)];
        
        _sellPointLab.font = [UIFont systemFontOfSize:14];
        
        _sellPointLab.backgroundColor = [UIColor clearColor];
        
        _sellPointLab.numberOfLines = 0;
        
        _sellPointLab.hidden = YES;
        
        _sellPointLab.textColor = [UIColor grayColor];
    }
    
    return _sellPointLab;
}

- (UILabel*)downPrice
{
    if(!_downPrice)
    {
        _downPrice = [[UILabel alloc] init];
        
        [self setLblProtery:_downPrice];
    }
    return _downPrice;
    
}

- (UILabel*)eGoPrice
{
    if(!_eGoPrice)
    {
        _eGoPrice = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 60, 18)];
        
        [self setLblProtery:_eGoPrice];
        
        _eGoPrice.text = [NSString stringWithFormat:@"%@:",L(@"yigouPrice")];
    }
    return _eGoPrice;
    
}

- (UILabel*)activetyLbl
{
    if(!_activetyLbl)
    {
        _activetyLbl = [[UILabel alloc] init];
    
        _activetyLbl.backgroundColor = [UIColor colorWithRGBHex:0xFF4800];
        
        _activetyLbl.font = [UIFont systemFontOfSize:11];
        
        _activetyLbl.textAlignment = NSTextAlignmentCenter;
        
        _activetyLbl.textColor = [UIColor colorWithRGBHex:0xffffff];//[UIColor colorWithRed:222.0/255 green:174.0/255 blue:93.0/255 alpha:1];
        
    }
    
    return _activetyLbl;
    
}

- (UIImageView*)activetyImageView
{
    if(!_activetyImageView)
    {
        _activetyImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 12, 20, 20)];
        
        [_activetyImageView setImage:[UIImage imageNamed:@"productDetail_Cuxiao.png"]];
        
        _activetyImageView.backgroundColor = [UIColor clearColor];
        
        
    }
    
    return _activetyImageView;
}

- (UIImageView *)seperateLine
{
    if (!_seperateLine) {
        _seperateLine = [[UIImageView alloc] init];
        
        _seperateLine.image = [UIImage streImageNamed:@"line.png"];
        
        _seperateLine.backgroundColor = [UIColor clearColor];
    }
    return _seperateLine;
}

- (StrikeThroughLabel*)downPriceLbl
{
    if(!_downPriceLbl)
    {
        _downPriceLbl = [[StrikeThroughLabel alloc] init];
        
        [self setStrikeThroughLabelProtery:_downPriceLbl];
        
        _downPriceLbl.isWithStrikeThrough = NO;
        
    }
    
    return _downPriceLbl;
}

- (StrikeThroughLabel*)eGoPriceLbl
{
    if(!_eGoPriceLbl)
    {
        _eGoPriceLbl = [[StrikeThroughLabel alloc] init];
        
        [self setStrikeThroughLabelProtery:_eGoPriceLbl];
        
        _eGoPriceLbl.isWithStrikeThrough = NO;
        
        _eGoPriceLbl.textColor =[UIColor colorWithRGBHex:0xff4800];
        
        _eGoPriceLbl.frame = CGRectMake(210, self.eGoPrice.bottom+3, 80, 18);
        
    }
    
    return _eGoPriceLbl;
}

- (BigSaleDTO *)bigSaleDto
{
    if (!_bigSaleDto) {
        _bigSaleDto = [[BigSaleDTO alloc] init];
    }
    return _bigSaleDto;
}

- (AppointmentDTO *)appointmentDto
{
    if (!_appointmentDto) {
        _appointmentDto = [[AppointmentDTO alloc] init];
    }
    return _appointmentDto;
}

- (void)setStrikeThroughLabelProtery:(StrikeThroughLabel*)lbl
{
    lbl.textAlignment = UITextAlignmentLeft;
    
    lbl.frame = CGRectMake(210, 65, 80, 18);
    
    lbl.adjustsFontSizeToFitWidth = YES;
    
    lbl.font = [UIFont systemFontOfSize:15.0];
    
    lbl.textColor =[UIColor colorWithRGBHex:0xff0000];
    
    lbl.backgroundColor = [UIColor clearColor];
    
    lbl.hidden = NO;
    
}

- (UILabel*)saveLbl
{
    if(!_saveLbl)
    {
        _saveLbl = [[UILabel alloc] init];
        
        [self setLblProtery:_saveLbl];
        
        _saveLbl.textColor = [UIColor colorWithRGBHex:0x666666];
        
        _saveLbl.numberOfLines = 0;
        
        _saveLbl.font = [UIFont systemFontOfSize:13];
        
        _saveLbl.lineBreakMode = UILineBreakModeCharacterWrap;
    }
    
    return _saveLbl;
}

- (void)productUnSale
{
    self.sellPointLab.hidden = NO;
    self.downPrice.hidden = YES;
    self.downPriceLbl.hidden = YES;
    self.eGoPrice.hidden = YES;
    self.eGoPriceLbl.hidden = YES;
    self.saveLbl.hidden = YES;
    self.activetyLbl.hidden = YES;
    self.sellPointLab.frame = CGRectMake(NKOrigionX, NKOrigionY, 300, NKLblHeight);
    self.sellPointLab.textColor = [UIColor blackColor];
}

- (void)setNCellInfo:(DataProductBasic*)dto
{
//    if(IsStrEmpty(dto.favourDesc))
//    {
//        self.activetyImageView.hidden = YES;
//        self.activetyLbl.hidden = YES;
//        self.seperateLine.hidden = YES;
//    }
//    else
//    {
//        self.activetyImageView.hidden = YES;
//        self.activetyLbl.hidden = YES;
//        self.seperateLine.hidden = YES;
//        //设置促销活动
//        
//        CGFloat lblHeight = [self setCUXIAOActivityCellHeight:dto];
//        
//        self.activetyLbl.text = dto.favourDesc;
////        self.activetyLbl.frame = CGRectMake(35,self.firstTopLine.bottom + 5, 275, lblHeight);
////        self.activetyImageView.frame = CGRectMake(10, self.firstTopLine.bottom + 10, 20, 20);
//        self.seperateLine.frame = CGRectMake(10, self.activetyImageView.bottom + 10, 300, 0.5);
//        
//        
//    }
    
    [self.contentView addSubview:self.eGoPriceLbl];
//    [self.contentView addSubview:self.eGoPrice];
//    [self.contentView addSubview:self.downPrice];
    [self.contentView addSubview:self.downPriceLbl];
    [self.contentView addSubview:self.activetyLbl];
//    [self.contentView addSubview:self.activetyImageView];
    [self.contentView addSubview:self.seperateLine];
    [self.contentView addSubview:self.sellPointLab];
    [self.contentView addSubview:self.saveLbl];
    
}

//设置团购cell显示内容
- (void)setNTuanGouThridCellInfo:(DJGroupDetailDTO*)tuanGoudto WithDetail:(DataProductBasic *)dto
{
    if (dto == nil)
    {
        return;
    }
    
    //    [self setTuanGou:dto];
    
    //设置显示价格
    [self isCanBuy:dto withSpecialPriceState:TuangouPrice];
    
    self.saveLbl.frame = CGRectMake(NKOrigionX, self.downPriceLbl.bottom, self.contentView.frame.size.width, 30);
    
    [self setNCellInfo:dto];
    
}

//设置抢购cell显示内容
- (void)setNQiangGouThridCellInfo:(PanicPurchaseDTO *)qiangGouDto WithDetail:(DataProductBasic*)dto
{
    if (dto == nil)
    {
        return;
    }
    
    //设置显示价格
    [self isCanBuy:dto withSpecialPriceState:QianggouPrice];
    //    [self setQiangGou:dto];
    
    self.saveLbl.frame = CGRectMake(NKOrigionX, self.downPriceLbl.bottom, self.contentView.frame.size.width, 30);
    
    [self setNCellInfo:dto];
    
    self.downPrice.text = [NSString stringWithFormat:@"%@: ",L(@"discount")];
    
}

//设置大聚惠cell显示内容
- (void)setBigSaleThirdCellInfo:(BigSaleDTO *)bigSaleDto WithDetail:(DataProductBasic *)dto
{
    if (dto == nil)
    {
        return;
    }
    
    self.bigSaleDto = bigSaleDto;
    
    //设置显示价格
    [self isCanBuy:dto withSpecialPriceState:DajuhuiPrice];
    
    self.saveLbl.frame = CGRectMake(NKOrigionX, self.downPriceLbl.bottom, self.contentView.frame.size.width, 30);
    
    [self setNCellInfo:dto];
}

- (void)setAppointmentThirdCellInfo:(AppointmentDTO *)appointmentDto WithDetail:(DataProductBasic *)dto
{
    if (dto == nil) {
        return;
    }
    self.appointmentDto = appointmentDto;
    
    //设置显示价格
    [self isCanBuy:dto withSpecialPriceState:AppointmentPrice];
    
    [self setNCellInfo:dto];
}

//设置促销活动高度
- (CGFloat)setCUXIAOActivityCellHeight:(DataProductBasic*)dto
{
    CGSize sizeCu = [dto.favourDesc sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(275, MAXFLOAT)];
    CGSize sizeOneLine = [L(@"Product_Suning") sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(275, MAXFLOAT)];
    
    if(sizeOneLine.height == sizeCu.height)
    {
        return 30+5;
    }
    else
    {
        return sizeCu.height+5;
        
    }
}

- (void)isCanBuy:(DataProductBasic *)dto withSpecialPriceState:(SpecialPriceState)state
{
    //是否为C店商品，1是，0不是
    if(dto.isCShop == 1)
    {
        if ([[dto hasStorage] isEqualToString:@""])
        {
            if ([dto.fare isEqualToString:@"-1"]) {
                [self productUnSale];
                self.sellPointLab.text = L(@"Sorry, Not enough stock");
            }
            else if((dto.suningPrice.doubleValue > 0 ))
            {
                self.sellPointLab.hidden = YES;
                self.eGoPrice.hidden = NO;
                self.eGoPriceLbl.hidden = NO;
                self.saveLbl.hidden = NO;
                self.downPriceLbl.hidden = NO;
                self.downPrice.hidden = NO;
                self.activetyLbl.hidden = NO;
                
                if (state == QianggouPrice) {
                    [self setQiangGou:dto];
                }
                else if (state == TuangouPrice)
                {
                    [self setTuanGou:dto];
                }
                else if (state == DajuhuiPrice)
                {
                    [self setDajuhui:self.bigSaleDto withDetailDto:dto];
                }
                else if (state == AppointmentPrice)
                {
                    [self setAppointmentPrice:dto];
                }
                __gIsProduceCode = [NSString stringWithFormat:@"%@",dto.productCode];
            }
            else
            {
                [self productUnSale];
                self.sellPointLab.text = L(@"Sorry, Not enough stock");
            }
        }
        else
        {
            [self productUnSale];
            self.sellPointLab.text = L(@"Sorry, Not enough stock");
        }
        
    }
    else if(dto.isCShop == 0)
    {
        
        //商品下架
        if (!dto.isPublished) {
            [self productUnSale];
            self.sellPointLab.text = L(@"Product_ProductNotSaleBuyOther");
            
            return;
        }
        
        // 商品有货
        if ([[dto hasStorage] isEqualToString:@"Y"])
        {
            //liukun 添加逻辑，如果商品价格为0，那么默认为商品暂停销售
            if ([dto.suningPrice doubleValue] <= 0)
            {
                [self productUnSale];
                self.sellPointLab.text = L(@"Sorry, Not enough stock");
            }
            else
            {
                self.sellPointLab.hidden = YES;
                self.eGoPrice.hidden = NO;
                self.eGoPriceLbl.hidden = NO;
                self.saveLbl.hidden = NO;
                self.downPriceLbl.hidden = NO;
                self.downPrice.hidden = NO;
                self.activetyLbl.hidden = NO;
                
                if (state == QianggouPrice) {
                    [self setQiangGou:dto];
                }
                else if (state == TuangouPrice)
                {
                    [self setTuanGou:dto];
                }
                else if (state == DajuhuiPrice)
                {
                    [self setDajuhui:self.bigSaleDto withDetailDto:dto];
                }
                else if (state == AppointmentPrice)
                {
                    [self setAppointmentPrice:dto];
                }
                __gIsProduceCode = [NSString stringWithFormat:@"%@",dto.productCode];
            }
            
        }
        else if ([dto.hasStorage isEqualToString:@"Z"])
        {
            self.sellPointLab.hidden = NO;
            
            // 此地暂不销售
            [self productUnSale];
            self.sellPointLab.text = L(@"Sorry, Not enough stock");
            
        }
        else // 商品无货
        {
            // 此商品暂无货
            if([dto.suningPrice doubleValue] > 0)
            {
                
                [self productUnSale];
                self.sellPointLab.text = L(@"No Product");
                
                
            }
            else // 此地暂不销售
            {
                [self productUnSale];
                self.sellPointLab.text = L(@"Sorry, Not enough stock");
                
            }
        }
    }
}

//设置抢购价格显示规则
- (void)setQiangGou:(DataProductBasic*)dto
{
//    self.downPrice.text = @"抢购价: ";
//    self.downPrice.frame = CGRectMake(NKOrigionX, NKOrigionY, 55, NKLblHeight);
//    self.downPrice.font = [UIFont systemFontOfSize:15];
//    self.downPrice.textColor = [UIColor colorWithRGBHex:0x333333];
//    self.eGoPrice.frame = CGRectMake(180, NKOrigionY, 55, NKLblHeight);
//    self.eGoPrice.font = [UIFont systemFontOfSize:12];
//    self.eGoPrice.textColor = [UIColor colorWithRGBHex:0x666666];
    
    NSString *downPriceStr = [NSString stringWithFormat:@"¥ %.2f",[dto.qianggouPrice doubleValue]];
    CGSize size = [downPriceStr sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(150, NKLblHeight) lineBreakMode:NSLineBreakByCharWrapping];
    CGFloat downPriceWidth = size.width > 85 ? size.width : 85;
    self.downPriceLbl.frame = CGRectMake(NKOrigionX, NKOrigionY, downPriceWidth, NKLblHeight);
    self.downPriceLbl.text = downPriceStr;
    self.downPriceLbl.textAlignment = UITextAlignmentLeft;
    self.downPriceLbl.font = [UIFont systemFontOfSize:16];
    self.downPriceLbl.textColor = [UIColor colorWithRGBHex:0xff0000];
    
    NSString *eGoPriceStr = [NSString stringWithFormat:@"¥ %.2f",[dto.netPrice doubleValue]];
    CGSize size1 = [eGoPriceStr sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(NKLblWidth, NKLblHeight) lineBreakMode:NSLineBreakByCharWrapping];
    self.eGoPriceLbl.frame = CGRectMake(self.downPriceLbl.right + 15, NKOrigionY, size1.width, NKLblHeight);
    self.eGoPriceLbl.text = eGoPriceStr;
    self.eGoPriceLbl.font = [UIFont systemFontOfSize:12];
    self.eGoPriceLbl.isWithStrikeThrough = YES;
    self.eGoPriceLbl.textColor = [UIColor colorWithRGBHex:0x999999];
    
    self.activetyLbl.text = L(@"QuickBuy");
    self.activetyLbl.frame = CGRectMake(self.eGoPriceLbl.right + 20, 12, 40, 16);
}

//设置团购价格显示规则
- (void)setTuanGou:(DataProductBasic*)dto
{

//    self.downPrice.text = @"团购价: ";
//    self.downPrice.frame = CGRectMake(NKOrigionX, NKOrigionY, 55, NKLblHeight);
//    self.downPrice.font = [UIFont systemFontOfSize:15];
//    self.downPrice.textColor = [UIColor colorWithRGBHex:0x333333];
//    self.eGoPrice.frame = CGRectMake(self.downPriceLbl.right+10, NKOrigionY, 55, NKLblHeight);
//    self.eGoPrice.font = [UIFont systemFontOfSize:12];
//    self.eGoPrice.textColor = [UIColor colorWithRGBHex:0x666666];
    
    NSString *downPriceStr = [NSString stringWithFormat:@"¥ %.2f",[dto.tuangouPrice doubleValue]];
    CGSize size = [downPriceStr sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(150, NKLblHeight) lineBreakMode:NSLineBreakByCharWrapping];
    CGFloat downPriceWidth = size.width > 85 ? size.width : 85;
    self.downPriceLbl.frame = CGRectMake(NKOrigionX, NKOrigionY, downPriceWidth, NKLblHeight);
    self.downPriceLbl.text = downPriceStr;
    self.downPriceLbl.font = [UIFont systemFontOfSize:16];
    self.downPriceLbl.textColor = [UIColor colorWithRGBHex:0xff0000];
    
    NSString *eGoPriceStr = [NSString stringWithFormat:@"¥ %.2f",[dto.netPrice doubleValue]];
    CGSize size1 = [eGoPriceStr sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(NKLblWidth, NKLblHeight) lineBreakMode:NSLineBreakByCharWrapping];
    self.eGoPriceLbl.frame = CGRectMake(self.downPriceLbl.right + 15, NKOrigionY, size1.width, NKLblHeight);
    self.eGoPriceLbl.text = eGoPriceStr;
    self.eGoPriceLbl.font = [UIFont systemFontOfSize:12];
    self.eGoPriceLbl.textColor = [UIColor colorWithRGBHex:0x999999];
    self.eGoPriceLbl.isWithStrikeThrough = YES;
    
    self.activetyLbl.text = L(@"Group Purchase");
    self.activetyLbl.frame = CGRectMake(self.eGoPriceLbl.right + 20, 12, 40, 16);
}

//设置大聚惠价格显示规则
- (void)setDajuhui:(BigSaleDTO *)dto withDetailDto:(DataProductBasic *)productDto;
{
    
//    self.downPrice.text = @"促销价: ";
//    self.downPrice.frame = CGRectMake(NKOrigionX, NKOrigionY, 55, NKLblHeight);
//    self.downPrice.font = [UIFont systemFontOfSize:15];
//    self.downPrice.textColor = [UIColor colorWithRGBHex:0x333333];
//    self.eGoPrice.frame = CGRectMake(self.downPriceLbl.right+10, NKOrigionY, 55, NKLblHeight);
//    self.eGoPrice.font = [UIFont systemFontOfSize:12];
//    self.eGoPrice.textColor = [UIColor colorWithRGBHex:0x666666];
    
    NSString *downPriceStr = [NSString stringWithFormat:@"¥ %.2f",[dto.gbPrice doubleValue]];
    CGSize size = [downPriceStr sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(150, NKLblHeight) lineBreakMode:NSLineBreakByCharWrapping];
    CGFloat downPriceWidth = size.width > 85 ? size.width : 85;
    self.downPriceLbl.frame = CGRectMake(NKOrigionX, NKOrigionY, downPriceWidth, NKLblHeight);
    self.downPriceLbl.text = downPriceStr;
    self.downPriceLbl.font = [UIFont systemFontOfSize:16];
    self.downPriceLbl.textColor = [UIColor colorWithRGBHex:0xff0000];
    
    NSString *eGoPriceStr = [NSString stringWithFormat:@"¥ %.2f",[productDto.netPrice doubleValue]];
    CGSize size1 = [eGoPriceStr sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(NKLblWidth, NKLblHeight) lineBreakMode:NSLineBreakByCharWrapping];
    self.eGoPriceLbl.frame = CGRectMake(self.downPriceLbl.right + 15, NKOrigionY, size1.width, NKLblHeight);
    self.eGoPriceLbl.text = eGoPriceStr;
    self.eGoPriceLbl.font = [UIFont systemFontOfSize:12];
    self.eGoPriceLbl.textColor = [UIColor colorWithRGBHex:0x999999];
    self.eGoPriceLbl.isWithStrikeThrough = YES;
    
    self.activetyLbl.text = L(@"Product_BigGatherSale");
    self.activetyLbl.frame = CGRectMake(self.eGoPriceLbl.right + 20, 12, 40, 16);
}

- (void)setAppointmentPrice:(DataProductBasic *)dto
{
    self.sellPointLab.hidden = YES;
    self.eGoPrice.hidden = NO;
    self.eGoPriceLbl.hidden = NO;
    self.saveLbl.hidden = YES;
    self.downPriceLbl.hidden = NO;
    self.downPrice.hidden = NO;
    if ([dto.appointPrice doubleValue] > 0) {
        self.downPrice.text = L(@"Product_CuxiaoPrice");
        self.downPrice.frame = CGRectMake(NKOrigionX, NKOrigionY, 55, NKLblHeight);
        self.downPriceLbl.frame = CGRectMake(self.downPrice.right, NKOrigionY, NKLblWidth, NKLblHeight);
        self.downPriceLbl.text = [NSString stringWithFormat:@"¥ %.2f",[dto.appointPrice doubleValue]];
        
        self.downPrice.font = [UIFont systemFontOfSize:15];
        self.downPriceLbl.font = [UIFont systemFontOfSize:15];
        
        self.downPrice.textColor = [UIColor colorWithRGBHex:0x333333];
        self.downPriceLbl.textColor = [UIColor colorWithRGBHex:0xff0000];
        
        self.eGoPrice.frame = CGRectMake(self.downPriceLbl.right+10, NKOrigionY, 55, NKLblHeight);
        self.eGoPriceLbl.frame = CGRectMake(self.eGoPrice.right, NKOrigionY, NKLblWidth, NKLblHeight);
        self.eGoPriceLbl.text = [NSString stringWithFormat:@"¥ %.2f",[dto.netPrice doubleValue]];
        
        self.eGoPrice.font = [UIFont systemFontOfSize:12];
        self.eGoPriceLbl.font = [UIFont systemFontOfSize:12];
        
        self.eGoPrice.textColor = [UIColor colorWithRGBHex:0x666666];
        self.eGoPriceLbl.textColor = [UIColor colorWithRGBHex:0x999999];
        self.eGoPriceLbl.isWithStrikeThrough = YES;
    }else
    {
        self.eGoPrice.hidden = YES;
        self.eGoPriceLbl.hidden = YES;
        
        self.downPrice.text = [NSString stringWithFormat:@"%@: ",L(@"Product_CuxiaoPrice")];
        self.downPrice.frame = CGRectMake(NKOrigionX, NKOrigionY, 55, NKLblHeight);
        self.downPriceLbl.frame = CGRectMake(self.downPrice.right, NKOrigionY, NKLblWidth, NKLblHeight);
        self.downPriceLbl.text = [NSString stringWithFormat:@"¥ %.2f",[dto.suningPrice doubleValue]];
        
        self.downPrice.font = [UIFont systemFontOfSize:15];
        self.downPriceLbl.font = [UIFont systemFontOfSize:15];
        
        self.downPrice.textColor = [UIColor colorWithRGBHex:0x333333];
        self.downPriceLbl.textColor = [UIColor colorWithRGBHex:0xff0000];
    }
    

}

//抢购价判断
-(BOOL)isDownLblBool:(DataProductBasic*)downDto
{
    if([downDto.qianggouPrice doubleValue] > 0)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

//易购价
-(BOOL)isEGOLblBool:(DataProductBasic*)downDto
{
    if([downDto.suningPrice doubleValue] > 0)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

//cell高度设置
- (CGFloat)instantHeightWithDetail:(DataProductBasic *)dto withType:(ProductDeatailType)type
{
    //只有sellerPointLbl是高度小，其他为2行高度大
    //是否为C店商品，1是，0不是
    if(dto.isCShop == 1)
    {
        if ([[dto hasStorage] isEqualToString:@""])
        {
            if((dto.suningPrice.doubleValue > 0 ))
            {
                _isQiangOrTuan = YES;
                
            }
            else
            {
                _isQiangOrTuan = NO;
            }
        }
        else
        {
            _isQiangOrTuan = NO;
        }
    }
    else if(dto.isCShop == 0)
    {
        // 商品有货
        if ([[dto hasStorage] isEqualToString:@"Y"])
        {
            //liukun 添加逻辑，如果商品价格为0，那么默认为商品暂停销售
            if ([dto.suningPrice doubleValue] <= 0)
            {
                _isQiangOrTuan = NO;
            }
            else
            {
                _isQiangOrTuan = YES;
            }
        }
        else if ([dto.hasStorage isEqualToString:@"Z"])
        {
            _isQiangOrTuan = NO;
        }
        else // 商品无货
        {
            // 此商品暂无货
            if([dto.suningPrice doubleValue] > 0)
            {
                _isQiangOrTuan = NO;
            }
            else // 此地暂不销售
            {
                _isQiangOrTuan = NO;
            }
        }
    }
    
    //业务要求不展示团购促销信息
    if (_isQiangOrTuan == YES)
    {
        if (type == AppointmentProduct) {
            return 40;
        }
        return 70;
        
    }
    else
    {
        return 40;
    }
}

+ (CGFloat)NSpecialThirdCellHeight:(DataProductBasic *)dto withType:(ProductDeatailType)type
{
    if (dto != nil) {
        return [[NQiangGouThridCell alloc] instantHeightWithDetail:dto withType:type];
    }
    return 0;
}


@end
