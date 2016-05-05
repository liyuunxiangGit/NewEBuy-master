//
//  HotelServiceInfoCell.m
//  SuningEBuy
//
//  Created by robin wang on 7/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HotelServiceInfoCell.h"

#define  leftPadding    10

#define  offsetY        0

#define MOBILE_QUERY_CELL_HEIGHT 35

#define contentFont             14

#define offsetBackx             20

#define kLBLHight             25

#define kDecsWith             300

@implementation HotelServiceInfoCell

@synthesize nameLbl = _nameLbl;

@synthesize discribLbl = _discribLbl;

@synthesize separatorLine = _separatorLine;

@synthesize merchItemDTO= _merchItemDTO;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_nameLbl);
    
    TT_RELEASE_SAFELY(_discribLbl);
    
    TT_RELEASE_SAFELY(_merchItemDTO);
    
    TT_RELEASE_SAFELY(_separatorLine);
    
    
}

- (id) initWithReuseIdentifier:(NSString *)reuseIdentifier
{
	
	if (self = [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:reuseIdentifier]) {
        
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		
		self.autoresizesSubviews = YES;
		
		//self.contentView.backgroundColor = [UIColor whiteColor];   
        //
        //		[self layoutSubviews];
        //        
        //		UIImage *image = [UIImage newImageFromResource:@"category_cellSeparatorLine.png"];
        //		
        //        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        //		
        //        imageView.frame = CGRectMake(0, (self.frame.size.height-2), 320, 2);
        //		TT_RELEASE_SAFELY(image);
        //		
        //        imageView.contentMode = UIViewContentModeScaleToFill;
        //		
        //        [self.contentView addSubview: imageView];
        //        
        //		
        //        [imageView release];
        
	}
	
	return self;
}

-(UIImageView *)separatorLine{
    if (_separatorLine == nil) {
        _separatorLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 2)];
        UIImage *tempImage = [UIImage newImageFromResource:@"category_cellSeparatorLine.png"];
        _separatorLine.image = tempImage;
        
        [self.contentView addSubview:_separatorLine];
    }
    
    return _separatorLine;
}


- (UILabel *)nameLbl
{
    if (_nameLbl == nil) 
    {
        UIFont *font = [UIFont boldSystemFontOfSize:contentFont];
        
		_nameLbl = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding,  offsetY, 300, kLBLHight)];
		
		_nameLbl.backgroundColor = [UIColor clearColor];
		
		_nameLbl.font = font;
        
        _nameLbl.textColor = [UIColor blackColor];
        
        _nameLbl.textAlignment = UITextAlignmentLeft;
		
		_nameLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_nameLbl];
        
    }
    return _nameLbl;
}

- (UILabel *)discribLbl
{
    if (_discribLbl == nil) 
    {
        UIFont *font = [UIFont systemFontOfSize:contentFont-1];
        
		_discribLbl = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding,  _nameLbl.bottom, kDecsWith, kLBLHight-5)];
		
		_discribLbl.backgroundColor = [UIColor clearColor];
		
		_discribLbl.font = font;
        
        _discribLbl.textColor = [UIColor grayColor];
        
        _discribLbl.numberOfLines = 0;
        
        _discribLbl.lineBreakMode = UILineBreakModeWordWrap;
        
        _discribLbl.textAlignment = UITextAlignmentLeft;
		
		_discribLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_discribLbl];
        
    }
    return _discribLbl;
}


+ (CGFloat)height:(HotelDetailImageListDTO *)item
{
    CGFloat cellHight = MOBILE_QUERY_CELL_HEIGHT;
    
    if (!item)
    {
        return MOBILE_QUERY_CELL_HEIGHT;
    }
    
    UIFont *font = [UIFont systemFontOfSize:contentFont];
    
    CGSize nameSize = [item.info heightWithFont:font width:kDecsWith linebreak:UILineBreakModeWordWrap];
    
    return (cellHight+nameSize.height);
}

- (void)setMerchItemDTO:(HotelDetailImageListDTO *)merchItemDTO
{
    if (merchItemDTO != _merchItemDTO) 
    {
        TT_RELEASE_SAFELY(_merchItemDTO);
        
        _merchItemDTO = merchItemDTO;
        
        self.nameLbl.text = _merchItemDTO.title;
        
        UIFont *font = [UIFont systemFontOfSize:contentFont];
        
        CGSize infoSize = [_merchItemDTO.info heightWithFont:font width:kDecsWith linebreak:UILineBreakModeWordWrap];
//        CGSize infoSize = [ _merchItemDTO.info sizeWithFont:self.discribLbl.font constrainedToSize:CGSizeMake(self.discribLbl.frame.size.width, 1000) lineBreakMode:UILineBreakModeWordWrap];
        CGRect frame = self.discribLbl.frame;
        frame.size.height = infoSize.height;
        self.discribLbl.frame = frame;
        
        self.discribLbl.text = _merchItemDTO.info;

    }
}

@end