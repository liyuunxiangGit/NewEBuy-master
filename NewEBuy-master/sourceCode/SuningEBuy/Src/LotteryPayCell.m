//
//  LotteryPayCell.m
//  SuningEBuy
//
//  Created by david david on 12-6-30.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import "LotteryPayCell.h"

@implementation LotteryPayCell

@synthesize keyString = _keyString;
@synthesize valueString = _valueString;
@synthesize keyLbl = _keyLbl;
@synthesize valueLbl = _valueLbl;
@synthesize valueLblColor = _valueLblColor;

- (void)dealloc {
    
    TT_RELEASE_SAFELY(_keyString);
    
    TT_RELEASE_SAFELY(_valueString);
    
    TT_RELEASE_SAFELY(_keyLbl);
    
    TT_RELEASE_SAFELY(_valueLbl);
    
    TT_RELEASE_SAFELY(_valueLblColor);
    
    TT_RELEASE_SAFELY(_isPay);
    
    TT_RELEASE_SAFELY(_arrowView);
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)setItem:(NSDictionary *)dic{
    
    if (dic == nil) {
        
        return;
    }
    
    NSString *itemName = [dic objectForKey:@"itemName"];
    
    NSString *itemValue = [dic objectForKey:@"itemValue"];
    
    UIColor *color = (UIColor *)[dic objectForKey:@"valueColor"];
    
    //添加银联支付修改
    
    self.isPay = [dic objectForKey:@"isPay"];
    
    
    if ([self.isPay isEqualToString:@"isUnionpay"])
    {
        self.keyLbl.text = itemName;
        
        self.valueLbl.text = itemValue;
        
        self.valueLbl.textColor = color;
        
        [self.contentView addSubview:self.arrowView];
        
        
        
    }
    
    
    else{
        
        self.keyLbl.text = itemName;
        
        self.valueLbl.text = itemValue;
        
        self.valueLbl.textColor = color;
    }
    
}


#pragma mark - views

-(UILabel *)keyLbl{
    
    if(_keyLbl == nil){
        
        if ([self.isPay isEqualToString:@"isNotPay"])
        {
            _keyLbl = [[UILabel alloc]initWithFrame:CGRectMake(-13, 0, 110, 44)];
        }
        else
        {
            _keyLbl = [[UILabel alloc]initWithFrame:CGRectMake(-30, 5, 110, 15)];
            
        }
        
        _keyLbl.backgroundColor = [UIColor clearColor];
        
        _keyLbl.textColor = RGBCOLOR(66, 31, 30);
        
        _keyLbl.textAlignment = UITextAlignmentRight;
        
        _keyLbl.font = [UIFont systemFontOfSize:16.0];
        
        [self.contentView addSubview:_keyLbl];
        
    }
    
    return _keyLbl;
}

-(UILabel *)valueLbl{
    
    if(_valueLbl == nil){
        
        if ([self.isPay isEqualToString:@"isNotPay"])
        {
            
            _valueLbl = [[UILabel alloc]initWithFrame:CGRectMake(self.keyLbl.right, 0, 240, 44)];
            
            _valueLbl.font = [UIFont systemFontOfSize:16.0];
            
            
        }
        else
        {
            _valueLbl = [[UILabel alloc]initWithFrame:CGRectMake(18, self.keyLbl.bottom, 240, 22)];
            
            _valueLbl.font = [UIFont systemFontOfSize:13.0];
            
            
            
        }
        
        _valueLbl.backgroundColor = [UIColor clearColor];
        
        
        
        [self.contentView addSubview:_valueLbl];
        
    }
    
    return _valueLbl;
}

- (UIImageView*)arrowView
{
    if (!_arrowView)
    {
        _arrowView = [[UIImageView alloc]init];
        
        _arrowView.frame = CGRectMake(280, 18, 7, 8);
        
        _arrowView.image = [UIImage imageNamed:@"pay_arrow.png"];
    }
    
    return _arrowView;
}


@end
