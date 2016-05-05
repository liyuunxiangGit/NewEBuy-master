//
//  OrderSubmitRootViewController.h
//  SuningEBuy
//
//  Created by xy ma on 12-5-11.
//  Modified by shasha on 12-10-9
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
#import "hangBanItemCell.h"
#import "FlightListDetailDTO.h"
#import "dengJiRenItemCell.h"
#import "yuDingRenItemCell.h"
#import "xingChengDanItemCell.h"
#import "baoXianItemCell.h"
#import "OrderSubmitHeadCell.h"
#import "BoardingPersionListViewController.h"
#import "flightPayOrderViewController.h"
#import "ExchangeTicketViewController.h"
#import "SNPopoverController.h"
#import "AddressChangeDelegate.h"
#import "TPKeyboardAvoidingTableView.h"
#import "SNPopoverController.h"
#import "BoardingService.h"
#import "FlightOrderService.h"
#import "InsuranceService.h"
#import "PlanTicketService.h"
#import "BackBarView.h"

@interface OrderSubmitRootViewController : CommonViewController
<UITextFieldDelegate,UIActionSheetDelegate,dengJiRenItemCellDelegate,
BoardingPersionListViewControllerDelegate,yuDingCellDelegate,
hangBanItemCellDelegate, AddressChangeDelegate,BoardingDelegate,
FlightOrderDelegate, InsuranceServiceDelegate,PlanTicketOrderDelegate>
{
    NSMutableArray *_personList;
    NSMutableArray *_allPersonList;

    int customerCount;
    CGFloat xingchengHeight;

    BOOL isInsurancesLoaded;
    
}

@property (nonatomic, strong) NSMutableArray *flightDetailDtoList;
@property (nonatomic, strong) NSMutableArray          *personList;//用户选择的登机人list
@property (nonatomic, strong) NSMutableArray          *allPersonList;//所有的登机人list

@property (nonatomic, strong) NSString *addressType;//行程单是否配送
@property (nonatomic, strong) AddressInfoDTO *selectAddrDto;
@property (nonatomic, strong) FlightInfoDTO *flightInfoDto;

@property (nonatomic, strong) NSString *contactMobile;//预订人手机
@property (nonatomic, strong) NSString *contactName;//预订人姓名

@property (nonatomic, strong) NSString *priceAmount;//订单总金额
@property (nonatomic, strong) NSString *dengjiData;//登机时间，

@property (nonatomic, strong) SNPopoverController *snPopoverController;

@property (nonatomic, strong) NSArray *insuranceList;   //险种列表
@property (nonatomic, strong) InsuranceDTO *selectedInsurance;  //选择的保险

- (void)chooseJumpPage;
- (void)updateTable;


- (NSInteger)ticketCount; //返回票数

- (void)calculateTotalAmount;   //计算总金额
@end