//
//  TCWBFriendViewController.h
//  TCWeiBoSDKDemo
//
//  Created by Cui Zhibo on 12-8-20.
//  Copyright (c) 2012年 bysft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCWBEngine.h"
#import "TCWBRebroadcastMsgViewController.h"

@interface TCWBFriendViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>{
    
    NSMutableArray *arrFriend;
    NSMutableArray *arrIndexFriend;
    NSMutableArray *arrSearchFriend;
    
    BOOL bSearchFriend;
    
    NSMutableString *strUserName;
    TCWBRebroadcastMsgViewController *rebroadcastviewController;
    
    NSMutableArray *arrMutualFriend;
    NSMutableArray *arrIntimateFriend;
    
    NSMutableArray *arrLoadQueue;
    
}


- (BOOL)setUserName:(NSString *)userName;
- (BOOL)setRebroadcatstMsgViewController:(TCWBRebroadcastMsgViewController *)rebroadcastMsg;

- (BOOL)setFriend:(NSArray *)arrMutualFriend intimateFriend:(NSArray *)arrIntimateFriend;
- (BOOL)isLoadingHead:(NSString *)headURL loadQueue:(NSArray *)arrLoadQueue;

- (void)loadHeadForOnScreen:(BOOL)bSearch;


- (UITableViewCell *)createFriendCell:(UITableView *)tableView identifier:(NSString *)strIdentifier  indexPath:(NSIndexPath *)indexPath data:(NSMutableDictionary *)dicItem;

- (UITableViewCell *)createKeyCell:(UITableView *)tableView identifier:(NSString *)strIdentifier  data:(NSDictionary *)dicItem;


@end
