//
//  PlaneOrderInfoCell.m
//  SuningEBuy
//
//  Created by david on 14-2-17.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "PlaneOrderInfoCell.h"

#define UILABLE_FONT    [UIFont systemFontOfSize:15]
#define leftPadding     15
#define topPadding      20


@interface PlaneOrderInfoCell()

@property(nonatomic,strong)UIView       *whiteBackView;
@property(nonatomic,strong)UILabel      *orderNumLbl;
@property(nonatomic,strong)UILabel      *orderNumValLbl;
@property(nonatomic,strong)UILabel      *createTimeLbl;
@property(nonatomic,strong)UILabel      *createTimeValLbl;
@property(nonatomic,strong)UILabel      *orderStatusLbl;
@property(nonatomic,strong)UILabel      *orderStatusValLbl;

@end


@implementation PlaneOrderInfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        self.backgroundView = nil;
    }
    return self;
}

+(CGFloat)height{
    
    return 120;
}

-(void)refreshCell:(PFOrderDetailDTO *)dto{
    
    if (dto == nil) return;

    self.whiteBackView.frame = CGRectMake(0, topPadding, 320, 100);
    
    //订单号
    self.orderNumLbl.frame = CGRectMake(leftPadding, topPadding+5, 80, 30);
    self.orderNumValLbl.frame = CGRectMake(_orderNumLbl.right, _orderNumLbl.top, (320-leftPadding-_orderNumLbl.right), 30);
    self.orderNumValLbl.text = dto.orderId;
    
    //下单时间
    self.createTimeLbl.frame = CGRectMake(leftPadding, _orderNumLbl.bottom, 80, 30);
    self.createTimeValLbl.frame = CGRectMake(_createTimeLbl.right, _createTimeLbl.top, (320-leftPadding-_createTimeLbl.right), 30);
    self.createTimeValLbl.text = dto.creatTime;
    
    //订单状态
    self.orderStatusLbl.frame = CGRectMake(leftPadding, _createTimeLbl.bottom, 80, 30);
    self.orderStatusValLbl.frame = CGRectMake(_orderStatusLbl.right, _orderStatusLbl.top, (320-leftPadding-_orderStatusLbl.right), 30);
    self.orderStatusValLbl.text = dto.orderStatusRemark?dto.orderStatusRemark:@"--";
    
}

#pragma mark -
#pragma mark UIView
-(UIView *)whiteBackView{
    if (!_whiteBackView) {
        _whiteBackView = [[UIView alloc]init];
        _whiteBackView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_whiteBackView];
    }
    return _whiteBackView;
}


-(UILabel *)orderNumLbl{
    if (!_orderNumLbl) {
        _orderNumLbl = [[UILabel alloc]init];
        _orderNumLbl.backgroundColor = [UIColor clearColor];
        _orderNumLbl.font = UILABLE_FONT;
        _orderNumLbl.text = L(@"orderNumber");
        [self.contentView addSubview:_orderNumLbl];
    }
    return _orderNumLbl;
}

-(UILabel *)orderNumValLbl{
    if (!_orderNumValLbl) {
        _orderNumValLbl = [[UILabel alloc]init];
        _orderNumValLbl.backgroundColor = [UIColor clearColor];
        _orderNumValLbl.font = UILABLE_FONT;
        _orderNumValLbl.textAlignment = UITextAlignmentRight;
        [self.contentView addSubview:_orderNumValLbl];
    }
    return _orderNumValLbl;
}


-(UILabel *)createTimeLbl{
    if (!_createTimeLbl) {
        _createTimeLbl = [[UILabel alloc]init];
        _createTimeLbl.backgroundColor = [UIColor clearColor];
        _createTimeLbl.font = UILABLE_FONT;
        _createTimeLbl.text = L(@"orderTimer");
        [self.contentView addSubview:_createTimeLbl];
    }
    return _createTimeLbl;
}

-(UILabel *)createTimeValLbl{
    if (!_createTimeValLbl) {
        _createTimeValLbl = [[UILabel alloc]init];
        _createTimeValLbl.backgroundColor = [UIColor clearColor];
        _createTimeValLbl.font = UILABLE_FONT;
        _createTimeValLbl.textAlignment = UITextAlignmentRight;
        [self.contentView addSubview:_createTimeValLbl];
    }
    return _createTimeValLbl;
}

-(UILabel *)orderStatusLbl{
    if (!_orderStatusLbl) {
        _orderStatusLbl = [[UILabel alloc]init];
        _orderStatusLbl.backgroundColor = [UIColor clearColor];
        _orderStatusLbl.font = UILABLE_FONT;
        _orderStatusLbl.text = L(@"orderStatus");
        [self.contentView addSubview:_orderStatusLbl];
    }
    return _orderStatusLbl;
}

-(UILabel *)orderStatusValLbl{
    if (!_orderStatusValLbl) {
        _orderStatusValLbl = [[UILabel alloc]init];
        _orderStatusValLbl.backgroundColor = [UIColor clearColor];
        _orderStatusValLbl.font = UILABLE_FONT;
        _orderStatusValLbl.textAlignment = UITextAlignmentRight;
        [self.contentView addSubview:_orderStatusValLbl];
    }
    return _orderStatusValLbl;
}

@end
