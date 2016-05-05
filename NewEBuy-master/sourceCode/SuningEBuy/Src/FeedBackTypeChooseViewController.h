//
//  FeedBackTypeChooseViewController.h
//  SuningEBuy
//
//  Created by xie wei on 13-5-29.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "SNPopoverCommonViewController.h"

//反馈类型
typedef enum {
    SNFeedBackFunction            = 1 << 0,
    SNFeedBackPage                = 1 << 1,
    SNFeedBackNewFunction         = 1 << 2,
    SNFeedBackConsult             = 1 << 3,
    SNFeedBackLogisticsConsult    = 1 << 4,
    SNFeedBackChangeGoodConsult   = 1 << 5,
    SNFeedBackOther               = 1 << 6,
    SNFeedBackAll                 = 127,
}SNFeedBackType;

@protocol ChooseFeedBackTypeDelegate <NSObject>

- (void)didChooseFeedBackType:(SNFeedBackType)feedBackType;

@end

@interface FeedBackTypeChooseViewController : SNPopoverCommonViewController

@property (nonatomic, weak) id<ChooseFeedBackTypeDelegate> delegate;
@property (nonatomic, assign) SNFeedBackType allType;

- (id)init:(NSInteger)selected;

@end
