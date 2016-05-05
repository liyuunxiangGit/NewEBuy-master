//
//  ProductConsultantListService.m
//  SuningEBuy
//
//  Created by 漫 王 on 12-9-24.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "ProductConsultantService.h"

#import "ProductConsultantDTO.h"


#define kHttpRequestConsultantValue     @"24"   // 咨询

@implementation ProductConsultantService

@synthesize product = _product;

@synthesize productConstantList = _productConstantList;

@synthesize delegate = _delegate;

@synthesize pageInfo = _pageInfo;


- (void)dealloc {
    
    TT_RELEASE_SAFELY(_product);
    
    TT_RELEASE_SAFELY(_productConstantList);
    
    TT_RELEASE_SAFELY(_errorMsg);
        
}


- (id)init {
    self = [super init];
    if (self) {
        
        if (!_productConstantList) {
            
            _productConstantList = [[NSMutableArray alloc]init];
        }
    }
    
    return self;
}

- (void)httpMsgRelease{
    
    
    HTTPMSG_RELEASE_SAFELY(_productConstantMsg);
    
    [super httpMsgRelease];
}

//根据传入的商品信息和当前页数发送商品咨询请求
//1.图书咨询请求
//2.电器商品咨询请求
- (void)beginProductConstantListHttpRequest:(DataProductBasic *)product currentPage:(NSInteger)currentPage {
    
    if (!_product) {
        
        self.product = product;
    }
    
    if (product.isABook) {//图书咨询请求
        
        NSMutableDictionary  *postDataDic = [[NSMutableDictionary alloc]init];
        
        [postDataDic setObject:(product.productId == nil ? @"":product.productId)  forKey:kHttpResponseProductId];
        
        [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
        
        [postDataDic setObject:kHttpRequestConsultantValue forKey:kHttpRequestModelTypeKey];
        
        [postDataDic setObject:[NSString stringWithFormat:@"%d", currentPage] forKey:KHttpResponseSendPage];
        
        // 咨询接口
        NSString *url = [NSString stringWithFormat:@"%@/%@", kHostAddressForHttps, kHttpRequestBookAppraiseConsultKey];
        
        HTTPMSG_RELEASE_SAFELY(_productConstantMsg);
        
        
        _productConstantMsg = [[HttpMessage alloc]initWithDelegate:self requestUrl:url postDataDic:postDataDic cmdCode:CC_BookConstant];
        
        _productConstantMsg.requestMethod =RequestMethodGet;
        TT_RELEASE_SAFELY(postDataDic);
        
        [self.httpMsgCtrl sendHttpMsg:_productConstantMsg];
    }
    else{//电器商品咨询请求
        
        NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc]init];
        
        
        [postDataDic setObject:(product.productCode == nil ? @"":product.productCode) forKey:kHttpResponseProductCode];
        
        [postDataDic setObject:(product.productId == nil ? @"":product.productId) forKey:kHttpResponseProductId];
        
        [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
        
        [postDataDic setObject:kHttpRequestHomeCatalogIdValue forKey:kHttpRequestHomeCatalogIdKey];
        
        [postDataDic setObject:[NSString stringWithFormat:@"%d", currentPage] forKey:KHttpResponseSendPage];
        
        NSString *url = [NSString stringWithFormat:@"%@/%@", kHostAddressForHttp, kHttpResponseConsultDo];
        
        HTTPMSG_RELEASE_SAFELY(_productConstantMsg);
        
        _productConstantMsg = [[HttpMessage alloc]initWithDelegate:self requestUrl:url postDataDic:postDataDic cmdCode:CC_ApplianceConstant];
        _productConstantMsg.requestMethod=RequestMethodGet;
        TT_RELEASE_SAFELY(postDataDic);
        
        [self.httpMsgCtrl sendHttpMsg:_productConstantMsg];
        
    }
}


- (void)productConstant:(BOOL)isSuccess{
    
    if (isSuccess == NO) {
        
        if (self.delegate && [_delegate respondsToSelector:@selector(productConstantCompletedWithResult:ProductConstantList:pageInfo:errorMsg:)]) {
            
            [_delegate productConstantCompletedWithResult:NO ProductConstantList:nil pageInfo:_pageInfo errorMsg:self.errorMsg];
            
        }
    }
    else{
        
        if (self.delegate && [_delegate respondsToSelector:@selector(productConstantCompletedWithResult:ProductConstantList:pageInfo:errorMsg:)]) {
            
            [_delegate productConstantCompletedWithResult:YES ProductConstantList:_productConstantList pageInfo:_pageInfo errorMsg:self.errorMsg];
            
        }
    }
}
        

- (void)receiveDidFailed:(HttpMessage *)receiveMsg{
    
    if (receiveMsg.cmdCode == CC_BookConstant ||receiveMsg.cmdCode == CC_ApplianceConstant) {
    
        [self productConstant:NO];
     
    self.errorMsg = @"netWork not aviliable, please restart";
    }
        
    [super receiveDidFailed:receiveMsg];
    
}

//解析商品咨询请求结果
//1.图书咨询数据解析
//2.电器商品咨询数据解析
- (void)productConstantRequestOK:(HttpMessage *)receiveMsg{
    
    NSDictionary *item = receiveMsg.jasonItems;
    
    NSString *errorCode;
    
    if (item ==nil || [item isEqual:[NSNull null]] || [item count] == 0) {
        
        self.errorMsg = @"no more product";
        
        [self productConstant:NO];
    }
    
    errorCode = [item objectForKey:@"erroCode"];
    
    if (errorCode && ![errorCode isEqual:@""]) {
        
        self.errorMsg = @"product not correct";
        
        [self productConstant:NO];
    }
    
    
    NSArray *consultantList = [item objectForKey:@"consultantList"];
    
    if (!_product.isABook) {
        
        consultantList = [item objectForKey:@"searchList"];
    }
    
    TT_RELEASE_SAFELY(_productConstantList);
    
    _productConstantList = [[NSMutableArray alloc]init];
    
    if (consultantList && [consultantList count] >0 ) {
        
        for (NSDictionary *dic in consultantList)
        {
            
            ProductConsultantDTO *dto = [[ProductConsultantDTO alloc]init];
            
            if (_product.isABook) {//图书咨询
                
                 [dto encodeFromBooksDictionary:dic];
            }
            else{//电器商品咨询
            
                [dto encodeFromApplianceDictionary:dic];
            }
            
            [_productConstantList addObject:dto];
            
             TT_RELEASE_SAFELY(dto); 
        }
        
    }
    
    SNPageInfo pageInfo_;
    
  
    if (_product.isABook) {
        
        pageInfo_.currentPage = [NotNilAndNull([item objectForKey:@"pageNumber"]) ? [item objectForKey:@"pageNumber"] : @"0" intValue];
        
        pageInfo_.totalPage = [NotNilAndNull([item objectForKey:@"numberOfPages"]) ? [item objectForKey:@"numberOfPages"] : @"0" intValue];
        
        pageInfo_.pageSize =  [NotNilAndNull([item objectForKey:@"resultSetSize"]) ? [item objectForKey:@"resultSetSize"] : @"0" intValue];
      
    }else{
        
        pageInfo_.currentPage = [NotNilAndNull([item objectForKey:@"resultCurrentPage"]) ? [item objectForKey:@"resultCurrentPage"] : @"0" intValue];
        
        pageInfo_.totalPage = [NotNilAndNull([item objectForKey:@"totlePage"]) ? [item objectForKey:@"totlePage"] : @"0" intValue];
        
        pageInfo_.pageSize =  [NotNilAndNull([item objectForKey:@"resultNumber"]) ? [item objectForKey:@"resultNumber"] : @"0" intValue];
        
    }
    _pageInfo = pageInfo_;
    
    [self productConstant:YES];
}


- (void)receiveDidFinished:(HttpMessage *)receiveMsg{
    
    if (receiveMsg.cmdCode == CC_BookConstant ||receiveMsg.cmdCode == CC_ApplianceConstant) {
        
        [self productConstantRequestOK:receiveMsg];
        
    }
}

@end
