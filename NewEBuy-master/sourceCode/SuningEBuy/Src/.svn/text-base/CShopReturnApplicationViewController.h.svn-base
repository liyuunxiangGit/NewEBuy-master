//
//  CShopReturnApplicationViewController.h
//  SuningEBuy
//
//  Created by 荀晓冬 on 13-12-13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "CShopApplicationCell.h"
#import "CShopApplicationSecondCell.h"
#import "CShopReturnApplicationService.h"
#import "ToolBarButton.h"
#import "PlaceholderTextView.h"
#import "AllOrderDetailCommonViewController.h"
#import "GCPlaceholderTextView.h"

@interface CShopReturnApplicationViewController : AllOrderDetailCommonViewController<CShopReturnGoodsApplicationServiceDelegate,ToolBarButtonDelegate,UITextViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate>
{
    ReturnGoodsPrepareDTO      *_prepareDto;//商品申请退货准备信息
    NSArray                    *_reasonList; //退货原因列表
    
    BOOL                        _getOSStatusOk;
    int                         _onlineStatus;  //客服在线状态
    BOOL isClickingRight;//退货须知
}
@property (nonatomic, strong)   ReturnGoodsPrepareDTO      *prepareDto;
@property (nonatomic, strong)   NSArray                    *reasonList;
@property (nonatomic, strong)   ReturnGoodsListDTO         *returnGoodsListDto;
@property (nonatomic, strong)   CShopReturnApplicationService *service;
@property (nonatomic, copy )    NSString    *checkupDate;
@property (nonatomic, strong)   NSString *reasonName;
@property (nonatomic, strong)   NSString *reasonDes;
@property (nonatomic, strong)   NSString *reasonId;
@property (nonatomic, strong)   ToolBarButton *toolBarBtton;
@property (nonatomic, strong)   UIPickerView *datePickerView;
@property (nonatomic, strong)   UIPickerView *reasonPickView;
@property (nonatomic, strong)   UIButton        *resonsTextField;  //退货原因text
@property (nonatomic, strong)   UILabel  *zhuLable;//注
@property (nonatomic, strong)   UIButton *submitReturnGoodsApplication;//提交退货申请
@property (nonatomic, strong)   UIView *fisrtView;
@property (nonatomic, strong)   UIView *secondView;
//退货须知
@property (nonatomic, strong) UIView *blackView;
@property (nonatomic, strong) UIView *tipBackView;
@property (nonatomic, strong) UIView *tipTitleView;
@property (nonatomic, strong) UIView *tipContentView;
@property (nonatomic, strong) UILabel *tipTitelLbl;
@property (nonatomic, strong) UIButton *tipCloseBtn;
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) UITextView *tipContentTextView;
//@property (nonatomic, strong)  PlaceholderTextView     *returnGoodsContents;             ;        //退货说明text

@property (nonatomic, strong)  PlaceholderTextView     *returnGoodsContents; //退货说明text

@property (nonatomic, strong)   UIButton      *pointView;
@property (nonatomic, strong)NSString *proPrice;
@property (nonatomic, strong)NSString *productCode;
@property (nonatomic, strong)NSString *payWay;


@end
