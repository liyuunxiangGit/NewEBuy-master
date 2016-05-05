//
//  ScanSearchView.h
//  SuningEBuy
//
//  Created by 孔斌 on 13-8-20.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CommonView.h"

@interface ScanSearchView : CommonView

@property (nonatomic, strong) UITableView       *scanTableView;

@property (nonatomic, strong) UILabel           *noScanHistoryLabel;

@property (nonatomic, strong) UIView            *delAllScanButtonView; //target: clearScanSearchHistorys


@end
