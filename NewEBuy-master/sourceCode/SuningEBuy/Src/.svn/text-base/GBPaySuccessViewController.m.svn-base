//
//  GBPaySuccessViewController.m
//  SuningEBuy
//
//  Created by  zhang jian on 13-2-25.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "GBPaySuccessViewController.h"
#import "GBOrderDetailViewController.h"

@interface GBPaySuccessViewController ()
{
    
}


@property (nonatomic, strong) UIButton                  *goOnShoppingBtn;
@property (nonatomic, strong) UIButton                  *goToOrderCenterBtn;
@property (nonatomic, strong) UILabel                   *descLabel;
@property (nonatomic, strong) UIImageView               *arrowImage;

@end

@implementation GBPaySuccessViewController

@synthesize arrowImage                          = _arrowImage;
@synthesize goOnShoppingBtn                     = _goOnShoppingBtn;
@synthesize goToOrderCenterBtn                  = _goToOrderCenterBtn;
@synthesize descLabel                           = _descLabel;

@synthesize gbOrderInfoDto                      = _gbOrderInfoDto;
@synthesize gbSubmitDto                         = _gbSubmitDto;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_gbOrderInfoDto);
    TT_RELEASE_SAFELY(_arrowImage);
    TT_RELEASE_SAFELY(_goToOrderCenterBtn);
    TT_RELEASE_SAFELY(_goOnShoppingBtn);
    TT_RELEASE_SAFELY(_descLabel);
    TT_RELEASE_SAFELY(_gbSubmitDto);
    
}

- (id)init
{
    self = [super init];
    if (self) {
        self.title = L(@"GBPaySuccess");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"virtual_gourpBuy"),self.title];
        if (!_gbSubmitDto) {
            _gbSubmitDto = [[GBSubmitDTO alloc] init];
        }
        if (!_gbOrderInfoDto) {
            _gbOrderInfoDto = [[GBOrderInfoDTO alloc] init];
        }
        
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] init];
        barButtonItem.title = L(@"returnTo_myEuy");
        self.navigationItem.backBarButtonItem = barButtonItem;
    }
    return self;
}


- (void)loadView
{
    [super loadView];
    
    [self.view addSubview:self.arrowImage];
    [self.view addSubview:self.descLabel];
    [self.view addSubview:self.goToOrderCenterBtn];
    [self.view addSubview:self.goOnShoppingBtn];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self initBackItem];
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
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
        
    UIWindow *widow = [UIApplication sharedApplication].keyWindow;
    
    for (UIView *view in widow.subviews) {
        
        if (view.tag == 9777) {
            
            [view removeFromSuperview];
            
        }
    }
}
- (UIImageView *)arrowImage
{
    if (!_arrowImage) {
        _arrowImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"merge_success_face"]];
        _arrowImage.backgroundColor = [UIColor clearColor];
        _arrowImage.frame = CGRectMake(45, 110, 23, 23);
    }
    return _arrowImage;
}

- (UILabel *)descLabel
{
    if (!_descLabel)
    {
        _descLabel = [[UILabel alloc] init];
        _descLabel.frame = CGRectMake(75, 112, 220, 20);
        _descLabel.textAlignment = UITextAlignmentCenter;
        _descLabel.backgroundColor = [UIColor clearColor];
        _descLabel.text = L(@"GBOrderSubmitSuccess3");
        _descLabel.font = [UIFont boldSystemFontOfSize:14.0];
        _descLabel.textColor =[UIColor light_Black_Color];
    }
    return _descLabel;
}

- (UIButton *)goOnShoppingBtn
{
    if (!_goOnShoppingBtn)
    {
        _goOnShoppingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
       
        _goOnShoppingBtn.frame = CGRectMake(30, 192, 120, 35);
        
        [_goOnShoppingBtn setTitle:L(@"GBShopContinue") forState:UIControlStateNormal];
        
        _goOnShoppingBtn.titleLabel.font =[UIFont boldSystemFontOfSize:15];
        
        [_goOnShoppingBtn setBackgroundColor:[UIColor clearColor]];
        
        _goOnShoppingBtn.tag = 22222;
        
        [_goOnShoppingBtn setTitleColor:[UIColor dark_Gray_Color]  forState:UIControlStateNormal];
        
        [_goOnShoppingBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [_goOnShoppingBtn setBackgroundImage:[UIImage imageNamed:@"button_white_normal"] forState:UIControlStateNormal];
    }
    return _goOnShoppingBtn;
}

- (UIButton *)goToOrderCenterBtn
{
    if (!_goToOrderCenterBtn)
    {
        _goToOrderCenterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
        _goToOrderCenterBtn.frame = CGRectMake(170, 192, 120, 35);
        
        [_goToOrderCenterBtn setTitle:L(@"GBLookForDetailsOfOrder") forState:UIControlStateNormal];
        
        _goToOrderCenterBtn.titleLabel.font =[UIFont boldSystemFontOfSize:15];

        [_goToOrderCenterBtn setBackgroundColor:[UIColor clearColor]];
        
        [_goToOrderCenterBtn setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
        
        _goToOrderCenterBtn.tag = 22223;
        
        [_goToOrderCenterBtn setBackgroundImage:[UIImage imageNamed:@"button_orange_normal.png"] forState:UIControlStateNormal];
       
        [_goToOrderCenterBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _goToOrderCenterBtn;
}

- (void)btnAction:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    switch (btn.tag) {
        case 22222://继续购物
            [self.navigationController popToRootViewControllerAnimated:YES];
            break;
        case 22223://查看订单详情
        {
            GBOrderInfoDTO *infoDto = [[GBOrderInfoDTO alloc] init];
            infoDto.orderId = self.gbSubmitDto.orderId;
//            if ([self.gbSubmitDto.categoryId isEqualToString:@"H8004"]) {
//                infoDto.gbType = 1;
//            }else{
//                infoDto.gbType = 0;
//            }
            infoDto.snProId = self.gbSubmitDto.snProId;
            infoDto.gbType = self.gbSubmitDto.gbType;
            infoDto.snProName = self.gbSubmitDto.snProName;
            
            GBOrderDetailViewController *detail = [[GBOrderDetailViewController alloc] initWithOrderInfo:infoDto];
            detail.isFormPayPage = YES;
            [self.navigationController pushViewController:detail animated:YES];
        }
            break;
        default:
            break;
    }
}


@end
