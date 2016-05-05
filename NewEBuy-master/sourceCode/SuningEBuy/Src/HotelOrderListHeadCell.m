//
//  HotelOrderListHeadCell.m
//  SuningEBuy
//
//  Created by Qin on 14-2-14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "HotelOrderListHeadCell.h"
#import "HotelOrderListDto.h"
@implementation HotelOrderListHeadCell

@synthesize dto=_dto;
@synthesize orderNumLbl=_orderNumLbl;
@synthesize dateLbl=_dateLbl;
//@synthesize bottomLineView=_bottomLineView;
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
-(void)setCellWithDto:(HotelOrderListDto*)dto
{
    
}
-(UILabel*)orderNumLbl
{
    if (!_orderNumLbl) {
        _orderNumLbl=[[UILabel alloc] initWithFrame:CGRectMake(15, 13.5, 145, 13)];
        _orderNumLbl.textColor=[UIColor colorWithRGBHex:0x313131];
        _orderNumLbl.backgroundColor = [UIColor clearColor];
        
        _orderNumLbl.font = [UIFont systemFontOfSize:13];
        
        _orderNumLbl.textAlignment = UITextAlignmentLeft;
    }
    return _orderNumLbl;
}
-(UILabel*)dateLbl
{
    if (!_dateLbl) {
        _dateLbl=[[UILabel alloc] initWithFrame:CGRectMake(170, 13.5, 145, 13)];
        _dateLbl.textColor=[UIColor dark_Gray_Color];
        _dateLbl.backgroundColor = [UIColor clearColor];
        
        _dateLbl.font = [UIFont systemFontOfSize:13];
        
        _dateLbl.textAlignment = UITextAlignmentRight;
    }
    return _dateLbl;
}
//-(UIImageView*)bottomLineView
//{
//    if (!_bottomLineView) {
//        _bottomLineView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 39, 320, 1)];
//        UIImage* img=[UIImage newImageFromResource:@"category_cellSeparatorLine.png"];
//        [_bottomLineView setImage:img];
//    }
//    return _bottomLineView;
//}
- (NSDateFormatter *)dateFormatterServer
{
    NSDateFormatter *_dateFormatter = [[NSDateFormatter alloc] init];
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [_dateFormatter setLocale:locale];
    
    [_dateFormatter setDateFormat:@"MMM dd, yyyy hh:mm:ss a"];
    
    return _dateFormatter;
}

- (NSDateFormatter *)dateFormatterClient
{
    NSDateFormatter *_dateFormatter = [[NSDateFormatter alloc] init];
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [_dateFormatter setLocale:locale];
    
    [_dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    return _dateFormatter;
}
-(void)setHeadCellWithDto:(HotelOrderListDto *)dto
{
    if (dto==nil) {
        return;
    }
    self.dto=dto;
    
    [self.contentView addSubview:self.orderNumLbl];
    [self.contentView addSubview:self.dateLbl];
//    [self.contentView addSubview:self.bottomLineView];
    
//    self.bottomLineView.top=self.bottom-1;
    self.orderNumLbl.text=[NSString stringWithFormat:@"%@%@",L(@"BTOrderCode"),_dto.orderNO];
    
    
    if (_dto.timer) {
        NSDate *date = [[self dateFormatterServer] dateFromString:_dto.timer];
        NSString *dateString = [[self dateFormatterClient] stringFromDate:date];
        
        NSString *yearStr = [dateString substringWithRange:NSMakeRange(0, 4)];
        NSString *mouthStr = [dateString substringWithRange:NSMakeRange(5, 2)];
        NSString *dayStr = [dateString substringWithRange:NSMakeRange(8, 2)];
        self.dateLbl.text=[NSString stringWithFormat:@"%@/%@/%@",yearStr,mouthStr,dayStr];
    }
}
@end
