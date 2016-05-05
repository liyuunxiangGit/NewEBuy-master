//
//  SNActivityViewController.h
//  SuningEBuy
//
//  Created by 家兴 王 on 12-10-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SNActivityDTO.h"
#import "PageRefreshTableViewController.h"
#import "SNActivityService.h"
#import "DMOrderDTO.h"
#import "AdActiveRuleCell.h"
#import "AdModel3Cell.h"

@interface SNActivityViewController : PageRefreshTableViewController<SNActivityServiceDelegate,AdActiveRuleCellDelegate,Model3Delegate>
{    
    BOOL                isHostSaleProductLoaded; 
    
    ASIFormDataRequest  *hotSaleASIHttpRequest;
    
    CGFloat              AdActiveRuleCellHeight;

}
@property (nonatomic, strong) NSString                      *activityId;
@property (nonatomic, strong) SNActivityDTO                 *activityDto;
@property (nonatomic ,strong) NSString                      *prdSortType;
@property (nonatomic, strong) DMOrderResultDTO              *dmDto;//如果是dm跳转时 此dto要赋值 其他情况不赋值

@property (nonatomic, strong) SNActivityService *service;

@property (nonatomic, assign) CGFloat              AdActiveRuleCellHeight;

@property (nonatomic, strong) UILabel           *emptyLabel;

@property (nonatomic, strong) UILabel            *emptyActiviLabel;

- (id)initWithActName:(NSString *)actName areaName:(NSString*)aAreaName;

- (CGFloat)getRuleHeight;

@end
