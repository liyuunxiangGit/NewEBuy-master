//
//  LotteryDealsCell.m
//  SuningLottery
//
//  Created by lyywhg on 13-4-12.
//  Copyright (c) 2013年 suning. All rights reserved.
//

#import "LotteryDealsCell.h"

@implementation LotteryDealsCell

@synthesize logo = _logo;
@synthesize periods = _periods;
@synthesize boughtdate = _boughtdate;
@synthesize totalMoney = _totalMoney;
@synthesize state = _state;
@synthesize dealsType = _dealsType;
@synthesize cutline = _cutline;
@synthesize arrow = _arrow;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.logo];
        [self.contentView addSubview:self.periods];
        [self.contentView addSubview:self.boughtdate];
        [self.contentView addSubview:self.totalMoney];
        [self.contentView addSubview:self.state];
        [self.contentView addSubview:self.dealsType];
        [self.contentView addSubview:self.cutline];
        [self.contentView addSubview:self.arrow];
    }
    return self;
}

-(void)dealloc
{
    
    TT_RELEASE_SAFELY(_logo);
    TT_RELEASE_SAFELY(_periods);
    TT_RELEASE_SAFELY(_boughtdate);
    TT_RELEASE_SAFELY(_totalMoney);
    TT_RELEASE_SAFELY(_state);
    TT_RELEASE_SAFELY(_dealsType);
    TT_RELEASE_SAFELY(_cutline);
    TT_RELEASE_SAFELY(_arrow);
    
}

-(UIImageView *)logo
{
    if (!_logo) {
        _logo = [[UIImageView alloc]initWithFrame:CGRectMake(10,10, 40, 40)];
    }
    return _logo;
}

-(UILabel *)periods
{
    if (!_periods) {
        _periods = [[UILabel alloc]initWithFrame:CGRectMake(self.logo.right + 5, self.logo.origin.y + 5, 110, self.logo.height/2 -5)];
        _periods.backgroundColor = [UIColor clearColor];
        [_periods setFont:[UIFont systemFontOfSize:12]];
    }
    return _periods;
}

-(UILabel *)boughtdate
{
    if (!_boughtdate) {
        _boughtdate = [[UILabel alloc]initWithFrame:CGRectMake(self.periods.origin.x,self.periods.origin.y + self.periods.height+5,self.periods.width,self.periods.height)];
        _boughtdate.backgroundColor = [UIColor clearColor];
        [_boughtdate setFont:[UIFont systemFontOfSize:10]];
    }
    return _boughtdate;
}

-(UILabel *)totalMoney
{
    if (!_totalMoney) {
        _totalMoney = [[UILabel alloc]initWithFrame:CGRectMake(self.periods.right + 5, self.periods.origin.y, 50, self.periods.height)];
        _totalMoney.backgroundColor = [UIColor clearColor];
        [_totalMoney setFont:[UIFont systemFontOfSize:11]];
        _totalMoney.textAlignment = NSTextAlignmentCenter;
        _totalMoney.textColor = [UIColor redColor];
    }
    return _totalMoney;
}

-(UILabel *)state
{
    if (!_state) {
        _state = [[UILabel alloc]initWithFrame:CGRectMake(self.totalMoney.origin.x, self.totalMoney.origin.y + self.totalMoney.height + 5, 50, self.totalMoney.height)];
        _state.backgroundColor = [UIColor clearColor];
        _state.textAlignment = NSTextAlignmentCenter;
        [_state setFont:[UIFont systemFontOfSize:11]];
    }
    return _state;
}


-(UILabel *)dealsType
{
    if (!_dealsType) {
        _dealsType = [[UILabel alloc]initWithFrame:CGRectMake(self.totalMoney.right + 15, self.totalMoney.origin.y + self.totalMoney.height/2, 40, self.totalMoney.height)];
        _dealsType.backgroundColor = [UIColor clearColor];
        [_dealsType setFont:[UIFont systemFontOfSize:11]];
    }
    return _dealsType;
}

-(UIImageView *)cutline
{
    if(!_cutline)
    {
        _cutline = [[UIImageView alloc]init];
        [_cutline setImage:[UIImage imageNamed:@"mylottery_cutline.png"]];
        [_cutline setFrame:CGRectMake(0, self.height + 15, self.width, 2)];
    }
    return _cutline;
}

-(UIImageView *)arrow
{
    if (!_arrow) {
        _arrow = [[UIImageView alloc]init];
        UIImage *temp = [UIImage imageNamed:@"arrow.png"];
        [_arrow setSize:temp.size];
        [_arrow setOrigin:CGPointMake(self.dealsType.right +20, self.dealsType.origin.y + 5)];
        [_arrow setImage:temp];
    }
    return _arrow;
}


-(void)setItems:(id) dto
{
    if ([dto isKindOfClass:[LotteryDealsDto class]]) {
        //代购
        LotteryDealsDto *tempDto = (LotteryDealsDto *)dto;
        
        [self.logo setImage:[UIImage imageNamed:[NSString stringWithFormat:@"caipiao_%@.png",tempDto.gid]]];
        [self.periods setText:[NSString stringWithFormat:L(@"%@ issue"),tempDto.pid]];
        [self.boughtdate setText:tempDto.buyDate];
        [self.totalMoney setText:[NSString stringWithFormat:@"%@%@",tempDto.money,L(@"Constant_RMB")]];
        
        [self.state setText:tempDto.localState];
        
        [self.dealsType setText:L(@"Purchase")];
    }else if ([dto isKindOfClass:[LotteryDealsSerialNumberDto class]])
    {
        //追号
        LotteryDealsSerialNumberDto *tempDto = (LotteryDealsSerialNumberDto *)dto;
        [self.logo setImage:[UIImage imageNamed:[NSString stringWithFormat:@"caipiao_%@.png",tempDto.gid]]];
        [self.periods setText:[NSString stringWithFormat:@"%d/%@",[tempDto.success integerValue]+[tempDto.failure integerValue],tempDto.pnums]];
        [self.boughtdate setText:tempDto.adddate];
        [self.totalMoney setText:[NSString stringWithFormat:@"%@%@",tempDto.tmoney,L(@"Constant_RMB")]];
        
        [self.state setText:tempDto.localState];
        
        [self.dealsType setText:L(@"serialpurchasing")];
    }
}

@end
