//
//  AdModel3ViewController.h
//  SuningEBuy
//
//  Created by wei xie on 12-8-21.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AdModel3Cell.h"
#import "AdModelService.h"
#import "AdActiveRuleCell.h"
#import "AdModel6Cell.h"

@interface AdModel3ViewController : CommonViewController <Model3Delegate,AdModelServiceDelegate,AdActiveRuleCellDelegate,Model6Delegate>
{
    BOOL                 _isHaveLoaded;
    
    NSString             *_advertiseId;
    NSArray              *_innerProductList;
    NSString             *_activeName;    
    NSString             *_activeRule;
    UITableView          *_innerProductTableView;
//    NSString             *activeInnerImageUrl_;
    
    
    CGFloat              AdActiveRuleCellHeight;
    
}

@property (nonatomic,strong) NSString             *activeInnerImageUrl;

@property (nonatomic,strong)NSString             *advertiseId;

@property (nonatomic,strong)NSArray              *innerProductList;

@property (nonatomic,strong) NSArray              *serviceProductArr;

@property (nonatomic,strong)NSString             *activeName;

@property (nonatomic,copy)NSString               *activeRule;

@property (nonatomic,strong)UITableView          *innerProductTableView;

@property (nonatomic, assign) CGFloat              AdActiveRuleCellHeight;

@property (nonatomic, strong) UILabel            *emptyLabel;

- (id)initWithAdvertiseId:(NSString*)advertiseId;

- (CGFloat)getRuleHeight;

@end
