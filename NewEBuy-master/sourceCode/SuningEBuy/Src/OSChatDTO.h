//
//  OSChatDTO.h
//  SuningEBuy
//
//  Created by  liukun on 13-11-25.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "BaseHttpDTO.h"
#import "OSMsgDTO.h"

typedef NS_ENUM(NSInteger, OSChatState) {
    OSChatStateUnCreated    = 0,    //还未创建
    OSChatStateOnWaitQueue  = 1,    //在排队
    OSChatStateOnChat       = 2,    //交谈中
    OSChatStateEnd          = 3,    //交谈结束
};

@interface OSChatDTO : BaseHttpDTO

@property (nonatomic, copy) NSString *b2cGroupId; //自营三级目录id
@property (nonatomic, copy) NSString *shopCode;   //商家编码
@property (nonatomic, copy) NSString *gId;        //C店在线客服通道ID
@property (nonatomic, copy) NSString *companyId;
@property (nonatomic, copy) NSString *vId;
@property (nonatomic, copy) NSString *chatId;
@property (nonatomic, copy) NSString *customerId;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *greeting;
@property (nonatomic, assign) OSChatState chatState;

@property (nonatomic, copy) NSString *waitQueueId;  //当前排队人数
@property (nonatomic, strong) NSMutableArray *sessionMsgs;
@property (nonatomic, strong) NSMutableArray *waitSendMsgs;


@end
