//
//  ProductDetailViewController.h
//  SuningEBuy
//
//  Created by xmy on 18/12/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "DataProductBasic.h"
#import "ProductDetailService.h"
#import "LoginViewController.h"
#import "DetailCollectService.h"
#import "MyFavoriteService.h"

#import "NDetailFirstCell.h"
#import "NProDetailFirstCell.h"
#import "NDetailSecondCell.h"
#import "NProDetailThirdCell.h"
#import "NQiangGouThridCell.h"
#import "NProDetailFourthCell.h"
#import "NProDetailFiveCell.h"
#import "NProDetailLastViewController.h"
#import "NProDetailSixCell.h"
#import "NProDetailShopExitCell.h"
#import "NProDetailRecommendCell.h"
#import "NProDetailServerCell.h"
#import "NProDetailSpotSupportCell.h"

#import "ProductCuView.h"

#import "OSGetStatusCommand.h"
#import "NProDtailAppraiseViewController.h"
#import "ChooseShareWayView.h"
#import "SNShareKit.h"

#import "PanicPurchaseDTO.h"
#import "PurchaseService.h"
#import "Calculagraph.h"

#import "DJGroupListItemDTO.h"
#import "DJGroupDetailDTO.h"
#import "DJGroupDetailService.h"
#import "DJGroupApplyService.h"

#import "ConsultationViewController.h"
#import "ConsultationService.h"

#import "BigSaleDTO.h"
#import "AppointmentDTO.h"

#import "ProductTimeView.h"
#import "ProductNumberCell.h"

#define kNStartCurveX         65
#define kNStartCurveY         63
#define kNEndCurveY           [UIScreen mainScreen].bounds.size.height

//从各个列表页进入商品详情页
typedef enum{
    FromGroupProduct        = 1,                //从团购列表页
    FromPanicProduct        = 2,                //从抢购列表页
    EightBannerProduct      = 3,                //从八连版
    BookThreeBannerProduct  = 4,                //从图书三联版
    RecommendListProduct    = 5,                //从推荐商品
    FromBigSaleProduct      = 6,                //从大聚惠列表页
    FromAppointmentProduct  = 7,                //从预约列表页
}ProductType;


@interface ProductDetailViewController : CommonViewController<ProductDetailServiceDelegate,DetailCollectServiceDelegate,MyFavoriteServiceDelegate,NProDetailFirstCellDelegate,NDetailSecondCellDelegate,NProDetailSixCellDelegate,NProDtailAppraiseViewControllerDelagete,ChooseShareWayDelegate,ChooseShareWayViewDelegate,NDetailHeadProImagesdelegate,OSChatServiceDelegate,ProductCuViewDelegate,NDetailFirstCellDelegate,NProDetailRecoCellDelegate,PurchaseServiceDelegate,DJGroupDetailServiceDelegate,DJGroupApplyServiceDelegate,ConsultationDelegate,ConsultationViewDelegate,ConsulDelegate,ProductNumberCellDelegate>
{
    BOOL _isFold;
    
    SEL      loginSel;
    
    OSShowStatus         chatServiceStatus;
    
    CALayer *transitionLayer;
    
    //    BOOL _isLoadDetail;//是否加载过
    
    BOOL _isProductCuView;//是否是ProductCuView的加入购物车按钮
    
    BOOL _isProductCuViewShow; //商品簇是否展开过
    
    BOOL noCalculagraphAtFirst;   //没有带计时器进入
}

@property (nonatomic)BOOL isLoadDetail;//是否加载过


/*团购，抢购区分*/
@property (nonatomic ,assign) ProductType productType;

@property (nonatomic ,assign) ProductDeatailType     type;

@property (nonatomic, strong) NProDetailFirstCell        *firstView;//商品图片view
//@property (nonatomic, strong) UIScrollView               *firstScrollView;//
@property (nonatomic, strong) EGOImageButton  *  imageViewBtn;
@property (nonatomic, strong) UIImageView               *buttomView;//按钮view

@property (nonatomic, strong) UIButton             *buyNowBtn;

@property (nonatomic, strong) UIButton             *addCarBtn;

@property (nonatomic, strong) UIButton             *CarBtn;

@property (nonatomic, strong) UIButton             *CarNumBtn;

@property (nonatomic,strong)ProductCuView        *cuView;//选择颜色、尺寸、数量view
@property (nonatomic, assign) BOOL isShowingCuView;//是否显示选择颜色、尺码、数量页面

@property (nonatomic)CGSize cuTableSize;

@property (nonatomic, strong) NSString       *collectFlag;

@property (nonatomic,retain)DataProductBasic    *productBase;

@property (nonatomic, strong) ProductDetailService *proDetailService;//详情

@property (nonatomic, strong) MyFavoriteService    *myFavorateService;

@property (nonatomic, retain) NSString     *appariseNumStr;//评价数量

//@property (nonatomic, retain) NSString     *goodRate;//好评率

@property (nonatomic, strong) NSString      *zixunCountStr;//咨询总数

@property (nonatomic, strong) DetailCollectService  *collectService;//收藏标识

@property (nonatomic,strong ) ConsultationService   *consulationservice;
@property (nonatomic, strong) NProDetailSixCell *headBtnsCell;//基本信息、商品介绍、评价选择按钮cell

@property (nonatomic, strong) NProDetailLastViewController  *lastTabView;//基本信息、商品介绍、评价展示view

@property (nonatomic, strong) NProDtailAppraiseViewController *appraisalVC;//评价展示view

@property (nonatomic, strong) ConsultationViewController *consultation;//咨询展示view

@property (nonatomic, strong) SNShareKit *shareKit;           //分享控制器

@property (nonatomic, strong) NSString  *colorOrVerStr;         //当前所选的颜色款式

//kongbin
@property (nonatomic, strong) ChooseShareWayView    *chooseShareWayView; //分享方式


#pragma mark -
#pragma mark ------------ 抢购 ------------

@property (nonatomic, strong) PurchaseService *panicService;

/*抢购信息 初始化抢购详情数据*/
@property (nonatomic, strong) PanicPurchaseDTO *panicDTO;

/*抢购即时详细信息 */
@property (nonatomic, strong) PanicPurchaseDTO *panicDetailDto;

//抢购渠道，默认为开关接口设置，但是也可以手动设置
@property (nonatomic, assign) PanicChannel       panicChannel;

///*计时器*/
@property (nonatomic, strong) Calculagraph    *calculagraph;

@property (nonatomic) BOOL isLoadPurchase;
@property (nonatomic) BOOL isLoadGroup;
@property (nonatomic) BOOL isLoadBigSale;
@property (nonatomic) BOOL isLoadAppointment;
@property (nonatomic) BOOL isAllLoaded;

@property (nonatomic) BOOL isScProduct;

@property(nonatomic,strong)NSString *stateStr;

@property(nonatomic,strong)NSString *timeStr;


#pragma mark -
#pragma mark ------------ 团购 ------------
//团购商品
@property (nonatomic, strong) DJGroupApplyService  *groupApplyService;

@property (nonatomic, strong) DJGroupDetailService *groupDeatilService;

@property (nonatomic, strong) DJGroupDetailDTO *detailDto;

@property (nonatomic, strong) DJGroupListItemDTO *baseItemDto;

@property (nonatomic, copy) NSString *actId;

@property (nonatomic, copy) NSString *channelId;

#pragma mark -
#pragma mark ------------ 大聚惠 ------------
@property (nonatomic, strong) BigSaleDTO    *bigsaleDto;

#pragma mark -
#pragma mark ------------ 预约 ------------
@property (nonatomic, strong) AppointmentDTO    *appointmentDto;

//抢团购底部时间
@property (nonatomic, strong) ProductTimeView   *timView;

//商品是否可买
- (BOOL)isProductEnabled;

- (id)initWithDataBasicDTO:(DataProductBasic *)infoDto;

- (void)reloadTableViewData;


- (void)refreshData;

//刷新底部按钮
-(void)refreshBtn;
//熟悉商品图片展示区域
- (void)refreshFirstProImagesView;

//- (void)beginEasilyBuy;

-(void)addToCar;

//- (void)addtoShoppingCart2;

- (BOOL)checkLogin;

@end
