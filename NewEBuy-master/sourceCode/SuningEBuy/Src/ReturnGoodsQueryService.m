//
//  ReturnGoodsQueryService.m
//  SuningEBuy
//
//  Created by 漫 王 on 12-9-28.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "ReturnGoodsQueryService.h"

#import "ReturnGoodsQueryDTO.h"
#import "CShopReturnGoodsDTO.h"


@implementation ReturnGoodsQueryService

@synthesize returnGoodList = _returnGoodList;

@synthesize delegate = _delegate;

@synthesize pageInfo = _pageInfo;

- (void)dealloc {
    
    TT_RELEASE_SAFELY(_returnGoodList);
    
}


- (void)httpMsgRelease{
    
    HTTPMSG_RELEASE_SAFELY(_returnGoodsQueryHttpMsg);
    
    [super httpMsgRelease];
}

- (id)init {
    self = [super init];
    
    if (self) {
        
        _returnGoodList = [[NSMutableArray alloc]init];
        
    }
    return self;
}

- (void)beginSendReturnGoodsQueryHttpRequest:(NSInteger)currentPage storeId:(NSString*)aStoreId
{
    if (IsStrEmpty(aStoreId))
    {
        aStoreId = @"10052";
    }
    
    NSString  *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttp,@"SNMobileReturnGoodsQueryDetailView"];
    
    NSMutableDictionary  *postDataDic = [[NSMutableDictionary alloc]init];
    
    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
    [postDataDic setObject:aStoreId forKey:@"storeId"];
    
    [postDataDic setObject:[NSString stringWithFormat:@"%d",currentPage] forKey:@"pageNum"];
    [postDataDic setObject:@"10" forKey:@"pageSize"];
    [postDataDic setObject:@"1" forKey:@"supportCshop"];
    
    HTTPMSG_RELEASE_SAFELY(_returnGoodsQueryHttpMsg);
    
    _returnGoodsQueryHttpMsg = [[HttpMessage alloc]initWithDelegate:self requestUrl:url postDataDic:postDataDic cmdCode:CC_ReturnGoodsQuery];
    _returnGoodsQueryHttpMsg.requestMethod =RequestMethodGet;
    TT_RELEASE_SAFELY(postDataDic);
    
    [self.httpMsgCtrl sendHttpMsg:_returnGoodsQueryHttpMsg];
}

- (void)beginSendReturnGoodsQueryHttpRequest:(NSInteger)currentPage{
    
    NSString  *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttp,[@"SNMobileReturnGoodsQueryDetailView" passport]];
    
    NSMutableDictionary  *postDataDic = [[NSMutableDictionary alloc]init];
    
    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
    
    [postDataDic setObject:[NSString stringWithFormat:@"%d",currentPage] forKey:@"pageNum"];
    
    [postDataDic setObject:@"10" forKey:@"pageSize"];
    [postDataDic setObject:@"1" forKey:@"supportCshop"];
    
    HTTPMSG_RELEASE_SAFELY(_returnGoodsQueryHttpMsg);
    
    _returnGoodsQueryHttpMsg = [[HttpMessage alloc]initWithDelegate:self requestUrl:url postDataDic:postDataDic cmdCode:CC_ReturnGoodsQuery];
    
    TT_RELEASE_SAFELY(postDataDic);
    
    [self.httpMsgCtrl sendHttpMsg:_returnGoodsQueryHttpMsg];
}

-(void)returnGoods:(BOOL)isSuccess
{
    if (isSuccess == NO) {
        
        if ( [_delegate respondsToSelector:@selector(returnGoodsCompletedWith:errorMsg:)]) {
            
            [_delegate returnGoodsCompletedWith:NO errorMsg:self.errorMsg];
        }
    }
    else
    {
        
        if ( [_delegate respondsToSelector:@selector(returnGoodsCompletedWith:errorMsg:)]) {
            
            [_delegate returnGoodsCompletedWith:YES  errorMsg:self.errorMsg];
        }
        
    }

}

- (void)returnGoodsQueryOK:(BOOL)isSuccess{
    
    if (isSuccess == NO) {
        
        if ( [_delegate respondsToSelector:@selector(returnGoodsQueryHttpRequestCompletedWith:returnGoodList:pageInfo:returnexpresslist:errorMsg:)]) {
            
            [_delegate returnGoodsQueryHttpRequestCompletedWith:NO returnGoodList:nil  pageInfo:_pageInfo returnexpresslist:nil errorMsg:self.errorMsg];
        }
    }
    else
    {
        
        if ( [_delegate respondsToSelector:@selector(returnGoodsQueryHttpRequestCompletedWith:returnGoodList:pageInfo:returnexpresslist:errorMsg:)]) {
            
            [_delegate returnGoodsQueryHttpRequestCompletedWith:YES returnGoodList:_returnGoodList pageInfo:_pageInfo returnexpresslist:_returnexpresslist errorMsg:self.errorMsg];
        }
        
    }
}

- (void)receiveDidFailed:(HttpMessage *)receiveMsg{
    
    [super receiveDidFailed:receiveMsg];
    
    if (receiveMsg.cmdCode == CC_ReturnGoodsQuery) {
        
        [self returnGoodsQueryOK:NO];
    }
    else if (receiveMsg.cmdCode == CC_ReturnCShopGoodsExpress){
        [self returnGoods:NO];
    }
}


- (void)receiveDidFinished:(HttpMessage *)receiveMsg{
    
    NSDictionary *items = receiveMsg.jasonItems;
    
    if (receiveMsg.cmdCode == CC_ReturnGoodsQuery)
    {
        NSString *isSucces = EncodeStringFromDic(items, @"isSuccess");

        if ([isSucces isEqualToString:@"1"])
        {
            
            
            NSArray *returnGoodList = EncodeArrayFromDicUsingParseBlock(items, @"itemsList", ^id(NSDictionary *innerDic) {
                
                ReturnGoodsQueryDTO *dto = [[ReturnGoodsQueryDTO alloc]init];
                [dto encodeFromDictionary:innerDic];
                return dto;
            });
            self.returnGoodList = [returnGoodList mutableCopy];
            
            NSArray *expressList = EncodeArrayFromDicUsingParseBlock(items, @"expressList", ^id(NSDictionary *innerDic) {
                
                CShopReturnGoodsDTO *dto = [[CShopReturnGoodsDTO alloc]init];
                [dto encodeFromDictionary:innerDic];
                return dto;
            });
            self.returnexpresslist = [expressList mutableCopy];
            
            
            SNPageInfo pageInfo_ = SNPageInfoMake
            (EncodeStringFromDic(items, @"pageNumber").integerValue,
             EncodeStringFromDic(items, @"totalPages").integerValue,
             EncodeStringFromDic(items, @"pageSize").integerValue) ;
            
            self.pageInfo = pageInfo_;
            
            [self returnGoodsQueryOK:YES];
            
        }
        else
        {
            self.errorMsg = kHttpResponseJSONValueFailError;
            [self returnGoodsQueryOK:NO];
        }

    }
    else if (receiveMsg.cmdCode == CC_ReturnCShopGoodsExpress)
    {
        NSString *isSucces = EncodeStringFromDic(items, @"isSuccess");
        if ([isSucces isEqualToString:@"1"])
        {
            [self returnGoods:YES];
        }
        else
        {
            NSString *errorMsg = EncodeStringFromDic(items, @"errorDesc");
            self.errorMsg = errorMsg.length?errorMsg:kSERVERBUSY_ERRORDESC;
            [self returnGoods:NO];
        }
    }
}
//c店确认退货
- (void)confirmReturnGoods:(CShopReturnGoodsDTO *)dto
              orderItemsId:(NSString *)orderItemsId
                expressNum:(NSString *)expressNum
               companyName:(NSString *)companyName
             expressDetail:(NSString *)expressDetail{
 
    NSString  *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttp,[@"SNMTConfirmReturnGoods" passport]];
    NSMutableDictionary  *postDic = [[NSMutableDictionary alloc]init];
    
    [postDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
    [postDic setObject:orderItemsId?orderItemsId:@"" forKey:@"orderItemId"];
    
    if (dto)
    {
        [postDic setObject:dto.expressId?dto.expressId:@"" forKey:@"expressId"];
    }
    else
    {
        [postDic setObject:companyName?companyName:@"" forKey:@"companyName"];
    }
    
    [postDic setObject:expressNum?expressNum:expressNum forKey:@"expressNum"];
    
    [postDic setObject:IsStrEmpty(expressDetail)?@"":expressDetail forKey:@"expressDetail"];
    HTTPMSG_RELEASE_SAFELY(_returnGoodsQueryHttpMsg);
    
    _returnGoodsQueryHttpMsg = [[HttpMessage alloc]initWithDelegate:self requestUrl:url postDataDic:postDic cmdCode:CC_ReturnCShopGoodsExpress];
    
    TT_RELEASE_SAFELY(postDic);
    
    [self.httpMsgCtrl sendHttpMsg:_returnGoodsQueryHttpMsg];
}
@end
