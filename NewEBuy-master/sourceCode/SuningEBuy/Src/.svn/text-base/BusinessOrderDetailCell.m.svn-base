//
//  BusinessOrderDetailCell.m
//  SuningEBuy
//
//  Created by robin wang on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BusinessOrderDetailCell.h"

#define  leftPadding    5

#define  offsetY        5

#define  kLblHight        25

#define MOBILE_QUERY_CELL_HEIGHT 210

#define contentFont             15

#define offsetBackx             20

@implementation BusinessOrderDetailCell

@synthesize hotelNameLbl = _hotelNameLbl;

@synthesize starView = _starView;

@synthesize addressLbl = _addressLbl;

@synthesize roomTypeLbl = _roomTypeLbl;

@synthesize startLiveTimerLbl = _startLiveTimerLbl;

@synthesize bookingRoomCountLbl= _bookingRoomCountLbl;

@synthesize payTypeLbl = _payTypeLbl;

@synthesize datePriceLbl = _datePriceLbl;

@synthesize totalPriceLbl = _totalPriceLbl;

@synthesize merchItemDTO = _merchItemDTO;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_hotelNameLbl);
    
    TT_RELEASE_SAFELY(_starView);
    
    TT_RELEASE_SAFELY(_addressLbl);
    
    TT_RELEASE_SAFELY(_roomTypeLbl);
    
    TT_RELEASE_SAFELY(_startLiveTimerLbl);
    
    TT_RELEASE_SAFELY(_bookingRoomCountLbl);
    
    TT_RELEASE_SAFELY(_payTypeLbl);
    
    TT_RELEASE_SAFELY(_datePriceLbl);

    TT_RELEASE_SAFELY(_totalPriceLbl);
    
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

- (UILabel *)hotelNameLbl
{
    if (_hotelNameLbl == nil) 
    {
        
        UIFont *font = [UIFont systemFontOfSize:contentFont];
		        
        CGSize size = [@"a" sizeWithFont:font];
        
        UILabel *markLbl = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, offsetY,  80, kLblHight)];
		
		markLbl.backgroundColor = [UIColor clearColor];
        
		markLbl.font = font;
		
		markLbl.autoresizingMask = UIViewAutoresizingNone;
        
        markLbl.textAlignment = UITextAlignmentRight;
        markLbl.text =  L(@"hotalName");
        [self.contentView addSubview: markLbl];
        
		_hotelNameLbl = [[UILabel alloc] initWithFrame:CGRectMake(markLbl.right+offsetBackx, offsetY+5, 200, size.height)];
		
		_hotelNameLbl.backgroundColor = [UIColor clearColor];
        
        _hotelNameLbl.numberOfLines=0;  //add by wangjiaxing 20120912
        
		_hotelNameLbl.font = font;
        
        _hotelNameLbl.textColor = [UIColor grayColor];
		
		_hotelNameLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_hotelNameLbl];
        
    }
    return _hotelNameLbl;
}

-(HotelStarView *)starView
{
    if (_starView == nil) {
        
        UIFont *font = [UIFont systemFontOfSize:contentFont];
		        
        UILabel *markLbl = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, _hotelNameLbl.bottom,  80, kLblHight)];
		
		markLbl.backgroundColor = [UIColor clearColor];
        
		markLbl.font = font;
		
		markLbl.autoresizingMask = UIViewAutoresizingNone;
        
        markLbl.textAlignment = UITextAlignmentRight;
        markLbl.text =  L(@"hotelStarLevel");
        [self.contentView addSubview: markLbl];
        
        _starView = [[HotelStarView alloc] initWithFrame:CGRectMake(markLbl.right+offsetBackx, _hotelNameLbl.bottom+8, 80, 20)];
        
        _starView.backgroundColor = [UIColor clearColor];
        
        _starView.userInteractionEnabled = NO;
        
        [self.contentView addSubview: _starView];
        
    }
    
    return _starView;
}

- (UILabel *)addressLbl 
{
    if (_addressLbl == nil) 
    {
        
        UIFont *font = [UIFont systemFontOfSize:contentFont];
		
		CGSize size = [@"a" sizeWithFont:font];
        
        UILabel *markLbl = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, _starView.bottom,  80, kLblHight)];
		
		markLbl.backgroundColor = [UIColor clearColor];
        
		markLbl.font = font;
		
		markLbl.autoresizingMask = UIViewAutoresizingNone;
        
        markLbl.textAlignment = UITextAlignmentRight;
        markLbl.text =  L(@"hotelAddresss");
        [self.contentView addSubview: markLbl];
        
		_addressLbl = [[UILabel alloc] initWithFrame:CGRectMake(markLbl.right+offsetBackx, _starView.bottom, 195, size.height)];
		
		_addressLbl.backgroundColor = [UIColor clearColor];
		
		_addressLbl.font = font;
        
        _addressLbl.numberOfLines = 0;
        
        _addressLbl.textColor = [UIColor grayColor];
		
		_addressLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_addressLbl];
        
    }
    return _addressLbl;
}

- (UILabel *)roomTypeLbl
{
    if (_roomTypeLbl == nil) 
    {
        
        UIFont *font = [UIFont systemFontOfSize:contentFont];
		        
        UILabel *markLbl = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, _addressLbl.bottom,  80, kLblHight)];
		
		markLbl.backgroundColor = [UIColor clearColor];
        
		markLbl.font = font;
		
		markLbl.autoresizingMask = UIViewAutoresizingNone;
        
        markLbl.textAlignment = UITextAlignmentRight;
        markLbl.text =  L(@"hotelRoomType");
        [self.contentView addSubview: markLbl];
        
		_roomTypeLbl = [[UILabel alloc] initWithFrame:CGRectMake(markLbl.right+offsetBackx, _addressLbl.bottom, 200, kLblHight)];
		
		_roomTypeLbl.backgroundColor = [UIColor clearColor];
		
		_roomTypeLbl.font = font;
        
        _roomTypeLbl.textColor = [UIColor grayColor];
		
		_roomTypeLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_roomTypeLbl];
        
    }
    return _roomTypeLbl;
}

- (UILabel *)startLiveTimerLbl
{
    if (_startLiveTimerLbl == nil) 
    {
        
        UIFont *font = [UIFont systemFontOfSize:contentFont];
		        
        UILabel *markLbl = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, _roomTypeLbl.bottom,  80, kLblHight)];
		
		markLbl.backgroundColor = [UIColor clearColor];
        
		markLbl.font = font;
		
		markLbl.autoresizingMask = UIViewAutoresizingNone;
        
        markLbl.textAlignment = UITextAlignmentRight;
        markLbl.text =  L(@"starLiveTimer");
        [self.contentView addSubview: markLbl];
        
		_startLiveTimerLbl = [[UILabel alloc] initWithFrame:CGRectMake(markLbl.right+offsetBackx, _roomTypeLbl.bottom, 200, kLblHight)];
		
		_startLiveTimerLbl.backgroundColor = [UIColor clearColor];
		
		_startLiveTimerLbl.font = font;
        
        _startLiveTimerLbl.textColor = [UIColor grayColor];
		
		_startLiveTimerLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_startLiveTimerLbl];
        
    }
    return _startLiveTimerLbl;
}

- (UILabel *)bookingRoomCountLbl
{
    if (_bookingRoomCountLbl == nil) 
    {
        
        UIFont *font = [UIFont systemFontOfSize:contentFont];
		        
        UILabel *markLbl = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, _startLiveTimerLbl.bottom,  80, kLblHight)];
		
		markLbl.backgroundColor = [UIColor clearColor];
        
		markLbl.font = font;
		
		markLbl.autoresizingMask = UIViewAutoresizingNone;
        
        markLbl.textAlignment = UITextAlignmentRight;
        markLbl.text =  L(@"bookRoomCount");
        [self.contentView addSubview: markLbl];
        
		_bookingRoomCountLbl = [[UILabel alloc] initWithFrame:CGRectMake(markLbl.right+offsetBackx, _startLiveTimerLbl.bottom, 200, kLblHight)];
		
		_bookingRoomCountLbl.backgroundColor = [UIColor clearColor];
		
		_bookingRoomCountLbl.font = font;
        
        _bookingRoomCountLbl.textColor = [UIColor grayColor];
		
		_bookingRoomCountLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_bookingRoomCountLbl];
        
    }
    return _bookingRoomCountLbl;
}

- (UILabel *)payTypeLbl
{
    if (_payTypeLbl == nil) 
    {
        
        UIFont *font = [UIFont systemFontOfSize:contentFont];
		        
        UILabel *markLbl = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, _bookingRoomCountLbl.bottom,  80, kLblHight)];
		
		markLbl.backgroundColor = [UIColor clearColor];
        
		markLbl.font = font;
		
		markLbl.autoresizingMask = UIViewAutoresizingNone;
        
        markLbl.textAlignment = UITextAlignmentRight;
        markLbl.text =  L(@"payType");
        [self.contentView addSubview: markLbl];
        
		_payTypeLbl = [[UILabel alloc] initWithFrame:CGRectMake(markLbl.right+offsetBackx, _bookingRoomCountLbl.bottom, 200, kLblHight)];
		
		_payTypeLbl.backgroundColor = [UIColor clearColor];
		
		_payTypeLbl.font = font;
        
        _payTypeLbl.textColor = [UIColor grayColor];
		
		_payTypeLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_payTypeLbl];
        
    }
    return _payTypeLbl;
}

- (UILabel *)datePriceLbl
{
    if (_datePriceLbl == nil) 
    {
        
        UIFont *font = [UIFont systemFontOfSize:contentFont];
		        
        UILabel *markLbl = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, _payTypeLbl.bottom,  80, kLblHight)];
		
		markLbl.backgroundColor = [UIColor clearColor];
        
		markLbl.font = font;
		
		markLbl.autoresizingMask = UIViewAutoresizingNone;
        
        markLbl.textAlignment = UITextAlignmentRight;
        markLbl.text =  L(@"dataPrice");
        [self.contentView addSubview: markLbl];
        
		_datePriceLbl = [[UILabel alloc] initWithFrame:CGRectMake(markLbl.right+offsetBackx, _payTypeLbl.bottom, 200, kLblHight)];
		
		_datePriceLbl.backgroundColor = [UIColor clearColor];
		
		_datePriceLbl.font = font;
        
        _datePriceLbl.textColor = [UIColor redColor];
		
		_datePriceLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_datePriceLbl];
        
    }
    return _datePriceLbl;
}

- (UILabel *)totalPriceLbl
{
    if (_totalPriceLbl == nil) 
    {
        
        UIFont *font = [UIFont systemFontOfSize:contentFont];
		        
        UILabel *markLbl = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, _datePriceLbl.bottom,  80, kLblHight)];
		
		markLbl.backgroundColor = [UIColor clearColor];
        
		markLbl.font = font;
		
		markLbl.autoresizingMask = UIViewAutoresizingNone;
        
        markLbl.textAlignment = UITextAlignmentRight;
        markLbl.text =  L(@"totalPrice");
        [self.contentView addSubview: markLbl];
        
		_totalPriceLbl = [[UILabel alloc] initWithFrame:CGRectMake(markLbl.right+offsetBackx, _datePriceLbl.bottom, 200, kLblHight)];
		
		_totalPriceLbl.backgroundColor = [UIColor clearColor];
		
		_totalPriceLbl.font = font;
        
        _totalPriceLbl.textColor = [UIColor redColor];
		
		_totalPriceLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_totalPriceLbl];
        
    }
    return _totalPriceLbl;
}

+ (CGFloat)height:(BusinessOrderDetailDTO *)item
{
    if (!item)
    {
        return MOBILE_QUERY_CELL_HEIGHT;
    }
    
    UIFont *font = [UIFont systemFontOfSize:contentFont];
    
    CGSize infoSize = [ item.address sizeWithFont:font constrainedToSize:CGSizeMake(195, 60) lineBreakMode:UILineBreakModeCharacterWrap];

    CGSize infoSize1 = [ item.name sizeWithFont:font constrainedToSize:CGSizeMake(200, kLblHight) lineBreakMode:UILineBreakModeCharacterWrap];//add by wangjiaxing 20120912
    
    return (MOBILE_QUERY_CELL_HEIGHT + infoSize.height+infoSize1.height);
}

- (void)setMerchItemDTO:(BusinessOrderDetailDTO *)merchItemDTO
{
    if (merchItemDTO != _merchItemDTO) 
    {
        TT_RELEASE_SAFELY(_merchItemDTO);
        
        _merchItemDTO = merchItemDTO;
        
        //add by wangjiaxing 20120912 ---begin---
        CGSize infoSize1 = [ _merchItemDTO.name sizeWithFont:self.hotelNameLbl.font constrainedToSize:CGSizeMake(self.hotelNameLbl.frame.size.width, 60) lineBreakMode:UILineBreakModeCharacterWrap];
        CGRect frame1 = self.hotelNameLbl.frame;
        frame1.size.height = infoSize1.height;
        //add by wangjiaxing 20120912 ---end---
        self.hotelNameLbl.frame = frame1;
        
        self.hotelNameLbl.text = _merchItemDTO.name;
        
        [self.starView setStarsImages: _merchItemDTO.statLevel];
        
       // self.addressLbl.text = _merchItemDTO.address;
        CGSize infoSize = [ _merchItemDTO.address sizeWithFont:self.addressLbl.font constrainedToSize:CGSizeMake(self.addressLbl.frame.size.width, 60) lineBreakMode:UILineBreakModeCharacterWrap];
        CGRect frame = self.addressLbl.frame;
        frame.size.height = infoSize.height;
        self.addressLbl.frame = frame;
        self.addressLbl.text = _merchItemDTO.address;
        
        self.roomTypeLbl.text = _merchItemDTO.roomType;
        
        self.startLiveTimerLbl.text = _merchItemDTO.startLiveTimer;
        
        self.bookingRoomCountLbl.text = _merchItemDTO.bookingRoomCount;
        
        self.payTypeLbl.text = _merchItemDTO.payType;
        
        self.datePriceLbl.text = [[NSString stringWithFormat:@"%d", [_merchItemDTO.datePrice intValue] ] stringByAppendingString:L(@" yuan")];

        self.totalPriceLbl.text = [[NSString stringWithFormat:@"%d", [_merchItemDTO.totalPrice intValue] ] stringByAppendingString:L(@" yuan")];
        
    }
}


@end
