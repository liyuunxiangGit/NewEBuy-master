//
//  ReturnGoodsApplicationService.h
//  SuningEBuy
//
//  Created by 漫 王 on 12-10-8.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

/*!
 @header     ReturnGoodsApplicationService
 @abstract   获取申请退货准备数据、申请退货  
 @author     wangman 
 @version    v1.1 12-10-10 
 */
#import "DataService.h"

#import "ReturnGoodsListDTO.h"

#import "ReturnGoodsPrepareDTO.h"

#import "MemberOrderDetailsDTO.h"

#import "NoReasonReturnDTO.h"
/*!
 @protocol      ReturnGoodsApplicationServiceDelegate
 @abstract      ReturnGoodsApplicationService的一个代理 
 @discussion    获取申请退货准备数据后回调，申请退货后回调
 */

@protocol ReturnGoodsApplicationServiceDelegate <NSObject>

@optional

/*!
 @method      returnGoodsApplicationRequestCompletedWithResult: reasonList: returnGoodsPreparedDto: errorMsg:
 @abstract    获取申请退货准备数据后回调  
 @param       isSuccess 是否获取成功 
 @param       reasonList 退货原因列表 
 @param       dto 退货商品信息
 @param       errorMsg 错误信息
 */
- (void)returnGoodsApplicationRequestCompletedWithResult:(BOOL)isSuccess reasonList:(NSMutableArray *)reasonList returnGoodsPreparedDto:(ReturnGoodsPrepareDTO*) dto errorMsg:(NSString *)errorMsg;

/*!
 @method       retunGoodsSubmitRequestCompletedWithResult: errorMsg:
 @abstract     申请退货后回调 
 @param        isSuccess 是否申请退货成功
 @param        errorMsg 错误信息
 */
- (void)retunGoodsSubmitRequestCompletedWithResult:(BOOL)isSuccess errorMsg:(NSString *)errorMsg;

@end


/*!
 @class     ReturnGoodsApplicationService 
 @abstract  获取退货申请准备数据、申请退货 
 */

@interface ReturnGoodsApplicationService : DataService{
    
    HttpMessage             *_returnGoodsApplicationHttpMsg;
    HttpMessage             *_returnGoodsSubmitHttpMsg;
    
    id                      <ReturnGoodsApplicationServiceDelegate>__weak _delegate;
    
    ReturnGoodsPrepareDTO   *_returnGoodsPrepareDto; 
    
    NSMutableArray          *_reasonList;
}

@property (nonatomic, weak)id                     <ReturnGoodsApplicationServiceDelegate>delegate;  

@property (nonatomic ,strong)ReturnGoodsPrepareDTO  *returnGoodsPrepareDto;

@property (nonatomic ,strong)    NSMutableArray          *reasonList;

/*!
 @method      beginSendReturnGoodsApplicationHttpRequest 
 @abstract    发送获取申请退货准备数据请求  
 @param       dto 退货商品信息 
 */
//- (void)beginSendReturnGoodsApplicationHttpRequest:(ReturnGoodsListDTO *) dto;
- (void)beginSendReturnGoodsApplicationHttpRequest:(MemberOrderDetailsDTO *) dto;

/*!
 @method    beginSendReturnGoodsSubmitHttpRequest   
 @abstract  发送申请退货请求    
 @param     dto 退货商品信息   
 @param     checkUpDate  鉴定时间
 @param     reasonDes 退回原因
 @param     退货原因编号
 */

- (void)beginSendReturnGoodsSubmitHttpRequest:(ReturnGoodsPrepareDTO *)dto  checkUpDate:(NSString *)checkUpDate reasonDes:(NSString *)reasonDes reasonId:(NSString *)reasonId noReasonReturnDto:(NoReasonReturnDTO *)noReasonDto;
//退换接口变化－245
- (void)beginSendReturnPartGoodsSubmitHttpRequest:(ReturnGoodsPrepareDTO *)dto  checkUpDate:(NSString *)checkUpDate reasonDes:(NSString *)reasonDes reasonId:(NSString *)reasonId noReasonReturnDto:(NoReasonReturnDTO *)noReasonDto;
/*!
 @method    returnGoodsApplicationRequestOK   
 @abstract  获取申请退货准备数据处理   
 @param     items 申请退货准备数据        
 */
- (void)returnGoodsApplicationRequestOK:(NSDictionary *)items;

/*!
 @method   returnGoodsApplicationOK    
 @abstract 获取申请退货准备数据处理      
 @param    isSuccess 是否获取成功    
 */
- (void)returnGoodsApplicationOK:(BOOL)isScuess;

/*!
 @method   returnGoodsSubmitOK    
 @abstract 盛情退货后处理      
 @param    isSuccess 是否申请退货成功    
 */
- (void)returnGoodsSubmitOK:(BOOL)isSuccess;
//


@end
