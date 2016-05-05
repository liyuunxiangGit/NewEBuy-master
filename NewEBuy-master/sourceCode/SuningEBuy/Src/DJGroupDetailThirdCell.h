//
//  DJGroupDetailThirdCell.h
//  SuningEBuy
//
//  Created by xie wei on 13-7-15.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "AddressInfoDAO.h"
#import "AddressInfoPickerView.h"
#import "ToolBarButton.h"
#import "OHAttributedLabel.h"
#import "DJGroupDetailDTO.h"
#import "DataProductBasic.h"

@interface DJGroupDetailThirdCell : UITableViewCell <AddressInfoPickerViewDelegate,ToolBarButtonDelegate>

@property (nonatomic, strong) UILabel *sendTo;
@property (nonatomic, strong) ToolBarButton              *defaultAddressButton;
@property (nonatomic, strong) AddressInfoPickerView      *addressPickerView;
@property (nonatomic, strong) UILabel *timeTitle;
@property (nonatomic, strong) OHAttributedLabel *timeContent;
@property (nonatomic, strong) UIImageView *saleOutCoutBack;
@property (nonatomic, strong) UILabel *saleOutText;
@property (nonatomic, retain)  UIImageView  *favourImage;
@property (nonatomic, retain)  UILabel      *favourLabel;

+ (CGFloat)height:(DataProductBasic *)productDetail;
- (void)setItem:(DataProductBasic *)productDetail detailDto:(DJGroupDetailDTO *)detailDto;

@end
