//
//  NBCommentsListViewController.h
//  suningNearby
//
//  Created by suning on 14-8-4.
//  Copyright (c) 2014年 suning. All rights reserved.
//
//  评论列表

#import "NBCommonViewController.h"

#import "NBDefineHeader.h"

@interface NBCommentsListViewController : NBCommonViewController

@property (nonatomic,strong) NSDictionary *stickItem;

@property (nonatomic,copy) nb_dispatch_block_t2 updateCommentNumBlock;

@end
