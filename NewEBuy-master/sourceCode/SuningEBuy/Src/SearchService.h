//
//  SearchService.h
//  SuningEBuy
//
//  Created by 刘坤 on 12-8-20.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

/*!
 @header      SearchService
 @abstract    搜索的service，获取热门关键字， 增删查历史搜索关键字
 @author      刘坤
 @version     v2.0  12-10-12
 @discussion  12-10-12修改，搜索接口更换新接口
 */

#import "DataService.h"
#import "DataProductBasic.h"
#import "DefaultKeyWordManager.h"
@class SearchService;

/*!
 @protocol       SearchServiceDelegate
 @abstract       SearchService的一个代理
 @discussion     代理模式
 */
@protocol SearchServiceDelegate <NSObject>

@optional
/*!
 @method        getHotKeywordsCompleteWithService:Result:errorMsg:
 @abstract      获取热门搜索关键字完成回调
 @param         service   service对象
 @param         isSuccess  获取关键字是否成功
 @param         errorMsg   失败时传入的错误信息，可直接用于提示用户
 */
- (void)getHotKeywordsCompleteWithService:(SearchService *)service
                                   Result:(BOOL)isSuccess 
                                 errorMsg:(NSString *)errorMsg;


@end

//------------------------------------------------------------------------

/*!
 @class     SearchService
 @abstract  搜索的service,  获取热门关键字， 增删查历史搜索关键字
 */
@interface SearchService : DataService
{
    HttpMessage     *getHotKeywordsHttpMsg;    
}

@property (nonatomic, weak) id<SearchServiceDelegate> delegate;
@property (nonatomic, strong) NSArray *hotKeywordList;      //热门关键字
@property (nonatomic, strong) NSMutableArray *hotWordDtoList; //保存关键字和url，为了不打乱以前的逻辑


/*!
 @method        beginGetHotKeywords
 @abstract      开始获取热门搜索关键字
 */
- (void)beginGetHotKeywords;


/*!
 @method        getLatestTwentyKeywordsWithCompletionBlock:
 @abstract      从本地db中获取最后20条搜索历史记录
 @param         completionBlock  执行完成后的回调程序块, list 操作完成后的历史关键字列表, block的参数
 */
- (void)getLatestTwentyKeywordsWithCompletionBlock:(void (^)(NSArray *list))completionBlock;


/*!
 @method        addKeywordToDB:completionBlock:
 @abstract      添加历史关键字到db
 @param         keyword 需要加入db的关键字
 @param         completionBlock  执行完成后的回调程序块, list 操作完成后的历史关键字列表, block的参数
 */
- (void)addKeywordToDB:(NSString *)keyword
       completionBlock:(void (^)(NSArray *list))completionBlock;


/*!
 @method        deleteKeywordFromDB:completionBlock:
 @abstract      删除历史关键字
 @param         keyword 需要删除的关键字
 @param         completionBlock  执行完成后的回调程序块, list 操作完成后的历史关键字列表, block的参数
 */
- (void)deleteKeywordFromDB:(NSString *)keyword 
            completionBlock:(void (^)(NSArray *list))completionBlock;

/*!
 @method        deleteAllKeywordsFromDBWithCompletionBlock:
 @abstract      删除所有历史关键字
 @param         completionBlock  执行完成后的回调程序块, list 操作完成后的历史关键字列表, block的参数
 */
- (void)deleteAllKeywordsFromDBWithCompletionBlock:(void (^)(NSArray *list))completionBlock;

@end



