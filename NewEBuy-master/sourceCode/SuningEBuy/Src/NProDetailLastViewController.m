//
//  NProDetailLastViewController.m
//  SuningEBuy
//
//  Created by xmy on 19/12/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "NProDetailLastViewController.h"
#import "ShopCartV2ViewController.h"
#import "BuyNowCommand.h"
#import <SSA_IOS/SSAIOSSNDataCollection.h>

//1：即将开始 2：已开始 3：已团完 4：已结束
#define kWillStart @"1"
#define kHaveStart @"2"
#define kNOGood @"3"
#define kHaveEnd @"4"

@interface NProDetailLastViewController ()

@end

@implementation NProDetailLastViewController


- (void)dealloc
{
    self.backScrollView.delegate = nil;
    
    if (PurchuseProduct == self.type) {
        [_calculagraph removeObserver:self forKeyPath:@"time"];
//        //    [_panicDTO removeObserver:self forKeyPath:@"purchaseState"];
//        
//        [_calculagraph stop];
        
        SERVICE_RELEASE_SAFELY(_panicService);
    }
    else if (GroupProduct == self.type)
    {
        [_groupBuyCalculagraph removeObserver:self forKeyPath:@"time"];
//        //    [_panicDTO removeObserver:self forKeyPath:@"purchaseState"];
//        
//        [_groupBuyCalculagraph stop];
    }
    else if (BigSaleProduct == self.type)
    {
        [_bigSaleCalculagraph removeObserver:self forKeyPath:@"time"];
    }
    else if (AppointmentProduct == self.type)
    {
        [_appointmentCalculagraph removeObserver:self forKeyPath:@"time"];
    }
    SERVICE_RELEASE_SAFELY(_paramService);
}
- (id)init
{
    self = [super init];
    
    if (self)
    {
        self.hasNav = NO;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(refreshCarNumBtn) name:@"changeProductDetailCarNum"
                                                   object:nil];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //商品参数请求
    [self.paramService beginGetProductParamWithProduct:self.productInfoDto];
    
    [self.headBtnsCell setNProDetailSixCellInfo:self.productInfoDto WithAppraiseNum:self.appariseNumStr];
    
    [self viewChangeWithType:self.selectTye];
    
//    if (IsStrEmpty(self.panicDTO.startTime)) {
//        
//        //            [_panicDTO removeObserver:self forKeyPath:@"purchaseState"];
//        [self.panicDTO addObserver:self
//                        forKeyPath:@"purchaseState"
//                           options:NSKeyValueObservingOptionNew
//                           context:nil];
//    }
    
//    if (self.type == NormalProduct) {
//        self.bottomNavBar.height = 48;
//        [self.timView removeFromSuperview];
//    }
//    else
//    {
//        self.bottomNavBar.height = 75;
//        [self.bottomNavBar addSubview:self.timView];
//    }
    
//    [self refreshCarNumBtn];
//
//    [self refreshBtn];
    
}

- (void)loadView
{
    [super loadView];
    
    self.hasNav = YES;
//    [self useBottomNavBar];
    self.bottomNavBar.backButton.hidden = YES;
    
    self.title = L(@"Product Details");
    
    [self.view addSubview:self.headBtnsCell];
    
    
//    [self refreshCarNumBtn];
//    
//    [self refreshBtn];

    [self.view addGestureRecognizer:self.swipeRight];

}

- (NSArray *)scrollViewsInView:(UIView *)view
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (UIView *subView in view.subviews)
    {
        if ([subView isKindOfClass:[UIScrollView class]]) {
            [array addObject:subView];
        }
        
        [array addObjectsFromArray:[self scrollViewsInView:subView]];
    }
    
    return [array copy];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
//    if (self.bottomNavBar.visible)
//    {
//        NSArray *scrollViews = [self scrollViewsInView:self.backScrollView];
//        
//        for (UIScrollView *rsv in scrollViews)
//        {
//            CGRect rect = [self.view convertRect:rsv.frame fromView:rsv.superview];
//            if (CGRectGetMaxY(rect) > self.bottomNavBar.top)
//            {
//                UIEdgeInsets oldInset = rsv.contentInset;
//                rsv.contentInset = UIEdgeInsetsMake(oldInset.top, oldInset.left, CGRectGetMaxY(rect)-self.bottomNavBar.top, oldInset.right);
//            }
//        }
//    }
}

- (UISwipeGestureRecognizer *)swipeRight
{
    if (!_swipeRight) {
        _swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backForePage)];
        [_swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
        _swipeRight.delegate = self;
    }
    return _swipeRight;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
- (void)swipeRight:(UISwipeGestureRecognizer *)recognizer
{
//    if (_delegate && [_delegate respondsToSelector:@selector(backToForePage)]) {
//        [_delegate backToForePage];
//    }
    
}

#pragma mark -
#pragma mark sixCell Delegate
-(void)viewChangeWithType:(BtnSelectTypeCell)type
{
    
    switch (type) {
        case SelectLeftBtnCell:
            //商品介绍
            self.swipeRight.enabled = YES;
            [self showIntroduceView];
            break;
        case SelectMidBtnCell:
            //基本信息
            self.swipeRight.enabled = NO;
            [self showBaseView];
            break;
        case SelectRightBtnCell:
            //评价
            self.swipeRight.enabled = NO;
            [self showAppraiseView];
            break;
        case SelectFourCell:
            //咨询
            self.swipeRight.enabled = NO;
            [self showConsultationView];
        default:
            break;
    }
    
}

- (UIScrollView *)backScrollView
{
    if (!_backScrollView)
    {
        _backScrollView = [[UIScrollView alloc] init];
        
        if (IOS7_OR_LATER) {
            _backScrollView.frame = CGRectMake(0, 35, 320, self.view.size.height - 35);
            _backScrollView.contentSize = CGSizeMake(self.leftParamView.size.width + self.midWebView.size.width + self.rightPingJiaView.size.width +self.consultationView.size.width, self.view.size.height - 35 - 20);
        }
        else
        {
            _backScrollView.frame = CGRectMake(0, 35, 320, self.view.size.height - 35);
            _backScrollView.contentSize = CGSizeMake(self.leftParamView.size.width + self.midWebView.size.width + self.rightPingJiaView.size.width+self.consultationView.size.width, self.view.size.height - 35);
        }

        _backScrollView.scrollEnabled = YES;
        _backScrollView.showsVerticalScrollIndicator =  NO;
        _backScrollView.showsHorizontalScrollIndicator = NO;
//        _backScrollView.alwaysBounceHorizontal = YES;
        _backScrollView.pagingEnabled = YES;
        _backScrollView.delegate = self;
        _backScrollView.bounces = NO;
//        _backScrollView.alwaysBounceVertical = YES;
//        CGRect rc =_backScrollView.frame;
        
        _backScrollView.backgroundColor = [UIColor whiteColor];
        _backScrollView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    }
    return _backScrollView;
}

- (NProDetailSixCell *)headBtnsCell
{
    if (!_headBtnsCell) {
        _headBtnsCell = [[NProDetailSixCell alloc] init];
        _headBtnsCell.frame = CGRectMake(0, 0, 320, 35);
        _headBtnsCell.delegate = self;
        _headBtnsCell.backgroundColor = [UIColor whiteColor];
    }
    return _headBtnsCell;
}

- (ProductTimeView *)timView
{
    if (!_timView) {
        _timView = [[ProductTimeView alloc] initWithFrame:CGRectMake(0, 0, 320, 25)];
    }
    return _timView;
}

- (ProductParamService *)paramService
{
    if (!_paramService) {
        _paramService = [[ProductParamService alloc] init];
        _paramService.delegate = self;
    }
    return _paramService;
}

-(UIView *)leftParamView{
    
    if (!_leftParamView) {
//        _leftParamView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, self.frame.size.height-92)];
        _leftParamView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, self.backScrollView.frame.size.height)];
        
        _leftParamView.backgroundColor = [UIColor clearColor];
        
        _leftParamView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight;
        [self.backScrollView addSubview:_leftParamView];
    }
    
    return _leftParamView;
}

-(void)setLeftView:(UIView *)leftView{
    
    [_leftParamView removeFromSuperview];
    
    _leftParamView = leftView;
    
    [self.backScrollView addSubview:_leftParamView];
}
-(UIView *)midWebView{
    
    if (!_midWebView) {
//        _midWebView = [[UIView alloc] initWithFrame:CGRectMake(320, 0, 320, self.frame.size.height-92)];
        _midWebView = [[UIView alloc] initWithFrame:CGRectMake(320, 0, 320, self.backScrollView.frame.size.height)];

        _midWebView.backgroundColor = [UIColor clearColor];
        
        _midWebView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight;

        [self.backScrollView addSubview:_midWebView];
    }
    
    return _midWebView;
}
-(void)setMidView:(UIView *)midView{
    
    [_midWebView removeFromSuperview];
    
    _midWebView = midView;
    
    [self.backScrollView addSubview:_midWebView];
}

-(UIView *)consultationView {
    if (!_consultationView) {
        
        //        _rightPingJiaView = [[UIView alloc] initWithFrame:CGRectMake(640, 0, 320, self.frame.size.height-92)];
        _consultationView = [[UIView alloc] initWithFrame:CGRectMake(960, 0, 320, self.backScrollView.frame.size.height)];
        
        _consultationView.backgroundColor = [UIColor clearColor];
        
        _consultationView.userInteractionEnabled = YES;
        
        _consultationView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight;
        [self.backScrollView addSubview:_consultationView];
    }
    
    return _consultationView;
}
-(UIView *)rightPingJiaView{
    
    if (!_rightPingJiaView) {
        
//        _rightPingJiaView = [[UIView alloc] initWithFrame:CGRectMake(640, 0, 320, self.frame.size.height-92)];
        _rightPingJiaView = [[UIView alloc] initWithFrame:CGRectMake(640, 0, 320, self.backScrollView.frame.size.height)];

        _rightPingJiaView.backgroundColor = [UIColor clearColor];
        
        _rightPingJiaView.userInteractionEnabled = YES;
        
        _rightPingJiaView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight;
        [self.backScrollView addSubview:_rightPingJiaView];
    }
    
    return _rightPingJiaView;
}

-(void)setRightView:(UIView *)rightView{
    
    [_rightPingJiaView removeFromSuperview];
    
    _rightPingJiaView = rightView;
    
    [self.backScrollView addSubview:_rightPingJiaView];
}

- (DataProductBasic*)productInfoDto
{
    if(!_productInfoDto)
    {
        _productInfoDto = [[DataProductBasic alloc] init];
    }
    
    return _productInfoDto;
}

- (NProDetailBaseInfoView*)baseInfoView
{
    if(!_baseInfoView)
    {
        _baseInfoView = [[NProDetailBaseInfoView alloc] initWithFrame:CGRectMake(0, 0, self.midWebView.size.width, self.midWebView.size.height)];
        
        _baseInfoView.backgroundColor = [UIColor clearColor];
        
        _baseInfoView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight;
        [self.midWebView addSubview:_baseInfoView];
    }
    
    return _baseInfoView;
}

- (NProDetailIntroduceView*)introduceView
{
    if(!_introduceView)
    {
        _introduceView = [[NProDetailIntroduceView alloc] init];
        
        _introduceView.view.frame = CGRectMake(0, 0, 320, self.backScrollView.frame.size.height);
        
        _introduceView.view.backgroundColor = [UIColor clearColor];
        
        _introduceView.view.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight;
        [self.leftParamView addSubview:_introduceView.introduceWebView];

    }
    
    return _introduceView;
}

- (UIButton*)introduceBtn
{
    if(!_introduceBtn)
    {
        _introduceBtn = [[UIButton alloc] init];
        
        _introduceBtn.backgroundColor = [UIColor clearColor];
        
        _introduceBtn.frame = CGRectMake(10, 20, 300, 30);
                
        [_introduceBtn setTitleColor:RGBCOLOR(135, 119, 73) forState:UIControlStateNormal];
        
        [_introduceBtn setBackgroundImage:[UIImage streImageNamed:@"button_white_normal.png"] forState:UIControlStateNormal];
        
//        [_introduceBtn setBackgroundImage:[UIImage imageNamed:@"N_Detail_IntroduceClick.png"] forState:UIControlStateHighlighted];
        
        [_introduceBtn setTitle:L(@"Product_CheckPCFullVersion") forState:UIControlStateNormal];
        
        
        [_introduceBtn addTarget:self action:@selector(introduceBtnAction) forControlEvents:UIControlEventTouchUpInside];

    }
    
    return _introduceBtn;
}

- (void)introduceBtnAction
{
    _isFoldIntroduce = YES;
    
    
    self.introduceBtn.hidden = YES;
    self.introduceView.introduceWebView.hidden = NO;

    self.introduceView.introduceWebView.frame = CGRectMake(0, 0, 320, self.backScrollView.frame.size.height);
    
    [self.introduceView setNProDetailIntroduceView:self.productInfoDto];

}

- (PurchaseService *)panicService
{
    if (!_panicService) {
        _panicService = [[PurchaseService alloc] init];
        _panicService.delegate = self;
        _panicService.panicChannel = self.panicChannel;
    }
    return _panicService;
}

- (DJGroupApplyService *)groupApplyService
{
    if (!_groupApplyService) {
        _groupApplyService = [[DJGroupApplyService alloc] init];
        _groupApplyService.delegate = self;
    }
    return _groupApplyService;
}

- (UIButton*)buyNowBtn
{
    if(!_buyNowBtn)
    {
        _buyNowBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, 7, 120, 35)];
        [_buyNowBtn setTitle:L(@"Product_BuyNow") forState:UIControlStateNormal];
        
        _buyNowBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        
        [_buyNowBtn addTarget:self action:@selector(beginEasyBuy) forControlEvents:UIControlEventTouchUpInside];
        
        [_buyNowBtn setBackgroundImage:[UIImage imageNamed:@"submit_button_normal.png"] forState:UIControlStateNormal];
        
        //        [_buyNowBtn setBackgroundImage:[UIImage imageNamed:@"N_GrayActivity.png"] forState:UIControlStateHighlighted];
        
        [_buyNowBtn setBackgroundImage:[UIImage imageNamed:@"button_white_disable.png"] forState:UIControlStateDisabled];
        
        //        [_buyNowBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [_buyNowBtn setTitleColor:[UIColor dark_Gray_Color] forState:UIControlStateDisabled];
        
        [_buyNowBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        _buyNowBtn.enabled = YES;
        
        
    }
    
    return _buyNowBtn;
}

- (UIButton*)addCarBtn
{
    if(!_addCarBtn)
    {
        
        _addCarBtn = [[UIButton alloc] initWithFrame:CGRectMake(185, 7, 120, 35)];
        
        [_addCarBtn setTitle:L(@"Add shopCart") forState:UIControlStateNormal];
        
        _addCarBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        
        [_addCarBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_addCarBtn setTitleColor:[UIColor dark_Gray_Color] forState:UIControlStateDisabled];
        
        [_addCarBtn addTarget:self action:@selector(addToCar) forControlEvents:UIControlEventTouchUpInside];
        
        [_addCarBtn setBackgroundImage:[UIImage streImageNamed:@"button_orange_normal.png"] forState:UIControlStateNormal];
        
        //        [_addCarBtn setBackgroundImage:[UIImage imageNamed:@"addtocar_h@2x.png"] forState:UIControlStateHighlighted];
        
        //        [_addCarBtn setBackgroundImage:[UIImage streImageNamed:@"N_GrayActivity.png"] forState:UIControlStateHighlighted];
        [_addCarBtn setBackgroundImage:[UIImage streImageNamed:@"button_white_disable.png"] forState:UIControlStateDisabled];
        
        _addCarBtn.enabled = YES;
    }
    
    return _addCarBtn;
}

- (UIButton*)CarNumBtn
{
    if(!_CarNumBtn)
    {
        
        _CarNumBtn = [[UIButton alloc] initWithFrame:CGRectMake(23, -7, 14, 14)];
        
        [_CarNumBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_CarNumBtn setBackgroundImage:[UIImage streImageNamed:@"productDetail_carNumber.png"] forState:UIControlStateNormal];
        
        [_CarNumBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        
        [_CarNumBtn addTarget:self action:@selector(GoToCar) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _CarNumBtn;
}

- (UIButton*)CarBtn
{
    if(!_CarBtn)
    {
        
        _CarBtn = [[UIButton alloc] initWithFrame:CGRectMake(200, 10, 41.5, 43.5)];
        
        [_CarBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [_CarBtn addTarget:self action:@selector(GoToCar) forControlEvents:UIControlEventTouchUpInside];
        
        [_CarBtn setImage:[UIImage imageNamed:@"productDetail_Car.png"] forState:UIControlStateNormal];
        
    }
    
    return _CarBtn;
}

- (void)GoToCar
{
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"121313"], nil]];
    ShopCartV2ViewController *vc = [[ShopCartV2ViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.isNeedBackItem = YES;
    [self.navigationController pushViewController:vc animated:YES];
//    [[AppDelegate currentAppDelegate].tabBarViewController setSelectedIndex:3];
//    [(UINavigationController*)[[AppDelegate currentAppDelegate].tabBarViewController.viewControllers objectAtIndex:3] popToRootViewControllerAnimated:NO];
}

- (void)setCalculagraph:(Calculagraph *)calculagraph
{
    if (_calculagraph != calculagraph) {
        [_calculagraph removeObserver:self forKeyPath:@"time"];
        _calculagraph = calculagraph;
        [_calculagraph addObserver:self
                        forKeyPath:@"time"
                           options:NSKeyValueObservingOptionNew
                           context:nil];
    }
}

- (void)setGroupBuyCalculagraph:(Calculagraph *)groupBuyCalculagraph
{
    if (_groupBuyCalculagraph != groupBuyCalculagraph) {
        [_groupBuyCalculagraph removeObserver:self forKeyPath:@"time"];
        _groupBuyCalculagraph = groupBuyCalculagraph;
        [_groupBuyCalculagraph addObserver:self
                        forKeyPath:@"time"
                           options:NSKeyValueObservingOptionNew
                           context:nil];
    }
}

- (void)setBigSaleCalculagraph:(Calculagraph *)bigSaleCalculagraph
{
    if (_bigSaleCalculagraph != bigSaleCalculagraph) {
        [_bigSaleCalculagraph removeObserver:self forKeyPath:@"time"];
        _bigSaleCalculagraph = bigSaleCalculagraph;
        [_bigSaleCalculagraph addObserver:self
                                forKeyPath:@"time"
                                   options:NSKeyValueObservingOptionNew
                                   context:nil];
    }
}

- (void)setAppointmentCalculagraph:(Calculagraph *)appointmentCalculagraph
{
    if (_appointmentCalculagraph != appointmentCalculagraph) {
        [_appointmentCalculagraph removeObserver:self forKeyPath:@"time"];
        _appointmentCalculagraph = appointmentCalculagraph;
        [_appointmentCalculagraph addObserver:self
                               forKeyPath:@"time"
                                  options:NSKeyValueObservingOptionNew
                                  context:nil];
    }
}


#pragma mark -
#pragma mark ------------ 商品参数回调 ------------

- (void)getProductParamCompletionWithResult:(BOOL)isSuccess
                                   errorMsg:(NSString *)errorMsg
                                  paramList:(NSArray *)list
{
    [self removeOverFlowActivityView];

    if (isSuccess) {
        
        [self.baseInfoView setNProDetailBaseInfoViewData:list];
        
        self.baseInfoView.baseInfoDto = self.productInfoDto;
        
    }
    else{
//        [self presentSheetOnNav:errorMsg];
    }
}


#pragma mark -
#pragma sixCell Delegate
-(void)showBaseView
{
    [self.backScrollView setContentOffset:CGPointMake(320, 0) animated:YES];
        
    [self.baseInfoView.baseInfoTableV reloadData];
}

-(void)showConsultationView
{
    [self.backScrollView setContentOffset:CGPointMake(960, 0) animated:YES];
    
    [self.baseInfoView.baseInfoTableV reloadData];
}

-(void)showIntroduceView{
    
    [self.backScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
   
//    self.introduceView.introduceWebView.frame = CGRectMake(0, 0, 320, self.backScrollView.frame.size.height);
//    
//    [self.introduceView setNProDetailIntroduceView:self.productInfoDto];

//    if(_isFoldIntroduce == YES)
//    {
        self.introduceBtn.hidden = YES;
        self.introduceView.introduceWebView.hidden = NO;
        
        self.introduceView.introduceWebView.frame = CGRectMake(0, 0, 320, self.backScrollView.frame.size.height);
        
        [self.introduceView setNProDetailIntroduceView:self.productInfoDto];
//    }
//    else
//    {
//        self.introduceBtn.hidden = NO;
//        
//        self.introduceView.introduceWebView.hidden = YES;
//        
//        [self.leftParamView addSubview:self.introduceBtn];
//    }
    
   
    
}
-(void)showAppraiseView{
    
    [self.backScrollView setContentOffset:CGPointMake(640, 0) animated:YES];

}

-(void)hideScrollViewHead
{
    self.headBtnsCell.hidden = YES;
    self.backScrollView.top = 0;
    self.backScrollView.scrollEnabled = NO;
    self.backScrollView.bounces = YES;
    //self.swipeRight.enabled = NO;
}

-(void)changeTitle:(NSString *)title
{
    self.title = title;
}

+ (CGFloat)setLastCellHeight:(DataProductBasic *)dto WithTabViewH:(CGFloat)cellHeight
{
    return cellHeight;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.backScrollView) {
        //基本信息、商品介绍、评价滑动切换
        
        if(self.backScrollView.contentOffset.x == 0)
        {
            
            [self.headBtnsCell btnChangeTabAction:self.headBtnsCell.introduceBtn];
        }
        else if(self.backScrollView.contentOffset.x == 320)
        {
            [self.headBtnsCell btnChangeTabAction:self.headBtnsCell.baseInfoBtn];
        }
        else if(self.backScrollView.contentOffset.x == 640)
        {
            [self.headBtnsCell btnChangeTabAction:self.headBtnsCell.appraiseBtn];
            
        }
        else if(self.backScrollView.contentOffset.x == 960){
            [self.headBtnsCell btnChangeTabAction:self.headBtnsCell.consultationBtn];
        }
    }
   
}

-(void)refreshBtn
{
    if(self.type == NormalProduct || self.type == BigSaleProduct){
        
        self.addCarBtn.hidden = NO;
        self.CarBtn.hidden = NO;
        self.CarNumBtn.hidden = NO;
        if (self.type == NormalProduct) {
            if ([self isProductEnabled]) {
                self.addCarBtn.enabled = YES;
                self.buyNowBtn.enabled = YES;
            }
            else{
                self.addCarBtn.enabled = NO;
                self.buyNowBtn.enabled = NO;
            }
        }
        else if (self.type == BigSaleProduct)
        {
            if ([self isBigsaleProductEnabled]) {
                self.addCarBtn.enabled = YES;
                self.buyNowBtn.enabled = YES;
            }
            else{
                self.addCarBtn.enabled = NO;
                self.buyNowBtn.enabled = NO;
            }
        }

        if (self.buyNowBtn.enabled) {
            [self.buyNowBtn setTitle:L(@"Product_BuyNow") forState:UIControlStateNormal];
        }else {
            [self.buyNowBtn setTitle:L(@"Product_BuyNow") forState:UIControlStateDisabled];
        }
    }
    else if(self.type == PurchuseProduct)
    {
        self.addCarBtn.hidden = YES;
        self.CarBtn.hidden = NO;
        self.CarNumBtn.hidden = NO;
        
        [self.buyNowBtn setTitle:@"" forState:UIControlStateNormal];
        
        [self.buyNowBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self.buyNowBtn setBackgroundImage:[UIImage imageNamed:@"submit_button_normal.png"] forState:UIControlStateNormal];
        
        [self.buyNowBtn setBackgroundImage:[UIImage imageNamed:@"button_white_disable.png"] forState:UIControlStateDisabled];
        
//        [self.bottomNavBar addSubview:self.buyNowBtn];
        
        if (self.panicDTO.purchaseState == ReadyForSale) {
            
            self.stateStr = L(@"readyForSaleState");
            self.buyNowBtn.enabled = NO;
            
        }
        else if (self.panicDTO.purchaseState == SaleOut){
            
            self.stateStr = L(@"SK without ant piece");
            self.buyNowBtn.enabled = NO;
        }
        else if(self.panicDTO.purchaseState == OnSale){
            
            
            if (self.panicDTO.leftQty && 0 == [self.panicDTO.leftQty intValue]) {
                
                self.stateStr = L(@"SK without ant piece");
                self.buyNowBtn.enabled = NO;
            }
            //        else if(self.panicDTO.isSale && [self.panicDTO.isSale isEqualToString:@"0"]){
            //
            //            self.stateStr = @"我要抢";
            //            self.buyNowBtn.enabled = NO;
            //        }
            else{
                
                self.stateStr = L(@"Add QuickBuy");
                self.buyNowBtn.enabled = YES;
            }
        }
        else{
            
            self.stateStr = L(@"Product_Over");
            self.buyNowBtn.enabled = NO;
        }
        
        
        if ([self isPurchaseProductEnabled] == NO)
        {
            self.buyNowBtn.enabled = NO;
            
            return;
        }

    }
    else if (GroupProduct == self.type)
    {
        self.addCarBtn.hidden = YES;
        self.CarBtn.hidden = NO;
        self.CarNumBtn.hidden = NO;
        
        [self.buyNowBtn setTitle:@"" forState:UIControlStateNormal];
        
        
        [self.buyNowBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.buyNowBtn setBackgroundImage:[UIImage imageNamed:@"submit_button_normal.png"] forState:UIControlStateNormal];
        
        [self.buyNowBtn setBackgroundImage:[UIImage imageNamed:@"button_white_disable.png"] forState:UIControlStateDisabled];
        
//        [self.bottomNavBar addSubview:self.buyNowBtn];
        
        if ([self.detailDto.startFlag isEqualToString:kWillStart]) {
            
            self.stateStr = L(@"Product_LeftToBegin");
            self.buyNowBtn.enabled = NO;
            
        } else if ([self.detailDto.startFlag isEqualToString:kHaveStart]) {
            
            self.stateStr = L(@"Add GroupBuy");
            
            self.buyNowBtn.enabled = YES;
            
        }
        else if ([self.detailDto.startFlag isEqualToString:kNOGood]) {
            
            self.stateStr = L(@"Group buy is over");
            
            self.buyNowBtn.enabled = NO;
        }
        
        if ([self isProductEnabled] == NO)
        {
            self.buyNowBtn.enabled = NO;
            
            
        }
    }
    else if (AppointmentProduct == self.type)
    {
        self.addCarBtn.hidden = YES;
        self.CarBtn.hidden = NO;
        self.CarNumBtn.hidden = NO;
        self.buyNowBtn.hidden = NO;
        [self.buyNowBtn setTitle:@"" forState:UIControlStateNormal];
        
        [self.buyNowBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self.buyNowBtn setBackgroundImage:[UIImage imageNamed:@"submit_button_normal.png"] forState:UIControlStateNormal];
        
        [self.buyNowBtn setBackgroundImage:[UIImage imageNamed:@"button_white_disable.png"] forState:UIControlStateDisabled];
        
//        [self.bottomNavBar addSubview:self.buyNowBtn];
        
        if (self.appointmentDto.status == ReadyForAppointment) {
            
            self.stateStr = L(@"Product_WaitForPreOrder");
            [self.buyNowBtn setTitle:L(@"Product_WaitForPreOrder") forState:UIControlStateDisabled];
            self.buyNowBtn.enabled = NO;
            
        }
        else if (self.appointmentDto.status == OnAppointment){
            
            self.stateStr = L(@"Product_PreOrderNow");
            [self.buyNowBtn setTitle:L(@"Product_PreOrderNow") forState:UIControlStateNormal];
            self.buyNowBtn.enabled = YES;
        }
        else if(self.appointmentDto.status == ReadyForPurchase || self.appointmentDto.status == WaitPurchase){
            self.stateStr = L(@"Product_WaitForPurchase");
            [self.buyNowBtn setTitle:L(@"Product_WaitForPurchase") forState:UIControlStateDisabled];
            self.buyNowBtn.enabled = NO;
            
        }
        else if(self.appointmentDto.status == OnPurchase)
        {
            self.stateStr = L(@"Product_PurchaseNow");
            [self.buyNowBtn setTitle:L(@"Product_PurchaseNow") forState:UIControlStateNormal];
            self.buyNowBtn.enabled = YES;
        }
        else{
            
            self.stateStr = L(@"SK without ant piece");
            [self.buyNowBtn setTitle:L(@"SK without ant piece") forState:UIControlStateDisabled];
            self.buyNowBtn.enabled = NO;
        }
        
        if ([self isAppointmentProductEnabled] == NO)
        {
            self.buyNowBtn.enabled = NO;
            
            return;
        }
        
    }

}

//是否能抢购
- (BOOL)isPurchaseProductEnabled
{
    if(self.panicDTO.purchaseState ==  SaleOut
       || self.panicDTO.purchaseState == TimeOver)
    {
        return NO;
    }
    else
    {
        if (self.productInfoDto.isCShop)
        {
            if (self.productInfoDto.suningPrice.doubleValue > 0)
            {
                return YES;
            }
            else
            {
                return NO;
            }
        }
        else
        {
            if ([self.productInfoDto.hasStorage isEqualToString:@"Y"] &&
                ![self.productInfoDto.cityCode isEqualToString:@""] &&
                [self.productInfoDto.suningPrice doubleValue] > 0 &&
                self.productInfoDto.isPublished)
            {
                BOOL isEnabled;
                
                if (self.panicDTO.purchaseState == SaleOut) {
                    isEnabled = NO;
                }else{
                    isEnabled = YES;
                }
                return isEnabled;
                
            }
            else
            {
                return NO;
            }
        }
        
    }
}


//是否显示购物车数量按钮
-(void)refreshButtomView:(BOOL)showCarNum{
    if (showCarNum) {
        NSString *num = [NSString stringWithFormat:@"%i", [ShopCartV2ViewController sharedShopCart].logic.allProductQuantity];
        
        //设置购物车数量显示图片自适应大小
        CGRect rect = self.CarNumBtn.frame;
        
        if ([num intValue]>99) {
            num = [NSString stringWithFormat:@"99+"];
            self.CarNumBtn.titleLabel.font = [UIFont systemFontOfSize:10];
            rect.size.width = 22;
        }
        else
        {
            self.CarNumBtn.titleLabel.font = [UIFont systemFontOfSize:12];
            rect.size.width = 17;
        }
        rect.size.height = 17;
        rect.origin.x = 34 - rect.size.width/2;
        rect.origin.y = 2;
        
        if (self.type == NormalProduct) {
            self.buyNowBtn.frame = CGRectMake(10, 7, 127, 35);
            self.addCarBtn.frame = CGRectMake(147, 7, 122, 35);
            self.CarBtn.frame = CGRectMake(270, 5, 44, 44);
        }
        else if (self.type == BigSaleProduct)
        {
            self.buyNowBtn.frame = CGRectMake(10, 34, 127, 35);
            self.addCarBtn.frame = CGRectMake(147, 34, 122, 35);
            self.CarBtn.frame = CGRectMake(270, 30, 44, 44);
        }
        else
        {
            self.buyNowBtn.frame = CGRectMake(15, 34, 255, 35);
            self.CarBtn.frame = CGRectMake(270, 30, 44, 44);
            //            rect.origin.y = 2;
        }
        
        self.CarNumBtn.frame = rect;
        
        [self.CarNumBtn setTitle:[NSString stringWithFormat:@"%@",num] forState:UIControlStateNormal];
        
        [self.bottomNavBar addSubview:self.addCarBtn];
        [self.bottomNavBar addSubview:self.buyNowBtn];
        [self.bottomNavBar addSubview:self.CarBtn];
        [self.CarBtn addSubview:self.CarNumBtn];
        
        self.CarBtn.hidden = NO;
        self.CarNumBtn.hidden = NO;
    }
    else{
        [self.bottomNavBar addSubview:self.addCarBtn];
        [self.bottomNavBar addSubview:self.buyNowBtn];
        [self.bottomNavBar addSubview:self.CarBtn];
        
//        self.buyNowBtn.hidden = NO;
//        self.addCarBtn.hidden = NO;
        self.CarBtn.hidden = NO;
        self.CarNumBtn.hidden = YES;
        
        if (self.type == NormalProduct) {
            self.buyNowBtn.frame = CGRectMake(10, 7, 127, 35);
            self.addCarBtn.frame = CGRectMake(147, 7, 122, 35);
            self.CarBtn.frame = CGRectMake(270, 3, 44, 44);
        }
        else if (self.type == BigSaleProduct)
        {
            self.buyNowBtn.frame = CGRectMake(10, 34, 127, 35);
            self.addCarBtn.frame = CGRectMake(147, 34, 122, 35);
            self.CarBtn.frame = CGRectMake(270, 30, 44, 44);
        }
        else
        {
            self.buyNowBtn.frame = CGRectMake(15, 34, 255, 35);
            self.CarBtn.frame = CGRectMake(270, 30, 44, 44);
        }
    }
}

- (BOOL)isAppointmentProductEnabled
{
    if (self.appointmentDto.status == ReadyForAppointment
        || self.appointmentDto.status == ReadyForPurchase
        || self.appointmentDto.status == PurchaseTimeOver) {
        return NO;
    }
    else
    {
        if (self.appointmentDto.status == OnAppointment) {
            return YES;
        }
        else
        {
            return [self isProductEnabled];
        }
    }
}

- (BOOL)isBigsaleProductEnabled
{
    if (self.bigsaleDto.bigSaleState == BsReadyForSale
        || self.bigsaleDto.bigSaleState == BsTimeOver
        || self.bigsaleDto.bigSaleState == BsSaleOut)
    {
        return NO;
    }
    else
    {
        return [self isProductEnabled];
    }
}

//商品是否可买
- (BOOL)isProductEnabled
{
    /*
     * liukun modify  12-12-06  如果商品价格小于等于0，默认也是不可买的
     */
    if (self.productInfoDto.isCShop)
    {
        if ([self.productInfoDto.hasStorage isEqualToString:@"Z"]) {
            return NO;
        }
        else
        {
            if (self.productInfoDto.suningPrice.doubleValue > 0)
            {
                return YES;
            }
            else
            {
                return NO;
            }
        }
    }
    else
    {
        if ([self.productInfoDto.hasStorage isEqualToString:@"Y"] &&
            ![self.productInfoDto.cityCode isEqualToString:@""] &&
            [self.productInfoDto.suningPrice doubleValue] > 0 &&
            self.productInfoDto.isPublished)
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
}

//检查是否登录，如果未登录则弹出登录界面
- (BOOL)checkLogin
{
    if ([UserCenter defaultCenter].isLogined) {
        return YES;
    }else{
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        loginVC.loginDelegate = self;
        loginVC.loginDidOkSelector = loginSel;
        AuthManagerNavViewController *navController = [[AuthManagerNavViewController alloc] initWithRootViewController:loginVC];
        [self presentModalViewController:navController animated:YES];
        return NO;
    }
}

#pragma mark -
#pragma mark btn actions
- (void)beginEasyBuy
{
    if (NormalProduct == self.type || BigSaleProduct == self.type) {
        if (NormalProduct == self.type) {
            [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"121311"], nil]];
        }else if (BigSaleProduct == self.type)
        {
            
        }
        [self goToNextView:1];
    }
    else if (PurchuseProduct == self.type)
    {
         [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"121314"], nil]];
        [self checkLoginWithLoginedBlock:^{
            [self joinPanicPurchase];
        } loginCancelBlock:NULL];
    }
    else if (GroupProduct == self.type)
    {
        [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"121315"], nil]];
        [self checkLoginWithLoginedBlock:^{
            [self joinGroup];
        } loginCancelBlock:NULL];
        
    }
    else if (AppointmentProduct == self.type)
    {
        [self checkLoginWithLoginedBlock:^{
            [self appointmentAction];
        } loginCancelBlock:NULL];
    }

}

-(void)addToCar2{
    
    if ([self isProductEnabled] && [self checkLogin])
    {
        BuyNowCommand *command = [BuyNowCommand command];
        command.product = self.productInfoDto;
        command.sController = self;
        [CommandManage excuteCommand:command completeBlock:nil];
    }
}

-(void)addToCar{
    
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"121312"], nil]];
    [self goToNextView:2];
    
}

-(void)goToNextView:(NSInteger)carTypr{
    
    if (1 == carTypr) {
        [self checkLoginWithLoginedBlock:^{
            
            if ([self isProductEnabled])
            {
                BuyNowCommand *command = [BuyNowCommand command];
                command.product = self.productInfoDto;
                command.sController = self;
                [CommandManage excuteCommand:command completeBlock:nil];
            }
        } loginCancelBlock:NULL];
        
        return;
    }
    
    if (![self isProductEnabled])
    {
        return;
    }
    
    if (self.productInfoDto.cityCode.length == 0)
    {
        self.productInfoDto.cityCode = [[Config currentConfig] defaultCity];
    }
    
    self.CarBtn.enabled = NO;
    
    self.addCarBtn.enabled = NO;
    self.buyNowBtn.enabled = NO;
    self.CarBtn.enabled = NO;
    self.CarBtn.enabled = NO;
    
    SNOperationCallBackBlock block = ^(BOOL isSuccess, NSString *errorMsg){
        
        [self removeOverFlowActivityView];
        
        self.addCarBtn.enabled = YES;
        self.CarBtn.enabled = YES;
        self.buyNowBtn.enabled = YES;
        self.CarNumBtn.enabled = YES;
        
        if (isSuccess) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"changeCuViewProductDetailCarNum" object:nil];
            
            //[self playAnmationAndSoundForSuckEffect];
            BBAlertView *alert =[ [BBAlertView alloc]initWithTitle:nil message:L(@"Product_AddToCartSuccess") delegate:nil cancelButtonTitle:L(@"Ok") otherButtonTitles:L(@"Product_GoToShopCart")];
            
                [alert setConfirmBlock:^{

                    [[AppDelegate currentAppDelegate].tabBarViewController setSelectedIndex:3];
                    [(UINavigationController*)[[AppDelegate currentAppDelegate].tabBarViewController.viewControllers objectAtIndex:3] popToRootViewControllerAnimated:NO];
                }];

            [alert show];
            
        }else{
            [self presentCustomDlg:errorMsg];
        }
    };
    
    [self displayOverFlowActivityView];
    [self.shoppingCartBoard addProductToShoppingCart:self.productInfoDto
                                     completionBlock:block];
    
}

//刷新底部购物车数量按钮
- (void)refreshCarNumBtn
{
    if([ShopCartV2ViewController sharedShopCart].logic.allProductQuantity > 0)
    {
        [self refreshButtomView:YES];
    }
    else
    {
        [self refreshButtomView:NO];
    }
}

#pragma mark -
#pragma mark command delegate

- (void)joinPanicPurchase
{
    if([self isPurchaseProductEnabled] == NO)
    {
        return;
    }
    
    self.buyNowBtn.enabled = NO;
    if (self.productInfoDto.cityCode.length == 0)
    {
        self.productInfoDto.cityCode = [[Config currentConfig] defaultCity];
    }
    
    NSString *errorMsg = nil;
    
    BOOL canAddToShopCart = [self.shoppingCartBoard checkProductCanAddToShopCart:self.productInfoDto
                                                                        errorMsg:&errorMsg];
    if (canAddToShopCart)
    {
        [self displayOverFlowActivityView];
        
        NSString *userId=[UserCenter defaultCenter].userInfoDTO.userId;
        
        NSString *cityCode=self.productInfoDto.cityCode==nil?self.productInfoDto.cityCode:[Config currentConfig].defaultCity;
        
        self.productInfoDto.quickbuyId = self.panicDTO.rushPurId;
        
        [self.panicService beginGetPanicPurchaseLimitList:self.panicDTO.rushPurId
                                                   userId:userId
                                                   cityId:cityCode];
    }
    else
    {
        [self presentCustomDlg:errorMsg];
        self.buyNowBtn.enabled = YES;
    }
    
}

- (void)joinGroup
{
    
    if ([self.productInfoDto.hasStorage isEqualToString:@"N"]){
        [self presentSheet:L(@"Product_ProductNotEnough")];
        self.buyNowBtn.enabled = NO;
        return;
    }else if ([self.productInfoDto.hasStorage isEqualToString:@"Z"]){
        [self presentSheet:L(@"DJGroup_NotOnSale")];
        self.buyNowBtn.enabled = NO;
        return;
    }
    
    
    if (self.productInfoDto.cityCode.length == 0)
    {
        self.productInfoDto.cityCode = [[Config currentConfig] defaultCity];
    }
    
    self.productInfoDto.danjiaGroupId = self.detailDto.grpPurId;
    self.productInfoDto.qianggouPrice = [NSNumber numberWithDouble:[self.detailDto.displayPrice doubleValue]];
    
    NSString *errorMsg = nil;
    
    BOOL canAddToShopCart = [self.shoppingCartBoard checkProductCanAddToShopCart:self.productInfoDto
                                                                        errorMsg:&errorMsg];
    if (canAddToShopCart)
    {
        if ([UserCenter defaultCenter].efubaoStatus == eLoginByPhoneUnBound) {
            [self presentCustomDlg:L(@"Product_BindMobilePhoneAndBuy")];
            return;
        }
        
        [self displayOverFlowActivityView];
        DJGroupApplyDTO *applyDto = [[DJGroupApplyDTO alloc] init];
        applyDto.storeId = @"10052";
        applyDto.catalogId = @"10051";
        applyDto.groupId = self.detailDto.grpPurId;
        applyDto.catentryId = self.detailDto.catentryId;
        applyDto.amount = @"1";
        
        [self.groupApplyService beginSendDJGroupApplyRequest:applyDto];
    }
    else
    {
        [self presentCustomDlg:errorMsg];
    }
    
}

- (void)appointmentAction
{
    if (self.appointmentDto.status == OnAppointment) {
        
    }else if (self.appointmentDto.status == OnPurchase)
    {
        
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"time"]) {
        if (PurchuseProduct == self.type) {
            double seconds = [[change objectForKey:@"new"] floatValue];
            double leavingTime = 0;
            switch (self.panicDTO.purchaseState) {
                case ReadyForSale:
                {
                    leavingTime = (double)self.panicDTO.startTimeSeconds - seconds;
                    [self setTime:leavingTime];
                    break;
                }
                case OnSale:
                {
                    leavingTime = (double)self.panicDTO.endTimeSeconds - seconds;
                    [self setTime:leavingTime];
                    break;
                }
                case SaleOut:
                {
                    leavingTime = (double)self.panicDTO.endTimeSeconds - seconds;
                    [self setTime:leavingTime];
                    break;
                }
                case TimeOver:
                {
                    break;
                }
                default:
                    break;
            }
        }
        else if (GroupProduct == self.type)
        {
            if ([self.detailDto.startFlag isEqualToString:kNOGood] || [self.detailDto.startFlag isEqualToString:kHaveEnd]) {
                [self setTimer:0];
                return;
            }
            
            NSTimeInterval leavingTime = 0;
            
            if ([self.detailDto.startFlag isEqualToString:kWillStart]) {
                leavingTime = self.detailDto.startTimeSeconds - self.groupBuyCalculagraph.seconds;
                [self setTimer:leavingTime];
                
            } else if ([self.detailDto.startFlag isEqualToString:kHaveStart]){
                leavingTime = self.detailDto.endTimeSeconds - self.groupBuyCalculagraph.seconds;
                [self setTimer:leavingTime];
                
            }else if ([self.detailDto.startFlag isEqualToString:kNOGood]){
                leavingTime = self.detailDto.endTimeSeconds - self.groupBuyCalculagraph.seconds;
                [self setTimer:leavingTime];
                
            } else {
                [self setTimer:0];
                
                [self setTimer:leavingTime];
                
                return;
            }
            
            if (leavingTime < 1) {
                if ([self.detailDto.startFlag isEqualToString:kWillStart]) {
                    self.detailDto.startFlag = kHaveStart;
                }else if ([self.detailDto.startFlag isEqualToString:kHaveStart]){
                    self.detailDto.startFlag = kHaveEnd;
                }
                
                [self setTimer:leavingTime];
                
                return;
            }
            
            [self setTimer:leavingTime];
        }
        else if (BigSaleProduct == self.type)
        {
            double seconds = [[change objectForKey:@"new"] floatValue];
            double leavingTime = 0;
            switch (self.bigsaleDto.bigSaleState) {
                case BsReadyForSale:
                {
                    leavingTime = (double)self.bigsaleDto.startTimeSeconds - seconds;
                    [self setBigSaleTime:leavingTime];
                    break;
                }
                case BsOnSale:
                {
                    leavingTime = (double)self.bigsaleDto.endTimeSeconds - seconds;
                    [self setBigSaleTime:leavingTime];
                    break;
                }
                case BsSaleOut:
                {
                    leavingTime = (double)self.bigsaleDto.endTimeSeconds - seconds;
                    [self setBigSaleTime:leavingTime];
                    break;
                }
                case BsTimeOver:
                {
                    [self setBigSaleTime:0];
                    break;
                }
                default:
                    break;
            }

        }
        else if (AppointmentProduct == self.type)
        {
            double seconds = [[change objectForKey:@"new"] floatValue];
            double leavingTime = 0;
            switch (self.appointmentDto.status) {
                case ReadyForAppointment:
                {
                    leavingTime = (double)self.appointmentDto.scheduleStartTimeSeconds - seconds;
                    [self setAppointmentTime:leavingTime];
                    break;
                }
                case OnAppointment:
                {
                    leavingTime = (double)self.appointmentDto.scheduleEndTimeSeconds - seconds;
                    [self setAppointmentTime:leavingTime];
                    break;
                }
                case ReadyForPurchase:
                {
                    leavingTime = (double)self.appointmentDto.startTimeSeconds - seconds;
                    [self setAppointmentTime:leavingTime];
                    break;
                }
                case OnPurchase:
                {
                    leavingTime = (double)self.appointmentDto.endTimeSeconds - seconds;
                    [self setAppointmentTime:leavingTime];
                    break;
                }
                case PurchaseTimeOver:
                {
                    [self setAppointmentTime:leavingTime];
                    break;
                }
                case WaitPurchase:
                {
                    [self setAppointmentTime:leavingTime];
                    break;
                }
                default:
                    break;
            }
            
        }
        
    }
    else if ([keyPath isEqualToString:@"purchaseState"])
    {
        [self refreshBtn];
        
    }
}

-(void)setStateStr:(NSString *)stateStr{
    
    _stateStr = stateStr;
    
    if (self.buyNowBtn.enabled) {
        [self.buyNowBtn setTitle:[NSString stringWithFormat:@"    %@    %@",_stateStr,_timeStr?_timeStr:@""] forState:UIControlStateNormal];
    }else {
        [self.buyNowBtn setTitle:[NSString stringWithFormat:@"    %@    %@",_stateStr,_timeStr?_timeStr:@""] forState:UIControlStateDisabled];
    }
}

-(void)setTimeStr:(NSString *)timeStr{
    
    _timeStr = timeStr;
    
    if (self.buyNowBtn.enabled) {
        [self.buyNowBtn setTitle:[NSString stringWithFormat:@"    %@    %@",_stateStr,_timeStr?_timeStr:@""] forState:UIControlStateNormal];
    }else {
        [self.buyNowBtn setTitle:[NSString stringWithFormat:@"    %@    %@",_stateStr,_timeStr?_timeStr:@""] forState:UIControlStateDisabled];
    }
    
}

//预约计算时间
- (void)setAppointmentTime:(double)seconds
{
    if (self.appointmentDto.status == PurchaseTimeOver) {
        [self.timView calculagraphTime:0];
        [self.timView hiddenTimeLabel:L(@"Panic_Purchase_Finished")];
        return;
    }
    
    if (self.appointmentDto.status == WaitPurchase) {
        [self.timView calculagraphTime:0];
        [self.timView hiddenTimeLabel:L(@"Product_PurchaseTimeNotDecided")];
        return;
    }
    if (seconds < 1 ) {
        if (self.appointmentDto.status == ReadyForAppointment) {
            self.appointmentDto.status = OnAppointment;
            [self.timView setState:2];
            [self refreshBtn];
            return;
        }
        else if (self.appointmentDto.status == ReadyForPurchase)
        {
            self.appointmentDto.status = OnPurchase;
            [self.timView setState:4];
            [self refreshBtn];
        }
        else if (self.appointmentDto.status == OnAppointment){
            
            if (IsStrEmpty(self.appointmentDto.purchaseStarttime) || IsStrEmpty(self.appointmentDto.purchaseEndtime)) {
                self.appointmentDto.status = WaitPurchase;
                [self.timView hiddenTimeLabel:L(@"Product_PurchaseTimeNotDecided")];
                return;
            }
            self.appointmentDto.status = ReadyForPurchase;
            [self.timView setState:3];
            [self refreshBtn];
            return;
        }
        else if (self.appointmentDto.status == OnPurchase)
        {
            self.appointmentDto.status = PurchaseTimeOver;
            [self.timView hiddenTimeLabel:L(@"Panic_Purchase_Finished")];
            [self refreshBtn];
            return;
        }
    }
    
    if (self.appointmentDto.status == ReadyForAppointment) {
        [self.timView calculagraphTime:seconds];
        [self.timView setState:1];
    }
    else if (self.appointmentDto.status == OnAppointment)
    {
        [self.timView calculagraphTime:seconds];
        [self.timView setState:2];
    }
    else
    {
        if(self.appointmentDto.status == ReadyForPurchase || self.appointmentDto.status == OnPurchase)
        {
            if (self.appointmentDto.status == ReadyForPurchase) {
                [self.timView setState:3];
            }else if (self.appointmentDto.status == OnPurchase)
            {
                [self.timView setState:4];
            }
            
            if (self.productInfoDto.isCShop) {
                [self.timView calculagraphTime:seconds];
            }
            else
            {
                if (self.productInfoDto.isPublished && [[self.productInfoDto hasStorage] isEqualToString:@"Y"]) {
                    [self.timView calculagraphTime:seconds];
                }
                else
                {
                    [self.timView calculagraphTime:0];
                    return;
                }
            }
            
        }
    }
    
}


//大聚惠计算时间
- (void)setBigSaleTime:(double)seconds
{
    if (self.bigsaleDto.bigSaleState == BsTimeOver) {
        [self.timView calculagraphTime:0];
        return;
    }
    
    if (seconds < 1 ) {
        if (self.bigsaleDto.bigSaleState == BsReadyForSale) {
            self.bigsaleDto.bigSaleState = BsOnSale;
            [self refreshBtn];
        }
        else if (self.bigsaleDto.bigSaleState == BsOnSale|| self.bigsaleDto.bigSaleState == BsSaleOut){
            self.bigsaleDto.bigSaleState = BsTimeOver;
            [self refreshBtn];
        }
    }
    
    if(self.bigsaleDto.bigSaleState == BsOnSale|| self.bigsaleDto.bigSaleState == BsSaleOut
       || self.bigsaleDto.bigSaleState == BsReadyForSale)
    {
        if (self.productInfoDto.isCShop) {
            [self.timView calculagraphTime:seconds];
        }
        else
        {
            if (self.productInfoDto.isPublished && [[self.productInfoDto hasStorage] isEqualToString:@"Y"]) {
                [self.timView calculagraphTime:seconds];
            }
            else
            {
                [self.timView calculagraphTime:0];
                return;
            }
        }
    }else{
        [self.timView calculagraphTime:0];
    }
}

//抢购计算时间
- (void)setTime:(double)seconds
{
    if (self.panicDTO.purchaseState == TimeOver) {
        
        return;
    }
    
    if (seconds < 1 && self.isLoadPurchase) {
        if (self.panicDTO.purchaseState == ReadyForSale) {
            self.panicDTO.purchaseState = OnSale;
            
            [self refreshBtn];
            
        }
        else if (self.panicDTO.purchaseState == OnSale|| self.panicDTO.purchaseState == SaleOut){
            
            self.panicDTO.purchaseState = TimeOver;
            
            self.stateStr = L(@"Product_Over");
            self.buyNowBtn.enabled = NO;
            
        }
    }
    
    if(self.panicDTO.purchaseState == OnSale|| self.panicDTO.purchaseState == SaleOut
       || self.panicDTO.purchaseState == ReadyForSale)
    {
        if (self.productInfoDto.isCShop) {
            [self.timView calculagraphTime:seconds];
        }
        else
        {
            if (self.productInfoDto.isPublished && [[self.productInfoDto hasStorage] isEqualToString:@"Y"]) {
                [self.timView calculagraphTime:seconds];
            }
            else
            {
                [self.timView calculagraphTime:0];
            }
        }
    }else{
        [self.timView calculagraphTime:0];
    }
}

//团购计算时间
- (void)setTimer:(NSTimeInterval)seconds
{
    if ([self.detailDto.startFlag isEqualToString:@"3"] || [self.detailDto.startFlag isEqualToString:@"4"] || (seconds == 0)){
        if (self.buyNowBtn.enabled) {
            [self.buyNowBtn setTitle:L(@"Group buy is over") forState:UIControlStateNormal];
        }else {
            [self.buyNowBtn setTitle:L(@"Group buy is over") forState:UIControlStateDisabled];
        }
        self.buyNowBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        self.buyNowBtn.enabled = NO;
        [self.timView calculagraphTime:seconds];
        return;
    }
    
    if ([self.detailDto.startFlag isEqualToString:kWillStart]) {
        self.stateStr = L(@"Ready to start");
        self.buyNowBtn.enabled = NO;
        [self.timView calculagraphTime:seconds];
        
    } else if ([self.detailDto.startFlag isEqualToString:kHaveStart]) {
        self.stateStr = L(@"Add GroupBuy");
        [self.timView calculagraphTime:seconds];
        self.buyNowBtn.enabled = YES;
        if ([self isProductEnabled] == NO)
        {
            self.buyNowBtn.enabled = NO;
        }
    }
    else if ([self.detailDto.startFlag isEqualToString:kNOGood]) {
        
        self.stateStr = L(@"Group buy is over");
        [self.timView calculagraphTime:0];
        self.buyNowBtn.enabled = NO;
    }
}

//“我要抢”按钮
- (void)addtoShoppingCart2
{
    //    if (nil == self.productBase || [self.productBase.hasStorage isEqualToString:@"N"])
    //    {
    //        return;
    //    }
    
    if([self isPurchaseProductEnabled] == NO)
    {
        return;
    }
    
    if (self.productInfoDto.cityCode.length == 0)
    {
        self.productInfoDto.cityCode = [[Config currentConfig] defaultCity];
    }
    
    SNOperationCallBackBlock block = ^(BOOL isSuccess, NSString *errorMsg){
        if (isSuccess) {
            
            BBAlertView *alert =[ [BBAlertView alloc]initWithTitle:nil message:L(@"Product_PurchasePayInThirtyMinute") delegate:nil cancelButtonTitle:L(@"Ok") otherButtonTitles:L(@"Product_GoToShopCart")];
            [alert show];
            [alert setConfirmBlock:^{
                
                [[AppDelegate currentAppDelegate].tabBarViewController setSelectedIndex:3];
                [(UINavigationController*)[[AppDelegate currentAppDelegate].tabBarViewController.viewControllers objectAtIndex:3] popToRootViewControllerAnimated:NO];
            }];
            [alert setCancelBlock:^{
                
                [self refreshBtn];
                
            }];
        }
        else{
            [self presentCustomDlg:errorMsg];
        }
    };
    
    [self.shoppingCartBoard addProductToShoppingCart:self.productInfoDto
                                     completionBlock:block];
    
}

#pragma mark -
#pragma mark servicedelegate

- (void)getPanicPurchaseLimitCompletionWithResult:(BOOL)isSuccess errorCode:(NSString *)errorCode  errorMsg:(NSString*)errorMsg flag:(NSString *)flag rushProcessId:(NSString *)rushProcessId
{
    [self removeOverFlowActivityView];
    self.buyNowBtn.enabled = YES;
    if(isSuccess)
    {
        if([flag isEqualToString:@"0"])
        {
            self.productInfoDto.qianggouPrice = [NSNumber numberWithDouble:[self.panicDTO.rushPurPrice doubleValue]];
            self.productInfoDto.rushProcessId = rushProcessId;
            [self addtoShoppingCart2];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"joinPanicPurchase" object:nil];
            
            [self refreshBtn];
        }else{
            
            if([errorCode isEqualToString:@"2"]||[errorCode isEqualToString:@"3"]||[errorCode isEqualToString:@"5"])
            {
                [self presentSheet:L(@"panicPurchase over")];
                
            }else if([errorCode isEqualToString:@"4"])
            {
                [self presentSheet:L(@"user had panic")];
                
            }else if([errorCode isEqualToString:@"6"])
            {
                [self presentSheet:L(@"city not sale")];
                
            }else if([errorCode isEqualToString:@"1"]||[errorCode isEqualToString:@"7"]||[errorCode isEqualToString:@"8"])
            {
                [self presentSheet:L(@"sorry panic failed")];
            }
            else if([errorCode isEqualToString:@"9"]){
                
                [self presentSheet:L(@"panicPurchase not start")];
            }else if([errorCode isEqualToString:@"10"]){
                
                [self presentSheet:L(@"userId failed")];
            }else if([errorCode isEqualToString:@"11"]){
                
                [self presentSheet:L(@"panicPurchase not support client")];
            }else if([errorCode isEqualToString:@"12"]){
                
                [self presentSheet:L(@"panicPurchase not support mobile")];
            }else {
                
                if (IsNilOrNull(errorMsg)) {
                    errorMsg = L(@"sorry panic failed");
                }
                [self presentSheet:errorMsg];
            }
        }
    }else {
        
        [self presentSheet:errorMsg];
        
    }
    
    [self refreshBtn];
    
}

//点击我要团按钮后返回的数据
- (void)didSendDJGroupApplyRequestComplete:(DJGroupApplyService *)service  Result:(BOOL)isSuccess
{
    [self removeOverFlowActivityView];
    
    if(isSuccess)
    {
        NSString *flag = service.result;
        
        if([flag isEqualToString:@"1"])
        {
            self.productInfoDto.qianggouPrice = [NSNumber numberWithDouble:[self.detailDto.displayPrice doubleValue]];
            [self addtoShoppingCart];
            
        }else {
            if([flag isEqualToString:@"2"]){
                [self presentSheet:L(@"Product_NotLogin")];
            }else if([flag isEqualToString:@"3"]){
                [self presentSheet:L(@"Product_BindMobilePhoneAndBuy")];
            }else if([flag isEqualToString:@"4"]){
                [self presentSheet:L(@"Product_NotFoundActivity")];
            }else if([flag isEqualToString:@"5"]){
                [self presentSheet:L(@"Product_GroupNotEffective")];
            }else if([flag isEqualToString:@"6"]){
                [self presentSheet:L(@"Product_BeyondTheLimit")];
            }else if([flag isEqualToString:@"7"]){
                [self presentSheet:L(@"Product_GroupNumNotEnough")];
            }else {
                [self presentSheet:L(@"Product_GroupFailed")];
            }
        }
    }else {
        
        [self presentSheet:L(@"Product_GroupFailed")];
        
    }
    
    [self refreshBtn];
    
}

//我要团事件
- (void)addtoShoppingCart
{
    if (nil == self.productInfoDto || [self.productInfoDto.hasStorage isEqualToString:@"N"])
    {
        return;
    }
    if (self.productInfoDto.cityCode.length == 0)
    {
        self.productInfoDto.cityCode = [[Config currentConfig] defaultCity];
    }
    
    SNOperationCallBackBlock block = ^(BOOL isSuccess, NSString *errorMsg){
        if (isSuccess) {
            BBAlertView *alert = [[BBAlertView alloc] initWithStyle:BBAlertViewStyleDefault
                                                              Title:L(@"system-info")
                                                            message:L(@"Product_AlreadyAddedToShopCart")
                                                         customView:nil
                                                           delegate:nil
                                                  cancelButtonTitle:L(@"Confirm")
                                                  otherButtonTitles:L(@"Product_GoToShopCart")];
            [alert show];
            [alert setConfirmBlock:^{
                
                [[AppDelegate currentAppDelegate].tabBarViewController setSelectedIndex:3];
                [(UINavigationController*)[[AppDelegate currentAppDelegate].tabBarViewController.viewControllers objectAtIndex:3] popToRootViewControllerAnimated:NO];
            }];
            [alert setCancelBlock:^{
                
            }];
            
            [self refreshBtn];
            
        }else{
            [self presentCustomDlg:errorMsg];
        }
    };
    
    if (self.productInfoDto.danjiaGroupId.length == 0)
    {
        self.productInfoDto.danjiaGroupId = self.detailDto.grpPurId;
    }
    
    if (self.productInfoDto.danjiaGroupId.length)
    {
        [self.shoppingCartBoard addProductToShoppingCart:self.productInfoDto
                                         completionBlock:block];
    }
    
    [self refreshBtn];
    
}

@end
