//
//  ProductDetailSubmitService.m
//  SuningEBuy
//
//  Created by 正来 崔 on 12-9-26.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "ProductDetailSubmitService.h"

@implementation ProductDetailSubmitService

@synthesize delegate=_delegate;
@synthesize imageArray=_imageArray;
@synthesize totalImageString=_totalImageString;
@synthesize isOrderDetailLoad=_isOrderDetailLoad;
@synthesize isSubmitDisOrder=_isSubmitDisOrder;


-(id)init
{
    self =[super init];
    if(self){
        
    }
    return self;
}


-(void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(_checkURPhotoExistsMsg);
    HTTPMSG_RELEASE_SAFELY(_disorderSumbitMsg);
    
    [super httpMsgRelease];
}

-(void)computeImagePercentage{
    
    NSString  *allImageString = @"";
    NSData *imageData;
    NSString *imageString;
    
    for (int i =0;i <[self.imageArray count];i++) {
        
        UIImage *image = [self.imageArray objectAtIndex:i];
        
        imageData = UIImageJPEGRepresentation(image, 1.0);
        
        imageString = [imageData base64Encoding];
        
        if (i==0) {
            allImageString = imageString;//第一个图片直接赋值
        }else 
        {
            if (i==[self.imageArray count]-1) {
                allImageString = [allImageString stringByAppendingFormat:@",,,,,,,,,,%@", imageString];//最后一个图片
                
            }else {
                allImageString = [allImageString stringByAppendingFormat:@",,,,,,,,,,%@", imageString];//其他图片以逗号做分隔符             
                
            }
        }    
    }
    
    double imageSize = [allImageString length];
    DLog(@"拼接后总图片的长度%f", imageSize);
    if (imageSize > 120000.0) {
        percentage = 120000.0 / imageSize;
        DLog(@"%f", percentage);
        NSString *percentageStr = [NSString stringWithFormat:@"%f",percentage];
        DLog(@"%@", percentageStr);
        percentageStr = [percentageStr substringToIndex:4];
        percentage = [percentageStr doubleValue]-0.01;
        DLog(@"%f", percentage);
    }
    else{
        percentage = 1.0;
    }
    
    
}

- (void)sendSubmitOrderHttpRequest:(MemberOrderDetailsDTO*)meberOrderDetailsDTO 
                        imageArray:(NSMutableArray*)imageArray 
                  totalImageString:(NSString *)totalImageString 
                             title:(NSString*)title 
                           content:(NSString*)content
{
    
    self.imageArray=imageArray;
    
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
   
    NSString *url = [NSString stringWithFormat:@"%@/%@", kHostZhiShiForHttp, @"postURPhoto.action"];
    
    [self computeImagePercentage];
    
    NSString *imageTemp = nil;
    self.totalImageString = totalImageString;
    @autoreleasepool {
        for (int i = 0; i < [self.imageArray count]; i++)
        {
            
            UIImage *image = [self.imageArray objectAtIndex:i];
           
            NSData *imageData = UIImageJPEGRepresentation(image, percentage);
//        NSData *imageData = UIImageJPEGRepresentation(image, 0.001);
            
            NSString *imageString = [imageData base64Encoding];
            
#ifdef DEBUGLOG
            NSData *imageDataTemp = UIImageJPEGRepresentation(image, 1.0);
            NSString *imageStringTemp = [imageDataTemp base64Encoding];
            double Size = [imageStringTemp length];
            DLog(@"压缩前单个图片的大小:%f", Size);
            double imageSizeTemp = [imageString length];
            DLog(@"压缩后单个图片的大小:%f", imageSizeTemp);
            DLog(@"压缩比:%f", imageSizeTemp/Size);
#endif
            
            if (i==0) {
                imageTemp = imageString;//第一个图片直接赋值
                self.totalImageString = imageTemp;
            }else {
                if (i==[self.imageArray count]-1) {
                    self.totalImageString = [imageTemp stringByAppendingFormat:@",,,,,,,,,,%@", imageString];//最后一个图片
                }else {
                    imageTemp = [imageTemp stringByAppendingFormat:@",,,,,,,,,,%@", imageString];//其他图片以逗号做分隔符             
                }
            }    
        }
    }
    
    
    NSString	*userId = [[[UserCenter defaultCenter]userInfoDTO ]userId];
    
    [postDataDic setObject:title?title:@"" forKey:@"title"];
    [postDataDic setObject:content?content:@"" forKey:@"content"];
    [postDataDic setObject:meberOrderDetailsDTO.orderItemId?meberOrderDetailsDTO.orderItemId:@""
                    forKey:@"orderItemId"];
    [postDataDic setObject:meberOrderDetailsDTO.productId?meberOrderDetailsDTO.productId:@""
                    forKey:@"catEntryId"];
    [postDataDic setObject:(userId == nil ? @"" : userId) forKey:kHttpResponseUserId];
    //取catEntryId，前面加IPHONE，MD5加密  
    NSString *mdddd = [NSString stringWithFormat:@"IPHONE%@",meberOrderDetailsDTO.productId];
    NSString *String11 = [GetAllSysInfo md5:mdddd];
    [postDataDic setObject:[String11 lowercaseString] forKey:@"verifyCode"];
    DLog(@"%d", [_totalImageString length]);
    //图片
    [postDataDic setObject:_totalImageString?_totalImageString:@"" forKey:@"image"];
    
    HTTPMSG_RELEASE_SAFELY(_disorderSumbitMsg);
    
    _disorderSumbitMsg=[[HttpMessage alloc]initWithDelegate:self 
                                                 requestUrl:url 
                                                postDataDic:postDataDic 
                                                    cmdCode:CC_DisorderDetail];
	
    [self.httpMsgCtrl sendHttpMsg:_disorderSumbitMsg];
    
	TT_RELEASE_SAFELY(postDataDic);

}


-(void)ProductDisOrderDetailSubmitFinish:(BOOL)isSuccess
{
    if(self.delegate&&[_delegate respondsToSelector:@selector(ProductDisOrderSubmitHttpRequestCompleteWithService:isSuccess:)])
    {
        [_delegate ProductDisOrderSubmitHttpRequestCompleteWithService:self isSuccess:isSuccess];
    }
}



-(void)checkURPhotoExistsHttpRequest:(MemberOrderDetailsDTO*)meberOrderDetailsDTO
                    isSubmitDisOrder:(BOOL)isSubmitDisOrder 
                   isOrderDetailLoad:(BOOL)isOrderDetailLoad
{
    self.isSubmitDisOrder=isSubmitDisOrder;
    self.isOrderDetailLoad=isOrderDetailLoad;
    
    NSMutableDictionary *postDataDic=[[NSMutableDictionary alloc]init];
    
    NSString	*userId = [[[UserCenter defaultCenter] userInfoDTO] userId];
    [postDataDic setObject:(userId == nil ? @"" : userId) forKey:@"userId"];
    [postDataDic setObject:meberOrderDetailsDTO.orderItemId forKey:@"orderItemId"];
    NSString *url = [NSString stringWithFormat:@"%@/%@", kHostZhiShiForHttp, @"checkURPhotoExists.action"];
    HTTPMSG_RELEASE_SAFELY(_checkURPhotoExistsMsg);
    _checkURPhotoExistsMsg=[[HttpMessage alloc]initWithDelegate:self 
                                                     requestUrl:url 
                                                    postDataDic:postDataDic 
                                                        cmdCode:CC_URPhotoExist];
    
    [self.httpMsgCtrl sendHttpMsg:_checkURPhotoExistsMsg];
    
    TT_RELEASE_SAFELY(postDataDic);
    
}


-(void)getcheckURPhotoExistsFinish:(BOOL)isSuccess
{
    if(self.delegate&&[_delegate respondsToSelector:@selector(CheckURPhotoExistsHttpRequestCompleteWithService:isOrderDetailLoad:isSuccess:errorMsg:)]){
        [_delegate CheckURPhotoExistsHttpRequestCompleteWithService:self.isSubmitDisOrder isOrderDetailLoad:self.isOrderDetailLoad isSuccess:isSuccess errorMsg:self.errorMsg];
    }
}


-(void)parsecheckURPhotoExists:(NSDictionary*)items
{
    if(!items || (NSNull *)items == [NSNull null]){
		
		self.isSubmitDisOrder = NO;
	}else 
    {       
        NSString *errcode = [items objectForKey:@"errCode"];
        NSString *eFlag = [items objectForKey:@"eFlag"];
        if (errcode != nil && ![errcode isEqualToString:@""] && eFlag != nil && ![eFlag isEqualToString:@""]) {
            if ([errcode isEqualToString:@"0"]&&[eFlag isEqualToString:@"0"]) 
            {
                self.isSubmitDisOrder = YES;
                self.isOrderDetailLoad = NO;
            }   
        }
    }
    [self getcheckURPhotoExistsFinish:YES];
    

}
-(void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    NSDictionary *items=receiveMsg.jasonItems;
#ifdef DEBUGLOG
    
    for (NSString *str in items) {
        DLog(@"%@", str);
    }
    
#endif
    
    if(receiveMsg.cmdCode==CC_URPhotoExist)
    {
        if(items){
            
            NSString *errcode = [items objectForKey:@"errCode"];
            if ([errcode isEqualToString:@"0"])
            {
                [self parsecheckURPhotoExists:items];
            }else {
                
                self.errorMsg = L(@"BastFailTrylater");
                
                [self getcheckURPhotoExistsFinish:NO];
            }
        }else
        {
            self.errorMsg = kHttpResponseJSONValueFailError;
            [self getcheckURPhotoExistsFinish:NO];
        }
    }else{
        
        if(items)
        {
            NSString *errcode = [items objectForKey:@"errCode"];
            if ([errcode isEqualToString:@"0"])
            {
                [self ProductDisOrderDetailSubmitFinish:YES];
            }else {
                
                self.errorMsg = L(@"BastPublishFailTrylater");
                [self ProductDisOrderDetailSubmitFinish:NO];
            }
        }else
        {
            self.errorMsg = kHttpResponseJSONValueFailError;
            [self ProductDisOrderDetailSubmitFinish:NO];
        }
        
    }
}

- (void)receiveDidFailed:(HttpMessage *)receiveMsg{
    
    [super receiveDidFailed:receiveMsg];
    
    if (receiveMsg.cmdCode == CC_URPhotoExist) {
        
        [self getcheckURPhotoExistsFinish:NO];
    }
    else
    {
        [self ProductDisOrderDetailSubmitFinish:NO];
    }
}
@end
