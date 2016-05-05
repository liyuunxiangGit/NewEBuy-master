//
//  SNOnSaleViewController.h
//  SuningEBuy
//
//  Created by 芳奎 赵 on 12-9-18.
//  Copyright (c) 2012年 苏宁. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SNActivityDTO.h"
#import "SNSpecialSubjectDTO.h"
#import "SNOnSaleActivityImageView.h"
#import "PageRefreshTableViewController.h"
#import "BBScrollViewController.h"
#import "SpecialSubjectService.h"

@interface SNSpecialSubjectViewController :PageRefreshTableViewController
<EGOImageViewDelegate, EGOImageViewExDelegate, BBScrollContentApperace,SpecialSubjectServiceDelegate>

@property(nonatomic,strong) SNSpecialSubjectDTO *specialSubjectDto;//专题数据模型
@property(nonatomic, strong)SpecialSubjectService *service;
@property (nonatomic, strong)UINavigationController *superViewController;

@property (nonatomic, strong) UILabel           *emptyLabel;

@end