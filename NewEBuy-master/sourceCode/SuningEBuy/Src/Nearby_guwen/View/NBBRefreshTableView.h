//
//  NBBRefreshTableView.h
//  suningNearby
//
//  Created by suning on 14-7-29.
//  Copyright (c) 2014年 suning. All rights reserved.
//
//  微拍生活 （图片列表，分组）

#import "UICCRefreshCommonTableView.h"
#import "NBDefineHeader.h"

@interface NBBRefreshTableView : UICCRefreshCommonTableView

@property (nonatomic,weak) CommonViewController *parentCtrler;
@property (nonatomic,weak) UIView               *parentView;

@property (nonatomic,strong) NSDictionary       *channel;

@property (nonatomic,copy) nb_dispatch_block_t2 distanceBlock;

// 刷新，重新请求 当前数据列表
- (void)refreshChannelDataList;

@end
