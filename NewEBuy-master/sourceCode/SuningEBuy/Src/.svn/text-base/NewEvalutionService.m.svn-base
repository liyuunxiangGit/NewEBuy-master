//
//  NewEvalutionService.m
//  SuningEBuy
//
//  Created by  zhang jian on 13-4-9.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "NewEvalutionService.h"
#import "EvalutionDTO.h"
#import "PasswdUtil.h"

@interface NewEvalutionService(){
}

- (void)evalutionValidate:(BOOL)isSuccess;
- (void)evalutionPublish:(BOOL)isSuccess;

@end

@implementation NewEvalutionService

@synthesize isLastPage = _isLastPage;

@synthesize totalPage = _totalPage;

@synthesize currentPage = _currentPage;

@synthesize totalOrderItemRecords = _totalOrderItemRecords;

-(void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(evalutionListMsg);
    
    HTTPMSG_RELEASE_SAFELY(evalutionValidateMsg);
    
    HTTPMSG_RELEASE_SAFELY(evalutionPublishMsg);
    
    HTTPMSG_RELEASE_SAFELY(evalutionProductMsg);
}


-(void)getEvalutionListHttp:(int)currentPage
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    self.currentPage = currentPage;
    //    [dic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
    [dic setObject:[NSString stringWithFormat:@"%d",currentPage] forKey:@"currentPage"];
    [dic setObject:@"10" forKey:@"pageSize"];
    [dic setObject:@"1" forKey:@"supportCStore"];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kEvaluateServerHost,@"my_product_review.htm"];
    
    HTTPMSG_RELEASE_SAFELY(evalutionListMsg);
    
    evalutionListMsg = [[HttpMessage alloc] initWithDelegate:self
                                                  requestUrl:url
                                                 postDataDic:dic
                                                     cmdCode:CC_EvaluateList];
    
    [self.httpMsgCtrl sendHttpMsg:evalutionListMsg];
    
    TT_RELEASE_SAFELY(dic);
}


- (void)beginEvalutionValidate:(NSString *)orderItemId
{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    
    [dic setObject:orderItemId?orderItemId:@"" forKey:@"orderItemId"];
    //    [dic setObject:catentryId?catentryId:@"" forKey:@"catentryId"];
    //    [dic setObject:[UserCenter defaultCenter].userInfoDTO.userId?[UserCenter defaultCenter].userInfoDTO.userId:@"" forKey:@"userId"];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kEvaluateServerHost,@"reviewable.htm"];
    
    HTTPMSG_RELEASE_SAFELY(evalutionValidateMsg);
    
    evalutionValidateMsg = [[HttpMessage alloc] initWithDelegate:self
                                                      requestUrl:url
                                                     postDataDic:dic
                                                         cmdCode:CC_EvaluateValidate];
    
    [self.httpMsgCtrl sendHttpMsg:evalutionValidateMsg];
    
    TT_RELEASE_SAFELY(dic);
    
}

- (void)beginEvalutionPublish:(EvaluationBsicDTO *)evaluationBsicDTO
{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    
    [dic setObject:evaluationBsicDTO.qualityStar?evaluationBsicDTO.qualityStar:@"" forKey:@"qualityStar"];
    
    NSString *data = [[[evaluationBsicDTO.content dataUsingEncoding:NSUTF8StringEncoding] base64Encoding] URLEvalutionEncoding];
    
    [dic setObject:data?data:@"" forKey:@"content"];
    
    [dic setObject:evaluationBsicDTO.orderItemId?evaluationBsicDTO.orderItemId:@"" forKey:@"orderItemId"];
    [dic setObject:evaluationBsicDTO.anonFlag?evaluationBsicDTO.anonFlag:@"" forKey:@"anonFlag"];
    [dic setObject:evaluationBsicDTO.orderId?evaluationBsicDTO.orderId:@"" forKey:@"orderId"];
    [dic setObject:evaluationBsicDTO.partNumber?evaluationBsicDTO.partNumber:@"" forKey:@"partNumber"];
    [dic setObject:evaluationBsicDTO.attitudeStar?evaluationBsicDTO.attitudeStar:@"0" forKey:@"attitudeStar"];
    [dic setObject:evaluationBsicDTO.sellerSpeedStar?evaluationBsicDTO.sellerSpeedStar:@"5" forKey:@"sellerSpeedStar"];
    [dic setObject:evaluationBsicDTO.dlvrSpeedStar?evaluationBsicDTO.dlvrSpeedStar:@"0" forKey:@"dlvrSpeedStar"];
    
    //add by xingxianping,iPhone客户端设备类型传6
    [dic setObject:@"6" forKey:@"deviceType"];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kEvaluateServerHost,@"add_product_review.htm"];//SNPublishCommentService
    
    HTTPMSG_RELEASE_SAFELY(evalutionPublishMsg);
    
    evalutionPublishMsg = [[HttpMessage alloc] initWithDelegate:self
                                                     requestUrl:url
                                                    postDataDic:dic
                                                        cmdCode:CC_EvaluatePublish];
    
    [self.httpMsgCtrl sendHttpMsg:evalutionPublishMsg];
    
    TT_RELEASE_SAFELY(dic);
    
}

//- (void)beginProductDetailEvaluationHttp:(NSString *)partNumbers CurrentPage:(int)currentPage ReviewType:(NSString *)reviewType
//{
//    self.currentPage = currentPage;
//    self.reviewType = reviewType;
//    if ([self.reviewType isEqualToString:@"display"]) {
//        NSString *url = [NSString stringWithFormat:@"%@/%@%@-%@-%@-%@-%@-%@-%@-%@-.html",kEvaluateServerHostJson,@"product_showorders/",partNumbers,@"",@"",partNumbers,@"",@"",@"10",[NSString stringWithFormat:@"%d",currentPage]];
//        HTTPMSG_RELEASE_SAFELY(evalutionProductMsg);
//        
//        evalutionProductMsg = [[HttpMessage alloc] initWithDelegate:self
//                                                         requestUrl:url
//                                                        postDataDic:nil
//                                                            cmdCode:CC_EvaluateProduct];
//        evalutionProductMsg.requestMethod = RequestMethodGet;
//    }
//    else
//    {
//        NSString *url = [NSString stringWithFormat:@"%@/%@%@-%@-%@-%@-%@-%@-%@-%@-%@-.html",kEvaluateServerHostJson,@"product_reviews/",[partNumbers substringToIndex:18],@"",reviewType,@"g",partNumbers,@"",@"",@"10",[NSString stringWithFormat:@"%d",currentPage]];
//        HTTPMSG_RELEASE_SAFELY(evalutionProductMsg);
//    
//        evalutionProductMsg = [[HttpMessage alloc] initWithDelegate:self
//                                                     requestUrl:url
//                                                    postDataDic:nil
//                                                        cmdCode:CC_EvaluateProduct];
//        evalutionProductMsg.requestMethod = RequestMethodGet;
//    }
//    [self.httpMsgCtrl sendHttpMsg:evalutionProductMsg];
//    
//}
//
//- (void)beginProductDetailEvaluationNumberHttp:(NSString *)partNumbers CurrentPage:(int)currentPage ReviewType:(NSString *)reviewType
//{
//    self.currentPage = currentPage;
//    self.reviewType = reviewType;
//    NSString *url = [NSString stringWithFormat:@"%@%@-%@-%@-%@-%@-%@-.html",@"http://zone.suning.com/review/json/productscore_reviewcount/",partNumbers,@"",@"",partNumbers,@"",@""];
//    HTTPMSG_RELEASE_SAFELY(evalutionProductMsg);
//    
//    evalutionProductMsg = [[HttpMessage alloc] initWithDelegate:self
//                                                     requestUrl:url
//                                                    postDataDic:nil
//                                                        cmdCode:CC_EvaluateNumber];
//    evalutionProductMsg.requestMethod = RequestMethodGet;
//    [self.httpMsgCtrl sendHttpMsg:evalutionProductMsg];
//}
//
//- (void)beginProductDetailEvaluationLabelHttp:(NSString *)partNumbers CurrentPage:(int)currentPage ReviewType:(NSString *)reviewType
//{
//    self.currentPage = currentPage;
//    self.reviewType = reviewType;
//    NSString *url = [NSString stringWithFormat:@"%@/%@%@-%@-%@-%@-%@-%@-.html",kEvaluateServerHostJson,@"product_toplabels/",partNumbers,@"",@"",@"",@"",partNumbers];
//    HTTPMSG_RELEASE_SAFELY(evalutionProductMsg);
//    
//    evalutionProductMsg = [[HttpMessage alloc] initWithDelegate:self
//                                                     requestUrl:url
//                                                    postDataDic:nil
//                                                        cmdCode:CC_EvaluateLabel];
//    evalutionProductMsg.requestMethod = RequestMethodGet;
//    [self.httpMsgCtrl sendHttpMsg:evalutionProductMsg];
//}
- (void)beginProductDetailEvaluationHttp:(NSString *)partNumbers CurrentPage:(int)currentPage ReviewType:(int)reviewType
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    self.currentPage = currentPage;
    self.reviewType = reviewType;
    [dic setObject:[NSString stringWithFormat:@"%d",currentPage] forKey:@"currentPage"];
    [dic setObject:@"10" forKey:@"pageSize"];
    [dic setObject:[NSString stringWithFormat:@"%d",reviewType] forKey:@"reviewType"];
    [dic setObject:partNumbers?partNumbers:@"" forKey:@"partNumbers"];
    
    [dic setObject:@"1" forKey:@"supportCStore"];

    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kEvaluateServerHost,@"product_review.htm"];
    
    HTTPMSG_RELEASE_SAFELY(evalutionProductMsg);
    
    evalutionProductMsg = [[HttpMessage alloc] initWithDelegate:self
                                                     requestUrl:url
                                                    postDataDic:dic
                                                        cmdCode:CC_EvaluateProduct];
    [self.httpMsgCtrl sendHttpMsg:evalutionProductMsg];
    
    TT_RELEASE_SAFELY(dic);
    
}


#pragma mark -
#pragma mark -- httpMessage delegate

-(void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    if (receiveMsg.cmdCode == CC_EvaluateList)
    {
        if (_delegate && [_delegate respondsToSelector:@selector(getEvalutionListCompletedWithResult:isLastPage:errorCode:List:number:)])
        {
            if (KPerformance)
            {
                PerformanceStatisticsHttp* temp = [[PerformanceStatisticsHttp alloc] init];
                temp.startTime = [NSDate date];
                temp.functionId = @"4";
                temp.interfaceId = @"404";
                temp.errorType = @"02";
                temp.errorCode = [NSString stringWithFormat:@"%@",receiveMsg.errorCode];
                [[PerformanceStatistics sharePerformanceStatistics]sendCustomNetData:temp];
            }
            [_delegate getEvalutionListCompletedWithResult:NO
                                                isLastPage:NO
                                                 errorCode:self.errorMsg
                                                      List:nil
                                                    number:@""];
        }
    }else if (receiveMsg.cmdCode == CC_EvaluateValidate)
    {
        [self evalutionValidate:NO];
    }else if (receiveMsg.cmdCode == CC_EvaluatePublish)
    {
        [self evalutionPublish:NO];
    }else if(receiveMsg.cmdCode == CC_EvaluateProduct)
    {
        if (_delegate && [_delegate respondsToSelector:@selector(evaluationProductDetailCompletedWithService:isSuccess:errorCode:list:)]) {
            [_delegate evaluationProductDetailCompletedWithService:self
                                                         isSuccess:NO
                                                         errorCode:self.errorMsg
                                                              list:nil];
        }
    }
}


-(void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    if (receiveMsg.cmdCode == CC_EvaluateList)
    {
        NSDictionary *dic = [receiveMsg jasonItems];
        
        if (dic == nil)
        {
            self.errorMsg = kHttpResponseJSONValueFailError;
            
            if (_delegate && [_delegate respondsToSelector:@selector(getEvalutionListCompletedWithResult:isLastPage:errorCode:List:number:)])
            {
                [_delegate getEvalutionListCompletedWithResult:NO
                                                    isLastPage:NO
                                                     errorCode:self.errorMsg
                                                          List:nil
                                                        number:@""];
            }
        }
        
        NSString *errorCode = [dic objectForKey:@"errorMsg"];
        
        if ([errorCode isEqualToString:@""])
        {
            [self parseLogisticsList:dic];
        }
        else
        {
            self.errorMsg = L(@"NWServeBusyTryLater");
            
            if (_delegate && [_delegate respondsToSelector:@selector(getEvalutionListCompletedWithResult:isLastPage:errorCode:List:number:)])
            {
                [_delegate getEvalutionListCompletedWithResult:NO
                                                    isLastPage:NO
                                                     errorCode:self.errorMsg
                                                          List:nil
                                                        number:@""];

            }
        }
    }else if (receiveMsg.cmdCode == CC_EvaluateValidate)
    {
        NSDictionary *dic = [receiveMsg jasonItems];
        self.showReviewStatus = NO;
        if ([[dic objectForKey:@"returnCode"] isEqualToString:@"0"]) {
            if ([[dic objectForKey:@"productReviewStatus"] isEqualToString:@"0"])
            {
                if ([[dic objectForKey:@"shopReviewStatus"] isEqualToString:@"0"]) {
                    self.showReviewStatus = NO;
                }else{
                    self.showReviewStatus = YES;
                }
                [self evalutionValidate:YES];
            }
            else{
                self.errorMsg = L(@"PVHaveEvaluated");
                [self evalutionValidate:NO];
            }
            
        }else{
            self.errorMsg = [dic objectForKey:@"errorMsg"];
            [self evalutionValidate:NO];
        }
        
    }else if (receiveMsg.cmdCode == CC_EvaluatePublish)
    {
        NSDictionary *dic = [receiveMsg jasonItems];
        
        if ([[dic objectForKey:@"returnCode"] isEqualToString:@"0"]) {
            [self evalutionPublish:YES];
        }else{
            self.errorMsg = [dic objectForKey:@"errorMsg"];
            [self evalutionPublish:NO];
        }
    } else if (receiveMsg.cmdCode == CC_EvaluateProduct)
    {
        NSDictionary *dic = [receiveMsg jasonItems];
        
        if (dic == nil)
        {
            self.errorMsg = kHttpResponseJSONValueFailError;
            
            if (_delegate && [_delegate respondsToSelector:@selector(evaluationProductDetailCompletedWithService:isSuccess:errorCode:list:)]) {
                [_delegate evaluationProductDetailCompletedWithService:self
                                                             isSuccess:NO
                                                             errorCode:self.errorMsg
                                                                  list:nil];
            }
        }
        
//        BOOL success = (BOOL)[dic objectForKey:@"success"];
//        
//        if (success)
//        {
//            [self parseProductList:[dic objectForKey:@"data"]];
//        }
        NSString *returnCode = [dic objectForKey:@"returnCode"];
        
        if ([returnCode isEqualToString:@"0"])
        {
            [self parseProductList:dic];
        }
        else
        {
            self.errorMsg = L(@"NWServeBusyTryLater");
            
            if (_delegate && [_delegate respondsToSelector:@selector(evaluationProductDetailCompletedWithService:isSuccess:errorCode:list:)]) {
                [_delegate evaluationProductDetailCompletedWithService:self
                                                             isSuccess:NO
                                                             errorCode:self.errorMsg
                                                                  list:nil];
            }
        }
        
        
//    }else if (receiveMsg.cmdCode == CC_EvaluateNumber)
//    {
//        NSDictionary *dic = [receiveMsg jasonItems];
//        /*
//        if (dic == nil)
//        {
//            self.errorMsg = kHttpResponseJSONValueFailError;
//            
//            if (_delegate && [_delegate respondsToSelector:@selector(evaluationProductDetailCompletedWithService:isSuccess:errorCode:list:)]) {
//                [_delegate evaluationProductDetailCompletedWithService:self
//                                                             isSuccess:NO
//                                                             errorCode:self.errorMsg
//                                                                  list:nil];
//            }
//        }*/
//        
//        BOOL success = (BOOL)[dic objectForKey:@"success"];
//        
//        if (success)
//        {
//            [self parseProductNumberList:[dic objectForKey:@"data"]];
//        }      
//        
//    }else if (receiveMsg.cmdCode == CC_EvaluateLabel)
//    {
//        NSDictionary *dic = [receiveMsg jasonItems];
//        [self parseProductLabelList:dic];
    }
}

-(void)parseLogisticsList:(NSDictionary *)dic
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @autoreleasepool
        {
            
            NSString *totalPageString = [dic objectForKey:@"totalPages"];
            NSString *totalRecords = [dic objectForKey:@"totalRecords"];
            self.totalOrderItemRecords = EncodeStringFromDic(dic, @"totalOrderItemRecords");
            
            if (NotNilAndNull(totalPageString) || ![totalPageString isEqualToString:@""])
            {
                self.totalPage = [totalPageString intValue];
            }else{
                self.totalPage = 1;
            }
            
            //            NSString *currentPageString = [dic objectForKey:@"totalRecords"];
            //
            //            if (NotNilAndNull(currentPageString) || ![currentPageString isEqualToString:@""]) {
            //
            //                self.currentPage = [currentPageString intValue];
            //
            //            }else{
            //
            //                self.currentPage = 1;
            //            }
            
            if (self.currentPage < self.totalPage)
            {
                self.isLastPage = NO;
                
            }else{
                
                self.isLastPage = YES;
            }
            
            
            NSMutableArray *logisticsProductArray = [[NSMutableArray alloc] init];
            
            NSArray *array = [dic objectForKey:@"orderList"];
            
            for(NSDictionary *dtoDic in array)
            {
                EvalutionDTO *logDto = [[EvalutionDTO alloc] init];
                
                [logDto encodeFromDictionary:dtoDic];
                
                [logisticsProductArray addObject:logDto];
                
                TT_RELEASE_SAFELY(logDto);
            }
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (_delegate && [_delegate respondsToSelector:@selector(getEvalutionListCompletedWithResult:isLastPage:errorCode:List:number:)])
                {
                    [_delegate getEvalutionListCompletedWithResult:YES
                                                        isLastPage:self.isLastPage
                                                         errorCode:nil
                                                              List:logisticsProductArray
                                                            number:totalRecords];
                }
            });
        }
    });
}

- (void)parseProductList:(NSDictionary *)dic{
    
    Background_Begin
    
//    NSMutableArray *logisticsProductArray = [[NSMutableArray alloc] init];
//    
//    if ([self.reviewType isEqualToString:@"display"]) {
//        NSArray *array = [dic objectForKey:@"showOrders"];
//        for(NSDictionary *dtoDic in array)
//        {
//            NewProductAppraisial_Json_DTO *logDto = [[NewProductAppraisial_Json_DTO alloc] init];
//            
//            [logDto encodeFromDictionary:dtoDic];
//            
//            [logisticsProductArray addObject:logDto];
//            
//            TT_RELEASE_SAFELY(logDto);
//        }
//    }
//    else
//    {
//        NSArray *array = [dic objectForKey:@"reviews"];
//        for(NSDictionary *dtoDic in array)
//        {
//            NewProductAppraisial_Json_DTO *logDto = [[NewProductAppraisial_Json_DTO alloc] init];
//            
//            [logDto encodeFromDictionary:dtoDic];
//            
//            [logisticsProductArray addObject:logDto];
//            
//            TT_RELEASE_SAFELY(logDto);
//        }
//    }
//    
//    
//    
//    Foreground_Begin
//    if (_delegate && [_delegate respondsToSelector:@selector(evaluationProductDetailCompletedWithService:isSuccess:errorCode:list:)]) {
//        [_delegate evaluationProductDetailCompletedWithService:self
//                                                     isSuccess:YES
//                                                     errorCode:nil
//                                                          list:logisticsProductArray];
//    }
//    Foreground_End
//    Background_End
//}
//
//- (void)parseProductNumberList:(NSDictionary *)dic{
//    Background_Begin
//    NSString *records = [dic objectForKey:@"totalCount"];
//    self.totalNum = [records intValue];
//    
//    NSString *goodEvaluate = [dic objectForKey:@"goodCount"];
//    self.goodNum = goodEvaluate;
//    
//    NSString *midEvaluate = [dic objectForKey:@"normalCount"];
//    self.midNum = midEvaluate;
//    
//    NSString *badEvaluate = [dic objectForKey:@"badCount"];
//    self.badNum = badEvaluate;
//    
//    NSString *displayEvaluate = [dic objectForKey:@"orderShowCount"];
//    self.dispNum = displayEvaluate;
//    if ([self.reviewType isEqualToString:@"total"]) {
//        if (_totalNum%10 == 0) {
//            self.totalPage=_totalNum/10;
//        }
//        else{
//            self.totalPage = _totalNum/10+1;
//        }
//    }
//    else if ([self.reviewType isEqualToString:@"good"]) {
    NSString *records = [dic objectForKey:@"totalRecords"];
    self.totalNum = [records intValue];
    
    NSString *goodEvaluate = [dic objectForKey:@"goodEvaluate"];
    self.goodNum = goodEvaluate;
    
    NSString *midEvaluate = [dic objectForKey:@"midEvaluate"];
    self.midNum = midEvaluate;
    
    NSString *badEvaluate = [dic objectForKey:@"badEvaluate"];
    self.badNum = badEvaluate;
    
    if (self.reviewType == 1) {
        int goodEvaluateNum = [goodEvaluate intValue];
        if (goodEvaluateNum%10 == 0) {
            self.totalPage=goodEvaluateNum/10;
        }
        else{
            self.totalPage = goodEvaluateNum/10+1;
        }
    }
//    else if ([self.reviewType isEqualToString:@"normal"]) {
    else if (self.reviewType == 2) {
        int midEvaluateNum = [midEvaluate intValue];
        if (midEvaluateNum%10 == 0) {
            self.totalPage=midEvaluateNum/10;
        }
        else{
            self.totalPage = midEvaluateNum/10+1;
        }
    }
//    else if ([self.reviewType isEqualToString:@"bad"]) {
    else if (self.reviewType == 3) {
        int badEvaluateNum = [badEvaluate intValue];
        if (badEvaluateNum%10 == 0) {
            self.totalPage=badEvaluateNum/10;
        }
        else{
            self.totalPage = badEvaluateNum/10+1;
        }
    }
//    else if ([self.reviewType isEqualToString:@"display"]) {
//        int displayNum = [displayEvaluate intValue];
//        if (displayNum%10 == 0) {
//            self.totalPage=displayNum/10;
//        }
//        else{
//            self.totalPage = displayNum/10+1;
//        }
//    }
//    
//    Foreground_Begin
//    
//    if (_delegate && [_delegate respondsToSelector:@selector(evaluationProductAppraisialNumberWithService:isSuccess:errorCode:)]) {
//        [_delegate evaluationProductAppraisialNumberWithService:self
//                                                     isSuccess:YES
//                                                     errorCode:nil];
//    }
//    Foreground_End
//    Background_End
//}
//
//- (void)parseProductLabelList:(NSDictionary *)dic{
//    Background_Begin
//    NSArray *labelArr = [dic objectForKey:@"labelList"];
//    for (int i = 0; i < [labelArr count]; i++) {
//        NSString *labelName = [labelArr[i] objectForKey:@"labelName"];
//        [self.labelArr addObject:labelName];
//    }
//    
//    Foreground_Begin
//    
//    if (_delegate && [_delegate respondsToSelector:@selector(evaluationProductAppraisialLabelWithService:isSuccess:errorCode:)]) {
//        [_delegate evaluationProductAppraisialLabelWithService:self
//                                                      isSuccess:YES
//                                                      errorCode:nil];

    
    NSMutableArray *logisticsProductArray = [[NSMutableArray alloc] init];
    
    NSArray *array = [dic objectForKey:@"productReviewList"];
    
    for(NSDictionary *dtoDic in array)
    {
        NewProductAppraisalDTO *logDto = [[NewProductAppraisalDTO alloc] init];
        
        [logDto encodeFromDictionary:dtoDic];
        
        [logisticsProductArray addObject:logDto];
        
        TT_RELEASE_SAFELY(logDto);
    }
    
    Foreground_Begin
    if (_delegate && [_delegate respondsToSelector:@selector(evaluationProductDetailCompletedWithService:isSuccess:errorCode:list:)]) {
        [_delegate evaluationProductDetailCompletedWithService:self
                                                     isSuccess:YES
                                                     errorCode:nil
                                                          list:logisticsProductArray];
    }
    Foreground_End
    Background_End
}

- (void)evalutionPublish:(BOOL)isSuccess
{
    if (_delegate && [_delegate respondsToSelector:@selector(evalutionPublishCompletedWithResult:errorMsg:)]) {
        [_delegate evalutionPublishCompletedWithResult:isSuccess errorMsg:self.errorMsg];
    }
}

- (void)evalutionValidate:(BOOL)isSuccess
{
    if (_delegate && [_delegate respondsToSelector:@selector(evalutionValidateCompletedWithResult:errorMsg:)]) {
        [_delegate evalutionValidateCompletedWithResult:isSuccess errorMsg:self.errorMsg];
    }
}



@end
