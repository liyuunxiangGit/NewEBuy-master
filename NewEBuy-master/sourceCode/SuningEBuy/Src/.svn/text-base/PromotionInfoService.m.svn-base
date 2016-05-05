//
//  PromotionInfoService.m
//  SuningEBuy
//
//  Created by huangtf on 12-9-4.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "PromotionInfoService.h"
#import "PromotionInfoDTO.h"

#pragma mark -
#pragma mark 资讯接口请求参数

#define kHttpRequestInfoAreaName                 @"areaName"
#define vHttpRequestInfoAreaName                 @"Suningzixun"
#define kHttpRequestInfoPageSize                 @"pageSize"
#define vHttpRequestInfoPageSize                 @"20"
#define kHttpRequestInfoPageNumber               @"pageNumber"

#pragma mark -
#pragma mark 资讯接口应用数据
#define kHttpResponseInfoCurrentPage             @"currentPage"
#define kHttpResponseInfoPagesCount              @"pagesCount"
#define kHttpResponseInfoShowList                @"showList"


#define kPromotionInfoLblTag                     10000



@implementation PromotionInfoService

@synthesize delegate=_delegate;

-(void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(PromotionInfoListMessage);
}


-(void)beginGetPromotionInfoListWithPageNum:(NSString *)pageNum 
                                   PageSize:(NSString *)pageSize
{
        // 固定值
	NSMutableDictionary *postDataDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                        kHttpRequestHomeStoreValue,kHttpRequestHomeStoreKey,
                                        vHttpRequestInfoAreaName,kHttpRequestInfoAreaName,
                                         nil];
	    // 访问页码
    [postDataDic setObject:pageNum?pageNum:@"1" forKey:kHttpRequestInfoPageNumber];
	NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttp,kHttpRequestPromotionInfoView];

    HTTPMSG_RELEASE_SAFELY(PromotionInfoListMessage);
    
    PromotionInfoListMessage = [[HttpMessage alloc] initWithDelegate:self requestUrl:url postDataDic:postDataDic cmdCode:CC_PromotionInfo];  

    [self.httpMsgCtrl sendHttpMsg:PromotionInfoListMessage];
    
}



- (void)getListDidFinish:(BOOL)isSuccess
                    list:(NSMutableArray *)list 
               totalPage:(NSInteger)tPage 
             currentPage:(NSInteger)currPage
{
    
    if (_delegate && [_delegate respondsToSelector:@selector(getPromotionInfoListWithSuccess:errorMsg:PromotionInfoList:totalPage:currentPage:)]) {
        [_delegate getPromotionInfoListWithSuccess:isSuccess 
                                          errorMsg:self.errorMsg 
                                 PromotionInfoList:list
                                         totalPage:tPage 
                                       currentPage:currPage];
    }



}
-(void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    NSDictionary *items = receiveMsg.jasonItems;

    if (!items)
    {
        self.errorMsg = kHttpResponseJSONValueFailError;
        [self getListDidFinish:NO list:nil totalPage:0 currentPage:0];
        return;
    }
    
    [self parsePromotionInfoListData:items ];
}

-(void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    [self getListDidFinish:NO list:nil totalPage:0 currentPage:0];

}

-(void)parsePromotionInfoListData:(NSDictionary *)items
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        @autoreleasepool {
            NSArray *array = [items objectForKey:kHttpResponseInfoShowList];
            
            NSMutableArray *retArray = nil;
            
            if(array != nil && [array count] > 0){
                
                retArray = [[NSMutableArray alloc] init];
                
                for(NSDictionary *dic in array){
                    
                    PromotionInfoDTO *dto = [[PromotionInfoDTO alloc] init];
                    
                    [dto encodeFromDictionary:dic];
                    
                    [retArray addObject:dto];
                    
                }
                
            }
            
            NSInteger totalPage =[[items objectForKey:kHttpResponseInfoPagesCount] integerValue];
            
            NSInteger currentPage = [[items objectForKey:kHttpResponseInfoCurrentPage] integerValue];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self getListDidFinish:YES list:retArray totalPage:totalPage currentPage:currentPage];
            });
        }
        
    });
    
    
}

@end
