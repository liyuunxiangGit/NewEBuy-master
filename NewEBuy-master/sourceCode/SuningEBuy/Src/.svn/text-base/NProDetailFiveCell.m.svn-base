//
//  NProDetailFiveCell.m
//  SuningEBuy
//
//  Created by xmy on 19/12/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "NProDetailFiveCell.h"
#import "SNSwitch.h"

@implementation NProDetailFiveCell

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

- (UIImageView *)fengelineOne
{
    if (!_fengelineOne) {
        _fengelineOne = [[UIImageView alloc] init];
        _fengelineOne.image = [UIImage streImageNamed:@"line.png"];
    }
    return _fengelineOne;
}

- (UIImageView *)fengelineTwo
{
    if (!_fengelineTwo) {
        _fengelineTwo = [[UIImageView alloc] init];
        _fengelineTwo.image = [UIImage streImageNamed:@"line.png"];
    }
    return _fengelineTwo;
}

- (UILabel*)shopNameLbl
{
    if(!_shopNameLbl)
    {
        _shopNameLbl = [[UILabel alloc] init];
        
        _shopNameLbl.textColor = [UIColor colorWithRGBHex:0x333333];//[UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1];
        
        _shopNameLbl.textAlignment = UITextAlignmentLeft;
        
        _shopNameLbl.font = [UIFont boldSystemFontOfSize:13];
        
        _shopNameLbl.backgroundColor = [UIColor clearColor];
        
        _shopNameLbl.numberOfLines = 0;
        
        _shopNameLbl.lineBreakMode = UILineBreakModeCharacterWrap;
        
        
    }
    
    return _shopNameLbl;
}

- (UILabel*)shopLbl
{
    if(!_shopLbl)
    {
        _shopLbl = [[UILabel alloc] init];
        
        [self setLblPropetry:_shopLbl];
        
        _shopLbl.textColor = [UIColor colorWithRGBHex:0xff6000];
        
    }
    
    return _shopLbl;
}

- (UILabel*)shopDetailLbl
{
    if(!_shopDetailLbl)
    {
        _shopDetailLbl = [[UILabel alloc] init];
        
        [self setLblPropetry:_shopDetailLbl];
        
        _shopDetailLbl.textColor = [UIColor colorWithRGBHex:0xff6000];

    }
    
    return _shopDetailLbl;
}


- (UILabel*)sellerSpeedLbl
{
    if(!_sellerSpeedLbl)
    {
        _sellerSpeedLbl = [[UILabel alloc] init];
        
        [self setLblPropetry:_sellerSpeedLbl];
        
        _sellerSpeedLbl.textColor = [UIColor colorWithRGBHex:0xff7800];

    }
    
    return _sellerSpeedLbl;
}

- (UILabel*)sellerSpeedDetailLbl
{
    if(!_sellerSpeedDetailLbl)
    {
        _sellerSpeedDetailLbl = [[UILabel alloc] init];
        
        [self setLblPropetry:_sellerSpeedDetailLbl];
        
        _sellerSpeedDetailLbl.textColor = [UIColor colorWithRGBHex:0xff7800];

    }
    
    return _sellerSpeedDetailLbl;
}


- (UILabel*)serviceSatisfyLbl
{
    if(!_serviceSatisfyLbl)
    {
        _serviceSatisfyLbl = [[UILabel alloc] init];
        
        [self setLblPropetry:_serviceSatisfyLbl];
        
        _serviceSatisfyLbl.textColor = [UIColor colorWithRGBHex:0xff9c00];

    }
    
    return _serviceSatisfyLbl;
}


- (UILabel*)serviceSatisfyDetailLbl
{
    if(!_serviceSatisfyDetailLbl)
    {
        _serviceSatisfyDetailLbl = [[UILabel alloc] init];
        
        [self setLblPropetry:_serviceSatisfyDetailLbl];
        
        _serviceSatisfyDetailLbl.textColor = [UIColor colorWithRGBHex:0xff9c00];

    }
    
    return _serviceSatisfyDetailLbl;
}

- (void)setLblPropetry:(UILabel*)lbl
{
    lbl.textColor = [UIColor colorWithRed:112.0/255 green:112.0/255 blue:112.0/255 alpha:1];
    
    lbl.textAlignment = UITextAlignmentLeft;
    
    lbl.font = [UIFont systemFontOfSize:13];
    
    lbl.numberOfLines = 0;
    
    lbl.lineBreakMode = UILineBreakModeCharacterWrap;
    
    lbl.backgroundColor = [UIColor clearColor];
    
}


- (UIImageView*)OnlineServiceImage
{
    if(_OnlineServiceImage)
    {
        _OnlineServiceImage = [[UIImageView alloc] init];
        
        _OnlineServiceImage.backgroundColor = [UIColor clearColor];
        
        _OnlineServiceImage.frame = CGRectMake(0, 5, 30, 30);
    }
    
    return _OnlineServiceImage;
}

-(UIImageView *)topLine{
    
    if (!_topLine) {
        
        _topLine = [[UIImageView alloc]init];
        
        _topLine.backgroundColor = [UIColor clearColor];
        
        _topLine.image = [UIImage streImageNamed:@"line.png"];
    }
    return _topLine;
}

- (UIButton*)OnlineServiceBtn
{
    if(!_OnlineServiceBtn)
    {
        _OnlineServiceBtn = [[UIButton alloc] init];
        
        _OnlineServiceBtn.backgroundColor = [UIColor clearColor];
                
        [_OnlineServiceBtn setTitleColor:[UIColor colorWithRGBHex:0xe18d00] forState:UIControlStateNormal];
        
        [_OnlineServiceBtn setTitleColor:[UIColor colorWithRGBHex:0x666666] forState:UIControlStateDisabled];
    }
    
    return _OnlineServiceBtn;
}

- (UIButton*)GoToShopBtn
{
    if(!_GoToShopBtn)
    {
        _GoToShopBtn = [[UIButton alloc] init];
        
        _GoToShopBtn.backgroundColor = [UIColor clearColor];
                
        [_GoToShopBtn setTitleColor:RGBCOLOR(144, 116, 80) forState:UIControlStateNormal];
        
//        [_GoToShopBtn setTitle:@"进入店铺" forState:UIControlStateNormal];

        [_GoToShopBtn setImage:[UIImage imageNamed:@"productDetail_goToShop_normal.png"] forState:UIControlStateNormal];
        
        [_GoToShopBtn setImage:[UIImage imageNamed:@"productDetail_goToShop_clicked.png"] forState:UIControlStateHighlighted];
        
    }
    
    return _GoToShopBtn;
}

- (UIImageView*)backView
{
    if(!_backView)
    {
        _backView = [[UIImageView alloc] init];
        
        [_backView setImage:[UIImage imageNamed:nil]];
        
        _backView.backgroundColor = [UIColor whiteColor];
        
        _backView.userInteractionEnabled = YES;
        
    }
    
    return _backView;
}


- (UIImageView *)oneLineView
{
    if (!_oneLineView) {
        _oneLineView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"segment_line_vertical_gray.png"]];
        _oneLineView.backgroundColor = [UIColor clearColor];
    }
    return _oneLineView;
}

- (UIImageView *)twoLineView
{
    if (!_twoLineView) {
        _twoLineView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"segment_line_vertical_gray.png"]];
        _twoLineView.backgroundColor = [UIColor clearColor];
    }
    return _twoLineView;
}

- (UIImageView *)threeLineView
{
    if (!_threeLineView) {
        _threeLineView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"segment_line_vertical_gray.png"]];
        _threeLineView.backgroundColor = [UIColor clearColor];
    }
    return _threeLineView;
}

- (UIImageView*)shopView
{
    if(!_shopView)
    {
        _shopView = [[UIImageView alloc] init];
        _shopView.backgroundColor = [UIColor clearColor];

    }
    
    return _shopView;
}
- (UIImageView*)serviceSatisfyView
{
    if(!_serviceSatisfyView)
    {
        _serviceSatisfyView = [[UIImageView alloc] init];
        _serviceSatisfyView.backgroundColor = [UIColor clearColor];
        
    }
    
    return _serviceSatisfyView;
}

- (UIImageView*)sellerSpeedView
{
    if(!_sellerSpeedView)
    {
        _sellerSpeedView = [[UIImageView alloc] init];
        _sellerSpeedView.backgroundColor = [UIColor clearColor];
        
    }
    
    return _sellerSpeedView;
}

/*
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
*/

- (void)setNProDetailFiveCellInfo:(DataProductBasic *)shopInfoDto WithChatStatus:(OSShowStatus)status
{

    self.backView.frame = CGRectMake(0, 0, 320, 70);
    self.backView.userInteractionEnabled = YES;
    [self.contentView addSubview:self.backView];
    
    self.shopNameLbl.frame = CGRectMake(13, 13, 260, 15);
    
    NSString *nameTemp  = [[[NSString stringWithFormat:@"%@",shopInfoDto.shopName] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] replacedWhiteSpacsByString:@""];
    
    CGSize nameSize = [nameTemp sizeWithFont:self.shopNameLbl.font constrainedToSize:CGSizeMake(self.shopNameLbl.frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeCharacterWrap];
    CGRect markFrame = self.shopNameLbl.frame;
    markFrame.size.height = nameSize.height;
    self.shopNameLbl.frame = markFrame;
    
    if(nameTemp == NULL || IsStrEmpty(nameTemp) || nameTemp == nil || nameTemp.length == 0 || [nameTemp isEqualToString:@"(null)"])
    {
        self.shopNameLbl.text = @" ";
    }
    else
    {
        self.shopNameLbl.text = [NSString stringWithFormat:@"%@",nameTemp];

    }
    self.shopLbl.text = L(@"Product_SellerSatisfaction");
//    [self setStarNumber:shopInfoDto];
    
    self.shopDetailLbl.text = [NSString stringWithFormat:@"%.1f %@",[shopInfoDto.shopGrade doubleValue] * 20,@"%"];
    self.shopView.frame = CGRectMake(28, self.shopNameLbl.bottom+16, 15, 15);//CGRectMake(20, 30, 20, 20);
    self.shopDetailLbl.frame = CGRectMake(48,  self.shopNameLbl.bottom+13, 55, 20);
    self.shopLbl.frame = CGRectMake(28, self.shopDetailLbl.bottom, 80, 20);
    
    //    self.deliverSpeedLbl.text = @"发货及时性";
    //    self.deliverSpeedDetailLbl.text = shopInfoDto.sellerSpeed; //don't doubt it, it's right
    
    self.oneLineView.frame = CGRectMake(109,  self.shopNameLbl.bottom+13, 1, 40);
    self.sellerSpeedLbl.text = L(@"Product_DeliverySatisfaction");
    self.sellerSpeedDetailLbl.text = [NSString stringWithFormat:@"%.1f %@",[shopInfoDto.deliverSpeed doubleValue] * 20,@"%"];//don't doubt it, it's right
    self.sellerSpeedView.frame = CGRectMake(133,  self.shopNameLbl.bottom+16, 15, 15);
    self.sellerSpeedDetailLbl.frame = CGRectMake(153,  self.shopNameLbl.bottom+13, 55, 20);
    self.sellerSpeedLbl.frame = CGRectMake(128, self.sellerSpeedDetailLbl.bottom, 80, 20);

    
    self.twoLineView.frame = CGRectMake(209, self.shopNameLbl.bottom+13, 1, 40);

    self.serviceSatisfyLbl.text = L(@"Product_ServiceSatisfaction");
    self.serviceSatisfyDetailLbl.text = [NSString stringWithFormat:@"%.1f %@",[shopInfoDto.serviceSatisfy doubleValue] * 20,@"%"];;//shopInfoDto.serviceSatisfy;
    self.serviceSatisfyView.frame = CGRectMake(230,  self.shopNameLbl.bottom+16, 15, 15);
    self.serviceSatisfyDetailLbl.frame = CGRectMake(247,  self.shopNameLbl.bottom+13, 55, 20);
    self.serviceSatisfyLbl.frame = CGRectMake(228, self.serviceSatisfyDetailLbl.bottom, 80, 20);//CGRectMake(220, 50, 80, 20);

    [self setRangeImageView:shopInfoDto];
    
    if([SNSwitch isOpenGoToShopExit] == YES)
    {
        if(IsStrEmpty(shopInfoDto.shopCode)  && status == OSShowStatusNone)
        {
            self.topLine.hidden = YES;
            self.backView.frame = CGRectMake(0, 0, 320, 2*20 + 13+ 6 + 25 + nameSize.height);
            
        }
        else if(status == OSShowStatusNone && !IsStrEmpty(shopInfoDto.shopCode)&& IsStrEmpty(shopInfoDto.companyName) && IsStrEmpty(shopInfoDto.shopName))
        {
            self.topLine.hidden = YES;
            self.backView.frame = CGRectMake(0, 0, 320, 2*20 + 13+ 16 + 25 + nameSize.height);
        }
        else
        {
            self.topLine.hidden = NO;
            
            self.backView.frame = CGRectMake(0, 0, 320, 2*20 + 35 + 13+ 6 + 25 + nameSize.height);
            
            self.topLine.frame = CGRectMake(10, self.serviceSatisfyLbl.bottom+10, 280, 0.5);
            
        }

    }
    else
    {//不展示店铺入口
        self.GoToShopBtn.hidden = YES;
        
        if(status == OSShowStatusNone)
        {
            self.topLine.hidden = YES;
            self.backView.frame = CGRectMake(0, 0, 320, 2*20 + 13+ 16 + 25 + nameSize.height);
            
        }
        else
        {
            self.topLine.hidden = NO;
            
            self.backView.frame = CGRectMake(0, 0, 320, 2*20 + 35 + 13+ 6 + 25 + nameSize.height);
            
            self.topLine.frame = CGRectMake(0, self.serviceSatisfyLbl.bottom+20, 320, 1);
            
        }
    }
    
    self.fengelineOne.frame = CGRectMake(0, 0, 320, 0.5);
    self.fengelineTwo.frame = CGRectMake(0, self.backView.bottom - 0.5, 320, 0.5);
    
    if (status == OSShowStatusNone)
    {
        //不展示在线客服
        self.OnlineServiceBtn.hidden = YES;
        self.threeLineView.hidden = YES;
        
        if([SNSwitch isOpenGoToShopExit] == YES)
        {
            if(IsStrEmpty(shopInfoDto.shopCode))
            {
                self.GoToShopBtn.hidden = YES;
            }
            else
            {
                if(IsStrEmpty(shopInfoDto.companyName) && IsStrEmpty(shopInfoDto.shopName))
                {
                    self.GoToShopBtn.hidden = YES;
                    
                }
                else
                {
                    self.GoToShopBtn.hidden = NO;
                    
                    self.GoToShopBtn.frame = CGRectMake(10,self.topLine.bottom+5 ,300, 30);
                }
                
            }

        }
        else
        {
           
            self.GoToShopBtn.hidden = YES;
            
        }
        
        
    }
    else
    {
        //设置是否展示和frame
        self.OnlineServiceBtn.hidden = NO;
        if([SNSwitch isOpenGoToShopExit] == YES)
        {
            if(IsStrEmpty(shopInfoDto.shopCode))    //是否有店铺
            {//不展示店铺入口
                self.GoToShopBtn.hidden = YES;
                
                self.OnlineServiceBtn.frame =CGRectMake(35,self.topLine.bottom ,300-70, 30) ;
                self.threeLineView.hidden = YES;
                
            }
            else
            {
                if(!IsStrEmpty(shopInfoDto.companyName) || !IsStrEmpty(shopInfoDto.shopName))
                {
                    self.GoToShopBtn.hidden = NO;
                    
                    self.OnlineServiceBtn.frame = CGRectMake(5,self.topLine.bottom+5 ,150, 30);
                    self.GoToShopBtn.frame = CGRectMake(self.OnlineServiceBtn.right+5,self.topLine.bottom+5 ,150, 30);
                    self.threeLineView.frame = CGRectMake(self.OnlineServiceBtn.right+5,self.topLine.bottom+10 ,1, 30);
                    self.threeLineView.hidden = NO;
                }
                else
                {//不展示店铺入口
                    self.GoToShopBtn.hidden = YES;
                    
                    self.OnlineServiceBtn.frame =CGRectMake(35,self.topLine.bottom+5 ,300-70, 30) ;
                    self.threeLineView.hidden = YES;
                }
                
            }

        }
        
        else
        {//不展示店铺入口
            self.GoToShopBtn.hidden = YES;
            self.OnlineServiceBtn.frame =CGRectMake(35,self.topLine.bottom ,300-70, 30) ;
            self.threeLineView.hidden = YES;
        }
        //设置在线客服按钮的样式
        

        if (status == OSShowStatusLeaveMessage)
        {
            [self.OnlineServiceBtn setImage:[UIImage imageNamed:kOS_lixianliuyan_image] forState:UIControlStateNormal];
            [self.OnlineServiceBtn setImage:[UIImage imageNamed:kOS_lixianliuyan_image_clicked] forState:UIControlStateHighlighted];
        }
        else
        {
            if(status == OSShowStatusOffline)
            {
                [self.OnlineServiceBtn setImage:[UIImage imageNamed:kOS_hewolianxi_disable_iamge] forState:UIControlStateNormal];

            }
            else
            {
                [self.OnlineServiceBtn setImage:[UIImage imageNamed:kOS_hewolianxi_normal_image] forState:UIControlStateNormal];
                [self.OnlineServiceBtn setImage:[UIImage imageNamed:kOS_hewolianxi_normal_image_clicked] forState:UIControlStateHighlighted];

            }
        }
        
        //设置是否可以点击
        if (status == OSShowStatusOffline)
        {
            self.OnlineServiceBtn.enabled = NO;
        }
        else
        {
            self.OnlineServiceBtn.enabled = YES;
        }
        
    }
    
    [self setNeedsLayout];
    
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self.backView addSubview:self.shopNameLbl];
    [self.backView addSubview:self.shopLbl];
    [self.backView addSubview:self.shopDetailLbl];
    [self.backView addSubview:self.sellerSpeedLbl];
    [self.backView addSubview:self.sellerSpeedDetailLbl];
    [self.backView addSubview:self.serviceSatisfyLbl];
    [self.backView addSubview:self.serviceSatisfyDetailLbl];
    [self.backView addSubview:self.shopView];
    [self.backView addSubview:self.sellerSpeedView];
    [self.backView addSubview:self.serviceSatisfyView];
    [self.backView addSubview:self.oneLineView];
    [self.backView addSubview:self.twoLineView];
    
    [self.backView addSubview:self.topLine];
    [self.backView addSubview:self.OnlineServiceBtn];
    [self.backView addSubview:self.GoToShopBtn];
    [self.backView addSubview:self.threeLineView];
    
    [self.backView addSubview:self.fengelineOne];
    [self.backView addSubview:self.fengelineTwo];
       
}


- (void)setRangeImageView:(DataProductBasic *)shopInfoDto
{
    if([shopInfoDto.shopGrade doubleValue]*20 >= 80)
    {//高
        self.shopView.image = [UIImage imageNamed:@"productDetail_high.png"];
        self.shopLbl.textColor = [UIColor colorWithRGBHex:0xff3c00];
        self.shopDetailLbl.textColor = RGBCOLOR(255, 60, 0);
    }
    else if([shopInfoDto.shopGrade doubleValue]*20 >= 60)
    {//中 
        self.shopView.image = [UIImage imageNamed:@"productDetail_mid.png"];
        self.shopLbl.textColor = [UIColor colorWithRGBHex:0xff7800];
        self.shopDetailLbl.textColor = RGBCOLOR(255, 120, 0);
    }
    else
    {//低
        self.shopView.image = [UIImage imageNamed:@"productDetail_low.png"];
        self.shopLbl.textColor = [UIColor colorWithRGBHex:0xff9c00];
        self.shopDetailLbl.textColor = RGBCOLOR(255, 156, 0);
    }
    
    if([shopInfoDto.deliverSpeed doubleValue]*20 >= 80)
    {//高
        self.sellerSpeedView.image = [UIImage imageNamed:@"productDetail_high.png"];
        self.sellerSpeedLbl.textColor = [UIColor colorWithRGBHex:0xff3c00];
        self.sellerSpeedDetailLbl.textColor = RGBCOLOR(255, 60, 0);
    }
    else if([shopInfoDto.shopGrade doubleValue]*20 >= 60)
    {//中
        self.sellerSpeedView.image = [UIImage imageNamed:@"productDetail_mid.png"];
        self.sellerSpeedLbl.textColor = [UIColor colorWithRGBHex:0xff7800];
        self.sellerSpeedDetailLbl.textColor = RGBCOLOR(255, 120, 0);
    }
    else
    {//低
        self.sellerSpeedView.image = [UIImage imageNamed:@"productDetail_low.png"];
        self.sellerSpeedLbl.textColor = [UIColor colorWithRGBHex:0xff9c00];
        self.sellerSpeedDetailLbl.textColor = RGBCOLOR(255, 156, 0);
    }
    
    if([shopInfoDto.serviceSatisfy doubleValue]*20 >= 80)
    {//高
        self.serviceSatisfyView.image = [UIImage imageNamed:@"productDetail_high.png"];
        self.serviceSatisfyLbl.textColor = [UIColor colorWithRGBHex:0xff3c00];
        self.serviceSatisfyDetailLbl.textColor = RGBCOLOR(255, 60, 0);
    }
    else if([shopInfoDto.shopGrade doubleValue]*20 >= 60)
    {//中
        self.serviceSatisfyView.image = [UIImage imageNamed:@"productDetail_mid.png"];
        self.serviceSatisfyLbl.textColor = [UIColor colorWithRGBHex:0xff7800];
        self.serviceSatisfyDetailLbl.textColor = RGBCOLOR(255, 120, 0);
    }
    else
    {//低
        self.serviceSatisfyView.image = [UIImage imageNamed:@"productDetail_low.png"];
        self.serviceSatisfyLbl.textColor = [UIColor colorWithRGBHex:0xff9c00];
        self.serviceSatisfyDetailLbl.textColor = RGBCOLOR(255, 156, 0);
    }
}

- (CGFloat)setShopNameHeight:(DataProductBasic*)shopInfoDto
{
    NSString *nameTemp  = [[[NSString stringWithFormat:@"%@",shopInfoDto.shopName] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] replacedWhiteSpacsByString:@""];
    
    CGSize nameSize = [nameTemp sizeWithFont:[UIFont boldSystemFontOfSize:12] constrainedToSize:CGSizeMake(260, MAXFLOAT) lineBreakMode:UILineBreakModeCharacterWrap];
    CGRect markFrame = self.shopNameLbl.frame;
    markFrame.size.height = nameSize.height;
    self.shopNameLbl.frame = markFrame;
    
    return nameSize.height;

}

+ (CGFloat)NProDetailFiveCellheight:(DataProductBasic *)shopInfoDto WithChatStatus:(OSShowStatus)status
{

    if([SNSwitch isOpenGoToShopExit] == YES)
    {
        if(IsStrEmpty(shopInfoDto.shopCode) && status == OSShowStatusNone)
        {
            
            return 110+[[NProDetailFiveCell alloc] setShopNameHeight:shopInfoDto];//60 + 10 + 25+ 15+5;
        }
        else if(status == OSShowStatusNone && !IsStrEmpty(shopInfoDto.shopCode)&& IsStrEmpty(shopInfoDto.companyName) && IsStrEmpty(shopInfoDto.shopName))
        {
            return 110+[[NProDetailFiveCell alloc] setShopNameHeight:shopInfoDto];
        }
        else
        {
            return 150+[[NProDetailFiveCell alloc] setShopNameHeight:shopInfoDto];//4*20+35 + 25+ 15+10;
        }
    }
    else
    {
        if(status == OSShowStatusNone)
        {
            
            return 110+[[NProDetailFiveCell alloc] setShopNameHeight:shopInfoDto];//60 + 10 + 25+ 15+5;
        }
        else
        {
            return 150+[[NProDetailFiveCell alloc] setShopNameHeight:shopInfoDto];//4*20+35 + 25+ 15+10;
        }
    }
    
    
}

@end
