//
//  OrderDetailItemInfoCell.h
//  SuningEBuy
//
//  Created by robin wang on 8/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITableViewCellEx.h"

#import "MemberOrderDetailsDTO.h"

@interface OrderDetailItemInfoCell : UITableViewCellEx
{
    
}

@property (nonatomic, assign) BOOL isNotShowButton;

@property (nonatomic, strong) UILabel *nameLbl;

@property (nonatomic, strong) UILabel *countLbl;

@property (nonatomic, strong) UILabel *priceLbl;

@property (nonatomic, strong) UILabel *checkCodeLbl;

@property (nonatomic, strong) UILabel *deliveryLbl;  //送货方式

@property (nonatomic, strong) UILabel *invoiceTypeLbl; //发票类型


@property (nonatomic, strong) UILabel *exWarrantyNameLabl;//阳光包

@property (nonatomic, strong) UILabel *exWarrantyCountLabl;//阳光包 count

@property (nonatomic, strong) UILabel *exWarrantyPriceLbl;

@property(nonatomic,strong) UIButton   *displayOrderBtn;//晒单
@property(nonatomic,strong) UIButton   *evaludateBtn;// 评论
@property(nonatomic,strong) UIButton   *logisticsBtn;//送货安装

@property(nonatomic,strong) UIButton   *cancelOrderBtn;


@property(nonatomic,copy) NSString      *policyDesc;


@property(nonatomic,copy) UIImageView      *cellSeparatorLine;

@property (nonatomic, strong) MemberOrderDetailsDTO *merchItemDTO;

- (id) initWithReuseIdentifier:(NSString *)reuseIdentifier;

+ (CGFloat)height:(id)item;

+ (CGFloat)detailheight:(MemberOrderDetailsDTO *)item isShowButton:(BOOL)isShow;


@end
