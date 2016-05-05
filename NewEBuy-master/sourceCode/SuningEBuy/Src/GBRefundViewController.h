//
//  GBRefundViewController.h
//  SuningEBuy
//
//  Created by li xiaokai on 13-6-18.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "GBCancelOrderService.h"
#import "SSBtnService.h"
#import "GBOrderInfoDTO.h"
#import "AllOrderDetailCommonViewController.h"
#import "ToolBarButton.h"

@interface GBRefundViewController : AllOrderDetailCommonViewController<GBCancelOrderDelegate,ToolBarButtonDelegate,UIPickerViewDataSource,UIPickerViewDelegate>



@property (nonatomic,strong)ReFundInfoDto *refundDto;

@property (nonatomic,strong)GBOrderInfoDTO *orderDto;

@property (nonatomic,strong) GBCancelOrderService *cancelService;

@property (nonatomic,weak)SSBtnService *singleBtn;

@property (nonatomic) NSInteger price;

@property (nonatomic,strong) ToolBarButton *refundReasonsBarBtn;
@property (nonatomic,strong) UIPickerView *reasonsPickView;
@property (nonatomic,strong)NSArray *infoArr;
@property (nonatomic, strong)   UIButton      *arrowBtn;

-(void)insertErrorMsg:(NSString *)errorMsg;

@end
