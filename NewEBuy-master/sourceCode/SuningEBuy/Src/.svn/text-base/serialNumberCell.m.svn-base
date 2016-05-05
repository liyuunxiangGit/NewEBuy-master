//
//  serialNumberCell.m
//  SuningEBuy
//
//  Created by DP on 3/11/12.
//  Copyright (c) 2012 __zhaofk__. All rights reserved.
//

#import "serialNumberCell.h"

@implementation serialNumberCell

@synthesize  item = _item;

@synthesize  serialNumberLbl = _serialNumberLbl;


- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.serialNumberLbl.frame = CGRectMake(5, 0, 315,25);
    
}

//初始化“易购券名称”
- (void)setItem:(MYEbuyCoumonDTO *)aItem
{   
    
    NSString *str_serialNumber= (aItem.serialNumber == nil || [aItem.serialNumber  isEqualToString:@""]) ?@"---":aItem.serialNumber;
    
    self.serialNumberLbl.text = str_serialNumber;
    
    [super setNeedsLayout];
}

-(void)dealloc{
    
	TT_RELEASE_SAFELY(_item);
    TT_RELEASE_SAFELY(_serialNumberLbl);
	
	
}
//初始化“易购券名称”label
- (UILabel *)serialNumberLbl{
    if (nil == _serialNumberLbl) {
        
        _serialNumberLbl = [[UILabel alloc]init];
        
        _serialNumberLbl.textAlignment = UITextAlignmentLeft;
        
        _serialNumberLbl.font = [UIFont systemFontOfSize:12];
        
        _serialNumberLbl.textColor = [UIColor blackColor];
        
        _serialNumberLbl.tag = 1;
        
        _serialNumberLbl.numberOfLines = 0; 
        
        _serialNumberLbl.backgroundColor = [UIColor clearColor];
        
        _serialNumberLbl.lineBreakMode = UILineBreakModeCharacterWrap;
        
        [self.contentView addSubview:_serialNumberLbl];
    }
    return  _serialNumberLbl;
}
@end
