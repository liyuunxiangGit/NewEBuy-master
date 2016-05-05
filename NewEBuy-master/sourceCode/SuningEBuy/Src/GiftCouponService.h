//
//  GiftCouponService.h
//  SuningEBuy
//
//  Created by  on 12-9-29.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "DataService.h"
#import "GiftCouponDTO.h"

@protocol GiftCouponServiceDelegate <NSObject>

@optional
/*!
 @abstract      获取可用优惠券列表请求完成的回调方法
 @param         isSuccess  请求是否成功
 @param         errorMsg   不成功时的错误信息
 @param         pointList  云钻电子券列表
 @param         noPointList  非电子券列表
 */
- (void)getGiftCouponListCompletionWithResult:(BOOL)isSuccess
                                     errorMsg:(NSString *)errorMsg;

- (void)activeGiftCouponCompletionWithResult:(BOOL)isSuccess
                                    errorMsg:(NSString *)errorMsg;

- (void)activeRecommendNumCompletionWithResult:(BOOL)isSuccess
                                  allianceName:(NSString *)allianceName
                              allianceDiscount:(NSString *)allianceDiscount
                                      errorMsg:(NSString *)errorMsg;

@end

/*********************************************************************/

@interface GiftCouponService : DataService
{
    HttpMessage     *activeGiftCouponHttpMsg;
    HttpMessage     *giftCouponListHttpMsg;
    BOOL            isFirstLag;
}

@property (nonatomic, weak) id<GiftCouponServiceDelegate> delegate;
//@property (nonatomic, strong) NSMutableArray                *selectList;
//@property (nonatomic, strong) NSMutableArray                *pointList;
//@property (nonatomic, strong) NSMutableArray                *noPointList;
@property (nonatomic, strong) NSString                      *phoneNum;
@property (nonatomic,strong) NSMutableDictionary                 *cCouponList;
@property (nonatomic, strong) NSMutableArray                *cashCardList;  //礼品卡列表
@property (nonatomic, strong) NSMutableArray                *normalCouponList;  //普通券列表

@property (nonatomic, strong) NSMutableArray                *couponList;        //c店优惠券
/*!
 @abstract      开始获取可用优惠券列表
 @discussion    在结算信息页面进入时请求
 */
- (void)beginGetGiftCouponListRequest:(BOOL)isCOrder unUsable:(BOOL)isable;

/*!
 @abstract      激活优惠券
 @param         cardNo  券号
 @param         cardPwd  券密码
 @discussion    在激活券时使用
 */
- (void)beginActiveGiftCouponRequest:(NSString *)cardNo cardPwd:(NSString *)cardPwd phoneNo:(NSString *)phoneNo;

//校验券名券密码以及验证码不能位特殊字符
+ (BOOL)validateString:(NSString *)string;

+ (BOOL)validateRegisterId:(NSString *)registerIdString;


@end
