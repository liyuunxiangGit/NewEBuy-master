//
//  GBRefundCell.h
//  SuningEBuy
//
//  Created by li xiaokai on 13-6-18.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSBtnService.h"
#import "GBCancelOrderService.h"
#import "keyboardNumberPadReturnTextField.h"
@interface GBRefundCell : UITableViewCell<KeyboardDoneTappedDelegate,UITextFieldDelegate>



@property(nonatomic,strong)UILabel *refundAccountLab;
@property(nonatomic,strong)keyboardNumberPadReturnTextField *refundAccountTF;
@property(nonatomic,strong)UILabel *accountDesLab;
@property(nonatomic,strong)UILabel *refundPriceLab;
@property(nonatomic,strong)UILabel *priceDesLab;
@property(nonatomic,strong)UIImageView *lineView;
@property(nonatomic,strong)UILabel *refundReasonLab;
@property(nonatomic,strong)SSBtnService *singleBtn;

@property(nonatomic,strong)ReFundInfoDto   *refundInfo;

@property(nonatomic,strong)NSDictionary *infoDic;

@property(nonatomic,strong)NSArray *keyArray;

@property (nonatomic,weak)id myDelegate;

-(void)initCellView:(ReFundInfoDto *)dto;
@end
