//
//  ReturnGoodsListService.m
//  SuningEBuy
//

//  Created by 漫 王 on 12-9-29.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "ReturnGoodsListService.h"

#import "ReturnGoodsListDTO.h"

@implementation ReturnGoodsListService

@synthesize delegate = _delegate;




- (void)httpMsgRelease
{
    
    HTTPMSG_RELEASE_SAFELY(returnGoodsListHttpMsg);
    
    [super httpMsgRelease];
}

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}



- (void)beginSendReturnGoodsListHttpRequest:(NSInteger)currentPage
{
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttp,[@"SNMobileRGOrderitemsListView" passport]];

    NSMutableDictionary  *postDataDic = [[NSMutableDictionary alloc] initWithCapacity:3];
    
    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
    
    [postDataDic setObject:[NSString stringWithFormat:@"%d",currentPage] forKey:@"pageNumber"];
    
    [postDataDic setObject:@"10" forKey:@"pageSize"];
    [postDataDic setObject:@"1" forKey:@"supportCShop"];
    
    HTTPMSG_RELEASE_SAFELY(returnGoodsListHttpMsg);
    
    returnGoodsListHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                        requestUrl:url
                                                       postDataDic:postDataDic
                                                           cmdCode:CC_RetrunGoodsList];
    
    returnGoodsListHttpMsg.requestMethod =RequestMethodGet;
    TT_RELEASE_SAFELY(postDataDic);
    
    [self.httpMsgCtrl sendHttpMsg:returnGoodsListHttpMsg];
    
}


- (void)returnGoodsListOK:(BOOL)isSuccess list:(NSArray *)list page:(SNPageInfo *)page
{
    if ([_delegate respondsToSelector:@selector(returnGoodsListRequestCompletedWith:
                                                retunGoodsList:
                                                pageInfo:
                                                errrorMsg:)])
    {
        
        [_delegate returnGoodsListRequestCompletedWith:isSuccess
                                        retunGoodsList:list
                                              pageInfo:page
                                             errrorMsg:self.errorMsg];
    }
}

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{   
    [super receiveDidFailed:receiveMsg];
    
    [self returnGoodsListOK:NO list:nil page:nil];
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg{
   
    NSDictionary *items = receiveMsg.jasonItems;
    
    if (!items)
    {
        self.errorMsg = kHttpResponseJSONValueFailError;
        [self returnGoodsListOK:NO list:nil page:nil];
    }
    else
    {
        //退货列表信息
        NSArray *datas = [items objectForKey:@"orderitemsList"];
        NSMutableArray *retList = nil;
        if (datas && [datas count] > 0)
        {
            retList = [[NSMutableArray alloc] initWithCapacity:[datas count]];
            for(NSDictionary *dic in datas)
            {
                ReturnGoodsListDTO *dto = [[ReturnGoodsListDTO alloc]init];
                [dto encodeFromDictionary:dic];
                [retList addObject:dto];
                TT_RELEASE_SAFELY(dto);
            }
        }
        
        //分页信息
        NSString *pageSize = [items objectForKey:@"resultSetSize"];
        NSString *totalPage= [items objectForKey:@"totalPages"];
        NSString *currentPage = [items objectForKey:@"pageNumber"];
        
        SNPageInfo pageInfo =
        {
            [currentPage integerValue],
            [totalPage integerValue],
            [pageSize integerValue]
        };

        [self returnGoodsListOK:YES list:retList page:&pageInfo];
    }
}

@end
