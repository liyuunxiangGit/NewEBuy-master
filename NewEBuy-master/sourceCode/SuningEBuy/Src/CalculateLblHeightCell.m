//
//  CalculateLblHeightCell.m
//  SuningEBuy
//
//  Created by xmy on 26/10/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CalculateLblHeightCell.h"

@implementation CalculateLblHeightCell

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


- (float)lblNumberOfLines:(UIFont*)lblFont WithLbl:(NSString*)lblStr WithLblWidth:(float)w
{
    CGSize labelHeight = [lblStr sizeWithFont:lblFont];
    
    CGSize contextSize = [lblStr heightWithFont:lblFont width:w linebreak:UILineBreakModeCharacterWrap];
    NSInteger lines = ceil(contextSize.height/labelHeight.height);
    
    if(lines > 1)
    {
        return labelHeight.height*lines;
    }
    else
    {
        return 30;//labelHeight.height;
    }
    
}



@end
