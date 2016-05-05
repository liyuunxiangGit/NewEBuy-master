//
//  ConfirmReceiptWebViewController.h
//  SuningEBuy
//
//  Created by YANG on 14-5-5.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "SNWebViewController.h"
#import "ConfirmAcceptService.h"

@interface ConfirmReceiptWebViewController : SNWebViewController<ConfirmAcceptServiceDelegate>
{
    NSString             *_activeName;

}
@property (nonatomic, copy) NSString *activeName;

@property (nonatomic, copy) NSString *orderID;
@property (nonatomic, copy) NSString *orderItemId;
@property (nonatomic, copy) NSString *supplierCode;

@property (nonatomic, strong) ConfirmAcceptService *confirmService;


@end
