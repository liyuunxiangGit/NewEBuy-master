//
//  NProDetailThirdCell.m
//  SuningEBuy
//
//  Created by xmy on 18/12/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "NProDetailThirdCell.h"
#import "SNSwitch.h"

#define NKOrigionX 15
#define NKOrigionY 5

#define NKLblWidth 100
#define NKLblHeight 30

@implementation NProDetailThirdCell

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
        
        _downPrice.text = [NSString stringWithFormat:@"%@:",L(@"Product_CuxiaoPrice")];
        
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

- (UILabel *)activetyTitleLbl
{
    if (!_activetyTitleLbl) {
        _activetyTitleLbl = [[UILabel alloc] init];
        
        _activetyTitleLbl.backgroundColor = [UIColor clearColor];
        
        _activetyTitleLbl.font = [UIFont systemFontOfSize:14];
        
        _activetyTitleLbl.text = L(@"Product_Activity");
        
        _activetyTitleLbl.textColor = [UIColor blackColor];
        
        _activetyTitleLbl.hidden = NO;
    }
    return _activetyTitleLbl;
}

- (UILabel*)activetyLbl
{
    if(!_activetyLbl)
    {
        _activetyLbl = [[UILabel alloc] init];
        
        _activetyLbl.backgroundColor = [UIColor clearColor];
        
        _activetyLbl.font = [UIFont systemFontOfSize:14];
        
        _activetyLbl.textColor = RGBCOLOR(244, 81, 0);
        
        _activetyLbl.textAlignment = UITextAlignmentLeft;
        
        _activetyLbl.hidden = NO;
        
        _activetyLbl.numberOfLines = 0;
        
        _activetyLbl.lineBreakMode = NSLineBreakByCharWrapping;
        
    }
    
    return _activetyLbl;
    
}

- (UIImageView *)linImgView
{
    if (!_linImgView) {
        _linImgView = [[UIImageView alloc] init];
        _linImgView.image = [UIImage imageNamed:@"line.png"];
        
    }
    return _linImgView;
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

- (void)setNProDetailThirdCellInfo:(DataProductBasic *)dto
{
    if (dto == nil || dto == self.nDto)
    {
        return;
    }
    
    self.nDto = dto;
    
    [self.contentView addSubview:self.eGoPriceLbl];
    [self.contentView addSubview:self.eGoPrice];
    [self.contentView addSubview:self.downPrice];
    [self.contentView addSubview:self.downPriceLbl];
    [self.contentView addSubview:self.activetyLbl];
//    [self.contentView addSubview:self.activetyImageView];
    [self.contentView addSubview:self.activetyTitleLbl];
    [self.contentView addSubview:self.sellPointLab];
    [self.contentView addSubview:self.linImgView];
    
    [self isCanBuy:dto];
    
    if(IsStrEmpty(dto.favourDesc))
    {
//        self.activetyImageView.hidden = YES;
        self.activetyTitleLbl.hidden = YES;
        self.activetyLbl.hidden = YES;
        self.linImgView.hidden = YES;
    }
    else
    {
        if ((dto.isPublished && !dto.isCShop) || dto.isCShop) {
//            self.activetyImageView.hidden = NO;
            self.activetyTitleLbl.hidden = NO;
            self.activetyLbl.hidden = NO;
            self.linImgView.hidden = NO;
            //设置促销活动
            
            CGFloat lblHeight = [self setCUXIAOActivityCellHeight:dto];
            
            self.activetyLbl.text = dto.favourDesc;
            
            self.linImgView.frame = CGRectMake(15, 40, 305, 0.5);
            self.activetyLbl.frame = CGRectMake(55,52, 255, lblHeight);
//            self.activetyImageView.frame = CGRectMake(15, 49.5, 20, 20);
            self.activetyTitleLbl.frame = CGRectMake(15, 52, 35, 20);
            
            [self.contentView addSubview:self.activetyLbl];
        }else
        {
//            self.activetyImageView.hidden = YES;
            self.activetyTitleLbl.hidden = YES;
            self.activetyLbl.hidden = YES;
            self.linImgView.hidden = YES;
        }
        
    }
}
//设置促销活动高度
- (CGFloat)setCUXIAOActivityCellHeight:(DataProductBasic*)dto
{
    CGSize sizeCu = [dto.favourDesc sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(255, MAXFLOAT)];
    CGSize sizeOneLine = [L(@"Product_Suning") sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(255, MAXFLOAT)];
    
    if(sizeOneLine.height == sizeCu.height)
    {
        return 20;
    }
    else
    {
        return sizeCu.height;
        
    }
}
//设置价格显示规则
- (void)setProductPrice:(DataProductBasic*)dto
{
    if ([self isEGOLblBool:dto]) {
        
        self.eGoPriceLbl.hidden = NO;
        self.eGoPrice.hidden = NO;
        
        if(dto.isOnlyNetPrice == NO)
        {
            self.downPriceLbl.hidden = NO;
            self.downPrice.hidden = NO;
            self.eGoPriceLbl.hidden = YES;
            self.eGoPrice.hidden = YES;
            
            self.downPrice.frame = CGRectMake(NKOrigionX, NKOrigionY, 55, NKLblHeight);
            self.downPriceLbl.frame = CGRectMake(self.downPrice.right, NKOrigionY, NKLblWidth, NKLblHeight);
            self.downPriceLbl.text = [NSString stringWithFormat:@"¥ %.2f",[dto.suningPrice doubleValue]];
            
            self.downPrice.font = [UIFont boldSystemFontOfSize:15];
            self.downPriceLbl.font = [UIFont boldSystemFontOfSize:15];
            
            self.downPrice.textColor = [UIColor colorWithRGBHex:0x333333];
            self.downPriceLbl.textColor = [UIColor colorWithRGBHex:0xff0000];
            
            if ([SNSwitch isNeednetPrice] == YES) {
                
                self.eGoPriceLbl.hidden = NO;
                self.eGoPrice.hidden = NO;
                
                self.eGoPrice.frame = CGRectMake(self.downPriceLbl.right+10, NKOrigionY, 55, NKLblHeight);
                self.eGoPriceLbl.frame = CGRectMake(self.eGoPrice.right, NKOrigionY, NKLblWidth, NKLblHeight);
                self.eGoPriceLbl.text = [NSString stringWithFormat:@"¥ %.2f",[dto.netPrice doubleValue]];
                
                self.eGoPrice.font = [UIFont systemFontOfSize:12];
                self.eGoPriceLbl.font = [UIFont systemFontOfSize:12];
                self.eGoPriceLbl.isWithStrikeThrough = YES;
                
                self.eGoPrice.textColor = [UIColor colorWithRGBHex:0x666666];
                self.eGoPriceLbl.textColor = [UIColor colorWithRGBHex:0x999999];
            }
        }
        else
        {
            self.downPriceLbl.hidden = YES;
            self.downPrice.hidden = YES;
            
            self.eGoPrice.frame = CGRectMake(NKOrigionX, NKOrigionY, 55, NKLblHeight);
            self.eGoPriceLbl.frame = CGRectMake(self.eGoPrice.right, NKOrigionY, NKLblWidth, NKLblHeight);
            self.eGoPriceLbl.text = [NSString stringWithFormat:@"¥ %.2f",[dto.suningPrice doubleValue]];
            
            self.eGoPrice.font = [UIFont boldSystemFontOfSize:15];
            self.eGoPriceLbl.font = [UIFont boldSystemFontOfSize:15];
            self.eGoPriceLbl.textAlignment = UITextAlignmentLeft;
            
            self.eGoPrice.textColor = [UIColor colorWithRGBHex:0x333333];
            self.eGoPriceLbl.textColor = [UIColor colorWithRGBHex:0xff4800];
            self.eGoPriceLbl.isWithStrikeThrough = NO;
            
            
        }
    }
    else{
        
        self.sellPointLab.text = L(@"Sorry, Not enough stock");//@"售罄";
        [self productUnSale];
    }
    
}

//是否有货
- (void)isCanBuy:(DataProductBasic*)dto
{
    //是否为C店商品，1是，0不是
    if(dto.isCShop == 1)
    {
        //暂不销售
        if ([dto.hasStorage isEqualToString:@"Z"]) {
            self.sellPointLab.text = L(@"Sorry, Not enough stock");
            [self productUnSale];
        }
        else
        {
            if ([dto.fare isEqualToString:@"-1"]) {
                self.sellPointLab.text = L(@"Sorry, Not enough stock");
                [self productUnSale];
            }
            else if((dto.suningPrice.doubleValue > 0 ))     //商品有货
            {
                [self setProductPrice:dto];
                self.sellPointLab.hidden = YES;
            }
            //商品无货
            else
            {
                self.sellPointLab.text = L(@"Sorry, Not enough stock");
                [self productUnSale];
            }
        }
        
    }
    else if(dto.isCShop == 0)
    {
        //商品已下架
        if (!dto.isPublished) {
            self.sellPointLab.text = L(@"Product_ProductNotSaleBuyOther");
            [self productUnSale];
            
            return;

        }
        // 商品有货
        if ([[dto hasStorage] isEqualToString:@"Y"])
        {
            //liukun 添加逻辑，如果商品价格为0，那么默认为商品暂停销售
            if ([dto.suningPrice doubleValue] <= 0)
            {
                self.sellPointLab.text = L(@"Sorry, Not enough stock");
                [self productUnSale];
            }
            else 
            {
                [self setProductPrice:dto];
                self.sellPointLab.hidden = YES;
            }
           
        }
        else if ([dto.hasStorage isEqualToString:@"Z"])
        {
            // 此地暂不销售
            self.sellPointLab.text = L(@"Sorry, Not enough stock");
            [self productUnSale];
            
        }
        else // 商品无货
        {
            // 此商品暂无货
            if([dto.suningPrice doubleValue] > 0)
            {
                self.sellPointLab.text = L(@"No Product");
                [self productUnSale];
            }
            else // 此地暂不销售
            {

                self.sellPointLab.text = L(@"Sorry, Not enough stock");
                [self productUnSale];
            }
        }
        
    }

}

- (void)productUnSale
{
    self.sellPointLab.hidden = NO;
    self.sellPointLab.textColor = [UIColor blackColor];
    self.eGoPrice.hidden = YES;
    self.eGoPriceLbl.hidden = YES;
    self.downPrice.hidden = YES;
    self.downPriceLbl.hidden = YES;
    self.sellPointLab.frame = CGRectMake(NKOrigionX, NKOrigionY, 300, NKLblHeight);
}

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

- (CGFloat)instantHeight:(DataProductBasic*)dto
{
    CGFloat lblHeight = [self setCUXIAOActivityCellHeight:dto];
    
    if(IsStrEmpty(dto.favourDesc))
    {
        return 40;
    }
    else
    {
        if ((dto.isPublished && !dto.isCShop) || dto.isCShop)
        {
            if (lblHeight == 20) {
                return 65 + lblHeight;
            }
            return 55+lblHeight;
        }
        else
        {
            return 40;
        }
    }
}

+ (CGFloat)NProDetailThirdCellHeight:(DataProductBasic*)dto
{
    if (dto != nil)
    {
        return [[NProDetailThirdCell alloc] instantHeight:dto];
    }
    else
    {
        return 0;
    }
}


@end
