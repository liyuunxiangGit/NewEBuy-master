//
//  OrderRoomNumCell.h
//  SuningEBuy
//
//  Created by jian  zhang on 12-7-2.
//  Copyright (c) 2012年 nanjing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToolBarTextField.h"

@protocol OrderRoomNumDelegate;

@interface OrderRoomNumCell : UITableViewCell<UIPickerViewDelegate,UIPickerViewDataSource,ToolBarTextFieldDelegate>
{
    
}
@property (nonatomic, strong)     UILabel                *hotelNameLabel;
@property (nonatomic, strong)     UILabel                *hotelTypeLabel;

@property (nonatomic, strong)     UILabel                *orderRoomLabel;
@property (nonatomic, strong)     UIPickerView           *orderRoomPickerView;
@property (nonatomic, strong)     NSArray                *orderRoomData;
@property (nonatomic, strong)     ToolBarTextField       *orderRoomTextField;
@property (nonatomic, strong)     UIButton               *arrowBtn;

@property (nonatomic, strong)     UILabel                *startTime;
@property (nonatomic, strong)     UITextField            *startTimeTextField;

@property (nonatomic, strong)     UILabel                *endTime;
@property (nonatomic, strong)     UITextField            *endTimeTextField;

@property (nonatomic, strong)     UIImageView            *timeBackground;

@property (nonatomic, weak)    id<OrderRoomNumDelegate>  delegate;

@property (nonatomic, assign)     BOOL hasAddLine;
- (void)initDatasource:(NSArray *)array;

@end


@protocol OrderRoomNumDelegate <NSObject>

@optional
- (void)selectOrderRoomNum:(NSString *)roomNum;

@end
