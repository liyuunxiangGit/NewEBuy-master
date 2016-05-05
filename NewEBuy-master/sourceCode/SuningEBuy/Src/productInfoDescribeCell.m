//
//  productInfoDescribeCell.m
//  SuningEBuy
//
//  Created by robin wang on 4/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "productInfoDescribeCell.h"



#define kDefualCellHight      10

@implementation productInfoDescribeCell
@synthesize infoLbl = _infoLbl;
@synthesize infoString = _infoString;

- (id) initWithReuseIdentifier:(NSString *)reuseIdentifier{
	
	if (self = [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:reuseIdentifier]) {
		
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		
		self.autoresizesSubviews = YES;
        
		self.contentView.backgroundColor = [UIColor clearColor];
	}
	
	return self;
}

-(UILabel *)infoLbl{
    
    if (!_infoLbl) {
        
        _infoLbl = [[UILabel alloc] init];
        
        _infoLbl.frame = CGRectMake(20, 5, kDefaulContendWidth, 5);
        
        _infoLbl.backgroundColor = [UIColor clearColor];
        
        _infoLbl.textAlignment = UITextAlignmentLeft;
        
        _infoLbl.textColor = [UIColor colorWithRed:112.0/255 green:112.0/255 blue:112.0/255 alpha:1];
        
        _infoLbl.font = [UIFont systemFontOfSize:kDefaulContendFont];
        
        _infoLbl.lineBreakMode = UILineBreakModeWordWrap;
        
        _infoLbl.numberOfLines = 0;
        
        [self addSubview:_infoLbl];
        
    }
    
    return _infoLbl;
    
}

-(void) setInfoString:(NSString *)aItem{
   	
    // if (aItem != _infoString) {
    
    
    _infoString = aItem;
    
    CGSize labelsize = [_infoString sizeWithFont:self.infoLbl.font constrainedToSize:CGSizeMake(self.infoLbl.frame.size.width, 300) lineBreakMode:UILineBreakModeWordWrap];
    
    CGRect frame = self.infoLbl.frame;
    
    frame.size.height = labelsize.height;
    
    self.infoLbl.frame = frame;
    
    self.infoLbl.text = _infoString;
    
    //  }
    
    
    
}

- (void) dealloc {
    
    TT_RELEASE_SAFELY(_infoLbl);
    
    TT_RELEASE_SAFELY(_infoString);
    
}

+ (CGFloat) height:(NSString *)astring{
    
    CGFloat cellHight = kDefualCellHight;
    
    if (astring == nil) {
        return cellHight;
    }
    UIFont *couendFont = [UIFont systemFontOfSize:kDefaulContendFont];
    
    DLog(@"height couend =%@", astring);
    
    CGSize labelsize = [astring sizeWithFont:couendFont constrainedToSize:CGSizeMake(kDefaulContendWidth, 300) lineBreakMode:UILineBreakModeWordWrap];
    
    cellHight += labelsize.height;
    
    return cellHight;
    
}
@end
