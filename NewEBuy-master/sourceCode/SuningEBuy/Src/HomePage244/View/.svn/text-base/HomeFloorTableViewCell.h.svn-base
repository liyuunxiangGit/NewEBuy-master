//
//  HomeFloorTableViewCell.h
//  SuningEBuy
//
//  Created by zhangbeibei on 14-9-23.
//  Copyright (c) 2014年 Suning. All rights reserved.
//  楼层cell


#define KTitleHeight 40
#define KSpace 15


#import "SNUITableViewCell.h"
#import "HomeFloorDTO.h"
#import "HomeModuleDTO.h"


@protocol HomeFloorTableViewCellDelegate <NSObject>

@optional
- (void)selectModuleDTO:(HomeModuleDTO *)dto;

@end

@interface HomeFloorTableViewCell : SNUITableViewCell <EGOImageViewExDelegate>{

}

//楼层DTO
@property (nonatomic, strong) HomeFloorDTO *floorDTO;
@property (nonatomic, assign) id<HomeFloorTableViewCellDelegate> delegate;


/**
 *  更新界面
 *
 *  @param array 模块列表
 */
- (void)updateViewWithFloorDTO:(HomeFloorDTO *)dto;
@end


