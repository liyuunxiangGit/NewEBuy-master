//
//  orderProductExpandItemCell.h
//  SuningEBuy
//
//  Created by wanghongwei on 11-10-10.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UITableViewCellEx.h"

#import "MemberOrderDetailsDTO.h"

@interface orderPlacerItemCell : UITableViewCellEx {
    
    UILabel *_orderPlacerNamesLbl;
    UILabel *_orderPlacerNamesContentLbl;
    
    UILabel *_orderMobilePhoneLbl;
    UILabel *_orderMobilePhoneContentLbl;
    
    UILabel *_orderAdressLbl;
    UILabel *_orderAdressContentLbl;
    
    MemberOrderDetailsDTO *_detailDTO;
        
}

@property(nonatomic,strong)    UILabel *orderPlacerNamesLbl;
@property(nonatomic,strong)    UILabel *orderPlacerNamesContentLbl;

@property(nonatomic,strong)    UILabel *orderMobilePhoneLbl;
@property(nonatomic,strong)    UILabel *orderMobilePhoneContentLbl;

@property(nonatomic,strong)    UILabel *orderAdressLbl;
@property(nonatomic,strong)    UILabel *orderAdressContentLbl;

@property(nonatomic,strong)    MemberOrderDetailsDTO *detailDTO;

-(void) setItem:(MemberOrderDetailsDTO *)aItem;
+ (CGFloat) height:(MemberOrderDetailsDTO *)item;
@end
