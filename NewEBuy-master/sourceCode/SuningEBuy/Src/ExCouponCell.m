//
//  ExCouponCell.m
//  SuningEBuy
//
//  Created by david david on 12-6-21.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import "ExCouponCell.h"

#define LINE_SPACE  0
#define ROW_SPACE  20
#define LEFT_SPACE 10
#define LABEL_HEIGHT 26



@implementation ExCouponCell

@synthesize typeValueLbl = _typeValueLbl;

@synthesize saleMoneyLbl = _saleMoneyLbl;
@synthesize saleMoneyValueLbl = _saleMoneyValueLbl;

@synthesize changeMoneyLbl = _changeMoneyLbl;
@synthesize changeMoneyValueLbl = _changeMoneyValueLbl;

@synthesize startTimeLbl = _startTimeLbl;
@synthesize startTimeValueLbl = _startTimeValueLbl;

@synthesize endTimeLbl = _endTimeLbl;
@synthesize endTimeValueLbl = _endTimeValueLbl;

@synthesize operateTimeLbl = _operateTimeLbl;
@synthesize operateTimeValueLbl = _operateTimeValueLbl;

@synthesize commonLbl = _commonLbl;
@synthesize commonValueLbl = _commonValueLbl;


- (void)dealloc {
    
    TT_RELEASE_SAFELY(_typeValueLbl);
    TT_RELEASE_SAFELY(_saleMoneyLbl);
    TT_RELEASE_SAFELY(_saleMoneyValueLbl);
    TT_RELEASE_SAFELY(_changeMoneyLbl);
    TT_RELEASE_SAFELY(_changeMoneyValueLbl);
    TT_RELEASE_SAFELY(_startTimeLbl);
    TT_RELEASE_SAFELY(_startTimeValueLbl);
    TT_RELEASE_SAFELY(_endTimeLbl);
    TT_RELEASE_SAFELY(_endTimeValueLbl);
    TT_RELEASE_SAFELY(_operateTimeLbl);
    TT_RELEASE_SAFELY(_operateTimeValueLbl);
    
    
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.backgroundColor = [UIColor cellBackViewColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone; 
    }
    return self;
}


-(UILabel *)commonLbl{

    _commonLbl = [[UILabel alloc]init];
    
    _commonLbl.backgroundColor = [UIColor clearColor];
    
    _commonLbl.font = [UIFont systemFontOfSize:12.0];
    
    _commonLbl.textColor = [UIColor grayColor];
        
    return _commonLbl;
}

-(UILabel *)commonValueLbl{
    
    _commonValueLbl = [[UILabel alloc]init];
    
    _commonValueLbl.backgroundColor = [UIColor clearColor];
    
    _commonValueLbl.font = [UIFont systemFontOfSize:12.0];
    
    _commonValueLbl.textColor= [UIColor grayColor];
    
    return _commonValueLbl;
}


-(UILabel *)typeValueLbl{
    
    if (!_typeValueLbl) {
        
        _typeValueLbl = [self commonValueLbl];
        
        _typeValueLbl.frame = CGRectMake(LEFT_SPACE, 0, 200, LABEL_HEIGHT);
        
        [self.contentView addSubview:_typeValueLbl];
    }
    
    return _typeValueLbl;
}


-(UILabel *)saleMoneyLbl{
    
    if (!_saleMoneyLbl) {
        
        _saleMoneyLbl = [self commonLbl];
        
        _saleMoneyLbl.frame = CGRectMake(LEFT_SPACE, self.typeValueLbl.bottom+LINE_SPACE, 100, LABEL_HEIGHT);
        
        [self.contentView addSubview:_saleMoneyLbl];
    }
    
    return _saleMoneyLbl;
}


-(UILabel *)saleMoneyValueLbl{
    
    if (!_saleMoneyValueLbl) {
        
        _saleMoneyValueLbl = [self commonValueLbl];
        
        _saleMoneyValueLbl.frame = CGRectMake(self.saleMoneyLbl.right+ROW_SPACE,  self.typeValueLbl.bottom+LINE_SPACE, 200, LABEL_HEIGHT);
        
        [self.contentView addSubview:_saleMoneyValueLbl];
    }
    
    return _saleMoneyValueLbl;
}

-(UILabel *)changeMoneyLbl{
    
    if (!_changeMoneyLbl) {
        
        _changeMoneyLbl = [self commonLbl];
        
        _changeMoneyLbl.frame = CGRectMake(LEFT_SPACE, self.saleMoneyLbl.bottom+LINE_SPACE, 100, LABEL_HEIGHT);
        
        [self.contentView addSubview:_changeMoneyLbl];
    }
    
    return _changeMoneyLbl;
}


-(UILabel *)changeMoneyValueLbl{
    
    if (!_changeMoneyValueLbl) {
        
        _changeMoneyValueLbl = [self commonValueLbl];
        
        _changeMoneyValueLbl.frame = CGRectMake(self.changeMoneyLbl.right+ROW_SPACE, self.saleMoneyLbl.bottom+LINE_SPACE, 200, LABEL_HEIGHT);
        
        [self.contentView addSubview:_changeMoneyValueLbl];
    }
    
    return _changeMoneyValueLbl;
}


-(UILabel *)startTimeLbl{
    
    if (!_startTimeLbl) {
        
        _startTimeLbl = [self commonLbl];
        
        _startTimeLbl.frame = CGRectMake(LEFT_SPACE, self.changeMoneyLbl.bottom+LINE_SPACE, 100, LABEL_HEIGHT);
        
        [self.contentView addSubview:_startTimeLbl];
    }
    
    return _startTimeLbl;
}


-(UILabel *)startTimeValueLbl{
    
    if (!_startTimeValueLbl) {
        
        _startTimeValueLbl = [self commonValueLbl];
        
        _startTimeValueLbl.frame = CGRectMake(self.startTimeLbl.right+ROW_SPACE, self.changeMoneyLbl.bottom+LINE_SPACE, 200, LABEL_HEIGHT);
        
        [self.contentView addSubview:_startTimeValueLbl];
    }
    
    return _startTimeValueLbl;
}

-(UILabel *)endTimeLbl{
    
    if (!_endTimeLbl) {
        
        _endTimeLbl = [self commonLbl];
        
        _endTimeLbl.frame = CGRectMake(LEFT_SPACE, self.startTimeLbl.bottom+LINE_SPACE, 100, LABEL_HEIGHT);
        
        [self.contentView addSubview:_endTimeLbl];
    }
    
    return _endTimeLbl;
}


-(UILabel *)endTimeValueLbl{
    
    if (!_endTimeValueLbl) {
        
        _endTimeValueLbl = [self commonValueLbl];
        
        _endTimeValueLbl.frame = CGRectMake(self.endTimeLbl.right+ROW_SPACE, self.startTimeLbl.bottom+LINE_SPACE, 200, LABEL_HEIGHT);
        
        [self.contentView addSubview:_endTimeValueLbl];
    }
    
    return _endTimeValueLbl;
}

-(UILabel *)operateTimeLbl{
    
    if (!_operateTimeLbl) {
        
        _operateTimeLbl = [self commonLbl];
        
        _operateTimeLbl.frame = CGRectMake(LEFT_SPACE, self.endTimeLbl.bottom+LINE_SPACE, 100, LABEL_HEIGHT);
        
        [self.contentView addSubview:_operateTimeLbl];
    }
    
    return _operateTimeLbl;
}


-(UILabel *)operateTimeValueLbl{
    
    if (!_operateTimeValueLbl) {
        
        _operateTimeValueLbl = [self commonValueLbl];
        
        _operateTimeValueLbl.frame = CGRectMake(self.operateTimeLbl.right+ROW_SPACE, self.endTimeLbl.bottom+LINE_SPACE, 200, LABEL_HEIGHT);
        
        [self.contentView addSubview:_operateTimeValueLbl];
    }
    
    return _operateTimeValueLbl;
}


-(void)setItem:(ExCouponDto *)dto{
    
    if (dto == nil) {
        
        return;
    }
        
    self.typeValueLbl.text =IsStrEmpty(dto.billType)?@"---":dto.billType;// dto.billType == nil?@"":dto.billType;
    
    self.saleMoneyLbl.text = L(@"MyEBuy_SalesAmount");

    if (dto.sellMoney || [dto.sellMoney isEqualToString:@""]) {
        
        NSString *saleMoney = [NSString stringWithFormat:@"%@%@",dto.sellMoney,L(@"Constant_RMB")];
        
        self.saleMoneyValueLbl.text = saleMoney;

    }else{
    
        self.saleMoneyValueLbl.text = @"--";
    }
    
    
    self.changeMoneyLbl.text = L(@"MyEBuy_ChangeAmount");
    
    if (dto.batchMoney || [dto.batchMoney isEqualToString:@""]) {
        
        NSString *batchMoney = [NSString stringWithFormat:@"%@%@",dto.batchMoney,L(@"Constant_RMB")];
        
        self.changeMoneyValueLbl.text = batchMoney;
        
    }else{
        
        self.changeMoneyValueLbl.text = @"--";
    }
    
    self.startTimeLbl.text = L(@"MyEBuy_StartDate");
    
    self.startTimeValueLbl.text = IsStrEmpty(dto.beginDate)?@"---":dto.beginDate;//dto.beginDate == nil?@"":dto.beginDate;
    
    self.endTimeLbl.text = L(@"MyEBuy_Deadlines");
    
    self.endTimeValueLbl.text =IsStrEmpty(dto.endDate)?@"---":dto.endDate;// dto.endDate == nil?@"":dto.endDate;
    
    self.operateTimeLbl.text = L(@"MyEBuy_OperationDate");
    
    self.operateTimeValueLbl.text = IsStrEmpty(dto.processTime)?@"---":dto.processTime;// dto.processTime == nil?@"":dto.processTime;

}

+(CGFloat)height{

    return LABEL_HEIGHT*6;
}

@end
