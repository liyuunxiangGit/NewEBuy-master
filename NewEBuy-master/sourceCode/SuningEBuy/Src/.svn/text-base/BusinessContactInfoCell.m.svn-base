//
//  BusinessContactInfoCell.m
//  SuningEBuy
//
//  Created by robin wang on 7/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BusinessContactInfoCell.h"

#define  leftPadding    5

#define  offsetY        5

#define  kLblHight        25

#define MOBILE_QUERY_CELL_HEIGHT 60

#define contentFont             15

#define offsetBackx             20

@implementation BusinessContactInfoCell

@synthesize nameLbl = _nameLbl;

@synthesize phoneNumberLbl = _phoneNumberLbl;

@synthesize merchItemDTO = _merchItemDTO;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_nameLbl);
    
    TT_RELEASE_SAFELY(_phoneNumberLbl);
    
    TT_RELEASE_SAFELY(_merchItemDTO);
    
}

- (id) initWithReuseIdentifier:(NSString *)reuseIdentifier
{
	
	if (self = [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:reuseIdentifier]) {
        
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		
		self.autoresizesSubviews = YES;
		
		self.contentView.backgroundColor = [UIColor clearColor];
		
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

- (UILabel *)nameLbl
{
    if (_nameLbl == nil) 
    {
        
        UIFont *font = [UIFont systemFontOfSize:contentFont];
		        
        UILabel *markLbl = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, offsetY,  80, kLblHight)];
		
		markLbl.backgroundColor = [UIColor clearColor];
        
		markLbl.font = font;
        
        markLbl.textAlignment = UITextAlignmentRight;
		
		markLbl.autoresizingMask = UIViewAutoresizingNone;
        
        markLbl.textAlignment = UITextAlignmentRight;
        markLbl.text =  L(@"name");
        [self.contentView addSubview: markLbl];
        
		_nameLbl = [[UILabel alloc] initWithFrame:CGRectMake(markLbl.right+offsetBackx, offsetY, 200, kLblHight)];
		
		_nameLbl.backgroundColor = [UIColor clearColor];
		
		_nameLbl.font = font;
		
		_nameLbl.autoresizingMask = UIViewAutoresizingNone;
        
        _nameLbl.textColor = [UIColor grayColor];
		
		[self.contentView addSubview:_nameLbl];
        
    }
    return _nameLbl;
}

- (UILabel *)phoneNumberLbl
{
    if (_phoneNumberLbl == nil) 
    {
        
        UIFont *font = [UIFont systemFontOfSize:contentFont];
		        
        UILabel *markLbl = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, _nameLbl.bottom,  80, kLblHight)];
		
		markLbl.backgroundColor = [UIColor clearColor];
        
		markLbl.font = font;
		
        markLbl.textAlignment = UITextAlignmentRight;
        
		markLbl.autoresizingMask = UIViewAutoresizingNone;
        markLbl.text =  L(@"mobileNo");
        [self.contentView addSubview: markLbl];
        
		_phoneNumberLbl = [[UILabel alloc] initWithFrame:CGRectMake(markLbl.right+offsetBackx, _nameLbl.bottom, 200, kLblHight)];
		
		_phoneNumberLbl.backgroundColor = [UIColor clearColor];
		
		_phoneNumberLbl.font = font;
		
		_phoneNumberLbl.autoresizingMask = UIViewAutoresizingNone;
        
        _phoneNumberLbl.textColor = [UIColor grayColor];
		
		[self.contentView addSubview:_phoneNumberLbl];
        
    }
    return _phoneNumberLbl;
}

+ (CGFloat)height:(BusinessOrderDetailDTO *)item
{
    if (!item)
    {
        return MOBILE_QUERY_CELL_HEIGHT;
    }
    
    return MOBILE_QUERY_CELL_HEIGHT;
}

- (void)setMerchItemDTO:(BusinessOrderDetailDTO *)merchItemDTO
{
    if (merchItemDTO != _merchItemDTO) 
    {
        TT_RELEASE_SAFELY(_merchItemDTO);
        
        _merchItemDTO = merchItemDTO;
        
        self.nameLbl.text = _merchItemDTO.contactName;
        
        self.phoneNumberLbl.text = _merchItemDTO.phoneNumber;
        
    }   
}

@end
