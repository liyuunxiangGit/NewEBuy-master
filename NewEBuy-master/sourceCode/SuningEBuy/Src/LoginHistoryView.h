//
//  LoginHistoryView.h
//  SuningEBuy
//
//  Created by  zhang jian on 13-8-21.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonView.h"

@protocol LoginHistoryViewDelegate;

@interface LoginHistoryView : CommonView<UITableViewDelegate,UITableViewDataSource>
{
    
}

@property (nonatomic ,strong) NSArray                       *loginList;
@property (nonatomic, weak) id<LoginHistoryViewDelegate>  delegate;

- (void)refreshNum:(NSArray *)numList;

@end

@protocol LoginHistoryViewDelegate <NSObject>

@optional
- (void)didSelectLoginNum:(NSString *)loginNum;

@end