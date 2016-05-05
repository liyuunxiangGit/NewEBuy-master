//
//  EvaluationListViewController.h
//  SuningEBuy
//
//  Created by  zhang jian on 13-4-9.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewEvalutionService.h"
#import "EvalutionListCell.h"
#import "PageRefreshTableViewController.h"
#import "ProductDetailSubmitService.h"

@interface EvaluationListViewController : PageRefreshTableViewController<NewEvalutionServiceDelegate,ProductDetailSubmitServiceDelegate>
{
    
}

@property (nonatomic, strong) NSMutableArray            *evalutionList;
@property (nonatomic, strong) NewEvalutionService       *evalutionService;
@property (nonatomic, strong) ProductDetailSubmitService *displayorderService;

@property (nonatomic, strong) UILabel                   *emptyLabel;

@end
