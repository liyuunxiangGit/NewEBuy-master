//
//  GuessYouLikeService.m
//  SuningEBuy
//
//  Created by GUO on 14-10-27.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "GuessYouLikeService.h"
#import "KCOpenUDID.h"
#import "GuessDataDTO.h"
#import "GuessYouLikeDTO.h"
#import "ProductUtil.h"

@implementation GuessYouLikeService

- (void)dealloc {
    
    HTTPMSG_RELEASE_SAFELY(guessYouLikeHttpMsg);
}

- (void)beginGetHomeGuessYouLikeHttpRequest
{
    //    NSString *url = @"http://10.19.90.232:9080/recommend-portal/recommendv2/biz.jsonp?u=154254855&c=140573580153189321&sceneIds=14-1&cityId=9173&count=50";
    NSString *customerId;
    NSString *phoneId;
    NSString *sceneId;
    NSString *cityId;
    NSString *count;
    if([UserCenter defaultCenter].isLogined){
        customerId = [UserCenter defaultCenter].userInfoDTO.memberCardNo;
    }else{
        customerId = @"";
    }
    phoneId = [KCOpenUDID value];
    sceneId = @"14-1";
    cityId = IsStrEmpty([Config currentConfig].locationCity)?[Config currentConfig].locationCity:[Config currentConfig].defaultCity;
    count = @"50";
    NSString *url = [NSString stringWithFormat:@"%@recommend-portal/recommendv2/biz.jsonp?u=%@&c=%@&sceneIds=%@&cityId=%@&count=%@",
                     kGuessYouLikeURL,
                     customerId,
                     phoneId,
                     sceneId,
                     cityId,
                     count
                     ];
    HTTPMSG_RELEASE_SAFELY(guessYouLikeHttpMsg);
    guessYouLikeHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                     requestUrl:url
                                                    postDataDic:nil
                                                        cmdCode:CC_HomeGuessYouLike];

    guessYouLikeHttpMsg.requestMethod = RequestMethodGet;
    guessYouLikeHttpMsg.timeout = 20;
    [self.httpMsgCtrl sendHttpMsg:guessYouLikeHttpMsg];
}

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    if (receiveMsg.cmdCode == CC_HomeGuessYouLike){
        [self homeGuessYouLikeServiceFinished:NO withDTO:nil with:nil];
    }
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    NSDictionary *jsonItem = receiveMsg.jasonItems;
    if(NotNilAndNull(jsonItem)){//json是否为空
        NSArray *guessList = EncodeArrayFromDic(jsonItem, @"sugGoods");
        if(!IsArrEmpty(guessList)){//数组是否为空
            NSDictionary *data = (NSDictionary *)[guessList objectAtIndex:0];
            if(NotNilAndNull(data)){//字典是否为空
                GuessYouLikeDTO *dto = [[GuessYouLikeDTO alloc] init];
                dto.retCode = [data objectForKey:@"resCode"];
                dto.sceneId = [data objectForKey:@"sceneId"];
                dto.cityId  = [data objectForKey:@"cityId"];
                if(![dto.retCode isEqualToString:@"02"]){//是否系统内部异常
                    NSMutableArray *productList = (NSMutableArray *)[data objectForKey:@"skus"];
                    if(!IsArrEmpty(productList)){//商品数组是否为空
                        NSMutableArray *guessArray = [[NSMutableArray alloc] initWithCapacity:[productList count]];
                        for(int i = 0;i<[productList count];i++){
                            GuessDataDTO *dataDto = [[GuessDataDTO alloc] init];
                            [dataDto parseFromDict:(NSDictionary *)[productList objectAtIndex:i]];
                            [guessArray addObject:dataDto];
                        }
                        dto.dataArray = guessArray;
                        
                        //预取4张图片
                        NSMutableArray *tempArray = [[NSMutableArray alloc] initWithCapacity:1];
//                        if([dto.dataArray count] >=4){
//                            for(int i = 0;i<4;i++){
//                                GuessDataDTO *tempDto = [dto.dataArray objectAtIndex:i];
//                                NSURL *imageUrl = [ProductUtil getImageUrlWithProductCode:tempDto.productCode size:ProductImageSize100x100];
//                                [tempArray addObject:imageUrl];
//                            }
//                        }
                        //解析成功
                        [self homeGuessYouLikeServiceFinished:YES withDTO:dto with:tempArray];
                    }
                    else{//商品数组为空
                        self.errorMsg = L(@"PVErrorOccur");
                        [self homeGuessYouLikeServiceFinished:NO withDTO:nil with:nil];
                    }
                }
                else{//系统内部异常
                    self.errorMsg = L(@"PVErrorOccur");
                    [self homeGuessYouLikeServiceFinished:NO withDTO:nil with:nil];
                }
            }
            else{//字典为空
                self.errorMsg = L(@"PVErrorOccur");
                [self homeGuessYouLikeServiceFinished:NO withDTO:nil with:nil];
            }
        }
        else{//数组为空
            self.errorMsg = L(@"PVErrorOccur");
            [self homeGuessYouLikeServiceFinished:NO withDTO:nil with:nil];
        }
    }
    else{//json为空
        self.errorMsg = L(@"PVErrorOccur");
        [self homeGuessYouLikeServiceFinished:NO withDTO:nil with:nil];
    }
}

- (void)homeGuessYouLikeServiceFinished:(BOOL)isSuccess withDTO:(GuessYouLikeDTO *)dto with:(NSMutableArray *)array
{
    if(_delegate && [_delegate respondsToSelector:@selector(homeGuessYouLikeServiceComplete:isSuccess:withDto:withPreLoad:)]){
        [_delegate homeGuessYouLikeServiceComplete:self isSuccess:isSuccess withDto:dto withPreLoad:array];
    }
}

@end
