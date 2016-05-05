//
//  CShopReturnApplicationService.h
//  SuningEBuy
//
//  Created by 荀晓冬 on 13-12-14.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "DataService.h"
#import "ReturnGoodsPrepareDTO.h"
#import "ReturnGoodsListDTO.h"
#import "MemberOrderDetailsDTO.h"
@protocol CShopReturnGoodsApplicationServiceDelegate <NSObject>

@optional

//c店
- (void)CShopReturnGoodsApplicationRequestCompletedWithResult:(BOOL)isSuccess reasonList:(NSMutableArray *)reasonList returnGoodsPreparedDto:(ReturnGoodsPrepareDTO*) dto errorMsg:(NSString *)errorMsg;


- (void)CshoopRetunGoodsSubmitRequestCompletedWithResult:(BOOL)isSuccess errorMsg:(NSString *)errorMsg;

@end
@interface CShopReturnApplicationService : DataService
{
    HttpMessage             *_returnCShopGoodsApplicationHttpMsg;
    
    HttpMessage             *_returnCShopGoodsSubmitHttpMsg;
    id                      <CShopReturnGoodsApplicationServiceDelegate>__weak _delegate;
    
    ReturnGoodsPrepareDTO   *_returnGoodsPrepareDto;
    
    NSMutableArray          *_reasonList;
}
@property (nonatomic, weak)id                     <CShopReturnGoodsApplicationServiceDelegate>delegate;

@property (nonatomic ,strong)ReturnGoodsPrepareDTO  *returnGoodsPrepareDto;

@property (nonatomic ,strong)    NSMutableArray          *reasonList;


//- (void)CShopBeginSendReturnGoodsApplicationHttpRequest:(ReturnGoodsListDTO *) dto;//发送获取申请退货准备数据请求
- (void)CShopBeginSendReturnGoodsApplicationHttpRequest:(MemberOrderDetailsDTO *) dto;//发送获取申请退货准备数据请求


- (void)CShopBeginSendReturnGoodsSubmitHttpRequest:(ReturnGoodsPrepareDTO *)dto
                                       reasonName:(NSString *)reasonName
                                         reasonDes:(NSString *)reasonDes
                                          reasonId:(NSString *)reasonId;//发送申请退货请求


- (void)returnGoodsApplicationRequestOK:(NSDictionary *)items;//获取申请退货准备数据

- (void)returnGoodsApplicationOK:(BOOL)isScuess;//获取申请退货真被数据是否成功


- (void)returnGoodsSubmitOK:(BOOL)isSuccess;// 申请退货处理是否成功
//


@end
