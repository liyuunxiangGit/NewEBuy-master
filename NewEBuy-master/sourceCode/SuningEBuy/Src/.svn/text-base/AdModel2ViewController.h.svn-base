//
//  AdModel2ViewController.h
//  SuningEBuy
//
//  Created by wei xie on 12-8-21.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InnerProductDTO.h"
#import "AdModelService.h"
#import "AdActiveRuleCell.h"

@interface AdModel2ViewController : CommonViewController <AdModelServiceDelegate,AdActiveRuleCellDelegate>
{
    BOOL                 _isHaveLoaded;
    
    NSString             *advertiseId_;
    NSArray              *innerProductList_;
    NSString             *activeName_;    
    NSString             *activeRule_;
    UITableView          *innerProductTableView_;
//    NSString             *activeInnerImageUrl_;
   
    
    CGFloat              AdActiveRuleCellHeight;

}

@property (nonatomic,strong) NSString             *bigBangName;//爆炸贴


@property (nonatomic,strong) NSString             *activeInnerImageUrl;

@property (nonatomic,strong) NSString             *advertiseId;

@property (nonatomic,strong) NSArray              *innerProductList;

@property (nonatomic,strong) NSArray              *serviceProductArr;

@property (nonatomic,strong) NSString             *activeName;

@property (nonatomic,copy) NSString             *activeRule;

@property (nonatomic,strong) UITableView          *innerProductTableView;

@property (nonatomic, assign) CGFloat              AdActiveRuleCellHeight;

@property (nonatomic, strong) UILabel            *emptyLabel;

- (id)initWithAdvertiseId:(NSString*)advertiseId;

- (CGFloat)getRuleHeight;

@end
