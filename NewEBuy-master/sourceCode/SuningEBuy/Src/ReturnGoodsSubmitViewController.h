//
//  ReturnGoodsSubmitViewController.h
//  SuningEBuy
//
//  Created by 漫 王 on 12-10-8.
//  Copyright (c) 2012年 Suning. All rights reserved.
//
#import "ReturnGoodsPrepareDTO.h"

#import "ReturnGoodsListDTO.h"

#import "ReturnGoodsApplicationService.h"

#import "ToolBarButton.h"
#import "UITableViewCell+BgView.h"
#import "AllOrderDetailCommonViewController.h"
#import "ReturnGoodSDetailCell.h"
#import "NOrderContactCell.h"
#import <SSA_IOS/SSAIOSSNDataCollection.h>
#import "OSLeaveMessageViewController.h"
#import "NoReasonReturnDTO.h"
//typedef enum {
//    noAppraisal,                        //没有鉴定方，不用鉴定
//    myCompany,                          //我司售后人员鉴定
//    factory,                            //供应商鉴定
//    store                               //店面3c服务中心鉴定
//} ReturnGoodsAppraisal;

@interface ReturnGoodsSubmitViewController : AllOrderDetailCommonViewController<ReturnGoodsApplicationServiceDelegate,UITextViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,ToolBarButtonDelegate,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSArray                    *_reasonList; //退货原因列表
    
    ReturnGoodsListDTO         *_returnGoodsListDto;//商品基本信息
    
    ReturnGoodsPrepareDTO      *_prepareDto;//商品申请退货准备信息
    
    BOOL                       isLoaded; //是否已加载
    
    BOOL                    _isGetOnlineStatusOk;
    int                     _onlineStatus;
    UIWebView               *_callWebView;
    
}

//------传值-------
@property (nonatomic ,strong)NSArray                    *reasonList;
@property (nonatomic ,strong)ReturnGoodsListDTO         *returnGoodsListDto;
@property (nonatomic, strong)NSString *proPrice;
@property (nonatomic, strong)NSString *productCode;
@property (nonatomic, strong)NSArray  *headList;
@property (nonatomic, assign)BOOL                    isCShopProduct;//传值
@property (nonatomic ,strong)NSString *reasonId;//退货原因id
//@property (nonatomic, strong) NSString *supplierCode;
//@property (nonatomic, strong) NSString *supplierName;
//------end-------

@property (nonatomic, strong)   UIButton      *pointView;

@property (nonatomic ,strong)ReturnGoodsPrepareDTO      *prepareDto;

@property (nonatomic, strong) NSString *returnType;//0:不能无理由退货 1:自提无理由退货 2:定向配送无理由退货
@property (nonatomic, strong) NSString    *taxType;//发票类型
@property (nonatomic, strong) NSString    *shopAddress;//自提门店地址
@property (nonatomic, strong) UITextField          *addressTextField;//详细地址
@property (nonatomic, strong) NSString    *distribution;//配送方式
@property (nonatomic ,strong)NSString *reasonDes;//退货原因


@end
