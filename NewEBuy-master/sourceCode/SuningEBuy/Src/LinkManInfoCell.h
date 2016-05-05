//
//  LinkManInfoCell.h
//  SuningEBuy
//
//  Created by jian  zhang on 12-7-2.
//  Copyright (c) 2012年 nanjing. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LinkManInfoCellDelegete;

@interface LinkManInfoCell : SNUITableViewCell<UITextFieldDelegate>
{
    
}


@property (nonatomic, strong) UILabel           *username;
@property (nonatomic, strong) UITextField       *usernameTextField;


@property (nonatomic, strong) UILabel           *phoneNum;
@property (nonatomic, strong) UITextField       *phoneNumTextField;

@property (nonatomic, assign)     BOOL hasAddLine;
@property (nonatomic, weak) id<LinkManInfoCellDelegete> delegate;

- (void)initLinkManInfo;


@end



@protocol LinkManInfoCellDelegete <NSObject>

@optional
- (void)sendLinkManName:(NSString *)username;
- (void)sendLinkManPhoneNum:(NSString *)phoneNum;

@end
