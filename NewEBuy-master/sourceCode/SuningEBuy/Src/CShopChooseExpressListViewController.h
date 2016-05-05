//
//  CShopChooseExpressListViewController.h
//  SuningEBuy
//
//  Created by 荀晓冬 on 13-12-22.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "UITableViewCell+BgView.h"
#import "ReturnGoodsQueryDTO.h"
#import "ToolBarButton.h"
#import "ReturnGoodsQueryService.h"
#import "CShopReturnGoodsDTO.h"
#import "PlaceholderTextView.h"
#import "CommonTextField.h"
#import "AllOrderDetailCommonViewController.h"
#import "SNReaderViewController.h"

@interface CShopChooseExpressListViewController : AllOrderDetailCommonViewController<ToolBarButtonDelegate,UIPickerViewDelegate,UIPickerViewDataSource,ReturnGoodsQueryServiceDelegate,UITextViewDelegate,UITextFieldDelegate,SNReaderDelegate>
{
     NSArray                    *_expressList; //退货原因列表
}

@property (nonatomic, strong)   ReturnGoodsQueryDTO      *prepareDto;
@property (nonatomic, strong)   NSString *expressId;
@property (nonatomic, strong)   NSString *expressName;
@property (nonatomic, strong)   ToolBarButton *toolBarBtton;
@property (nonatomic, strong)   UIPickerView *expressPickView;
@property (nonatomic, strong)   NSArray *expressList;
@property (nonatomic, strong)   ReturnGoodsQueryService *service;
@property (nonatomic, strong)   CShopReturnGoodsDTO *expressDto;
@property (nonatomic, strong)   ReturnGoodsQueryDTO *queryDto;
@property (nonatomic, strong)   UIButton      *pointView;
@property (nonatomic, strong)   CommonTextField *expressNameTextView;
//@property (nonatomic, strong) SNReaderController *readerController;

@property (nonatomic, strong)   UITextField *expressNumberTextView;
@property (nonatomic, strong)   NSString *expressNameSelect;
@property (nonatomic, strong)   UIButton *applyBtn;

@end
