//
//  ProductAppraisalService.m
//  SuningEBuy
//
//  Created by 正来 崔 on 12-9-20.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "ProductAppraisalService.h"
#import "BookAppraisalDTO.h"
#import "ProductAppraisalDTO.h"

@implementation ProductAppraisalService

@synthesize delegate=_delegate;
@synthesize totalEvaludate=_totalEvaludate;
@synthesize isEvaluatable=_isEvaluatable;
@synthesize appraiseList=_appraiseList;
@synthesize pageInfo = _pageInfo;



- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}
-(void)dealloc{
    
    TT_RELEASE_SAFELY(_appraiseList);
    TT_RELEASE_SAFELY(_isEvaluatable);
}

- (void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(_ProductAppraisalHttpMsg);
    HTTPMSG_RELEASE_SAFELY(_BookAppraisalHttpMsg);
    HTTPMSG_RELEASE_SAFELY(_ValidateHttpMsg);
    
    [super httpMsgRelease];
}
//发送请求普通商品评价的请求
-(void)sendProductAppraisalHttpRequest:(NSString *)productCode
                             ProductId:(NSString *)productId
                           currentPage:(NSInteger)currentPage
                                  type:(NSString *)type
{
    _pageInfo = SNPageInfoZero;
    NSMutableDictionary *postDataDic=[[NSMutableDictionary alloc]init ];
    
    [postDataDic setObject:(productCode==nil?@"":productCode) forKey:kHttpResponseProductCode];
    [postDataDic setObject:(productId==nil?@"":productId) forKey:kHttpResponseProductId];
    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
    [postDataDic setObject:[NSString stringWithFormat:@"%d",currentPage] forKey:KHttpResponseSendPage];
    [postDataDic setObject:type?type:@"" forKey:@"typeFlg"];
    
    HTTPMSG_RELEASE_SAFELY(_ProductAppraisalHttpMsg);
    
    NSString *url = [NSString stringWithFormat:@"%@/%@", kHostAddressForHttp, kHttpResponseEvaluationDo];
    
    _ProductAppraisalHttpMsg=[[HttpMessage alloc]initWithDelegate:self
                                                       requestUrl:url
                                                      postDataDic:postDataDic
                                                          cmdCode:CC_ProductAppraisal];
    _ProductAppraisalHttpMsg.requestMethod=RequestMethodGet;
    [self.httpMsgCtrl sendHttpMsg:_ProductAppraisalHttpMsg];
    
    TT_RELEASE_SAFELY(postDataDic)
}
//根据普通商品评价请求的结果执行代理
-(void)getProductAppraisalFinished:(BOOL)isSuccess
{
    if(self.delegate&&[_delegate respondsToSelector:@selector(ProductAppraisalHttpRequestCompletedWithService:isSucess:errorCode:)]){
        [_delegate ProductAppraisalHttpRequestCompletedWithService:self isSucess:isSuccess errorCode:self.errorMsg];
    }
    
}
//解析普通商品的评价信息
-(void)parseProductAppraisal:(NSDictionary*)items
{
    Background_Begin
    self.appraiseList=nil;
    
    NSArray *searcheList = [items objectForKey:@"searchList"];
    
    if (searcheList&& [searcheList count] > 0)
    {
        NSMutableArray *resultList = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dic in searcheList )
        {
            ProductAppraisalDTO *dto = [[ProductAppraisalDTO alloc] init];
            [dto encodeFromDictionary:dic];
            [resultList addObject:dto];
            TT_RELEASE_SAFELY(dto);
        }
        
        self.appraiseList=resultList;
        
        TT_RELEASE_SAFELY(resultList);
        
    }else{
        
        self.appraiseList=nil;
        
    }
    
    self.totalEvaludate=[[items objectForKey:@"goodEvaluate"]doubleValue]+
    [[items objectForKey:@"midEvaluate"]doubleValue]+[[items objectForKey:@"badEvaluate"]doubleValue];
    //设置分页
    _pageInfo.totalPage = [[items objectForKey:@"totlePage"] intValue];
    
    _pageInfo.currentPage = [[items objectForKey:@"resultCurrentPage"] intValue];
    Foreground_Begin
    [self getProductAppraisalFinished:YES];
    Foreground_End
    
    Background_End
    
}



/*
 *发送图书评价请求
 */
-(void)sendBookAppraisalHttpRequest:(NSString *)productCode
                          ProductId:(NSString *)productId
                        currentPage:(NSInteger)currentPage
                               type:(NSString *)type
{
    _pageInfo = SNPageInfoZero;

    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc]init];
    
    [postDataDic setObject:(productCode == nil ? @"" :productCode)
                    forKey:kHttpResponseProductCode];
    [postDataDic setObject:(productId == nil ? @"" :productId)
                    forKey:kHttpResponseProductId];
    
    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
    
    [postDataDic setObject:[NSString stringWithFormat:@"%d",currentPage] forKey:KHttpResponseSendPage];
    
    [postDataDic setObject:type?type:@"" forKey:@"appraiseLevel"];
    
    [postDataDic setObject:@"22" forKey:@"modelType"];//22表示评价  44表示咨询
    
    [postDataDic setObject:@"5" forKey:@"pageSize"];
    
    
    NSString *url = [NSString stringWithFormat:@"%@/%@", kHostAddressForHttp, @"SNiPhoneBookAppraiseConsultView"];
    
    HTTPMSG_RELEASE_SAFELY(_BookAppraisalHttpMsg);
    
    _BookAppraisalHttpMsg=[[HttpMessage alloc]initWithDelegate:self
                                                    requestUrl:url
                                                   postDataDic:postDataDic
                                                       cmdCode:CC_BookAppraisal];
    _BookAppraisalHttpMsg.requestMethod=RequestMethodGet;
    [self.httpMsgCtrl sendHttpMsg:_BookAppraisalHttpMsg];
    
    TT_RELEASE_SAFELY(postDataDic);
}

-(void)getBookAppraisalFinished:(BOOL)isSuccess
{
    if(self.delegate &&[_delegate respondsToSelector:@selector(BookAppraisalHttpRequestCompletedWithService:isSucess:errorCode:)]){
        [_delegate BookAppraisalHttpRequestCompletedWithService:self isSucess:isSuccess errorCode:self.errorMsg];
    }
    
}
//解析图书商品的评价信息
-(void)parseBookAppraisal:(NSDictionary*)items
{
    Background_Begin
    self.appraiseList=nil;
    NSArray *appraiseList_ = [items objectForKey:@"appraiseList"];
    
    if (appraiseList_ && [appraiseList_ count] > 0)
    {
        NSMutableArray *resultList = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dic in appraiseList_)
        {
            BookAppraisalDTO *dto = [[BookAppraisalDTO alloc] init];
            [dto encodeFromDictionary:dic];
            [resultList addObject:dto];
            TT_RELEASE_SAFELY(dto);
        }
        
        self.appraiseList=resultList;
        
        _pageInfo.totalPage = [[items objectForKey:@"numberOfPages"] intValue];
        _pageInfo.currentPage = [[items objectForKey:@"pageNumber"] intValue];
        _pageInfo.pageSize =[[items objectForKey:@"resultSetSize"] intValue];
        
        
        TT_RELEASE_SAFELY(resultList);
    }else
    {
        self.appraiseList=nil;
    }
    Foreground_Begin
    
    [self getBookAppraisalFinished:YES];
    Foreground_End
    
    Background_End
}

-(void)sendValidateHttpRequest:(NSString *)productCode
{
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
    
    [postDataDic setObject:(productCode == nil ? @"" : productCode)
                    forKey:@"partNumber"];
    
    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@", kHostAddressForHttp, @"SNMobileCanPublishArticle"];
    
    HTTPMSG_RELEASE_SAFELY(_ValidateHttpMsg);
    
    _ValidateHttpMsg = [[HttpMessage alloc]initWithDelegate:self
                                                 requestUrl:url
                                                postDataDic:postDataDic
                                                    cmdCode:CC_Validate];
    
    [self.httpMsgCtrl sendHttpMsg:_ValidateHttpMsg];
    
    TT_RELEASE_SAFELY(postDataDic);
}

-(void)getValidateFinished:(BOOL)isSuccess
{
    if(self.delegate &&[_delegate respondsToSelector:@selector(ValidateHttpRequestCompletedWithService:isSuccess:)]){
        [_delegate ValidateHttpRequestCompletedWithService:self isSuccess:isSuccess];
    }
    
}

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    switch (receiveMsg.cmdCode) {
        case CC_ProductAppraisal:
        {
            [self getProductAppraisalFinished:NO];
            break;
        }
        case CC_BookAppraisal:
        {
            [self getBookAppraisalFinished:NO];
            break;
        }
        case CC_Validate:
        {
            [self getValidateFinished:NO];
            break;
        }
        default:
            break;
    }
}

-(void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    NSDictionary *items=receiveMsg.jasonItems;
    NSString *errorCode=[items objectForKey:@"errorCode"];
    
    if(receiveMsg.cmdCode==CC_ProductAppraisal)
    {
        if([errorCode isEqualToString:@""])
        {
            [self parseProductAppraisal:items];
        }
        else
        {
            self.errorMsg=kHttpResponseJSONValueFailError;
            [self getProductAppraisalFinished:NO];
        }
        
    }
    else if(receiveMsg.cmdCode==CC_BookAppraisal)
    {
        if(![errorCode isEqualToString:@""])
        {
            receiveMsg.errorCode=kHttpResponseJSONValueFailError;
            [self getBookAppraisalFinished:NO];
        }
        else
        {
            [self parseBookAppraisal:items];
        }
    }
    else if(receiveMsg.cmdCode==CC_Validate)
    {
        if(!items){
            receiveMsg.errorCode=kHttpResponseJSONValueFailError;
            [self getValidateFinished:NO];
        }
        else{
            self.isEvaluatable=[items objectForKey:@"isEvaluatable"];
            [self getValidateFinished:YES];
        }
    }
}


@end
