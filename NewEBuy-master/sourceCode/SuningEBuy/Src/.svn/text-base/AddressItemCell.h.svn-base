//
//  AddressItemCell.h
//  SuningEBuy
//
//  Created by xy ma on 11-10-20.
//  Copyright (c) 2011年 sn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UITableViewCellEx.h"
#import "AddressInfoDTO.h"
#import "SNGraphics.h"
#import "SNUITableViewCell.h"
#import "OHAttributedLabel.h"
#import "NSAttributedString+Attributes.h"

typedef enum{
    FromEbuy = 0,
    FromShop
}AddressCellType;

@protocol AddressItemCellDelegate;

@interface AddressItemCell : SNUITableViewCell
{
    
}
@property(nonatomic,weak) id<AddressItemCellDelegate>  delegate;

@property(nonatomic,strong) UILabel                 *nameLab;       //姓名
@property(nonatomic,strong) UILabel                 *phoneLab;      //电话
@property(nonatomic,strong) OHAttributedLabel       *addressLab;    //详细地址
@property(nonatomic,strong) UIButton                *editBtn;       //编辑
@property(nonatomic,strong) UIButton                *markBtn;      //是否勾选
@property(nonatomic,strong) UIImageView             *lineImgView;
@property(nonatomic,strong) AddressInfoDTO          *addressInfoItem;
@property(nonatomic, assign)BOOL                    isSelect;

@property(nonatomic)AddressCellType     cellType;
- (void)setAddressInfoItem:(AddressInfoDTO *)aAddressInfoItem edit:(BOOL)isEdit;

+ (CGFloat) height:(AddressInfoDTO *)addressInfoItem type:(AddressCellType)cellType edit:(BOOL)edit;

@end

@protocol AddressItemCellDelegate <NSObject>

- (void)editAddressItemAction:(AddressInfoDTO *)dto withTag:(NSInteger)tag;

@end
