//
//  CitysFilterTableViewCell.h
//  SuningEBuy
//
//  Created by chupeng on 14-8-22.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressInfoDAO.h"
@class FilterPopupViewController;
@interface CitysFilterTableViewCell : UITableViewCell<UITableViewDataSource, UITableViewDelegate>
{
    NSInteger selectCityIndex;
    NSInteger selectedSectionIndex; //被选中的section
    BOOL      selectedSectionOpened; //被选中的section是否已经展开
}

@property (nonatomic, assign) FilterPopupViewController *filterCtrl;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *provinceList;
@property (nonatomic, strong) NSMutableDictionary *dicProvinceCodeToCitys;
@end
