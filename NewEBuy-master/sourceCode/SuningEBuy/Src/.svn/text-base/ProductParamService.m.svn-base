//
//  ProductParamService.m
//  SuningEBuy
//
//  Created by  on 12-9-13.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "ProductParamService.h"
#import "ProductParaDTO.h"

@interface ProductParamService()
{
    BOOL    isBook;
}

- (void)parseParamInfo:(NSDictionary *)items;

@end

/*********************************************************************/

@implementation ProductParamService

@synthesize delegate = _delegate;

- (void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(getParamHttpMsg);
}

- (void)beginGetProductParamWithProduct:(DataProductBasic *)product
{
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] initWithCapacity:4];
    
    [postDataDic setObject:(product.productCode == nil ? @"" :product.productCode) 
                    forKey:kHttpResponseProductCode];
	[postDataDic setObject:(product.productId == nil ? @"" : product.productId)
                    forKey:kHttpResponseProductId];	
	[postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
	[postDataDic setObject:kHttpRequestHomeCatalogIdValue forKey:kHttpRequestHomeCatalogIdKey]; 
    
    NSString *parameterURL;
    
    if (product.isABook) {
        parameterURL = [kHostAddressForHttp stringByAppendingFormat:@"/%@",kHttpResponseBookPublishView];
    }else{
        parameterURL = [kHostAddressForHttp stringByAppendingFormat:@"/%@",kHttpRequestProductParameter];
    }
    isBook = product.isABook;
    
    HTTPMSG_RELEASE_SAFELY(getParamHttpMsg);
    
	getParamHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                 requestUrl:parameterURL
                                                postDataDic:postDataDic
                                                    cmdCode:CC_ProductParam];
    getParamHttpMsg.requestMethod = RequestMethodGet;
    [self.httpMsgCtrl sendHttpMsg:getParamHttpMsg];
	
	TT_RELEASE_SAFELY(postDataDic);
}

- (void)getParamDidFinish:(BOOL)isSuccess list:(NSArray *)list
{
    if (_delegate && [_delegate respondsToSelector:@selector(getProductParamCompletionWithResult:errorMsg:paramList:)]) {
        [_delegate getProductParamCompletionWithResult:isSuccess errorMsg:self.errorMsg paramList:list];
    }
}

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    [self getParamDidFinish:NO list:nil];
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    NSDictionary *items = receiveMsg.jasonItems;
    if (!items) {
        self.errorMsg = L(@"SorryNoProductData");
        [self getParamDidFinish:NO list:nil];
    }else{
        BOOL isRequestSuccess;
        if (isBook) {
            NSString *isSuccess = [items objectForKey:@"isSuccess"];
            isRequestSuccess = [isSuccess isEqualToString:@"1"];
        }else{
            isRequestSuccess = [receiveMsg.errorCode isEqualToString:@""];
        }
        
        if (isRequestSuccess) {
            [self parseParamInfo:items];
        }else{
            if ([receiveMsg.errorCode isEqualToString:@"0"]) {
                self.errorMsg = L(@"SorryNoProductData");
            }
            else
            {
                self.errorMsg = L(@"Get_Product_Param_Fail_Error");
            }
            [self getParamDidFinish:NO list:nil];
        }
    }
}

- (void)parseParamInfo:(NSDictionary *)items
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @autoreleasepool {
            NSArray *parameters = [items objectForKey:@"parameters"];
            
            NSMutableArray *retList = nil;
            
            if (parameters && [parameters count] > 0)
            {
                retList = [[NSMutableArray alloc] initWithCapacity:[parameters count]];
                if (isBook)
                {
                    for (NSDictionary *dic in parameters)
                    {
                        ProductParaDTO *dto = [[ProductParaDTO alloc] init];
                        
                        [dto encodeFromDictionary:dic];
                        
                        if (!IsStrEmpty(dto.parameterName) ) {
                            [retList addObject:dto];
                        }
                        
                        TT_RELEASE_SAFELY(dto);
                    }
                }
                else
                {
                    for (NSDictionary *dic in parameters)
                    {
                        ProductParaContentDTO *dto = [[ProductParaContentDTO alloc] init];
                        
                        [dto encodeFromDictionary:dic];
                        
                        if (!IsStrEmpty(dto.attrName) ) {
                            [retList addObject:dto];
                        }
                        
                        TT_RELEASE_SAFELY(dto);
                    }
                }
                
            }

            dispatch_async(dispatch_get_main_queue(), ^{
                [self getParamDidFinish:YES list:retList];
            });

        } 
    });
}

@end
