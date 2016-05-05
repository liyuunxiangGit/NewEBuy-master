//
//  SNSpecialListViewController.h
//  SuningEBuy
//
//  Created by  zhang jian on 13-4-10.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SNActivityDTO.h"
#import "SNSpecialSubjectDTO.h"
#import "SNOnSaleActivityImageView.h"
#import "PageRefreshTableViewController.h"
#import "SpecialSubjectService.h"

@interface SNSpecialListViewController :PageRefreshTableViewController
<EGOImageViewDelegate, EGOImageViewExDelegate,SpecialSubjectServiceDelegate>

@property (nonatomic, strong) SNSpecialSubjectDTO   *specialSubjectDto;//专题数据模型
@property (nonatomic, strong) SpecialSubjectService *service;


@end