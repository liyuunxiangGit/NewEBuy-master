//
//  GuessYouLikeService.h
//  SuningEBuy
//
//  Created by GUO on 14-10-27.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "DataService.h"
#import "GuessYouLikeDTO.h"

@protocol GuessYouLikeServiceDelegate;

@interface GuessYouLikeService : DataService
{
    HttpMessage *guessYouLikeHttpMsg;
}

@property (nonatomic, assign) id<GuessYouLikeServiceDelegate> delegate;

//请求猜你喜欢模块数据
- (void)beginGetHomeGuessYouLikeHttpRequest;

@end

@protocol GuessYouLikeServiceDelegate <NSObject>

@optional
/**
 *  GuessYouLikeService回调
 *
 *  @param isSuccess 是否成功
 *  @param dto       传递的数据
 *  @param array     预加载图片数组
 */
- (void)homeGuessYouLikeServiceComplete:(GuessYouLikeService *)service
                              isSuccess:(BOOL)isSuccess
                              withDto:(GuessYouLikeDTO *)dto
                              withPreLoad:(NSMutableArray *)array;

@end