//
//  DJGroupListViewController.h
//  SuningEBuy
//
//  Created by xie wei on 13-7-8.
//  Copyright (c) 2013年 Suning. All rights reserved.
//  单价团商品列表

#import <UIKit/UIKit.h>
#import "PageRefreshTableViewController.h"
#import "DJGroupItemCell.h"
#import "DJGroupListService.h"
#import "CustomSegment.h"

typedef enum{
    MainChannel = 1,
    MobileChannel = 2,
} GroupChannel;

@interface DJGroupListViewController : PageRefreshTableViewController </*DJGroupItemCellDelegate,*/DJListServiceDelegate,UITextViewDelegate,CustomSegmentDelegate>
{
     BOOL isClik;
     CGFloat      startY;
     NSString     *__lastActId;
    BOOL isClickingRight;
}

@end
