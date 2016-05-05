//
//  ScanerAuthoViewController.m
//  SuningEBuy
//
//  Created by XZoscar on 14-6-20.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "ScanerAuthoViewController.h"
#import "ScanerCodeActionService.h"
#import "AppDelegate.h"
#import "LoginViewController.h"

#import "SuningMainClick.h"
#import "HomePageViewController.h"


@interface ScanerAuthoViewController () <ScanerCodeActionServiceDelegate>
@property (nonatomic,strong) IBOutlet UIScrollView   *scrollView;
@property (nonatomic,strong) IBOutlet UILabel        *msgLabel0,*msgLabel1,*msgLabel2;
@property (nonatomic,strong) ScanerCodeActionService *actionService;
@end

@implementation ScanerAuthoViewController

- (void)dealloc {
    

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self bindWithPassportRequest];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backForePage {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (ScanerCodeActionService *)actionService {
    if (nil == _actionService) {
        _actionService = [[ScanerCodeActionService alloc] init];
        _actionService.delegate = self;
    }
    return _actionService;
}

- (void)bindWithPassportRequest {
    [_scrollView setContentOffset:CGPointMake(-320.0f,.0f)];
    [self displayOverFlowActivityView];
    // 绑定验证
    [self.actionService scanerCodeToActionLoginWithUuid:_authoUuid];
}

- (void)confirmAuthoRequest {
    [self displayOverFlowActivityView];
    [self.actionService scanerCodeToActionAuthoWithUuid:self.authoUuid];
}

- (IBAction)on_functionButton_clicked:(UIButton *)sender {
    
    if (0 == sender.tag) {          // 确认授权
        [self confirmAuthoRequest];
    }else if (1 == sender.tag) {    // 取消
        [self backForePage];
    }else if (2 == sender.tag) {    // 重新扫描
        
        [self displayOverFlowActivityView];
        
        ScanerAuthoViewController *__weak weakSelf = self;
        [self dismissViewControllerAnimated:YES completion:^{
            
            TabBarController *tabBarCtrler = APP_DELEGATE.tabBarViewController;
            UINavigationController *navCtrler = (UINavigationController *)tabBarCtrler.viewControllers[0];
            HomePageViewController *homeCtrler = (HomePageViewController *)navCtrler.topViewController;
            if (nil!=homeCtrler
                && [homeCtrler respondsToSelector:@selector(readerController)]) {
                [homeCtrler.readerController beginReader];
            }
            
            [weakSelf removeOverFlowActivityView];
        }];
        
    }else if (3 == sender.tag) {    // 返回首页
         [self backForePage];
    }
}

// 第一步 验证
- (void)delegate_scanerCode_actionLogin:(NSDictionary *)dictionary
                                  error:(NSString *)errDesc {
    
    [self removeOverFlowActivityView];
    if (nil != errDesc) {
        
        NSString *resCode = dictionary[@"res_code"];
        if (nil != resCode
            && [resCode isEqualToString:@"1"]) {
            // cookie 失效
            ScanerAuthoViewController *__weakSelf = self;
            [self displayOverFlowActivityView];
            LoginViewController *ctrler = [[LoginViewController alloc] init];
            ctrler.dismissViewControllerComplete = ^ {
                [__weakSelf bindWithPassportRequest];
            };
            [self presentViewController:ctrler animated:YES completion:^{
                [__weakSelf removeOverFlowActivityView];
            }];
        }else {
            
            [self presentSheet:errDesc];
            [_msgLabel1 setText:errDesc];
            [_scrollView setContentOffset:CGPointMake(self.view.frame.size.width,.0f)];
        }
        
        [self snclick_switchPageWithPageTitle:L(@"Member_ScanCodeToLoginAndRegister_AuthorizationFailPage")]; // 授权失败页面
        
    }else {
        // 第一步验证成功 （已扫描，并通知passport验证成功返回）
        // 下一步:等待确认授权其它终端登录
        // 验证成功 进入授权状态页面
        [_scrollView setContentOffset:CGPointZero];
        NSString *account = [UserCenter defaultCenter].userInfoDTO.logonId;
        [_msgLabel0 setText:[NSString stringWithFormat:@"%@%@%@",L(@"BeAboutToUse"),((nil == account)?L(@"Yours"):account),L(@"CountSynLoginEasyBuyOtherTerminal")]];
        
        [self snclick_switchPageWithPageTitle:L(@"Member_ScanCodeToLoginAndRegister_AuthorizationPage")];  // 验证成功 进入授权状态页面,认为是页面切换
    }
}

// 第二步 授权
- (void)delegate_scanerCode_actionAutho:(NSDictionary *)dictionary
                                  error:(NSString *)errDesc {
    if (nil != errDesc) {
        
        NSString *resCode = dictionary[@"res_code"];
        if (nil != resCode
            && [resCode isEqualToString:@"1"]) {
            // cookie 失效
            ScanerAuthoViewController *__weakSelf = self;
            [self displayOverFlowActivityView];
            LoginViewController *ctrler = [[LoginViewController alloc] init];
            ctrler.dismissViewControllerComplete = ^ {
                [__weakSelf confirmAuthoRequest];
            };
            [self presentViewController:ctrler animated:YES completion:^{
                [__weakSelf removeOverFlowActivityView];
            }];
        }else {
            
            [self presentSheet:errDesc];
            _msgLabel1.text = errDesc;
            [_scrollView setContentOffset:CGPointMake(self.view.frame.size.width,.0f)];
        }
    }else {
        [_msgLabel2 setText:L(@"SynLoginSuccess")];
        [_scrollView setContentOffset:CGPointMake(self.view.frame.size.width*2,.0f)];
        
        [self snclick_switchPageWithPageTitle:L(@"Member_ScanCodeToLoginAndRegister_AuthorizationSuccessPage")];// 授权成功页面
    }
    [self removeOverFlowActivityView];
}

@end
