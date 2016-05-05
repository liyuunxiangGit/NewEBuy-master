//
//  GBPayModelViewController.m
//  SuningEBuy
//
//  Created by  zhang jian on 13-2-25.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "GBPayModelViewController.h"
#import "GBPayByEfubaoViewController.h"
#import "GBPaySuccessViewController.h"
#import "NSAttributedString+Attributes.h"

#import "GBDetailViewController.h"


static NSString *kMainLbl = @"mainLbl";
static NSString *kDetailLblEnable = @"detailLblEnable";
static NSString *kDetailLblDisable = @"detailLblDisable";
static NSString *kSupportPayment = @"supportPayment";


@interface GBPayModelViewController ()

@property (nonatomic, strong) NSArray               *payArr;
@property (nonatomic, strong) EfubaoAccountService *efubaoService;

@end

@implementation GBPayModelViewController

@synthesize gbPayService                = _gbPayService;
@synthesize gbSubmitDto                 = _gbSubmitDto;
@synthesize descLabel                   = _descLabel;

@synthesize payArr                      = _payArr;
@synthesize arrowImage                  = _arrowImage;
@synthesize priceLabel                  = _priceLabel;

@synthesize isFormOrder                 = _isFormOrder;
@synthesize efubaoService = _efubaoService;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_priceLabel);
    TT_RELEASE_SAFELY(_arrowImage);
    TT_RELEASE_SAFELY(_payArr);
    
    TT_RELEASE_SAFELY(_descLabel);
    TT_RELEASE_SAFELY(_gbSubmitDto);
    TT_RELEASE_SAFELY(_gbPayService);
    
    SERVICE_RELEASE_SAFELY(_efubaoService);
    
}

- (id)init
{
    self = [super init];
    if (self) {
        self.title = L(@"Order pay");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"virtual_gourpBuy"),self.title];
        if (!_gbSubmitDto) {
            _gbSubmitDto = [[GBSubmitDTO alloc] init];
        }
        self.isFormOrder = NO;
        
    }
    return self;
}

- (void)initPayData
{
    //易付宝支付
    NSMutableDictionary *dic1 = [[NSMutableDictionary alloc] initWithCapacity:4];
    [dic1 setObject:L(@"choosePayWayFor30") forKey:kMainLbl];
    [dic1 setObject:L(@"choosePayWayFor31") forKey:kDetailLblEnable];
    // 2.是否支持易付宝支付的逻辑判断，如果不支持，则将错误信息保存到对应的变量
    if ([self isEppActive])
    {
        // 易付宝余额不足
        if ([[UserCenter defaultCenter].userInfoDTO.yifubaoBalance floatValue] < [self.gbSubmitDto.eppAmount floatValue])
        {

            [dic1 setObject:L(@"GBAccountUnfilledVacanciesIsInsufficient") forKey:kDetailLblDisable];
            [dic1 setObject:[NSNumber numberWithBool:NO] forKey:kSupportPayment];
        }
        else{
            [dic1 setObject:L(@"GBAccountUnfilledVacanciesIsEnough") forKey:kDetailLblDisable];
            [dic1 setObject:[NSNumber numberWithBool:YES] forKey:kSupportPayment];
        }
    }
    else
    {
        // 易付宝尚未激活
        [dic1 setObject:L(@"GBYourEBuyIsNotActivite") forKey:kDetailLblDisable];
        [dic1 setObject:[NSNumber numberWithBool:NO] forKey:kSupportPayment];
    }
      
    //银联支付
    NSMutableDictionary *dic2 = [[NSMutableDictionary alloc] initWithCapacity:4];
    [dic2 setObject:L(@"choosePayWayFor50") forKey:kMainLbl];
    [dic2 setObject:L(@"support bank card") forKey:kDetailLblEnable];
   // [dic2 setObject:L(@"Store take unsupport bank online") forKey:kDetailLblDisable];
    [dic2 setObject:L(@"support bank card") forKey:kDetailLblDisable];
    // 3.是否支持汇付手机支付的逻辑判断，当为门店自提时，不支持汇付支付
    [dic2 setObject:[NSNumber numberWithBool:YES] forKey:kSupportPayment];
    
//#warning 启动银联2.0
    _payArr = [[NSArray alloc] initWithObjects:dic1,dic2, nil];
}

- (void)loadView
{
    [super loadView];
    
    [self initPayData];
    
    [self.view addSubview:self.arrowImage];
    [self.view addSubview:self.descLabel];
    [self.view addSubview:self.priceLabel];
    
    self.tpTableView.frame = CGRectMake(0, 130, 320, 300);
    self.tpTableView.scrollEnabled = NO;
    [self.view addSubview:self.tpTableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSString * eppPrice = [NSString stringWithFormat:@"%@%0.2f", L(@"GBOrderSumOfMoney"), [self.gbSubmitDto.eppAmount floatValue]];
    NSMutableAttributedString *eppPriceAttStr =[[NSMutableAttributedString alloc] initWithString:eppPrice];

    [eppPriceAttStr setFont:[UIFont boldSystemFontOfSize:18] range:NSMakeRange(0, 5)];
    [eppPriceAttStr setFont:[UIFont boldSystemFontOfSize:18] range:NSMakeRange(5, eppPriceAttStr.length-5)];
    [eppPriceAttStr setTextColor:[UIColor light_Black_Color] range:NSMakeRange(0, 5)];
    [eppPriceAttStr setTextColor:[UIColor orange_Light_Color] range:NSMakeRange(5, eppPriceAttStr.length-5)];
    self.priceLabel.attributedText = eppPriceAttStr;
    
    if ([UserCenter defaultCenter].isLogined)
    {
        [self sendFirstEfubaoHttpRequest];
    }
}

- (void)initBackItem
{
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 110, 44)];
    backButton.backgroundColor = [UIColor clearColor];
    [backButton addTarget:self action:@selector(backToFore:) forControlEvents:UIControlEventTouchUpInside];
    backButton.tag = 9777;
    
    UIWindow *widow = [UIApplication sharedApplication].keyWindow;
    [widow addSubview:backButton];
    TT_RELEASE_SAFELY(backButton);
}

- (void)backToFore:(id)sender
{
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[GBDetailViewController class]]) {
                [self.navigationController popToViewController:controller animated:YES];
            }
        }
//    }];
//    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)backForePage
{
    NSString *message = @"";
    message = L(@"GBOrderSubmitSuccess");
    BBAlertView *alert = [[BBAlertView alloc]
                          initWithTitle:L(@"friend_tips")
                          message:message
                          delegate:self
                          cancelButtonTitle:L(@"Cancel")
                          otherButtonTitles:L(@"Ok")];
    [alert show];
    [alert setConfirmBlock:^{
        if (!self.isFormOrder) {
            for (UIViewController *controller in self.navigationController.viewControllers) {
                if ([controller isKindOfClass:[GBDetailViewController class]]) {
                    [self.navigationController popToViewController:controller animated:YES];
                }
            }
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (!self.isFormOrder)
    {
        UIWindow *widow = [UIApplication sharedApplication].keyWindow;
        
        for (UIView *view in widow.subviews) {
            
            if (view.tag == 9777) {
                
                [view removeFromSuperview];
            }
        }
    }
}

- (void)sendFirstEfubaoHttpRequest
{
	[self displayOverFlowActivityView];
    
    [self.efubaoService beginGetEfubaoAccountInfo];
}

- (void)didGetEfubaoAccountCompleted:(BOOL)isSuccess
                            errorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];
    
    if (!isSuccess)
    {
        [self presentSheet:L(errorMsg)];
    }
    else{
        
//        if (2 != [_payArr count]) {
//            
//            return;
//        }
        
        NSMutableDictionary *dic = [_payArr objectAtIndex:0];
        
        // 2.是否支持易付宝支付的逻辑判断，如果不支持，则将错误信息保存到对应的变量
        if ([self isEppActive])
        {
            // 易付宝余额不足
            if ([[UserCenter defaultCenter].userInfoDTO.yifubaoBalance floatValue] < [self.gbSubmitDto.eppAmount floatValue])
            {
                
                [dic setObject:L(@"GBAccountUnfilledVacanciesIsInsufficient") forKey:kDetailLblDisable];
                [dic setObject:[NSNumber numberWithBool:NO] forKey:kSupportPayment];
            }
            else{
                [dic setObject:L(@"GBAccountUnfilledVacanciesIsEnough") forKey:kDetailLblDisable];
                [dic setObject:[NSNumber numberWithBool:YES] forKey:kSupportPayment];
            }
        }
        else
        {
            // 易付宝尚未激活
            [dic setObject:L(@"GBYourEBuyIsNotActivite") forKey:kDetailLblDisable];
            [dic setObject:[NSNumber numberWithBool:NO] forKey:kSupportPayment];
        }
    }
    
    [self.tpTableView reloadData];
}

- (EfubaoAccountService *)efubaoService
{
    if (!_efubaoService) {
        _efubaoService = [[EfubaoAccountService alloc] init];
        _efubaoService.delegate = self;
    }
    return _efubaoService;
}

- (UILabel *)descLabel
{
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] init];
        _descLabel.frame = CGRectMake(self.arrowImage.right + 10, 36, 250, 20);
        _descLabel.text = L(@"GBOrderSubmitSuccess2");
        _descLabel.backgroundColor = [UIColor clearColor];
        _descLabel.font = [UIFont boldSystemFontOfSize:14.0];
        _descLabel.textColor =[UIColor light_Black_Color];
    }
    return _descLabel;
}

- (UIImageView *)arrowImage
{
    if (!_arrowImage) {
        _arrowImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"merge_success_face"]];
        _arrowImage.frame = CGRectMake(60 , 35, 23, 23);
        _arrowImage.backgroundColor = [UIColor clearColor];
    }
    return _arrowImage;
}

- (OHAttributedLabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [[OHAttributedLabel alloc] initWithFrame:CGRectMake(15, 100, 200, 30)];
        
        _priceLabel.backgroundColor = [UIColor clearColor];
    }
    return _priceLabel;
}

- (GBPayService *)gbPayService
{
    if (!_gbPayService) {
        _gbPayService = [[GBPayService alloc] init];
        _gbPayService.delegate = self;
    }
    return _gbPayService;
}

- (void)payByMobileComplete:(GBPayService *)service Result:(BOOL)isSuccess withXml:(NSString *)xml
{
    if (isSuccess) {
        
        [UPPayPlugin startPay:xml
                         mode:@"00"
               viewController:self
                     delegate:self];
        
//        [UPPayPlugin startPay:xml
//                SystemProvide:@"11173000"
//                         SPID:@"0229"
//           withViewController:self
//                     Delegate:self];
        
//        [UPPayPlugin test:xml
//                SystemProvide:@"00000001"
//                         SPID:@"0001"
//           withViewController:self
//                     Delegate:self];
        
//        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(40, 300, 50, 50)];
//        btn.backgroundColor = [UIColor redColor];
//        btn.titleLabel.text = xml;
//        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:btn];
//        [btn release];
        
    }else{
        [self presentSheet:self.gbPayService.errorMsg];
    }
}

//- (void)clickBtn:(id)sender
//{
//    UIButton *btn = (UIButton *)sender;
//    
//    [UPPayPlugin startPay:btn.titleLabel.text
//            SystemProvide:@"11173000"
//                     SPID:@"0229"
//       withViewController:self
//                 Delegate:self];
//}

#pragma mark -
#pragma mark tableview delegate/datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_payArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *payModelIdentifier = @"payModelIdentifier";
    
    SNUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:payModelIdentifier];
    
    if (cell == nil) {
        cell = [[SNUITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:payModelIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont boldSystemFontOfSize:17.0f];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14.0];
        cell.detailTextLabel.numberOfLines = 0;
        cell.detailTextLabel.lineBreakMode = UILineBreakModeCharacterWrap;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textColor =[UIColor light_Black_Color];
        cell.detailTextLabel.textColor =[UIColor dark_Gray_Color];
    }
    NSDictionary *dic = [self.payArr objectAtIndex:indexPath.row];
    cell.textLabel.text = [dic objectForKey:kMainLbl];
    cell.detailTextLabel.text = [dic objectForKey:kDetailLblDisable];
    BOOL isSupportPay = [[dic objectForKey:kSupportPayment] boolValue];
    if (!isSupportPay) {
        
        cell.detailTextLabel.textColor = [UIColor orange_Red_Color];
    }
    else{
        
        cell.detailTextLabel.textColor = [UIColor dark_Gray_Color];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        NSDictionary *dic = [self.payArr objectAtIndex:indexPath.row];
        BOOL isSupportPay = [[dic objectForKey:kSupportPayment] boolValue];
        self.gbSubmitDto.payMode = GBPayModeEfubao;
        if (isSupportPay) {
            GBPayByEfubaoViewController *epp = [[GBPayByEfubaoViewController alloc] init];
            epp.submitDto = self.gbSubmitDto;
            epp.submitDto.snProName = self.gbSubmitDto.snProName;

            [self.navigationController pushViewController:epp animated:YES];
            TT_RELEASE_SAFELY(epp);
        }
    }
    else{
        self.gbSubmitDto.payMode = GBPayModeOnlineBank;
        self.gbSubmitDto.payAmount = self.gbSubmitDto.eppAmount;
     
        //提交订单
        [self displayOverFlowActivityView:L(@"Commit_Order...")];
        [self.gbPayService beginPayByMobileChannel:self.gbSubmitDto];
    }
}

#pragma mark -
#pragma mark 银联支付回调

- (void)UPPayPluginResult:(NSString*)result
{
    [self removeOverFlowActivityView];
    DLog(@"result:%@", result);
    if([result isEqualToString:@"cancel"])
    {
//        //go to homepage
//        [self.navigationController popToRootViewControllerAnimated:NO];
//        //去订单中心
//        [self jumpToOrderCenterBoard];
    }
    else if(![result isEqualToString:@"fail"] &&![result isEqualToString:@"cancel"])
    {
        GBPaySuccessViewController *success = [[GBPaySuccessViewController alloc] init];
        success.gbSubmitDto = self.gbSubmitDto;
        success.gbSubmitDto.snProName = self.gbSubmitDto.snProName;
        [self.navigationController pushViewController:success animated:YES];

//        BBAlertView *alert = [[BBAlertView alloc] initWithTitle:nil
//                                                        message:L(@"succeedPay")
//                                                       delegate:self
//                                              cancelButtonTitle:L(@"confirm")
//                                              otherButtonTitles:nil];
//        alert.tag = 1111;
//        [alert show];
//        [alert release];
    }
    else
    {
        [self presentSheet:L(@"Pay failed") posY:100];
    }
    
}

@end
