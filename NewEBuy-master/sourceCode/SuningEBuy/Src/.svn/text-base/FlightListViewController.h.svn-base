//
//  FlightListViewController.h
//  SuningEBuy
//
//  Created by shasha on 12-5-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QueryConditionDTO.h"
#import "IndicatorButton.h"
#import "CompanyFilterView.h"
#import "FlightListTitleView.h"
#import "QueryTicketInfoService.h"
#import "FlightListFilterView.h"

@interface FlightListViewController : CommonViewController<CompanyFilterViewDelegate,FlightInfoDelegate,FlightListFilterViewDelegate>{
    
    BOOL               isLoaded;
    BOOL               isReturnLoaded;
        
    //yes：往返类型，no：单程
    BOOL               isGoBack;
    
}


@property(nonatomic,assign)BOOL          isBackView;

@property(nonatomic,strong) QueryConditionDTO  *queryDTO;
 
@property(nonatomic,strong) UILabel     *noResult;

@property(nonatomic,strong) NSMutableArray *selectedArr;

@property(nonatomic,strong) CompanyFilterView *companyFilterView; 

@property(nonatomic,strong) FlightListTitleView  *titleView;

@property(nonatomic,strong) QueryTicketInfoService *ticketinfoService;

@property (nonatomic, strong) FlightListFilterView  *filterView;

- (id)initWithQueryDTO:(QueryConditionDTO*)queryDTO;


@end

