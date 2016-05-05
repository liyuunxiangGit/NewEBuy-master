//
//  QueryPlaneViewController.h
//  SuningEBuy
//
//  Created by lanfeng on 12-5-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityListViewController.h"
#import "QueryPlaneCell.h"
#import "CalendarViewController.h"
#import "QueryConditionDTO.h"
#import "FlightListViewController.h"
#import "PlaneSegement.h"

@interface QueryPlaneViewController : CommonViewController<CityListViewControllerProtocol,CalendarViewControllerDelegate,PlaneSegementDelegate>
{
    UITableView *tpTableView_;
    
    NSMutableArray     *_itemsArray;
    
    NSMutableArray     *_itemsValueArray;
    
    BOOL               isRoundTripTicket;
    
    UIView             *_footView;

    UIButton           *_queryBtn;
    
    NSString           *_queryDate;
    
}

@property (nonatomic,retain) PlaneSegement  *segement;
@property (nonatomic,retain) UIView         *footView;
@property (nonatomic,retain) UIButton       *queryBtn;
@property (nonatomic,copy)   NSString       *queryDate;

@property (nonatomic,retain) NSMutableArray  *itemsArray;
@property (nonatomic,retain) NSMutableArray  *itemsValueArray;

@property (nonatomic,retain) NSDate *beginDate;
@property (nonatomic,retain) NSDate *backDate;

-(void)presentViewController;

@end
