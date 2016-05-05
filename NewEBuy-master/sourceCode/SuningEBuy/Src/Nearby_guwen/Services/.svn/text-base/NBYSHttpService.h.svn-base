//
//  NBYSHttpService.h
//  SuningEBuy
//
//  Created by suning on 14-9-22.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "DataService.h"

#define kNBYPageLimtCount 20

@protocol NBYSHttpServiceDelegate <NSObject>
@optional
- (void)delegate_nbys_httpService_result:(NSDictionary *)result
                                 usrInfo:(id)userInfo
                                   error:(NSError *)error
                                     cmd:(E_CMDCODE)cmd;

@end


@interface NBYSHttpService : DataService

@property (nonatomic,weak) id<NBYSHttpServiceDelegate> delegate;

/*
 // Function    : requestHomeChannelsList
 // Description : http post method,获取 身边顾问 首页 频道配置
 // Date        : 2014-09-22 14:00:00
 // Author      : XZoscar
 */
- (void)requestHomeChannelsList;

/*
 // Function    : requestHomeFixedModeChannelListWithParas: usrInfo:
 // Description : 获取频道下数据列表，首页（身边精华）数据列表
 // Date        : 2014-09-23 14:00:00
 // Author      : XZoscar
 */
- (void)requestHomeFixedModeChannelListWithParas:(NSDictionary *)paras
                                         usrInfo:(id)userInfo;

/*
 // Function    : requestHomeNormalModeChannelListWithParas: usrInfo:
 // Description : 获取频道下数据列表，普通频道数据列表
 // Date        : 2014-09-24 14:00:00
 // Author      : XZoscar
 */
- (void)requestHomeNormalModeChannelListWithParas:(NSDictionary *)paras
                                          usrInfo:(id)userInfo;


/*
 // Function    : requestHomeMoreModeChannelListWithParas: usrInfo:
 // Description : 获取频道下数据列表，首页（身边精华）数据列表
 // Date        : 2014-09-23 14:00:00
 // Author      : XZoscar
 */
- (void)requestHomeMoreModeChannelListWithParas:(NSDictionary *)paras
                                        usrInfo:(id)userInfo;

/*
 // Function    : requestGetCommentsListWithParas: usrInfo:
 // Description : 获取某个帖子的评论列表
 // Date        : 2014-09-28 10:00:00
 // Author      : XZoscar
 */
- (void)requestGetCommentsListWithParas:(NSDictionary *)paras usrInfo:(id)userInfo;

/*
 // Function    : requestSendComment:
 // Description : 发表评论（多某个帖子进行评论）
 // Date        : 2014-09-28 12:40:00
 // Author      : XZoscar
 */
- (void)requestSendComment:(NSDictionary *)paras;

/*
 // Function    : requestReportPublishStick:
 // Description : 举报 某个 帖子
 // Date        : 2014-09-30 16:40:00
 // Author      : XZoscar
 */
- (void)requestReportPublishStick:(NSDictionary *)paras;

/*
 // Function    : requestGetRewardScoreConfList:
 // Description : 获取打赏积分/云钻列表 (打赏属性列表)
 // Date        : 2014-09-30 17:40:00
 // Author      : XZoscar
 */
- (void)requestGetRewardScoreConfList;


/*
 // Function    : requestDoReward:
 // Description : 打赏 (对某个帖子 进行打赏)
 // Date        : 2014-09-30 17:40:00
 // Author      : XZoscar
 */
- (void)requestDoReward:(NSDictionary *)paras;

/*
 // Function    : requestGetRewardsList:usrInfo:
 // Description : 获取打赏列表 ，分页
 // Date        : 2014-09-30 20:14:00
 // Author      : XZoscar
 */
- (void)requestGetRewardsList:(NSDictionary *)paras
                      usrInfo:(id)userInfo;

/*
 // Function    : requestGetMoreSticksListByPostion:usrInfo:
 // Description : 获取 更多位置分组 列表
 // Date        : 2014-09-30 21:18:00
 // Author      : XZoscar
 */
- (void)requestGetMoreSticksListByPostion:(NSDictionary *)paras
                      usrInfo:(id)userInfo;

/*
 // Function    : requestGetDynamicNoticeCount:
 // Description : 动态 数字 提示 （新的 未查看的 动态）
 // Date        : 2014-10-02 09:00:00
 // Author      : XZoscar
 */
- (void)requestGetDynamicNoticeCount:(NSDictionary *)paras;

/*
 // Function    : requestGetDynamicsNoticeListWithParas:usrInfo:
 // Description : 动态 数字 提示 （新的 未查看的 动态）
 // Date        : 2014-10-02 16:00:00
 // Author      : XZoscar
 */
-(void)requestGetDynamicsNoticeListWithParas:(NSDictionary *)paras
                                     usrInfo:(id)userInfo;

/*
 // Function    : requestPublicContentWithParas:
 // Description : 发布帖子
 // Date        : 2014-10-02 20:32:00
 // Author      : XZoscar
 */
-(void)requestPublicContentWithParas:(NSDictionary *)paras;

/*
 // Function    : requestGetStickDetailtWithParas:
 // Description : 发布帖子
 // Date        : 2014-10-02 21:44:00
 // Author      : XZoscar
 */
-(void)requestGetStickDetailtWithParas:(NSDictionary *)paras;

/*
 // Function    : requestPostPicture:
 // Description : 发布帖子
 // Date        : 2014-10-08 10:27:00
 // Author      : XZoscar
 */
- (void)requestPostPicture:(NSData *)imageData;

///*
// // Function    : requestPostPicture2:
// // Description : 发布帖子
// // Date        : 2014-10-08 10:27:00
// // Author      : XZoscar
// */
//- (void)requestPostPicture2:(NSData *)picData;

@end
