//
//  SNCommentShareService.m
//  SuningEBuy
//
//  Created by Joe on 14-11-14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "SNCommentShareService.h"

@interface SNCommentShareService()
{
    HttpMessage     *_validateMsg;
    HttpMessage     *_imageUploadMsg;
    HttpMessage     *_publicMsg;
}

@end

@implementation SNCommentShareService

-(void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(_imageUploadMsg);
    HTTPMSG_RELEASE_SAFELY(_validateMsg);
    HTTPMSG_RELEASE_SAFELY(_publicMsg);
}

-(void)validata:(NSString*)orderId customerId:(NSString*)customerId
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:orderId forKey:@"orderItemId"];
    [dic setObject:customerId forKey:@"cmfUserId"];
    [dic setObject:@"6" forKey:@"deviceType"];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kCommentShareReviewServer,@"ajax/validateIsReview.htm"];
    
    HTTPMSG_RELEASE_SAFELY(_validateMsg);
    
    _validateMsg = [[HttpMessage alloc] initWithDelegate:self
                                                  requestUrl:url
                                                 postDataDic:dic
                                                     cmdCode:CC_CommentShareValidate];
    
    [self.httpMsgCtrl sendHttpMsg:_validateMsg];
    
    TT_RELEASE_SAFELY(dic);
}

-(void)uploadImage:(NSString*)imagePath token:(NSString*)token orderId:(NSString*)orderId userId:(NSString*)userId imageLocalId:(NSString*)imageId
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:orderId forKey:@"orderItemId"];
    [dic setObject:token forKey:@"token"];
    [dic setObject:userId forKey:@"cmfUserId"];
    [dic setObject:@"6" forKey:@"deviceType"];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kCommentShareReviewServer,@"uploadServlet"];
    
    
    HTTPMSG_RELEASE_SAFELY(_imageUploadMsg);
    
    _imageUploadMsg = [[HttpMessage alloc] initWithDelegate:self
                                              requestUrl:url
                                             postDataDic:dic
                                                 cmdCode:CC_CommentShareImageUpload];
    if (imageId) {
        [_imageUploadMsg.additionValues setObject:imageId forKey:@"imageId"];
    }
    _imageUploadMsg.requestMethod = RequestMethodPostStream;
    _imageUploadMsg.isUploadImage = YES;
    _imageUploadMsg.postData      = nil;
    [self.httpMsgCtrl sendHttpMsg:_imageUploadMsg];
    
    TT_RELEASE_SAFELY(dic);
}

-(void)publish:(NSString*)content orderId:(NSString*)orderId partNumer:(NSString*)number isPublic:(BOOL)isPublic productStar:(int)prodcutStar deliverStar:(int)deliverStar serviceStar:(int)serviceStar imageResourceIds:(NSMutableArray*)resouceIds{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:orderId forKey:@"orderItemId"];
    [dic setObject:content forKey:@"content"];
    [dic setObject:number forKey:@"partnumber"];
    [dic setObject:[NSNumber numberWithBool:!isPublic] forKey:@"anonFlag"]; //接口默认是是否匿名
    //[dic setObject:[NSNumber numberWithBool:prodcutStar] forKey:@"anonFlag"];
    [dic setObject:[NSNumber numberWithBool:deliverStar] forKey:@"dlvrSpeedStar"];
    [dic setObject:[NSNumber numberWithBool:serviceStar] forKey:@"attitudeStar"];
    [dic setObject:[resouceIds componentsJoinedByString:@","] forKey:@"imgResourceIds"];
    [dic setObject:@"6" forKey:@"deviceType"];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kCommentShareReviewServer,@"ajax/mergeReviewAndOrderShow.htm"];
    
    
    HTTPMSG_RELEASE_SAFELY(_publicMsg);
    
    _publicMsg = [[HttpMessage alloc] initWithDelegate:self
                                                 requestUrl:url
                                                postDataDic:dic
                                                    cmdCode:CC_CommentSharePublish];

    [self.httpMsgCtrl sendHttpMsg:_publicMsg];
    
    TT_RELEASE_SAFELY(dic);
}

-(void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    if (receiveMsg.cmdCode == CC_CommentShareValidate) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(validataResult:token:)]) {
            [self.delegate validataResult:NO token:@""];
        }
    }else if(receiveMsg.cmdCode == CC_CommentShareImageUpload){
        if (self.delegate && [self.delegate respondsToSelector:@selector(imageUploadedResult:imageId:resultId:)]) {
            [self.delegate imageUploadedResult:NO imageId:[receiveMsg.additionValues strValue:@"imageId"] resultId:@""];
        }
    }else if(receiveMsg.cmdCode == CC_CommentSharePublish){
        if (self.delegate && [self.delegate respondsToSelector:@selector(publishResult:commentId:serviceId:showId:)]) {
            [self.delegate publishResult:NO commentId:@"" serviceId:@"" showId:@""];
        }
    }
}

-(void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    if (receiveMsg.cmdCode == CC_CommentShareValidate) {
        NSDictionary *dic = [receiveMsg jasonItems];
        NSString *errorCode = [dic strValue:@"errorcode"];
        if ([errorCode isEqualToString:@"0"] && self.delegate && [self.delegate respondsToSelector:@selector(validataResult:token:)]) {
            [self.delegate validataResult:YES token:[dic strValue:@"token"]];
        }else if(![errorCode isEqualToString:@"0"] && self.delegate && [self.delegate respondsToSelector:@selector(validataResult:token:)]){
            [self.delegate validataResult:NO token:[dic strValue:@"token"]];
        }
    }else if(receiveMsg.cmdCode == CC_CommentShareImageUpload){
        NSDictionary *dic = [receiveMsg jasonItems];
        NSString *errorCode = [dic strValue:@"errorcode"];
        if ([errorCode isEqualToString:@"0"] && self.delegate && [self.delegate respondsToSelector:@selector(imageUploadedResult:imageId:resultId:)]) {
            [self.delegate imageUploadedResult:YES imageId:[receiveMsg.additionValues objectForKey:@"imageId"] resultId:[dic strValue:@"imgResourceId"]];
        }else if(![errorCode isEqualToString:@"0"] && self.delegate && [self.delegate respondsToSelector:@selector(imageUploadedResult:imageId:resultId:)]){
            [self.delegate imageUploadedResult:NO imageId:[receiveMsg.additionValues objectForKey:@"imageId"] resultId:[dic strValue:@"imgResourceId"]];
        }
    }else if(receiveMsg.cmdCode == CC_CommentSharePublish){
        NSDictionary *dic = [receiveMsg jasonItems];
        NSString *errorCode = [dic strValue:@"errorcode"];
        if ([errorCode isEqualToString:@"0"] && self.delegate && [self.delegate respondsToSelector:@selector(publishResult:commentId:serviceId:showId:)]) {
            [self.delegate publishResult:YES commentId:[dic strValue:@"reviewId"] serviceId:[dic strValue:@"serviceReviewId"] showId:[dic strValue:@"orderShowId"]];
        }else if(![errorCode isEqualToString:@"0"] && self.delegate && [self.delegate respondsToSelector:@selector(publishResult:commentId:serviceId:showId:)]){
            [self.delegate publishResult:NO commentId:[dic strValue:@"reviewId"] serviceId:[dic strValue:@"serviceReviewId"] showId:[dic strValue:@"orderShowId"]];
        }
    }
}

@end
