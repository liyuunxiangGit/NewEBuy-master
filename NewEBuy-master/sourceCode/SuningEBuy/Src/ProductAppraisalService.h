//
//  ProductAppraisalService.h
//  SuningEBuy
//
//  Created by 正来 崔 on 12-9-20.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "DataService.h"

@class ProductAppraisalService;

@protocol ProductAppraisalServiceDelegate <NSObject>

@optional
- (void)ProductAppraisalHttpRequestCompletedWithService:(ProductAppraisalService *)service
                                               isSucess:(BOOL)isSucess
                                              errorCode:(NSString *)errorCode;

- (void)BookAppraisalHttpRequestCompletedWithService:(ProductAppraisalService *)service 
                                            isSucess:(BOOL)isSucess 
                                           errorCode:(NSString *)errorCode;

-(void)ValidateHttpRequestCompletedWithService:(ProductAppraisalService*)service 
                                     isSuccess:(BOOL)isSuccess;


@end



@interface ProductAppraisalService : DataService{
    
    HttpMessage     *_ProductAppraisalHttpMsg;
    HttpMessage     *_BookAppraisalHttpMsg;
    HttpMessage     *_ValidateHttpMsg;
}

@property(nonatomic,weak)id<ProductAppraisalServiceDelegate>delegate;

@property(nonatomic,assign)double    totalEvaludate;
@property(nonatomic,strong)NSMutableArray   *appraiseList;
@property(nonatomic,strong)NSString  *isEvaluatable;
@property(nonatomic,assign)SNPageInfo pageInfo;

-(void)sendBookAppraisalHttpRequest:(NSString *)productCode  
                          ProductId:(NSString *)productId 
                        currentPage:(NSInteger)currentPage
                               type:(NSString *)type;

-(void)sendProductAppraisalHttpRequest:(NSString *)productCode  
                             ProductId:(NSString *)productId 
                           currentPage:(NSInteger)currentPage
                                  type:(NSString *)type;

-(void)sendValidateHttpRequest:(NSString *)productCode;


@end
