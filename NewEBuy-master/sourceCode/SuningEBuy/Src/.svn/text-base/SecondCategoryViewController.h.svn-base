//
//  SecondCategoryViewController.h
//  SuningEBuy
//
//  Created by shasha on 12-8-23.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "CategoryService.h"
#import "RedbabyAndCosmeticsCell.h"

typedef enum {

    RedBabyCategory    =    1,     //红孩子
    CosmeticsCategory,           //化妆品 缤纷购
    BookCategory,
    
}SecondCategoryType;


@interface SecondCategoryViewController : CommonViewController<CategoryServiceDelegate,RedbabyAndCosmeticsCellDelegate>

@property (nonatomic, strong) CategoryService  *service;

@property (nonatomic)  SecondCategoryType  categoryType;

@property (nonatomic,strong)UIImageView *tableBackground;


- (id)initWithCategoryType:(SecondCategoryType)type;
@end
