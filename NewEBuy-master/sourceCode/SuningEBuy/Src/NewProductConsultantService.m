//
//  NewProductConsultantService.m
//  SuningEBuy
//
//  Created by 漫 王 on 12-9-26.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "NewProductConsultantService.h"

@implementation NewProductConsultantService

@synthesize  delegate = _delegate;

- (id)init {
    self = [super init];
    if (self) {
    }
    return self;
}



- (void)httpMsgRelease{

    HTTPMSG_RELEASE_SAFELY(_newProductConsultantHttpMsg);
    
    [super httpMsgRelease];
}


- (void) beginSendNewProductConsultantHttpRequest:(DataProductBasic*) product text:(NSString *)text{
    
    NSString            *url = [NSString stringWithFormat:@"%@/%@", kHostAddressForHttps, kHttpRequestGetPublishArticleKey];

    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc]init];
    
    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];

    if (product.isABook) {
        
         [postDataDic setObject:kHttpRequestBookCatalogIdValue forKey:kHttpRequestHomeCatalogIdKey];
    }
    else{
        
    [postDataDic setObject:kHttpRequestHomeCatalogIdValue forKey:kHttpRequestHomeCatalogIdKey];
        
    }
    
    [postDataDic setObject:(product.productId ? product.productId : @"") forKey:KHttpRequestProductId];
    
    [postDataDic setObject:@"5" forKey:kHttpRequestModelTypeKey];
    
    [postDataDic setObject:@"0" forKey:@"artType"];
    
    [postDataDic setObject:@"购买咨询" forKey:@"title"];
    
    [postDataDic setObject:(text ? text : @"") forKey:kHttpRequestContentKey];
    
    HTTPMSG_RELEASE_SAFELY(_newProductConsultantHttpMsg);
    
    _newProductConsultantHttpMsg = [[HttpMessage alloc]initWithDelegate:self requestUrl:url postDataDic:postDataDic cmdCode:CC_New_Consultant];
    
    TT_RELEASE_SAFELY(postDataDic);
    
    [self.httpMsgCtrl sendHttpMsg:_newProductConsultantHttpMsg];
    
}

- (void)receiveDidFailed:(HttpMessage *)receiveMsg{

    if (receiveMsg.cmdCode == CC_New_Consultant) {
        
        self.errorMsg = @"Sorry loading failed";
        
        if (_delegate && [_delegate respondsToSelector:@selector(newProductConsultantCompleted:errorMsg:)]) {
            
            [_delegate newProductConsultantCompleted:NO errorMsg:self.errorMsg];
        }
    }
    
    [super receiveDidFailed:receiveMsg];
}

//发送发表商品咨询请求成功后处理
//1.发表成功
//2.发表失败
- (void)receiveDidFinished:(HttpMessage *)receiveMsg{
    
    if (receiveMsg.cmdCode == CC_New_Consultant) {
        
        NSDictionary   *items = receiveMsg.jasonItems;
        
        NSString *errorCode = [items objectForKey:@"isSuccess"];
        
        if ([errorCode isEqualToString:@"1"]) {
            
            self.errorMsg = @"Advisory success";
            
        }else{
            
            NSString *errorCode = [items objectForKey:@"errorCode"];
        
            if (errorCode == nil || [errorCode isEqualToString:@""]) {
                
                self.errorMsg = @"Advisory failed";
            }else{
                
                self.errorMsg = [items objectForKey:@"errorCode"];
            }
        }
        
        
        if (_delegate && [_delegate respondsToSelector:@selector(newProductConsultantCompleted:errorMsg:)]) {
            
            [_delegate newProductConsultantCompleted:YES errorMsg:self.errorMsg];
        }
    }
}
@end
