//
//  SuNingSellDao.h
//  SuningEBuy
//
//  Created by zl on 14-8-18.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "DAO.h"
extern NSString* __gIsProduceCode;//商品编码
@interface SuNingSellDao : DAO

- (BOOL)deleteSuNingSellDAOFromDB:(NSString*)produceCode isSearch:(BOOL)isSearch;//删除单个商品商品
- (BOOL)insertSuNingSellDAOFromDB:(NSString*)sourceChannel channelDetail:(NSString*)channelDetail produceCode:(NSString*)produceCode producePrice:(NSString*)producePrice;//插入商品
- (NSString*)searchSuNingSellDAOToDB:(NSString*)produceCode;//搜索商品
- (NSMutableArray *)getAllSuNingSellDAOFromDB;//获取所有的商品
- (BOOL)deleteAllSuNingSellDAOFromDB;//删除所有的商品
@end
