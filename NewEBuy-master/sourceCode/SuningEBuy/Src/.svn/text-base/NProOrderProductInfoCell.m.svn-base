//
//  NProOrderProductInfoCell.m
//  SuningEBuy
//
//  Created by xmy on 26/1/14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "NProOrderProductInfoCell.h"
#import "ProductUtil.h"
#import "orderHttpDataSource.h"
@implementation NProOrderProductInfoCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
#pragma mark
#pragma ProductOrderList
-(void)setNProOrderProductInfoCell:(ProductListDTO *)productDto
                          orderDto:(NewOrderListDTO *)orderDto
                          cellType:(CellViewType)cellType
                           withRow:(int)row
{
    
    if (IsNilOrNull(productDto) || IsNilOrNull(orderDto))
    {
        return;
    }
    
    self.row = row;
    self.snxpressQueryBtn.hidden = YES;
    
    //商品行各个控件Frame
    [self setUIFrame:productDto orderDto:orderDto];
    
    //商品图片加载
    [self loadProductPicture:productDto orderDto:orderDto];
    
    //判断是否显示物流按钮
    [self setAButtonsPosiotion:orderDto WithProduct:productDto];
    
    //设置商家名
    [self isShowBusinessName:productDto orderDto:orderDto];
    
    //物流 评价 晒单 评价晒单 四个按钮显示关系
    [self setFourButton:productDto orderDto:orderDto];
    
}
#pragma mark -
#pragma 商品订单列表中运用到的方法

//加载商品图片
- (void)loadProductPicture:(ProductListDTO *)productDto orderDto:(NewOrderListDTO *)orderDto
{
    //商品图片
    if ([[AppDelegate currentAppDelegate] isHeightQuailtyImg])
    {
        
        self.iconImageView.imageURL = [ProductUtil getImageUrlWithProductCode:productDto.productCode size:ProductImageSize160x160];
    }
    else
    {
        
        self.iconImageView.imageURL = [ProductUtil getImageUrlWithProductCode:productDto.productCode size:ProductImageSize120x120];
    }
}

//设置商品行各个控件frame
- (void)setUIFrame:(ProductListDTO *)productDto orderDto:(NewOrderListDTO *)orderDto
{
    //商品图片
    self.iconImageView.frame = CGRectMake(15, 12, 85, 85);
    
    //商品名
    self.productNameLbl.frame = CGRectMake(self.iconImageView.right+10, 15, 120, 40);
    self.productNameLbl.text = productDto.productName;
    
    //单价
    self.singlePrice.frame = CGRectMake(self.iconImageView.right + 10, self.productNameLbl.bottom, 37, 20);
    self.singlePrice.text = [NSString stringWithFormat:@"%@: ",L(@"MyEBuy_UnitPrice")];
    
    //价格
    self.priceLbl.frame = CGRectMake(self.singlePrice.right, self.productNameLbl.bottom, 100, 20);
    self.priceLbl.text = [NSString stringWithFormat:@"￥%.2f",[productDto.itemPrice doubleValue]];
    
    //剩余数量
    self.productNumLbl.frame = CGRectMake(self.iconImageView.right + 10, self.priceLbl.bottom, 85, 20);
    self.productNumLbl.text = [NSString stringWithFormat:@"%@: %i",L(@"Constant_Amount"),[productDto.quantity intValue]];
    
    //物流按钮
    self.snxpressQueryBtn.frame = CGRectMake(KSecondBigBtnsX + 24, 40, KNewSmallBtnsWidth + 10, KNewBtnsHeight);
    
    //评价
    self.pingjiaBtn.frame = CGRectMake(KSecondBigBtnsX + 24, 40, KNewSmallBtnsWidth + 10, KNewBtnsHeight);
    
    //晒单
    self.shaidanBtn.frame = CGRectMake(KSecondBigBtnsX + 24, 40, KNewSmallBtnsWidth + 10, KNewBtnsHeight);
    
    //评价晒单
    self.bothBtn.frame = CGRectMake(KSecondBigBtnsX + 24, 40, KNewSmallBtnsWidth + 10, KNewBtnsHeight);
    
    //c店：以商家个数为单位显示确认收货按钮
    self.confirmAcceptBtn.frame = CGRectMake(KSecondBigBtnsX + 34, 2, KNewSmallBtnsWidth, 30);
    
    //商铺名
    self.supplierLbl.frame = CGRectMake(15, 0, 220, 35);
    
    //商品行之间分割线
    self.lineView2.frame = CGRectMake(15, 0, 305, 0.5);
    
    //商家名上下的分割线
    //上
    self.lineView.frame = CGRectMake(0, 0, 320, 0.5);
    //下
    self.lineView1.frame = CGRectMake(0, 34.5, 320, 0.5);
    
    //订单状态
    self.orderStatusLbl.frame = CGRectMake(self.supplierLbl.right,0, 70, 35);
    self.orderStatusLbl.text = [orderHttpDataSource getOrderTypeInfo:orderDto.ormOrder WithOrderStatus:productDto.supplierOrderStatus];
    
    //如果商品行需要展示商家名称y坐标向下移动40
    self.iconImageView.frame = [self setControlsFrame:self.iconImageView.frame productListDto:productDto];
    self.productNameLbl.frame = [self setControlsFrame:self.productNameLbl.frame productListDto:productDto];
    self.priceLbl.frame = [self setControlsFrame:self.priceLbl.frame productListDto:productDto];
    self.productNumLbl.frame = [self setControlsFrame:self.productNumLbl.frame productListDto:productDto];
    self.snxpressQueryBtn.frame = [self setControlsFrame:self.snxpressQueryBtn.frame productListDto:productDto];
    self.lineView2.frame = [self setControlsFrame:self.lineView2.frame productListDto:productDto];
    self.singlePrice.frame = [self setControlsFrame:self.singlePrice.frame productListDto:productDto];
    self.pingjiaBtn.frame = [self setControlsFrame:self.pingjiaBtn.frame productListDto:productDto];
    self.shaidanBtn.frame = [self setControlsFrame:self.shaidanBtn.frame productListDto:productDto];
    self.bothBtn.frame = [self setControlsFrame:self.bothBtn.frame productListDto:productDto];

}

//是否展示商家名和订单状态
- (void)isShowBusinessName:(ProductListDTO *)productDto orderDto:(NewOrderListDTO *)orderDto
{
    if (productDto.isShowShopName == YES)
    {
        //显示商家名
        self.supplierLbl.hidden = NO;
        self.lineView.hidden = NO;
        self.lineView1.hidden = NO;
        self.orderStatusLbl.hidden = NO;
        //隐藏商品行分割线
        self.lineView2.hidden = YES;
        
        if (IsStrEmpty(productDto.supplierCode))
        {
            self.supplierLbl.text = L(@"MyEBuy_SuningSelf");
        }
        else
        {
            self.supplierLbl.text = productDto.supplierName;
        }
        
        //不再显示订单状态
//        self.orderStatusLbl.hidden = YES;
        //有支付按钮时 不显示订单状态
        if (orderDto.canTwiceBuy && ([orderDto.oiStatus eq:@"M"] || [orderDto.oiStatus eq:@"M1"])) {
            if ([orderDto.ormOrder eq:@"11701"]) {
                self.orderStatusLbl.hidden = NO;
            }
            else
            {
                self.orderStatusLbl.hidden = YES;
            }
        }
        else
        {
            self.orderStatusLbl.hidden = NO;
        }
        if([orderDto.oiStatus isEqualToString:@"M2"] || [orderDto.oiStatus isEqualToString:@"M3"])
        {
            self.orderStatusLbl.hidden = NO;
        }

        //商铺上下分割线
        self.lineView.hidden = NO;
        self.lineView1.hidden = NO;

    }
    else
    {
        self.supplierLbl.hidden = YES;
        self.orderStatusLbl.hidden = YES;
        self.lineView.hidden = YES;
        self.lineView1.hidden = YES;
        
        self.lineView2.hidden = NO;
    }

}

//物流 评价 晒单 评价晒单 四个按钮显示关系
- (void)setFourButton:(ProductListDTO *)productDto orderDto:(NewOrderListDTO *)orderDto
{
    //0显示 1不显示
    if ([productDto.isCanComment eq:@"0"] && [productDto.isCanShow eq:@"0"]) {
        self.bothBtn.hidden = NO;
        self.pingjiaBtn.hidden = YES;
        self.shaidanBtn.hidden = YES;
        self.snxpressQueryBtn.hidden = YES;
    }
    else if ([productDto.isCanComment eq:@"0"] && [productDto.isCanShow eq:@"1"])
    {
        self.pingjiaBtn.hidden = NO;
        self.shaidanBtn.hidden = YES;
        self.bothBtn.hidden = YES;
        self.snxpressQueryBtn.hidden = YES;
    }
    else if ([productDto.isCanComment eq:@"1"] && [productDto.isCanShow eq:@"0"])
    {
        self.shaidanBtn.hidden = NO;
        self.pingjiaBtn.hidden = YES;
        self.bothBtn.hidden = YES;
        self.snxpressQueryBtn.hidden = YES;
    }
    else
    {
        self.shaidanBtn.hidden = YES;
        self.pingjiaBtn.hidden = YES;
        self.bothBtn.hidden = YES;
        //*******物流按钮已经隐藏不显示**********
        if (!self.snxpressQueryBtn.hidden == YES)
        {
            self.snxpressQueryBtn.hidden = NO;

        }
        //************End******************
    }
    
}

//A:全部订单
- (void)setAButtonsPosiotion:(NewOrderListDTO *)dto
                 WithProduct:(ProductListDTO *)productDto
{
    
    if([dto.oiStatus hasPrefix:@"M"] &&
       ![dto.ormOrder isEqualToString:@"11601"] &&
       ![dto.ormOrder isEqualToString:@"11701"] &&
       IsStrEmpty(dto.supplierCode))
    {//等待支付订单 中 非货到付款和非门店付款订单
        self.snxpressQueryBtn.hidden = YES;
    }
    else
    {
        
        BOOL isFinishAccept = [dto isFinishAcceptOK:productDto.finishAccept];
        BOOL isDelivery = [dto isDelivityOK:productDto.omsStatus];
        
        
        
        if([dto.oiStatus hasPrefix:@"M"])
        {//等待支付订单
            
            if([dto.ormOrder isEqualToString:@"11601"])
            {//货到付款订单
                [self setM1OrM2ButtonsPosiotion:dto];
            }
            else
            {
                [self setMButtonsPosiotion:dto];
                
            }
        }
        else if(([dto.oiStatus eq:@"X"] ||
                 [dto.oiStatus eq:@"x"] ||
                 [dto.oiStatus eq:@"H"]))
        {//已取消订单
            [self setXButtonsPosiotion:dto];
            
        }
        else if(([dto.oiStatus eq:@"R"] ||
                 [dto.oiStatus eq:@"r"] ||
                 [dto.oiStatus eq:@"G"]))
        {//以退货订单
            [self setRButtonsPosiotion:dto];
            
        }
        else
        {
            if(isDelivery == YES)
            {
                [self setCButtonsPosiotion:dto];
            }
            else if(isFinishAccept == YES)
            {
                [self setCButtonsPosiotion:dto];
                
            }
            else if(([dto.oiStatus eq:@"C"] ||
                     [dto.oiStatus eq:@"c"] ||
                     [dto.oiStatus eq:@"D"] ||
                     [dto.oiStatus eq:@"E"] ||
                     [dto.oiStatus eq:@"SOMED"] ||
                     [dto.oiStatus eq:@"SD"] ||
                     [dto.oiStatus eq:@"SC"] ||
                     [dto.oiStatus eq:@"WD"] ||
                     [dto.oiStatus eq:@"F"]) &&
                    (isFinishAccept == NO && isDelivery == NO) )
            {//支付完成订单，已发货订单，收货完成订单
                [self setCButtonsPosiotion:dto];
            }
        }
        
    }
    
}


//C:已支付的订单
- (void)setCButtonsPosiotion:(NewOrderListDTO *)dto
{
    self.snxpressQueryBtn.hidden = NO;
}

//M:待支付的订单
- (void)setMButtonsPosiotion:(NewOrderListDTO *)dto{
    
    if(![dto.ormOrder isEqualToString:@"11601"] &&
       ![dto.ormOrder isEqualToString:@"11701"])
    {
        self.snxpressQueryBtn.hidden = YES;
    }
    else
    {
        self.snxpressQueryBtn.hidden = YES;
    }
    if([dto.oiStatus hasPrefix:@"M"] && [dto.ormOrder isEqualToString:@"11601"])
    {
        self.snxpressQueryBtn.hidden = NO;
    }
    
}

//M M1:发货处理中订单
- (void)setM1OrM2ButtonsPosiotion:(NewOrderListDTO *)dto
{
    self.snxpressQueryBtn.hidden = YES;
    if([dto.oiStatus hasPrefix:@"M"] && ([dto.ormOrder isEqualToString:@"11601"]))
    {
        self.snxpressQueryBtn.hidden = NO;
    }
}


//X:已取消的订单
- (void)setXButtonsPosiotion:(NewOrderListDTO *)dto
{
    self.snxpressQueryBtn.hidden = YES;
}

//R:退货成功的订单
- (void)setRButtonsPosiotion:(NewOrderListDTO *)dto
{
    self.snxpressQueryBtn.hidden = YES;
}

#pragma mark -
#pragma mark UIView
- (UIButton*)confirmAcceptBtn
{
    if(!_confirmAcceptBtn)
    {
        _confirmAcceptBtn = [[UIButton alloc] init];
        
        [_confirmAcceptBtn setTitle:L(@"MyEBuy_ConfirmReceipt") forState:UIControlStateNormal];
        
        [_confirmAcceptBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        _confirmAcceptBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        
        UIImage *buttonImageNormal = [UIImage streImageNamed:@"submit_button_normal.png"];
        
        UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:0 topCapHeight:0];
        
        [_confirmAcceptBtn setBackgroundImage:stretchableButtonImageNormal
                                     forState:UIControlStateNormal];
        [_confirmAcceptBtn setBackgroundImage:[UIImage imageNamed:@"submit_button_touched.png"]
                                     forState:UIControlStateHighlighted];
        
        [self.contentView addSubview:_confirmAcceptBtn];
    }
    
    return _confirmAcceptBtn;
}

-(UIImageView *)backView{
    
    if (!_backView) {
        
        _backView = [[UIImageView alloc]init];
        _backView.backgroundColor = [UIColor clearColor];
        _backView.image = [UIImage streImageNamed:@"yellow_mid@2x.png"];
    }
    return _backView;
}

-(EGOImageButton *)iconImageView{
    
    if (!_iconImageView) {
        _iconImageView = [[EGOImageButton alloc]init];
        _iconImageView.backgroundColor = [UIColor clearColor];
        _iconImageView.layer.borderColor = RGBCOLOR(220, 220, 220).CGColor;
        _iconImageView.layer.borderWidth = .5;
        [self.contentView addSubview:_iconImageView];
    }
    return _iconImageView;
}

-(EGOImageView *)priceImageV{
    
    if (!_priceImageV) {
        _priceImageV = [[EGOImageView alloc]init];
        
        _priceImageV.backgroundColor = [UIColor clearColor];
        _priceImageV.contentMode = UIViewContentModeLeft;
        _priceImageV.placeholderImage = nil;
        _priceImageV.refreshCached = YES;
        
        [self.contentView addSubview:_priceImageV];
    }
    return _priceImageV;
}

- (void)setLblProtery:(UILabel*)lbl
{
    lbl.textColor = [UIColor colorWithRGBHex:0x313131];
    
    lbl.backgroundColor = [UIColor clearColor];
    
    lbl.font = [UIFont systemFontOfSize:13];
    
    lbl.textAlignment = UITextAlignmentLeft;
    
}


- (void)setContextLblProtery:(UILabel*)lbl
{
    lbl.textColor = [UIColor dark_Gray_Color];
    
    lbl.backgroundColor = [UIColor clearColor];
    
    lbl.font = [UIFont systemFontOfSize:13];
    
    lbl.textAlignment = UITextAlignmentRight;
    
    lbl.lineBreakMode = UILineBreakModeCharacterWrap;
    
    lbl.numberOfLines = 0;
    
}

-(UILabel *)productNameLbl{
    
    if (!_productNameLbl) {
        _productNameLbl = [[UILabel alloc]init];
        _productNameLbl.backgroundColor = [UIColor clearColor];
        _productNameLbl.font = [UIFont systemFontOfSize:13];
        _productNameLbl.textColor = [UIColor colorWithRGBHex:0x313131];
        _productNameLbl.textAlignment = UITextAlignmentLeft;
        _productNameLbl.numberOfLines = 2;
        _productNameLbl.lineBreakMode = UILineBreakModeTailTruncation;
        [self.contentView addSubview:_productNameLbl];
    }
    return _productNameLbl;
}

-(UILabel *)supplierLbl{
    
    if (!_supplierLbl) {
        _supplierLbl = [[UILabel alloc]init];
        _supplierLbl.backgroundColor = [UIColor clearColor];
        _supplierLbl.font = [UIFont systemFontOfSize:14.0f];
        _supplierLbl.textColor = [UIColor colorWithRGBHex:0x313131];
        [self.contentView addSubview:_supplierLbl];
    }
    return _supplierLbl;
}

-(UILabel *)priceLbl{
    
    if (!_priceLbl) {
        _priceLbl = [[UILabel alloc]init];
        _priceLbl.backgroundColor = [UIColor clearColor];
        _priceLbl.font = [UIFont systemFontOfSize:14];
        _priceLbl.textColor = [UIColor orange_Red_Color];
        [self.contentView addSubview:_priceLbl];
    }
    return _priceLbl;
}

- (UILabel *)singlePrice
{
    if (!_singlePrice) {
        _singlePrice = [[UILabel alloc] init];
        _singlePrice.backgroundColor = [UIColor clearColor];
        _singlePrice.font = [UIFont systemFontOfSize:14];
        _singlePrice.textColor = [UIColor dark_Gray_Color];
        [self.contentView addSubview:_singlePrice];

    }
    return _singlePrice;
}

-(UILabel *)productNumLbl{
    
    if (!_productNumLbl) {
        _productNumLbl = [[UILabel alloc]init];
        _productNumLbl.backgroundColor = [UIColor clearColor];
        _productNumLbl.font = [UIFont systemFontOfSize:14];
        _productNumLbl.textColor = [UIColor dark_Gray_Color];
        _productNumLbl.textAlignment = UITextAlignmentLeft;
        [self.contentView addSubview:_productNumLbl];
    }
    return _productNumLbl;
}

-(UILabel *)remindLabel{
    
    if (!_remindLabel) {
        _remindLabel = [[UILabel alloc]init];
        _remindLabel.backgroundColor = [UIColor clearColor];
        _remindLabel.font = [UIFont systemFontOfSize:14];
        _remindLabel.textColor = [UIColor dark_Gray_Color];
        _remindLabel.textAlignment = UITextAlignmentLeft;
        _remindLabel.numberOfLines = 0;
        _remindLabel.lineBreakMode = UILineBreakModeWordWrap;
        [self.contentView addSubview:_remindLabel];
    }
    return _remindLabel;
}

- (UIButton*)snxpressQueryBtn
{
    if(!_snxpressQueryBtn)
    {
        _snxpressQueryBtn = [[UIButton alloc] init];
        
        [_snxpressQueryBtn setTitle:L(@"MyEBuy_CheckExpress") forState:UIControlStateNormal];
        
        [_snxpressQueryBtn setTitleColor:[UIColor orange_Light_Color] forState:UIControlStateNormal];
        
        _snxpressQueryBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        
        UIImage *buttonImageNormal = [UIImage streImageNamed:@"order_WuLiu.png"];
        
        UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:0 topCapHeight:0];
        
        [_snxpressQueryBtn setBackgroundImage:stretchableButtonImageNormal
                                     forState:UIControlStateNormal];
        [_snxpressQueryBtn setBackgroundImage:[UIImage imageNamed:@"order_WuLiuClicked.png"]
                                     forState:UIControlStateHighlighted];
        _snxpressQueryBtn.hidden = YES;
        [self.contentView addSubview:_snxpressQueryBtn];
    }
    
    return _snxpressQueryBtn;
}

- (UIButton*)pingjiaBtn
{
    if(!_pingjiaBtn)
    {
        _pingjiaBtn = [[UIButton alloc] init];
        
        [_pingjiaBtn setTitle:L(@"MyEBuy_Evaluate") forState:UIControlStateNormal];
        
        [_pingjiaBtn setTitleColor:[UIColor orange_Light_Color] forState:UIControlStateNormal];
        
        _pingjiaBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        
        UIImage *buttonImageNormal = [UIImage streImageNamed:@"order_WuLiu.png"];
        
        UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:0 topCapHeight:0];
        
        [_pingjiaBtn setBackgroundImage:stretchableButtonImageNormal
                                     forState:UIControlStateNormal];
        [_pingjiaBtn setBackgroundImage:[UIImage imageNamed:@"order_WuLiuClicked.png"]
                                     forState:UIControlStateHighlighted];
        _pingjiaBtn.hidden = YES;
        [self.contentView addSubview:_pingjiaBtn];
    }
    
    return _pingjiaBtn;
}

- (UIButton*)shaidanBtn
{
    if(!_shaidanBtn)
    {
        _shaidanBtn = [[UIButton alloc] init];
        
        [_shaidanBtn setTitle:L(@"MyEBuy_DisplayOrder") forState:UIControlStateNormal];
        
        [_shaidanBtn setTitleColor:[UIColor orange_Light_Color] forState:UIControlStateNormal];
        
        _shaidanBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        
        UIImage *buttonImageNormal = [UIImage streImageNamed:@"order_WuLiu.png"];
        
        UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:0 topCapHeight:0];
        
        [_shaidanBtn setBackgroundImage:stretchableButtonImageNormal
                                     forState:UIControlStateNormal];
        [_shaidanBtn setBackgroundImage:[UIImage imageNamed:@"order_WuLiuClicked.png"]
                                     forState:UIControlStateHighlighted];
        _shaidanBtn.hidden = YES;
        [self.contentView addSubview:_shaidanBtn];
    }
    
    return _shaidanBtn;
}

- (UIButton*)bothBtn
{
    if(!_bothBtn)
    {
        _bothBtn = [[UIButton alloc] init];
        
        [_bothBtn setTitle:L(@"MyEBuy_EvaluateOrDisplayOrder") forState:UIControlStateNormal];
        
        [_bothBtn setTitleColor:[UIColor orange_Light_Color] forState:UIControlStateNormal];
        
        _bothBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        
        UIImage *buttonImageNormal = [UIImage streImageNamed:@"order_WuLiu.png"];
        
        UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:0 topCapHeight:0];
        
        [_bothBtn setBackgroundImage:stretchableButtonImageNormal
                                     forState:UIControlStateNormal];
        [_bothBtn setBackgroundImage:[UIImage imageNamed:@"order_WuLiuClicked.png"]
                                     forState:UIControlStateHighlighted];
        _bothBtn.hidden = YES;
        [self.contentView addSubview:_bothBtn];
    }
    
    return _bothBtn;
}



-(UIImageView *)lineView{
    
    if (!_lineView) {
        
        _lineView = [[UIImageView alloc]init];
        
        _lineView.backgroundColor = [UIColor clearColor];
        
        _lineView.frame = CGRectMake(0, 39.5, 320, 0.5);
        
//        [_lineView setImage:[UIImage streImageNamed:@"orde_line.png"]];
        
        [_lineView setImage:[UIImage streImageNamed:@"line.png"]];

        [self.contentView addSubview:_lineView];
        
    }
    
    return _lineView;
}

-(UIImageView *)lineView1{
    
    if (!_lineView1) {
        
        _lineView1 = [[UIImageView alloc]init];
        
        _lineView1.backgroundColor = [UIColor clearColor];
        
        _lineView1.image = [UIImage streImageNamed:@"line.png"];
        
        [self.contentView addSubview:_lineView1];
    }
    return _lineView1;
}

-(UIImageView *)lineView2{
    
    if (!_lineView2) {
        
        _lineView2 = [[UIImageView alloc]init];
        
        _lineView2.backgroundColor = [UIColor clearColor];
        
        _lineView2.image = [UIImage streImageNamed:@"line.png"];
        
        [self.contentView addSubview:_lineView2];
    }
    return _lineView2;
}


#pragma mark -
#pragma 门店订单列表

-(void)refreshCell:(ShopOrderItemListDto *)productDto
          orderDto:(ShopOrderListDto *)orderDto
          cellType:(CellViewType)cellType
{
    
    if (IsNilOrNull(productDto) || IsNilOrNull(orderDto))
    {
        return;
    }
    self.iconImageView.frame = CGRectMake(15, 12, 85, 85);
    
    if ([[AppDelegate currentAppDelegate] isHeightQuailtyImg]) {
        
        self.iconImageView.imageURL = [ProductUtil getImageUrlWithProductCode:productDto.commodityCode size:ProductImageSize160x160];
    }
    else{
        
        self.iconImageView.imageURL = [ProductUtil getImageUrlWithProductCode:productDto.commodityCode size:ProductImageSize120x120];
    }
    
    
    int nameLines = [self setProNameHeight:productDto.commodityName WithLbl:self.productNameLbl];
    
    if(nameLines == 1)
    {
        self.productNameLbl.frame = CGRectMake(self.iconImageView.right+10, 16, (kScreenWidth-15-55-10-15), 15);
        self.priceLbl.frame = CGRectMake(self.iconImageView.right+10, 55, 100, 20);
        self.priceLbl.text = [NSString stringWithFormat:@"￥%.2f",[productDto.unitPrice doubleValue]];
        
        self.productNumLbl.frame = CGRectMake(_priceLbl.right+10, 55, 85, 20);
        self.productNumLbl.text = [NSString stringWithFormat:@"%@：%i",L(@"Constant_Amount"),[productDto.saleCount intValue]];
        
        
    }
    else
    {
        self.productNameLbl.frame = CGRectMake(self.iconImageView.right+10, 10, (kScreenWidth-15-55-10-15), 40);
        self.priceLbl.frame = CGRectMake(self.iconImageView.right+10, 55, 100, 20);
        self.priceLbl.text = [NSString stringWithFormat:@"￥%.2f",[productDto.unitPrice doubleValue]];
        
        self.productNumLbl.frame = CGRectMake(_priceLbl.right+10, 55, 85, 20);
        self.productNumLbl.text = [NSString stringWithFormat:@"%@：%i",L(@"Constant_Amount"),[productDto.saleCount intValue]];
        
        
    }
    
    self.productNameLbl.text = productDto.commodityName;
    
    
    self.supplierLbl.frame = CGRectMake(self.iconImageView.right+10, _productNumLbl.bottom, 180, 20);
   
    self.supplierLbl.text = L(@"MyEBuy_SuningSelf");
    
    
    self.lineView.hidden = YES;
    self.lineView1.hidden = NO;
    self.lineView1.frame = CGRectMake(0, 162.5, 320, 0.5);
    
    
    [self setShopOrderAButtonsPosiotion:orderDto WithProduct:productDto];
    //门店订单区别于普通订单，这里将单独进行设置
    self.snxpressQueryBtn.frame = CGRectMake(KSecondBigBtnsX, self.iconImageView.bottom + 20, KNewBtnsWidth, KNewBtnsHeight);
    
}



//ALL:全部订单
- (void)setShopOrderAButtonsPosiotion:(ShopOrderListDto *)dto
                 WithProduct:(ShopOrderItemListDto *)productDto
{
    
//    self.snxpressQueryBtn.frame = CGRectMake(KSecondBigBtnsX, self.iconImageView.bottom+15, KNewBtnsWidth, KNewBtnsHeight);
//    self.snxpressQueryBtn.frame = CGRectMake(KSecondBigBtnsX + 34, 40, KNewSmallBtnsWidth, KNewBtnsHeight);
    
    self.snxpressQueryBtn.hidden = NO;
    
}
#pragma mark -
#pragma 退货申请
-(void)setReturnGoodsCellInfo:(ReturnGoodsPrepareDTO *)prepareDto
{
    if (IsNilOrNull(prepareDto))
    {
        return;
    }
    self.iconImageView.frame = CGRectMake(15, 12, 85, 85);
    
    if ([[AppDelegate currentAppDelegate] isHeightQuailtyImg]) {
        
        self.iconImageView.imageURL = [ProductUtil getImageUrlWithProductCode:prepareDto.productCode size:ProductImageSize160x160];
    }
    else{
        
        self.iconImageView.imageURL = [ProductUtil getImageUrlWithProductCode:prepareDto.productCode size:ProductImageSize120x120];
    }
    
//    self.iconImageView.imageURL = [ProductUtil imageUrl_ls_ForProduct:prepareDto.productCode];
    
//    double yfbAmount = [prepareDto.returnYfbAmount doubleValue];
//    
//    double yhkAmount = [prepareDto.returnYhkAmount doubleValue];
//    
//    double totalAmount = yfbAmount+yhkAmount;
//    
//    if (![prepareDto.zstatus1 isEqualToString:@"C"] && totalAmount == 0.00f) {
//        
//        self.priceLbl.text = @"";
//    }else{
//        
//        self.priceLbl.text = [NSString stringWithFormat:@"￥%0.2f元",totalAmount];
//    }
    
    self.priceLbl.frame = CGRectMake(self.iconImageView.right+10, 55, 100, 20);
    if(IsStrEmpty(prepareDto.price))
    {
        self.priceLbl.text = @"";
    }
    else
    {
        self.priceLbl.text = [NSString stringWithFormat:@"￥%.2f",[prepareDto.price doubleValue]];

    }
    
    
    int nameLines = [self setProNameHeight:prepareDto.productName WithLbl:self.productNameLbl];
    
    if(nameLines == 1)
    {
        self.productNameLbl.frame = CGRectMake(self.iconImageView.right+10, 16, (kScreenWidth-15-55-10-15), 15);
        self.priceLbl.frame = CGRectMake(self.iconImageView.right+10, 55, 100, 20);
        if (self.isNumber)
        {
            self.productNumLbl.hidden = YES;
        }
        self.productNumLbl.frame = CGRectMake(_priceLbl.right+10, 55, 85, 20);
        self.productNumLbl.text = [NSString stringWithFormat:@"%@：%i",L(@"Constant_Amount"),[prepareDto.quantityValue intValue]];        
    }
    else
    {
        self.productNameLbl.frame = CGRectMake(self.iconImageView.right+10, 10, (kScreenWidth-15-55-10-15), 40);
        
        self.priceLbl.frame = CGRectMake(self.iconImageView.right+10, 55, 100, 20);

        if (self.isNumber)
        {
            self.productNumLbl.hidden = YES;
        }
        self.productNumLbl.frame = CGRectMake(_priceLbl.right+10, 55, 85, 20);
        self.productNumLbl.text = [NSString stringWithFormat:@"%@：%i",L(@"Constant_Amount"),[prepareDto.quantityValue intValue]];
        
    }
    
    self.productNameLbl.text = prepareDto.productName;
    
    
    self.supplierLbl.frame = CGRectMake(self.iconImageView.right+10, _productNumLbl.bottom, 180, 20);
    
    self.supplierLbl.text = [NSString stringWithFormat:@"%@",prepareDto.channel?prepareDto.channel:@""];
    
    
    self.lineView.hidden = NO;
    self.lineView1.hidden = YES;
    self.lineView.frame = CGRectMake(0, 109.5, 320, 0.5);
    
}

#pragma mark -
#pragma 无理由退货
-(void)setNOReasonReturnGoodsCellInfo:(ReturnGoodsPrepareDTO *)prepareDto
{
    if (IsNilOrNull(prepareDto))
    {
        return;
    }
    self.iconImageView.frame = CGRectMake(15, 12, 85, 85);
    
    if ([[AppDelegate currentAppDelegate] isHeightQuailtyImg]) {
        
        self.iconImageView.imageURL = [ProductUtil getImageUrlWithProductCode:prepareDto.productCode size:ProductImageSize160x160];
    }
    else{
        
        self.iconImageView.imageURL = [ProductUtil getImageUrlWithProductCode:prepareDto.productCode size:ProductImageSize120x120];
    }
    
    self.priceLbl.frame = CGRectMake(self.iconImageView.right+10, 55, 100, 20);
    if(IsStrEmpty(prepareDto.price))
    {
        self.priceLbl.text = @"";
    }
    else
    {
        self.priceLbl.text = [NSString stringWithFormat:@"￥%.2f",[prepareDto.price doubleValue]];
        
    }
    
    
    int nameLines = [self setProNameHeight:prepareDto.productName WithLbl:self.productNameLbl];
    
    if(nameLines == 1)
    {
        self.productNameLbl.frame = CGRectMake(self.iconImageView.right+10, 16, (kScreenWidth-15-55-10-15), 15);
        self.priceLbl.frame = CGRectMake(self.iconImageView.right+10, 55, 100, 20);
        
        self.productNumLbl.frame = CGRectMake(_priceLbl.right+10, 55, 85, 20);
        self.productNumLbl.text = [NSString stringWithFormat:@"%@：%i",L(@"Constant_Amount"),[prepareDto.quantityValue intValue]];
        
        
    }
    else
    {
        self.productNameLbl.frame = CGRectMake(self.iconImageView.right+10, 10, (kScreenWidth-15-55-10-15), 40);
        
        self.priceLbl.frame = CGRectMake(self.iconImageView.right+10, 55, 100, 20);
        
        
        self.productNumLbl.frame = CGRectMake(_priceLbl.right+10, 55, 85, 20);
        self.productNumLbl.text = [NSString stringWithFormat:@"%@：%i",L(@"Constant_Amount"),[prepareDto.quantityValue intValue]];
        
        
    }
    
    self.productNameLbl.text = prepareDto.productName;
    
    
    self.supplierLbl.frame = CGRectMake(self.iconImageView.right+10, _productNumLbl.bottom, 180, 20);
    
    self.supplierLbl.text = [NSString stringWithFormat:@"%@",prepareDto.channel?prepareDto.channel:@""];
    
    
    self.lineView.hidden = NO;
    self.lineView1.hidden = YES;
    self.lineView.frame = CGRectMake(0, 109.5, 320, 0.5);
    self.lineView2.frame = CGRectMake(0, 196.5, 320, 0.5);
    //温馨提示
    self.remindLabel.frame = CGRectMake(15, 110, 290, 87);
    self.remindLabel.text = L(@"MyEBuy_Prompt");
    
}

-(void)setCShopReturnGoodsCellInfo:(ReturnGoodsPrepareDTO *)prepareDto
{
    if (IsNilOrNull(prepareDto))
    {
        return;
    }
    self.iconImageView.frame = CGRectMake(15, 12, 85, 85);
    
//    NSString *str = [NSString stringWithFormat:@"000000000%@",prepareDto.productCode];
    if ([[AppDelegate currentAppDelegate] isHeightQuailtyImg]) {
        
        self.iconImageView.imageURL = [ProductUtil getImageUrlWithProductCode:prepareDto.productCode size:ProductImageSize160x160];
    }
    else{
        
        self.iconImageView.imageURL = [ProductUtil getImageUrlWithProductCode:prepareDto.productCode size:ProductImageSize120x120];
    }
//    self.iconImageView.imageURL = [ProductUtil imageUrl_ls_ForProduct:str];
    
//    double yfbAmount = [prepareDto.returnYfbAmount doubleValue];
//    
//    double yhkAmount = [prepareDto.returnYhkAmount doubleValue];
//    
//    double totalAmount = yfbAmount+yhkAmount;
//    
//    if (![prepareDto.zstatus1 isEqualToString:@"C"] && totalAmount == 0.00f) {
//        
//        self.priceLbl.text = @"";
//    }else{
//        
//        self.priceLbl.text = [NSString stringWithFormat:@"￥%0.2f元",totalAmount];
//    }
    
    self.priceLbl.frame = CGRectMake(self.iconImageView.right+10, 55, 100, 20);

    if(IsStrEmpty(prepareDto.price))
    {
        self.priceLbl.text = @"";

    }
    else
    {
        self.priceLbl.text = [NSString stringWithFormat:@"￥%0.2f",[prepareDto.price doubleValue]];
    }
    int nameLines = [self setProNameHeight:prepareDto.productName WithLbl:self.productNameLbl];
    
    if(nameLines == 1)
    {
        self.productNameLbl.frame = CGRectMake(self.iconImageView.right+10, 16, (kScreenWidth-15-55-10-15), 15);
        self.priceLbl.frame = CGRectMake(self.iconImageView.right+10, 55, 100, 20);
        
        self.productNumLbl.frame = CGRectMake(_priceLbl.right+10, 55, 85, 20);
        self.productNumLbl.text = [NSString stringWithFormat:@"%@：%i",L(@"Constant_Amount"),[prepareDto.quantityValue intValue]];
        
        
    }
    else
    {
        self.productNameLbl.frame = CGRectMake(self.iconImageView.right+10, 10, (kScreenWidth-15-55-10-15), 40);
        
        self.priceLbl.frame = CGRectMake(self.iconImageView.right+10, 55, 100, 20);
        
        
        self.productNumLbl.frame = CGRectMake(_priceLbl.right+10, 55, 85, 20);
        self.productNumLbl.text = [NSString stringWithFormat:@"%@：%i",L(@"Constant_Amount"),[prepareDto.quantityValue intValue]];
        
        
    }
    
    self.productNameLbl.text = prepareDto.productName;
    
    
    self.supplierLbl.frame = CGRectMake(self.iconImageView.right+10, _productNumLbl.bottom, 180, 20);
    
    self.supplierLbl.text = [NSString stringWithFormat:@"%@",prepareDto.vendorCShopName?prepareDto.vendorCShopName:@""];
    
    
    self.lineView.hidden = NO;
    self.lineView1.hidden = YES;
    self.lineView.frame = CGRectMake(0, 109.5, 320, 0.5);
    
}

#pragma mark - 生活团购订单列表
- (void)setGroupOrderListCell:(GBOrderInfoDTO *)dto
{
    if(IsNilOrNull(dto))
    {
        return;
    }
    
    self.iconImageView.hidden = YES;
        
    CGFloat nameSizeHeight = [self lblNumberOfLines:self.productNameLbl.font WithLbl:dto.snProName WithLblWidth:290];
    
    self.productNameLbl.frame = CGRectMake(KNewCellOrigionX, 10, 290, nameSizeHeight);
    
    self.productNameLbl.text = dto.snProName?dto.snProName:@"";

    self.priceLbl.font = [UIFont systemFontOfSize:12];
    self.priceLbl.frame = CGRectMake(KNewCellOrigionX, self.productNameLbl.bottom+7, 290, 13);
    self.priceLbl.text = [NSString stringWithFormat:@"¥%@",dto.orderAmount?dto.orderAmount:@""];
    self.priceLbl.textAlignment = UITextAlignmentRight;

    self.productNumLbl.font = [UIFont systemFontOfSize:12];
    self.productNumLbl.frame = CGRectMake(KNewCellOrigionX, self.productNameLbl.bottom+7, 290, 13);
    self.productNumLbl.text = [NSString stringWithFormat:@"%@：%i",L(@"Constant_Amount"),[dto.saleCount intValue]];
    self.productNumLbl.textAlignment = UITextAlignmentLeft;

    
    self.supplierLbl.hidden = YES;
    
    self.lineView.hidden = NO;
    self.lineView1.hidden = YES;
    self.lineView.frame = CGRectMake(0, nameSizeHeight+42.5, 320, 0.5);
    
    
}

+ (CGFloat)setGroupOrderListCellHeight:(GBOrderInfoDTO *)dto
{
    if(IsNilOrNull(dto))
    {
        return 0;
    }
    
    CGFloat nameSizeHeight = [[NProOrderProductInfoCell alloc] lblNumberOfLines:[UIFont systemFontOfSize:13] WithLbl:dto.snProName WithLblWidth:290];
    
    
    return nameSizeHeight+43;
    
}


#pragma mark -
#pragma 退货中
-(void)setReturnGoodsQueryCellInfo:(ReturnGoodsQueryDTO *)prepareDto;
{
    if(IsNilOrNull(prepareDto))
    {
        return;
    }
    self.iconImageView.frame = CGRectMake(15, 12, 85, 85);
    
    if ([[AppDelegate currentAppDelegate] isHeightQuailtyImg]) {
        
        self.iconImageView.imageURL = [ProductUtil getImageUrlWithProductCode:prepareDto.productCode size:ProductImageSize160x160];
    }
    else{
        
        self.iconImageView.imageURL = [ProductUtil getImageUrlWithProductCode:prepareDto.productCode size:ProductImageSize120x120];
    }
    
    self.productNumLbl.hidden = YES;
//    self.priceLbl.hidden =  YES;
    self.priceLbl.hidden = YES;
    self.priceImageV.hidden = YES;

//    self.priceLbl.text = @"¥ ";
//
//    self.priceLbl.textColor = [UIColor colorWithRGBHex:0xFF0000];
//    self.priceLbl.font = [UIFont systemFontOfSize:15];
//    
//    NSString *cityId = [Config currentConfig].defaultCity;
//    self.priceImageV.imageURL = [ProductUtil priceImageUrlOfProductId:prepareDto.productId city:cityId];
    
    
    int nameLines = [self setProNameHeight:prepareDto.productName WithLbl:self.productNameLbl];
    self.productNameLbl.numberOfLines = 3;
    if(nameLines == 1)
    {
        self.productNameLbl.frame = CGRectMake(self.iconImageView.right+10, 16, (kScreenWidth-15-55-10-15), 15);
        self.priceLbl.frame = CGRectMake(self.iconImageView.right+10, 55, 8, 16);

        self.priceImageV.frame = CGRectMake(self.priceLbl.right, 55, 100, 16);

    }
    else
    {
        self.productNameLbl.frame = CGRectMake(self.iconImageView.right+10, 10, (kScreenWidth-15-55-10-15), 40);
        self.priceLbl.frame = CGRectMake(self.iconImageView.right+10, 55, 8, 16);

        self.priceImageV.frame = CGRectMake(self.priceLbl.right, 55, 100, 16);

        
    }
    
    self.productNameLbl.text = prepareDto.productName;
    
    
    self.supplierLbl.frame = CGRectMake(self.iconImageView.right+10, 75, 180, 20);
    
    if (IsStrEmpty(prepareDto.vendorCode))
    {
        self.supplierLbl.text = L(@"MyEBuy_SuningSelf");
    }
    else{
        self.supplierLbl.text = prepareDto.vendorName?prepareDto.vendorName:@"";
    }
    
    
    self.lineView.hidden = NO;
    self.lineView1.hidden = YES;
    self.lineView.frame = CGRectMake(0, 109.5, 320, 0.5);
    
}


#pragma mark - C店订单物流查询NewOrderSnxpressViewController
- (void)setCshopExpressCell:(NewSnxpressDTO *)dto  WithRow:(int)row
{
    if(IsNilOrNull(dto))
    {
        return;
    }
    
    self.productNumLbl.hidden = YES;
    self.priceLbl.hidden =  YES;
    self.productNumLbl.hidden = YES;
    self.supplierLbl.hidden = YES;
    
    NSString *prodName = nil;
    NSString *prodId = nil;
    
    
    if([dto.productList count] > 0)
    {
        NSDictionary *dic = [dto.productList objectAtIndex:row-1];
        prodName = [dic objectForKey:@"prodName"];
        prodId = [dic objectForKey:@"prodId"];
        
        self.iconImageView.frame = CGRectMake(15, 12, 55, 55);
        
        //NSString *str = [NSString stringWithFormat:@"0000000000%@",prodId];
        NSString *str = [dic objectForKey:@"partNumber"]; // 商品编码 而非商品id
        
        if ([[AppDelegate currentAppDelegate] isHeightQuailtyImg]) {
            
            self.iconImageView.imageURL = [ProductUtil getImageUrlWithProductCode:str size:ProductImageSize160x160];
        }
        else{
            
            self.iconImageView.imageURL = [ProductUtil getImageUrlWithProductCode:str size:ProductImageSize120x120];
        }
//        self.productNameLbl.numberOfLines = 3;
        self.productNameLbl.frame = CGRectMake(self.iconImageView.right+10, 10, (kScreenWidth-15-55-10-15), 60);
        self.productNameLbl.text = prodName?prodName:@"";
    }
    else
    {
        return;
    }
    
//    self.productNameLbl.numberOfLines = 3;

    self.lineView.hidden = NO;
    self.lineView1.hidden = YES;
    self.lineView.frame = CGRectMake(0, 79.5, 320, 0.5);
}
- (void)setExpressCell:(ProductListDTO *)dto  WithRow:(int)row
{
    if(IsNilOrNull(dto))
    {
        return;
    }
    
    self.productNumLbl.hidden = YES;
    self.priceLbl.hidden =  YES;
    self.productNumLbl.hidden = YES;
    self.supplierLbl.hidden = YES;
    //
    NSString *prodName = nil;
    //    NSString *prodId = nil;
    //
    //
    //    if([dto.productList count] > 0)
    //    {
    //        NSDictionary *dic = [dto.productList objectAtIndex:row-1];
    prodName = dto.productName;
    //        prodId = [dic objectForKey:@"prodId"];
    
    self.iconImageView.frame = CGRectMake(15, 52, 55, 55);
    
    //        NSString *str = [NSString stringWithFormat:@"0000000000%@",prodId];
    
    if ([[AppDelegate currentAppDelegate] isHeightQuailtyImg]) {
        
        self.iconImageView.imageURL = [ProductUtil getImageUrlWithProductCode:dto.productCode size:ProductImageSize160x160];
    }
    else{
        
        self.iconImageView.imageURL = [ProductUtil getImageUrlWithProductCode:dto.productCode size:ProductImageSize120x120];
    }
    //        self.productNameLbl.numberOfLines = 3;
    self.productNameLbl.frame = CGRectMake(self.iconImageView.right+10, 50, (kScreenWidth-15-55-10-15), 60);
    self.productNameLbl.text = prodName?prodName:@"";
    //    }
    //    else
    //    {
    //        return;
    //    }
    
    //    self.productNameLbl.numberOfLines = 3;
    
    self.lineView.hidden = NO;
    self.lineView1.hidden = YES;
    self.lineView.frame = CGRectMake(0, 119.5, 320, 0.5);

}
- (void)setNewExpressCell:(ProductListDTO *)dto  WithRow:(int)row newOrderListDTO:(ServiceDetailDTO *)serviceDetailDto
{
    if(IsNilOrNull(dto))
    {
        return;
    }
    
    self.productNumLbl.hidden = YES;
    self.priceLbl.hidden =  YES;
    self.productNumLbl.hidden = YES;
    self.supplierLbl.hidden = YES;
//    
    NSString *prodName = nil;
//    NSString *prodId = nil;
//    
//
//    if([dto.productList count] > 0)
//    {
//        NSDictionary *dic = [dto.productList objectAtIndex:row-1];
        prodName = dto.productName;
//        prodId = [dic objectForKey:@"prodId"];
    
        self.iconImageView.frame = CGRectMake(15, 52, 55, 55);
        
//        NSString *str = [NSString stringWithFormat:@"0000000000%@",prodId];
    
        if ([[AppDelegate currentAppDelegate] isHeightQuailtyImg]) {
            
            self.iconImageView.imageURL = [ProductUtil getImageUrlWithProductCode:dto.productCode size:ProductImageSize160x160];
        }
        else{
            
            self.iconImageView.imageURL = [ProductUtil getImageUrlWithProductCode:dto.productCode size:ProductImageSize120x120];
        }
        //        self.productNameLbl.numberOfLines = 3;
        self.productNameLbl.frame = CGRectMake(self.iconImageView.right+10, 50,(kScreenWidth-15-55-10-15), 60);
        self.productNameLbl.text = prodName?prodName:@"";
//    }
//    else
//    {
//        return;
//    }

    //    self.productNameLbl.numberOfLines = 3;
    
    self.deliveryDetail.frame = CGRectMake(15, 0, 100, 40);
    self.arrivalTime.frame = CGRectMake(115, 0, 200, 40);
    if (IsStrEmpty(serviceDetailDto.deliveryDate)) {
        self.arrivalTime.hidden = YES;
    }
    else
    {
        self.arrivalTime.hidden = NO;
//        self.arrivalTime.text = [NSString stringWithFormat:@"预计到货时间: %@",[serviceDetailDto. substringWithRange:NSMakeRange(0, 10)]];
        self.arrivalTime.text = [NSString stringWithFormat:@"%@: %@",L(@"MyEBuy_ExpectedArrivalTime"),serviceDetailDto.deliveryDate];

    }
    

    
    self.lineView.hidden = NO;
    self.lineView1.hidden = YES;
    self.lineView.frame = CGRectMake(0, 119.5, 320, 0.5);
    self.lineView2.frame = CGRectMake(0, 39.5, 320, 0.5);
}



+ (CGFloat)setCshopExpressCell:(NewSnxpressDTO *)dto  WithRow:(int)row
{
    if(IsNilOrNull(dto))
    {
        return 0;
    }

    if([dto.productList count] <= 0)
    {
        return 0;
    }
    
    return 80;
}


- (int)setProNameHeight:(NSString *)nameStr WithLbl:(UILabel *)lbl
{
    //    NSString *nameTemp  = [[[NSString stringWithFormat:@"%@",nameStr] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] replacedWhiteSpacsByString:@""];
    
    NSString *nameTemp = [NSString stringWithFormat:@"%@",nameStr];
    
    CGSize labelHeight = [nameTemp sizeWithFont:lbl.font];
    
    CGSize contextSize = [nameTemp heightWithFont:lbl.font width:(kScreenWidth-15-55-10-15) linebreak:UILineBreakModeCharacterWrap];
    
    NSInteger lines = ceil(contextSize.height/labelHeight.height);
    
    if(lines > 1)
    {
        return 2;
    }
    else
    {
        return 1;
    }
    
}


#pragma mark - 商品详情申请退货列表
-(void)setOrderReturnGoodsCellInfo:(MemberOrderDetailsDTO *)prepareDto WithBtnSelect:(BOOL)isSelect
{
    if(IsNilOrNull(prepareDto))
    {
        return ;
    }
    
    self.checkBtn.frame = CGRectMake(15, 40, 20, 20);
    self.checkBtn.selected = isSelect;
    self.checkBtn.enabled = isSelect;
    
    self.iconImageView.frame = CGRectMake(47, 12, 85, 85);

    if ([[AppDelegate currentAppDelegate] isHeightQuailtyImg]) {
        
        self.iconImageView.imageURL = [ProductUtil getImageUrlWithProductCode:prepareDto.productCode size:ProductImageSize160x160];
    }
    else{
        
        self.iconImageView.imageURL = [ProductUtil getImageUrlWithProductCode:prepareDto.productCode size:ProductImageSize120x120];
    }
    
    self.productNameLbl.text = prepareDto.productName;
    
    
    if(IsStrEmpty(prepareDto.supplierCode) )
        
    {
        self.supplierLbl.text = L(@"MyEBuy_SuningSelf");
        
    }
    else
    {
        self.supplierLbl.text = prepareDto.cShopName;
        
    }
    
    self.productNumLbl.text =[NSString stringWithFormat:@"%@：%i",L(@"Constant_Amount"),[prepareDto.quantityInIntValue intValue]] ;
    
    NSString *marketPrice = [NSString stringWithFormat:@"¥ %.2f",[prepareDto.totalProduct floatValue]];
    
    self.priceLbl.text = marketPrice;
    
    self.productNameLbl.numberOfLines = 1;

    self.productNameLbl.frame = CGRectMake(self.iconImageView.right+10, 16, (kScreenWidth-15-55-10-15), 15);
    self.priceLbl.frame = CGRectMake(self.iconImageView.right+10, 55, 100, 20);
    
    self.productNumLbl.frame = CGRectMake(_priceLbl.right+10, 55, 85, 20);
    
    self.supplierLbl.frame = CGRectMake(self.iconImageView.right+10, _productNumLbl.bottom, 180, 20);

 
//    self.productNameLbl.numberOfLines = 1;
//    
//    self.productNameLbl.frame = CGRectMake(self.iconImageView.right+10, 16, 190, 15);
//    self.priceLbl.frame = CGRectMake(self.iconImageView.right+10, 55, 8, 16);
//    
//    self.priceImageV.frame = CGRectMake(self.priceLbl.right, 55, 100, 16);
//    
//    self.productNameLbl.text = prepareDto.productName;
    
//    self.supplierLbl.frame = CGRectMake(self.iconImageView.right+10, 75, 180, 20);
    
//    if([prepareDto.cshopFlag isEqualToString:@"0"])
//    {
//        self.supplierLbl.text = @"苏宁自营";
//    }
//    else{
//        self.supplierLbl.text =prepareDto.saleHall?prepareDto.saleHall:@"";
//    }
    
    
    self.lineView.hidden = NO;
    self.lineView1.hidden = YES;
    self.lineView.frame = CGRectMake(0, 99.5, 320, 0.5);
}

-(UIButton *)checkBtn{
    
    
    if (!_checkBtn) {
        
        _checkBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,
                                                               self.frame.size.height-20,
                                                               self.frame.size.width,
                                                               20)];
//        [_checkBtn addTarget:self
//                      action:@selector(checkBtnAction)
//            forControlEvents:UIControlEventTouchUpInside];
        [_checkBtn setBackgroundImage:[UIImage imageNamed:@"checkbox_selected.png"] forState:UIControlStateSelected];
        [_checkBtn setBackgroundImage:[UIImage imageNamed:@"checkbox_unselect.png"] forState:UIControlStateNormal];
        _checkBtn.selected = NO;
        
        [self.contentView addSubview:_checkBtn];
    }
    
    
    return _checkBtn;
}

//-(void)checkBtnAction{
//    
//    self.checkBtn.selected = !self.checkBtn.isSelected;
//}

- (NSMutableArray*)checkBtnArr
{
    if(!_checkBtnArr)
    {
        _checkBtnArr = [[NSMutableArray alloc] init];
    }
    
    return _checkBtnArr;
}

- (UILabel *)deliveryDetail
{
    if (!_deliveryDetail) {
        _deliveryDetail = [[UILabel alloc] init];
        _deliveryDetail.font = [UIFont systemFontOfSize:14.0f];
        _deliveryDetail.backgroundColor = [UIColor clearColor];
        _deliveryDetail.textColor = [UIColor blackColor];
        _deliveryDetail.textAlignment = UITextAlignmentLeft;
        _deliveryDetail.text = L(@"MyEBuy_DeliveryInformation");
        [self.contentView addSubview:_deliveryDetail];
    }
    return _deliveryDetail;
}

- (UILabel *)arrivalTime{
    if (!_arrivalTime) {
        _arrivalTime = [[UILabel alloc] init];
        _arrivalTime.font = [UIFont systemFontOfSize:14.0f];
        _arrivalTime.backgroundColor = [UIColor clearColor];
        _arrivalTime.textColor = [UIColor blackColor];
        _arrivalTime.textAlignment = UITextAlignmentRight;
        [self.contentView addSubview:_arrivalTime];
    }
    return _arrivalTime;
}

- (UILabel*)orderStatusLbl
{
    if(!_orderStatusLbl)
    {
        _orderStatusLbl = [[UILabel alloc] init];
        
        [self setContextLblProtery:_orderStatusLbl];
        _orderStatusLbl.font = [UIFont systemFontOfSize:14.0f];
        _orderStatusLbl.textColor = [UIColor colorWithRGBHex:0x313131];
        
        [self.contentView addSubview:_orderStatusLbl];
    }
    return _orderStatusLbl;
}


- (CGRect )setControlsFrame:(CGRect )frame productListDto:(ProductListDTO *)dto
{
    if(dto.isShowShopName)
    {
        frame.origin.y = frame.origin.y + 35;
    }
    return frame;
}


@end
