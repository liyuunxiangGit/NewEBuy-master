//
//  ReceiveInfoShopRemarkCell.h
//  SuningEBuy
//
//  Created by 孔斌 on 14-5-26.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "SNUITableViewCell.h"

@protocol ReceiveInfoShopRemarkCellDelegate;

@interface ReceiveInfoShopRemarkCell : SNUITableViewCell<UITextFieldDelegate>

@property (nonatomic, weak)    id<ReceiveInfoShopRemarkCellDelegate>delegate;
@property (nonatomic, strong) NSString      *supplierCodeStr;   //供应商编码
@property (nonatomic, strong) UITextField   *remarkTextFld;     //商家留言

- (void)setRemarkTextWithShopCode:(NSString *)supplierCode;
@end

@protocol ReceiveInfoShopRemarkCellDelegate <NSObject>

- (void)getRemarkWithText:(NSString *)remarkText supplierCode:(NSString *)supplierCode;
- (void)showLimitAlertView;

@end
