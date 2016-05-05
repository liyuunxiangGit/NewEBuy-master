//
//  NBCommentTableCell.h
//  suningNearby
//
//  Created by suning on 14-8-4.
//  Copyright (c) 2014年 suning. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NBCommentTableCell : UITableViewCell

@property (nonatomic,strong) NSDictionary *commentItem;

@property (nonatomic,weak)   NSIndexPath  *idxPath;

+ (NBCommentTableCell *)cell;

@end