//
//  ProducetDetailBaseViewController.h
//  SuningEBuy
//
//  Created by li xiaokai on 13-7-12.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "ProductAppraisalViewController.h"
#import "NewProductAppraisalViewController.h"
#import "SNShareKit.h"

typedef enum {

    SelectLeftBtn = 0,
    SelectMidBtn,
    SelectRightBtn
    
} BtnSelectType;

@interface ProducetDetailBaseViewController : CommonViewController<UIScrollViewDelegate>

@property (nonatomic,strong)UIImageView *headBackView;

@property (nonatomic, strong) UIImageView   *lineView;
@property(nonatomic,strong)UIButton *baseInfoBtn;
@property(nonatomic,strong)UIButton *introduceBtn;
@property(nonatomic,strong)UIButton *appraiseBtn;
@property(nonatomic,strong)NSArray *btnArray;

@property(nonatomic,strong)UIView *leftView;
@property(nonatomic,strong)UIView *midView;
@property(nonatomic,strong)UIView *rightView;
@property(nonatomic, strong)UIScrollView *backScrollView;//添加tab切换效果 chupeng 2013-11-28

@property(nonatomic,strong)NSArray *appraseBtnArray;

@property(nonatomic)BtnSelectType selectType;

//@property(nonatomic,strong)NewProductAppraisalViewController *appraisVC;

@property (nonatomic, strong) SNShareKit *shareKit;           //分享控制器

//子类需要实现的方法
-(void)viewChangeWithType:(BtnSelectType)type;

-(void)showBaseView;
-(void)showIntroduceView;
-(void)showAppraiseView;

- (void)share;
@end
