//
//  DJGroupDetailFourthCell.m
//  SuningEBuy
//
//  Created by xie wei on 13-7-15.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "DJGroupDetailFourthCell.h"

#define kDefualCellHight         10

#define kDefaulMarkWidth        100

#define kDefaulContendWidth     (320 - kDefaulMarkWidth-60)

#define kDefaulContendFont      12

@implementation DJGroupDetailFourthCell
@synthesize markLbl =_markLbl;
@synthesize infoLbl = _infoLbl;
@synthesize contendTDO =_contendTDO;

- (void)dealloc {
    
    TT_RELEASE_SAFELY(_contendTDO);
    TT_RELEASE_SAFELY(_markLbl);
    TT_RELEASE_SAFELY(_infoLbl);
    
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier{
	
	if (self = [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:reuseIdentifier]) {
		
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		
		self.autoresizesSubviews = YES;
        
		self.contentView.backgroundColor = [UIColor clearColor];
	}
	
	return self;
}

- (UILabel *)markLbl{
    
    if (!_markLbl) {
        
        _markLbl = [[UILabel alloc] init];
        
        _markLbl.frame = CGRectMake(15, 5, kDefaulMarkWidth, 25);
        
        _markLbl.backgroundColor = [UIColor clearColor];
        
        _markLbl.textAlignment = UITextAlignmentRight;
        
        _markLbl.textColor = [UIColor blackColor];
        
        _markLbl.font = [UIFont systemFontOfSize:kDefaulContendFont];
        
        _markLbl.lineBreakMode = UILineBreakModeCharacterWrap;
        
        _markLbl.numberOfLines = 0;
        
        [self addSubview:_markLbl];
        
    }
    
    return _markLbl;
    
}

- (UILabel *)infoLbl{
    
    if (!_infoLbl) {
        
        _infoLbl = [[UILabel alloc] init];
        
        _infoLbl.frame = CGRectMake(self.markLbl.right+30, 5, kDefaulContendWidth, 5);
        
        _infoLbl.backgroundColor = [UIColor clearColor];
        
        _infoLbl.textAlignment = UITextAlignmentLeft;
        
        _infoLbl.textColor = [UIColor skyBlueColor];
        
        _infoLbl.font = [UIFont systemFontOfSize:kDefaulContendFont];
        
        _infoLbl.lineBreakMode = UILineBreakModeCharacterWrap;
        
        _infoLbl.numberOfLines = 0;
        
        [self addSubview:_infoLbl];
        
    }
    
    return _infoLbl;
    
}

- (void)setContendTDO:(ProductParaDTO *)aItem{
   	
    if (aItem != _contendTDO) {
        
        
        _contendTDO = aItem;
        
        NSString *nameTemp  = [[[NSString stringWithFormat:@"%@:",_contendTDO.parameterName] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] replacedWhiteSpacsByString:@""];
        
        CGSize nameSize = [nameTemp sizeWithFont:self.markLbl.font constrainedToSize:CGSizeMake(self.markLbl.frame.size.width, 50) lineBreakMode:UILineBreakModeCharacterWrap];
        CGRect markFrame = self.markLbl.frame;
        markFrame.size.height = nameSize.height;
        self.markLbl.frame = markFrame;
        
        self.markLbl.text = nameTemp;
        
        NSString *cotendTemp  = [[[NSString stringWithFormat:@"%@",_contendTDO.parameterContents] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] replacedWhiteSpacsByString:@""];
        
        CGSize infoSize = [cotendTemp sizeWithFont:self.infoLbl.font constrainedToSize:CGSizeMake(self.infoLbl.frame.size.width, 1000) lineBreakMode:UILineBreakModeCharacterWrap];
        CGRect frame = self.infoLbl.frame;
        frame.size.height = infoSize.height;
        self.infoLbl.frame = frame;
        
        self.infoLbl.text = cotendTemp;
        
    }
    
}

+ (CGFloat)height:(ProductParaDTO *)dto
{
    CGFloat cellHight = kDefualCellHight;
    
    if (IsNilOrNull(dto)) {
        return 0;
    }
    
    return ([DJGroupDetailFourthCell getRowHeight:dto]+ cellHight);
}


+ (CGFloat)getRowHeight:(ProductParaDTO *)tempDto{
    if (IsNilOrNull(tempDto)) {
        return 0;
    }
    
    UIFont *font = [UIFont systemFontOfSize:kDefaulContendFont];
    
    NSString *nameTemp  = [[[NSString stringWithFormat:@"%@:",tempDto.parameterName] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] replacedWhiteSpacsByString:@""];
    
    CGFloat nameHeight = [nameTemp heightWithFont:font width:kDefaulMarkWidth linebreak:UILineBreakModeCharacterWrap].height;
    
    NSString *contentString = [[tempDto.parameterContents stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] replacedWhiteSpacsByString:@""];
    
    CGFloat contentHeight  = [contentString heightWithFont:font width:kDefaulContendWidth linebreak:UILineBreakModeCharacterWrap].height;
    
    return nameHeight>contentHeight ? nameHeight : contentHeight;
    
}
@end
