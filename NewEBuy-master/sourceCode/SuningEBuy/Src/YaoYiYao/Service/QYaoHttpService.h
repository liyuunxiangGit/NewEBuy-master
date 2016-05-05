//
//  QYaoHttpService.h
//  SuningEBuy
//
//  Created by XZoscar on 14-4-8.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "DataService.h"

@protocol QYaoHttpServiceDelegate <NSObject>

- (void)delegate_yaoYiYaoHttpServeResult:(id)bean;

@end

@interface QYaoHttpService : DataService {
    @private
    HttpMessage         *_httpMsg;
}

@property (nonatomic,weak) id<QYaoHttpServiceDelegate> httpDelegate;

@property (nonatomic,strong) NSString *activeTypeId;

/*
// activeTypeId 客户端 写死，（活动类型id 如摇易摇id,!非活动id）
// 需求规定：摇易摇 activeTypeId = "1"
*/

// 活动查询
- (void)reqActiveQuery:(NSString *)activeTypeId;

// 抽奖
- (void)reqActiveChouJiang:(NSString *)activeTypeId;

/*
// 校验克隆的有效性
// paras: activeTypeId 活动类型id
          prizeId  奖项id (即宝贝id)
*/
- (void)reqActiveCloneValidate:(NSString *)activeTypeId prizeId:(NSString *)prizeId;


// 2014-05-30 xzoscar add 云钻乐园 服务'项' 获取
- (void)reqGetScoreParkItems;

@end
