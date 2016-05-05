//
//  OrderListItemCell.h
//  SuningEBuy
//
//  Created by zhaojw on 11-9-28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UITableViewCellEx.h"

#import "MemberOrderNamesDTO.h"

@interface OrderListItemCell : UITableViewCellEx {
	
	
	UILabel *_orderIDLbl;
	
	UILabel *_orderIDContentLbl;
	
	
	UILabel *_orderTimeLbl;
	
	UILabel *_orderTimeContentLbl;
	
	UILabel *_orderStatusLbl;
	
	UILabel *_orderStatusContentLbl;
	
	UILabel *_orderPriceLbl;
	
	UILabel *_orderPriceContentLbl;
	
	MemberOrderNamesDTO *_item;
		
}
@property(nonatomic,strong) UILabel    *orderIDLbl;
@property(nonatomic,strong) UILabel    *orderIDContentLbl;
@property(nonatomic,strong) UILabel    *orderTimeLbl;
@property(nonatomic,strong) UILabel    *orderTimeContentLbl;
@property(nonatomic,strong) UILabel    *orderStatusLbl;
@property(nonatomic,strong) UILabel    *orderStatusContentLbl;
@property(nonatomic,strong) UILabel    *orderPriceLbl;
@property(nonatomic,strong) UILabel    *orderPriceContentLbl;

@property(nonatomic,strong) MemberOrderNamesDTO *item;

-(void) setItem:(MemberOrderNamesDTO *)aItem;

+ (CGFloat) height:(MemberOrderNamesDTO *)item;

@end
