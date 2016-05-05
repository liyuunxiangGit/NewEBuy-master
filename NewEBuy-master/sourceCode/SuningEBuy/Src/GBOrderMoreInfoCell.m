//
//  GBOrderMoreInfo.m
//  SuningEBuy
//
//  Created by 王 漫 on 13-3-11.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "GBOrderMoreInfoCell.h"

@implementation GBOrderMoreInfoCell
@synthesize item = _item;
@synthesize singleInfoView = _singleInfoView;
@synthesize doubleInfoView = _doubleInfoView;
@synthesize threeInfoView = _threeInfoView;
@synthesize returnButton = _returnButton;
@synthesize payButton = _payButton;
@synthesize cancelButton = _cancelButton;
@synthesize delegate = _delegate;

- (void)dealloc{
    
    TT_RELEASE_SAFELY(_item);
    TT_RELEASE_SAFELY(_singleInfoView);
    TT_RELEASE_SAFELY(_doubleInfoView);
    TT_RELEASE_SAFELY(_threeInfoView);
    TT_RELEASE_SAFELY(_returnButton);
    TT_RELEASE_SAFELY(_payButton);
    TT_RELEASE_SAFELY(_cancelButton);
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self )
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryNone;
        orderStatus = -1;
        tuanGouType = -1;
        [ [NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notCancelOrder) name:GB_ORDER_CANCEL_FAIL object:nil];
        
    }
    return self;
}

- (void)notCancelOrder
{
    [self.payButton setBackgroundImage:[UIImage imageNamed:@"GB_pay_submit.png"] forState:UIControlStateNormal];
    [self.cancelButton setBackgroundImage:[UIImage imageNamed:@"GB_order_cancel.png"] forState:UIControlStateNormal];
}

- (UIView *)singleInfoView{
    if (!_singleInfoView) {
        _singleInfoView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, 320, 70)];
        _singleInfoView.backgroundColor = [UIColor clearColor];
        UIButton *singleButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, 300, 50)];
        [singleButton setTitle:L(@"BTPrompt") forState:UIControlStateNormal];
        singleButton.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
        singleButton.backgroundColor = [UIColor clearColor];
        [singleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [singleButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -170, 0, 0)];
        [singleButton setBackgroundImage: [UIImage imageNamed:@"GB_cell_single_background.png"] forState:UIControlStateNormal];
        UIImageView *imageV = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"GB_cell_arrow.png"]];
        imageV.backgroundColor = [UIColor clearColor];
        imageV.frame = CGRectMake(245, 20, 10, 15);
        [singleButton addSubview:imageV];
        [_singleInfoView addSubview:singleButton];
        [singleButton addTarget:self action:@selector(gotoVoucherNotice) forControlEvents:UIControlEventTouchUpInside];
    }
    return _singleInfoView;
}

- (UIView *)doubleInfoView{
    if (!_doubleInfoView) {
        _doubleInfoView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, 320, 120)];
        _doubleInfoView.backgroundColor = [UIColor clearColor];
        UIButton *topButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, 300, 50)];
        topButton.backgroundColor = [UIColor clearColor];
        topButton.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
        [topButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [topButton setBackgroundImage:[UIImage imageNamed:@"GB_cell_top_background.png"] forState:UIControlStateNormal];
        [topButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -170, 0, 0)];
       // topButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_doubleInfoView addSubview:topButton];
        UIButton *bottomButton = [[UIButton alloc]initWithFrame:CGRectMake(10, topButton.bottom, 300, 50)];
        bottomButton.backgroundColor = [UIColor clearColor];
        bottomButton.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
        [bottomButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [bottomButton setBackgroundImage:[UIImage imageNamed:@"GB_cell_bottom_background.png"] forState:UIControlStateNormal];
        [bottomButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -170, 0, 0)];
        //bottomButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        UIImageView *imageV1 = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"GB_cell_arrow.png"]];
        imageV1.backgroundColor = [UIColor clearColor];
        imageV1.frame = CGRectMake(245, 20, 10, 15);
        [topButton addSubview:imageV1];
        UIImageView *imageV2 = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"GB_cell_arrow.png"]];
        imageV2.backgroundColor = [UIColor clearColor];
        imageV2.frame = CGRectMake(245, 20, 10, 15);
        [bottomButton addSubview:imageV2];
        [_doubleInfoView addSubview:topButton];
        [_doubleInfoView addSubview:bottomButton];
        if (tuanGouType == 0 && (orderStatus == 1 || orderStatus == 2)) {
            [topButton setTitle:L(@"GBDetailOfGroupCertification") forState:UIControlStateNormal];
            [bottomButton   setTitle:L(@"BTPrompt2") forState:UIControlStateNormal];
            [topButton addTarget:self action:@selector(gotoVoucherInfo) forControlEvents:UIControlEventTouchUpInside];
            [bottomButton addTarget:self action:@selector(gotoVoucherNotice) forControlEvents:UIControlEventTouchUpInside];
        }
        if (tuanGouType == 1 && (orderStatus !=1 && orderStatus !=2)) {
            [topButton setTitle:L(@"GBProjectOfGroupBuy") forState:UIControlStateNormal];
            [bottomButton setTitle:L(@"BTInfoOfShop") forState:UIControlStateNormal];
            [topButton addTarget:self action:@selector(gotoVoucherNotice) forControlEvents:UIControlEventTouchUpInside];
            [bottomButton addTarget:self action:@selector(gotoShopInfo) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return _doubleInfoView;
}

- (UIView *)threeInfoView
{
    if (!_threeInfoView) {
        _threeInfoView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, 320, 170)];
        _threeInfoView.backgroundColor = [UIColor clearColor];
        UIButton *topButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, 300, 50)];
        topButton.backgroundColor = [UIColor clearColor];
        topButton.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
        [topButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [topButton setTitle:L(@"GBDetailOfGroupCertification2") forState:UIControlStateNormal];
        [topButton setBackgroundImage:[UIImage imageNamed:@"GB_cell_three_top_background.png"] forState:UIControlStateNormal];
        [topButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -170, 0, 0)];
        UIImageView *imageV1 = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"GB_cell_arrow.png"]];
        imageV1.backgroundColor = [UIColor clearColor];
        imageV1.frame = CGRectMake(245, 20, 10, 15);
        [topButton addSubview:imageV1];
        [_doubleInfoView addSubview:topButton];
        UIButton *middleButton = [[UIButton alloc]initWithFrame:CGRectMake(10, topButton.bottom, 300, 50)];
        middleButton.backgroundColor = [UIColor clearColor];
        middleButton.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
        [middleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [middleButton setTitle:L(@"GBProjectOfGroupBuy") forState:UIControlStateNormal];
        [middleButton setBackgroundImage:[UIImage imageNamed:@"GB_cell_three_middle_background.png"] forState:UIControlStateNormal];
        [middleButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -170, 0, 0)];
        UIImageView *imageV2 = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"GB_cell_arrow.png"]];
        imageV2.backgroundColor = [UIColor clearColor];
        imageV2.frame = CGRectMake(245, 20, 10, 15);
        [middleButton addSubview:imageV2];
        [_doubleInfoView addSubview:middleButton];
        UIButton *bottomButton = [[UIButton alloc]initWithFrame:CGRectMake(10, middleButton.bottom, 300, 50)];
        bottomButton.backgroundColor = [UIColor clearColor];
        bottomButton.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
        [bottomButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [bottomButton setTitle:L(@"BTInfoOfShop") forState:UIControlStateNormal];
        [bottomButton setBackgroundImage:[UIImage imageNamed:@"GB_cell_three_bottom_background.png"] forState:UIControlStateNormal];
        [bottomButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -170, 0, 0)];
        UIImageView *imageV3 = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"GB_cell_arrow.png"]];
        imageV3.backgroundColor = [UIColor clearColor];
        imageV3.frame = CGRectMake(245, 20, 10, 15);
        [bottomButton addSubview:imageV3];
        [_threeInfoView addSubview:topButton];
        [_threeInfoView addSubview:middleButton];
        [_threeInfoView addSubview:bottomButton];
        [topButton addTarget:self action:@selector(gotoVoucherInfo) forControlEvents:UIControlEventTouchUpInside];
        [middleButton addTarget:self action:@selector(gotoVoucherNotice) forControlEvents:UIControlEventTouchUpInside];
        [bottomButton addTarget:self action:@selector(gotoShopInfo) forControlEvents:UIControlEventTouchUpInside];
        
        TT_RELEASE_SAFELY(topButton);
        TT_RELEASE_SAFELY(middleButton);
        TT_RELEASE_SAFELY(bottomButton);
    }
    return _threeInfoView;
}

-(UIButton *)returnButton{
    if (!_returnButton) {
        _returnButton = [[UIButton alloc]init];
        [_returnButton setBackgroundImage: [UIImage imageNamed:@"GB_pay_submit.png"] forState:UIControlStateNormal];
        _returnButton.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
        [_returnButton setTitleColor:RGBCOLOR(55, 37, 5)forState:UIControlStateNormal];
        _returnButton.backgroundColor = [UIColor clearColor];
        [_returnButton setTitle:L(@"BTRefund") forState:UIControlStateNormal];
        [_returnButton addTarget:self action:@selector(returnOrder) forControlEvents:UIControlEventTouchUpInside];
    }
    return _returnButton;
}

- (UIButton *)payButton{
    if (!_payButton) {
        _payButton = [[UIButton alloc]init];
        [_payButton setBackgroundImage: [UIImage imageNamed:@"GB_pay_submit.png"] forState:UIControlStateNormal];
        _payButton.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
        [_payButton setTitleColor:RGBCOLOR(55, 37, 5)forState:UIControlStateNormal];
        _payButton.backgroundColor = [UIColor clearColor];
        [_payButton setTitle:L(@"BTPay") forState:UIControlStateNormal];
        [_payButton addTarget:self action:@selector(payOrder) forControlEvents:UIControlEventTouchUpInside];
    }
    return _payButton;
}

- (UIButton *)cancelButton{
    if (!_cancelButton){
        _cancelButton = [[UIButton alloc]init];
        _cancelButton.tag = 1105;
        _cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:18.0 ];
        [_cancelButton setBackgroundImage:[UIImage imageNamed:@"GB_order_cancel.png"] forState:UIControlStateNormal];
        _cancelButton.backgroundColor = [UIColor clearColor];
        [_cancelButton setTitleColor:RGBCOLOR(55, 37, 5) forState:UIControlStateNormal];
        [_cancelButton setTitle:L(@"BTOrderCancel") forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelOrder) forControlEvents:UIControlEventTouchUpInside];
    }
    return  _cancelButton;
}


- (void)gotoVoucherInfo{
    if (_delegate && [_delegate respondsToSelector:@selector(gotoVoucherInfo)]) {
        [_delegate gotoVoucherInfo];
    }
}

- (void)gotoVoucherNotice{
    if (_delegate && [_delegate respondsToSelector:@selector(gotoVoucherNotice)]) {
        [_delegate gotoVoucherNotice];
    }
}
- (void)gotoShopInfo{
    if (_delegate && [_delegate respondsToSelector:@selector(gotoShopInfo)]) {
        [_delegate gotoShopInfo];
    }
}

- (void)returnOrder{
    if (_delegate && [_delegate respondsToSelector:@selector(returnOrder)]) {
        [_delegate returnOrder];
    }
}

- (void)payOrder{
    [self.payButton setBackgroundImage: [UIImage imageNamed:@"GB_pay_submit.png"] forState:UIControlStateNormal];
    [self.cancelButton setBackgroundImage:[UIImage imageNamed:@"GB_order_cancel.png"] forState:UIControlStateNormal];
    if (_delegate &&[_delegate respondsToSelector:@selector(payOrder)]) {
        [_delegate payOrder];
    }
}

- (void)cancelOrder{
    [self.cancelButton setBackgroundImage: [UIImage imageNamed:@"GB_pay_submit.png"] forState:UIControlStateNormal];
    [self.payButton setBackgroundImage:[UIImage imageNamed:@"GB_order_cancel.png"] forState:UIControlStateNormal];
    if (_delegate && [_delegate respondsToSelector:@selector(cancelOrder)]) {
        [_delegate cancelOrder];
    }
}

- (void)setItem:(GBOrderInfoDTO *)item{
    if (_item != item) {
        _item = item;
        [self.contentView removeAllSubviews];
        tuanGouType = _item.gbType;
        orderStatus = _item.orderStatus;
        if (_item.gbType == 0 &&( _item.orderStatus != 1 && _item.orderStatus !=2)) {
            [self.contentView  addSubview:self.singleInfoView];
        }
        else if ((_item.gbType == 0 &&( _item.orderStatus == 1 || _item.orderStatus == 2)) || (_item.gbType == 1&&( _item.orderStatus!=1 && _item.orderStatus != 2))) {
            [self.contentView addSubview:self.doubleInfoView];
        }
        else if (_item.gbType == 1 && (_item.orderStatus ==1 || _item.orderStatus == 2)) {
            [self.contentView addSubview:self.threeInfoView];
        }
        
        if (_item.orderStatus == 0) {
            [self.contentView addSubview:self.payButton];
            [self.contentView addSubview:self.cancelButton];
        }
        [self setNeedsLayout];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    UIView *view = nil;
    if (tuanGouType == 0 && (orderStatus != 1 && orderStatus != 2)) {
        self.singleInfoView.frame = CGRectMake(0, 0, 320, 80);
        view = self.singleInfoView;
    }
    else if ((tuanGouType == 0 && (orderStatus == 1 || orderStatus == 2)) ||(tuanGouType == 1 && (orderStatus != 1 && orderStatus != 2))) {
        self.doubleInfoView.frame= CGRectMake(0, 0, 320, 120);
        view = self.doubleInfoView;
    }
    else if (tuanGouType == 1 && (orderStatus == 1 || orderStatus == 2)) {
        self.threeInfoView.frame = CGRectMake(0, 0, 320, 160);
        view = self.threeInfoView;
    }
    self.payButton.frame = CGRectMake(20, view.bottom+10, 130, 40);
    self.cancelButton.frame = CGRectMake(self.payButton.right+20, view.bottom+10, 130, 40);
}

+ (CGFloat)height:(GBOrderInfoDTO *)item
{
    if (item.gbType == 0 && (item.orderStatus != 1 && item.orderStatus != 2)) {
        return 160;
    }
    if ((item.gbType == 0 && (item.orderStatus == 1 || item.orderStatus == 2)) || (item.gbType == 1 && (item.orderStatus != 1 && item.orderStatus != 2))) {
        return 200;
    }
    if (item.gbType == 1 && (item.orderStatus == 1 || item.orderStatus == 2)) {
        return 240;
    }
    return 0;
    

}

@end
