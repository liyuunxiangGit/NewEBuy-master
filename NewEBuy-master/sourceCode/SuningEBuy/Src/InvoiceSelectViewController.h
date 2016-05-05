//
//  InvoiceSelectViewController.h
//  SuningEBuy
//
//  Created by 孔斌 on 14-4-29.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "InvoiceSelectCell.h"

@class ReceiveInfoViewController;

@interface InvoiceSelectViewController : CommonViewController<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *invoiceTextFld;
@property (nonatomic, strong) ReceiveInfoViewController *obj;

@property (nonatomic, assign) BOOL      isEleInvoice;
@property (nonatomic, assign) BOOL      canUseEleInvoice;   //是否支持电子发票

- (id)initWith:(ReceiveInfoViewController *)object withType:(NSInteger)type;

@end
