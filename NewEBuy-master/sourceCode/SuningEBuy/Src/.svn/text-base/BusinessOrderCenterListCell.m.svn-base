//
//  BusinessOrderCenterListCell.m
//  SuningEBuy
//
//  Created by robin wang on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BusinessOrderCenterListCell.h"

#define  leftPadding    5

#define  offsetY        0

#define MOBILE_QUERY_CELL_HEIGHT 125

#define contentFont             16

#define offsetBackx             20

@implementation BusinessOrderCenterListCell
@synthesize orderNOLbl = _orderNOLbl;

@synthesize hotelNameLbl = _hotelNameLbl;

@synthesize numberLbl = _numberLbl;

@synthesize totalPriceLbl = _totalPriceLbl;

@synthesize timerLbl = _timerLbl;

@synthesize statusLbl = _statusLbl;

@synthesize  merchItemDTO = _merchItemDTO;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_orderNOLbl);
    
    TT_RELEASE_SAFELY(_hotelNameLbl);
    
    TT_RELEASE_SAFELY(_numberLbl);
    
    TT_RELEASE_SAFELY(_totalPriceLbl);
    
    TT_RELEASE_SAFELY(_timerLbl);
    
    TT_RELEASE_SAFELY(_statusLbl);
    
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

- (UILabel *)orderNOLbl
{
    if (_orderNOLbl == nil) 
    {
        
        UIFont *font = [UIFont systemFontOfSize:contentFont];
		
		CGSize size = [@"a" sizeWithFont:font];
        
        UILabel *markLbl = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, offsetY,  80, size.height)];
		
		markLbl.backgroundColor = [UIColor clearColor];
        
		markLbl.font = font;
        
        markLbl.textColor = [UIColor grayColor];
		
		markLbl.autoresizingMask = UIViewAutoresizingNone;
        
        markLbl.textAlignment = UITextAlignmentRight;
        markLbl.text = L(@"orderNumber");
        
        [self.contentView addSubview: markLbl];
        
		_orderNOLbl = [[UILabel alloc] initWithFrame:CGRectMake(markLbl.right+offsetBackx, offsetY, 200, size.height)];
		
		_orderNOLbl.backgroundColor = [UIColor clearColor];
		
		_orderNOLbl.font = font;
		
		_orderNOLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_orderNOLbl];
        
    }
    return _orderNOLbl;
}

- (UILabel *)hotelNameLbl
{
    if (_hotelNameLbl == nil) 
    {
        
        UIFont *font = [UIFont systemFontOfSize:contentFont];
		
		CGSize size = [@"a" sizeWithFont:font];
        
        UILabel *markLbl = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, _orderNOLbl.bottom,  80, size.height)];
		
		markLbl.backgroundColor = [UIColor clearColor];
        
		markLbl.font = font;
        
        markLbl.textColor = [UIColor grayColor];
		
		markLbl.autoresizingMask = UIViewAutoresizingNone;
        
        markLbl.textAlignment = UITextAlignmentRight;
        markLbl.text =  L(@"hotalName");
        [self.contentView addSubview: markLbl];
        
		_hotelNameLbl = [[UILabel alloc] initWithFrame:CGRectMake(markLbl.right+offsetBackx, _orderNOLbl.bottom, 200, size.height)];
		
		_hotelNameLbl.backgroundColor = [UIColor clearColor];
		
		_hotelNameLbl.font = font;
		
		_hotelNameLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_hotelNameLbl];
        
    }
    return _hotelNameLbl;
}

- (UILabel *)numberLbl
{
    if (_numberLbl == nil) 
    {
        
        UIFont *font = [UIFont systemFontOfSize:contentFont];
		
		CGSize size = [@"a" sizeWithFont:font];
        
        UILabel *markLbl = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, _hotelNameLbl.bottom,  80, size.height)];
		
		markLbl.backgroundColor = [UIColor clearColor];
        
		markLbl.font = font;
        
        markLbl.textColor = [UIColor grayColor];
		
		markLbl.autoresizingMask = UIViewAutoresizingNone;
        
        markLbl.textAlignment = UITextAlignmentRight;
        markLbl.text = L(@"Count");
        [self.contentView addSubview: markLbl];
        
		_numberLbl = [[UILabel alloc] initWithFrame:CGRectMake(markLbl.right+offsetBackx, _hotelNameLbl.bottom, 200, size.height)];
		
		_numberLbl.backgroundColor = [UIColor clearColor];
		
		_numberLbl.font = font;
		
		_numberLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_numberLbl];
        
    }
    
    return _numberLbl;
}

- (UILabel *)totalPriceLbl
{
    if (_totalPriceLbl == nil) 
    {
        
        UIFont *font = [UIFont systemFontOfSize:contentFont];
		
		CGSize size = [@"a" sizeWithFont:font];
        
        UILabel *markLbl = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, _numberLbl.bottom,  80, size.height)];
		
		markLbl.backgroundColor = [UIColor clearColor];
        
		markLbl.font = font;
        
        markLbl.textColor = [UIColor grayColor];
		
		markLbl.autoresizingMask = UIViewAutoresizingNone;
        
        markLbl.textAlignment = UITextAlignmentRight;
        markLbl.text = L(@"totalPrice");
        [self.contentView addSubview: markLbl];
        
		_totalPriceLbl = [[UILabel alloc] initWithFrame:CGRectMake(markLbl.right+offsetBackx,  _numberLbl.bottom, 200, size.height)];
		
		_totalPriceLbl.backgroundColor = [UIColor clearColor];
		
		_totalPriceLbl.font = font;
        
        _totalPriceLbl.textColor = [UIColor redColor];
		
		_totalPriceLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_totalPriceLbl];
        
    }
    return _totalPriceLbl;
}

- (UILabel *)timerLbl
{
    if (_timerLbl == nil) 
    {
        
        UIFont *font = [UIFont systemFontOfSize:contentFont];
		
		CGSize size = [@"a" sizeWithFont:font];
        
        UILabel *markLbl = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, _totalPriceLbl.bottom,  80, size.height)];
		
		markLbl.backgroundColor = [UIColor clearColor];
        
		markLbl.font = font;
        
        markLbl.textColor = [UIColor grayColor];
		
		markLbl.autoresizingMask = UIViewAutoresizingNone;
        
        markLbl.textAlignment = UITextAlignmentRight;
        markLbl.text = L(@"orderTimer");
        [self.contentView addSubview: markLbl];
        
		_timerLbl = [[UILabel alloc] initWithFrame:CGRectMake(markLbl.right+offsetBackx, _totalPriceLbl.bottom, 200, size.height)];
		
		_timerLbl.backgroundColor = [UIColor clearColor];
		
		_timerLbl.font = font;
		
		_timerLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_timerLbl];
        
    }
    return _timerLbl;
}

- (UILabel *)statusLbl
{
    if (_statusLbl == nil) 
    {
        
        UIFont *font = [UIFont systemFontOfSize:contentFont];
		
		CGSize size = [@"a" sizeWithFont:font];
        
        UILabel *markLbl = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, _timerLbl.bottom,  80, size.height)];
		
		markLbl.backgroundColor = [UIColor clearColor];
        
		markLbl.font = font;
        
        markLbl.textColor = [UIColor grayColor];
		
		markLbl.autoresizingMask = UIViewAutoresizingNone;
        
        markLbl.textAlignment = UITextAlignmentRight;
        markLbl.text = L(@"orderStatus");
        [self.contentView addSubview: markLbl];
        
		_statusLbl = [[UILabel alloc] initWithFrame:CGRectMake(markLbl.right+offsetBackx, _timerLbl.bottom, 200, size.height)];
		
		_statusLbl.backgroundColor = [UIColor clearColor];
		
		_statusLbl.font = font;
		
		_statusLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_statusLbl];
        
    }
    return _statusLbl;
}

+ (CGFloat)height:(BusinessOrderCenterListDTO *)item
{
    if (!item)
    {
        return MOBILE_QUERY_CELL_HEIGHT;
    }
    
    return MOBILE_QUERY_CELL_HEIGHT;
}

- (NSDateFormatter *)dateFormatterServer
{
    NSDateFormatter *_dateFormatter = [[NSDateFormatter alloc] init];
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [_dateFormatter setLocale:locale];
    
    [_dateFormatter setDateFormat:@"MMM dd, yyyy hh:mm:ss a"];
    
    return _dateFormatter;
}

- (NSDateFormatter *)dateFormatterClient
{
    NSDateFormatter *_dateFormatter = [[NSDateFormatter alloc] init];
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [_dateFormatter setLocale:locale];
    
    [_dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    return _dateFormatter;
}

- (void)setMerchItemDTO:(BusinessOrderCenterListDTO *)merchItemDTO
{
    if (merchItemDTO != _merchItemDTO) 
    {
        TT_RELEASE_SAFELY(_merchItemDTO);
        
        _merchItemDTO = merchItemDTO;
        
        self.orderNOLbl.text = _merchItemDTO.orderNO;
        
        self.hotelNameLbl.text = _merchItemDTO.hotelName;
        
        self.numberLbl.text = _merchItemDTO.number;
        
        self.totalPriceLbl.text = [[NSString stringWithFormat:@"%.2f", [_merchItemDTO.totalPrice floatValue] ] stringByAppendingString:L(@" yuan")];
        
        if (NotNilAndNull(_merchItemDTO.timer)) {
            NSDate *date = [[self dateFormatterServer] dateFromString:_merchItemDTO.timer];
            NSString *checkIn = [[self dateFormatterClient] stringFromDate:date];
            self.timerLbl.text = checkIn;
        }
        
        self.statusLbl.text = _merchItemDTO.status;
        
    }
}


@end
