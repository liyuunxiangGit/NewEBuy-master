//
//  LoginView.h
//  SuningEBuy
//
//  Created by 刘坤 on 12-8-17.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonView.h"

#import "OHAttributedLabel.h"
#import "NSAttributedString+Attributes.h"
#import "PasswordToggleView.h"

@protocol MatchedAccountsViewDelegate <NSObject>
@optional
- (void)delegate_MatchedAccountsView_selected:(NSString *)matchedAccount;
@end

@interface MatchedAccountsView : UITableView <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSString       *text;
@property (nonatomic,weak) id<MatchedAccountsViewDelegate> selDelegate;
@end

@interface LoginView : CommonView

@property (nonatomic, strong)  UITextField          *usernameTextField;
@property (nonatomic, strong)  UITextField          *passwordTextField;

@property (nonatomic, strong)  UIView               *footerView;
@property (nonatomic, strong)  UIButton             *findPassWordBtn;

@property (nonatomic, strong)  UIButton             *loginHistoryBtn;
@property (nonatomic, strong)  UIImageView          *loginHistoryImg;
@property (nonatomic, strong)  UIButton             *loginButton;
@property (nonatomic, strong)  UIButton             *registerButton;

//@property (nonatomic, strong)  UIButton             *rememberPasswordBtn;
//@property (nonatomic, strong)  UILabel              *rememberPasswordLabel;


#pragma mark - 验证码相关
@property (nonatomic, strong) UIView *verifyCodeView;
@property (nonatomic, strong) UIView *labelandTFBackView;//包括label和输入textfield
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UITextField *verifyCodeTextField;
@property (nonatomic, strong) EGOImageView *verifyCodeImageView;
@property (nonatomic, strong) OHAttributedLabel *labelRefresh;
@property (nonatomic, strong) UIButton *btnRefresh;   //换一换button

@property (nonatomic, strong) PasswordToggleView *passwdToggleView;


@property (nonatomic,strong) MatchedAccountsView *matchedAccView;

- (void)loadVerifyCodeImage;
- (void)refreshVerifycode:(id)sender;
@end
