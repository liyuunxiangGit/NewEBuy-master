//
//  LotteryPayPlugin.m
//  SuningEBuy
//
//  Created by  liukun on 13-8-15.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "LotteryPayPlugin.h"
#import "LotteryPayRequestService.h"
#import "LotteryHallViewController.h"

static LotteryPayPlugin *sharedPayPlugin = nil;
static NSDictionary     *payedInfoDic = nil;

@interface LotteryPayPlugin() <LotteryPayRequestServiceDelegate>

@property (nonatomic, strong) LotteryPayRequestService *service;
@property (nonatomic, weak) CommonViewController *fromController;

@property (nonatomic, strong) SubmitLotteryDto *lotteryDto;

@end

/*********************************************************************/

@implementation LotteryPayPlugin

- (void)dealloc
{
    SERVICE_RELEASE_SAFELY(_service);
}

- (void)cancel
{
    SERVICE_RELEASE_SAFELY(_service);
    self.fromController = nil;
}

- (LotteryPayRequestService *)service
{
    if (!_service)
    {
        _service = [[LotteryPayRequestService alloc] init];
        _service.delegate = self;
    }
    return _service;
}

- (void)startPayWithParamDic:(NSDictionary *)dic controller:(CommonViewController *)controller
{
    self.fromController = controller;
    [controller displayOverFlowActivityView];
    [self.service beginLotteryPay:dic];
}

- (void)getLotteryPayCompletionWithResult:(BOOL)isSussecc
                                  Service:(LotteryPayRequestService *)service
{
    [self.fromController removeOverFlowActivityView];
    
    if ([service.unLoginErrorCode isEqualToString:@"common.2.userNotLoggedIn"])
    {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:LOGIN_SESSION_FAILURE_NEED_LOGIN object:nil];
        
         sharedPayPlugin = nil;
        return;
    }
    
    
    if (service.lotteryPayErrorMsg)
    {
        //网络问题
        [self.fromController presentSheet:service.lotteryPayErrorMsg];
    }
    else
    {
        
        NSDictionary *items = service.items;
        
        NSString *resultString = @"";
        
        if ([[items objectForKey:kHttpResponseCode] isEqualToString:@"0"])
        {
            if ([[items objectForKey:kHttpResponseDesc] isEqualToString:L(@"LORenewPlanInfo")])//无其他参数可判断，只能用返回的Message判断
            {
                for (UIViewController *vc in self.fromController.navigationController.viewControllers) {
                    if ([vc isKindOfClass:[LotteryHallViewController class]]) {
                        [self.fromController.navigationController popToViewController:vc animated:YES];
                        [(LotteryHallViewController *)vc presentSheet:L(@"LOPaySuccess")];

                        return;
                    }
                }
                
            }
            NSString *eppUrl = nil;
            NSString *projid = nil;
            if ([self.lotteryDto.saleType isEqualToString:L(@"Purchase")])
            {
                NSDictionary *resultDic = EncodeDicFromDic(items, @"result");
                eppUrl = EncodeStringFromDic(resultDic, @"@eppUrl");
                projid = [resultDic objectForKey:@"@projid"];
            }
            else
            {
                NSDictionary *resultDic = EncodeDicFromDic(items, @"zhuihao");
                eppUrl = EncodeStringFromDic(resultDic, @"@eppUrl");
                projid = [resultDic objectForKey:@"@id"];
            }
            
            
            if (eppUrl.trim.length)
            {
                //跳转之前先缓存数据
                NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                
                NSNumber *type = [self.lotteryDto.periods integerValue]<=1?@(kDealsType_DaiGou):@(kDealsType_ZhuiHao);
                [dic setObject:type forKey:@"type"];
                [dic setObject:self.lotteryDto.gid forKey:@"gid"];
                [dic setObject:projid?projid:@"" forKey:@"projid"];
                payedInfoDic = dic;

                //跳转web收银台
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:eppUrl]];

            }
            else
            {
                [self.fromController presentSheet:L(@"LOFailToGetLink")];
            }
        }
        else
        {
            //支付失败
            if([[items objectForKey:kHttpResponseCode]isEqualToString:@"-99"])
            {
                
                NSDictionary *resultDic = [items objectForKey:@"result"];
                
                if (resultDic)
                {
                    
                    if ([[resultDic objectForKey:@"@failure"] isEqualToString:@"3"])
                    {
                        
                        [self.fromController presentSheet:L(@"Password input wrong more than three times the account has been frozen, automatically unlock after 24 hours")];
                    }
                    else
                    {
                        
                        int leftNo = [[resultDic objectForKey:@"@failure"]intValue];
                        
                        if (leftNo == -1)
                        {
                            resultString = L(@"yifubao check failure");
                        }
                        else
                        {
                            resultString = [NSString stringWithFormat:@"%@%d%@",L(@"Enter the wrong password, but also can to try"),(3-leftNo),L(@"times,if failed account will be frozen")];
                        }
                        
                        [self.fromController presentSheet:resultString];
                        
                    }
                }
                
            }
            else
            {
                resultString = [items objectForKey:kHttpResponseDesc];
                
                if (IsStrEmpty(resultString))
                {
                    resultString = L(@"Network anomalies, please try again later");
                }
                
                [self.fromController presentSheet:resultString];
            }
            
        }
    }

     sharedPayPlugin = nil;
}

+ (void)startPayWithDto:(SubmitLotteryDto *)payDto
         fromController:(CommonViewController *)controller
{
    NSString *productTimes = payDto.productTimes == nil ?@"":payDto.productTimes;
    NSString *buyCodes = payDto.buyCodes == nil ?@"":payDto.buyCodes;
    NSString *multiNo = payDto.multiNo == nil?@"":payDto.multiNo;
    NSString *saleType = payDto.saleType == nil?@"":payDto.saleType;
    NSString *productMoney = payDto.productMoney==nil?@"":payDto.productMoney;
    NSString *gid = payDto.gid == nil?@"":payDto.gid;
    NSString *periods = payDto.periods == nil?@"":payDto.periods; //追号期数
    BOOL    stopWhenWin = payDto.stopWhenWin;
    
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc]init];
    //公用参数
    [postDataDic setObject:@"1"  forKey:@"json"];                          //是否返回json格式字符串,1:是，0否
    [postDataDic setObject:gid forKey:@"gid"];                             //游戏编号
    [postDataDic setObject:buyCodes forKey:@"codes"];                      //投注号码 |分割红蓝 ;分割不同两组号
    
    [postDataDic setObject:productMoney forKey:@"money"];                  //方案金额
    
    [postDataDic setObject:@"2" forKey:@"source"];                         //投注来源（0:网站 1:客户端 2:手机 3:wap）
    
    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    [postDataDic setObject:[NSString stringWithFormat:@"201I%@",version] forKey:@"origin"];                           //彩票系统原订单来源字段origin：“0”为web订单，“2”为客户端订单。客户端字段现扩展为”2XYZ”,X值包括00（彩票客户端）、01（易购客户端）、02（易付宝客户端）；Y值包括A（andriod系统）、I（IOS系统）；Z值为各客户端版本号，视具体情况而定。
    
    //非公用参数
    if ([payDto.saleType isEqualToString:L(@"purchasing")])
    {
        //代购订单易付宝支付和手机银联支付公用参数
        [postDataDic setObject:productTimes forKey:@"pid"];                    //期次编号
        [postDataDic setObject:@"1" forKey:@"play"];                           //玩法编号，默认为1
        [postDataDic setObject:@"0" forKey:@"fflag"];                          //是否文件，代购为0
        [postDataDic setObject:@"0" forKey:@"type"];                           //方案类型，代购为0
        [postDataDic setObject:multiNo forKey:@"muli"];                        //投注倍数
        [postDataDic setObject:saleType forKey:@"name"];                       //方案标题，默认为"代购"
        [postDataDic setObject:saleType forKey:@"desc"];                       //方案描述，默认为"代购"
        [postDataDic setObject:@"1" forKey:@"tnum"];                           //方案份数，代购为1
        [postDataDic setObject:@"1" forKey:@"bnum"];                           //购买份数，代购为1
        [postDataDic setObject:@"0" forKey:@"pnum"];                           //保底份数，代购为0
        [postDataDic setObject:@"0" forKey:@"oflag"];                          //公开标志，默认为0
        [postDataDic setObject:@"0" forKey:@"wrate"];                          //提成比率，默认为0
        [postDataDic setObject:@"" forKey:@"comeFrom"];                        //方案来源，默认为空
        [postDataDic setObject:@"" forKey:@"endTime"];                         //截至时间，默认为空
        
        //------------用券新增接口参数-----------------
        if (payDto.needCoupon)
        {
            [postDataDic setObject:@"" forKey:@"origin"];
            [postDataDic setObject:payDto.commPayedMoney forKey:@"commPayedMoney"];
            [postDataDic setObject:payDto.coupons forKey:@"coupons"];
            [postDataDic setObject:payDto.eppPayedMoney forKey:@"eppPayedMoney"];
        }//判断是否使用用券
        
        [postDataDic setObject:@"2" forKey:@"payMethod"];                      //支付方式：0或者null 易付宝支付； 1 手机银联支付 2 wap收银台
        
    }
    else
    {
        //追号订单易付宝支付和手机银联支付公用参数
        [postDataDic setObject:periods forKey:@"pidNum"]; //追号次数
        [postDataDic setObject:multiNo forKey:@"mulitys"]; //倍数
        [postDataDic setObject:[NSString stringWithFormat:@"%d",stopWhenWin] forKey:@"zflag"];
        [postDataDic setObject:@"1" forKey:@"ichase"];   //未知项  必填
        //追号订单易付宝支付独享参数
        
        [postDataDic setObject:@"2" forKey:@"payMethod"];                      //支付方式：0或者null 易付宝支付； 1 手机银联支付 2 wap收银台

    }
        
    [postDataDic setObject:kURLSchemeSuningEBuy forKey:@"returnUrl"];
    
    [sharedPayPlugin cancel];
    sharedPayPlugin = [[LotteryPayPlugin alloc] init];
    sharedPayPlugin.lotteryDto = payDto;
    [sharedPayPlugin startPayWithParamDic:postDataDic controller:controller];
    
}

+ (void)lastOrderPayedOk
{
    if (payedInfoDic)
    {
        NSString *resultString = L(@"Submit orders for success, I wish you the award-winning");
        BBAlertView *alertView =
        [[BBAlertView alloc] initWithStyle:BBAlertViewStyleLottery
                                     Title:L(@"system-error")
                                   message:resultString
                                customView:nil
                                  delegate:nil
                         cancelButtonTitle:L(@"Goto Lottery hall")
                         otherButtonTitles:L(@"View orders")];
        NSDictionary *dic = payedInfoDic;
        [alertView setConfirmBlock:^{
            
            [self alertViewDismiss:1 infoDic:dic];
            
        }];
        
        [alertView setCancelBlock:^{
            
            [self alertViewDismiss:0 infoDic:dic];
            
        }];
        
        [alertView show];
        
        payedInfoDic = nil;
    }
}

+ (void)alertViewDismiss:(NSInteger)buttonIndex infoDic:(NSDictionary *)payedInfoDic
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:payedInfoDic];
    
    if (APP_DELEGATE.tabBarViewController.selectedIndex == 0)
    {
        if (buttonIndex == 0) {
            
            UINavigationController *nav = APP_DELEGATE.tabBarViewController.viewControllers[0];
            BOOL inLottery = NO;
            for (UIViewController *ctrl in nav.viewControllers)
            {
                if ([ctrl isKindOfClass:[LotteryHallViewController class]])
                {
                    [nav popToViewController:ctrl animated:YES];
                    inLottery = YES;
                    break;
                }
            }
            if (!inLottery)
            {
                [nav popToRootViewControllerAnimated:NO];
                
                LotteryHallViewController *vc = [[LotteryHallViewController alloc] init];
                [nav pushViewController:vc animated:YES];
            }
        }
        else if (buttonIndex == 1)
        {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"GoToLotteryOrderDetail"
                                                                object:nil];
            
        }
        
    }
    else if (APP_DELEGATE.tabBarViewController.selectedIndex == 4)
    {
        UINavigationController *nav = APP_DELEGATE.tabBarViewController.viewControllers[4];
        [nav popToRootViewControllerAnimated:NO];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"GoLotteryOrderDetailFormOrder"
                                                            object:nil];
        
        if (buttonIndex == 0) {
            [dic setObject:@"1" forKey:@"goToType"];
        }else{
            [dic setObject:@"2" forKey:@"goToType"];
        }
    }
    else
    {
        APP_DELEGATE.tabBarViewController.selectedIndex = 4;
        
        if ([UserCenter defaultCenter].isLogined)
        {
            UINavigationController *nav = APP_DELEGATE.tabBarViewController.viewControllers[4];
            [nav popToRootViewControllerAnimated:NO];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"GoLotteryOrderDetailFormOrder"
                                                                object:nil];
            
            if (buttonIndex == 0) {
                [dic setObject:@"1" forKey:@"goToType"];
            }else{
                [dic setObject:@"2" forKey:@"goToType"];
            }
        }
    }
    
    //延迟发送
    double delayInSeconds = 0.3;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        [[NSNotificationCenter defaultCenter] postNotificationName:REFRESH_MYLOTTERY
                                                            object:nil
                                                          userInfo:dic];
    });
}


+ (void)cancelPay
{
    if (sharedPayPlugin)
    {
        [sharedPayPlugin cancel];
        sharedPayPlugin = nil;
    }
}

+ (BOOL)open
{
    return YES;
}

@end
