//
//  AllOrderListViewController.m
//  SuningEBuy
//
//  Created by xmy on 28/1/14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "AllOrderListViewController.h"


@interface AllOrderListViewController ()

@end

@implementation AllOrderListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.hasSuspendButton = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView
{
    [super loadView];
 
    
//    self.view.frame = [self visibleBoundsShowNav:self.hasNav showTabBar:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //self.navigationController.navigationBarHidden = YES;
}

- (id)initWithData:(NSString*)orderStatus WithSelect:(OrderSelectDownType)row
{
    self = [super init];
    
    if(self)
    {
        self.orderStatus = orderStatus;
        
        self.selectRow = row;
        
//        [self.arrowImg setBackgroundImage:[UIImage imageNamed:@"gray_up_arrow.png"] forState:UIControlStateNormal];
        
        [self.arrowImg setBackgroundImage:[UIImage imageNamed:@"Order_down_grayArrow.png"] forState:UIControlStateNormal];

        if(self.selectRow == 0)
        {
            [self.orderStytleBtn setTitle:L(@"MyEBuy_GoodsOrder") forState:UIControlStateNormal];

        }
        else
        {
            [self.orderStytleBtn setTitle:L(@"MyEBuy_GroupLife") forState:UIControlStateNormal];

        }
        
        self.orderSelectDownVC.selectRow = self.selectRow;

        [self.orderStytleBtn addSubview:self.arrowImg];
        
        self.navigationItem.titleView = self.orderStytleBtn;
        
        self.isLastPage = YES;
        
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"member_myEbuy"),self.title];
        
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    [self changeOrderListView:self.selectRow];
}

- (CGRect)setViewFrame:(BOOL)hasNav
{
    CGRect newframe = self.view.frame;
    
    if(hasNav == NO)
    {
        //        origin=(x=0, y=0) size=(width=320, height=548)
        newframe = CGRectMake(newframe.origin.x, newframe.origin.y, newframe.size.width, newframe.size.height-48);
    }
    else
    {
        //        origin=(x=0, y=0) size=(width=320, height=504)
        CGRect  frame = CGRectMake(newframe.origin.x, newframe.origin.y, newframe.size.width, newframe.size.height-48);
        
        return frame;
    }
    
    
    return newframe;
}



#pragma mark -
#pragma bottomView
//- (UIView*)bottomView
//{
//    if(!_bottomView)
//    {
//        _bottomView = [[UIView alloc] init];
//        
//        _bottomView.backgroundColor = [UIColor whiteColor];
//        
//        _bottomView.frame = CGRectMake(0, self.view.frame.size.height - 48, self.view.frame.size.width, 48);
//        
//        [_bottomView addSubview:self.bottomCell];
//        
//    }
//    
//    return _bottomView;
//}


- (void)goToMyEbuy
{

    [self orderYiGouBtnShowRightSideView];
    
//    [[AppDelegate currentAppDelegate].tabBarViewController setSelectedIndex:4];
//    
//    [(UINavigationController*)[[AppDelegate currentAppDelegate].tabBarViewController.viewControllers objectAtIndex:4] popToRootViewControllerAnimated:NO];

    
}

- (void)backBtnAction
{
    [self backForePage];
}

- (OrderDetailBottomCell*)bottomCell
{
    static NSString *str = @"OrderDetailBottomCell_List";
    
    if(!_bottomCell)
    {
        _bottomCell = [[OrderDetailBottomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        
        _bottomCell.frame = CGRectMake(0, 0, self.view.frame.size.width, 48);
        
        _bottomCell.userInteractionEnabled = YES;
        
        _bottomCell.contentView.userInteractionEnabled = YES;
        [_bottomCell.backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
        
        [_bottomCell.yiGouBtn addTarget:self action:@selector(goToMyEbuy) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    [_bottomCell setListBottomCellInfo];
    
    return _bottomCell;
}

#pragma mark -
#pragma viewControllers
- (ProOrderListViewController*)proOrderListVC
{
    if(!_proOrderListVC) {
        _proOrderListVC = [[ProOrderListViewController alloc] initWithOrderStatus:self.orderStatus];
    }
    
    return _proOrderListVC;
}

- (NShopOrderListViewController*)shopListVC
{
    if(!_shopListVC)
    {
        _shopListVC = [[NShopOrderListViewController alloc] init];
        
//        _shopListVC.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y-64-20-44, self.view.frame.size.width, self.view.frame.size.height-92);
        
    }
    
    return _shopListVC;
}
- (MobilePayQueryViewController*)mobileVC
{
    if(!_mobileVC)
    {
        _mobileVC = [[MobilePayQueryViewController alloc] init];
        
//        _mobileVC.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y-64, self.view.frame.size.width, self.view.frame.size.height-92);
        
        _mobileVC.view.frame = [self visibleBoundsShowNav:self.hasNav showTabBar:NO];
    }
    
    return _mobileVC;
}

- (LotteryDealsViewController*)lotteryVC
{
    if(!_lotteryVC)
    {
        _lotteryVC = [[LotteryDealsViewController alloc]initDataCaiPiao];
        _lotteryVC.isFormLotteryHall = NO;
        
        [self addChildViewController:_lotteryVC];
        
    }
    
    return _lotteryVC;
}
- (GBOrderListViewController*)groupBuyVC
{
    if(!_groupBuyVC)
    {
        _groupBuyVC = [[GBOrderListViewController alloc] init];
        
    }
    
    return _groupBuyVC;
}

- (PayServiceQueryViewController*)waterPayVC
{
    if(!_waterPayVC)
    {
        _waterPayVC = [[PayServiceQueryViewController alloc] init];
        
        _waterPayVC.isBottomView = NO;
        
    }
    
    return _waterPayVC;
}

- (MyTicketListViewController*)planeOrderVC
{
    if(!_planeOrderVC)
    {
        _planeOrderVC = [[MyTicketListViewController alloc] init];
        _planeOrderVC.isFromAllOrderCenter = YES;
    }
    
    return _planeOrderVC;
}
- (HotelOrderListViewController*)hotelVC
{
    if(!_hotelVC)
    {
        _hotelVC = [[HotelOrderListViewController alloc] init];
        _hotelVC.isFromAllOrderCenter=YES;
        
    }
    
    return _hotelVC;
}

- (SNWebViewController*)manzuoVC
{
    if(!_manzuoVC)
    {
        NSString *mymanzuoUrl = [NSString stringWithFormat:@"%@?sysCode=%@&targetUrl=%@&mode=restrict",kPassportTrustLoginUrl,kSysCodeForManzuo,kHostForManZuoOrderList];
        _manzuoVC = [[SNWebViewController alloc] initWithType:SNWebViewTypeManZuo attributes:@{@"url": mymanzuoUrl}];
        
    }
    
    return _manzuoVC;
}


#pragma mark --- 展示界面的切换
- (void)changeOrderListView:(OrderSelectDownType)selectType
{

    if([SNSwitch isOpenShopOrderList] == YES)
    {
        switch (selectType) {
            case eProductOrderList:
            {
                [self.view removeAllSubviews];
                
                self.proOrderListVC.hasNav = self.hasNav;
                [self.view addSubview:self.proOrderListVC.view];
            }
                break;
                
            case eShopOrderList:
            {
                [self.view removeAllSubviews];
                self.shopListVC.hasNav = self.hasNav;
                [self.view addSubview:self.shopListVC.view];
                
            }
                break;
                
            case eMobileFeeOrderList:
            {
                [self.view removeAllSubviews];
                self.mobileVC.hasNav = self.hasNav;
                [self.view addSubview:self.mobileVC.view];
                
            }
                break;
                
            case eCaiPiaoOrderList:
            {
                [self.view removeAllSubviews];
                self.lotteryVC.hasNav = self.hasNav;
                
                [self.view addSubview:self.lotteryVC.view];
                
            }
                break;
            
//            case eTuanGouOrderList:
//            {
//                [self.view removeAllSubviews];
//                self.groupBuyVC.hasNav = self.hasNav;
//                
//                [self.view addSubview:self.groupBuyVC.view];
//            }
//                break;
            case eWaterOrderList:
            {
                [self.view removeAllSubviews];
                
                self.payServiceDto.typeCode = [NSString stringWithFormat:@"0%d",1];
                
                self.waterPayVC.typeCode = self.payServiceDto.typeCode;
                self.waterPayVC.hasNav = self.hasNav;
                
                [self.view addSubview:self.waterPayVC.view];
                
                
            }
                break;
                
            case eElectricOrderList:
            {
                [self.view removeAllSubviews];
                self.waterPayVC.hasNav = self.hasNav;
                
                self.payServiceDto.typeCode = [NSString stringWithFormat:@"0%d",2];
                
                self.waterPayVC.typeCode = self.payServiceDto.typeCode;
                
                [self.view addSubview:self.waterPayVC.view];
                
            }
                break;
                
            case eGasOrderList:
            {
                [self.view removeAllSubviews];
                self.waterPayVC.hasNav = self.hasNav;
                
                self.payServiceDto.typeCode = [NSString stringWithFormat:@"0%d",3];
                
                self.waterPayVC.typeCode = self.payServiceDto.typeCode;
                
                [self.view addSubview:self.waterPayVC.view];
                
            }
                break;
                
            case ePlaneOrderList:
            {
                [self.view removeAllSubviews];
                self.planeOrderVC.hasNav = self.hasNav;
                
                [self.view addSubview:self.planeOrderVC.view];
                
            }
                break;
                
            case eHotelOrderList:
            {
                [self.view removeAllSubviews];
                self.hotelVC.hasNav = self.hasNav;
                
                [self.view addSubview:self.hotelVC.view];
                
            }
                break;
                
            case eReturnGoodsOrderList:
            {
                //展示退货中订单
                //            self.view.frame = [self visibleBoundsShowNav:self.hasNav showTabBar:NO];
            }
                break;
                
            case eWaitPingJiaList:
            {
                //            self.view.frame = [self visibleBoundsShowNav:self.hasNav showTabBar:NO];
                
            }
                break;
            case eManzuoOrderList:
            {
                [self.view removeAllSubviews];
                self.manzuoVC.hasNav = self.hasNav;
                
                [self.view addSubview:self.manzuoVC.view];
            }
                break;
            default:
            {
                [self.view removeAllSubviews];
                self.proOrderListVC.hasNav = self.hasNav;
                [self.view addSubview:self.proOrderListVC.view];
                //            if(self.hasNav == NO)
                //            {
                //                self.view.frame = [self visibleBoundsShowNav:self.hasNav showTabBar:NO];
                //                
                //            }
                //            else
                //            {
                //                
                //            }
                
            }
                break;
        }

    }
    else
    {
        switch (selectType) {
            case eProductOrderList:
            {
                [self.view removeAllSubviews];
                
                self.proOrderListVC.hasNav = self.hasNav;
                [self.view addSubview:self.proOrderListVC.view];
                
                //            if(self.hasNav == NO)
                //            {
                //                self.view.frame = [self visibleBoundsShowNav:self.hasNav showTabBar:NO];
                //
                //            }
                //            else
                //            {
                //
                //            }
                
            }
                break;
                
            case eShopOrderList:
            {
                [self.view removeAllSubviews];
                self.mobileVC.hasNav = self.hasNav;
                [self.view addSubview:self.mobileVC.view];
                
            }
                break;
                
            case eMobileFeeOrderList:
            {
                [self.view removeAllSubviews];
                self.lotteryVC.hasNav = self.hasNav;
                
                [self.view addSubview:self.lotteryVC.view];
                
            }
                break;
                
            case eCaiPiaoOrderList:
            {
                [self.view removeAllSubviews];
                self.groupBuyVC.hasNav = self.hasNav;
                
                [self.view addSubview:self.groupBuyVC.view];
                
            }
                break;
                
//            case eTuanGouOrderList:
//            {
//                [self.view removeAllSubviews];
//                
//                self.payServiceDto.typeCode = [NSString stringWithFormat:@"0%d",1];
//                
//                self.waterPayVC.typeCode = self.payServiceDto.typeCode;
//                self.waterPayVC.hasNav = self.hasNav;
//                
//                [self.view addSubview:self.waterPayVC.view];
//
//            }
//                break;
//                
            case eWaterOrderList:
            {
                [self.view removeAllSubviews];
                self.waterPayVC.hasNav = self.hasNav;
                
                self.payServiceDto.typeCode = [NSString stringWithFormat:@"0%d",2];
                
                self.waterPayVC.typeCode = self.payServiceDto.typeCode;
                
                [self.view addSubview:self.waterPayVC.view];

                
            }
                break;
                
            case eElectricOrderList:
            {
                [self.view removeAllSubviews];
                self.waterPayVC.hasNav = self.hasNav;
                
                self.payServiceDto.typeCode = [NSString stringWithFormat:@"0%d",3];
                
                self.waterPayVC.typeCode = self.payServiceDto.typeCode;
                
                [self.view addSubview:self.waterPayVC.view];
            }
                break;
                
            case eGasOrderList:
            {
                [self.view removeAllSubviews];
                self.planeOrderVC.hasNav = self.hasNav;
                
                [self.view addSubview:self.planeOrderVC.view];
                
            }
                break;
                
            case ePlaneOrderList:
            {
                [self.view removeAllSubviews];
                self.hotelVC.hasNav = self.hasNav;
                
                [self.view addSubview:self.hotelVC.view];
                
            }
                break;
                
            case eHotelOrderList:
            {
               
                
            }
                break;
                
            case eReturnGoodsOrderList:
            {
                
            }
                break;
                
            case eWaitPingJiaList:
            {
                
            }
                break;
            case eManzuoOrderList:
            {
                [self.view removeAllSubviews];
                self.manzuoVC.hasNav = self.hasNav;
                
                [self.view addSubview:self.manzuoVC.view];
            }
                break;
            default:
            {
                [self.view removeAllSubviews];
                self.proOrderListVC.hasNav = self.hasNav;
                [self.view addSubview:self.proOrderListVC.view];
            }
                break;
        }

    }
    
    self.orderSelectDownVC.view.hidden = YES;
    
    [self.view addSubview:self.orderSelectDownVC.view];

//    self.bottomNavBar.frame = CGRectMake(0, self.view.frame.size.height - 48, self.view.frame.size.width, 48);
//    
//    [self useBottomNavBar];
//    [self.bottomNavBar addSubview:self.bottomCell];
//    
//    [self.view addSubview:self.bottomView];

}


- (PayServiceDTO *)payServiceDto
{
    if(!_payServiceDto)
    {
        _payServiceDto = [[PayServiceDTO alloc] init];
    }
    
    return _payServiceDto;
}

- (void)setBtnPropetry:(UIButton*)btn
{
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor colorWithRGBHex:0x313131] forState:UIControlStateNormal];
    
    [btn.titleLabel setFont:[UIFont systemFontOfSize:21]];
    
    btn.selected = NO;
    
    [btn addTarget:self action:@selector(downSelectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    btn.backgroundColor = [UIColor clearColor];
    
}
- (UIButton*)orderStytleBtn
{
    if(!_orderStytleBtn)
    {
        _orderStytleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [self setBtnPropetry:_orderStytleBtn];
        
        if(self.selectRow == 0)
        {
            [_orderStytleBtn setTitle:L(@"MyEBuy_GoodsOrder") forState:UIControlStateNormal];
            
        }
        _orderStytleBtn.frame = CGRectMake(0, 0, 200, 30);
        
        _orderStytleBtn.tag = 1;
        
    }
    
    return _orderStytleBtn;
}

- (UIButton*)arrowImg
{
    if(!_arrowImg)
    {
        _arrowImg = [[UIButton alloc] initWithFrame:CGRectMake(self.orderStytleBtn.titleLabel.right + 10, 10 , 8.5, 6.5)];
        
        [self setBtnPropetry:_arrowImg];
        [_arrowImg setBackgroundImage:[UIImage imageNamed:@"Order_down_grayArrow.png"] forState:UIControlStateNormal];
        
    }
    _arrowImg.frame = CGRectMake(self.orderStytleBtn.titleLabel.right + 10, 10 , 12, 8);
    _arrowImg.userInteractionEnabled = YES;
    
    return _arrowImg;
}


#pragma mark -
#pragma  下拉按钮触发事件
-(void)btnsImage
{
    self.orderStytleBtn.selected = !self.orderStytleBtn.selected;
    self.arrowImg.selected = !self.arrowImg.selected;
    [self.arrowImg setBackgroundImage:[UIImage imageNamed:@"Order_down_grayArrow.png"] forState:UIControlStateNormal];
    
}

- (void)selectedAllOrderStyleOrTime:(NSString *)str WithRow:(NSInteger)row
{
    self.orderStytleBtn.selected = !self.orderStytleBtn.selected;
    self.arrowImg.selected = !self.arrowImg.selected;
    
    [self.orderStytleBtn setTitle:str forState:UIControlStateNormal];
    
    [self.orderStytleBtn setTitle:str forState:UIControlStateHighlighted];
    
    [self.arrowImg setBackgroundImage:[UIImage imageNamed:@"Order_down_grayArrow.png"] forState:UIControlStateNormal];
    
    [self.arrowImg setBackgroundImage:[UIImage imageNamed:@"Order_down_grayArrow.png"] forState:UIControlStateHighlighted];

    self.selectRow = row;
    
    [self changeOrderListView:row];
    
}

- (void)downSelectBtnAction:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    
    btn.selected = !btn.selected;
    
    self.orderStytleBtn.selected = btn.selected;
    self.arrowImg.selected = btn.selected;
    if(btn.selected == YES)
    {
        
        [self.arrowImg setBackgroundImage:[UIImage imageNamed:@"Order_up_grayArrow.png"] forState:UIControlStateNormal];

    }
    else
    {
        [self.arrowImg setBackgroundImage:[UIImage imageNamed:@"Order_down_grayArrow.png"] forState:UIControlStateNormal];

    }
    
    
    [self.view bringSubviewToFront:self.orderSelectDownVC.view];
    
    self.orderSelectDownVC.view.hidden = !btn.selected;
    
    [self.orderSelectDownVC.tableView reloadData];
}

- (AllOrderDownSelectViewController*)orderSelectDownVC
{
    if(!_orderSelectDownVC)
    {
        _orderSelectDownVC = [[AllOrderDownSelectViewController alloc] init];
        
       
        _orderSelectDownVC.view.frame = CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.height);

            
        _orderSelectDownVC.delegate = self;
        
        if(IOS7_OR_LATER)
        {
            
        }
        else
        {
            _orderSelectDownVC.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        }
        
        _orderSelectDownVC.selectRow = self.selectRow;
    }
    return _orderSelectDownVC;
}

////tab，有bottomview但不展示hastab为Yes no则展示
//- (CGRect)setViewFrame:(BOOL)hasNav WithTab:(BOOL)hastab
//{
//    self.mobileVC.view.frame = [self visibleBoundsShowNav:self.mobileVC.hasNav showTabBar:NO];
//
//    CGRect newframe = self.mobileVC.view.frame;//self.view.frame;
//    
//    if(hastab == YES)
//    {
//        return newframe;
//        
//    }
//    else
//    {
//        if(hasNav == NO)
//        {
//            //        origin=(x=0, y=0) size=(width=320, height=548)
//            newframe = CGRectMake(newframe.origin.x, newframe.origin.y, newframe.size.width, newframe.size.height-48);
//        }
//        else
//        {
//            //        origin=(x=0, y=0) size=(width=320, height=504)
//            CGRect  frame = CGRectMake(newframe.origin.x, newframe.origin.y, newframe.size.width, newframe.size.height-48);
//            
//            return frame;
//        }
//    }
//    
//    
//    return newframe;
//}

//tab，有bottomview但不展示hastab为Yes no则展示
- (CGRect)setViewFrame:(BOOL)hasNav WithTab:(BOOL)hastab
{
    CGRect newframe = self.view.frame;
    
    if(hastab == YES)
    {
        if(hasNav == NO)
        {
            //        origin=(x=0, y=0) size=(width=320, height=548)
            newframe = CGRectMake(newframe.origin.x, newframe.origin.y, newframe.size.width, newframe.size.height+48);
        }
        else
        {
            //        origin=(x=0, y=0) size=(width=320, height=504)
            CGRect  frame = CGRectMake(newframe.origin.x, newframe.origin.y, newframe.size.width, newframe.size.height+48);
            
            return frame;
        }

        return newframe;
        
    }
    else
    {
        if(hasNav == NO)
        {
            //        origin=(x=0, y=0) size=(width=320, height=548)
            newframe = CGRectMake(newframe.origin.x, newframe.origin.y, newframe.size.width, newframe.size.height-48);
        }
        else
        {
            //        origin=(x=0, y=0) size=(width=320, height=504)
            CGRect  frame = CGRectMake(newframe.origin.x, newframe.origin.y, newframe.size.width, newframe.size.height-48);
            
            return frame;
        }
    }
    
    
    return newframe;
}


@end
