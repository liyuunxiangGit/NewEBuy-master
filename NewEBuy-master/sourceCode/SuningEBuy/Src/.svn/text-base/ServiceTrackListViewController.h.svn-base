//
//  ServiceTrackListViewController.h
//  SuningEBuy
//
//  Created by wei xie on 12-9-7.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingTableView.h"
#import "ServiceQueryDTO.h"
#import "PageRefreshTableViewController.h"
#import "ServiceTrackListService.h"
#import "keyboardNumberPadReturnTextField.h"

#import "NOrderListService.h"
#import "LoginViewController.h"
@interface ServiceTrackListViewController : PageRefreshTableViewController<UITextFieldDelegate,ServiceTrackListServiceDelegate,NOrderListServiceDelegate>
{
    TPKeyboardAvoidingTableView *_tpkTableView;
    
    UITextField                 *_memberTextField;
    keyboardNumberPadReturnTextField                 *_marketNumTextField;
    
    NSMutableArray              *_queryList;
    
    UIView                      *_loadMoreView;
}

@property (nonatomic, strong) TPKeyboardAvoidingTableView *tpkTableView;

@property (nonatomic, strong) UITextField                 *memberTextField;

@property (nonatomic, strong) keyboardNumberPadReturnTextField          *marketNumTextField;

@property (nonatomic, strong) NSMutableArray              *queryList;

@property (nonatomic, strong) UIView                      *loadMoreView;

@property (nonatomic, strong) UIView                      *backgroundView;

@property (nonatomic, strong) NOrderListService *orderListservice;


@end
