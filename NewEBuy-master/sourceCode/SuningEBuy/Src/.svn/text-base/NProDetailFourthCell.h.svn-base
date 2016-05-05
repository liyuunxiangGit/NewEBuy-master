//
//  NProDetailFourthCell.h
//  SuningEBuy
//
//  Created by xmy on 18/12/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToolBarButton.h"
#import "DataProductBasic.h"
#import "AddressInfoPickerView.h"
#import "AddressInfoDAO.h"
#import "OHAttributedLabel.h"

@interface NProDetailFourthCell : UITableViewCell<AddressInfoPickerViewDelegate,ToolBarButtonDelegate>

@property (nonatomic, retain) UILabel *songZhiLbl;//送至

@property (nonatomic, retain)  ToolBarButton *defaultAddressButton;

@property (nonatomic, retain)  UILabel *arrivetimeLbl;

@property (nonatomic)NSInteger rowNum;//送达状态行数

@property (nonatomic, strong)  UIImageView   *topLineImgView;

@property (nonatomic, retain)  OHAttributedLabel *deliveryFeeLbl;

//@property (nonatomic,retain)UIImageView *secondTopLine;

//商品详情
@property (nonatomic, retain) DataProductBasic *productDetailDTO;

//地址选择控件
@property (nonatomic, retain)   AddressInfoPickerView *addressPickerView;

@property (nonatomic,retain)UIImageView *thirdTopLine;

@property (nonatomic, assign)ProductDeatailType type;

- (void)setNProDetailFourCellInfo:(DataProductBasic*)dto WithType:(ProductDeatailType)type coloStr:(NSString *)colorStr;

+ (CGFloat)NProDetailFourCellHeight:(DataProductBasic*)dto WithType:(ProductDeatailType)type
;

//展示评价标签
- (void)setAppraisalLabel:(DataProductBasic*)dto;

//展示评价
- (void)setAppraisal:(DataProductBasic *)dto;

@end
