//
//  CommonView.h
//  SuningEBuy
//
//  Created by 刘坤 on 12-8-17.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingTableView.h"
#import "CommonViewController.h"

@interface CommonView : UIView
{
    UITableView             *_tableView;
    
    UITableView             *_groupTableView;
    
    TPKeyboardAvoidingTableView     *_tpTableView;
    
    id    __weak _owner;
}

@property (nonatomic, weak) id  owner;

@property (nonatomic, strong) UITableView       *tableView;

@property (nonatomic, strong) UITableView       *groupTableView;

@property (nonatomic, strong) TPKeyboardAvoidingTableView       *tpTableView;


- (id)initWithOwner:(id)owner;


@end
