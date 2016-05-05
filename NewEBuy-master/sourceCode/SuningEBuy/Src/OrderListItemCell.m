//
//  OrderListItemCell.m
//  SuningEBuy
//
//  Created by zhaojw on 11-9-28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OrderListItemCell.h"
#import "orderHttpDataSource.h"
#define  ORDER_LIST_CELL_HEIGHT  100


#define  leftPadding    10

@implementation OrderListItemCell



@synthesize orderIDLbl        = _orderIDLbl;

@synthesize orderIDContentLbl = _orderIDContentLbl;

@synthesize orderTimeLbl = _orderTimeLbl;

@synthesize orderTimeContentLbl = _orderTimeContentLbl;

@synthesize orderStatusLbl = _orderStatusLbl;

@synthesize orderStatusContentLbl = _orderStatusContentLbl;

@synthesize orderPriceLbl = _orderPriceLbl;

@synthesize orderPriceContentLbl = _orderPriceContentLbl;

@synthesize item = _item;

- (NSDateFormatter *)dateFormatterServer
{
    NSDateFormatter *_dateFormatter = [[NSDateFormatter alloc] init];
    
    [_dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    
    return _dateFormatter;
}

- (NSDateFormatter *)dateFormatterClient
{
    NSDateFormatter *_dateFormatter = [[NSDateFormatter alloc] init];
    
    [_dateFormatter setDateFormat:L(@"MyEBuy_SetDate")];
    
    return _dateFormatter;
}



- (id) initWithReuseIdentifier:(NSString *)reuseIdentifier{
	self = [super initWithReuseIdentifier:reuseIdentifier];
	if (self) {
		
		//self.frame = CGRectMake(0, 0, 320, 48);
		
		/*UIImage *image = [UIImage newImageFromResource:@"CellGradientBackground.png"];
		
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
		
		TT_RELEASE_SAFELY(image);
		
        imageView.contentMode = UIViewContentModeScaleToFill;
		
        self.backgroundView = imageView;
		
        [imageView release];*/
    self.backgroundColor = [UIColor cellBackViewColor];
		
	}
	
	return self;
}

-(void)dealloc{
	
	
	TT_RELEASE_SAFELY(_orderIDLbl);
	
	TT_RELEASE_SAFELY(_orderIDContentLbl);
	
	TT_RELEASE_SAFELY(_orderTimeLbl);
	
	TT_RELEASE_SAFELY(_orderTimeContentLbl);
	
	TT_RELEASE_SAFELY(_orderStatusLbl);
	
	TT_RELEASE_SAFELY(_orderStatusContentLbl);
	
	TT_RELEASE_SAFELY(_orderPriceLbl);
	
	TT_RELEASE_SAFELY(_orderPriceContentLbl);
	
	TT_RELEASE_SAFELY(_item);
	
	
}


-(UILabel *) orderIDLbl{
	
	if (!_orderIDLbl) {
		
		UIFont *font = [UIFont systemFontOfSize:14];
		
		CGSize size = [@"a" sizeWithFont:font];
		
		_orderIDLbl = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, 5, 60, size.height)];
		
		_orderIDLbl.backgroundColor = [UIColor clearColor];
		
		_orderIDLbl.font = font;
		
		_orderIDLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_orderIDLbl];
	}
	
	return _orderIDLbl;
}


-(UILabel *) orderIDContentLbl{
	
	if (!_orderIDContentLbl) {
		
		UIFont *font = [UIFont boldSystemFontOfSize:14];
		
		CGSize size = [@"a" sizeWithFont:font];
		
		_orderIDContentLbl = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 60, size.height)];
		
		_orderIDContentLbl.backgroundColor = [UIColor clearColor];
		
		_orderIDContentLbl.textColor = [UIColor colorWithRed:0/255.0 green:51/255.0 blue:153/255.0 alpha:1.0];
		
		_orderIDContentLbl.font = font;
		
		_orderIDContentLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_orderIDContentLbl];
	}
	
	return _orderIDContentLbl;
}


-(UILabel *) orderTimeLbl{
	
	if (!_orderTimeLbl) {
		
		UIFont *font = [UIFont systemFontOfSize:14];
		
		CGSize size = [@"a" sizeWithFont:font];
		
		_orderTimeLbl = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, 5, 60, size.height)];
		
		_orderTimeLbl.backgroundColor = [UIColor clearColor];
		
		_orderTimeLbl.font = font;
		
		_orderTimeLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_orderTimeLbl];
	}
	
	return _orderTimeLbl;
}


-(UILabel *) orderTimeContentLbl{
	
	if (!_orderTimeContentLbl) {
		
		UIFont *font = [UIFont boldSystemFontOfSize:14];
		
		CGSize size = [@"a" sizeWithFont:font];
		
		_orderTimeContentLbl = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 160, size.height)];
		
		_orderTimeContentLbl.backgroundColor = [UIColor clearColor];
		
		_orderTimeContentLbl.font = font;
		
		_orderTimeContentLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_orderTimeContentLbl];
	}
	
	return _orderTimeContentLbl;
}



-(UILabel *) orderStatusLbl{
	
	if (!_orderStatusLbl) {
		
		UIFont *font = [UIFont systemFontOfSize:14];
		
		CGSize size = [@"a" sizeWithFont:font];
		
		_orderStatusLbl = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, 5, 60, size.height)];
		
		_orderStatusLbl.backgroundColor = [UIColor clearColor];
		
		_orderStatusLbl.font = font;
		
		_orderStatusLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_orderStatusLbl];
	}
	
	return _orderStatusLbl;
}


-(UILabel *) orderStatusContentLbl{
	
	if (!_orderStatusContentLbl) {
		
		UIFont *font = [UIFont boldSystemFontOfSize:14];
		
		CGSize size = [@"a" sizeWithFont:font];
		
		_orderStatusContentLbl = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 60, size.height)];
		
		_orderStatusContentLbl.backgroundColor = [UIColor clearColor];
		
		_orderStatusContentLbl.font = font;
		
		_orderStatusContentLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_orderStatusContentLbl];
	}
	
	return _orderStatusContentLbl;
}



-(UILabel *) orderPriceLbl{
	
	if (!_orderPriceLbl) {
		
		UIFont *font = [UIFont systemFontOfSize:14];
		
		CGSize size = [@"a" sizeWithFont:font];
		
		_orderPriceLbl = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, 5, 60, size.height)];
		
		_orderPriceLbl.backgroundColor = [UIColor clearColor];
		
		_orderPriceLbl.font = font;
		
		_orderPriceLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_orderPriceLbl];
	}
	
	return _orderPriceLbl;
}


-(UILabel *) orderPriceContentLbl{
	
	if (!_orderPriceContentLbl) {
		
		UIFont *font = [UIFont boldSystemFontOfSize:14];
		
		CGSize size = [@"a" sizeWithFont:font];
		
		_orderPriceContentLbl = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 60, size.height)];
		
		_orderPriceContentLbl.backgroundColor = [UIColor clearColor];
		
		_orderPriceContentLbl.textColor = [UIColor redColor];
		
		
		_orderPriceContentLbl.font = font;
		
		_orderPriceContentLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_orderPriceContentLbl];
	}
	
	return _orderPriceContentLbl;
}




+(CGFloat) height:(MemberOrderNamesDTO *)item{
	
	if (!item) {
		
		return ORDER_LIST_CELL_HEIGHT;
	}
	
	
	return  ORDER_LIST_CELL_HEIGHT;
	
}


-(void) setItem:(MemberOrderNamesDTO *)aItem{
	
	if (aItem != _item) {
		
		
		_item = aItem;
		
		
		
		self.orderIDLbl.text = L(@"order ID");
		
		self.orderIDContentLbl.text = _item.orderId;
		
		self.orderTimeLbl.text = L(@"order Time");
        
        NSDate *date = [[self dateFormatterServer] dateFromString:_item.lastUpdate];
        
        NSString *dateString = [[self dateFormatterClient] stringFromDate:date];
		
		self.orderTimeContentLbl.text = dateString;
		
		
		self.orderStatusLbl.text = L(@"order stutas");
		
		self.orderStatusContentLbl.text = [orderHttpDataSource getOrderTypeInfo:_item.oiStatus];
		
		
		self.orderPriceLbl.text = L(@"order price");
		
		NSString	*marketPrice = [[NSString alloc] initWithFormat:@"￥%.2f",[_item.prepayAmount floatValue]];
		
		self.orderPriceContentLbl.text = marketPrice;
        
        TT_RELEASE_SAFELY(marketPrice);
		
		[self setNeedsLayout];
		
		
		
	}
}


-(void) layoutSubviews{
	
	[super layoutSubviews];
	
	
	self.orderIDContentLbl.frame = CGRectMake(self.orderIDLbl.right+10, self.orderIDLbl.top, 100, self.orderIDContentLbl.height);
	
	
	self.orderTimeLbl.frame = CGRectMake(self.orderIDLbl.left, self.orderIDLbl.bottom+5, 60, self.orderTimeLbl.height);
	
	self.orderTimeContentLbl.frame = CGRectMake(self.orderTimeLbl.right+10, self.orderTimeLbl.top, 180, self.orderStatusContentLbl.height);
	
	
	
	
	self.orderStatusLbl.frame = CGRectMake(self.orderTimeLbl.left, self.orderTimeLbl.bottom+5, 60, self.orderTimeLbl.height);
	
	self.orderStatusContentLbl.frame = CGRectMake(self.orderStatusLbl.right+10, self.orderStatusLbl.top, 100, self.orderStatusContentLbl.height);
	
	
	
	self.orderPriceLbl.frame = CGRectMake(self.orderStatusLbl.left, self.orderStatusLbl.bottom+5, 60, self.orderPriceLbl.height);
	
	self.orderPriceContentLbl.frame = CGRectMake(self.orderPriceLbl.right+10, self.orderPriceLbl.top, 100, self.orderPriceContentLbl.height);
	
}


@end
