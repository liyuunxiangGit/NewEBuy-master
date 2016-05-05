//
//  ShopInfoDetailCell.m
//  SuningEBuy
//
//  Created by xmy on 17/10/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "ShopInfoDetailCell.h"

@implementation ShopInfoDetailCell

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

- (UILabel*)shopNameLbl
{
    if(!_shopNameLbl)
    {
        _shopNameLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 260, 15)];
        
        _shopNameLbl.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1];
        
        _shopNameLbl.textAlignment = UITextAlignmentLeft;
        
        _shopNameLbl.font = [UIFont boldSystemFontOfSize:12];
        
        _shopNameLbl.backgroundColor = [UIColor clearColor];
        
        _shopNameLbl.numberOfLines = 0;

        _shopNameLbl.lineBreakMode = UILineBreakModeCharacterWrap;
        
        [self.contentView addSubview:self.shopNameLbl];
        
    }
    
    return _shopNameLbl;
}

- (UILabel*)shopLbl
{
    if(!_shopLbl)
    {
        _shopLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, self.shopNameLbl.bottom, 60, 15)];
        
        [self setLblPropetry:_shopLbl];
        
    }
    
    return _shopLbl;
}

- (UILabel*)deliverSpeedLbl
{
    if(!_deliverSpeedLbl)
    {
        _deliverSpeedLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, self.shopLbl.bottom, 60, 15)];
        
        [self setLblPropetry:_deliverSpeedLbl];
    }
    
    return _deliverSpeedLbl;
}


- (UILabel*)deliverSpeedDetailLbl
{
    if(!_deliverSpeedDetailLbl)
    {
        _deliverSpeedDetailLbl = [[UILabel alloc] initWithFrame:CGRectMake(self.deliverSpeedLbl.right+32, self.shopLbl.bottom, 60, 15)];
        
        [self setLblPropetry:_deliverSpeedDetailLbl];
    
    }
    
    return _deliverSpeedDetailLbl;
}

- (UILabel*)sellerSpeedLbl
{
    if(!_sellerSpeedLbl)
    {
        _sellerSpeedLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, self.shopLbl.bottom, 60, 15)];
        
        [self setLblPropetry:_sellerSpeedLbl];

    }
    
    return _sellerSpeedLbl;
}


- (UILabel*)sellerSpeedDetailLbl
{
    if(!_sellerSpeedDetailLbl)
    {
        _sellerSpeedDetailLbl = [[UILabel alloc] initWithFrame:CGRectMake(self.deliverSpeedLbl.right+32, self.shopLbl.bottom, 60, 15)];
        
        [self setLblPropetry:_sellerSpeedDetailLbl];
        
    }
    
    return _sellerSpeedDetailLbl;
}


- (UILabel*)serviceSatisfyLbl
{
    if(!_serviceSatisfyLbl)
    {
        _serviceSatisfyLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, self.sellerSpeedLbl.bottom, 60, 15)];
        
        [self setLblPropetry:_serviceSatisfyLbl];

    }
    
    return _serviceSatisfyLbl;
}


- (UILabel*)serviceSatisfyDetailLbl
{
    if(!_serviceSatisfyDetailLbl)
    {
        _serviceSatisfyDetailLbl = [[UILabel alloc] initWithFrame:CGRectMake(self.serviceSatisfyLbl.right+32, self.sellerSpeedLbl.bottom, 60, 15)];
        
        [self setLblPropetry:_serviceSatisfyDetailLbl];
        
    }
    
    return _serviceSatisfyDetailLbl;
}

- (void)setLblPropetry:(UILabel*)lbl
{
    lbl.textColor = [UIColor colorWithRed:112.0/255 green:112.0/255 blue:112.0/255 alpha:1];
    
    lbl.textAlignment = UITextAlignmentLeft;
    
    lbl.font = [UIFont systemFontOfSize:12];
    
    lbl.numberOfLines = 0;
    
    lbl.lineBreakMode = UILineBreakModeCharacterWrap;
    
    lbl.backgroundColor = [UIColor clearColor];
    
}

- (void)setStarNumber:(DataProductBasic*)dto
{
    int startAllNum = 0;
    int halfNum = 0;

    if([dto.shopGrade floatValue] > 5.2)
    {
        dto.shopGrade = @"5";
    }
    
    float shopGrade = [dto.shopGrade floatValue];
    
    if(shopGrade <= 0.2)
    {
        startAllNum = 0;
        halfNum = 0;
    }
    else if(shopGrade <= 0.7)
    {
        startAllNum = 0;
        halfNum = 1;
    }
    else if(shopGrade <= 1.2)
    {
        startAllNum = 1;
        halfNum = 0;
    }
    else if(shopGrade <= 1.7)
    {
        startAllNum = 1;
        halfNum = 1;
    }
    else if(shopGrade <= 2.2)
    {
        startAllNum = 2;
        halfNum = 0;
    }
    
    else if(shopGrade <= 2.7)
    {
        startAllNum = 2;
        halfNum = 1;
    }
    else if(shopGrade <= 3.2)
    {
        startAllNum = 3;
        halfNum = 0 ;
    }
    else if(shopGrade <= 3.7)
    {
        startAllNum = 3;
        halfNum = 1;
    }
    else if(shopGrade <= 4.2)
    {
        startAllNum = 4;
        halfNum = 0;
    }
    else if(shopGrade <= 4.7)
    {
        startAllNum = 4;
        halfNum = 1;
    }
    else if(shopGrade <= 5.2)
    {
        startAllNum = 5;
        halfNum = 0;
    }

    
    for(int i=0; i<startAllNum; i++)
    {
        UIImageView *startImage = [[UIImageView alloc] init];
        
        startImage.backgroundColor = [UIColor clearColor];
        
        [startImage setImage:[UIImage imageNamed:@"CS_Star_Yellow.png"]];
        
        startImage.frame = CGRectMake(self.shopLbl.right+32+i*15, self.shopNameLbl.bottom, 15, 14);
        
        [self addSubview:startImage];
        
    }
    
    for(int n=0; n<halfNum; n++)
    {
        UIImageView *startImage = [[UIImageView alloc] init];
        
        startImage.backgroundColor = [UIColor clearColor];
        
        [startImage setImage:[UIImage imageNamed:@"CS_Star_HalfYellow.png"]];
        
        startImage.frame = CGRectMake(self.shopLbl.right+32+startAllNum*15+n*15, self.shopNameLbl.bottom, 15, 14);
        
        [self addSubview:startImage];
        
    }
    
    for(int j=0; j<5-startAllNum-halfNum; j++)
    {
        UIImageView *startImage = [[UIImageView alloc] init];
        
        startImage.backgroundColor = [UIColor clearColor];
        
        [startImage setImage:[UIImage imageNamed:@"CS_Star_Gray.png"]];
        
        startImage.frame = CGRectMake(self.shopLbl.right+32+(startAllNum+halfNum)*15+j*15, self.shopNameLbl.bottom, 15, 14);
        
        [self addSubview:startImage];

    }
    
}



- (void)setShopInfo:(DataProductBasic *)shopInfoDto
{
    self.shopNameLbl.text = shopInfoDto.shopName ;//@"三星自营店";
    
    NSString *nameTemp  = [[[NSString stringWithFormat:@"%@",shopInfoDto.shopName] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] replacedWhiteSpacsByString:@""];
    
    CGSize nameSize = [nameTemp sizeWithFont:self.shopNameLbl.font constrainedToSize:CGSizeMake(self.shopNameLbl.frame.size.width, 50) lineBreakMode:UILineBreakModeCharacterWrap];
    CGRect markFrame = self.shopNameLbl.frame;
    markFrame.size.height = nameSize.height;
    self.shopNameLbl.frame = markFrame;
    
    self.shopNameLbl.text = nameTemp;

    self.shopLbl.text = L(@"Product_SellerSatisfaction");
    [self setStarNumber:shopInfoDto];
    
//    self.deliverSpeedLbl.text = @"发货及时性";
//    self.deliverSpeedDetailLbl.text = shopInfoDto.sellerSpeed; //don't doubt it, it's right

    self.sellerSpeedLbl.text = L(@"Product_DeliverySatisfaction");
    self.sellerSpeedDetailLbl.text = shopInfoDto.deliverSpeed; //don't doubt it, it's right
    
    self.serviceSatisfyLbl.text = L(@"Product_ServiceSatisfaction");
    self.serviceSatisfyDetailLbl.text = shopInfoDto.serviceSatisfy;
    
    
    [self addSubview:self.shopNameLbl];
    [self addSubview:self.shopLbl];
//    [self addSubview:self.deliverSpeedLbl];
//    [self addSubview:self.deliverSpeedDetailLbl];
    [self addSubview:self.sellerSpeedLbl];
    [self addSubview:self.sellerSpeedDetailLbl];
    [self addSubview:self.serviceSatisfyLbl];
    [self addSubview:self.serviceSatisfyDetailLbl];
    
}



+ (CGFloat)height
{
    return 4*20;
}


@end
