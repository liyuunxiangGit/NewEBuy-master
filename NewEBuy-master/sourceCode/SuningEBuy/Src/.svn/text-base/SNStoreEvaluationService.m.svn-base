//
//  SNStoreEvaluationService.m
//  SuningEBuy
//
//  Created by snping on 14-11-9.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "SNStoreEvaluationService.h"
#import "SNStoreEvaluationOrderDTO.h"

#define kStoreCommentListPath            @"/getStoreCommentList.do"
#define kStoreOrderEvaluationStatePath   @"/queryStoreOrderReviewStatus.do"
#define kStoreOrderEvaluationCommitPath  @"/saveStoreComment.do"


@implementation SNStoreEvaluationService

-(void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(storeEvalutionListMsg);
    
    HTTPMSG_RELEASE_SAFELY(storeEvalutionStateMsg);
    
    HTTPMSG_RELEASE_SAFELY(storeEvalutionCommitMsg);
    
}


#pragma mark---待评价门店订单查询接口
- (void)getStoreEvalutionList
{
    NSString *url = [NSString stringWithFormat:@"%@%@",kStoreEvaluationHostURL,kStoreCommentListPath];
    
    HTTPMSG_RELEASE_SAFELY(storeEvalutionListMsg);
    storeEvalutionListMsg = [[HttpMessage alloc]initWithDelegate:self requestUrl:url postDataDic:nil cmdCode:CC_StoreEvaluationList];
    storeEvalutionListMsg.requestMethod = RequestMethodGet;
    
    [self.httpMsgCtrl sendHttpMsg:storeEvalutionListMsg];
}

- (void)parseStoreEvalutionList:(NSDictionary *)dic
{
    
}

#pragma mark---门店订单评价状态查询
- (void)getStoreOrderEvaluationStatusByOrderItemId:(NSString *)orderItemId
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];

    [dic setObject:(orderItemId?:@"") forKey:@"orderItemId"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",kStoreEvaluationHostURL,kStoreOrderEvaluationCommitPath];
    
    HTTPMSG_RELEASE_SAFELY(storeEvalutionStateMsg);
    storeEvalutionStateMsg = [[HttpMessage alloc]initWithDelegate:self requestUrl:url postDataDic:dic cmdCode:CC_StoreEvaluationState];
    storeEvalutionStateMsg.requestMethod = RequestMethodGet;
    
    [self.httpMsgCtrl sendHttpMsg:storeEvalutionStateMsg];

 }

#pragma mark---门店订单评价提交
- (void)saveStoreCommentWithOrderComment:(SNOrderCommentDTO *)orderComment
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    
      [dic setObject:orderComment.qualityStar  forKey:@"qualityStar"];
      [dic setObject:orderComment.logisticStar forKey:@"logisticStar"];
    
    if (orderComment.serviceStar) {
      [dic setObject:orderComment.serviceStar  forKey:@"serviceStar"];
    }

      [dic setObject:orderComment.anonFlag     forKey:@"anonFlag"];
      [dic setObject:orderComment.orderId      forKey:@"orderId"];
      [dic setObject:orderComment.orderItemId  forKey:@"orderItemId"];
      [dic setObject:orderComment.commodityCode forKey:@"commodityCode"];
      [dic setObject:orderComment.content       forKey:@"content"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",kStoreEvaluationHostURL,kStoreOrderEvaluationCommitPath];
    
    HTTPMSG_RELEASE_SAFELY(storeEvalutionCommitMsg);
    storeEvalutionCommitMsg = [[HttpMessage alloc]initWithDelegate:self requestUrl:url postDataDic:dic cmdCode:CC_StoreEvaluationCommit];

    [self.httpMsgCtrl sendHttpMsg:storeEvalutionCommitMsg];
}

#pragma mark -- httpMessage delegate

-(void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    switch (receiveMsg.cmdCode) {
        case CC_StoreEvaluationList:
            if (_delegate&&[_delegate respondsToSelector:@selector(storeEvaluationService:getStoreEvalutionListSuccess:errorMsg:)]) {
                
                [_delegate storeEvaluationService:self  getStoreEvalutionListSuccess:NO errorMsg:self.errorMsg];
            }
            break;
            
        case CC_StoreEvaluationState:
            if (_delegate&&[_delegate respondsToSelector:@selector(storeEvaluationService:getStoreOrderEvaluationStatusSuccess:errorMsg:)]) {
                
                [_delegate storeEvaluationService:self  getStoreOrderEvaluationStatusSuccess:NO errorMsg:self.errorMsg];
            }
            break;

        case CC_StoreEvaluationCommit:
            if (_delegate&&[_delegate respondsToSelector:@selector(saveStoreCommentSuccess:errorMsg:)]) {
                
                [_delegate saveStoreCommentSuccess:NO errorMsg:self.errorMsg];
            }
            break;

            
        default:
            break;
    }
    
}


-(void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    NSDictionary *items = receiveMsg.jasonItems;
    NSString *code = EncodeStringFromDic(items, @"code");
    
    switch (receiveMsg.cmdCode) {
            
        case CC_StoreEvaluationList:
        {
            BOOL isSuccess = NO;
            
            if ([code isEqualToString:@"1"])
            {
                self.errorMsg = L(@"MyEBuy_EvaluateSuccess");
                isSuccess = YES;
                
                self.storeEvalutionList = EncodeArrayFromDicUsingParseBlock(items, @"data", ^id(NSDictionary *innerDic) {
                    SNStoreEvaluationOrderDTO *dto = [SNStoreEvaluationOrderDTO new ];
                    [dto parseOrderItmFromDictionary:innerDic];
                    return dto;
                });
            
                
            }else if ([code isEqualToString:@"-1"])
            {
                self.errorMsg = L(@"NWServiceException");
                
            }
            
            if (_delegate&&[_delegate respondsToSelector:@selector(storeEvaluationService:getStoreEvalutionListSuccess:errorMsg:)]) {
                
                [_delegate storeEvaluationService:self  getStoreEvalutionListSuccess:isSuccess errorMsg:self.errorMsg];
            }
            

            break;
        }
            
        case CC_StoreEvaluationState:
        {
            BOOL isSuccess = NO;
            
            if ([code isEqualToString:@"1"])
            {
                self.errorMsg = L(@"MyEBuy_EvaluateSuccess");
                isSuccess = YES;
                
                NSDictionary *dataDic = EncodeDicFromDic(items, @"data");
                self.omsOrderItemId = EncodeStringFromDic(dataDic, @"omsOrderItemId");
                self.otherCommented = EncodeStringFromDic(dataDic, @"otherCommented");
                self.serviceCommented = EncodeStringFromDic(dataDic, @"serviceCommented");
                
            }else if ([code isEqualToString:@"-1"])
            {
                self.errorMsg = L(@"NWServiceException");
                
            }else if ([code isEqualToString:@"-2"])
            {
                self.errorMsg = L(@"HCantFindOrderState");
                
            }
            if (_delegate&&[_delegate respondsToSelector:@selector(storeEvaluationService:getStoreOrderEvaluationStatusSuccess:errorMsg:)]) {
                
                [_delegate storeEvaluationService:self  getStoreOrderEvaluationStatusSuccess:isSuccess errorMsg:self.errorMsg];
            }
            break;
        }
            
        case CC_StoreEvaluationCommit:
        {
            BOOL isSuccess = NO;
            
            if ([code isEqualToString:@"1"])
            {
                self.errorMsg = L(@"MyEBuy_EvaluateSuccess");
                isSuccess = YES;
                
            }else if ([code isEqualToString:@"-1"]||[code isEqualToString:@"0010"])
            {
             self.errorMsg = L(@"NWServiceException");
                
            }else if ([code isEqualToString:@"0011"])
            {
                self.errorMsg = L(@"HCommentRepeat");
                
            }else if ([code isEqualToString:@"0012"])
            {
                self.errorMsg = L(@"HNotStoreOrder");
            }
            
            if (_delegate&&[_delegate respondsToSelector:@selector(saveStoreCommentSuccess:errorMsg:)]) {
                
                [_delegate saveStoreCommentSuccess:isSuccess errorMsg:self.errorMsg];
            }
            break;
        }
            
            
        default:
            break;
    }

}


@end
