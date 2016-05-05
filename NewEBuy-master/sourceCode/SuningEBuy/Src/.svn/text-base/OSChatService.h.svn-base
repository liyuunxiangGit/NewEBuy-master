//
//  Powered by SNFramework
//
//  OSChatService.h
//  SuningEBuy
//
//  Created by  liukun on 13-11-26.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "DataService.h"
#import "OSChatDTO.h"
#import "OSMsgDTO.h"

#define kOSParamSignKey                 @"66eda4649f5375986bf3707028a56e27"

#define kOSWaitQueueRepeatInterval      (3.0f)
#define kOSGetMsgInterval               (5.0f)

#define kOSChatServerErrorMsg           @"很抱歉，当前没有客服在线,请致电4008-365-365办理"

@class OSChatService;
@protocol OSChatServiceDelegate <NSObject>

@optional
- (void)osService:(OSChatService *)service getB2CStatusComplete:(BOOL)isSuccess;
- (void)osService:(OSChatService *)service getCStatusComplete:(BOOL)isSuccess;
- (void)osService:(OSChatService *)service createB2CChatComplete:(BOOL)isSuccess;
- (void)osService:(OSChatService *)service createCChatComplete:(BOOL)isSuccess;
- (void)osService:(OSChatService *)service waitQueueComplete:(BOOL)isSuccess;
- (void)osService:(OSChatService *)service quitWaitQueueComplete:(BOOL)isSuccess;
- (void)osService:(OSChatService *)service sendMsgComplete:(BOOL)isSuccess;
- (void)osService:(OSChatService *)service getMsgComplete:(BOOL)isSuccess;
- (void)osService:(OSChatService *)service endChatComplete:(BOOL)isSuccess;
- (void)osService:(OSChatService *)service opinionComplete:(BOOL)isSuccess;
- (void)osService:(OSChatService *)service leaveMessageComplete:(BOOL)isSuccess;
- (void)osService:(OSChatService *)service getQuickAskListComplete:(BOOL)isSuccess;

@end

@interface OSChatService : DataService
{
    HttpMessage *getCStatusHttpMsg;
    HttpMessage *getB2CStatusHttpMsg;
    HttpMessage *createB2CChatHttpMsg;
    HttpMessage *createCChatHttpMsg;
    HttpMessage *waitQueueHttpMsg;
    HttpMessage *quitWaitQueueHttpMsg;
    HttpMessage *sendMsgHttpMsg;
    HttpMessage *getMsgHttpMsg;
    HttpMessage *endChatHttpMsg;
    HttpMessage *opinionHttpMsg;
    HttpMessage *leaveMsgHttpMsg;
    HttpMessage *quickAskHttpMsg;
}

@property (nonatomic, weak) id<OSChatServiceDelegate> delegate;

@property (nonatomic, strong) OSMsgDTO *msgDTO;

@property (nonatomic, assign) int code;  //1，在线 0不在线， -1无此通道 , 2排队
@property (nonatomic, strong) OSChatDTO *chat;
@property (nonatomic, strong) NSArray *messageArray;
@property (nonatomic, strong) NSArray *quickAskList;
@property (nonatomic, assign) SNShopType shopType;

- (void)requestGetB2CStatus:(NSString *)b2cGroupId
                        gId:(NSString *)gId
                GroupMember:(NSString *)groupMember
                  ClassCode:(NSString *)classCode;

- (void)requestGetCStatus:(NSString *)shopCode;

- (void)requestCreateB2CChat:(NSString *)b2cGroupId
                         GId:(NSString *)gId
                 GroupMember:(NSString *)groupMember
                   ClassCode:(NSString *)classCode
                      UserId:(NSString *)userId
                      CustNo:(NSString *)custNo
                    NickName:(NSString *)nickName
                 ProductName:(NSString *)productName
                 ProductCode:(NSString *)productCode
                     OrderNo:(NSString *)orderNo;

- (void)requestCreateCChat:(NSString *)shopCode
                    UserId:(NSString *)userId
                    CustNo:(NSString *)custNo
                  NickName:(NSString *)nickName
               ProductName:(NSString *)productName
               ProductCode:(NSString *)productCode
                   OrderNo:(NSString *)orderNo;

- (void)requestWaitQueue:(OSChatDTO *)waitingChat;

- (void)requestQuitWaitQueue:(NSString *)companyId GId:(NSString *)gId VId:(NSString *)vId;

- (void)requestSendMsg:(OSMsgDTO *)message
            customerId:(NSString *)customerId
             CompanyId:(NSString *)companyId
                ChatId:(NSString *)chatId
                   VId:(NSString *)vId;


- (void)requestGetMsg:(NSString *)companyId ChatId:(NSString *)chatId VId:(NSString *)vId;

- (void)requestEndChat:(NSString *)companyId ChatId:(NSString *)chatId VId:(NSString *)vId;

- (void)requestOpinion:(NSString *)opinion
             CompanyId:(NSString *)companyId
                ChatId:(NSString *)chatId
                   VId:(NSString *)vId
                  Desp:(NSString *)desp;

- (void)requestLeaveMessage:(NSString *)title
                    Context:(NSString *)context
                   ShopCode:(NSString *)shopCode
                GroupMember:(NSString *)groupMember
                  ClassCode:(NSString *)classCode
                     UserId:(NSString *)userId
                     CustNo:(NSString *)custNo
                   NickName:(NSString *)nickName
                ProductCode:(NSString *)productCode
                    OrderNo:(NSString *)orderNo
                    Contact:(NSString *)contact;

- (void)requestQuickAskList;

@end
