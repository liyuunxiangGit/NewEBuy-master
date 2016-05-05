//
//  AddressEditViewController.h
//  SuningEBuy
//
//  Created by xy ma on 12-8-27.
//  Copyright (c) 2012年 Suning. All rights reserved.
//
//  Modifyed by liukun

#import "AddressNewViewController.h"

@interface AddressEditViewController : AddressNewViewController
{
    AddressInfoDTO      *_baseAddressInfoDTO;  //传入的地址，不可改
}

@property (nonatomic, strong) AddressInfoDTO    *baseAddressInfoDTO;

@property (nonatomic, strong) UIButton          *deleteBtn;

@property (nonatomic, strong) UIView            *footView;

- (id)initWithBaseAddress:(AddressInfoDTO *)baseAddress;


//设置状态为可编辑状态
- (void)setStatusEdit;

@end
