//
//  CardWbSerVice.m
//  SuningEBuy
//
//  Created by YANG on 14-3-13.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "CardWbSerVice.h"

@interface CardWbSerVice()
{
    CFAbsoluteTime  startTime;
    CFAbsoluteTime  endTime;
}
@end

@implementation CardWbSerVice

-(void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(delHttpMsg);
    HTTPMSG_RELEASE_SAFELY(detailHttpMsg);
    HTTPMSG_RELEASE_SAFELY(userWbHttpMsg);
    HTTPMSG_RELEASE_SAFELY(getMoneyHttpMsg);
    HTTPMSG_RELEASE_SAFELY(remarkHttpMsg);
}

-(void)beginSaveDetailInfo:(CardDetailBaseDTO *)dto
{
    startTime = CFDateGetAbsoluteTime((CFDateRef)[NSDate date]);
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    if (dto.custNum != nil) {
        [dic setObject:dto.custNum forKey:@"custNum"];
    }
    
    if (dto.sysHeadPicFlag != nil) {
        [dic setObject:dto.sysHeadPicFlag forKey:@"sysHeadPicFlag"];
    }
    
    if (dto.sysHeadPicNum != nil) {
        [dic setObject:dto.sysHeadPicNum forKey:@"sysHeadPicNum"];
    }
    
    if (dto.imgData != nil) {
        [dic setObject:dto.imgData forKey:@"imgData"];
    }
    
    
    NSString *url = [NSString stringWithFormat:@"%@%@",KNewHomeAPIURL,@"mts-web/appbuy/social/setMemberPictureInfo.do"];

    
    HTTPMSG_RELEASE_SAFELY(detailHttpMsg);
    
    detailHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                               requestUrl:url
                                              postDataDic:dic
                                                  cmdCode:CC_WBCardDetailSave];
    
    [self.httpMsgCtrl sendHttpMsg:detailHttpMsg];
    
    TT_RELEASE_SAFELY(dic);
}

#pragma mark -
#pragma mark -- httpMessage delegate

-(void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    
    if(receiveMsg.cmdCode == CC_WBCardDetailSave)
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(savePersonDetailComplete:ErrorMsg:)])
        {
            [self.delegate savePersonDetailComplete:NO ErrorMsg:self.errorMsg];
        }
    }
    
}


-(void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    if(receiveMsg.cmdCode == CC_WBCardDetailSave)
    {
        NSDictionary *dic = [receiveMsg jasonItems];
        
        if (dic == nil)
        {
            self.errorMsg = @"kHttpResponseJSONValueFailError";
        }
        else
        {
            NSString *successFlg = [dic objectForKey:@"successFlg"];
            
            self.errorMsg = [dic objectForKey:@"errorMsg"];
            
            BOOL isSucces = NO;
            if ([successFlg isEqualToString:@"COMPLETE"])
            {
                isSucces = YES;
            }
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(savePersonDetailComplete:ErrorMsg:)])
            {
                endTime = CFDateGetAbsoluteTime((CFDateRef)[NSDate date]);
                //                DLog(@"startTime = %f",startTime);
                //                DLog(@"endTime = %f",endTime);
                //                DLog(@"ssssss = %f",endTime - startTime);
                
                [self.delegate savePersonDetailComplete:isSucces ErrorMsg:self.errorMsg];
            }
            
        }
    }
    
}
@end