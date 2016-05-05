//
//  PayInfoCell.m
//  SuningEBuy
//
//  Created by Qin on 14-2-19.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "PayInfoCell.h"

@implementation PayInfoCell

@synthesize dto=_dto;

@synthesize payType=_payType;
@synthesize payLbl=_payLbl;
@synthesize dayPrice=_dayPrice;
@synthesize priceLbl=_priceLbl;

//@synthesize topLine=_topLine;
//@synthesize bottomLine=_bottomLine;

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
-(UILabel*)payType{
    if (_payType==nil) {
        _payType=[[UILabel alloc] initWithFrame:CGRectMake(15,10,140, 20)];
        _payType.backgroundColor=[UIColor clearColor];
        _payType.textColor=[UIColor light_Black_Color];
        _payType.font=[UIFont systemFontOfSize:15];
        _payType.text =  L(@"payType");
        [self.contentView addSubview:_payType];
    }
    return _payType;
}

-(UILabel*)payLbl{
    if (_payLbl==nil) {
        _payLbl=[[UILabel alloc] initWithFrame:CGRectMake(170,10,135, 20)];
        _payLbl.backgroundColor=[UIColor clearColor];
        _payLbl.textColor=[UIColor light_Black_Color];
        _payLbl.font=[UIFont systemFontOfSize:15];
        _payLbl.textAlignment=UITextAlignmentRight;
        [self.contentView addSubview:_payLbl];
    }
    return _payLbl;
}
-(UILabel*)dayPrice{
    if (_dayPrice==nil) {
        _dayPrice=[[UILabel alloc] initWithFrame:CGRectMake(15,10,140, 20)];
        _dayPrice.backgroundColor=[UIColor clearColor];
        _dayPrice.textColor=[UIColor dark_Gray_Color];
        _dayPrice.font=[UIFont systemFontOfSize:13];
        _dayPrice.text =  L(@"dataPrice");
        [self.contentView addSubview:_dayPrice];
    }
    return _dayPrice;
}
-(UILabel*)priceLbl{
    if (_priceLbl==nil) {
        _priceLbl=[[UILabel alloc] initWithFrame:CGRectMake(170,10,135, 20)];
        _priceLbl.backgroundColor=[UIColor clearColor];
        _priceLbl.textColor=[UIColor orange_Red_Color];
        _priceLbl.font=[UIFont systemFontOfSize:13];
        _priceLbl.textAlignment=UITextAlignmentRight;
        [self.contentView addSubview:_priceLbl];
    }
    return _priceLbl;
}

//-(UIImageView*)topLine
//{
//    if (_topLine==nil) {
//        _topLine=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.5)];
//        
//        UIImage* img=[UIImage newImageFromResource:@"category_cellSeparatorLine.png"];
//        [_topLine setImage:img];
//        
//        return _topLine;
//    }
//    return _topLine;
//}
-(void)setPayInfoCellWithDto:(HotelOrderDetailDTO*)dto
{
    if (!dto) {
        return;
    }
    self.dto=dto;
    
    self.payType.top=10;
    self.payLbl.top=10;
    
    self.payLbl.text=_dto.payType;
    [self.payLbl setFrame:CGRectMake(170,10,135, 30)];
    
    self.priceLbl.text=[NSString stringWithFormat:@"￥%.2f",[_dto.datePrice doubleValue]];
    
    self.dayPrice.top=self.payType.bottom+10;
    self.priceLbl.top=self.dayPrice.top;
    self.priceLbl.textColor=[UIColor orange_Red_Color];
    
//    UIImageView* topLine=[self newLineImageView];
//    topLine.top=0.5;
//    [self.contentView addSubview:topLine];
//    
//    UIImageView* bottomLine=[self newLineImageView];
//    bottomLine.top=0.5;
//    [self.contentView addSubview:bottomLine];
    
}
@end
