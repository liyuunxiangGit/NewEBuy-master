//
//  ChooseCouponViewController.h
//  SuningEBuy
//
//  Created by  liukun on 13-12-24.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "CheckCodeService.h"
#import "SNReaderViewController.h"
#import "PayFlowService.h"

@class ChooseCouponViewController;
@protocol ChooseCouponDelegate <NSObject>

- (void)chooseCouponDidOk:(ChooseCouponViewController *)vc;

@end

@interface ChooseCouponViewController : CommonViewController <CheckCodeServiceDelegate,SNReaderDelegate,PayFlowServiceDelegate>
{
    BOOL    _isCouponLoaded;
    BOOL    _isUnuseCouponLoaded;
}
@property (nonatomic, assign) BOOL isAllCOrder;                 //是否只含有c店商品

@property (nonatomic, assign) BOOL isCOrder;
@property (nonatomic, strong) NSArray *cashCartList;
@property (nonatomic, strong) NSArray *uncashCartList;
@property (nonatomic, strong) NSArray *unnormalCouponList;
@property (nonatomic, strong) NSArray *ccouplist;
@property (nonatomic, strong) NSArray *unccouplist;

@property (nonatomic, strong) NSMutableArray *ccouplisttitle;
@property (nonatomic, strong) NSMutableArray *unccouplisttitle;
@property (nonatomic, strong) NSArray *normalCouponList;
@property (nonatomic, strong) NSString *captcha;    //验证码


@property (nonatomic, strong) NSString *allianceTel;    //联盟手机号
@property (nonatomic, strong) NSString *allianceName;   //联盟推荐名称
@property (nonatomic, strong) NSString *allianceDiscount;   //联盟推荐金额

@property (nonatomic, strong) NSArray *selectCouponList;
@property (nonatomic, assign) id<ChooseCouponDelegate> delegate;
@property (nonatomic, strong) PayFlowService    *payFlowService;

@property (nonatomic, strong) NSDictionary *cashdic;

@property (nonatomic, strong) NSString *totalPriceStr;       //商品总价格的格式化字符串
@property (nonatomic, strong) NSString *shouldPayPrice;       //应该支付的价格
@property (nonatomic, strong) NSString *totalDiscount;      //优惠金额
@property (nonatomic, strong) NSString *totalFareStr;       //总运费

- (void)rebuildCouponSelectState;

@end
