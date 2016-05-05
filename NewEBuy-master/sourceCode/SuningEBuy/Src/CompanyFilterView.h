//
//  CompanyFilterView.h
//  SuningEBuy
//
//  Created by shasha on 12-5-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QueryConditionDTO.h"
#import "IndicatorButton.h"

@protocol CompanyFilterViewDelegate ;

@interface CompanyFilterView : UIView <UITableViewDataSource,UITableViewDelegate>

//黑色半透明的背景
@property(nonatomic,strong) UIButton       *backButon;
//白色背景
@property(nonatomic,strong) UIImageView    *backGroudView;

@property(nonatomic,strong) UIView         *tableBackView;
@property(nonatomic,strong) UITableView    *companyFilterTableView;

@property(nonatomic,strong) NSArray        *companyList;
@property(nonatomic,strong) NSString       *companyId;

/*!
 时间选择
 */
@property(nonatomic,strong) IndicatorButton    *timeButton;
@property(nonatomic,strong) IndicatorButton    *backDayButton;
@property(nonatomic,strong) IndicatorButton    *nextDayButtton;

@property(nonatomic,weak) id<CompanyFilterViewDelegate>  filterDelegate; 

@property(nonatomic,strong) QueryConditionDTO  *queryDTO;


- (void)changeTime:(NSString *)dateStr;

- (void)sendProductDetailHttpReqeust;

@end

@protocol CompanyFilterViewDelegate <NSObject>

- (void)chooseCompanyFilter:(NSString *)companyId;

- (void)chooseFlightDate;

@end
