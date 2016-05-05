//
//  OrderInvoiceItemCell.h
//  SuningEBuy
//
//  Created by wanghongwei on 11-10-10.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UITableViewCellEx.h"

#import "MemberOrderDetailsDTO.h"


@interface OrderInvoiceItemCell : UITableViewCellEx {
    
    UILabel *_ordertaxTyperLbl;
    UILabel *_ordertaxTyperContentLbl;
    
    UILabel *_orderInvoiceLbl;
    UILabel *_orderInvoiceContentLbl;
    
    UILabel *_orderInvoiceDescriptionLbl;
    UILabel *_orderInvoiceDescriptionContentLbl;
    
    MemberOrderDetailsDTO *_detailDTO;
}

@property(nonatomic,strong)    UILabel *ordertaxTyperLbl;
@property(nonatomic,strong)    UILabel *ordertaxTyperContentLbl;

@property(nonatomic,strong)    UILabel *orderInvoiceLbl;
@property(nonatomic,strong)    UILabel *orderInvoiceContentLbl;

@property(nonatomic,strong)    UILabel *orderInvoiceDescriptionLbl;
@property(nonatomic,strong)    UILabel *orderInvoiceDescriptionContentLbl;

@property(nonatomic,strong)    MemberOrderDetailsDTO *detailDTO;

-(void) setItem:(MemberOrderDetailsDTO *)aItem;
+ (CGFloat) height:(MemberOrderDetailsDTO *)item;

@end
