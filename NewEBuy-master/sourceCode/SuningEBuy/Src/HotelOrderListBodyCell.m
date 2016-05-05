//
//  HotelOrderListBodyCell.m
//  SuningEBuy
//
//  Created by Qin on 14-2-14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "HotelOrderListBodyCell.h"

@implementation HotelOrderListBodyCell

@synthesize dto=_dto;
@synthesize nameLbl=_nameLbl;
@synthesize countLbl=_countLbl;
@synthesize priceLbl=_priceLbl;
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
-(UIImageView*)topLineView
{
    if (_topLineView==nil) {
        _topLineView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
        UIImage* img=[UIImage newImageFromResource:@"category_cellSeparatorLine.png"];
        [_topLineView setImage:img];
    }
    return _topLineView;
}
-(UILabel*)nameLbl
{
    if (!_nameLbl) {
        _nameLbl = [[UILabel alloc]init];
        _nameLbl.backgroundColor = [UIColor clearColor];
        _nameLbl.font = [UIFont systemFontOfSize:13];
        _nameLbl.textColor = [UIColor colorWithRGBHex:0x313131];
        _nameLbl.numberOfLines = 2;
        _nameLbl.lineBreakMode = UILineBreakModeTailTruncation;
    }
    return _nameLbl;
}
-(UILabel*)priceLbl
{
    if (!_priceLbl) {
        _priceLbl = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 125, 20)];
        _priceLbl.backgroundColor = [UIColor clearColor];
        _priceLbl.font = [UIFont systemFontOfSize:14];
        _priceLbl.textAlignment=NSTextAlignmentLeft;
        _priceLbl.textColor = [UIColor orange_Red_Color];
    }
    return _priceLbl;
}
-(UILabel*)countLbl
{
    if (!_countLbl) {
        _countLbl = [[UILabel alloc]initWithFrame:CGRectMake(155, 0, 150, 20)];
        _countLbl.textAlignment=UITextAlignmentRight;
        _countLbl.backgroundColor = [UIColor clearColor];
        _countLbl.font = [UIFont systemFontOfSize:14];
        _countLbl.textColor = [UIColor dark_Gray_Color];
    }
    return _countLbl;
}


-(void)setBodyCellWithDto:(HotelOrderListDto*)dto
{
    if (dto==nil) {
        return;
    }
    self.dto=dto;
    
    float nameLblHeight=[HotelOrderListBodyCell nameLblHeight:_dto.hotelName];
    self.nameLbl.frame=CGRectMake(15, 15, 290, nameLblHeight);
    self.priceLbl.top=self.nameLbl.bottom+5;
    self.countLbl.top=self.priceLbl.top;
    
    self.nameLbl.text=_dto.hotelName;
    double singglePrice=[_dto.totalPrice doubleValue]/[_dto.number intValue];
    self.priceLbl.text=[NSString stringWithFormat:@"￥%.2f",singglePrice];
    
    self.countLbl.text=[NSString stringWithFormat:@"%@ %@",L(@"Number:"),_dto.number];
    
    
    [self.contentView addSubview:self.nameLbl];
    [self.contentView addSubview:self.priceLbl];
    [self.contentView addSubview:self.countLbl];
    [self.contentView addSubview:self.topLineView];
}
+(float)nameLblHeight:(NSString*)string
{
    CGSize size=[string sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(290, 40) lineBreakMode:UILineBreakModeCharacterWrap];//最多2行
    return size.height;
}
+(float)cellHeightWithDto:(HotelOrderListDto*)dto
{
    return 15+[self nameLblHeight:dto.hotelName]+25+10;
}
@end
