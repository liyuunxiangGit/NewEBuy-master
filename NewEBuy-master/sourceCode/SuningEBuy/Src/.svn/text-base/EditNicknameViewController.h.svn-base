//
//  EditNicknameViewController.h
//  SuningEBuy
//
//  Created by jian  zhang on 12-7-27.
//  Copyright (c) 2012年 nanjing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"
#import "CommonViewController.h"
#import "EditNickNameService.h"

@protocol EditNicknameDelegate;

@interface EditNicknameViewController : CommonViewController<UITextFieldDelegate,EditNickNameServiceDelegate>
{
    
    ASIFormDataRequest   *editNicknameASIHTTPRequest;
    
}
@property (nonatomic, strong) EditNickNameService      *service;

@property (nonatomic, weak) id<EditNicknameDelegate> delegate;

@end

@protocol EditNicknameDelegate <NSObject>

@optional
- (void)editNickNameOK;

@end
