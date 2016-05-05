//
//  SNStoreEvaluationService.h
//  SuningEBuy
//
//  Created by snping on 14-11-9.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "DataService.h"
#import "SNOrderCommentDTO.h"

@protocol SNStoreEvaluationServiceDelegate;
@interface SNStoreEvaluationService : DataService

{
    HttpMessage         *storeEvalutionListMsg;
    HttpMessage         *storeEvalutionStateMsg;
    HttpMessage         *storeEvalutionCommitMsg;
    
}

@property (nonatomic, assign) id<SNStoreEvaluationServiceDelegate> delegate;
@property (nonatomic, strong)  NSArray *storeEvalutionList;//评价门店订单
@property (nonatomic, strong)  NSString  *omsOrderItemId;//订单行号
@property (nonatomic, strong)  NSString  *otherCommented;// 其他是否已评论 1是 0否
@property (nonatomic, strong)  NSString  *serviceCommented;// 店员服务是否已评论 1是 0否

- (void)getStoreEvalutionList;

- (void)getStoreOrderEvaluationStatusByOrderItemId:(NSString *)orderItemId;

- (void)saveStoreCommentWithOrderComment:(SNOrderCommentDTO *)orderComment;

@end




@protocol SNStoreEvaluationServiceDelegate <NSObject>

- (void)storeEvaluationService:(SNStoreEvaluationService *)service getStoreEvalutionListSuccess:(BOOL)isSuccess errorMsg:(NSString *)errorMsg ;


- (void)storeEvaluationService:(SNStoreEvaluationService *)service getStoreOrderEvaluationStatusSuccess:(BOOL)isSuccess errorMsg:(NSString *)errorMsg ;

- (void)saveStoreCommentSuccess:(BOOL)isSuccess errorMsg:(NSString *)errorMsg;


@end


