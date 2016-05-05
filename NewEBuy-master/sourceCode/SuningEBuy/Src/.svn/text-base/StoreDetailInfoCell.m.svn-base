//
//  StoreDetailInfoCell.m
//  SuningEBuy
//
//  Created by JackyWu on 14-8-6.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "StoreDetailInfoCell.h"

@interface StoreDetailInfoCell()
{
    NSIndexPath   *_selfIndexPath;
}

@end

@implementation StoreDetailInfoCell

- (UILabel *)titleLbl
{
    if(_titleLbl == nil)
    {
        _titleLbl = [[UILabel alloc]init];
        
        _titleLbl.backgroundColor = [UIColor clearColor];
        
        _titleLbl.textColor = [UIColor colorWithRGBHex:0x313131];
        
        _titleLbl.numberOfLines = 0;
        
        _titleLbl.contentMode = UIViewContentModeTop;
        
        _titleLbl.font = [UIFont systemFontOfSize:15];
        
        _titleLbl.frame = CGRectMake(16, 0, 80, self.height);
        
        _titleLbl.textAlignment = UITextAlignmentLeft;
        
        [self.contentView addSubview:_titleLbl];
    }
    return _titleLbl;
}

-(UILabel*)detailLbl
{
    if(_detailLbl == nil)
    {
        _detailLbl = [[UILabel alloc]init];
        
        _detailLbl.backgroundColor = [UIColor clearColor];
        
        _detailLbl.textColor = [UIColor colorWithRGBHex:0x707070];
        
        _detailLbl.numberOfLines = 0;
        
        _detailLbl.contentMode = UIViewContentModeTop;
        
        _detailLbl.font = [UIFont systemFontOfSize:13];
        
        _detailLbl.frame = CGRectMake(96, 0, 210, self.height);
        
        [self.contentView addSubview:_detailLbl];
    }
    
    return _detailLbl;
}

- (UIImageView *)line
{
    if (!_line)
    {
        _line = [[UIImageView alloc]init];
        
        _line.frame = CGRectMake(0, self.height-1, 320, 1);
        
        _line.backgroundColor = [UIColor clearColor];
        
        _line.image = [UIImage streImageNamed:@"line"];
        
        [self.contentView addSubview:_line];
    }
    return _line;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.titleLbl.frame = CGRectMake(16, 0, 270, self.height);
    
    self.detailLbl.frame = CGRectMake(96, 0, 210, self.height);
    
    if (_selfIndexPath.row == 0)
    {
        self.line.frame = CGRectMake(0, self.height-1, 320, 1);
        
    }else if (_selfIndexPath.row == 1)
    {
        self.line.frame = CGRectMake(0, self.height-1, 320, 1);
        
    }else if (_selfIndexPath.row == 2)
    {
        self.line.frame = CGRectMake(0, self.height-1, 320, 1);
        
    }else if (_selfIndexPath.row ==3)
    {
        self.line.frame = CGRectMake(0, self.height-1, 320, 1);
        
    }else if (_selfIndexPath.row == 4)
    {
        self.line.frame = CGRectMake(0, self.height-1, 320, 1);
        
    }else if (_selfIndexPath.row == 5)
    {
        self.line.frame = CGRectMake(0, self.height-1, 320, 1);
        
    }else if (_selfIndexPath.row == 6)
    {
        self.line.frame = CGRectMake(0, self.height-1, 320, 1);
        
    }else if (_selfIndexPath.row == 7)
    {
        self.line.frame = CGRectMake(0, self.height-1, 320, 1);
        
    }
    
}

- (void)setItem:(SuningStoreDetailInfoDTO *)dto withRow:(NSInteger)row
{
    if (row == 0)
    {
        self.titleLbl.text = L(@"NearbySuning_FloorInfo");
        if (IsStrEmpty(dto.floorInfo))
        {
            self.detailLbl.text = L(@"NearbySuning_NoRelatedInfo");
        }
        else
        {
            NSArray *arr =[dto.floorInfo componentsSeparatedByString:@";"];
            NSMutableString *str = [[NSMutableString alloc]init];
            for (int i = 0; i < [arr count]-1; i++) {
                if (i == [arr count]-2) {
                    [str appendFormat:@"%@",[arr objectAtIndex:i]];
                }
                else{
                    [str appendFormat:@"%@\n",[arr objectAtIndex:i]];
                }
            }
            self.detailLbl.text = str;
        }
        
    }else if (row == 1)
    {
        self.titleLbl.text = L(@"NearbySuning_BusinessHours");
        NSString *workdayBeginTime = [[NSString alloc]init];
        NSString *workdayEndTime = [[NSString alloc]init];
        NSString *weekendBeginTime = [[NSString alloc]init];
        NSString *weekendEndTime = [[NSString alloc]init];
        if (IsStrEmpty(dto.workdayBeginTime) && IsStrEmpty(dto.workdayEndTime) && IsStrEmpty(dto.weekendBeginTime) && IsStrEmpty(dto.weekendEndTime)) {
            self.detailLbl.text = L(@"NearbySuning_NoRelatedInfo");
        }
        else{
            if (IsStrEmpty(dto.workdayBeginTime)) {
                workdayBeginTime = [NSString stringWithFormat:@"%@",@"    "];
            }else{
                NSArray *arr =[dto.workdayBeginTime componentsSeparatedByString:@":"];
                if ([arr count]>=2) {
                    workdayBeginTime = [NSString stringWithFormat:@"%@:%@",[arr objectAtIndex:0],[arr objectAtIndex:1]];
                }else{
                    workdayBeginTime = [NSString stringWithFormat:@"%@",[arr objectAtIndex:0]];
                }
            }
            if (IsStrEmpty(dto.workdayEndTime)) {
                workdayEndTime = [NSString stringWithFormat:@"%@",@""];
            }else{
                NSArray *arr =[dto.workdayEndTime componentsSeparatedByString:@":"];
                if ([arr count]>=2) {
                    workdayEndTime = [NSString stringWithFormat:@"%@:%@",[arr objectAtIndex:0],[arr objectAtIndex:1]];
                }else{
                    workdayEndTime = [NSString stringWithFormat:@"%@",[arr objectAtIndex:0]];
                }
            }
            if (IsStrEmpty(dto.weekendBeginTime)) {
                weekendBeginTime = [NSString stringWithFormat:@"%@",@"    "];
            }else{
                NSArray *arr =[dto.weekendBeginTime componentsSeparatedByString:@":"];
                if ([arr count]>=2) {
                    weekendBeginTime = [NSString stringWithFormat:@"%@:%@",[arr objectAtIndex:0],[arr objectAtIndex:1]];
                }else{
                    weekendBeginTime = [NSString stringWithFormat:@"%@",[arr objectAtIndex:0]];
                }
            }
            if (IsStrEmpty(dto.weekendEndTime)) {
                weekendEndTime = [NSString stringWithFormat:@"%@",@""];
            }else{
                NSArray *arr =[dto.weekendEndTime componentsSeparatedByString:@":"];
                if ([arr count]>=2) {
                    weekendEndTime = [NSString stringWithFormat:@"%@:%@",[arr objectAtIndex:0],[arr objectAtIndex:1]];
                }else{
                    weekendEndTime = [NSString stringWithFormat:@"%@",[arr objectAtIndex:0]];
                }
            }
            NSString *str = [NSString stringWithFormat:@"%@%@-%@\n%@%@-%@",L(@"NearbySuning_NormalTime1"),workdayBeginTime,workdayEndTime,L(@"NearbySuning_WeekendTime1"),weekendBeginTime,weekendEndTime];
            self.detailLbl.text = str;
        }
        
    }else if (row == 2)
    {
        self.titleLbl.text = L(@"NearbySuning_Address");
        self.detailLbl.text = !IsStrEmpty(dto.address)?dto.address:L(@"NearbySuning_NoRelatedInfo");
        
    }else if (row == 3)
    {
        self.titleLbl.text = L(@"NearbySuning_BusRoute");
        if (IsStrEmpty(dto.busLine)) {
            self.detailLbl.text = L(@"NearbySuning_NoRelatedInfo");
        }else{
            NSString *str = [NSString stringWithFormat:@"%@",dto.busLine];
            self.detailLbl.text = str;
        }
        
    }else if (row == 4)
    {
        self.titleLbl.text =L(@"NearbySuning_UnderLineRoute");
        if (IsStrEmpty(dto.subwayDetail)) {
            self.detailLbl.text = L(@"NearbySuning_NoRelatedInfo");
        }else{
            NSString *str = [NSString stringWithFormat:@"%@",dto.subwayDetail];
            self.detailLbl.text = str;
        }
        
    }else if (row == 5)
    {
        self.titleLbl.text =L(@"NearbySuning_ParkingLot");
        self.detailLbl.text = !IsStrEmpty(dto.parkDetail)?dto.parkDetail:L(@"NearbySuning_NoRelatedInfo");
        
    }else if ( row == 6)
    {
        self.titleLbl.text=L(@"NearbySuning_Telphone");
        if (IsStrEmpty(dto.telephone)) {
            self.detailLbl.text = L(@"NearbySuning_NoRelatedInfo");
        }else{
            NSString *str = [NSString stringWithFormat:@"%@%@",L(@"NearbySuning_ServiceTel"),dto.telephone];
            self.detailLbl.text = str;
        }
        
    }
        
    self.line.hidden =NO;
}

+ (float)height:(SuningStoreDetailInfoDTO *)dto withRow:(NSInteger)row
{
    if (row ==0 && !IsStrEmpty(dto.floorInfo))
    {
        NSArray *arr =[dto.floorInfo componentsSeparatedByString:@";"];
        NSMutableString *str = [[NSMutableString alloc]init];
        for (int i = 0; i < [arr count]-1; i++) {
            if (i == [arr count]-2) {
                [str appendFormat:@"%@",[arr objectAtIndex:i]];
            }
            else{
                [str appendFormat:@"%@\n",[arr objectAtIndex:i]];
            }
        }
        CGSize size = [str sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(210, 350)];
        float height = size.height>60?size.height:60;
        return height;

    }else if (row == 1 && !IsStrEmpty(dto.workdayBeginTime) && !IsStrEmpty(dto.workdayEndTime) && !IsStrEmpty(dto.weekendBeginTime) && !IsStrEmpty(dto.weekendEndTime))
    {
        NSString *str = [NSString stringWithFormat:@"%@%@-%@\n%@%@-%@",L(@"NearbySuning_NormalTime1"),dto.workdayBeginTime,dto.workdayEndTime,L(@"NearbySuning_WeekendTime1"),dto.weekendBeginTime,dto.weekendEndTime];
        CGSize size = [str sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(210, 200)];
        float height = size.height>60?size.height:60;
        return height;
        
    }else if (row == 2 && !IsStrEmpty(dto.address))
    {
        CGSize size = [dto.address sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(210, 200)];
        float height = size.height>60?size.height:60;
        return height;
        
    }else if (row == 3 && !IsStrEmpty(dto.busLine))
    {
        NSString *str = [NSString stringWithFormat:@"%@%@",L(@"NearbySuning_Bus"),dto.busLine];
        CGSize size = [str sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(210, 200)];
        float height = size.height>60?size.height:60;
        return height;
        
    }else if (row == 4 && !IsStrEmpty(dto.subwayDetail))
    {
        NSString *str = [NSString stringWithFormat:@"%@%@",L(@"NearbySuning_UnderLine"),dto.subwayDetail];
        CGSize size = [str sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(210, 200)];
        float height = size.height>60?size.height:60;
        return height;
        
    }else if (row == 5 && !IsStrEmpty(dto.parkDetail))
    {
        CGSize size = [dto.parkDetail sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(210, 200)];
        float height = size.height>60?size.height:60;
        return height;
        
    }else if (row == 6 && !IsStrEmpty(dto.telephone))
    {
        NSString *str = [NSString stringWithFormat:@"%@%@",L(@"NearbySuning_ServiceTel"),dto.telephone];
        CGSize size = [str sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(210, 200)];
        float height = size.height>60?size.height:60;
        return height;
        
    }
    
    return 60;
}


@end
