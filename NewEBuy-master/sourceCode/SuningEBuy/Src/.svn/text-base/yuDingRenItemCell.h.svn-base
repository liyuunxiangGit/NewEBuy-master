//
//  yuDingRenItemCell.h
//  SuningEBuy
//
//  Created by xy ma on 12-5-11.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UITableViewCellEx.h"
#import "keyboardNumberPadReturnTextField.h"

@protocol yuDingCellDelegate <NSObject>

@optional
- (void)sendPhone:(NSString *)phone;
- (void)sendName:(NSString *)name;

@end

@interface yuDingRenItemCell : UITableViewCellEx<UITextFieldDelegate>


@property(nonatomic,strong) UILabel        *yudingrenLbl;
@property(nonatomic,strong) UIView         *whiteBackView;
@property(nonatomic,strong) UITextField    *yuDingNameFld;
@property(nonatomic,strong) keyboardNumberPadReturnTextField    *yuDingPhoneFld;
@property(nonatomic,strong) UILabel    *yuDingNameLbl;
@property(nonatomic,strong) UILabel    *yuDingPhoneLbl;
@property(nonatomic,weak) id<yuDingCellDelegate> yuDingDelegate;


-(void) setItem:(NSString *)name andPhone:(NSString *)phone;

@end
