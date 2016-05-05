//
//  NProOrderListHeadCell.m
//  SuningEBuy
//
//  Created by xmy on 26/1/14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "NProOrderListHeadCell.h"
#import "orderHttpDataSource.h"
@implementation NProOrderListHeadCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILongPressGestureRecognizer *longpressGesture  = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress)];
        longpressGesture.minimumPressDuration           = 0.5;
        [self.copyView addGestureRecognizer:longpressGesture];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

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

- (UILabel*)countLbl
{
    if(!_countLbl)
    {
        _countLbl = [[UILabel alloc] init];
        _countLbl.textColor = [UIColor colorWithRGBHex:0x313131];
        
        _countLbl.backgroundColor = [UIColor clearColor];
        
        _countLbl.font = [UIFont systemFontOfSize:14];
        
        _countLbl.textAlignment = UITextAlignmentLeft;

        
        [self.contentView addSubview:_countLbl];
    }
    
    return _countLbl;
}

-(UILabel *)priceLbl{
    
    if (!_priceLbl) {
        
        _priceLbl = [[UILabel alloc]init];
        
        _priceLbl.textColor = [UIColor orange_Red_Color];
        
        _priceLbl.backgroundColor = [UIColor clearColor];
        
        _priceLbl.font = [UIFont systemFontOfSize:14];
        
        _priceLbl.textAlignment = UITextAlignmentLeft;
        
        _priceLbl.lineBreakMode = UILineBreakModeCharacterWrap;
        
        _priceLbl.numberOfLines = 0;

        
        [self.contentView addSubview:_priceLbl];
    }
    return _priceLbl;
}


- (UILabel*)orderIdLbl
{
    if(!_orderIdLbl)
    {
        _orderIdLbl = [[UILabel alloc] init];
        _orderIdLbl.textColor = [UIColor colorWithRGBHex:0x313131];
        
        _orderIdLbl.backgroundColor = [UIColor clearColor];
        
        _orderIdLbl.font = [UIFont systemFontOfSize:14.0f];
        
        _orderIdLbl.textAlignment = UITextAlignmentLeft;

        [self.copyView addSubview:_orderIdLbl];
    }
    
    return _orderIdLbl;
}

-(UILabel *)updateTimeLbl{
    
    if (!_updateTimeLbl) {
        
        _updateTimeLbl = [[UILabel alloc]init];
        _updateTimeLbl.textColor = [UIColor dark_Gray_Color];
        
        _updateTimeLbl.backgroundColor = [UIColor clearColor];
        
        _updateTimeLbl.font = [UIFont systemFontOfSize:14.0f];
        
        _updateTimeLbl.textAlignment = UITextAlignmentCenter;
        
        _updateTimeLbl.lineBreakMode = UILineBreakModeCharacterWrap;
        
        _updateTimeLbl.numberOfLines = 0;

        [self.contentView addSubview:_updateTimeLbl];
    }
    return _updateTimeLbl;
}

- (UILabel*)orderIdContextLbl
{
    if(!_orderIdContextLbl)
    {
        _orderIdContextLbl = [[UILabel alloc] init];
        
        [self setContextLblProtery:_orderIdContextLbl];
        _orderIdContextLbl.hidden = YES;

        _orderIdContextLbl.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:_orderIdContextLbl];
    }
    
    return _orderIdContextLbl;
}

-(UILabel *)updateTimeTextLbl
{
    
    if (!_updateTimeTextLbl) {
        
        _updateTimeTextLbl = [[UILabel alloc]init];
        
        [self setContextLblProtery:_updateTimeTextLbl];
        _updateTimeTextLbl.hidden = YES;

        [self.contentView addSubview:_updateTimeTextLbl];
    }
    return _updateTimeTextLbl;
}


- (UIImageView*)lineView
{
    if(!_lineView)
    {
        _lineView = [[UIImageView alloc] init];
        
        _lineView.backgroundColor = [UIColor clearColor];
        
        _lineView.frame = CGRectMake(0, 39.5, 320, 0.5);
                
        [_lineView setImage:[UIImage streImageNamed:@"line.png"]];
        
        [self.contentView addSubview:_lineView];
    }
    
    return _lineView;
    
}

- (UIImageView*)upLineView
{
    if(!_upLineView)
    {
        _upLineView = [[UIImageView alloc] init];
        
        _upLineView.backgroundColor = [UIColor clearColor];
        
        _upLineView.frame = CGRectMake(0, 0, 320, 0.5);
        
        [_upLineView setImage:[UIImage streImageNamed:@"line.png"]];
        
        [self.contentView addSubview:_upLineView];
    }
    
    return _upLineView;
    
}

- (UIView *)copyView
{
    if (!_copyView) {
        _copyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 165, 40)];
        _copyView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_copyView];
    }
    return _copyView;
}

#pragma mark -
#pragma  NewOrderListDTO 商品订单详情
- (void)setNOrderDetailListHeadCellInfo:(MemberOrderNamesDTO*)listDto

{
    if (IsNilOrNull(listDto)) {
        return;
    }

    if([listDto.totalPrice doubleValue] > 0)
    {
        self.orderIdLbl.frame = CGRectMake(15, 0, 165, 40);
        self.orderIdLbl.text = [NSString stringWithFormat:@"%@：%@",L(@"MyEBuy_OrderCode"),listDto.orderId];
        
        self.updateTimeLbl.frame = CGRectMake(_orderIdLbl.right, 0, 125, 40);
        self.payDetailBtn.frame = CGRectMake(250, 38, 57, 35);
        if(IsStrEmpty(listDto.lastUpdate))
        {
            self.updateTimeLbl.text = [NSString stringWithFormat:@"%@",@""];
            
        }
        else
        {
            //        NSString *time = [[listDto.lastUpdate substringFromIndex:0] substringToIndex:10];
            
            NSString *yearStr = [listDto.lastUpdate substringWithRange:NSMakeRange(0, 4)];
            NSString *mouthStr = [listDto.lastUpdate substringWithRange:NSMakeRange(5, 2)];
            NSString *dayStr = [listDto.lastUpdate substringWithRange:NSMakeRange(8, 2)];
            
            
            self.updateTimeLbl.text = [NSString stringWithFormat:@"%@/%@/%@",yearStr,mouthStr,dayStr];
            
            
        }
        
        self.upLineView.frame = CGRectMake(0, 83.5, 320, 0.5);
        self.lineView.frame = CGRectMake(0, 114.5, 320, 0.5);
        
        
        
        self.countLbl.text = [NSString stringWithFormat:@"%@ : ",L(@"MyEBuy_OrderAmount")];
        
        self.countLbl.frame = CGRectMake(15, 40, 65, 30);
        
        self.priceLbl.text = [NSString stringWithFormat:@"¥ %.2f",[listDto.prepayAmount doubleValue]];
        
        self.priceLbl.frame = CGRectMake(self.countLbl.right, 40, 80, 30);
        
        BOOL canSecondPay = listDto.canTwiceBuyNew;
        
        if(canSecondPay == YES)
        {
            self.payDetailBtn.hidden = NO;
        }
        else
        {
            self.payDetailBtn.hidden = YES;
        }
        
    }
    else
    {
        self.payDetailBtn.hidden = YES;
    }
    
    
    if([listDto.oiStatus isEqualToString:@"M2"] || [listDto.oiStatus isEqualToString:@"M3"])
    {
        self.payDetailBtn.hidden = YES;
    }
    else
    {
        
    }
    
    self.supplierLbl.frame = CGRectMake(15, 84, 185, 30);
    if (IsStrEmpty(listDto.cShopName)) {
        self.supplierLbl.text = L(@"MyEBuy_SuningSelf");
    }
    else
    {
        self.supplierLbl.text = listDto.cShopName;
    }
    
    self.orderStatusLbl.frame = CGRectMake(self.supplierLbl.right, 84, 100, 30);
    if ([listDto.oiStatus eq:@"M"]) {
        self.orderStatusLbl.hidden = YES;
    }
    else
    {
        self.orderStatusLbl.hidden = NO;
        self.orderStatusLbl.text = [orderHttpDataSource getOrderTypeInfo:listDto.ormOrder WithOrderStatus:listDto.oiStatus];
    }

    
    
//    self.orderIdLbl.frame = CGRectMake(15, 0, 165, 40);
//    self.orderIdLbl.text = [NSString stringWithFormat:@"订单编号：%@",listDto.orderId];
//    
//    self.updateTimeLbl.frame = CGRectMake(_orderIdLbl.right, 0, 125, 40);
//    
//    if(IsStrEmpty(listDto.lastUpdate))
//    {
//        self.updateTimeLbl.text = [NSString stringWithFormat:@"%@",@""];
//        
//    }
//    else
//    {
//        //        NSString *time = [[listDto.lastUpdate substringFromIndex:0] substringToIndex:10];
//        
//        NSString *yearStr = [listDto.lastUpdate substringWithRange:NSMakeRange(0, 4)];
//        NSString *mouthStr = [listDto.lastUpdate substringWithRange:NSMakeRange(5, 2)];
//        NSString *dayStr = [listDto.lastUpdate substringWithRange:NSMakeRange(8, 2)];
//        
//        
//        self.updateTimeLbl.text = [NSString stringWithFormat:@"%@/%@/%@",yearStr,mouthStr,dayStr];
//        
//        
//    }
//    
//    //    self.upLineView.frame = CGRectMake(0, 0, 320, 1);
//    //    self.lineView.frame = CGRectMake(0, , 320, 0.5);
//    
//    
//    
//    self.countLbl.text = @"订单金额 : ";
//    
//    self.countLbl.frame = CGRectMake(15, 40, 65, 40);
//    
//    self.priceLbl.text = [NSString stringWithFormat:@"¥ %.2f",[listDto.prepayAmount doubleValue]];
//    
//    self.priceLbl.frame = CGRectMake(self.countLbl.right, 40, 80, 40);
//    
//    //    self.orderStatusLbl.frame = CGRectMake(250,5, 80, 40);
//    //    self.orderStatusLbl.text = [orderHttpDataSource getOrderTypeInfo:dto.ormOrder WithOrderStatus:dto.oiStatus];
//    
//    [self setAButtonsPosiotion:listDto WithProduct:nil];
//    //正在支付中定单无取消与支付按钮
//    if ([listDto.oiStatus hasPrefix:@"M2"]  ||
//        [listDto.oiStatus isEqualToString:@"M3"]) {
//        
//        self.cancelOrderBtn.hidden = YES;
//        self.payBtn.hidden = YES;
//        //        self.orderStatusLbl.text = [orderHttpDataSource getOrderTypeInfo:listDto.ormOrder WithOrderStatus:listDto.oiStatus];
//        //        self.orderStatusLbl.frame = CGRectMake(250,5, 80, 40);
//        //        self.orderStatusLbl.hidden = NO;
//	}
    
}

#pragma mark -
#pragma  NewOrderListDTO 商品订单列表
- (void)setNProOrderListHeadCellInfo:(NewOrderListDTO*)listDto
                         WithIsCshop:(BOOL)isCshop
                          productDto:(ProductListDTO *)productDTO
{
    if (IsNilOrNull(listDto)) {
        return;
    }
   
    self.item = listDto;
    //订单编号
    
    CGSize sz = self.frame.size;
    
    self.orderIdLbl.frame = CGRectMake(15, 0,sz.width-110.0f, 40);
    self.orderIdLbl.text = [NSString stringWithFormat:@"%@：%@",L(@"MyEBuy_OrderCode"),listDto.orderId];
    
    //下单时间
    self.updateTimeLbl.frame = CGRectMake(_orderIdLbl.right,0,100.0f, 40);
    if(IsStrEmpty(listDto.lastUpdate))
    {
        self.updateTimeLbl.text = [NSString stringWithFormat:@"%@",@""];
    }
    else
    {
        NSString *yearStr = [listDto.lastUpdate substringWithRange:NSMakeRange(0, 4)];
        NSString *mouthStr = [listDto.lastUpdate substringWithRange:NSMakeRange(5, 2)];
        NSString *dayStr = [listDto.lastUpdate substringWithRange:NSMakeRange(8, 2)];
        self.updateTimeLbl.text = [NSString stringWithFormat:@"%@/%@/%@",yearStr,mouthStr,dayStr];
    }
    
    //订单总额
    self.countLbl.text = [NSString stringWithFormat:@"%@ : ",L(@"MyEBuy_OrderAmount")];
    self.countLbl.frame = CGRectMake(15, 40, 70, 30);
    self.priceLbl.text = [NSString stringWithFormat:@"¥ %.2f",[listDto.prepayAmount doubleValue]];
    self.priceLbl.frame = CGRectMake(self.countLbl.right, 40, 80, 30);
    
    //支付按钮
    self.payBtn.frame = CGRectMake(250, 35, 57, 35);
    if (listDto.canTwiceBuy && ([listDto.oiStatus eq:@"M"] || [listDto.oiStatus eq:@"M1"]) ) {
        if ([listDto.ormOrder eq:@"11701"]) {
            self.payBtn.hidden = YES;
        }
        else
        {
            self.payBtn.hidden = NO;
        }
    }
    else
    {
        self.payBtn.hidden = YES;
    }
    if([listDto.oiStatus isEqualToString:@"M2"] || [listDto.oiStatus isEqualToString:@"M3"])
    {
        self.payBtn.hidden = YES;
    }
    
    // xzoscar 2014/08/19 add，删除订单 按钮
    self.deleteButton.frame = CGRectMake(KSecondBigBtnsX + 24, 35, KNewSmallBtnsWidth + 10, KNewBtnsHeight);
    if ([listDto.oiStatus isEqualToString:@"SC"] // 已完成
        || [listDto.oiStatus isEqualToString:@"r"] // 已退货
        || [listDto.oiStatus isEqualToString:@"X"]) {// 已取消
        self.deleteButton.hidden = NO;
    }else {
        self.deleteButton.hidden = YES;
    }
}

#pragma mark -
#pragma 门店订单列表
-(void)refreshShopOrderInfoCell:(ShopOrderListDto *)listDto
{
    if (IsNilOrNull(listDto)) {
        return;
    }
    
    CGSize sz = self.frame.size;
    
    self.orderIdLbl.frame = CGRectMake(15, 0,sz.width-110.0f, 40);
    self.orderIdLbl.text = [NSString stringWithFormat:@"%@：%@",L(@"MyEBuy_OrderCode"),listDto.sourceOrderId];

    self.updateTimeLbl.frame = CGRectMake(_orderIdLbl.right, 0,80.0f,40);
    

    if(IsStrEmpty(listDto.orderDttm))
    {
        self.updateTimeLbl.text = [NSString stringWithFormat:@"%@",@""];
        
    }
    else
    {
        
//        NSString *yearStr = [listDto.orderDttm substringWithRange:NSMakeRange(0, 4)];
//        NSString *mouthStr = [listDto.orderDttm substringWithRange:NSMakeRange(5, 2)];
//        NSString *dayStr = [listDto.orderDttm substringWithRange:NSMakeRange(8, 2)];
//        
//        
//        self.updateTimeLbl.text = [NSString stringWithFormat:@"%@/%@/%@",yearStr,mouthStr,dayStr];
        
        NSString *time = [[listDto.orderDttm substringFromIndex:0] substringToIndex:10];
        self.updateTimeLbl.text = [NSString stringWithFormat:@"%@",time];
        
        
    }
    
    self.lineView.frame = CGRectMake(0, 39.5, 320, 0.5);
    
    
}

#pragma mark -
#pragma 退货申请
-(void)refreshReturnGoodsInfoCell:(ReturnGoodsPrepareDTO *)prepareDto
{
    
    if (IsNilOrNull(prepareDto)) {
        return;
    }
    
    self.orderIdLbl.frame = CGRectMake(15, 0, 165, 40);
    self.orderIdLbl.text = [NSString stringWithFormat:@"%@：%@",L(@"MyEBuy_OrderId"),prepareDto.orderId];
    
    self.updateTimeLbl.frame = CGRectMake(_orderIdLbl.right, 0, 125, 40);
    
    
    if(IsStrEmpty(prepareDto.currentDay))
    {
        self.updateTimeLbl.text = [NSString stringWithFormat:@"%@",@""];
        
    }
    else
    {
        
        //        NSString *yearStr = [listDto.orderDttm substringWithRange:NSMakeRange(0, 4)];
        //        NSString *mouthStr = [listDto.orderDttm substringWithRange:NSMakeRange(5, 2)];
        //        NSString *dayStr = [listDto.orderDttm substringWithRange:NSMakeRange(8, 2)];
        //
        //
        //        self.updateTimeLbl.text = [NSString stringWithFormat:@"%@/%@/%@",yearStr,mouthStr,dayStr];
        
        NSString *time = [[prepareDto.currentDay substringFromIndex:0] substringToIndex:10];
        self.updateTimeLbl.text = [NSString stringWithFormat:@"%@",time];
        
        
    }
    
    self.lineView.frame = CGRectMake(0, 39.5, 320, 0.5);
    

    
       
}

#pragma mark - 生活团购订单列表
- (void)setGroupOrderListCell:(GBOrderInfoDTO *)dto
{
    if(IsNilOrNull(dto))
    {
        return;
    }
    
    self.orderIdLbl.frame = CGRectMake(KNewCellOrigionX, 0, 165, 40);
    self.orderIdLbl.text = [NSString stringWithFormat:@"%@：%@",L(@"MyEBuy_OrderId"),dto.orderId];
    
    self.updateTimeLbl.frame = CGRectMake(_orderIdLbl.right, 0, 125, 40);
    
    
    if(IsStrEmpty(dto.createTime))
    {
        self.updateTimeLbl.text = [NSString stringWithFormat:@"%@",@""];
        
    }
    else
    {
        
        NSString *time = [[dto.createTime substringFromIndex:0] substringToIndex:10];
        self.updateTimeLbl.text = [NSString stringWithFormat:@"%@",time];
        
        
    }
    
    self.lineView.frame = CGRectMake(0, 39.5, 320, 0.5);
}

#pragma mark -
#pragma 退货中
-(void)setReturnGoodsQueryInfoCell:(ReturnGoodsQueryDTO *)queryDto
{
    if(IsNilOrNull(queryDto))
    {
        return;
    }
    
    self.orderIdLbl.frame = CGRectMake(15, 0, 165, 40);
    self.orderIdLbl.text = [NSString stringWithFormat:@"%@：%@",L(@"MyEBuy_OrderId"),queryDto.orderId];
    
    self.updateTimeLbl.frame = CGRectMake(_orderIdLbl.right, 0, 125, 40);
    
    
    if(IsStrEmpty(queryDto.submitTime))
    {
        self.updateTimeLbl.text = [NSString stringWithFormat:@"%@",@""];
        
    }
    else
    {
        
   
        NSString *time = [[queryDto.submitTime substringFromIndex:0] substringToIndex:10];
        self.updateTimeLbl.text = [NSString stringWithFormat:@"%@",time];
        
        
    }
    
    self.lineView.frame = CGRectMake(0, 39.5, 320, 0.5);
    

    
}


#pragma mark - C店订单物流查询NewOrderSnxpressViewController
- (void)setCshopExpressCell:(NewSnxpressDTO *)dto
{
    if(IsNilOrNull(dto))
    {
        return;
    }
    
    self.orderIdLbl.frame = CGRectMake(15, 0, 165, 40);
    
    if(IsStrEmpty(dto.packageNum))
    {
        self.orderIdLbl.text = @"";
        
    }
    else
    {
        self.orderIdLbl.text = [NSString stringWithFormat:@"%@%@",L(@"MyEBuy_Package"),dto.packageNum];
        
    }
    
    self.updateTimeLbl.frame = CGRectMake(_orderIdLbl.right, 0, 320, 40);
    
    
    if(IsStrEmpty(dto.deliveryDate))
    {
        self.updateTimeLbl.text = @"";
        
    }
    else
    {
        self.updateTimeLbl.text = [NSString stringWithFormat:@"%@：%@",L(@"MyEBuy_ExpectedArrival"),dto.deliveryDate?dto.deliveryDate:@""];
        
    }
    
    self.lineView.frame = CGRectMake(0, 39.5, 320, 0.5);
    
}

#pragma mark -非C店订单物流查询ServiceDetailViewController －－－门店订单物流查询
- (void)setZiYingExpressCell:(ServiceDetailDTO *)dto WithIsInStall:(BOOL)isInstall WithCode:(NSString*)verificationCode
{
    if(IsNilOrNull(dto))
    {
        return;
    }
    
    self.orderIdLbl.frame = CGRectMake(15, 0, 50, 40);
    
    if(IsStrEmpty(verificationCode))
    {
        self.orderIdLbl.hidden = YES;
        self.orderIdLbl.text = @"";
    }
    else
    {
        self.orderIdLbl.hidden = NO;

        self.orderIdLbl.text =[NSString stringWithFormat:@"%@:",L(@"MyEBuy_CheckCode")];// [NSString stringWithFormat:@"校验码:%@",verificationCode];
        self.orderIdContextLbl.text = verificationCode?verificationCode:@"";
        self.orderIdContextLbl.frame = CGRectMake(self.orderIdLbl.right, 0, 100, 40);
        self.orderIdContextLbl.textAlignment = UITextAlignmentLeft;
        self.orderIdContextLbl.hidden = NO;
        self.orderIdContextLbl.textColor = [UIColor orange_Light_Color];
    }

//        self.orderIdLbl.text = dto.deliveryType?dto.deliveryType:@"";
    self.updateTimeLbl.hidden = NO;
    
    self.updateTimeLbl.frame = CGRectMake(15, 0, 210, 40);
    self.updateTimeLbl.textColor = [UIColor light_Black_Color];
    if(IsStrEmpty(dto.deliveryDate))
    {
        self.updateTimeLbl.text = @"";
        self.lineView.hidden = YES;

    }
    else
    {
        self.updateTimeLbl.text = [NSString stringWithFormat:@"%@:",L(@"MyEBuy_ExpectedArrival")];
        self.updateTimeTextLbl.hidden = NO;
        self.updateTimeTextLbl.text = [NSString stringWithFormat:@"%@",dto.deliveryDate?dto.deliveryDate:@""];
        self.updateTimeTextLbl.textAlignment = UITextAlignmentRight;
        self.updateTimeTextLbl.frame = CGRectMake(15, 0, 290, 40);
        self.lineView.hidden = NO;

        self.lineView.frame = CGRectMake(0, 39.5, 320, 0.5);

    }

    
    
}



#pragma mark ----------------------------- 拷贝

- (void)longPress
{
    [self becomeFirstResponder];
    
    UIMenuItem   *copyItem = [[UIMenuItem alloc] initWithTitle:L(@"MyEBuy_CopyOrderNumber") action:@selector(copyClicked:)];
    UIMenuController *menuControll  = [UIMenuController sharedMenuController];
    [menuControll setMenuItems:@[copyItem]];
    
    [menuControll setTargetRect:self.orderIdLbl.frame inView:self.contentView];
    
    [menuControll update];
    [menuControll setMenuVisible:YES];
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(copyClicked:)) {
        return YES;
    }
    return NO;
}


- (void)copyClicked:(id)sender
{
    //贴入剪贴板
    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
    [pasteBoard setString:self.item.orderId];
}

//A:全部订单
- (void)setAButtonsPosiotion:(NewOrderListDTO *)dto
                 WithProduct:(ProductListDTO *)productDto
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
    {//已退货订单
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


//C:已支付的订单
- (void)setCButtonsPosiotion:(NewOrderListDTO *)dto
{
    self.payBtn.hidden = YES;
    self.cancelOrderBtn.hidden = YES;
    
}

//M:待支付的订单
- (void)setMButtonsPosiotion:(NewOrderListDTO *)dto{
    
    //    if(![dto.ormOrder isEqualToString:@"11601"] &&
    //       ![dto.ormOrder isEqualToString:@"11701"])
    //    {
    //
    //        self.payBtn.hidden = YES;
    //        self.cancelOrderBtn.hidden = YES;
    //    }
    //    else
    //    {
    self.payBtn.hidden = YES;
    self.cancelOrderBtn.hidden = YES;
    
    
    UIButton *button1 = nil;
    UIButton *button2 = nil;
    
    BOOL cancelOrder = [dto canCancelOrderList];
    
    //可以二次支付，展示二次支付按钮
    if (dto.canTwiceBuy) {
        
        self.payBtn.hidden = NO;
        button2 = self.payBtn;
        
    }
    
    //可以取消订单，展示取消订单按钮
    if (cancelOrder) {
        
        self.cancelOrderBtn.hidden = NO;
        
        if (IsNilOrNull(button2)) {
            button2 = self.cancelOrderBtn;
        }else{
            button1 = self.cancelOrderBtn;
        }
        
    }
    
    
    button1.frame = CGRectMake(190, 42, 50, 35);
    
    button2.frame = CGRectMake(254, 42, 50, 35);
    
    //    }
    if([dto.oiStatus hasPrefix:@"M"] && ([dto.ormOrder isEqualToString:@"11601"] ||[dto.ormOrder isEqualToString:@"11701"]))
    {
        
        self.cancelOrderBtn.hidden = YES;
        
        self.payBtn.hidden = YES;
        
        
    }
    
}

//M M1:发货处理中订单
- (void)setM1OrM2ButtonsPosiotion:(NewOrderListDTO *)dto{
    
    self.payBtn.hidden = YES;
    self.cancelOrderBtn.hidden = YES;
    
    
    if([dto.oiStatus hasPrefix:@"M"] && ([dto.ormOrder isEqualToString:@"11601"]))
    {
        
        self.cancelOrderBtn.hidden = YES;
        
        self.payBtn.hidden = YES;
        
    }
    
    
    
}


//X:已取消的订单
- (void)setXButtonsPosiotion:(NewOrderListDTO *)dto{
    
    self.payBtn.hidden = YES;
    self.cancelOrderBtn.hidden = YES;
    
}

//R:退货成功的订单
- (void)setRButtonsPosiotion:(NewOrderListDTO *)dto{
    
    self.payBtn.hidden = YES;
    self.cancelOrderBtn.hidden = YES;
}

- (UIButton*)deleteButton
{
    if(!_deleteButton)
    {
        _deleteButton = [[UIButton alloc] init];
        
        [_deleteButton setTitle:L(@"BTDeleteOrders") forState:UIControlStateNormal];
        [_deleteButton addTarget:self action:@selector(on_operationButton_clicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [_deleteButton setTitleColor:[UIColor orange_Light_Color] forState:UIControlStateNormal];
        
        _deleteButton.titleLabel.font = [UIFont systemFontOfSize:14];
        
        UIImage *buttonImageNormal = [UIImage streImageNamed:@"order_WuLiu.png"];
        
        UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:0 topCapHeight:0];
        
        [_deleteButton setBackgroundImage:stretchableButtonImageNormal
                                     forState:UIControlStateNormal];
        [_deleteButton setBackgroundImage:[UIImage imageNamed:@"order_WuLiuClicked.png"]
                                     forState:UIControlStateHighlighted];
        _deleteButton.hidden = YES;
        
        [self.contentView addSubview:_deleteButton];
    }
    return _deleteButton;
}

- (void)performOperationDelegate:(int)operation {
    if (nil != _delegate
        && [_delegate respondsToSelector:@selector(delegate_NProOrderListHeadCell_operation: view:)]) {
        [_delegate delegate_NProOrderListHeadCell_operation:operation view:self];
    }
}

- (void)on_operationButton_clicked:(UIButton *)sender {
    
    int operation = -1;
    if (sender == _deleteButton) {
        operation = 0;
        
        NProOrderListHeadCell *__weak weakSelf = self;
        
        BBAlertView *alertView = [[BBAlertView alloc] initWithTitle:@""
                                                            message:L(@"MyEBuy_AreYouSureToDeleteOrder")
                                                           delegate:nil
                                                  cancelButtonTitle:L(@"Cancel") otherButtonTitles:L(@"Ok")];
        [alertView setConfirmBlock:^{
            [weakSelf performOperationDelegate:operation];
        }];
        [alertView show];
    }
}


- (UIButton*)payBtn
{
    if(!_payBtn)
    {
        _payBtn = [[UIButton alloc] init];
        
        [_payBtn setTitle:L(@"MyEBuy_Payment") forState:UIControlStateNormal];
        
        [_payBtn setTitleColor:[UIColor orange_Light_Color] forState:UIControlStateNormal];
        
        
        [_payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        _payBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        
        //        UIImage *buttonImageNormal = [UIImage imageNamed:@"order_Orange.png"];
        
        UIImage *buttonImageNormal = [UIImage imageNamed:@"submit_button_normal.png"];
        
        
        UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:0 topCapHeight:0];
        
        [_payBtn setBackgroundImage:stretchableButtonImageNormal
                           forState:UIControlStateNormal];
        [_payBtn setBackgroundImage:[UIImage streImageNamed:@"submit_button_touched.png"]
                           forState:UIControlStateHighlighted];
        _payBtn.hidden = YES;
        
        [self.contentView addSubview:_payBtn];
    }
    
    return _payBtn;
}

- (UIButton*)payDetailBtn
{
    if(!_payDetailBtn)
    {
        _payDetailBtn = [[UIButton alloc] init];
        
        [_payDetailBtn setTitle:L(@"MyEBuy_Payment") forState:UIControlStateNormal];
        
        [_payDetailBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        
//        [_payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        _payDetailBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        
        //        UIImage *buttonImageNormal = [UIImage imageNamed:@"order_Orange.png"];
        
        UIImage *buttonImageNormal = [UIImage imageNamed:@"submit_button_normal.png"];
        
        
        UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:0 topCapHeight:0];
        
        [_payDetailBtn setBackgroundImage:stretchableButtonImageNormal
                           forState:UIControlStateNormal];
        [_payDetailBtn setBackgroundImage:[UIImage streImageNamed:@"submit_button_touched.png"]
                           forState:UIControlStateHighlighted];
        _payDetailBtn.hidden = YES;
        
        [self.contentView addSubview:_payDetailBtn];
    }
    
    return _payDetailBtn;
}


- (UIButton*)cancelOrderBtn
{
    if(!_cancelOrderBtn)
    {
        _cancelOrderBtn = [[UIButton alloc] init];
        
        [_cancelOrderBtn setTitle:L(@"Cancel") forState:UIControlStateNormal];
        
        [_cancelOrderBtn setTitleColor:RGBCOLOR(68, 68, 68) forState:UIControlStateNormal];
        
        
        [_cancelOrderBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        _cancelOrderBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        
        UIImage *buttonImageNormal = [UIImage imageNamed:@"button_white_normal.png"];
        
        UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:0 topCapHeight:0];
        
        [_cancelOrderBtn setBackgroundImage:stretchableButtonImageNormal
                                   forState:UIControlStateNormal];
        
        [_cancelOrderBtn setBackgroundImage:[UIImage imageNamed:@"button_white_clicked.png"]
                                   forState:UIControlStateHighlighted];
        _cancelOrderBtn.hidden = YES;
        
//        [self.contentView addSubview:_cancelOrderBtn];
    }
    
    return _cancelOrderBtn;
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



@end
