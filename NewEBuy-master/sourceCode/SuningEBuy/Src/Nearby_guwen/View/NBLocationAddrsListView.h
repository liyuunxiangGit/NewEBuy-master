//
//  NBLocationAddrsListView.h
//  suningNearby
//
//  Created by suning on 14-8-5.
//  Copyright (c) 2014年 suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NBDefineHeader.h"

@class BMKPoiInfo;

@interface BMKPoiBean : NSObject
@property (nonatomic,assign) BOOL isSelected;
@property (nonatomic,assign) double distance;
@property (nonatomic,strong) BMKPoiInfo *poi;
@end



@class CommonViewController;

@interface NBLocationAddrsListView : UIView

@property (nonatomic,weak) CommonViewController *parentCtrler;

@property (nonatomic,copy) nb_dispatch_block_t2 selectedBlock;

@property (nonatomic,strong) NSArray *sourceArray;

@end
