//
//  PayServiceQueryViewController.h
//  SuningEBuy
//
//  Created by 谢伟 on 12-9-29.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PageRefreshTableViewController.h"
#import "PayServiceQueryService.h"
#import "AllOrderListPageFreshViewController.h"


@protocol PayServiceQueryServiceDelegate;

@interface PayServiceQueryViewController : AllOrderListPageFreshViewController <PayServiceQueryServiceDelegate>
{
    NSString            *_typeCode;
    NSMutableArray      *_itemLists;
    PayServiceQueryService  *_payServiceQueryService;
    
}
@property (nonatomic) BOOL       isBottomView;//是否展示Bottom
@property (nonatomic, copy) NSString       *typeCode;
@property (nonatomic, strong) NSMutableArray *itemLists;
@property (nonatomic, strong) PayServiceQueryService  *payServiceQueryService;

@property (nonatomic,strong) UILabel *alertLbl;
@property (nonatomic,strong) UIImageView                 *alertImageV;

@end
