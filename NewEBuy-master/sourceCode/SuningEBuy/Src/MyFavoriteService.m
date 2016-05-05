//
//  MyFavoriteService.m
//  SuningEBuy
//
//  Created by huangtf on 12-8-29.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "MyFavoriteService.h"
#import "MyFavoriteViewController.h"
#import "MyFavoriteCell.h"


#define kHttpRequestFavoritePageNumber          @"pageNumber"
#define kHttpResponseFavoriteCurrentPage        @"currentPage"
#define kHttpResponseFavoriteNumberOfPages      @"pagesCount"

@interface MyFavoriteService()
- (void)parseFavoriteListData:(NSDictionary *)items;


@end


@implementation MyFavoriteService

@synthesize delegate = _delegate;

- (void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(favoriteListHttpMsg);
    HTTPMSG_RELEASE_SAFELY(favoriteListDeleteMsg);
}

- (void)beginGetMyFavoriteListWithPageNum:(NSString *)pageNum withListsize:(NSString *)listSize
{
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] initWithCapacity:2];
    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
    [postDataDic setObject:pageNum?pageNum:@"" forKey:kHttpRequestFavoritePageNumber];
    [postDataDic setObject:IsStrEmpty(listSize)?@"10":listSize forKey:@"listsize"];
    [postDataDic setObject:@"1" forKey:@"supportCshop"];
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttps,kHttpRequestMemberMyFavorite];
    
    HTTPMSG_RELEASE_SAFELY(favoriteListHttpMsg);
    
    favoriteListHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                     requestUrl:url
                                                    postDataDic:postDataDic
                                                        cmdCode:CC_MyFavorite];
    favoriteListHttpMsg.requestMethod = RequestMethodGet;
    [self.httpMsgCtrl sendHttpMsg:favoriteListHttpMsg];
    
    TT_RELEASE_SAFELY(postDataDic);
}

- (void)deleteMyFavoriteFinish:(BOOL)isSuccess
{
    if (_delegate && [_delegate respondsToSelector:@selector(getDeleteMyFavoriteCompletionWith:errorMsg:)]) {
        [_delegate getDeleteMyFavoriteCompletionWith:isSuccess errorMsg:self.errorMsg];
    }
}

- (void)getListDidFinish:(BOOL)isSuccess
                    list:(NSArray *)list 
               totalPage:(NSInteger)tPage 
             currentPage:(NSInteger)currPage
{
    if (_delegate && [_delegate respondsToSelector:@selector(getMyFavoriteCompletionWith:errorMsg:favoriteList:totalPage:currentPage:)]) {
        [_delegate getMyFavoriteCompletionWith:isSuccess errorMsg:self.errorMsg favoriteList:list totalPage:tPage currentPage:currPage];
    }
}

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    if (receiveMsg.cmdCode == CC_MyFavorite) {
        [self getListDidFinish:NO list:nil totalPage:0 currentPage:0];
    }
    else
    {
        [self deleteMyFavoriteFinish:NO];    
    }
}


- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    NSDictionary *items = receiveMsg.jasonItems;
    if (receiveMsg.cmdCode == CC_MyFavorite) {
        if (!items) 
        {
            self.errorMsg = kHttpResponseJSONValueFailError;
            [self getListDidFinish:NO list:nil totalPage:0 currentPage:0];

            return;
        }
        
        if ([receiveMsg.errorCode isEqualToString:@""]||[receiveMsg.errorCode isEqualToString:@"0"]) {
            
            [self parseFavoriteListData:receiveMsg.jasonItems];
            
        }
        else
        {
            self.errorMsg = L(@"NoMoreCollection");
            [self getListDidFinish:NO list:nil totalPage:0 currentPage:0];

        }

    }
    else
    {
        if (!items) {
            self.errorMsg = kHttpResponseJSONValueFailError;
            [self deleteMyFavoriteFinish:NO];
            return;
        }
        if ([receiveMsg.errorCode isEqualToString:@""]) {
            [self deleteMyFavoriteFinish:YES];

        }
        else{
            self.errorMsg = receiveMsg.errorCode;
            [self deleteMyFavoriteFinish:NO];

        
        }
    
    }
}

- (void)parseFavoriteListData:(NSDictionary *)items
{
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        @autoreleasepool {
            NSArray *array = [items objectForKey:kResponseMemberMyFavoriteList];
            
            NSMutableArray *retArray = nil;
            
            if(array != nil && [array count] > 0){
                
                retArray = [[NSMutableArray alloc] init];
                
                for(NSDictionary *dic in array){
                    
                    DataProductBasic *dto = [[DataProductBasic alloc] init];
                    
                    [dto encodeFromDictionary:dic];
                    
                    [retArray addObject:dto];
                    
                }
                
            }
            
            NSInteger totalPage =[[items objectForKey:kHttpResponseFavoriteNumberOfPages] integerValue];
            
            NSInteger currentPage = [[items objectForKey:kHttpResponseFavoriteCurrentPage] integerValue];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self getListDidFinish:YES list:retArray totalPage:totalPage currentPage:currentPage];
            });
        }
        
    });
}





-(void)parseDeleteFavoriteListOk:(NSArray *)array
{



}




-(void)beginDeleteMyFavoriteList:(DataProductBasic *)dto
{
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] initWithCapacity:3];
    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
    [postDataDic setObject:dto.productId?dto.productId:@"" forKey:kHttpRequestMemberCatEntryIdKey];
    [postDataDic setObject:dto.vendorCode forKey:@"vendorCode"];
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttps,kHttpRequestMemberClearMyFavorite];    
    HTTPMSG_RELEASE_SAFELY(favoriteListDeleteMsg);
    favoriteListDeleteMsg = [[HttpMessage alloc]initWithDelegate:self
                                                requestUrl:url
                                                postDataDic:postDataDic 
                                                         cmdCode:CC_MyFavoriteDelete];
    [self.httpMsgCtrl sendHttpMsg:favoriteListDeleteMsg];
    TT_RELEASE_SAFELY(postDataDic);
}


@end
