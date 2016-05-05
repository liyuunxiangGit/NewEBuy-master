//
//  TotalAmountCell.h
//  SuningEBuy
//
//  Created by DP on 3/11/12.
//  Copyright (c) 2012 __zhaofk__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UITableViewCellEx.h"
#import <UIKit/UIKit.h>
#import "MYEbuyCoumonDTO.h"
@interface TotalAmountCell : UITableViewCellEx{
    
    
    //易购券余额 格式“280.00”
    UILabel    *_totalAmountLbl;
    
    //"易购券余额" 格式“易购券余额”
    UILabel    *_desTotalAmountLbl;
    
    //"易购券余额" 格式“元”
    UILabel    *_desRmbLbl;
    
}
@property(nonatomic,strong) UILabel    *totalAmountLbl;
@property(nonatomic,strong) UILabel    *desTotalAmountLbl;
@property(nonatomic,strong) UILabel    *desRmbLbl;

/*给cotroller中的全局变量“totalAmount”付值
 param aItem
 description:
 1 从请求ok返回结果中，提取“totalamount” 值，付值给cotroller中的全局变量
 
 */
-(void) setItem:(NSString *)aItem;

@end
