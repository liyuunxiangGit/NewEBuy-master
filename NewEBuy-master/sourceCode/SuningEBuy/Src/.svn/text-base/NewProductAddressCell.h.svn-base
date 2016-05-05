//
//  NewProductAddressCell.h
//  SuningEBuy
//
//  Created by xmy on 18/10/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
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

#import "PanicPurchaseDTO.h"

#define kDefaultProvinceCode       [Config currentConfig].defaultProvince
#define kDefaultCityCode           [Config currentConfig].defaultCity

@interface NewProductAddressCell : UITableViewCell<ToolBarButtonDelegate, AddressInfoPickerViewDelegate>


@property (nonatomic, retain)  ToolBarButton *defaultAddressButton;

@property (nonatomic, retain)  UILabel *temContentLbl;

@property (nonatomic, retain)  OHAttributedLabel *arrivetimeLbl;

@property (nonatomic, retain)  StrikeThroughLabel *priceLbl;

//商品详情
@property (nonatomic, retain) DataProductBasic *productDetailDTO;

//地址选择控件
@property (nonatomic, retain)   AddressInfoPickerView *addressPickerView;

//@property (nonatomic, retain)  UIImageView  *favourImage;
//@property (nonatomic, retain)  UILabel      *favourLabel;


@property (nonatomic)NSInteger type;  //1,普通 2，抢购

@property (nonatomic)NSInteger rowNum;

- (void)setItem:(DataProductBasic *)productDetail;
- (void)setItem:(DataProductBasic *)productDetail qiang:(PanicPurchaseDTO*)dto;

+ (CGFloat)height:(DataProductBasic *)productDetail;

@end