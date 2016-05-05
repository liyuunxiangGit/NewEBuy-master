//
//  InvoiceSelectTemporaryViewController.h
//  SuningEBuy
//
//  Created by 孔斌 on 14-11-14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "InvoiceSelectCell.h"

@class ReceiveInfoViewController;

@interface InvoiceSelectTemporaryViewController : CommonViewController<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *invoiceTextFld;
@property (nonatomic, strong) ReceiveInfoViewController *obj;

@property (nonatomic, assign) BOOL      canUseEleInvoice;   //是否支持电子发票
@property (nonatomic, assign) BOOL      isDefaultEleInvoice;//是否默认展示电子发票，不是则展示不开发票

- (id)initWith:(ReceiveInfoViewController *)object withType:(NSInteger)type;
@end
