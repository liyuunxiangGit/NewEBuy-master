//
//  AirLineCell.m
//  SuningEBuy
//
//  Created by david on 14-2-16.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "AirLineCell.h"
#import "AirlineInfoDTO.h"

#define topPadding      20
#define leftPadding     15
#define cellHeight      170

@interface AirLineCell()

@property(nonatomic,strong) UIView      *whiteBackView;
@property(nonatomic,strong) UILabel     *airlineLbl;
@property(nonatomic,strong) UILabel     *dateLbl;
@property(nonatomic,strong) UILabel     *useTimeLbl;
@property(nonatomic,strong) UILabel     *companyLbl;
@property(nonatomic,strong) UILabel     *startLbl;
@property(nonatomic,strong) UILabel     *startTimeLbl;
@property(nonatomic,strong) UILabel     *endLbl;
@property(nonatomic,strong) UILabel     *endTimeLbl;
@property(nonatomic,strong) UIButton    *button;

@end


@implementation AirLineCell

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

+(CGFloat)height:(PFOrderDetailDTO *)dto{
    
    if (dto == nil) {
        return 0;
    }
    
    return cellHeight;
}

-(void)refreshCell:(PFOrderDetailDTO *)dto index:(NSInteger)index{

    if (dto == nil || [dto.airLineInfoArray count] <= index) return;
    
    //白色背景
    self.whiteBackView.frame = CGRectMake(0, topPadding, 320, cellHeight-topPadding);
    
    AirlineInfoDTO *info = [dto.airLineInfoArray objectAtIndex:index];
    
    infoDto = info;
    
    //航线
    self.airlineLbl.frame = CGRectMake(leftPadding, topPadding+5, 200, 30);
    NSString *tmpStr = [NSString stringWithFormat:@"%@-%@【%@】",info.startCityName,info.arriveCityName,info.airlineType];
    self.airlineLbl.text = tmpStr;
    
    //航班日期
    self.dateLbl.frame = CGRectMake(_airlineLbl.right, _airlineLbl.top, (320-leftPadding-_airlineLbl.right), 30);
    if (info.startTime.length > 10) {
        NSString *tmpStr = [info.startTime substringToIndex:10];
        self.dateLbl.text = tmpStr;
    }else{
        self.dateLbl.text = tmpStr;
    }

    //航空公司
    self.companyLbl.frame = CGRectMake(leftPadding, _airlineLbl.bottom, 180, 30);
    self.companyLbl.text = info.airlineComName;
    
    //耗时
    self.useTimeLbl.frame = CGRectMake(_companyLbl.right, _companyLbl.top, (320-leftPadding-_companyLbl.right), 30);
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *startDate = nil;
    NSDate *arriveDate = nil;
    if (info.startTime.length > 19) {
        NSString *tmpStr = [info.startTime substringToIndex:19];
        startDate = [formatter dateFromString:tmpStr];
    }else{
        startDate = [formatter dateFromString:info.startTime];
    }
    if (info.arriveTime.length > 19) {
        NSString *tmpStr = [info.arriveTime substringToIndex:19];
        arriveDate = [formatter dateFromString:tmpStr];
    }else{
        arriveDate = [formatter dateFromString:info.arriveTime];
    }
    
    NSTimeInterval userTime = [arriveDate timeIntervalSinceDate:startDate];
    int hour = userTime/3600;
    int minute = (userTime-hour*3600)/60;
    self.useTimeLbl.text = [NSString stringWithFormat:L(@"BTAboutHourMinute"),hour,minute];
    
    //起飞时间
    self.startLbl.frame = CGRectMake(leftPadding, _companyLbl.bottom, 40, 30);
    self.startTimeLbl.frame = CGRectMake(_startLbl.right, _startLbl.top, 180, 30);
    if (info.startTime.length > 16) {
        NSString *tmpStr = [info.startTime substringWithRange:NSMakeRange(11, 5)];
        self.startTimeLbl.text = [NSString stringWithFormat:@"%@ %@",tmpStr,info.startAirport];
    }else{
        self.startTimeLbl.text = [NSString stringWithFormat:@"%@ %@",info.startTime,info.startAirport];
    }
    
    //降落时间
    self.endLbl.frame = CGRectMake(leftPadding, _startLbl.bottom, 40, 30);
    self.endTimeLbl.frame = CGRectMake(_endLbl.right, _endLbl.top, 180, 30);
    if (info.startTime.length > 16) {
        NSString *tmpStr = [info.arriveTime substringWithRange:NSMakeRange(11, 5)];
        self.endTimeLbl.text = [NSString stringWithFormat:@"%@ %@",tmpStr,info.arriveAirport];
    }else{
        self.endTimeLbl.text = [NSString stringWithFormat:@"%@ %@",info.arriveTime,info.arriveAirport];
    }
    
    //退改签按钮
    self.button.frame = CGRectMake(_startTimeLbl.right, _startLbl.top+15, 80, 30);
    
}

#pragma mark -
#pragma mark 退改签按钮被点击
-(void)buttonTouched{
    
    if ([_delegate respondsToSelector:@selector(airlineCell:airlineInfo:)]) {
        
        [_delegate airlineCell:self airlineInfo:infoDto];
    }
}

#pragma mark -
#pragma mark UIView
-(UIView *)whiteBackView{
    if (_whiteBackView == nil) {
        _whiteBackView = [[UIView alloc]init];
        _whiteBackView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_whiteBackView];
    }
    return _whiteBackView;
}

-(UILabel *)airlineLbl{
    if (_airlineLbl == nil) {
        _airlineLbl = [[UILabel alloc]init];
        _airlineLbl.backgroundColor = [UIColor clearColor];
        _airlineLbl.font = [UIFont boldSystemFontOfSize:16];
        [self.contentView addSubview:_airlineLbl];
    }
    return _airlineLbl;
}

-(UILabel *)dateLbl{
    if (_dateLbl == nil) {
        _dateLbl = [[UILabel alloc]init];
        _dateLbl.backgroundColor = [UIColor clearColor];
        _dateLbl.font = [UIFont systemFontOfSize:14];
        _dateLbl.textAlignment = UITextAlignmentRight;
        [self.contentView addSubview:_dateLbl];
    }
    return _dateLbl;
}


-(UILabel *)useTimeLbl{
    if (_useTimeLbl == nil) {
        _useTimeLbl = [[UILabel alloc]init];
        _useTimeLbl.backgroundColor = [UIColor clearColor];
        _useTimeLbl.font = [UIFont systemFontOfSize:14];
        _useTimeLbl.textAlignment = UITextAlignmentRight;
        [self.contentView addSubview:_useTimeLbl];
    }
    return _useTimeLbl;
}

-(UILabel *)companyLbl{
    if (_companyLbl == nil) {
        _companyLbl = [[UILabel alloc]init];
        _companyLbl.backgroundColor = [UIColor clearColor];
        _companyLbl.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_companyLbl];
    }
    return _companyLbl;
}

-(UILabel *)startLbl{
    if (_startLbl == nil) {
        _startLbl = [[UILabel alloc]init];
        _startLbl.backgroundColor = [UIColor clearColor];
        _startLbl.font = [UIFont systemFontOfSize:14];
        _startLbl.text = L(@"BTFly2");
        [self.contentView addSubview:_startLbl];
    }
    return _startLbl;
}

-(UILabel *)startTimeLbl{
    if (_startTimeLbl == nil) {
        _startTimeLbl = [[UILabel alloc]init];
        _startTimeLbl.backgroundColor = [UIColor clearColor];
        _startTimeLbl.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_startTimeLbl];
    }
    return _startTimeLbl;
}

-(UILabel *)endLbl{
    if (_endLbl == nil) {
        _endLbl = [[UILabel alloc]init];
        _endLbl.backgroundColor = [UIColor clearColor];
        _endLbl.font = [UIFont systemFontOfSize:14];
        _endLbl.text = L(@"BTLand2");
        [self.contentView addSubview:_endLbl];
    }
    return _endLbl;
}

-(UILabel *)endTimeLbl{
    if (_endTimeLbl == nil) {
        _endTimeLbl = [[UILabel alloc]init];
        _endTimeLbl.backgroundColor = [UIColor clearColor];
        _endTimeLbl.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_endTimeLbl];
    }
    return _endTimeLbl;
}

-(UIButton *)button{
    if (!_button) {
        
        _button = [UIButton buttonWithType:UIButtonTypeCustom];

        UIImage *buttonImageNormal = [UIImage imageNamed:@"orange_button.png"];
        UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:0 topCapHeight:0];
        [_button setBackgroundImage:stretchableButtonImageNormal
                              forState:UIControlStateNormal];
        
        UIImage *buttonImagePressed = [UIImage imageNamed:@"orange_button_clicked.png"];
        UIImage *stretchableButtonImagePressed = [buttonImagePressed stretchableImageWithLeftCapWidth:0 topCapHeight:0];
        [_button setBackgroundImage:stretchableButtonImagePressed forState:UIControlStateHighlighted];
        
        [_button setTitle:L(@"BTEndorse") forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _button.titleLabel.font = [UIFont systemFontOfSize:15.0];

        [_button addTarget:self action:@selector(buttonTouched) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_button];
    }
    return _button;
}

@end
