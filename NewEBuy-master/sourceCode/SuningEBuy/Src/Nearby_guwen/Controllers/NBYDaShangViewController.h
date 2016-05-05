//
//  NBYDaShangViewController.h
//  SuningEBuy
//
//  Created by suning on 14-9-29.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "NBCommonViewController.h"

#import "NBDefineHeader.h"

@interface NBYDaShangViewController : NBCommonViewController

@property (nonatomic,strong) NSDictionary *stickItem;

@property (nonatomic,copy) nb_dispatch_block_t2 updateCommentNumBlock;

@end
