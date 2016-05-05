//
//  HotelOrderListFootCell.m
//  SuningEBuy
//
//  Created by Qin on 14-2-14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "HotelOrderListFootCell.h"

@implementation HotelOrderListFootCell

@synthesize dto=_dto;
@synthesize countLbl=_countLbl;
@synthesize priceLbl=_priceLbl;
@synthesize statusLbl=_statusLbl;
@synthesize topLineView=_topLineView;
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
-(UILabel*)countLbl
{
    if (!_countLbl) {
        _countLbl=[[UILabel alloc] initWithFrame:CGRectMake(15, 5, 40, 40)];
        _countLbl.textColor=[UIColor light_Black_Color];
        _countLbl.backgroundColor = [UIColor clearColor];
        
        _countLbl.font = [UIFont systemFontOfSize:13];
        
        _countLbl.textAlignment = UITextAlignmentLeft;
    }
    return _countLbl;
}
-(UILabel*)priceLbl
{
    if (!_priceLbl) {
        _priceLbl=[[UILabel alloc] initWithFrame:CGRectMake(55, 5, 100, 40)];
        _priceLbl.textColor = [UIColor orange_Red_Color];
        
        _priceLbl.backgroundColor = [UIColor clearColor];
        
        _priceLbl.font = [UIFont systemFontOfSize:13];
        
        _priceLbl.textAlignment = UITextAlignmentLeft;
    }
    return _priceLbl;
}
-(UILabel*)statusLbl
{
    if (!_statusLbl) {
        _statusLbl=[[UILabel alloc] initWithFrame:CGRectMake(180, 5, 125, 40)];
        
        _statusLbl.backgroundColor = [UIColor clearColor];
        
        _statusLbl.font = [UIFont systemFontOfSize:13];
        
        _statusLbl.textAlignment = UITextAlignmentRight;
        
        _statusLbl.textColor=[UIColor dark_Gray_Color];
        
    }
    return _statusLbl;
}
-(UIImageView*)topLineView
{
    if (_topLineView==nil) {
        _topLineView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
        UIImage* img=[UIImage newImageFromResource:@"category_cellSeparatorLine.png"];
        [_topLineView setImage:img];
    }
    return _topLineView;
}

-(void)setFootCellWithDto:(HotelOrderListDto *)dto
{
    if (dto==nil) {
        return;
    }
    self.dto=dto;
    
    [self.contentView addSubview:self.countLbl];
    [self.contentView addSubview:self.priceLbl];
    [self.contentView addSubview:self.statusLbl];
    [self.contentView addSubview:self.topLineView];
    
    self.countLbl.text=L(@"BTTotal2");
    self.priceLbl.text=[NSString stringWithFormat:@"¥ %.2f",[_dto.totalPrice floatValue]];
    self.statusLbl.text=_dto.status;
}
@end
