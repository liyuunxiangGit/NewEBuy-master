//
//  ReturnGoodsPicService.m
//  SuningEBuy
//
//  Created by zl on 14-11-8.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "ReturnGoodsPicService.h"
@interface ReturnGoodsPicService ()

@property (nonatomic,strong) HttpMessage *httpMsg;

@end
@implementation ReturnGoodsPicService
- (void)dealloc
{
    HTTPMSG_RELEASE_SAFELY(_httpMsg);
}

- (void)requestPostPicture:(NSData *)imageData orderId:(NSString*)orderId ownerId:(NSString*)ownerId
{
    HTTPMSG_RELEASE_SAFELY(_httpMsg);
    NSString* strUrl = nil;
    E_CMDCODE temp = 0;
    
    if ([ownerId length] == 0)
    {
        strUrl = [NSString stringWithFormat:@"%@/SNMobileComplaintPicCmd?storeId=10052&orderId=%@&catalogId=10051&ownerId=&type=uploadPicture",kHostAddressForHttps,orderId];
        temp = CC_ReturnGoodsUpPic;
    }
    else
    {
        strUrl = [NSString stringWithFormat:@"%@/SNMobileComplaintPicCmd?storeId=10052&orderId=%@&catalogId=10051&ownerId=%@&type=deletePicture",kHostAddressForHttps,orderId,ownerId];
        temp = CC_ReturnGoodsDeletePic;
    }
    _httpMsg = [[HttpMessage alloc] initWithDelegate:self
                                          requestUrl:strUrl
                                         postDataDic:nil
                                             cmdCode:temp];
    _httpMsg.delegate      = self;
    _httpMsg.requestMethod = RequestMethodPostStream;
//    _httpMsg.isUploadPic = YES;
    if (imageData)
    {
        _httpMsg.postData      = imageData;
    }
    
    [self.httpMsgCtrl sendHttpMsg:_httpMsg];
}
- (void)receiveDidFinished:(HttpMessage *)receiveMsg {
    
    NSDictionary *dictionary = receiveMsg.jasonItems;
    NSString *ret = EncodeStringFromDic(dictionary,@"status");
    if ([ret isEqualToString:@"success"])
    {
        if ([_delegate respondsToSelector:@selector(delegate_httpService_result:usrInfo:error:cmd:)])
        {
            [_delegate delegate_httpService_result:dictionary
                                           usrInfo:receiveMsg.userInfo
                                             error:nil
                                               cmd:receiveMsg.cmdCode];
        }
    }

}

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
    {
    [super receiveDidFailed:receiveMsg];
    
    if (nil != _delegate
        && [_delegate respondsToSelector:@selector(delegate_httpService_result:usrInfo:error:cmd:)]) {
        
        NSError *error = [NSError errorWithDomain:@"" code:-1
                                         userInfo:@{NSLocalizedDescriptionKey:self.errorMsg}];
        
        [_delegate delegate_httpService_result:nil
                                            usrInfo:receiveMsg.userInfo
                                              error:error
                                                cmd:receiveMsg.cmdCode];
    }
}


@end
