//
//  OrderNamesItemCell.m
//  SuningEBuy
//
//  Created by wanghongwei on 11-10-8.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "OrderNamesItemCell.h"
#import "orderHttpDataSource.h"

@implementation OrderNamesItemCell

@synthesize orderStatusLbl=_orderStatusLbl;
@synthesize orderStatusContentLbl = _orderStatusContentLbl;

@synthesize lastUpdateLbl=_lastUpdateLbl;
@synthesize lastUpdateContentLbl=_lastUpdateContentLbl;

@synthesize prepayAmountLbl=_prepayAmountLbl;
@synthesize prepayAmountContentLbl=_prepayAmountContentLbl;

@synthesize policeDescLbl=_policeDescLbl;
@synthesize policeDescContentLbl=_policeDescContentLbl;

@synthesize namesItem = _namesItem;
@synthesize prepayTrueAmount = _prepayTrueAmount;


- (id) initWithReuseIdentifier:(NSString *)reuseIdentifier{
	self = [super initWithReuseIdentifier:reuseIdentifier];
	if (self) {
		self.backgroundColor = [UIColor cellBackViewColor];
	}
	
	return self;
}

-(void)dealloc{
    
	TT_RELEASE_SAFELY(_orderStatusLbl);
	TT_RELEASE_SAFELY(_orderStatusContentLbl);
	
	TT_RELEASE_SAFELY(_lastUpdateLbl);	
	TT_RELEASE_SAFELY(_lastUpdateContentLbl);
	
	TT_RELEASE_SAFELY(_prepayAmountLbl);
	TT_RELEASE_SAFELY(_prepayAmountContentLbl);
	
	TT_RELEASE_SAFELY(_policeDescLbl);	
	TT_RELEASE_SAFELY(_policeDescContentLbl);
    TT_RELEASE_SAFELY(_prepayTrueAmount);
    
}

-(void)setNamesItem:(MemberOrderNamesDTO *)anamesItem {
	
	if (anamesItem != _namesItem) {
		
		
        _namesItem  = anamesItem;
        
        [self customizeTopTableViewCell:self];
        
        for (int i=0; i<4; i++) {
            UILabel	*label=(UILabel *)[self.contentView viewWithTag:i+10];
            UILabel	*value=(UILabel *)[self.contentView viewWithTag:i+14];
            value.textColor=[UIColor colorWithRed:0/255.0 green:51/255.0 blue:153/255.0 alpha:1.0];
            switch (i) {
                case 0:
                {
                    label.text	=	L(@"Order Status:");
                    self.orderStatusLbl = label;
                    value.text = [orderHttpDataSource getOrderTypeInfo:_namesItem.oiStatus];
                    self.orderStatusContentLbl = value;
                    break;
                }
                case 1:
                {
                    label.text	=	L(@"Amount due:");
                    self.prepayAmountLbl = label;
                    value.textColor=[UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1.0];
                    NSNumberFormatter *priceFormatter = [[NSNumberFormatter alloc] init];
                    
                    [priceFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
                    
//                    NSString	*marketPrice = [NSString stringWithFormat:@"￥%.2f", [_namesItem.prepayAmount floatValue]];
                    NSString	*marketPrice = [NSString stringWithFormat:@"￥%.2f", [self.prepayTrueAmount floatValue]];
                    value.text = marketPrice;
                    TT_RELEASE_SAFELY(priceFormatter);
                    self.prepayAmountContentLbl = value;
                    break;
                }
                case 2:
                {
                    label.text	=	L(@"Order time:");
                    self.lastUpdateLbl = label;
                    
                    value.text	= _namesItem.lastUpdate;
                    self.lastUpdateContentLbl = value;
                    break;
                }
                case 3:
                {
                    label.text	=	L(@"Payment:");
                    self.policeDescLbl = label;
                    value.text	= _namesItem.policyDesc;
                    self.policeDescContentLbl = value;
                    break;
                }
                default:
                {
                    break;
                }
            }
        }
        
        [self setNeedsLayout];
    }
    
}

-(void) layoutSubviews{
	
	[super layoutSubviews];
 
	
}

//自定义表格 customize top cell
-(void)customizeTopTableViewCell:(UITableViewCell *)cell
{
	//添加自定义标签
	for (int i=0; i<4; i++) {
		CGRect labelRect ;
		if (i<2) {
			labelRect = CGRectMake(15,i*25+5 , 55, 20);
		}else if(i == 2){
			labelRect = CGRectMake(140,(i-2)*25+5 , 65, 20);
		}else {
			labelRect = CGRectMake(15,55 , 55, 20);
		}
        
		
		UILabel *label = [[UILabel alloc] initWithFrame:labelRect];
		label.textAlignment = UITextAlignmentLeft;
		label.font = [UIFont boldSystemFontOfSize:12];
        label.backgroundColor = [UIColor clearColor];
		label.tag = i+10;
		[cell.contentView addSubview:label];
	}
	
	//添加自定义标签(显示内容)
	for (int i=0; i<4; i++) {
		CGRect contentValueRect ;
		if (i<2) {
			contentValueRect = CGRectMake(70,i*25+5 , 68, 20);
		}else if(i == 2) {
			contentValueRect = CGRectMake(200,(i-2)*25+5 , 90, 20);
		}else {
			contentValueRect = CGRectMake(70,55 , 200, 20);
		}
        
		
		UILabel *contentValue = [[UILabel alloc] initWithFrame:contentValueRect];
		contentValue.textAlignment = UITextAlignmentLeft;
		contentValue.font = [UIFont boldSystemFontOfSize:12];
        contentValue.backgroundColor = [UIColor clearColor];
		contentValue.tag = i+14;
		[cell.contentView addSubview:contentValue];
	}
}



@end
