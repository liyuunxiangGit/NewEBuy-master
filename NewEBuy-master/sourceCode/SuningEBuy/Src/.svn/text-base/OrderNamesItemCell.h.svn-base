//
//  OrderNamesItemCell.h
//  SuningEBuy
//
//  Created by wanghongwei on 11-10-8.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UITableViewCellEx.h"
#import "MemberOrderNamesDTO.h"


@interface OrderNamesItemCell : UITableViewCellEx {
    
    //section 1:订单详情
    //订单状态
    UILabel *_orderStatusLbl;
    UILabel *_orderStatusContentLbl;
    
    //下单时间
    UILabel *_lastUpdateLbl;	
	UILabel *_lastUpdateContentLbl;
    
    //应付金额
    UILabel *_prepayAmountLbl;    
    UILabel *_prepayAmountContentLbl;
    
    //支付方式
    UILabel *_policeDescLbl;
    UILabel *_policeDescContentLbl;
    
    MemberOrderNamesDTO   *_namesItem;
    
}

@property(nonatomic,strong) UILabel *orderStatusLbl;
@property(nonatomic,strong) UILabel *orderStatusContentLbl;

@property(nonatomic,strong) UILabel *lastUpdateLbl;	
@property(nonatomic,strong) UILabel *lastUpdateContentLbl;

@property(nonatomic,strong) UILabel *prepayAmountLbl;    
@property(nonatomic,strong) UILabel *prepayAmountContentLbl;

@property(nonatomic,strong) UILabel *policeDescLbl;
@property(nonatomic,strong) UILabel *policeDescContentLbl;

@property(nonatomic,strong) MemberOrderNamesDTO *namesItem;

@property(nonatomic,copy) NSString *prepayTrueAmount;

-(void)setNamesItem:(MemberOrderNamesDTO *)anamesItem;
-(void)customizeTopTableViewCell:(UITableViewCell *)cell;

@end
