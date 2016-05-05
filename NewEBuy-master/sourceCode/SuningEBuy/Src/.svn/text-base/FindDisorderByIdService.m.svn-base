//
//  FindDisorderByIdService.m
//  SuningEBuy
//
//  Created by 正来 崔 on 12-9-25.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "FindDisorderByIdService.h"
#import "zhishiDetailsHttpDataSource.h"
#import "DisProductDetailsDTO.h"

@implementation FindDisorderByIdService

@synthesize delegate=_delegate;
@synthesize articleId=_articleId;
@synthesize imageArray=_imageArray;
@synthesize ProductDisOrderReplyItem=_ProductDisOrderReplyItem;
@synthesize disProductDetailsItemList=_disProductDetailsItemList;



-(void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(_findDisorderByIdHttpMsg);
    
    [super httpMsgRelease];
}

-(id)init
{
    self =[super init];
    if(self){
        
    }
    return  self;
}

-(void)sendFindDisorderByIdHttpRequest:(NSNumber*)articleId
{

    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
    
    [postDataDic setObject:articleId forKey:@"articleId"];
    
    HTTPMSG_RELEASE_SAFELY(_findDisorderByIdHttpMsg);
    
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostZhiShiForHttp,kHttpfindURPhotoById];
    
    _findDisorderByIdHttpMsg =[[HttpMessage alloc]initWithDelegate:self 
                                                        requestUrl:url 
                                                       postDataDic:postDataDic 
                                                           cmdCode:CC_DisorderById];
    
    [self.httpMsgCtrl sendHttpMsg:_findDisorderByIdHttpMsg];
    
    TT_RELEASE_SAFELY(postDataDic);
    
}

-(void)getFindDisorderByIdFinish:(BOOL)isSuccess
{
    if(self.delegate&&[_delegate respondsToSelector:@selector(FindDisorderByIdHttpRequestCompleteWithService:isSuccess:)]){
        [_delegate FindDisorderByIdHttpRequestCompleteWithService:self isSuccess:isSuccess];
    }
}

-(void)parseFindDisorderById:(NSDictionary *)items
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        @autoreleasepool {
            
            //获取图片list-开始
            
            self.imageArray = [zhishiDetailsHttpDataSource parsezhishiImageList:items];
            //获取图片list-结束
            
            //将晒单转换为数组-开始
            self.disProductDetailsItemList = [zhishiDetailsHttpDataSource parseZhishiDetailsList:items];
            
            //DisProductDetailsDTO *shaidanDto = [[DisProductDetailsDTO alloc]init];
            
//            DisProductDetailsDTO *shaidanDto = [self.disProductDetailsItemList objectAtIndex:0];//晒单类型，qaType为0是晒单，其余均是回复
            
//            self.shaidanzhengwen = shaidanDto.content;
//            self.disOrderDetailLabel.text = shaidanDto.content;
            //将晒单转换为数组-结束
            
            
            //将回复转换为数组--开始
            self.ProductDisOrderReplyItem = [zhishiDetailsHttpDataSource parseZhishiReplyList:items];
            //将回复转换为数组--结束
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self getFindDisorderByIdFinish:YES];
            });
            
        }
    });
    
    
}

-(void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    NSDictionary *items=receiveMsg.jasonItems;
    
    if(receiveMsg.cmdCode==CC_DisorderById)
    {
        if(items){
            
            [self parseFindDisorderById:items];
            
        }else{
            
            [self getFindDisorderByIdFinish:NO];
            
        }
    }
    
}

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    [self getFindDisorderByIdFinish:NO];
}

@end
