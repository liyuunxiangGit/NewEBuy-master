//
//  CategoryViewCell.h
//  SuningEBuy
//
//  Created by 周俊杰 on 13-12-23.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "V2FristCategoryDTO.h"

@interface CategoryViewCell : SNUITableViewCell
{
	UILabel                *_kindNameLbl;
    UILabel                *_kindDesLbl;
	EGOImageView           *_menuImageView;
	V2FristCategoryDTO     *_item;
}
@property(nonatomic,strong) UILabel            *kindNameLbl;
@property(nonatomic,strong) UILabel            *kindDesLbl;
@property(nonatomic,strong) EGOImageView       *menuImageView;
@property(nonatomic,strong) V2FristCategoryDTO *item;
@property(nonatomic, strong) UIImageView *cellSeparatorLine;
@property (nonatomic, strong) UIImageView *leftArrow;
@property (nonatomic, strong) UIImageView *verticalLine; //用于二级分类的左边线
- (void)setItem:(V2FristCategoryDTO *)aItem;
@end
