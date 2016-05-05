//
//  NProDtailAppraiseViewController.h
//  SuningEBuy
//
//  Created by xmy on 23/12/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "PageRefreshTableViewController.h"
#import "NewEvalutionService.h"
#import "DataProductBasic.h"
#import "NewProductAppraisalCell.h"
#import "SNProductInfoCell.h"
//#import "DWTagListWithoutAnimation.h"


@class NProDtailAppraiseViewController;

@protocol NProDtailAppraiseViewControllerDelagete <NSObject>

- (void)backRecordsDelegate:(NSString *)recordsNum;// Rate:(NSString *)rate;

@end

@interface NProDtailAppraiseViewController :PageRefreshTableViewController<NewEvalutionServiceDelegate, UIScrollViewDelegate,UIGestureRecognizerDelegate>//DWTagListWithoutAnimationDelegate>
{
    BOOL                isListLoaded;
}
@property (nonatomic,strong)NSMutableArray *productReviewList;

@property (nonatomic, strong) NewEvalutionService       *evalutionService;

@property (nonatomic, strong) DataProductBasic *productBasic;

@property (nonatomic, weak) id<NProDtailAppraiseViewControllerDelagete> delegate;

@property (nonatomic, assign) NSInteger  reviewType;//评价类型

@property (nonatomic, strong) NSString   *stringType;//NSString类型的评价类型

@property (nonatomic, assign) BOOL      isListLoaded;

@property (nonatomic, strong) UIImageView   *btnClickedImg;

@property (nonatomic, strong) UIView    *headView;

//@property (nonatomic, strong) UIButton  *synthesisBtn;  //综合

@property (nonatomic, strong) UIButton  *goodBtn;       //好评

@property (nonatomic, strong) UIButton  *midBtn;        //中评

@property (nonatomic, strong) UIButton  *badBtn;        //差评

//@property (nonatomic, strong) UIButton  *disOrderBtn;   //晒单

//@property (nonatomic, strong) UIView    *labelView;     //标签及好评率

//@property (nonatomic, strong) UISwipeGestureRecognizer  *swipe;

@property(nonatomic,strong)NSArray      *btnArray;

//@property (nonatomic, strong) DWTagListWithoutAnimation *tagList;

- (id)initWithProductBasicDTO:(DataProductBasic *)productBasc;

//- (void)sendLabelHttpRequest;

- (void)sendHttpRequest;

- (void)btnChangeAppraiseAction:(UIButton *)btn;

- (void)refreshData;
@end
