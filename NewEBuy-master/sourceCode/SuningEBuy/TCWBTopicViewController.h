//
//  TCWBTopicViewController.h
//  TCWeiBoSDKDemo
//
//  Created by Cui Zhibo on 12-8-20.
//  Copyright (c) 2012年 bysft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCWBRebroadcastMsgViewController.h"
@protocol topicViewControllerDetegate <NSObject>

- (void)topicViewsubTitle:(NSString *)title;

@end

@interface TCWBTopicViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate> {
        
    NSMutableArray *arrTopic;
    NSMutableArray *arrSearchedTopic;
    BOOL bSearching;
    
    TCWBRebroadcastMsgViewController *rebroadcastviewController;
    
}



- (BOOL)setTopic:(NSArray *)arrTopic;
- (BOOL)setRebroadcatstMsgViewController:(TCWBRebroadcastMsgViewController *)rebroadcastMsg;

@end
