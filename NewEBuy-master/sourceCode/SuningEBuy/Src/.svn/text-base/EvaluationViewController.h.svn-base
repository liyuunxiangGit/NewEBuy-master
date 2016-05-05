//
//  EvaluationViewController.h
//  SuningEBuy
//
//  Created by 孔斌 on 13-8-23.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewEvalutionService.h"
#import "EvalutionListCell.h"
#import "PageRefreshTableViewController.h"
#import "ProductDetailSubmitService.h"
#import "AllOrderListViewController.h"

@interface EvaluationViewController : AllOrderListViewController<NewEvalutionServiceDelegate,ProductDetailSubmitServiceDelegate>

@property (nonatomic, strong) NSMutableArray            *evalutionList;
@property (nonatomic, strong) NewEvalutionService       *evalutionService;
@property (nonatomic, strong) ProductDetailSubmitService *displayorderService;

@property (nonatomic, strong) UILabel                   *emptyLabel;

@property (nonatomic, strong) UIView                    *emptyView;
@property (nonatomic, strong) UIImageView               *alertImageV;


@end
