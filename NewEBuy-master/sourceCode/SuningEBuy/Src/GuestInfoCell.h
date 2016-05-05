//
//  GuestInfoCell.h
//  SuningEBuy
//
//  Created by jian  zhang on 12-7-2.
//  Copyright (c) 2012年 nanjing. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ToolBarTextField.h"
@protocol GuestInfoCellDelegate;

@interface GuestInfoCell: SNUITableViewCell<UITextFieldDelegate,ToolBarTextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{

}

@property (nonatomic, strong)  NSArray       *dateList;

@property (nonatomic, strong)  UILabel       *username;
@property (nonatomic, strong)  UITextField   *usernameTextField;


@property (nonatomic, strong)  UILabel       *arriveTime;
@property (nonatomic, strong)  ToolBarTextField   *arriveTimeTextField;
@property (nonatomic, strong)  UIPickerView  *arriveTimePicker;
@property (nonatomic, strong)  UIButton      *arrowBtn;

@property (nonatomic, copy)    NSString     *checkInTime;
@property (nonatomic, strong)  UILabel       *leaveTime;
@property (nonatomic, strong)  ToolBarTextField   *leaveTimeTextField;
//@property (nonatomic, retain)  UIDatePicker  *leaveTimePicker;
@property (nonatomic, strong)  id<GuestInfoCellDelegate> delegate;

/*******************************type=begin id=1*******************************
 * author:zhaofk
 * date:2012-9-3
 * description:添加最早到达时间、最晚到达时间缓存
 */
@property (nonatomic,strong) NSString  *earliestArriveTime;
@property (nonatomic,strong) NSString  *lastestArriveTime;


/*******************************type=begin id=1********************************/

- (void) initDataSourceWithRoomNum:(NSString *)roomNum isChangeRoomNum:(BOOL)isChangeRoomNum checkInTime:(NSString *)checkInTime earliestArriveTime:(NSString *)time1 lastestArriveTime:(NSString *)time2 guestInfo:(NSDictionary *)guestInfo;

- (int)convertDateToString:(NSString *)string;


@end


@protocol GuestInfoCellDelegate <NSObject>

@optional
- (void)setGuestName:(NSString *)username withTag:(int)tag;
- (void)setArriveTime:(NSString *)arriveTime leaveTime:(NSString *)leaveTime;

@end
