//
//  ProductDisorderListService.m
//  SuningEBuy
//
//  Created by 正来 崔 on 12-9-25.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "ProductDisorderListService.h"
#import "DisProductDetailsDTO.h"

@implementation ProductDisorderListService

@synthesize delegate=_delegate;


-(id)init
{
    self =[super init];
    if(self)
    {
        
    }
    return  self;
}


-(void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(_disorderListHttpMsg);
    
}

//mmd5加密，加密的内容为 《"IPHONE"+商品id》
-(NSString *)mmdFiveVerifyCode:(NSString *)str
{
    
    NSString *mdddd = [NSString stringWithFormat:@"IPHONE%@",str];
	
    NSString *tempString = [GetAllSysInfo md5:mdddd];
    
    DLog(@"mmd5String =  %@", [tempString lowercaseString]);
    
    return [tempString lowercaseString];
}

-(void)sendDisorderListHttpRequest:(NSString *)productId currentPage:(NSInteger)currentPage
{
 
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] initWithCapacity:4];
    //组装请求参数
    NSString *verifyCode = [self mmdFiveVerifyCode:productId];
    
    NSString *tempCurrentPage = [NSString stringWithFormat: @"%d",currentPage];
    
    [postDataDic setObject:productId?productId:@"" forKey:KHttpRequestDisOrderCatEntryId];
    
	[postDataDic setObject:tempCurrentPage?tempCurrentPage:@"1" forKey:KHttpRequestDisOrderCurrentPage];
    
    [postDataDic setObject:@"10" forKey:@"pageSize"];
    
    [postDataDic setObject:verifyCode forKey:KHttpRequestDisOrderVerifyCode];
    
	HTTPMSG_RELEASE_SAFELY(_disorderListHttpMsg);
    
    NSString *parameterURL = [kHostZhiShiForHttp stringByAppendingFormat:@"/%@",KHttpRequestDisOrderIntefaceName];
    
    _disorderListHttpMsg=[[HttpMessage alloc]initWithDelegate:self 
                                                   requestUrl:parameterURL 
                                                  postDataDic:postDataDic 
                                                      cmdCode:CC_DisorserList];
    
    [self.httpMsgCtrl sendHttpMsg:_disorderListHttpMsg];
    
    TT_RELEASE_SAFELY(postDataDic);
    
    
}

-(void)getDisorderListFinish:(BOOL)isSuccess page:(const SNPageInfo *)page list:(NSArray *)list
{
    if ([_delegate respondsToSelector:
         @selector(ProductDisorderListHttpRequestCompleteWithResult:errorMsg:pageInfo:disorderList:)])
    {
        [_delegate ProductDisorderListHttpRequestCompleteWithResult:isSuccess
                                                           errorMsg:self.errorMsg
                                                           pageInfo:page
                                                       disorderList:list];
    }
    
}

-(void)parseDisorderList:(NSDictionary*)items
{
    Background_Begin
    
    NSString *temp = [items objectForKey: @"errCode"];
    if ( [temp isEqualToString:@"0"])
    {
        NSInteger __currentPage = [[items objectForKey:@"currentPage"] intValue];
        NSInteger __totalPage = [[items objectForKey:@"totalPage"] integerValue];
        
        SNPageInfo pageInfo =
        {
            __currentPage,
            __totalPage,
            10
        };
        
        NSArray *articleList = [items objectForKey: @"articleList"];
        NSMutableArray *_tempList = nil;
        if(articleList && [articleList count]>0){
            
            _tempList = [NSMutableArray arrayWithCapacity:[articleList count]];
            
            for (NSDictionary *dic in articleList) {
                
                if ([dic isKindOfClass:[NSDictionary class]])
                {
                    DisProductDetailsDTO *dto = [[DisProductDetailsDTO alloc] init];
                    
                    [dto encodeFromDictionary:dic];
                    
                    [_tempList addObject:dto];
                    
                    TT_RELEASE_SAFELY(dto);
                }
            }
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self getDisorderListFinish:YES page:&pageInfo list:_tempList];
        });
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self getDisorderListFinish:NO page:NULL list:nil];
        });
        
    }
    
    Background_End
}

-(void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    NSDictionary *items=receiveMsg.jasonItems;
    
    if(items){
        
        [self parseDisorderList:items];
        
    }else{
        
        [self getDisorderListFinish:NO page:NULL list:nil];
        
    }
}

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    [self getDisorderListFinish:NO page:NULL list:nil];

}

@end
