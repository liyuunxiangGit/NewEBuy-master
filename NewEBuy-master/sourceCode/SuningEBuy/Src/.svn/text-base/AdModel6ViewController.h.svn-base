//
//  AdModel6ViewController.h
//  SuningEBuy
//
//  Created by xmy on 19/7/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CommonViewController.h"

#import "AdModelService.h"
#import "AdActiveRuleCell.h"
#import "AdModel6Cell.h"

@interface AdModel6ViewController : CommonViewController <AdModelServiceDelegate,AdActiveRuleCellDelegate,Model6Delegate>
{
    BOOL                 _isHaveLoaded;
//    BOOL                 _IsFloor;
}

@property (nonatomic,strong) NSString            *activeInnerImageUrl;

@property (nonatomic,strong)NSString             *advertiseId;

@property (nonatomic,strong)NSArray              *innerProductList;

@property (nonatomic,strong) NSArray             *serviceProductArr;

@property (nonatomic,strong)NSString             *activeName;

@property (nonatomic,strong)UITableView          *innerProductTableView;

//@property (nonatomic, retain) AdModelService     *modelService;

//@property (nonatomic,retain)NSArray              *innerFloorList;//楼层
//
//@property (nonatomic, retain)UILabel             *floorLable;
@property (nonatomic, strong) UILabel            *emptyLabel;
@property (nonatomic,copy)NSString               *activeRule;
@property (nonatomic, assign) CGFloat              AdActiveRuleCellHeight;


- (id)initWithAdvertiseId:(NSString*)advertiseId;
- (CGFloat)getRuleHeight;


@end
