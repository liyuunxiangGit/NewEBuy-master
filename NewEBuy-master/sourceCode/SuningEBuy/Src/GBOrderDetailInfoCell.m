//
//  GBWWOrderDetailCell.m
//  SuningEBuy
//
//  Created by 王 漫 on 13-3-1.
//  Copyright (c) 2013年 Suning. All rights reserved.
//
#import "GBOrderDetailInfoCell.h"
#define kOffsetContentLeft          20
#define kOffsetContentHight         25
#define kOffsetContentLength        85

#define kOffsetHight                25
#define kOffsetLength               280
#define kGBOrderDetailInfoCell_Height    220

@implementation GBOrderDetailInfoCell

@synthesize orderInfoContentLbl = _orderInfoContentLbl;

@synthesize orderNumberLbl =_orderNumberLbl;

@synthesize orderTimeLbl = _orderTimeLbl;


@synthesize orderNameLbl = _orderNameLbl;

@synthesize numLbl = _numLbl;

@synthesize priceLbl =_priceLbl;

@synthesize phoneLabel = _phoneLabel;

@synthesize orderStateLbl =_orderStateLbl;

@synthesize item = _item;

-(void)dealloc{
    
    TT_RELEASE_SAFELY(_item);
    TT_RELEASE_SAFELY(orderStateList);
    TT_RELEASE_SAFELY(_orderInfoContentLbl);
    
    TT_RELEASE_SAFELY(_orderNumberLbl);
    
    TT_RELEASE_SAFELY(_orderTimeLbl);
    
    TT_RELEASE_SAFELY(_orderNameLbl);
    
    TT_RELEASE_SAFELY(_numLbl);
    
    TT_RELEASE_SAFELY(_priceLbl);
    
    TT_RELEASE_SAFELY(_phoneLabel);
    
    TT_RELEASE_SAFELY(_orderStateLbl);
    
    TT_RELEASE_SAFELY(_btnImg);
    
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        orderStateList = [[NSMutableArray alloc]initWithObjects:L(@"PVWaitForPay"),L(@"PVPaid"),L(@"PVPaid"),L(@"PVCanceled"),L(@"PVRefunding"),L(@"PVRefunded"),L(@"PVCanceled"), nil];
    }
    return self;
}

- (UILabel *)orderInfoContentLbl{
    if (!_orderInfoContentLbl) {
        _orderInfoContentLbl = [[UILabel alloc]init];
        _orderInfoContentLbl.backgroundColor = [UIColor clearColor];
        _orderInfoContentLbl.font = [UIFont boldSystemFontOfSize:18];
        _orderInfoContentLbl.text = L(@"LBOrderInfo");
        [self.contentView addSubview:_orderInfoContentLbl];
    }
    return _orderInfoContentLbl;
}


- (UILabel *)orderNumberLbl{
    if (!_orderNumberLbl) {
        _orderNumberLbl = [[UILabel alloc]init];
        _orderNumberLbl.backgroundColor = [UIColor clearColor];
        _orderNumberLbl.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_orderNumberLbl];
    }
    return _orderNumberLbl;
}

-(UIImageView *)btnImg{
    
    if(!_btnImg){
        
        _btnImg = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"GB_cell_arrow.png"]];
        _btnImg.backgroundColor = [UIColor clearColor];
       // _btnImg.frame = CGRectMake(245, 20, 10, 15);
        
        [self.contentView addSubview:_btnImg];
    }
    
    return _btnImg;
}


- (UILabel *)orderTimeLbl{
    if (!_orderTimeLbl) {
        _orderTimeLbl = [[UILabel alloc]init];
        _orderTimeLbl.backgroundColor = [UIColor clearColor];
        _orderTimeLbl.font = [UIFont systemFontOfSize:14];
        _orderTimeLbl.numberOfLines = 0;
        [self.contentView addSubview:_orderTimeLbl];
    }
    return _orderTimeLbl;
}


- (UIButton *)orderNameLbl{
    if (!_orderNameLbl) {
        _orderNameLbl = [[UIButton alloc]init];
        _orderNameLbl.backgroundColor = [UIColor clearColor];
        _orderNameLbl.titleLabel.font = [UIFont systemFontOfSize: 14.0];
        [_orderNameLbl setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _orderNameLbl.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_orderNameLbl addTarget:self action:@selector(gotoGroupDetail) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_orderNameLbl];
    }
    return _orderNameLbl;
}



- (UILabel *)numLbl{
    if (!_numLbl) {
        _numLbl = [[UILabel alloc]init];
        _numLbl.backgroundColor = [UIColor clearColor];
        _numLbl.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_numLbl];
    }
    return _numLbl;
}



- (UILabel *)priceLbl{
    if (!_priceLbl) {
        _priceLbl = [[UILabel alloc]init];
        _priceLbl.backgroundColor = [UIColor clearColor];
        _priceLbl.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_priceLbl];
    }
    return _priceLbl;
}


- (UILabel *)phoneLabel{
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc]init];
        _phoneLabel.backgroundColor = [UIColor clearColor];
        _phoneLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_phoneLabel];
    }
    return _phoneLabel;
}



- (UILabel *)orderStateLbl{
    if (!_orderStateLbl) {
        _orderStateLbl = [[UILabel alloc]init];
        _orderStateLbl.backgroundColor = [UIColor clearColor];
        _orderStateLbl.font = [UIFont systemFontOfSize:14];
        _orderStateLbl.shadowColor = [UIColor whiteColor];
        _orderStateLbl.shadowOffset = CGSizeMake(1, 1);

        [self.contentView addSubview:_orderStateLbl];
    }
    return _orderStateLbl;
}

+(CGFloat)height:(GBOrderInfoDTO *)item{
    return kGBOrderDetailInfoCell_Height;
}

- (void)setItem:(GBOrderInfoDTO *)item{
    if (_item !=item) {
        TT_RELEASE_SAFELY(_item);
        _item = item;
    
    self.orderNumberLbl.text = [NSString stringWithFormat:@"%@%@",L(@"LBOrderCode"),item.orderId];
    self.orderTimeLbl.text = [NSString stringWithFormat:@"%@%@",L(@"LBOrderTime"),item.createTime];
    if (_item.gbType == 1) {

        [self.orderNameLbl setTitle:[NSString stringWithFormat:@"%@%@",L(@"LBProjectName"),item.hotelName] forState:UIControlStateNormal];

    }
    else{

        [self.orderNameLbl setTitle:[NSString stringWithFormat:@"%@%@",L(@"LBProjectName"),item.snProName] forState:UIControlStateNormal];
    }
    self.numLbl.text = [NSString stringWithFormat:@"%@%@",L(@"LBAmount2"),item.saleCount];
    self.priceLbl.text = [NSString stringWithFormat:@"%@%0.2f",L(@"LBCount"),[item.orderAmount floatValue]];
    self.phoneLabel.text = [NSString stringWithFormat:@"%@%@",L(@"LBInfoOfContact"),item.telephone];

        
    self.orderStateLbl.text = [NSString stringWithFormat:@"%@%@",L(@"LBOrderListStateChinese"),item.statusName];
    
    [self setNeedsLayout];
    }
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.orderInfoContentLbl.frame= CGRectMake(kOffsetContentLeft, 5, kOffsetContentLength, kOffsetHight);
    
    self.orderNumberLbl.frame = CGRectMake( kOffsetContentLeft, self.orderInfoContentLbl.bottom, kOffsetLength, kOffsetHight);
    
    self.orderTimeLbl.frame = CGRectMake(kOffsetContentLeft, self.orderNumberLbl.bottom, kOffsetLength, kOffsetHight);
    
    self.orderNameLbl.frame = CGRectMake(kOffsetContentLeft, self.orderTimeLbl.bottom, kOffsetLength-10, kOffsetHight);
    
    self.btnImg.frame = CGRectMake(self.orderNameLbl.right, self.orderTimeLbl.bottom+5, 10, 15);
    self.numLbl.frame = CGRectMake(kOffsetContentLeft, self.orderNameLbl.bottom, kOffsetLength, kOffsetHight);
    
    self.priceLbl.frame = CGRectMake(kOffsetContentLeft, self.numLbl.bottom, kOffsetLength, kOffsetHight);
    
    self.phoneLabel.frame = CGRectMake(kOffsetContentLeft,self.priceLbl.bottom, kOffsetLength, kOffsetHight);
    
        self.orderStateLbl.frame = CGRectMake(kOffsetContentLeft, self.phoneLabel.bottom, kOffsetLength, kOffsetHight);
    
}

-(void)gotoGroupDetail{
    
    if (_myDelegate && [_myDelegate respondsToSelector:@selector(gotoGroupDetail)]) {
        [_myDelegate gotoGroupDetail];
    }
}
@end
