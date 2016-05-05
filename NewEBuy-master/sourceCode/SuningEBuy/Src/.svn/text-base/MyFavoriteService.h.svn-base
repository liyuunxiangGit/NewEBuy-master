//
//  MyFavoriteService.h
//  SuningEBuy
//
//  Created by huangtf on 12-8-29.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "DataService.h"
#import "DataProductBasic.h"

@protocol MyFavoriteServiceDelegate <NSObject>

@optional
- (void)getMyFavoriteCompletionWith:(BOOL)isSuccess 
                           errorMsg:(NSString *)errorMsg 
                       favoriteList:(NSArray *)list 
                          totalPage:(NSInteger)totalPage 
                        currentPage:(NSInteger)currPage;


- (void)getDeleteMyFavoriteCompletionWith:(BOOL)isSuccess
                                 errorMsg:(NSString *)errorMsg; 
@end


@interface MyFavoriteService : DataService
{
    HttpMessage     *favoriteListHttpMsg;
    HttpMessage     *favoriteListDeleteMsg;
    

}

@property (nonatomic, weak) id<MyFavoriteServiceDelegate> delegate;

- (void)beginGetMyFavoriteListWithPageNum:(NSString *)pageNum withListsize:(NSString *)listSize;

- (void)beginDeleteMyFavoriteList:(DataProductBasic *)dto;


@end
