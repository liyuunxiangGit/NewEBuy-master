//
//  NProDetailSixCell.h
//  SuningEBuy
//
//  Created by xmy on 19/12/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataProductBasic.h"

typedef enum {
    
    SelectLeftBtnCell = 0,
    SelectMidBtnCell = 1,
    SelectRightBtnCell = 2,
    SelectFourCell =3
    
} BtnSelectTypeCell;

@class NProDetailSixCell;

@protocol NProDetailSixCellDelegate <NSObject>

-(void)viewChangeWithType:(BtnSelectTypeCell)type;

//- (void)setAppraiseBtnNumbers;

@end

@interface NProDetailSixCell : UIView

@property (nonatomic, weak)id<NProDetailSixCellDelegate>delegate;
@property (nonatomic, retain)UIButton *baseInfoBtn;
@property (nonatomic, retain)UIButton *introduceBtn;
@property (nonatomic, retain)UIButton *appraiseBtn;
@property (nonatomic, strong)UIButton *consultationBtn;
@property(nonatomic,strong)NSArray *btnArray;
@property(nonatomic)BtnSelectTypeCell selectType;
@property (nonatomic, strong) UIImageView   *lineView;
@property (nonatomic, strong) UIImageView   *lineView1;
@property (nonatomic, strong) UIImageView   *lineView2;
@property (nonatomic, strong) UIImageView   *btnClickedImg;

@property (nonatomic, strong) UIImageView   *seperateLineOne;
@property (nonatomic, strong) UIImageView   *seperateLineTwo;
@property (nonatomic, strong) UIImageView   *seperateLineThree;

-(void)btnChangeTabAction:(UIButton *)btn;


- (void)setNProDetailSixCellInfo:(DataProductBasic*)dto WithAppraiseNum:(NSString*)numStr;


@end
