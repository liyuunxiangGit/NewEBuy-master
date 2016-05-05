//
//  LiveingCustomerInfoCell.m
//  SuningEBuy
//
//  Created by robin wang on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LiveingCustomerInfoCell.h"

#define  leftPadding    5

#define  offsetY        5

#define  kLblHight        25

#define MOBILE_QUERY_CELL_HEIGHT 58

#define contentFont             15

#define offsetBackx             20

@implementation LiveingCustomerInfoCell

@synthesize liveLatestTimerLbl = _liveLatestTimerLbl;

@synthesize liveEarliestTimerLbl = _liveEarliestTimerLbl;

@synthesize merchItemDTO = _merchItemDTO;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_liveLatestTimerLbl);
    
    TT_RELEASE_SAFELY(_liveEarliestTimerLbl);
    
    TT_RELEASE_SAFELY(_merchItemDTO);
    
}

- (id) initWithReuseIdentifier:(NSString *)reuseIdentifier
{
	
	if (self = [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:reuseIdentifier]) {
        
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		
		self.autoresizesSubviews = YES;
		
		self.contentView.backgroundColor = [UIColor clearColor];
        
        offsetForLblY = 0.0f;
		
		//self.frame = CGRectMake(0, 0, 320, 48);
		
//		UIImage *image = [UIImage newImageFromResource:@"Virtual_item_bg.png"];
//		
//        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
//		
//        imageView.frame = CGRectMake(0, 0, 620, 141);
//		TT_RELEASE_SAFELY(image);
//		
//        imageView.contentMode = UIViewContentModeScaleToFill;
//		
//        [self.contentView addSubview: imageView];
//        //self.backgroundView = imageView;
//		
//        [imageView release];
        
	}
	
	return self;
}

- (UILabel *)liveEarliestTimerLbl
{
    if (_liveEarliestTimerLbl == nil) 
    {

        UIFont *font = [UIFont systemFontOfSize:contentFont];
		        
        UILabel *markLbl = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, offsetForLblY,  100, kLblHight)];
		
		markLbl.backgroundColor = [UIColor clearColor];
        
		markLbl.font = font;
		
		markLbl.autoresizingMask = UIViewAutoresizingNone;
        
         markLbl.textAlignment = UITextAlignmentRight;
        
        markLbl.text =  L(@"liveingEarliestTimer");
        [self.contentView addSubview: markLbl];
        
		_liveEarliestTimerLbl = [[UILabel alloc] initWithFrame:CGRectMake(markLbl.right+offsetBackx, offsetForLblY, 200, kLblHight)];
		
		_liveEarliestTimerLbl.backgroundColor = [UIColor clearColor];
		
		_liveEarliestTimerLbl.font = font;
        
        _liveEarliestTimerLbl.textColor = [UIColor grayColor];
		
		_liveEarliestTimerLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_liveEarliestTimerLbl];
        
    }
    return _liveEarliestTimerLbl;
}

- (UILabel *)liveLatestTimerLbl
{
    if (_liveLatestTimerLbl == nil) 
    {
        
        UIFont *font = [UIFont systemFontOfSize:contentFont];
		        
        UILabel *markLbl = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, _liveEarliestTimerLbl.bottom,  100, kLblHight)];
		
		markLbl.backgroundColor = [UIColor clearColor];
        
		markLbl.font = font;
        
        markLbl.textAlignment = UITextAlignmentRight;
		
		markLbl.autoresizingMask = UIViewAutoresizingNone;

        markLbl.text =  L(@"liveingLatestTimer");
        [self.contentView addSubview: markLbl];
        
		_liveLatestTimerLbl = [[UILabel alloc] initWithFrame:CGRectMake(markLbl.right+offsetBackx, _liveEarliestTimerLbl.bottom, 200, kLblHight)];
		
		_liveLatestTimerLbl.backgroundColor = [UIColor clearColor];
		
		_liveLatestTimerLbl.font = font;
        
        _liveLatestTimerLbl.textColor = [UIColor grayColor];
		
		_liveLatestTimerLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_liveLatestTimerLbl];
        
    }
    return _liveLatestTimerLbl;
}

-(void)loopMarkLbl:(NSInteger)wCount withInfo:(NSString *)wString
{
    UIFont *font = [UIFont systemFontOfSize:contentFont];
    
    CGSize size = [@"a" sizeWithFont:font];
    
    NSString *markText = [NSString stringWithFormat:@"入住人%d", (wCount+1)];
    
    UILabel *markLbl = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, offsetY+(wCount*kLblHight),  100, size.height)];
    
    markLbl.backgroundColor = [UIColor clearColor];
    
    markLbl.font = font;
    
    markLbl.textAlignment = UITextAlignmentRight;
    
    markLbl.autoresizingMask = UIViewAutoresizingNone;

    markLbl.text = markText;
    [self.contentView addSubview: markLbl];
    
    UILabel *tempInfoLbl = [[UILabel alloc] initWithFrame:CGRectMake(markLbl.right+offsetBackx, offsetY+(wCount*kLblHight), 200, size.height)];
    
    tempInfoLbl.backgroundColor = [UIColor clearColor];
    
    tempInfoLbl.font = font;
    
    tempInfoLbl.textAlignment = UITextAlignmentLeft;
    
    tempInfoLbl.text = wString;
    
    tempInfoLbl.textColor = [UIColor grayColor];
    
    tempInfoLbl.autoresizingMask = UIViewAutoresizingNone;
    
    offsetForLblY = tempInfoLbl.bottom+5;
    
    [self.contentView addSubview:tempInfoLbl];
    
    

}

+ (CGFloat)height:(BusinessOrderDetailDTO *)item
{
    if (!item)
    {
        return MOBILE_QUERY_CELL_HEIGHT; 
    }
    
    return (MOBILE_QUERY_CELL_HEIGHT+ ([item.liveingCountArr count]*kLblHight));
}

- (void)setMerchItemDTO:(BusinessOrderDetailDTO *)merchItemDTO
{
    if (merchItemDTO != _merchItemDTO) 
    {
        TT_RELEASE_SAFELY(_merchItemDTO);
        
        _merchItemDTO = merchItemDTO;
        
        for (NSInteger index = 0; index < [_merchItemDTO.liveingCountArr count]; index++) {
            
            NSString *tempText = [_merchItemDTO.liveingCountArr objectAtIndex:index];
            
             [self loopMarkLbl:index withInfo:tempText];
        }
        
       // NSArray *tempViewArr =  [self subviews];
         if (offsetForLblY < 0) {
             offsetForLblY = 5;
         }

        
        self.liveEarliestTimerLbl.top = offsetForLblY;
        
        self.liveLatestTimerLbl.top = self.liveEarliestTimerLbl.bottom;
        
        
        
        self.liveEarliestTimerLbl.text = _merchItemDTO.liveEarliestTimer;
        
        self.liveLatestTimerLbl.text = _merchItemDTO.liveLatestTimer; 

    }   
}

@end
