//
//  ShopCartSyncManager.m
//  SuningEBuy
//
//  Created by liukun on 14-6-18.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "ShopCartSyncManager.h"
#import "ShopCartPushTask.h"
#import "ShopCartV2ViewController.h"
#import "ShopCartSyncTask.h"
#import "ShopCartAddItemTask.h"

@interface ShopCartSyncManager() <BBTaskDelegate>
{
    NSOperationQueue    *_syncUpdateQueue;
    NSMutableSet        *_refreshCallBacksSet;
    NSMutableSet        *_missedItemEventSet;
    void (^_addCallBckBlock) (BOOL, NSString *);
    ShopCartSyncTask    *_syncTask;     //同步接口
    ShopCartPushTask    *_queryTask;    //查询接口
    BOOL                 _needMerge;    //是否需要合并
    BOOL                 _isInSettle;   //是否在结算中
    
    NSMutableDictionary *_changedItemsDic;
    
    BOOL                 _isPaused;
}

@property (nonatomic, weak) ShopCartV2ViewController *shopCartContr;

@end

/*********************************************************************/

@implementation ShopCartSyncManager

- (void)dealloc
{
    [_syncUpdateQueue cancelAllOperations];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _syncUpdateQueue = [[NSOperationQueue alloc] init];
        [_syncUpdateQueue setMaxConcurrentOperationCount:1];
        
        _refreshCallBacksSet = [[NSMutableSet alloc] init];
        _changedItemsDic = [[NSMutableDictionary alloc] init];
        _missedItemEventSet = [[NSMutableSet alloc] init];
    }
    return self;
}

- (instancetype)initWithController:(ShopCartV2ViewController *)object
{
    self = [super init];
    if (self) {
        self.shopCartContr = object;
        _syncUpdateQueue = [[NSOperationQueue alloc] init];
        [_syncUpdateQueue setMaxConcurrentOperationCount:1];
        
        _refreshCallBacksSet = [[NSMutableSet alloc] init];
        _changedItemsDic = [[NSMutableDictionary alloc] init];
        _missedItemEventSet = [[NSMutableSet alloc] init];
    }
    return self;
}

- (BOOL)isLogined
{
    return [UserCenter defaultCenter].isLogined;
}

- (ShopCartLogic *)logic
{
    return self.shopCartContr.logic;
//    return [ShopCartV2ViewController sharedShopCart].logic;
}

- (void)syncShopCart
{
    //空购物车不同步
    if (self.logic.isEmpty && !_needMerge) {
        [self.logic saveToCache];
        return;
    }
    
    //如果正在合并
    if (_syncTask.isExecuting)
    {
        [_syncTask cancel];
    }
     [self.shopCartContr displayOverFlowActivityView:L(@"loading...")];
    _syncTask = [[ShopCartSyncTask alloc] initWithCartList:self.logic.shopCartList
                                                   isMerge:_needMerge
                                                isInSettle:_isInSettle
                                                  delegate:self];
    if (_needMerge) _needMerge = NO;
    if (_isInSettle) _isInSettle = NO;
    [_syncUpdateQueue addOperation:_syncTask];
}

- (void)addProduct:(DataProductBasic *)product callBack:(void (^)(BOOL, NSString *))callBack
{
    [self.shopCartContr displayOverFlowActivityView:L(@"loading...")];
    _addCallBckBlock = [callBack copy];
    ShopCartAddItemTask *task = [[ShopCartAddItemTask alloc] initWithProduct:product delegate:self];
    [_syncUpdateQueue addOperation:task];
}

- (void)modifyCity:(NSString *)cityCode
{
    if (cityCode.length)
    {
        if ([self isLogined])
        {
            if (_queryTask.isExecuting) {
                [_queryTask cancel];
            }
            
            [self changeCity:cityCode];
            [self startSyncChangeAfterDelay:0.];
            
        }
        else
        {
            [self syncShopCart];
        }
    }
}

- (void)modifyCheck:(NSArray *)items
{
    if (self.isLogined)
    {
        if (_queryTask.isExecuting) {
            [_queryTask cancel];
        }
        
        [self addItems:items chageType:ShopCartItemUpdateFlag];
        [self startSyncChangeAfterDelay:1.];
    }
    else
    {
        [self syncShopCart];
    }
}

- (void)modifyCount:(NSArray *)items
{
    if (self.isLogined)
    {
        if (_queryTask.isExecuting) {
            [_queryTask cancel];
        }
        
        [self addItems:items chageType:ShopCartItemUpdateQuantity];
        [self startSyncChangeAfterDelay:1.];
    }
    else
    {
        [self syncShopCart];
    }
}

- (void)modifySpecial:(NSArray *)items
{
    //must be logined
    if (self.isLogined)
    {
        if (_queryTask.isExecuting) {
            [_queryTask cancel];
        }
        
        [self addItems:items chageType:ShopCartItemUpdateSpecial];
        [self startSyncChangeAfterDelay:1.];
    }
}

- (void)deleteItems:(NSArray *)items
{
    if (self.isLogined)
    {
        if (_queryTask.isExecuting) {
            [_queryTask cancel];
        }
        
        [self addItems:items chageType:ShopCartItemDeleteItem];
        [self startSyncChangeAfterDelay:0.];
    }
    else
    {
        [self syncShopCart];
    }
}

- (void)query
{
    if (self.isLogined)
    {
        if (_queryTask.isExecuting) {
            [_queryTask cancel];
        }
        
        [self addItems:nil chageType:ShopCartItemJustQuery];
        [self startSyncChangeAfterDelay:0.];
    }
    else
    {
        [self syncShopCart];
    }
}

- (void)merge
{
    if (self.logic.isEmpty)
    {
        [self query];
    }
    else
    {
        _needMerge = YES;
        [self syncShopCart];
    }
}

- (void)mergeWithLoginWinFlag:(BOOL)isInSettle
{
    //此处购物车不应该为空，故不需要做购物车空判断
    _needMerge = YES;
    _isInSettle = isInSettle;
    [self syncShopCart];
}

- (void)cancelSync
{
    [_syncUpdateQueue cancelAllOperations];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(startOperations) object:nil];
}

#pragma mark - 同步频率控制

- (void)changeCity:(NSString *)cityCode
{
    if (cityCode.length) {
        ShopCartPushItem *item = [ShopCartPushItem cityItem:cityCode];
        [_changedItemsDic setObject:item forKey:item.itemId];
    }
}

- (void)addItems:(NSArray *)items chageType:(ShopCartItemUpdateType)type
{
    if (type == ShopCartItemJustQuery)
    {
        ShopCartPushItem *dto = [ShopCartPushItem queryItem];
        [_changedItemsDic setObject:dto forKey:dto.itemId];
    }
    else
    {
        for (ShopCartV2DTO *dto in items) {
            
            NSString *itemId = dto.orderItemId?dto.orderItemId:@"";
            ShopCartPushItem *eDto = [_changedItemsDic objectForKey:itemId];
            if (!eDto) {
                eDto = [[ShopCartPushItem alloc] init];
                eDto.itemId = itemId;
                [_changedItemsDic setObject:eDto forKey:itemId];
            }
            
            switch (type) {
                case ShopCartItemUpdateFlag: {
                    eDto.flag = [NSString stringWithFormat:@"%d", dto.isChecked];
                    break;
                }
                case ShopCartItemUpdateQuantity: {
                    eDto.quantity = dto.quantity;
                    break;
                }
                case ShopCartItemUpdateSpecial: {
                    eDto.special = dto.special>0?[NSString stringWithFormat:@"%d", dto.special]:@"";
                    break;
                }
                case ShopCartItemDeleteItem: {
                    eDto.deleteFlag = @"1";
                    break;
                }
                default:
                    break;
            }
        }
    }
}

- (void)startSyncChangeAfterDelay:(NSTimeInterval)delay
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(startOperations) object:nil];
    if (delay > 0) {
        [self performSelector:@selector(startOperations) withObject:nil afterDelay:delay];
    } else {
        [self startOperations];
    }
}

- (void)startOperations
{    
    if (_isPaused) {
        return;
    }
    
    NSArray *changedItems = [_changedItemsDic allValues];
    if ([changedItems count]) {
        
        [self.shopCartContr displayOverFlowActivityView:L(@"loading...")];
        
        ShopCartPushTask *task = [[ShopCartPushTask alloc] initWithItems:changedItems delegate:self];
        [_syncUpdateQueue addOperation:task];
        [_changedItemsDic removeAllObjects];
    }
}

#pragma mark - task call back

- (void)taskDidComplete:(BBTask *)task
{
    if ([task isKindOfClass:[ShopCartPushTask class]])
    {
        //同步任务池空闲时才刷新页面
        if ([self isIdle])
        {
            ShopCartPushTask *pushTask = (ShopCartPushTask *)task;
            
            ShopCartLogic *logicNew = [[ShopCartLogic alloc] initWithCartList:pushTask.shopCartItemList
                                                              productAllPrice:pushTask.productAllPrice
                                                              userPayAllPrice:pushTask.userPayAllPrice
                                                                  sunpgkPrice:pushTask.sunpgkPrice
                                                                totalDiscount:pushTask.totalDiscount
                                                                promotionDesc:pushTask.promotionDesc
                                                                   inSameCity:pushTask.inSameCity];
            if ([_refreshCallBacksSet count])
            {
                for (id item in _refreshCallBacksSet) {
                    
                    void (^_refreshBlock) (ShopCartLogic *) = item;
                    _refreshBlock(logicNew);
                }
            }
            
            if (pushTask.missItemId.length)
            {
                for (id item in _missedItemEventSet) {
                    
                    void (^_missItemEventBlock)(NSString *) = item;
                    _missItemEventBlock(pushTask.missItemId);
                }
            }
        }
    }
    else if ([task isKindOfClass:[ShopCartSyncTask class]])
    {
        //同步任务池空闲时才刷新页面
        if ([self isIdle])
        {
            ShopCartSyncTask *syncTask = (ShopCartSyncTask *)task;
            
            ShopCartLogic *logicNew = [[ShopCartLogic alloc] initWithCartList:syncTask.shopCartItemList
                                                              productAllPrice:syncTask.productAllPrice
                                                              userPayAllPrice:syncTask.userPayAllPrice
                                                                  sunpgkPrice:syncTask.sunpgkPrice
                                                                totalDiscount:syncTask.totalDiscount
                                                                promotionDesc:syncTask.promotionDesc
                                                                   inSameCity:syncTask.inSameCity];
            
            if (syncTask.isMerge || [self.logic isMatchedIn:logicNew])
            {
                if (syncTask.isMerge) {
                    //合并之后清空本地未登录列表
                    [ShopCartLogic removeCache];
                }
                
                //如果未登录，缓存到文件
                if (!self.isLogined) {
                    [logicNew saveToCache];
                }
                
                if ([_refreshCallBacksSet count])
                {
                    for (id item in _refreshCallBacksSet) {
                        
                        void (^_refreshBlock) (ShopCartLogic *) = item;
                        _refreshBlock(logicNew);
                        [ShopCartV2ViewController sharedShopCart].logic = logicNew;
                    }
                }
            }
            else
            {
                if (!self.isLogined)
                {
                    [self syncShopCart];
                }
            }
            
        }
    }
    else if ([task isKindOfClass:[ShopCartAddItemTask class]])
    {
        ShopCartAddItemTask *addTask = (ShopCartAddItemTask *)task;
        if (_addCallBckBlock) {
            _addCallBckBlock(addTask.isSuccessed, addTask.error.localizedDescription);
        }
    }
    [self.shopCartContr removeOverFlowActivityView];
}

- (id)addRefreshBlock:(void (^)(ShopCartLogic *))block
{
    void (^_refreshBlock) (ShopCartLogic *) = [block copy];
    
    [_refreshCallBacksSet addObject:_refreshBlock];
    
    return _refreshBlock;
}

- (void)removeRefreshObserver:(id)observerBlock
{
    if ([_refreshCallBacksSet containsObject:observerBlock]) {
        [_refreshCallBacksSet removeObject:observerBlock];
    }
}

- (id)addMissedItemEvent:(void(^)(NSString *missItemId))eventBlock
{
    void (^_missedItemEventBlock)(NSString *) = [eventBlock copy];
    [_missedItemEventSet addObject:_missedItemEventBlock];
    return _missedItemEventBlock;
}

- (void)removeMissedItemEventObserver:(id)observer
{
    if ([_missedItemEventSet containsObject:observer]) {
        [_missedItemEventSet removeObject:observer];
    }
}

- (BOOL)isIdle
{
    if (_syncUpdateQueue.operationCount == 0 && [_changedItemsDic count] == 0) {
        return YES;
    } else {
        return NO;
    }
}

- (void)addEventWhenIdle:(dispatch_block_t)event
{
    if ([self isIdle]) {
        if (event) event();
    } else {
        
        if ([_changedItemsDic count] > 0) {
            [self startSyncChangeAfterDelay:0.];
        }
        
        [_syncUpdateQueue addOperation:[NSBlockOperation blockOperationWithBlock:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                if (event) event();
            });
        }]];
    }
}

- (void)pause
{
    _isPaused = YES;
}

- (void)resume
{
    _isPaused = NO;
    [self startSyncChangeAfterDelay:0.];
}
@end
