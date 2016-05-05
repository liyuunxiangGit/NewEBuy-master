//
//  orderProductExpandItemCell.m
//  SuningEBuy
//
//  Created by wanghongwei on 11-10-10.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "orderPlacerItemCell.h"

#define  ORDER_LIST_CELL_HEIGHT  100
#define  leftPadding    10

@implementation orderPlacerItemCell

@synthesize orderPlacerNamesLbl = _orderPlacerNamesLbl;
@synthesize orderPlacerNamesContentLbl = _orderPlacerNamesContentLbl;

@synthesize orderAdressLbl = _orderAdressLbl;
@synthesize orderAdressContentLbl = _orderAdressContentLbl;

@synthesize orderMobilePhoneLbl = _orderMobilePhoneLbl;
@synthesize orderMobilePhoneContentLbl = _orderMobilePhoneContentLbl;

@synthesize detailDTO = _detailDTO;

- (id) initWithReuseIdentifier:(NSString *)reuseIdentifier{
	self = [super initWithReuseIdentifier:reuseIdentifier];
	if (self) {
		self.backgroundColor = [UIColor cellBackViewColor];
	}
	
	return self;
}

-(void)dealloc{
    TT_RELEASE_SAFELY(_orderPlacerNamesLbl);
    TT_RELEASE_SAFELY(_orderPlacerNamesContentLbl);
    
    TT_RELEASE_SAFELY(_orderAdressLbl);
    TT_RELEASE_SAFELY(_orderAdressContentLbl);
    
    TT_RELEASE_SAFELY(_orderMobilePhoneLbl);
    TT_RELEASE_SAFELY(_orderMobilePhoneContentLbl);
    
    TT_RELEASE_SAFELY(_detailDTO);
    
}

-(UILabel *) orderPlacerNamesLbl{
	
	if (!_orderPlacerNamesLbl) {
		
		UIFont *font = [UIFont systemFontOfSize:14];
		
		CGSize size = [@"a" sizeWithFont:font];
		
		_orderPlacerNamesLbl = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, 5, 60, size.height)];
		
		_orderPlacerNamesLbl.backgroundColor = [UIColor clearColor];
		
		_orderPlacerNamesLbl.font = font;
		
		_orderPlacerNamesLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_orderPlacerNamesLbl];
	}
	
	return _orderPlacerNamesLbl;
}


-(UILabel *) orderPlacerNamesContentLbl{
	
	if (!_orderPlacerNamesContentLbl) {
		
		UIFont *font = [UIFont boldSystemFontOfSize:14];
		
		CGSize size = [@"a" sizeWithFont:font];
		
		_orderPlacerNamesContentLbl = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 60, size.height)];
		
		_orderPlacerNamesContentLbl.backgroundColor = [UIColor clearColor];
		
		_orderPlacerNamesContentLbl.textColor = [UIColor colorWithRed:0/255.0 green:51/255.0 blue:153/255.0 alpha:1.0];
		
		_orderPlacerNamesContentLbl.font = font;
		
		_orderPlacerNamesContentLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_orderPlacerNamesContentLbl];
	}
	
	return _orderPlacerNamesContentLbl;
}

-(UILabel *) orderAdressLbl{
	
	if (!_orderAdressLbl) {
		
		UIFont *font = [UIFont systemFontOfSize:14];
		
		CGSize size = [@"a" sizeWithFont:font];
		
		_orderAdressLbl = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, 5, 60, size.height)];
		
		_orderAdressLbl.backgroundColor = [UIColor clearColor];
		
		_orderAdressLbl.font = font;
		
		_orderAdressLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_orderAdressLbl];
	}
	
	return _orderAdressLbl;
}


-(UILabel *) orderAdressContentLbl{
	
	if (!_orderAdressContentLbl) {
		
		UIFont *font = [UIFont boldSystemFontOfSize:14];
		
		CGSize size = [@"a" sizeWithFont:font];
		
		_orderAdressContentLbl = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 60, size.height)];
		
		_orderAdressContentLbl.backgroundColor = [UIColor clearColor];
		
		_orderAdressContentLbl.textColor = [UIColor colorWithRed:0/255.0 green:51/255.0 blue:153/255.0 alpha:1.0];
		
		_orderAdressContentLbl.font = font;
        
        _orderAdressContentLbl.lineBreakMode = UILineBreakModeCharacterWrap;
        
		[_orderAdressContentLbl setNumberOfLines:0];
		_orderAdressContentLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_orderAdressContentLbl];
	}
	
	return _orderAdressContentLbl;
}

-(UILabel *) orderMobilePhoneLbl{
	
	if (!_orderMobilePhoneLbl) {
		
		UIFont *font = [UIFont systemFontOfSize:14];
		
		CGSize size = [@"a" sizeWithFont:font];
		
		_orderMobilePhoneLbl = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, 5, 60, size.height)];
		
		_orderMobilePhoneLbl.backgroundColor = [UIColor clearColor];
		
		_orderMobilePhoneLbl.font = font;
		
		_orderMobilePhoneLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_orderMobilePhoneLbl];
	}
	
	return _orderMobilePhoneLbl;
}


-(UILabel *) orderMobilePhoneContentLbl{
	
	if (!_orderMobilePhoneContentLbl) {
		
		UIFont *font = [UIFont boldSystemFontOfSize:14];
		
		CGSize size = [@"a" sizeWithFont:font];
		
		_orderMobilePhoneContentLbl = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 60, size.height)];
		
		_orderMobilePhoneContentLbl.backgroundColor = [UIColor clearColor];
		
		_orderMobilePhoneContentLbl.textColor = [UIColor colorWithRed:0/255.0 green:51/255.0 blue:153/255.0 alpha:1.0];
		
		_orderMobilePhoneContentLbl.font = font;
		
		_orderMobilePhoneContentLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_orderMobilePhoneContentLbl];
	}
	
	return _orderMobilePhoneContentLbl;
}

+ (CGFloat) height:(MemberOrderDetailsDTO *)item{
	
	if (!item) {
		
		return ORDER_LIST_CELL_HEIGHT;
	}
    
    UIFont *font = [UIFont boldSystemFontOfSize:14];
    
    CGSize size1 = CGSizeMake(190, 200);
    
    CGSize laberSize = [item.address sizeWithFont:font constrainedToSize:size1 lineBreakMode:UILineBreakModeWordWrap];
    CGSize size2 = [@"a" sizeWithFont:font];
    
    if ([item.address isEqualToString:@""] || item.address == nil)
    {
        CGFloat height = size2.height * 3 + 22;
        
        return height;
    }
	
    CGFloat height = size2.height * 2 + 22 + laberSize.height;
	
	return  height;
	
}

-(void) setItem:(MemberOrderDetailsDTO *)aItem{
	
	if (aItem != _detailDTO) {
		
		
		_detailDTO = aItem;
		
		
		self.orderPlacerNamesLbl.text = L(@"order PlacerNames");
		
		self.orderPlacerNamesContentLbl.text = _detailDTO.itemPlacerName;
        
		
		self.orderAdressLbl.text = L(@"order Adress");
		
		self.orderAdressContentLbl.text = _detailDTO.address;
		
		self.orderMobilePhoneLbl.text = L(@"order MobilePhone");
		
		self.orderMobilePhoneContentLbl.text = _detailDTO.itemMobilePhone;		
        

		[self setNeedsLayout];
		
		
		
	}
}

-(void) layoutSubviews{
	
	[super layoutSubviews];
	
    self.orderPlacerNamesContentLbl.frame= CGRectMake(self.orderPlacerNamesLbl.right+10,self.orderPlacerNamesLbl.top, 100, self.orderPlacerNamesContentLbl.height);
    
    self.orderMobilePhoneLbl.frame = CGRectMake(self.orderPlacerNamesLbl.left,self.orderPlacerNamesLbl.bottom+5, 60, self.orderMobilePhoneLbl.height);
    
    self.orderMobilePhoneContentLbl.frame = CGRectMake(self.orderMobilePhoneLbl.right+10,self.orderPlacerNamesLbl.bottom+5, 100, self.orderMobilePhoneContentLbl.height);
    
    self.orderAdressLbl.frame = CGRectMake(self.orderMobilePhoneLbl.left,self.orderMobilePhoneLbl.bottom+5, 60, self.orderAdressLbl.height);
    
    //self.orderAdressContentLbl.frame = CGRectMake(self.orderAdressLbl.right+10,self.orderMobilePhoneLbl.bottom+5, 190, self.orderAdressLbl.height*2);
    
    UIFont *font = [UIFont boldSystemFontOfSize:14];
    
    CGSize size = CGSizeMake(190, 200);
    
    CGSize laberSize = [_detailDTO.address sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    
    CGRect addressFrame = CGRectMake(self.orderAdressLbl.right+10, self.orderMobilePhoneLbl.bottom+5, laberSize.width, laberSize.height);
    
    self.orderAdressContentLbl.frame = addressFrame;
	
}

@end
