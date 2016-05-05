//
//  HotelDetalRoomTypeCell.m
//  SuningEBuy
//
//  Created by robin wang on 7/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HotelDetalRoomTypeCell.h"

#define  leftPadding    10

#define  offsetY        0

#define MOBILE_QUERY_CELL_HEIGHT 25

#define contentFont             16

#define offsetBackx             20

#define kLBLHight             25

#define kDecsWith             280

@implementation HotelDetalRoomTypeCell

@synthesize nameLbl = _nameLbl;

@synthesize discribLbl = _discribLbl;

@synthesize priceLbl = _priceLbl;

@synthesize statusLbl= _statusLbl;

@synthesize  merchItemDTO = _merchItemDTO;

@synthesize separatorLine = _separatorLine;

@synthesize arrowImg=_arrowImg;
- (void)dealloc
{
    TT_RELEASE_SAFELY(_nameLbl);
    
    TT_RELEASE_SAFELY(_discribLbl);
    
    TT_RELEASE_SAFELY(_priceLbl);
    
    TT_RELEASE_SAFELY(_statusLbl);
    
    TT_RELEASE_SAFELY(_merchItemDTO);
    
    TT_RELEASE_SAFELY(_separatorLine);
    
    
}

- (id) initWithReuseIdentifier:(NSString *)reuseIdentifier
{
	
	if (self = [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:reuseIdentifier]) {
        
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		
		self.autoresizesSubviews = YES;
        
            [self setNeedsLayout];
		
		//self.contentView.backgroundColor = [UIColor whiteColor];   
//
//		[self layoutSubviews];
//        
//		UIImage *image = [UIImage newImageFromResource:@"category_cellSeparatorLine.png"];
//		
//        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
//		
//        imageView.frame = CGRectMake(0, self.bottom+30, 320, 2);
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

- (void)layoutSubviews
{
    [super layoutSubviews];
        
    self.separatorLine.frame = CGRectMake(0, self.height-1, 320, 1);
}    

-(UIImageView *)separatorLine{
    if (_separatorLine == nil) {
        _separatorLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 1)];
        UIImage *tempImage = [UIImage imageNamed:@"category_cellSeparatorLine.png"];
        _separatorLine.image = tempImage;
        //[tempImage release];    
        
        [self.contentView addSubview:_separatorLine];
    }
    
    return _separatorLine;
}


- (UILabel *)nameLbl
{
    if (_nameLbl == nil) 
    {
        UIFont *font = [UIFont systemFontOfSize:contentFont];
        
		_nameLbl = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding,  offsetY, 230, kLBLHight)];
		
		_nameLbl.backgroundColor = [UIColor clearColor];
		
		_nameLbl.font = font;
        
        _nameLbl.textColor = [UIColor blackColor];
        
        _nameLbl.textAlignment = UITextAlignmentLeft;
        _nameLbl.numberOfLines = 0;
		
		_nameLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_nameLbl];

    }
    return _nameLbl;
}

- (UILabel *)discribLbl
{
    if (_discribLbl == nil) 
    {
        UIFont *font = [UIFont systemFontOfSize:contentFont-2];
        
		_discribLbl = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding,  _nameLbl.bottom, kDecsWith, kLBLHight-5)];
		
		_discribLbl.backgroundColor = [UIColor clearColor];
		
		_discribLbl.font = font;
        
        _discribLbl.textColor = [UIColor grayColor];
        
        _discribLbl.numberOfLines = 0;
        
        _discribLbl.textAlignment = UITextAlignmentLeft;
		
		_discribLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_discribLbl];
        
    }
    return _discribLbl;
}

- (UILabel *)priceLbl
{
    if (_priceLbl == nil) 
    {
        UIFont *font = [UIFont systemFontOfSize:contentFont];
        
		_priceLbl = [[UILabel alloc] initWithFrame:CGRectMake(_nameLbl.right, offsetY, 80, kLBLHight)];
		
		_priceLbl.backgroundColor = [UIColor clearColor];
		
		_priceLbl.font = font;
        
        _priceLbl.textColor = [UIColor orange_Red_Color];
        
        _priceLbl.textAlignment = UITextAlignmentLeft;
		
		_priceLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_priceLbl];
        
    }
    return _priceLbl;
}

- (UILabel *)statusLbl
{
    if (_statusLbl == nil) 
    {
        UIFont *font = [UIFont systemFontOfSize:contentFont];
        
		_statusLbl = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding,  _discribLbl.bottom, 200, kLBLHight)];
		
		_statusLbl.backgroundColor = [UIColor clearColor];
		
		_statusLbl.font = font;
        
        _statusLbl.textColor = [UIColor orange_Light_Color];
        
        _statusLbl.textAlignment = UITextAlignmentLeft;
		
		_statusLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_statusLbl];
        
    }
    return _statusLbl;
}
-(UIImageView*)arrowImg{
    if (!_arrowImg) {
        UIImage* img=[UIImage newImageFromResource:@"cellDetail@2x.png"];
        _arrowImg=[[UIImageView alloc] initWithFrame:CGRectMake(303, 38, 6, 11)];
        [_arrowImg setImage:img];
        TT_RELEASE_SAFELY(img);
        
    }
    return _arrowImg;
}
+ (CGFloat)height:(HotelDetalRoomTypeDTO *)item
{
    CGFloat cellHight = MOBILE_QUERY_CELL_HEIGHT;
    
    if (!item)
    {
        return MOBILE_QUERY_CELL_HEIGHT;
    }
    
     UIFont *font = [UIFont systemFontOfSize:contentFont-2];
    
    NSString *discrib = [NSString stringWithFormat:@"%@%@ %@%@ %@", item.area, L(@"BTSquareMetre"),item.floor,L(@"BTLayer"), item.discribe];
    CGSize infoSize = [discrib sizeWithFont:font constrainedToSize:CGSizeMake(kDecsWith, 50) lineBreakMode:UILineBreakModeWordWrap];
    
    NSString *nameString = [NSString stringWithFormat:@"%@   --%@",item.name, item.nike];
    CGSize nameSize = [nameString sizeWithFont:[UIFont systemFontOfSize:contentFont] constrainedToSize:CGSizeMake(230, 50) lineBreakMode:UILineBreakModeCharacterWrap];
    
    return (cellHight+infoSize.height+nameSize.height);
}

- (void)setMerchItemDTO:(HotelDetalRoomTypeDTO *)merchItemDTO
{
    if (merchItemDTO != _merchItemDTO) 
    {
        TT_RELEASE_SAFELY(_merchItemDTO);
        
        _merchItemDTO = merchItemDTO;
        
        NSString *nameNike = [NSString stringWithFormat:@"%@   --%@",_merchItemDTO.name, _merchItemDTO.nike];
        
        self.nameLbl.text = nameNike;
        NSString *nameString = [NSString stringWithFormat:@"%@   --%@",_merchItemDTO.name, _merchItemDTO.nike];
        CGSize nameSize = [nameString sizeWithFont:[UIFont systemFontOfSize:contentFont] constrainedToSize:CGSizeMake(230, 50) lineBreakMode:UILineBreakModeCharacterWrap];
        self.nameLbl.height=nameSize.height;
        
        
        NSString *discrib = [NSString stringWithFormat:@"%@%@ %@%@ %@", _merchItemDTO.area,L(@"BTSquareMetre"), _merchItemDTO.floor,L(@"BTLayer"), _merchItemDTO.discribe];
        CGSize infoSize = [discrib sizeWithFont:self.discribLbl.font constrainedToSize:CGSizeMake(self.discribLbl.frame.size.width, 50) lineBreakMode:UILineBreakModeWordWrap];
        
        CGRect frame = self.discribLbl.frame;
        frame.size.height = infoSize.height;
        self.discribLbl.frame = frame;
        self.discribLbl.top=self.nameLbl.bottom;
        
        self.discribLbl.text = discrib;
        
        self.priceLbl.text = [NSString stringWithFormat:@"￥%@", _merchItemDTO.price];
                              
        self.statusLbl.top = self.discribLbl.bottom;
        
        if ([_merchItemDTO.status isEqualToString:@"0"]==YES) {
            self.statusLbl.text = L(@"BTRoomHave");
        }else if ([_merchItemDTO.status isEqualToString:@"1"]==YES)
        {
            self.statusLbl.text = L(@"BTRoomFull");
        }else    
        {
            self.statusLbl.text = L(@"BTRoomFull");
        }    
    
       self.separatorLine.top = self.statusLbl.bottom;
        
       self.arrowImg.top=[HotelDetalRoomTypeCell height:_merchItemDTO]/2.0-5.5;
        [self.contentView addSubview:self.arrowImg];
        
    }
}


@end
