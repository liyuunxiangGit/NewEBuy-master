//
//  MobilePayCell.m
//  SuningEBuy
//
//  Created by david david on 12-8-9.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import "MobilePayCell.h"

@implementation MobilePayCell

@synthesize payModelLabel = _payModelLabel;
@synthesize payDesLabel = _payDesLabel;

- (void)dealloc {
    
    TT_RELEASE_SAFELY(_payModelLabel);
    TT_RELEASE_SAFELY(_payDesLabel);
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        if (IOS7_OR_LATER) {
            self.backgroundColor =[UIColor cellBackViewColor];
        }
        else
        {
            UIView *back = [UIView new];
            back.backgroundColor =[UIColor cellBackViewColor];
            self.backgroundView = back;
        }
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(UILabel *)payModelLabel{

    if (_payModelLabel == nil) {
        
        _payModelLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 280, 30)];
        
        _payModelLabel.font =[UIFont systemFontOfSize:14];
        
        _payModelLabel.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:_payModelLabel];
    }

    return _payModelLabel;
}

-(UILabel *)payDesLabel{

    if (_payDesLabel == nil) {
        
        _payDesLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, self.payModelLabel.bottom, 280, 30)];
        
        _payDesLabel.backgroundColor = [UIColor clearColor];
        
        _payDesLabel.textColor = [UIColor dark_Gray_Color];
        
        _payDesLabel.font = [UIFont systemFontOfSize:14.0];
        
        _payDesLabel.adjustsFontSizeToFitWidth = YES;
        
        [self.contentView addSubview:_payDesLabel];
    }
    
    return _payDesLabel;


}

-(void)setItem:(NSString *)payModelString payDes:(NSString *)payDesString color:(UIColor *)labelColor{
    
    if (payDesString == nil) {
        
        return;
    }
        
    self.payModelLabel.text = payModelString;
    
    self.payDesLabel.text = payDesString;
    
    self.payDesLabel.textColor = labelColor;
    
}


@end
