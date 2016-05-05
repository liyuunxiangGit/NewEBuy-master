//
//  ProductCuView.h
//  SuningEBuy
//
//  Created by li xiaokai on 13-11-27.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataProductBasic.h"
#import "SelectItemCell.h"
#import "ProductPackageView.h"
#import "ProductNumberCell.h"

#import "OHAttributedLabel.h"
#import "NSAttributedString+Attributes.h"

#import "PanicPurchaseDTO.h"
#import "Calculagraph.h"
#import "DJGroupListItemDTO.h"
#import "DJGroupApplyDTO.h"
#import "DJGroupDetailDTO.h"

#import "ProductTimeView.h"
#import "BigSaleDTO.h"
#import "AppointmentDTO.h"

@protocol ProductCuViewDelegate <NSObject>


@optional

-(void)selectCu:(DataProductBasic *)productDto;

-(void)selectProduct:(DataProductBasic *)productDto;

-(void)addtoCar:(BOOL)isSelectColor;

-(void)buyNow;

-(void)removeProductCuview;

- (void)cuViewAddCarFinished:(id)sender;

- (void)goToShopCart;

@end

@interface ProductCuView : UIView<UITableViewDataSource,UITableViewDelegate,SelectItemDelegate,ProductNumberCellDelegate,PackageProductCellDelegate>
{
//    BOOL _isClickAddCar;
//    
//    NSInteger proNum;
    CALayer *transitionLayer;
}

//@property(nonatomic)BOOL isClickAddCar;

@property (nonatomic, assign)ProductDeatailType     type; 

@property(nonatomic,strong)UITableView *productTable;

@property(nonatomic,strong)UIImageView *backView;

@property(nonatomic,strong)DataProductBasic *productDto;

@property(nonatomic,strong)NSString *colorId;

@property(nonatomic,strong)NSString *versionId;

@property(nonatomic,strong)UIImageView *buttomView;

@property(nonatomic,strong)UIButton *buyNowBtn;

@property(nonatomic,strong)UIButton *addCarBtn;

@property(nonatomic,strong)UIButton *deleteBtn;

@property(nonatomic,strong)EGOImageView *productImg;

@property(nonatomic,strong)UILabel *nameLab;

@property(nonatomic,strong)UILabel *sellLab;

@property(nonatomic,strong)UILabel *priceLab;

@property(nonatomic,strong)UIImageView *applicationImageView;

@property(nonatomic,strong)UIView   *backGroundView;

@property(nonatomic,assign)keyboardNumberPadReturnTextField *numberTF;

@property (nonatomic, strong) OHAttributedLabel *tipLabel;
@property (nonatomic, strong) OHAttributedLabel *discountLabel;

//@property (nonatomic, strong) UILabel *titleLab;

@property(nonatomic,assign)id<ProductCuViewDelegate> mydelegate;

//xmy
@property (nonatomic, strong) UIButton             *CarBtn;

@property (nonatomic, strong) UIButton             *CarNumBtn;

@property (nonatomic, assign) NSInteger             addToCarType;

/*抢购信息 初始化抢购详情数据*/
@property (nonatomic, strong) PanicPurchaseDTO *panicDTO;

///*计时器*/
@property (nonatomic, strong) Calculagraph    *calculagraph;

@property(nonatomic,strong)NSString *stateStr;

@property(nonatomic,strong)NSString *timeStr;

@property (nonatomic) BOOL isLoadPurchase;

//团购商品

@property (nonatomic, strong) DJGroupDetailDTO *detailDto;

@property (nonatomic, strong) DJGroupListItemDTO *baseItemDto;

///*计时器*/
@property (nonatomic, strong) Calculagraph    *groupBuyCalculagraph;

#pragma mark ------------ 大聚惠 ------------
@property (nonatomic, strong) BigSaleDTO    *bigsaleDto;

#pragma mark -
#pragma mark ------------ 预约 ------------
@property (nonatomic, strong) AppointmentDTO    *appointmentDto;
@property (nonatomic, strong) Calculagraph   *appointmentCalculagraph;

//抢团购底部时间
@property (nonatomic, strong) ProductTimeView   *timView;
@property (nonatomic, strong) Calculagraph   *bigSaleCalculagraph;

#pragma mark ------------ S码商品 ------------
@property (nonatomic) BOOL isScProduct;     //是否是s码商品
@property (nonatomic, strong) Calculagraph   *scScodeCalculagraph;

-(void)hideCuView;
-(void)showCuView;

-(void)refreshView:(DataProductBasic *)dto;

-(void)btnEnable:(BOOL)enabled;

-(void)scrollTotop;

- (void)displayOverFlowActivityView;
- (void)removeOverFlowActivityView;

- (void)displayAnimation:(CGImageRef)image;
@end
