//
//  CategoryViewController.h
//  SuningEBuy
//
//  Created by li xiaokai on 13-4-10.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CategoryService.h"
#import "SecondCategoryMarkView.h"


@interface CategoryViewController : CommonViewController<CategoryServiceDelegate,SecondCategoryMarkViewDelegate, UINavigationControllerDelegate>{
    
    
    NSInteger iOpenCell;  //-1表示 没有展开 0，1...表示已经展开的cell
}

@property (nonatomic, strong) CategoryService  *cateService;

@end
