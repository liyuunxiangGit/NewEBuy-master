//
//  LotteryOrderListCell.m
//  SuningEBuy
//
//  Created by david david on 12-7-3.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import "LotteryOrderListCell.h"

@interface LotteryOrderListCell()

-(NSString *)returnOrderStatus;

@end

@implementation LotteryOrderListCell

@synthesize lotteryImageView = _lotteryImageView;
@synthesize lotteryNameLbl = _lotteryNameLbl;
@synthesize lotteryTimesLbl = _lotteryTimesLbl;
@synthesize buyDateLbl = _buyDateLbl;
@synthesize moneyLbl = _moneyLbl;
@synthesize statusLbl = _statusLbl;
@synthesize orderDto = _orderDto;
@synthesize cellSeparatedImageView = _cellSeparatedImageView;

- (void)dealloc {
    
    TT_RELEASE_SAFELY(_lotteryImageView);
    
    TT_RELEASE_SAFELY(_lotteryNameLbl);
    
    TT_RELEASE_SAFELY(_lotteryTimesLbl);
    
    TT_RELEASE_SAFELY(_buyDateLbl);
    
    TT_RELEASE_SAFELY(_moneyLbl);
    
    TT_RELEASE_SAFELY(_statusLbl);
    
    TT_RELEASE_SAFELY(_orderDto);
    TT_RELEASE_SAFELY(_cellSeparatedImageView);
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

-(void)setItem:(LotteryOrderDto *)dto{
    
    if (dto == nil) {
        return;
    }
    
    self.orderDto = dto;
    
    //    self.lotteryImageView.frame = CGRectMake(20, 5, 40, 40); 
    //    self.lotteryNameLbl.frame = CGRectMake(10, self.lotteryImageView.bottom, 60, 25);
    self.lotteryTimesLbl.frame = CGRectMake(self.lotteryImageView.right+30, 5, 100, 30);
    self.buyDateLbl.frame = CGRectMake(self.lotteryImageView.right+30, self.lotteryTimesLbl.bottom+5, 80, 30);
    self.moneyLbl.frame = CGRectMake(self.lotteryTimesLbl.right+60, 5, 80, 30);
    self.statusLbl.frame = CGRectMake(self.lotteryTimesLbl.right+60, self.moneyLbl.bottom+5, 80, 30);
    self.cellSeparatedImageView.frame=CGRectMake(0, 78, 320, 2);
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if ([self isNullOrEmpty:self.orderDto.gid]) {
        
        NSString *imageName = [NSString stringWithFormat:@"caipiao_%@",self.orderDto.gid];
        
        UIImage *image = [UIImage imageNamed:imageName];
        
        self.lotteryImageView.image = image;
    }
    
    if ([self.orderDto.gid isEqualToString:@"01"]) {
        
        self.lotteryNameLbl.text = L(@"DoubleColor ball");
        
    }else if([self.orderDto.gid isEqualToString:@"50"]){
        
        self.lotteryNameLbl.text = L(@"BigLotto");
    }else{
        
        self.lotteryNameLbl.text = @"";
    }
    
    if ([self isNullOrEmpty:self.orderDto.pid]) {
        
        self.lotteryTimesLbl.text = [NSString stringWithFormat:L(@"%@ issue"),self.orderDto.pid];
        
    }
    
    if ([self isNullOrEmpty:self.orderDto.buyDate]) {
        
        self.buyDateLbl.text = self.orderDto.buyDate;
        
    }
    
    if ([self isNullOrEmpty:self.orderDto.money]) {
        
        double money = [self.orderDto.money doubleValue];
        
        self.moneyLbl.text = [NSString stringWithFormat:@"%0.2f%@",money,L(@"Constant_RMB")];
        self.moneyLbl.textColor = [UIColor redColor];
    }
    
    self.statusLbl.text = [self returnOrderStatus];
    
    if ([[self returnOrderStatus]isEqualToString:L(@"Hit the jackpot")]) {
        
        self.statusLbl.textColor = [UIColor redColor];
    }else{
        self.statusLbl.textColor = [UIColor darkGrownColor];
    }
    
}


-(UIImageView *)lotteryImageView{
    
    if (_lotteryImageView == nil) {
        
        _lotteryImageView = [[UIImageView alloc]init];
        
        [self.contentView addSubview:_lotteryImageView];
        
        _lotteryImageView.backgroundColor = [UIColor clearColor];
        
    }
    
    return _lotteryImageView;
    
}

-(UILabel *)lotteryNameLbl{
    
    if (_lotteryNameLbl == nil) {
        
        _lotteryNameLbl = [[UILabel alloc]init];
        
        _lotteryNameLbl.backgroundColor = [UIColor clearColor];
        
        _lotteryNameLbl.font = [UIFont systemFontOfSize:14.0];
        
        _lotteryNameLbl.textColor = [UIColor darkGrownColor];
        
        _lotteryNameLbl.textAlignment = UITextAlignmentCenter;
        
        [self.contentView addSubview:_lotteryNameLbl];
        
    }
    
    return _lotteryNameLbl;
}


-(UILabel *)lotteryTimesLbl{
    
    if (_lotteryTimesLbl == nil) {
        
        _lotteryTimesLbl = [[UILabel alloc]init];
        
        _lotteryTimesLbl.backgroundColor = [UIColor clearColor];
        
        _lotteryTimesLbl.font = [UIFont boldSystemFontOfSize:14.0];
        
        _lotteryTimesLbl.textColor = [UIColor darkGrownColor];
        
        [self.contentView addSubview:_lotteryTimesLbl];
        
    }
    
    return _lotteryTimesLbl;
}

-(UILabel *)buyDateLbl{
    
    if (_buyDateLbl == nil) {
        
        _buyDateLbl = [[UILabel alloc]init];
        
        _buyDateLbl.backgroundColor = [UIColor clearColor];
        
        _buyDateLbl.font = [UIFont systemFontOfSize:14.0];
        
        _buyDateLbl.textColor = [UIColor darkGrownColor];
        
        _buyDateLbl.textAlignment = UITextAlignmentCenter;
        
        [self.contentView addSubview:_buyDateLbl];
        
    }
    
    return _buyDateLbl;
}

-(UILabel *)moneyLbl{
    
    if (_moneyLbl == nil) {
        
        _moneyLbl = [[UILabel alloc]init];
        
        _moneyLbl.backgroundColor = [UIColor clearColor];
        
        _moneyLbl.font = [UIFont boldSystemFontOfSize:14.0];
        
        _moneyLbl.textColor = [UIColor redColor];
        
        [self.contentView addSubview:_moneyLbl];
        
    }
    
    return _moneyLbl;
}


-(UILabel *)statusLbl{
    
    if (_statusLbl == nil) {
        
        _statusLbl = [[UILabel alloc]init];
        
        _statusLbl.backgroundColor = [UIColor clearColor];
        
        _statusLbl.font = [UIFont systemFontOfSize:14.0];
        
        _statusLbl.textColor = [UIColor darkGrownColor];
        
        [self.contentView addSubview:_statusLbl];
        
    }
    
    return _statusLbl;
}

-(UIImageView *)cellSeparatedImageView{ 
    
    if (_cellSeparatedImageView == nil) {
        
        _cellSeparatedImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 48, 320, 2)];
        
        _cellSeparatedImageView.backgroundColor = [UIColor clearColor];
        
        UIImage *image = [UIImage imageNamed:@"splitLine.png"];
        
        _cellSeparatedImageView.image = image;
        [self.contentView addSubview:_cellSeparatedImageView];
        
    }
    
    return _cellSeparatedImageView;
}


/*
 * YES:不为空
 * NO:为空或者为nil
 */
-(BOOL)isNullOrEmpty:(NSString *)string{
    
    if (!string) {
        
        return NO;
        
    }else if([string isEqualToString:@""]){
        
        return NO;
    }
    
    return YES;
}

#pragma mark - compute order status 判断订单状态
-(NSString *)returnOrderStatus{
    
    if ([self.orderDto.pay isEqualToString:@"-1"]) {
        
        return L(@"Payment failure");
        
    }else{
        
        if ([self.orderDto.cancel isEqualToString:@"0"]) {
            
            if ([self.orderDto.isReturn isEqualToString:@"2"]) {
                
                if ([self.orderDto.rmoney intValue] > 0) {
                    
                    return L(@"Hit the jackpot");
                    
                }else{
                    
                    return L(@"Not hit the jackpot");
                }
            }else{
                
                return L(@"Unsettled");
            }
            
        }else if([self.orderDto.cancel isEqualToString:@"1"]){
            
            return L(@"I revoked");
            
        }else if([self.orderDto.cancel isEqualToString:@"2"]){
            
            return L(@"Have been revoked");
        }
    }
    
    return @"";
}
@end
