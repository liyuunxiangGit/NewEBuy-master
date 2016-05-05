//
//  OrderCenterListCell.m
//  SuningEBuy
//
//  Created by lanfeng on 12-4-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "OrderCenterListCell.h"

@implementation OrderCenterListCell

@synthesize orderTypeLbl = _orderTypeLbl;
@synthesize orderNoLbl   = _orderNoLbl;
@synthesize unitLbl      = _unitLbl;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) 
    {
        self.orderTypeLbl.frame = CGRectMake(10, 0, 150, 48);
        self.orderNoLbl.frame = CGRectMake(150, 0, 100, 48);
        self.unitLbl.frame = CGRectMake(250, 0, 20, 48);
        self.backgroundColor = [UIColor cellBackViewColor];
    }
    return self;
}

- (void)dealloc {
    
    TT_RELEASE_SAFELY(_orderTypeLbl);
    TT_RELEASE_SAFELY(_orderNoLbl);
    TT_RELEASE_SAFELY(_unitLbl);
}

-(UILabel *)orderTypeLbl{
    if (_orderTypeLbl == nil) {
        _orderTypeLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 150, 48)];
        _orderTypeLbl.backgroundColor = [UIColor clearColor];
        _orderTypeLbl.font = [UIFont boldSystemFontOfSize:18.0];
        _orderTypeLbl.textColor = [UIColor colorWithRGBHex:0x4444444];//[UIColor darkTextColor];
        [self.contentView addSubview:_orderTypeLbl];
    }
    return _orderTypeLbl;
}


-(UILabel *)orderNoLbl{
    if (_orderNoLbl == nil) {
        _orderNoLbl = [[UILabel alloc]initWithFrame:CGRectMake(150, 0, 100, 48)];
        _orderNoLbl.backgroundColor = [UIColor clearColor];
        _orderNoLbl.font = [UIFont boldSystemFontOfSize:18.0];
        _orderNoLbl.text = @"";
        _orderNoLbl.textColor = [UIColor colorWithRGBHex:0xFF0000];//[UIColor colorWithRed:204/255.0 green:0 blue:0 alpha:1.0];
        _orderNoLbl.textAlignment = UITextAlignmentRight;
        [self.contentView addSubview:_orderNoLbl];
    }
    return _orderNoLbl;
}


-(UILabel *)unitLbl{
    if (_unitLbl == nil) {
        _unitLbl = [[UILabel alloc]initWithFrame:CGRectMake(250, 0, 20, 48)];
        _unitLbl.backgroundColor = [UIColor clearColor];
        _unitLbl.font = [UIFont boldSystemFontOfSize:18.0];
        _unitLbl.textColor = [UIColor colorWithRGBHex:0x444444];//[UIColor darkTextColor];
        _unitLbl.text =L(@"order number");
        [self.contentView addSubview:_unitLbl];
    }
    return _unitLbl;
}


@end
