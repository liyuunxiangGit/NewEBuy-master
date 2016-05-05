//
//  MobilePayByYiFuBaoViewController.h
//  SuningEBuy
//
//  Created by david david on 12-8-9.
//  Copyright (c) 2012年 sn. All rights reserved.
//
#define NormalChacracter @"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
#import "CommonViewController.h"
#import "payMobileOrderDTO.h"
#import "EfubaoAccountService.h"
#import "MobilePayService.h"
#import "EppValidateCodeService.h"

@interface MobilePayByYiFuBaoViewController : CommonViewController<UITextFieldDelegate,EfubaoAccountServiceDelegate,MobilePayServiceDelegate,EppValidateCodeServiceDelegate>
{
@private
    
}

@property(nonatomic,strong)    payMobileOrderDTO *paySource;

@property (nonatomic, strong) EppValidateCodeService *eppValidateService;

@end
