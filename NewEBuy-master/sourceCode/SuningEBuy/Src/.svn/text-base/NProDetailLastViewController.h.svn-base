//
//  NProDetailLastViewController.h
//  SuningEBuy
//
//  Created by xmy on 19/12/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CommonViewController.h"

#import "NProDetailBaseInfoView.h"
#import "NProDetailIntroduceView.h"
#import "NProDetailSixCell.h"
#import "LoginViewController.h"
#import "PanicPurchaseDTO.h"
#import "PurchaseService.h"
#import "Calculagraph.h"
#import "DJGroupListItemDTO.h"
#import "DJGroupApplyDTO.h"
#import "DJGroupDetailDTO.h"
#import "DJGroupApplyService.h"
#import "ProductParamService.h"
#import "ProductTimeView.h"
#import "BigSaleDTO.h"
#import "AppointmentDTO.h"

@interface NProDetailLastViewController : CommonViewController<UIWebViewDelegate,UIScrollViewDelegate,NProDetailSixCellDelegate,PurchaseServiceDelegate,DJGroupApplyServiceDelegate,UIGestureRecognizerDelegate,ProductParamServiceDelegate>
{
    BOOL  _isFoldParam;//商品参数
    BOOL  _isFoldPackList;//装箱清单
    BOOL  _isFold;//售后服务
    BOOL  _isFoldIntroduce;//是否已点击查看电脑完整版按钮
    
    SEL      loginSel;
}
@property(nonatomic, retain)UIView *leftParamView;
@property(nonatomic, retain)UIView *midWebView;
@property(nonatomic, retain)UIView *rightPingJiaView;
@property(nonatomic, retain)UIView *consultationView;


@property(nonatomic, retain)UIScrollView *backScrollView;//添加tab切换效果 chupeng 2013-11-28

@property (nonatomic,retain)DataProductBasic *productInfoDto;

@property (nonatomic, strong)NProDetailBaseInfoView *baseInfoView;

@property (nonatomic, strong)NProDetailIntroduceView *introduceView;

@property (nonatomic,retain)UIButton *introduceBtn;

@property (nonatomic, strong) NProDetailSixCell *headBtnsCell;//基本信息、商品介绍、评价选择按钮cell

@property (nonatomic, assign) NSInteger     selectTye;  //参数类型 （商品详情，基本信息，评价）

@property (nonatomic, strong) NSString      *appariseNumStr;//评价总数

@property (nonatomic, strong) UISwipeGestureRecognizer  *swipeRight;
//@property (nonatomic, strong) UIView                    *swipeView;     //当滑动到图文详情时视图左侧五分之一处加个右滑手势

@property (nonatomic, strong) ProductParamService  *paramService;

//普通商品
@property (nonatomic, assign) ProductDeatailType     type;  //1，详情 2，抢购 3，团购

@property(nonatomic,strong)UIButton         *buyNowBtn;

@property(nonatomic,strong)UIButton         *addCarBtn;

@property (nonatomic, strong) UIButton      *CarBtn;

@property (nonatomic, strong) UIButton      *CarNumBtn;

//抢购商品
@property (nonatomic, strong) PurchaseService *panicService;

/*抢购信息 初始化抢购详情数据*/
@property (nonatomic, strong) PanicPurchaseDTO *panicDTO;

///*计时器*/
@property (nonatomic, strong) Calculagraph    *calculagraph;

@property(nonatomic,strong)NSString *stateStr;

@property(nonatomic,strong)NSString *timeStr;

//抢购渠道，默认为开关接口设置，但是也可以手动设置
@property (nonatomic, assign) PanicChannel       panicChannel;
@property (nonatomic) BOOL isLoadPurchase;

//团购商品
@property (nonatomic, strong) DJGroupApplyService  *groupApplyService;
//@property (nonatomic, strong) DJGroupDetailService *service;

@property (nonatomic, strong) DJGroupDetailDTO *detailDto;

@property (nonatomic, strong) DJGroupListItemDTO *baseItemDto;

///*计时器*/
@property (nonatomic, strong) Calculagraph    *groupBuyCalculagraph;

#pragma mark ------------ 大聚惠 ------------
@property (nonatomic, strong) BigSaleDTO    *bigsaleDto;
@property (nonatomic, strong) Calculagraph   *bigSaleCalculagraph;


#pragma mark -
#pragma mark ------------ 预约 ------------
@property (nonatomic, strong) AppointmentDTO    *appointmentDto;
@property (nonatomic, strong) Calculagraph   *appointmentCalculagraph;

//抢团购底部时间
@property (nonatomic, strong) ProductTimeView   *timView;

-(void)showBaseView;
-(void)showIntroduceView;
-(void)showAppraiseView;

//用于隐藏scrollView的头，仅展示页面，并且取消scrollView页面间的滑动手势
-(void)hideScrollViewHead;

//更改view的title
-(void)changeTitle:(NSString *)title;

//+ (CGFloat)setLastCellHeight:(DataProductBasic*)dto WithTabViewH:(CGFloat)cellHeight;


@end
