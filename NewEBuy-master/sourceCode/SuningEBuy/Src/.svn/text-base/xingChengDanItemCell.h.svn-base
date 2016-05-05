//
//  xingChengDanItemCell.h
//  SuningEBuy
//
//  Created by xy ma on 12-5-11.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UITableViewCellEx.h"
#import "AddressInfoDTO.h"
#import "AddressInfoListViewController.h"
#import "ToolBarButton.h"

@class OrderSubmitRootViewController;
@interface xingChengDanItemCell : UITableViewCellEx
<ToolBarButtonDelegate,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
    UIPickerView                        *_choosePickerView;
    int amountValue;

}

@property(nonatomic,strong) UILabel    *xingchengdanLbl;
@property(nonatomic,strong) UIView     *whiteBackView;
@property(nonatomic,strong) UILabel    *peiSongInfoLbl;
@property(nonatomic,strong) UILabel    *nameLbl;
@property(nonatomic,strong) UILabel    *addressLbl;
@property(nonatomic,strong) UILabel    *phoneLbl;

@property(nonatomic,strong) UIButton   *changeAddressBtn;
@property(nonatomic,strong) UIPickerView *choosePickerView;
@property(nonatomic,strong) NSArray     *pickerData;
@property(nonatomic,strong) AddressInfoDTO *addressDto;

@property(nonatomic,weak) OrderSubmitRootViewController *controller;

@property(nonatomic,strong) UILabel *alertLbl;

@property(nonatomic,strong) ToolBarButton *chooseXCDButton;

@property(nonatomic,copy) NSString *addressType;

- (void) setItem:(AddressInfoDTO *)addrDto;


+ (CGFloat)height:(NSString *)addressType;

@end
