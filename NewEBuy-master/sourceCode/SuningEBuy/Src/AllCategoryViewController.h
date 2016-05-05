//
//  AllCategoryViewController.h
//  SuningEBuy
//
//  Created by 周俊杰 on 13-12-20.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "CategoryService.h"

@class NextCategoryViewController;
@interface AllCategoryViewController : CommonViewController <CategoryServiceDelegate>
@property (nonatomic, assign) BOOL bShowingNextCata;
@property (nonatomic, strong) CategoryService  *cateService;
@property (nonatomic, strong) NextCategoryViewController *nextCataViewController; //二，三级分类页面
@property (nonatomic, assign) BOOL bShowSepLine;
@property (nonatomic, assign) NSInteger selectedRow;
@end
