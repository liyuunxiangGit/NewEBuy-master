//
//  OrderInvoiceItemCell.m
//  SuningEBuy
//
//  Created by wanghongwei on 11-10-10.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "OrderInvoiceItemCell.h"

#define  ORDER_LIST_CELL_HEIGHT  100
#define  leftPadding    10


@implementation OrderInvoiceItemCell

@synthesize  ordertaxTyperLbl = _ordertaxTyperLbl;
@synthesize ordertaxTyperContentLbl = _ordertaxTyperContentLbl;

@synthesize orderInvoiceLbl = _orderInvoiceLbl;
@synthesize orderInvoiceContentLbl = _orderInvoiceContentLbl;

@synthesize orderInvoiceDescriptionLbl = _orderInvoiceDescriptionLbl;
@synthesize orderInvoiceDescriptionContentLbl = _orderInvoiceDescriptionContentLbl;

@synthesize detailDTO = _detailDTO;

- (id) initWithReuseIdentifier:(NSString *)reuseIdentifier{
	self = [super initWithReuseIdentifier:reuseIdentifier];
	if (self) {
		self.backgroundColor = [UIColor cellBackViewColor];
	}
	
	return self;
}

-(void)dealloc{
    TT_RELEASE_SAFELY(_ordertaxTyperLbl);
    TT_RELEASE_SAFELY(_ordertaxTyperContentLbl);
    
    TT_RELEASE_SAFELY(_orderInvoiceLbl);
    TT_RELEASE_SAFELY(_orderInvoiceContentLbl);
    
    TT_RELEASE_SAFELY(_orderInvoiceDescriptionLbl);
    TT_RELEASE_SAFELY(_orderInvoiceDescriptionContentLbl);
    
    TT_RELEASE_SAFELY(_detailDTO);
    
}

-(UILabel *) ordertaxTyperLbl{
	
	if (!_ordertaxTyperLbl) {
		
		UIFont *font = [UIFont systemFontOfSize:14];
		
		CGSize size = [@"a" sizeWithFont:font];
		
		_ordertaxTyperLbl = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, 5, 60, size.height)];
		
		_ordertaxTyperLbl.backgroundColor = [UIColor clearColor];
		
		_ordertaxTyperLbl.font = font;
		
		_ordertaxTyperLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_ordertaxTyperLbl];
	}
	
	return _ordertaxTyperLbl;
}


-(UILabel *) ordertaxTyperContentLbl{
	
	if (!_ordertaxTyperContentLbl) {
		
		UIFont *font = [UIFont boldSystemFontOfSize:14];
		
		CGSize size = [@"a" sizeWithFont:font];
		
		_ordertaxTyperContentLbl = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 60, size.height)];
		
		_ordertaxTyperContentLbl.backgroundColor = [UIColor clearColor];
		
		_ordertaxTyperContentLbl.textColor = [UIColor colorWithRed:0/255.0 green:51/255.0 blue:153/255.0 alpha:1.0];
		
		_ordertaxTyperContentLbl.font = font;
		
		_ordertaxTyperContentLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_ordertaxTyperContentLbl];
	}
	
	return _ordertaxTyperContentLbl;
}

-(UILabel *) orderInvoiceLbl{
	
	if (!_orderInvoiceLbl) {
		
		UIFont *font = [UIFont systemFontOfSize:14];
		
		CGSize size = [@"a" sizeWithFont:font];
		
		_orderInvoiceLbl = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, 5, 60, size.height)];
		
		_orderInvoiceLbl.backgroundColor = [UIColor clearColor];
		
		_orderInvoiceLbl.font = font;
		
		_orderInvoiceLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_orderInvoiceLbl];
	}
	
	return _orderInvoiceLbl;
}


-(UILabel *) orderInvoiceContentLbl{
	
	if (!_orderInvoiceContentLbl) {
		
		UIFont *font = [UIFont boldSystemFontOfSize:14];
		
		CGSize size = [@"a" sizeWithFont:font];
		
		_orderInvoiceContentLbl = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 60, size.height)];
		
		_orderInvoiceContentLbl.backgroundColor = [UIColor clearColor];
		
		_orderInvoiceContentLbl.textColor = [UIColor colorWithRed:0/255.0 green:51/255.0 blue:153/255.0 alpha:1.0];
		
		_orderInvoiceContentLbl.font = font;
		
		_orderInvoiceContentLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_orderInvoiceContentLbl];
	}
	
	return _orderInvoiceContentLbl;
}

-(UILabel *) orderInvoiceDescriptionLbl{
	
	if (!_orderInvoiceDescriptionLbl) {
		
		UIFont *font = [UIFont systemFontOfSize:14];
		
		CGSize size = [@"a" sizeWithFont:font];
		
		_orderInvoiceDescriptionLbl = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, 5, 60, size.height)];
		
		_orderInvoiceDescriptionLbl.backgroundColor = [UIColor clearColor];
		
		_orderInvoiceDescriptionLbl.font = font;
		
		_orderInvoiceDescriptionLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_orderInvoiceDescriptionLbl];
	}
	
	return _orderInvoiceDescriptionLbl;
}


-(UILabel *) orderInvoiceDescriptionContentLbl{
	
	if (!_orderInvoiceDescriptionContentLbl) {
		
		UIFont *font = [UIFont boldSystemFontOfSize:14];
		
		CGSize size = [@"a" sizeWithFont:font];
		
		_orderInvoiceDescriptionContentLbl = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 60, size.height)];
		
		_orderInvoiceDescriptionContentLbl.backgroundColor = [UIColor clearColor];
		
		_orderInvoiceDescriptionContentLbl.textColor = [UIColor colorWithRed:0/255.0 green:51/255.0 blue:153/255.0 alpha:1.0];
		
		_orderInvoiceDescriptionContentLbl.font = font;
        
        _orderInvoiceDescriptionContentLbl.numberOfLines = 0;
        
        _orderInvoiceDescriptionContentLbl.lineBreakMode = UILineBreakModeWordWrap;
		
		_orderInvoiceDescriptionContentLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_orderInvoiceDescriptionContentLbl];
	}
	
	return _orderInvoiceDescriptionContentLbl;
}

+(CGFloat) height:(MemberOrderDetailsDTO *)item{
	
	if (!item) {
		
		return ORDER_LIST_CELL_HEIGHT;
	}
    
	UIFont *font = [UIFont boldSystemFontOfSize:14];
    
    CGSize size1 = CGSizeMake(190, 200);
    
    CGSize laberSize = [item.invoiceDescription sizeWithFont:font constrainedToSize:size1 lineBreakMode:UILineBreakModeWordWrap];
    CGSize size2 = [@"a" sizeWithFont:font];
    
    CGFloat height = size2.height * 2 + 22 + laberSize.height;
	
	return  height;

	
}

-(void) setItem:(MemberOrderDetailsDTO *)aItem{
	
	if (aItem != _detailDTO) {
		
		
		_detailDTO = aItem;
		
		
		self.ordertaxTyperLbl.text = L(@"order taxTyper");
        
        NSString *taxTyp;
        
        if ([_detailDTO.taxType isEqualToString:@"0"]) {
            taxTyp = L(@"General invoice");
        }else if ([_detailDTO.taxType isEqualToString:@"1"]) {
            taxTyp = L(@"VAT invoice");
        }else if ([_detailDTO.taxType isEqualToString:@"5"]){
            taxTyp = L(@"NO invoice");
        }else {
            taxTyp = @"";
        }
		
		self.ordertaxTyperContentLbl.text = taxTyp;
		
		self.orderInvoiceLbl.text = L(@"order Invoice");
		
		self.orderInvoiceContentLbl.text = _detailDTO.invoice;
		
		
		self.orderInvoiceDescriptionLbl.text = L(@"order Invoice Description");
		
		self.orderInvoiceDescriptionContentLbl.text = _detailDTO.invoiceDescription;		
        
        
		[self setNeedsLayout];
		
		
		
	}
}

-(void) layoutSubviews{
	
	[super layoutSubviews];
	
    self.ordertaxTyperContentLbl.frame= CGRectMake(self.ordertaxTyperLbl.right+10,self.ordertaxTyperLbl.top, 100, self.ordertaxTyperContentLbl.height);
    
    self.orderInvoiceLbl.frame = CGRectMake(self.ordertaxTyperLbl.left,self.ordertaxTyperLbl.bottom+5, 60, self.orderInvoiceLbl.height);
    
    self.orderInvoiceContentLbl.frame = CGRectMake(self.orderInvoiceLbl.right+10,self.ordertaxTyperLbl.bottom+5, 100, self.ordertaxTyperContentLbl.height);
    
    self.orderInvoiceDescriptionLbl.frame = CGRectMake(self.orderInvoiceLbl.left,self.orderInvoiceLbl.bottom+5, 60, self.orderInvoiceDescriptionLbl.height);
    
    //self.orderInvoiceDescriptionContentLbl.frame = CGRectMake(self.orderInvoiceDescriptionLbl.right+10,self.orderInvoiceLbl.bottom+5, 190, self.orderInvoiceDescriptionContentLbl.height);
	
    UIFont *font = [UIFont boldSystemFontOfSize:14];
    
    CGSize size = CGSizeMake(190, 200);
    
    CGSize laberSize = [_detailDTO.invoiceDescription sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    
    CGRect addressFrame = CGRectMake(self.orderInvoiceDescriptionLbl.right+10, self.orderInvoiceLbl.bottom+5, laberSize.width, laberSize.height);
    
    self.orderInvoiceDescriptionContentLbl.frame = addressFrame;
}

@end
