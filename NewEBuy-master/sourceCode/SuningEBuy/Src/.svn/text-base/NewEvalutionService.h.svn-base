//
//  NewEvalutionService.h
//  SuningEBuy
//
//  Created by  zhang jian on 13-4-9.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EvaluationBsicDTO.h"
#import "NewProductAppraisalDTO.h"
#import "NewProductAppraisial_Json_DTO.h"

@protocol NewEvalutionServiceDelegate;

@interface NewEvalutionService : DataService
{
    HttpMessage         *evalutionListMsg;
    HttpMessage         *evalutionValidateMsg;
    HttpMessage         *evalutionPublishMsg;
    HttpMessage         *evalutionProductMsg;
    BOOL                _isBook;
}

@property (nonatomic, weak) id<NewEvalutionServiceDelegate>     delegate;
@property (nonatomic, assign) BOOL  showReviewStatus;

@property (nonatomic, assign)  BOOL isLastPage; //是否最后一页

@property (nonatomic, assign)  int totalPage;   //总页数

@property (nonatomic, assign)  int currentPage; //当前页数
@property (nonatomic, strong)  NSString* totalOrderItemRecords; //评价总数
@property (nonatomic, assign)  int reviewType;  //评价类型

@property (nonatomic, assign)  int totalNum;    //评价总数
@property (nonatomic, strong)  NSString *goodNum;     //好评数
@property (nonatomic, strong)  NSString *midNum;      //中评数
@property (nonatomic, strong)  NSString *badNum;      //差评数
@property (nonatomic, strong)  NSString *dispNum;     //晒单数
@property (nonatomic, strong)  NSMutableArray *labelArr;//标签数组

- (void)getEvalutionListHttp:(int)currentPage;

- (void)beginEvalutionValidate:(NSString *)orderItemId;

- (void)beginEvalutionPublish:(EvaluationBsicDTO *)evaluationBsicDTO;

- (void)beginProductDetailEvaluationHttp:(NSString *)partNumbers
                             CurrentPage:(int)currentPage
                              ReviewType:(int)reviewType;

- (void)beginProductDetailEvaluationNumberHttp:(NSString *)partNumbers
                             CurrentPage:(int)currentPage
                              ReviewType:(NSString *)reviewType;

- (void)beginProductDetailEvaluationLabelHttp:(NSString *)partNumbers
                                   CurrentPage:(int)currentPage
                                    ReviewType:(NSString *)reviewType;

@end


@protocol NewEvalutionServiceDelegate <NSObject>

@optional
- (void)getEvalutionListCompletedWithResult:(BOOL)isSucced
                                 isLastPage:(BOOL)isLastPages
                                  errorCode:(NSString*)errorCode
                                       List:(NSArray*)array
                                     number:(NSString *)evalutionNumber;


- (void)evalutionValidateCompletedWithResult:(BOOL)isSuccess
                                    errorMsg:(NSString *)errorMsg;


- (void)evalutionPublishCompletedWithResult:(BOOL)isSuccess
                                   errorMsg:(NSString *)errorMsg;

- (void)evaluationProductDetailCompletedWithService:(NewEvalutionService *)service
                                          isSuccess:(BOOL)isSuccess
                                          errorCode:(NSString *)errorMsg
                                               list:(NSArray *)array;

//- (void)evaluationProductAppraisialNumberWithService:(NewEvalutionService *)service
//                                           isSuccess:(BOOL)isSuccess
//                                           errorCode:(NSString *)errorMsg;
//
//- (void)evaluationProductAppraisialLabelWithService:(NewEvalutionService *)service
//                                           isSuccess:(BOOL)isSuccess
//                                           errorCode:(NSString *)errorMsg;

@end