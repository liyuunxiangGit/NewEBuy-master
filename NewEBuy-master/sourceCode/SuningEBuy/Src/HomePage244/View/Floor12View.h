//
//  Floor12View.h
//  SuningEBuy
//
//  Created by zhangbeibei on 14-9-27.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeFloorDTO.h"
#import "HomeModuleDTO.h"
#import "HomeFloorTableViewCell.h"

@interface Floor12View : UIView <EGOImageViewExDelegate, UIScrollViewDelegate>{
    UIScrollView        *imageScrollView;
    
}

@property (nonatomic, strong) HomeFloorDTO *floorDTO;
@property (nonatomic, assign) id<HomeFloorTableViewCellDelegate> delegate;

- (void)updateViewWithFloorDTO:(HomeFloorDTO *)dto;

@end
