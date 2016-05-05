//
//  AdModel4ViewController.h
//  SuningEBuy
//
//  Created by wei xie on 12-8-21.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AdModel3Cell.h"
#import "AdModelService.h"
#import "AdActiveRuleCell.h"
#import "AdModel4Cell.h"

@interface AdModel4ViewController : CommonViewController<Model3Delegate,AdModelServiceDelegate,AdActiveRuleCellDelegate,Model4Delegate>{
    
    BOOL                 _isHaveLoaded;
    
    NSString             *advertiseId_;
    
    NSArray              *innerProductList_;
    
    NSArray              *innerAdList_;
    
    NSString             *activeName_;    
    
    NSString             *activeRule_;
    
    UITableView          *innerProductTableView_;
    
    EGOImageViewEx       *innerAdImageView_;
    
    int                  setionCount;
    
    CGFloat              AdActiveRuleCellHeight;

}

@property (nonatomic,strong)NSString             *advertiseId;
@property (nonatomic,strong)NSArray              *innerProductList;
@property (nonatomic,strong)NSArray              *innerAdList;
@property (nonatomic,strong) NSArray             *serviceProductArr;
@property (nonatomic,strong)NSString             *activeName;
@property (nonatomic,copy)  NSString             *activeRule;
@property (nonatomic,strong)UITableView          *innerProductTableView;
@property (nonatomic,strong) EGOImageViewEx      *innerAdImageView;
@property (nonatomic, assign) CGFloat            AdActiveRuleCellHeight;

@property (nonatomic,strong) NSString            *activeInnerImageUrl;

@property (nonatomic, strong) UILabel            *emptyLabel;

- (id)initWithAdvertiseId:(NSString*)advertiseId;

- (CGFloat)getRuleHeight;

@end
