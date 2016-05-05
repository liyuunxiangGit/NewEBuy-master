//
//  OSMsgDTO.h
//  SuningEBuy
//
//  Created by  liukun on 13-11-25.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "BaseHttpDTO.h"

typedef enum {
    OSMsgNormal,            //普通消息
    OSMsgCloseChat,         //对话结束
    OSMsgTo,                //to
    OSMsgScreenShot,        //图片
    OSMsgFile,              //文件
    OSMsgOpinion,           //评价
    OSMsgTranschat,         //转移对话
}OSMsgType;

typedef enum{
    OSMessageSendSuccess = 1,   //发送成功
    OSMessageSendFail,          //发送失败
    OSMessageWaitForSend,       //等待发送
    OSMessageSending,           //正在发送
} OSMessageSendType;

typedef NS_ENUM(NSInteger, OSOpinionScore) {
    OSOpinionScoreVeryAngry     = -1,   //非常不满意
    OSOpinionScoreNotSatisfied  = 1,    //不满意
    OSOpinionScoreGeneral       = 2,    //一般
    OSOpinionScoreSatified      = 3,    //满意
    OSOpinionScoreVerySatisfied = 4,    //非常满意
};

@interface OSMsgDTO : BaseHttpDTO

@property (nonatomic, copy) NSString *chatId;
@property (nonatomic, copy) NSString *from;
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, copy) NSString *to;
@property (nonatomic, assign) BOOL  isSelf;
@property (nonatomic, assign) OSMsgType type;
@property (nonatomic, assign) OSMessageSendType sendType;
@property (nonatomic, strong) NSDate *time;
@property (nonatomic, strong) NSString *chatIdNew;

@property (nonatomic, assign) BOOL  shouldShowTime;     //是否应该显示时间
@property (nonatomic, assign) CGFloat layoutCellHeight; //将要布局的高度
@property (nonatomic, strong) NSAttributedString *messageAttributedString;    //分解成数组的消息
@property (nonatomic, assign) CGSize  visibleSize;  //大小

+ (instancetype)msgForEndChat;

@end
