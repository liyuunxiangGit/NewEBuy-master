//
//  HotelOrderInfoCell.m
//  SuningEBuy
//
//  Created by Qin on 14-2-19.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "HotelOrderInfoCell.h"

@implementation HotelOrderInfoCell

@synthesize dto=_dto;

@synthesize orderNum=_orderNum;
@synthesize orderNumLbl=_orderNumLbl;
@synthesize orderTime=_orderTime;
@synthesize orderTimeLbl=_orderTimeLbl;
@synthesize orderState=_orderState;
@synthesize orderStateLbl=_orderStateLbl;
@synthesize orderNumLine=_orderNumLine;
@synthesize orderTimeLine=_orderTimeLine;
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
-(UILabel*)orderNum{
    if (_orderNum==nil) {
        _orderNum=[[UILabel alloc] initWithFrame:CGRectMake(15,10,100, 20)];
        _orderNum.backgroundColor=[UIColor clearColor];
        _orderNum.textColor=[UIColor light_Black_Color];
        _orderNum.font=[UIFont systemFontOfSize:15];
        _orderNum.text = L(@"order ID");
        [self.contentView addSubview:_orderNum];
    }
    return _orderNum;
}
-(UILabel*)orderNumLbl{
    if (_orderNumLbl==nil) {
        _orderNumLbl=[[UILabel alloc] initWithFrame:CGRectMake(130,10,185, 20)];
        _orderNumLbl.backgroundColor=[UIColor clearColor];
        _orderNumLbl.textColor=[UIColor light_Black_Color];
        _orderNumLbl.font=[UIFont systemFontOfSize:15];
        _orderNumLbl.textAlignment=UITextAlignmentRight;
        [self.contentView addSubview:_orderNumLbl];
    }
    return _orderNumLbl;
}
-(UILabel*)orderTime{
    if (_orderTime==nil) {
        _orderTime=[[UILabel alloc] initWithFrame:CGRectMake(15,10,100, 20)];
        _orderTime.backgroundColor=[UIColor clearColor];
        _orderTime.textColor=[UIColor light_Black_Color];
        _orderTime.font=[UIFont systemFontOfSize:15];
        _orderTime.text =  L(@"orderTimer");
        [self.contentView addSubview:_orderTime];
    }
    return _orderTime;
}
-(UILabel*)orderTimeLbl{
    if (_orderTimeLbl==nil) {
        _orderTimeLbl=[[UILabel alloc] initWithFrame:CGRectMake(130,10,185, 20)];
        _orderTimeLbl.backgroundColor=[UIColor clearColor];
        _orderTimeLbl.textColor=[UIColor light_Black_Color];
        _orderTimeLbl.font=[UIFont systemFontOfSize:15];
        _orderTimeLbl.textAlignment=UITextAlignmentRight;
        [self.contentView addSubview:_orderTimeLbl];
    }
    return _orderTimeLbl;
}
-(UILabel*)orderState{
    if (_orderState==nil) {
        _orderState=[[UILabel alloc] initWithFrame:CGRectMake(15,10,100, 20)];
        _orderState.backgroundColor=[UIColor clearColor];
        _orderState.textColor=[UIColor light_Black_Color];
        _orderState.font=[UIFont systemFontOfSize:15];
        _orderState.text =  L(@"Order Status");
        [self.contentView addSubview:_orderState];
    }
    return _orderState;
}
-(UILabel*)orderStateLbl{
    if (_orderStateLbl==nil) {
        _orderStateLbl=[[UILabel alloc] initWithFrame:CGRectMake(130,10,185, 20)];
        _orderStateLbl.backgroundColor=[UIColor clearColor];
        _orderStateLbl.textColor=[UIColor light_Black_Color];
        _orderStateLbl.font=[UIFont systemFontOfSize:15];
        _orderStateLbl.textAlignment=UITextAlignmentRight;
        [self.contentView addSubview:_orderStateLbl];
    }
    return _orderStateLbl;
}

-(UIImageView*)orderNumLine
{
    if (_orderNumLine==nil) {
        _orderNumLine=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.5)];
        
        UIImage* img=[UIImage newImageFromResource:@"category_cellSeparatorLine.png"];
        [_orderNumLine setImage:img];
        
        [self.contentView addSubview:_orderNumLine];
    }
    return _orderNumLine;
}
-(UIImageView*)orderTimeLine
{
    if (_orderTimeLine==nil) {
        _orderTimeLine=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.5)];
        
        UIImage* img=[UIImage newImageFromResource:@"category_cellSeparatorLine.png"];
        [_orderTimeLine setImage:img];
        
        [self.contentView addSubview:_orderTimeLine];
    }
    return _orderTimeLine;
}
-(void)setHotelOrderInfoCellWithDto:(HotelOrderDetailDTO*)dto
{
    if (dto==nil) {
        return;
    }
    self.dto=dto;
    
    self.orderNum.top=10;
    self.orderNumLbl.top=10;
    self.orderNumLbl.text=_dto.orderNO;
    
    self.orderNumLine.top=self.orderNum.bottom+10;

    
    self.orderTime.top=self.orderNum.bottom+20;
    self.orderTimeLbl.top=self.orderTime.top;
    self.orderTimeLbl.text=_dto.bookingTime;
    
    self.orderTimeLine.top=self.orderTimeLbl.bottom+10;
    
    self.orderState.top=self.orderTime.bottom+20;
    self.orderStateLbl.top=self.orderState.top;
    self.orderStateLbl.text=_dto.orderStatus;
}
@end
