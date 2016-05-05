//
//  HotelOrderSubmitViewController.h
//  SuningEBuy
//
//  Created by jian  zhang on 12-7-2.
//  Copyright (c) 2012年 nanjing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToolBarTextField.h"
#import "OrderRoomNumCell.h"
#import "LinkManInfoCell.h"
#import "GuestInfoCell.h"

#import "HotelOrderBaseViewController.h"
#import "HotelOrderSubmitHttpRequest.h"
#import "HotelDataSourceDTO.h"
#import "HotelOrderService.h"
#import "HotelOrderDTO.h"

@interface HotelOrderSubmitViewController : HotelOrderBaseViewController<OrderRoomNumDelegate,GuestInfoCellDelegate,LinkManInfoCellDelegete,EGOImageViewDelegate,EGOImageViewExDelegate,HotelOrderSubmitHttpRequestDelegate,HotelOrderDelegate>
{
    BOOL isSelectOrNot;
    BOOL isChangeRoomNum;
}

@property (nonatomic, strong) UIView  *bottomView;
@property (nonatomic, strong) UIButton *backBtn;

@property (nonatomic, copy)  NSString   *selectRoomNum;
@property (nonatomic, copy)  NSString   *linkManName;
@property (nonatomic, copy)  NSString   *linkManPhoneNum;
@property (nonatomic, copy)  NSString   *arriveTime;
@property (nonatomic, copy)  NSString   *leaveTime;
@property (nonatomic, copy)  NSMutableDictionary *userNameDic;

@property (nonatomic, strong) HotelDataSourceDTO *datasource;
@property (nonatomic, strong)  UIView     *headerView;
@property (nonatomic, strong)  UIView     *footerView;
@property (nonatomic, strong)  HotelOrderSubmitHttpRequest   *hotelOrderSubmitHttpRequest;

@property (nonatomic, strong) HotelOrderService *orderService;
@property (nonatomic, strong) HotelOrderDTO *orderDto;

//校验中文
- (BOOL) validateChinese: (NSString *) userName;
//校验手机号码
- (BOOL) validateMobileNo: (NSString *) mobileNo;


- (int)convertDateToString:(NSString *)string;

//提交预订时  让键盘消失
- (void)resignKeyBoardInView:(UIView *)view;


@end
