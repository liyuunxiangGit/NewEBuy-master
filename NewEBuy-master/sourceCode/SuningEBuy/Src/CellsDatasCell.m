//
//  CellsDatasCell.m
//  SuningEBuy
//
//  Created by xmy on 26/1/14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "CellsDatasCell.h"

@implementation CellsDatasCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)getProOrderListDatas:(NewOrderListDTO *)dto
                 WithIsCshop:(BOOL)isCshop
{
    self.proOrderListDto = dto;
    self.proOrderListDto.isCshop = isCshop;
    
}


- (void)setLblProtery:(UILabel*)lbl
{
    lbl.textColor = [UIColor colorWithRGBHex:0x313131];
    
    lbl.backgroundColor = [UIColor clearColor];
    
    lbl.font = [UIFont systemFontOfSize:13];
    
    lbl.textAlignment = UITextAlignmentLeft;
    
    lbl.text = @"";
    
}


- (void)setContextLblProtery:(UILabel*)lbl
{
    lbl.textColor = [UIColor dark_Gray_Color];
    
    lbl.backgroundColor = [UIColor clearColor];
    
    lbl.font = [UIFont systemFontOfSize:13];
    
    lbl.textAlignment = UITextAlignmentRight;
    
    lbl.lineBreakMode = UILineBreakModeCharacterWrap;
    
    lbl.numberOfLines = 0;
    
    lbl.text = @"";

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
        return labelHeight.height;
    }
    
}

- (float)MaxlblNumberOfLines:(UIFont*)lblFont WithLbl:(NSString*)lblStr WithLblWidth:(float)w
{
    CGSize labelHeight = [lblStr sizeWithFont:lblFont];
    
//    CGSize contextSize = [lblStr heightWithFont:lblFont width:w linebreak:UILineBreakModeCharacterWrap];
    
//    NSInteger lines = ceil(contextSize.height/labelHeight.height);
    
    if(labelHeight.height < 40)
    {
        return 40;
    }
    else
    {
        return labelHeight.height;
    }

}

- (int)setProNameHeight:(NSString *)nameStr WithLbl:(UILabel *)lbl
{
//    NSString *nameTemp  = [[[NSString stringWithFormat:@"%@",nameStr] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] replacedWhiteSpacsByString:@""];

    NSString *nameTemp = [NSString stringWithFormat:@"%@",nameStr];
                            
    CGSize labelHeight = [nameTemp sizeWithFont:lbl.font];
    
    CGSize contextSize = [nameTemp heightWithFont:lbl.font width:190 linebreak:UILineBreakModeCharacterWrap];
    
    NSInteger lines = ceil(contextSize.height/labelHeight.height);
    
    if(lines > 1)
    {
        return 2;
    }
    else
    {
        return 1;
    }

}

- (int)setNameHeight:(NSString*)nameStr WithLbl:(UILabel*)lbl
{
    NSString *nameTemp  = [[[NSString stringWithFormat:@"%@",nameStr] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] replacedWhiteSpacsByString:@""];
    
    CGSize labelHeight = [nameTemp sizeWithFont:lbl.font];
    
    CGSize contextSize = [nameTemp heightWithFont:lbl.font width:190 linebreak:UILineBreakModeCharacterWrap];
    
    NSInteger lines = ceil(contextSize.height/labelHeight.height);
    
    if(lines > 1)
    {
        return 2;
    }
    else
    {
        return 1;
    }
    
    
}


@end
