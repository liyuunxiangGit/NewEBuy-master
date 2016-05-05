//
//  NextCategoryViewController.h
//  SuningEBuy
//
//  Created by 周俊杰 on 13-12-24.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "V2FristCategoryDTO.h"
#import "CategoryCell.h"
#import "HeadCategoryView.h"
#import "AllCategoryViewController.h"
@interface NextCategoryViewController : CommonViewController<CategoryBaseCellDelegate>
{
    V2FristCategoryDTO *_dto;
    UITableView        *_detailTableView;
    int                _detailSelectIndex;
    
    int                _secondSelectIndex;

    NSMutableArray * _categoryList;
    
    V2FristCategoryDTO *_actionDto;

}

@property (nonatomic , strong) V2FristCategoryDTO *dto;
@property (nonatomic , strong) UITableView        *detailTableView;
@property (nonatomic, strong) HeadCategoryView     *headCateView;

@property (nonatomic , strong) V2FristCategoryDTO *actionDto;
@property (nonatomic , copy) NSString *selectRow;
@property (nonatomic, weak) AllCategoryViewController *parentCtrl;
@property (nonatomic, assign) int iFirstCatatorySelectedRow;
@property (nonatomic, assign) int iSecondCatagorySelectedRow;

-(void)touchActionBnt:(id)sender;

-(void)pushWebWithUrl:(NSString*)strUrl;

@end
