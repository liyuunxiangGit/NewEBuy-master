//
//  NBYSHttpService.m
//  SuningEBuy
//
//  Created by suning on 14-9-22.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "NBYSHttpService.h"

//#define kNBYSHTTPPATH @"http://msit.cnsuning.com/mts-web/nearby/"
//#define kNBYSHTTPPATH @"http://10.24.63.92:8080/mts-web/nearby/"

#define kNBYSHTTPPATH kEbuyWapHostURL
//#define kNBYSHTTPPATH @"http://10.24.64.103:8080"

@interface NBYSHttpService ()

@property (nonatomic,strong) HttpMessage *httpMsg;

@end


@implementation NBYSHttpService

- (void)dealloc {
    HTTPMSG_RELEASE_SAFELY(_httpMsg);
}


/*
 // Function    : requestHomeChannelsList
 // Description : http post method,获取 身边顾问 首页 频道配置
 // Date        : 2014-09-22 14:00:00
 // Author      : XZoscar
 */
- (void)requestHomeChannelsList {
    HTTPMSG_RELEASE_SAFELY(_httpMsg);
    _httpMsg = [[HttpMessage alloc] initWithDelegate:self
                                          requestUrl:[kNBYSHTTPPATH stringByAppendingString:@"/mts-web/nearby/conf/channelList.do"]
                                         postDataDic:nil
                                             cmdCode:CC_NBYGetHomeChannels];
    _httpMsg.delegate = self;
    _httpMsg.requestMethod = RequestMethodGet;
    
    [self.httpMsgCtrl sendHttpMsg:_httpMsg];
}


/*
 // Function    : requestHomeFixedModeChannelListWithParas: usrInfo:
 // Description : 获取频道下数据列表，首页（身边精华）数据列表
 // Date        : 2014-09-23 14:00:00
 // Author      : XZoscar
 */
- (void)requestHomeFixedModeChannelListWithParas:(NSDictionary *)paras
                                         usrInfo:(id)userInfo {
    
    HTTPMSG_RELEASE_SAFELY(_httpMsg);
    
    _httpMsg = [[HttpMessage alloc] initWithDelegate:self
                                          requestUrl:[kNBYSHTTPPATH stringByAppendingString:@"/mts-web/nearby/content/getBestContList.do"]
                                         postDataDic:paras
                                             cmdCode:CC_NBYHomeFixedModeChannelList];
    _httpMsg.delegate      = self;
    _httpMsg.requestMethod = RequestMethodPostStream;
    _httpMsg.userInfo      = userInfo;
    
    [self.httpMsgCtrl sendHttpMsg:_httpMsg];
}

/*
 // Function    : requestHomeMoreModeChannelListWithParas: usrInfo:
 // Description : 获取频道下数据列表，首页（身边精华）数据列表
 // Date        : 2014-09-23 14:00:00
 // Author      : XZoscar
 */
- (void)requestHomeMoreModeChannelListWithParas:(NSDictionary *)paras
                                         usrInfo:(id)userInfo {
    
    HTTPMSG_RELEASE_SAFELY(_httpMsg);
    
    _httpMsg = [[HttpMessage alloc] initWithDelegate:self
                                          requestUrl:[kNBYSHTTPPATH stringByAppendingString:@"/mts-web/nearby/content/getListByAddress.do"]
                                         postDataDic:paras
                                             cmdCode:CC_NBYNormalMoreModeChannelList];
    _httpMsg.delegate      = self;
    _httpMsg.requestMethod = RequestMethodPostStream;
    _httpMsg.userInfo      = userInfo;
    
    [self.httpMsgCtrl sendHttpMsg:_httpMsg];
}

/*
 // Function    : requestHomeNormalModeChannelListWithParas: usrInfo:
 // Description : 获取频道下数据列表，普通频道数据列表
 // Date        : 2014-09-24 14:00:00
 // Author      : XZoscar
 */
- (void)requestHomeNormalModeChannelListWithParas:(NSDictionary *)paras
                                         usrInfo:(id)userInfo {
    
    HTTPMSG_RELEASE_SAFELY(_httpMsg);
    
    _httpMsg = [[HttpMessage alloc] initWithDelegate:self
                                          requestUrl:[kNBYSHTTPPATH stringByAppendingString:@"/mts-web/nearby/content/getNormalList.do"]
                                         postDataDic:paras
                                             cmdCode:CC_NBYHomeNormalModeChannelList];
    _httpMsg.delegate      = self;
    _httpMsg.requestMethod = RequestMethodPostStream;
    _httpMsg.userInfo      = userInfo;
    
    [self.httpMsgCtrl sendHttpMsg:_httpMsg];
}

/*
 // Function    : requestGetCommentsListWithParas: usrInfo:
 // Description : 获取某个帖子的评论列表
 // Date        : 2014-09-28 10:00:00
 // Author      : XZoscar
 */

- (void)requestGetCommentsListWithParas:(NSDictionary *)paras usrInfo:(id)userInfo {
    
    HTTPMSG_RELEASE_SAFELY(_httpMsg);
    
    _httpMsg = [[HttpMessage alloc] initWithDelegate:self
                                          requestUrl:[kNBYSHTTPPATH stringByAppendingString:@"/mts-web/nearby/comment/getCommentList.do"]
                                         postDataDic:paras
                                             cmdCode:CC_NBYGetCommentsList];
    _httpMsg.delegate      = self;
    _httpMsg.requestMethod = RequestMethodPostStream;
    _httpMsg.userInfo      = userInfo;
    
    [self.httpMsgCtrl sendHttpMsg:_httpMsg];
    
}

/*
 // Function    : requestSendComment:
 // Description : 发表评论（多某个帖子进行评论）
 // Date        : 2014-09-28 12:40:00
 // Author      : XZoscar
 */

- (void)requestSendComment:(NSDictionary *)paras {
    
    HTTPMSG_RELEASE_SAFELY(_httpMsg);
    
    _httpMsg = [[HttpMessage alloc] initWithDelegate:self
                                          requestUrl:[kNBYSHTTPPATH stringByAppendingString:@"/mts-web/nearby/comment/private/commentPublish.do"]
                                         postDataDic:paras
                                             cmdCode:CC_NBYSendComment];
    _httpMsg.delegate      = self;
    _httpMsg.requestMethod = RequestMethodPostStream;
    
    [self.httpMsgCtrl sendHttpMsg:_httpMsg];
}

/*
 // Function    : requestReportPublishStick:
 // Description : 举报 某个 帖子
 // Date        : 2014-09-30 16:40:00
 // Author      : XZoscar
 */
- (void)requestReportPublishStick:(NSDictionary *)paras {
    
    HTTPMSG_RELEASE_SAFELY(_httpMsg);
    
    _httpMsg = [[HttpMessage alloc] initWithDelegate:self
                                          requestUrl:[kNBYSHTTPPATH stringByAppendingString:@"/mts-web/nearby/content/private/reportPublish.do"]
                                         postDataDic:paras
                                             cmdCode:CC_NBYReportPublish];
    _httpMsg.delegate      = self;
    _httpMsg.requestMethod = RequestMethodPostStream;
    
    [self.httpMsgCtrl sendHttpMsg:_httpMsg];
}

/*
 // Function    : requestGetRewardScoreConfList:
 // Description : 获取打赏积分/云钻列表 (打赏属性列表)
 // Date        : 2014-09-30 17:40:00
 // Author      : XZoscar
 */
- (void)requestGetRewardScoreConfList {
    
    HTTPMSG_RELEASE_SAFELY(_httpMsg);
    
    _httpMsg = [[HttpMessage alloc] initWithDelegate:self
                                          requestUrl:[kNBYSHTTPPATH stringByAppendingString:@"/mts-web/nearby/conf/scoreConf.html"]
                                         postDataDic:nil
                                             cmdCode:CC_NBYGetScoreConfList];
    _httpMsg.delegate      = self;
    _httpMsg.requestMethod = RequestMethodGet;
    
    [self.httpMsgCtrl sendHttpMsg:_httpMsg];
}

/*
 // Function    : requestDoReward:
 // Description : 打赏 (对某个帖子 进行打赏)
 // Date        : 2014-09-30 17:40:00
 // Author      : XZoscar
 */
- (void)requestDoReward:(NSDictionary *)paras {
    
    HTTPMSG_RELEASE_SAFELY(_httpMsg);
    
    _httpMsg = [[HttpMessage alloc] initWithDelegate:self
                                          requestUrl:[kNBYSHTTPPATH stringByAppendingString:@"/mts-web/nearby/reward/private/doReward.do"]
                                         postDataDic:paras
                                             cmdCode:CC_NBYDoReward];
    _httpMsg.delegate      = self;
    _httpMsg.requestMethod = RequestMethodPostStream;
    
    [self.httpMsgCtrl sendHttpMsg:_httpMsg];
}

/*
 // Function    : requestGetRewardsList:usrInfo:
 // Description : 获取打赏列表 ，分页
 // Date        : 2014-09-30 20:14:00
 // Author      : XZoscar
 */
- (void)requestGetRewardsList:(NSDictionary *)paras usrInfo:(id)userInfo {
    
    HTTPMSG_RELEASE_SAFELY(_httpMsg);
    
    _httpMsg = [[HttpMessage alloc] initWithDelegate:self
                                          requestUrl:[kNBYSHTTPPATH stringByAppendingString:@"/mts-web/nearby/reward/getRewardList.do"]
                                         postDataDic:paras
                                             cmdCode:CC_NBYGetDaShangsList];
    _httpMsg.delegate      = self;
    _httpMsg.requestMethod = RequestMethodPostStream;
    _httpMsg.userInfo      = userInfo;
    
    [self.httpMsgCtrl sendHttpMsg:_httpMsg];
}

/*
 // Function    : requestGetMoreSticksListByPostion:usrInfo:
 // Description : 获取 更多位置分组 列表
 // Date        : 2014-09-30 21:18:00
 // Author      : XZoscar
 */
- (void)requestGetMoreSticksListByPostion:(NSDictionary *)paras
                                  usrInfo:(id)userInfo  {
    HTTPMSG_RELEASE_SAFELY(_httpMsg);
    
    _httpMsg = [[HttpMessage alloc] initWithDelegate:self
                                          requestUrl:[kNBYSHTTPPATH stringByAppendingString:@"/mts-web/nearby/content/getListByAddress.do"]
                                         postDataDic:paras
                                             cmdCode:CC_NBYGetMoreSticksListByPos];
    _httpMsg.delegate      = self;
    _httpMsg.requestMethod = RequestMethodPostStream;
    _httpMsg.userInfo      = userInfo;
    
    [self.httpMsgCtrl sendHttpMsg:_httpMsg];
}

/*
 // Function    : requestGetDynamicNoticeCount:
 // Description : 动态 数字 提示 （新的 未查看的 动态）
 // Date        : 2014-10-02 09:00:00
 // Author      : XZoscar
 */
- (void)requestGetDynamicNoticeCount:(NSDictionary *)paras {
    
    HTTPMSG_RELEASE_SAFELY(_httpMsg);
    
    _httpMsg = [[HttpMessage alloc] initWithDelegate:self
                                          requestUrl:[kNBYSHTTPPATH stringByAppendingString:@"/mts-web/nearby/notice/private/getNoticeCount.do"]
                                         postDataDic:paras
                                             cmdCode:CC_NBYGetDynamicNoticeCount];
    _httpMsg.delegate      = self;
    _httpMsg.requestMethod = RequestMethodPostStream;
    
    [self.httpMsgCtrl sendHttpMsg:_httpMsg];
}

/*
 // Function    : requestGetDynamicNoticesList:
 // Description : 动态 数字 提示 （新的 未查看的 动态）
 // Date        : 2014-10-02 16:00:00
 // Author      : XZoscar
 */
-(void)requestGetDynamicsNoticeListWithParas:(NSDictionary *)paras usrInfo:(id)userInfo {
    HTTPMSG_RELEASE_SAFELY(_httpMsg);
    
    _httpMsg = [[HttpMessage alloc] initWithDelegate:self
                                          requestUrl:[kNBYSHTTPPATH stringByAppendingString:@"/mts-web/nearby/notice/private/getNoticeList.do"]
                                         postDataDic:paras
                                             cmdCode:CC_NBYGetDynamicNoticesList];
    _httpMsg.delegate      = self;
    _httpMsg.userInfo      = userInfo;
    _httpMsg.requestMethod = RequestMethodPostStream;
    
    [self.httpMsgCtrl sendHttpMsg:_httpMsg];
}

/*
 // Function    : requestPublicContentWithParas:
 // Description : 发布帖子
 // Date        : 2014-10-02 20:32:00
 // Author      : XZoscar
 */
-(void)requestPublicContentWithParas:(NSDictionary *)paras {
    
    HTTPMSG_RELEASE_SAFELY(_httpMsg);
    
    _httpMsg = [[HttpMessage alloc] initWithDelegate:self
                                          requestUrl:[kNBYSHTTPPATH stringByAppendingString:@"/mts-web/nearby/content/private/publish.do"]
                                         postDataDic:paras
                                             cmdCode:CC_NBYPublicStick];
    _httpMsg.delegate      = self;
    _httpMsg.requestMethod = RequestMethodPostStream;
    
    [self.httpMsgCtrl sendHttpMsg:_httpMsg];
}

/*
 // Function    : requestGetStickDetailtWithParas:
 // Description : 发布帖子
 // Date        : 2014-10-02 21:44:00
 // Author      : XZoscar
 */
-(void)requestGetStickDetailtWithParas:(NSDictionary *)paras {
    HTTPMSG_RELEASE_SAFELY(_httpMsg);
    
    _httpMsg = [[HttpMessage alloc] initWithDelegate:self
                                          requestUrl:[kNBYSHTTPPATH stringByAppendingString:@"/mts-web/nearby/content/getDetail.do"]
                                         postDataDic:paras
                                             cmdCode:CC_NBYGetStickDetail];
    _httpMsg.delegate      = self;
    _httpMsg.requestMethod = RequestMethodPostStream;
    
    [self.httpMsgCtrl sendHttpMsg:_httpMsg];
}


/*
 // Function    : requestPostPicture:
 // Description : 发布帖子
 // Date        : 2014-10-08 10:27:00
 // Author      : XZoscar
 */
- (void)requestPostPicture:(NSData *)imageData {
    HTTPMSG_RELEASE_SAFELY(_httpMsg);
    
    _httpMsg = [[HttpMessage alloc] initWithDelegate:self
                                          requestUrl:[kMFSServer stringByAppendingString:@"/mfs-web/UploadServlet"]
                                         postDataDic:nil
                                             cmdCode:CC_NBYUploadPicture];
    _httpMsg.delegate      = self;
    _httpMsg.requestMethod = RequestMethodPostStream;
    _httpMsg.isUploadImage = YES;
    _httpMsg.postData      = imageData;
    
    [self.httpMsgCtrl sendHttpMsg:_httpMsg];
}

#pragma mark - http callback －－－－－ －－－－－ －－－－


- (void)receiveDidFinished:(HttpMessage *)receiveMsg {
    
    NSDictionary *dictionary = receiveMsg.jasonItems;
    NSString *ret = EncodeStringFromDic(dictionary,@"ret");
    
    NSError *error = nil;
    if (nil == ret
        || ![ret isEqualToString:@"0"]) {
        NSString *msg = EncodeStringFromDic(dictionary,@"msg");
        error = [NSError errorWithDomain:L(@"PVServerInsideError") code:-1
                                userInfo:@{NSLocalizedDescriptionKey:((nil==msg||msg.length==0)?L(@"PVMaybeServerInsideError"):msg)}];
    }
    
    if (nil != _delegate
        && [_delegate respondsToSelector:@selector(delegate_nbys_httpService_result:usrInfo:error:cmd:)]) {
        [_delegate delegate_nbys_httpService_result:dictionary
                                            usrInfo:receiveMsg.userInfo
                                              error:error
                                                cmd:receiveMsg.cmdCode];
    }
}

- (void)receiveDidFailed:(HttpMessage *)receiveMsg {
    [super receiveDidFailed:receiveMsg];
    
    if (nil != _delegate
        && [_delegate respondsToSelector:@selector(delegate_nbys_httpService_result:usrInfo:error:cmd:)]) {
        
        NSError *error = [NSError errorWithDomain:@"" code:-1
                                         userInfo:@{NSLocalizedDescriptionKey:self.errorMsg}];
        
        [_delegate delegate_nbys_httpService_result:nil
                                            usrInfo:receiveMsg.userInfo
                                              error:error
                                                cmd:receiveMsg.cmdCode];
    }
}


@end
