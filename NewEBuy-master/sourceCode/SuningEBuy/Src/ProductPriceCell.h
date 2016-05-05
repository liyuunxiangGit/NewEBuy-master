//
//  ProductPriceCell.h
//  SuningEBuy
//
//  Created by 刘坤 on 12-2-10.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataProductBasic.h"
#import "ToolBarButton.h"
#import "EvaluationView.h"
#import "StrikeThroughLabel.h"
#import "AddressInfoPickerView.h"
#import "AddressInfoDAO.h"
#import "AddressInfoDTO.h"
#import "OHAttributedLabel.h"

#define kDefaultProvinceCode       [Config currentConfig].defaultProvince
#define kDefaultCityCode           [Config currentConfig].defaultCity

@interface ProductPriceCell : UITableViewCell <ToolBarButtonDelegate, AddressInfoPickerViewDelegate>


@property (nonatomic, retain)  EvaluationView *starView;

@property (nonatomic, retain)  ToolBarButton *defaultAddressButton;

@property (nonatomic, retain)  UILabel *temContentLbl;

@property (nonatomic, retain)  StrikeThroughLabel *priceLbl;

@property (nonatomic, retain)  OHAttributedLabel *arrivetimeLbl;

//商品详情
@property (nonatomic, retain) DataProductBasic *productDetailDTO;

//地址选择控件
@property (nonatomic, retain)   AddressInfoPickerView *addressPickerView;

@property (nonatomic)NSInteger rowNum;

- (void)setItem:(DataProductBasic *)productDetail;

+ (CGFloat)height:(DataProductBasic *)productDetail;

@end
