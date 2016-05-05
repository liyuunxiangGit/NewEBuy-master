//
//  ExchangTicketCell.m
//  SuningEBuy
//
//  Created by lanfeng on 12-5-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ExchangTicketCell.h"

@implementation ExchangTicketCell

@synthesize label = _label;
@synthesize ruleString = _ruleString;
@synthesize separatorLine = _separatorLine;

- (void)dealloc {
    
    TT_RELEASE_SAFELY(_label);
    
    TT_RELEASE_SAFELY(_ruleString);
    
    TT_RELEASE_SAFELY(_separatorLine);
    
}

-(void)setItem:(NSString *)string{

    if (string == nil || [string isEqualToString:@""]) {
        return;
    }

    
    self.ruleString = string;
    
    [self setNeedsLayout];
}


-(void)layoutSubviews{

    [super layoutSubviews];
    
    UIFont *font = [UIFont boldSystemFontOfSize:14.0];
    
    CGSize size = [self.ruleString sizeWithFont:font constrainedToSize:CGSizeMake(230, 1000) lineBreakMode:UILineBreakModeCharacterWrap];
    
    self.label.frame = CGRectMake(5, 0, size.width, size.height+10);
    
    self.separatorLine.frame = CGRectMake(0, size.height+10-2, 230, 2);
    
    self.label.text = self.ruleString;

}

-(UILabel *)label{
    if (_label == nil) {
        _label = [[UILabel alloc]init];
        _label.font = [UIFont boldSystemFontOfSize:14.0];
        _label.backgroundColor = [UIColor clearColor];
        _label.numberOfLines = 0;
        [self.contentView addSubview:_label];
    }
    return _label;
}

-(UIImageView *)separatorLine{
    if (_separatorLine == nil) {
        _separatorLine = [[UIImageView alloc]init];
        UIImage *image = [UIImage imageNamed:@"cellSeparatorLine.png"];
        _separatorLine.image = image;
        [self.contentView addSubview:_separatorLine];
    }
    return _separatorLine;
}

+(CGFloat)height:(NSString *)string{
    
    UIFont *font = [UIFont boldSystemFontOfSize:14.0];
    
    CGSize size = [string sizeWithFont:font constrainedToSize:CGSizeMake(230, 1000) lineBreakMode:UILineBreakModeCharacterWrap];
    
    return size.height+10;

}

@end
