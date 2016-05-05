//
//  NProDetailParameterViewCell.h
//  SuningEBuy
//
//  Created by xmy on 23/12/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductParaDTO.h"

@interface NProDetailParameterViewCell : UITableViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain)NSArray *parameterArr;

- (void)loadParameterView:(NSArray *)paramList;

+ (CGFloat)height:(NSArray *)paramList;

@end
