//
//  GBVoucherSingleInfoCell.h
//  SuningEBuy
//
//  Created by xingxuewei on 13-3-1.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GBVoucherSingleInfoDTO.h"
#import "SNUITableViewCell.h"

@class GBVoucherSingleInfoCell;

@protocol GBVoucherSingleInfoCellDelegate <NSObject>

@optional

-(void)selectAction:(GBVoucherSingleInfoDTO *)item cell:(NSIndexPath *)indexPath;

@end

@interface GBVoucherSingleInfoCell : SNUITableViewCell<GBVoucherSingleInfoCellDelegate>

//@property (nonatomic, retain)    UILabel                     *spOrderIdContentLbl;
//@property (nonatomic, retain)    UILabel                     *spOrderIdLbl;                     //编号
@property (nonatomic, strong)    UILabel                     *voucherCodeContentLbl;
@property (nonatomic, strong)    UILabel                     *voucherCodeLbl;                   //券号码
@property (nonatomic, strong)    UILabel                     *usefulLifeContentLbl;
@property (nonatomic, strong)    UILabel                     *usefulLifeLbl;                    //有效期
@property (nonatomic, strong)    UILabel                     *voucherStateContentLbl;
@property (nonatomic, strong)    UILabel                     *voucherStateLbl;                  //券状态
@property (nonatomic, strong)    UILabel                     *voucherPasswordContentLbl;
@property (nonatomic, strong)    UILabel                     *voucherPasswordLbl;               //券密码
@property (nonatomic, strong)    UIImageView                 *lineView;

@property (nonatomic, assign)    GBType                      tuanGouType;

@property (nonatomic, strong)    GBVoucherSingleInfoDTO      *item;

@property (nonatomic, strong)    UIButton                    *selectBtn;

@property (nonatomic)    BOOL                    isRefund;


@property (nonatomic,weak)  id<GBVoucherSingleInfoCellDelegate> myDelegate;
- (void)setItem:(GBVoucherSingleInfoDTO *)item WithIsrefund:(BOOL)isRefund;


@end
