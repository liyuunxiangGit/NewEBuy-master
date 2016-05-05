//
//  WaterElectricGasPaymentView.h
//  SuningEBuy
//
//  Created by 王家兴 on 13-6-13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadioButton.h"

#import "PayServiceDTO.h"
#import "ToolBarTextField.h"
#import "keyboardNumberPadReturnTextField.h"
#import "SNReaderViewController.h"
#import "WaterElectricityGasService.h"
#import "SNDropDownMenuViewController.h"

typedef enum{
    payWater = 0,
	payElectricity =1,
	payGas = 2
} PayServiceType;

@interface WaterElectricGasPaymentView : UIView<UITableViewDelegate, UITableViewDataSource,UIPickerViewDataSource, UIPickerViewDelegate, UIActionSheetDelegate, ToolBarTextFieldDelegate, SNReaderDelegate, WaterElectricityGasServiceDelegate,RadioButtonDelegate,SNDropDownMenuDelegate>
{
    UITableView                         *_groupTableView;

    PayServiceType                       _payType;
    
    ToolBarTextField                     *_payRegionTextField;
    
    ToolBarTextField                     *_payCompanyTextField;
    
    UITextField                          *_payAccountTextField;
    
    UIPickerView                         *_regionPickerView;
    
    UIPickerView                         *_companyPickerView;
    
    WaterElectricityGasService           *_waterElecGasService;
    
    NSMutableArray                       *_regionList;
    
    NSMutableArray                       *_companyList;
    
    PayServiceDTO                        *_payServiceDTO;
    
    BOOL                                 isManual;
    
    UILabel                              *_customerNameLabel;
    
    UILabel                              *_payBalanceLabel;
    
    NSString                             *_payAccountNum;//记录已经请求过的付款账户，
    
    BOOL                                 isFirst;//记录用户是否是首次查询，非首次查询打开页面时回一次执行几个接口
    
    BOOL                                 isGetAccountInfo;//记录是否获得过最终的账户信息，避免从下级页面返回时重复调用几个接口
    
    BOOL                                 isLoading;
        
    UIButton                             *_payWaterButton;
    UIButton                             *_payElectricButton;
    UIButton                             *_payGasButton;
    
    CommonViewController *__weak _contentController;
}
@property (nonatomic, weak) CommonViewController *contentController;

@property (nonatomic, strong) UITableView     *groupTableView;

@property (nonatomic, assign) PayServiceType  payType;

@property (nonatomic, strong) ToolBarTextField  *payRegionTextField;

@property (nonatomic, strong) ToolBarTextField  *payCompanyTextField;

@property (nonatomic, strong) UITextField   *payAccountTextField;

@property (nonatomic, strong) UIPickerView  *companyPickerView;

@property (nonatomic, strong) WaterElectricityGasService *waterElecGasService;

@property (nonatomic, strong) NSMutableDictionary *cityDic;

@property (nonatomic, strong) NSMutableArray  *regionList;

@property (nonatomic, strong) NSMutableArray  *companyList;

@property (nonatomic, strong) NSMutableArray  *accountList;

@property (nonatomic, strong) PayServiceDTO  *payServiceDTO;

@property (nonatomic, strong) NSMutableArray  *payServiceList;

@property (nonatomic, strong) NSArray  *payServiceInfoList;

@property (nonatomic, strong) UILabel  *customerNameLabel;

@property (nonatomic, strong) UILabel  *payBalanceLabel;

@property (nonatomic, strong) NSString *payAccountNum;

@property (nonatomic, strong) UIButton *settlementBtn;

@property (nonatomic, strong) UILabel *customerNameTextLabel;

@property (nonatomic, strong) UILabel *payBalanceTextLabel;

//- (id)initWithPayType:(PayServiceType)payServiceType;

@property (nonatomic, strong) UIButton *payWaterButton;
@property (nonatomic, strong) UIButton *payElectricButton;
@property (nonatomic, strong) UIButton *payGasButton;

@property (nonatomic, strong) UIButton *checkBox;

- (id)initWithContentController:(CommonViewController *)controller;

- (void)dataInit;

- (void)viewAppear;

@end
