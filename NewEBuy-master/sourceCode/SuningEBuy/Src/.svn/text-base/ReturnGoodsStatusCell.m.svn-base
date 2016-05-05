//
//  ReturnGoodsStatusCell.m
//  SuningEBuy
//
//  Created by 漫 王 on 12-9-29.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "ReturnGoodsStatusCell.h"

#import "ReturnGoodsStatusDTO.h"

@implementation ReturnGoodsStatusCell

@synthesize time = _time;

@synthesize record = _record;

@synthesize item = _item;

- (void)dealloc {
    
    TT_RELEASE_SAFELY(_time);
    
    TT_RELEASE_SAFELY(_record);
    
    TT_RELEASE_SAFELY(_item);
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
		
        self.backgroundColor = [UIColor clearColor];
        
		self.autoresizesSubviews = YES;
        
    }
    return self;
}

- (UILabel *)time
{
    
    if (!_time)
    {
        _time = [[UILabel alloc] init];
        
        _time.backgroundColor = [UIColor clearColor];
        
        _time.font = [UIFont systemFontOfSize:14.0];
        
        _time.numberOfLines = 0;
        
        _time.textAlignment = UITextAlignmentLeft;
        
        [self.contentView addSubview:_time];
    }
    
    return _time;
}

- (UILabel  *)record
{
    
    if (!_record) {
        _record = [[UILabel alloc] init];
        _record.backgroundColor = [UIColor clearColor];
        _record.font = [UIFont systemFontOfSize:14.0];
        _record.numberOfLines = 0;
        
        [self.contentView addSubview:_record];
        
    }
    return _record;
}

- (UIImageView *)statusPoint
{
    if (!_statusPoint) {
        _statusPoint = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 15, 15)];
        _statusPoint.image = [UIImage imageNamed:@"Service_Detail_List_Cell_Point.png"];
        
        [self.contentView addSubview:_statusPoint];
    }
    return _statusPoint;
}

- (UIImageView *)statusLine
{
    if (!_statusLine) {
        _statusLine = [[UIImageView alloc] init];
        
        _statusLine.image = [UIImage imageNamed:@"Service_Detail_List_Cell_Line.png"];
        
        
        [self.contentView addSubview:_statusLine];
    }
    return _statusLine;
}


+ (CGFloat)height:(ReturnGoodsStatusDTO *)dto
{
    NSString *status1 = @"";
    NSString *status2 = @"";
    status1 = dto.returnRecord;
    status2 = dto.returnTime;


    UIFont *font = [UIFont systemFontOfSize:14.0];
    
    CGSize infoSize = [status1 sizeWithFont:font constrainedToSize:CGSizeMake(239.5, 1000) lineBreakMode:UILineBreakModeWordWrap];
    
    CGSize infoSize1 = [status2 sizeWithFont:font constrainedToSize:CGSizeMake(239.5, 1000) lineBreakMode:UILineBreakModeWordWrap];
    return   infoSize.height+infoSize1.height+20;
}

- (void)setReturnTimeAndRecord:(ReturnGoodsStatusDTO *)dto1 WithRow:(int)row
{
    
    if(IsNilOrNull(dto1))
    {
        return;
    }
    
    CGFloat cellHeight = [ReturnGoodsStatusCell height:dto1];
    if(row == -1)
    {
        self.record.textColor = [UIColor dark_Gray_Color];
        self.time.textColor = [UIColor dark_Gray_Color];
        
        self.statusPoint.frame = CGRectMake(20, 10, 15, 15);
        self.statusLine.frame = CGRectMake(25, 0, 5, 10);
    }
    else if(row == -2)
    {
        self.record.textColor = [UIColor colorWithRGBHex:0xff7700];
        self.time.textColor = [UIColor colorWithRGBHex:0xff7700];
        
        self.statusPoint.image = [UIImage imageNamed:@"Service_Detail_List_Cell_Hollow_Point.png"];
        self.statusLine.frame = CGRectMake(25, 24, 5, 0);
    }
    else if(row == 0)
    {
        self.record.textColor = [UIColor colorWithRGBHex:0xff7700];
        self.time.textColor = [UIColor colorWithRGBHex:0xff7700];
        
        self.statusPoint.image = [UIImage imageNamed:@"Service_Detail_List_Cell_Hollow_Point.png"];
        self.statusLine.frame = CGRectMake(25, 24, 5, cellHeight);

    }
    else
    {
        self.record.textColor = [UIColor dark_Gray_Color];
        self.time.textColor = [UIColor dark_Gray_Color];
        
        self.statusPoint.frame = CGRectMake(20, 10, 15, 15);
        self.statusLine.frame = CGRectMake(25, 0, 5, cellHeight);
        
    }
    
    NSString *status1 = @"";
    NSString *status2 = @"";
    status1 = dto1.returnRecord;
    status2 = dto1.returnTime;

    UIFont *font = [UIFont systemFontOfSize:14.0];
    
    CGSize infoSize = [status1 sizeWithFont:font constrainedToSize:CGSizeMake(239.5, 1000) lineBreakMode:UILineBreakModeWordWrap];
    
    self.record.frame = CGRectMake(50, 10, 239.5, infoSize.height);
    
    self.record.text = status1;
    CGSize infoSize1 = [status2 sizeWithFont:font constrainedToSize:CGSizeMake(239.5, 1000) lineBreakMode:UILineBreakModeCharacterWrap];
    
    self.time.frame = CGRectMake(50,10 + infoSize.height , 239.5, infoSize1.height);
    
    self.time.text = status2;
    
}


- (void)layoutSubviews{
    
    [super layoutSubviews];
        
}


@end
