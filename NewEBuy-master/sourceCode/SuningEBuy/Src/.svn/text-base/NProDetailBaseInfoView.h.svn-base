//
//  NProDetailBaseInfoView.h
//  SuningEBuy
//
//  Created by xmy on 20/12/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewProductInfoDescribeCell.h"
#import "NProParamHeadCell.h"
#import "NProDetailParameterViewCell.h"
#import "DataProductBasic.h"
#import "NProDetailParameterNbookTableView.h"

@interface NProDetailBaseInfoView : UIView<UITableViewDataSource,UITableViewDelegate, UIScrollViewDelegate>
{
    BOOL  _isFoldParam;//商品参数
    BOOL  _isFoldPackList;//装箱清单
    BOOL  _isFold;//售后服务
}

@property (nonatomic, retain)NProDetailParameterViewCell        *parameterView;//图书商品参数tableView
@property (nonatomic, strong)NProDetailParameterNbookTableView  *parameterTableView;//非图书商品参数tableView

@property (nonatomic, strong)UITableView                        *baseInfoTableV;
@property (nonatomic, strong)DataProductBasic                   *baseInfoDto;
@property (nonatomic, strong) NSArray                           *paraList;

- (void)setNProDetailBaseInfoViewData:(NSArray*)arr;

+ (CGFloat)NProDetailBaseInfoViewHeight:(DataProductBasic*)dto WithArr:(NSArray*)arr;

@end
