//
//  OSGetStatusService.m
//  SuningEBuy
//
//  Created by  liukun on 13-11-26.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "OSChatService.h"
#import "SNCache.h"

#define kOSChatQuickAskCacheKey         @"oschat.quickask"

@implementation OSChatService

- (void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(getCStatusHttpMsg);
    HTTPMSG_RELEASE_SAFELY(getB2CStatusHttpMsg);
    HTTPMSG_RELEASE_SAFELY(createB2CChatHttpMsg);
    HTTPMSG_RELEASE_SAFELY(createCChatHttpMsg);
    HTTPMSG_RELEASE_SAFELY(waitQueueHttpMsg);
    HTTPMSG_RELEASE_SAFELY(quitWaitQueueHttpMsg);
    HTTPMSG_RELEASE_SAFELY(sendMsgHttpMsg);
    HTTPMSG_RELEASE_SAFELY(getMsgHttpMsg);
    HTTPMSG_RELEASE_SAFELY(endChatHttpMsg);
    HTTPMSG_RELEASE_SAFELY(opinionHttpMsg);
    HTTPMSG_RELEASE_SAFELY(leaveMsgHttpMsg);
    HTTPMSG_RELEASE_SAFELY(quickAskHttpMsg);
}

- (id)init
{
    self = [super init];
    if (self) {
        self.code = -2;
    }
    return self;
}

#pragma mark ----------------------------- request call back

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    switch (receiveMsg.cmdCode) {
        case CC_OSGetB2CStatus:
        {
            self.errorMsg = kOSChatServerErrorMsg;
            [self getB2CStatusOk:NO];
            break;
        }
        case CC_OSGetCStatus:
        {
            [self getCStatusOk:NO];
            break;
        }
        case CC_OSCreateB2CChat:
        {
            self.errorMsg = kOSChatServerErrorMsg;
            [self createB2CChatOk:NO];
            break;
        }
        case CC_OSCreateCChat:
        {
            self.errorMsg = kOSChatServerErrorMsg;
            [self createCChatOk:NO];
            break;
        }
        case CC_OSWaitQueue:
        {
            [self waitQueueOk:NO];
            break;
        }
        case CC_OSExitWaitQueue:
        {
            [self quitWaitQueueOk:NO];
            break;
        }
        case CC_OSSendMsg:
        {
            [self sendMsgOk:NO];
            break;
        }
        case CC_OSGetMessage:
        {
            [self getMsgOk:NO];
            break;
        }
        case CC_OSEndChat:
        {
            [self endChatOk:NO];
            break;
        }
        case CC_OSOpinion:
        {
            [self opinionOk:NO];
            break;
        }
        case CC_OSLeaveMessage:
        {
            [self leaveMsgOk:NO];
            break;
        }
        case CC_OSQuickAsk:
        {
            [self getQuickAskOk:NO];
            break;
        }
        default:
            break;
    }
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    switch (receiveMsg.cmdCode) {
        case CC_OSGetB2CStatus:
        {
            [self parseGetB2CStatusInfo:receiveMsg.jasonItems];
            break;
        }
        case CC_OSGetCStatus:
        {
            [self parseGetCStatusInfo:receiveMsg.jasonItems];
            break;
        }
        case CC_OSCreateB2CChat:
        {
            [self parseCreateB2CChatInfo:receiveMsg.jasonItems];
            break;
        }
        case CC_OSCreateCChat:
        {
            [self parseCreateCChatInfo:receiveMsg.jasonItems];
            break;
        }
        case CC_OSWaitQueue:
        {
            [self parseWaitQueueInfo:receiveMsg.jasonItems];
            break;
        }
        case CC_OSExitWaitQueue:
        {
            [self parseQuitWaitQueueInfo:receiveMsg.jasonItems];
            break;
        }
        case CC_OSSendMsg:
        {
            [self parseSendMsgInfo:receiveMsg.jasonItems];
            break;
        }
        case CC_OSGetMessage:
        {
            [self parseGetMsgInfo:receiveMsg.jasonItems];
            break;
        }
        case CC_OSEndChat:
        {
            [self parseEndChatInfo:receiveMsg.jasonItems];
            break;
        }
        case CC_OSOpinion:
        {
            [self parseOpinionInfo:receiveMsg.jasonItems];
            break;
        }
        case CC_OSLeaveMessage:
        {
            [self parseLeaveMsgInfo:receiveMsg.jasonItems];
            break;
        }
        case CC_OSQuickAsk:
        {
            [self parseQuickAskInfo:receiveMsg.jasonItems];
            break;
        }
        default:
            break;
    }
}

#pragma mark ----------------------------- util

- (NSString *)signStringForParams:(NSDictionary *)paramDic
{
    NSMutableArray* pairs = [NSMutableArray array];
	for (NSString* key in [paramDic keyEnumerator]) {
		NSString* value = [paramDic objectForKey:key];
		NSString* pair = [NSString stringWithFormat:@"%@=%@", key, value];
		[pairs addObject:pair];
	}
    
    NSArray *sortArray = [pairs sortedArrayUsingComparator:^(NSString *s1, NSString *s2){
        
        return [s1 compare:s2];
    }];
	
	NSString *paramStr = [sortArray componentsJoinedByString:@"&"];
    
    DLog(@"string will be sign : %@", paramStr);
    paramStr = [paramStr stringByAppendingString:kOSParamSignKey];
    
	return [paramStr md5Hash];
}

#pragma mark ----------------------------- B2C客服状态

- (void)requestGetB2CStatus:(NSString *)b2cGroupId gId:(NSString *)gId GroupMember:(NSString *)groupMember ClassCode:(NSString *)classCode
{
    NSMutableDictionary *postDataDic = [NSMutableDictionary dictionary];
    if (b2cGroupId.length) {
        [postDataDic setObject:b2cGroupId forKey:@"b2cGroupId"];
    }
    if (gId.length) {
        [postDataDic setObject:gId forKey:@"gId"];
    }
    if (groupMember.length) {
        [postDataDic setObject:groupMember forKey:@"groupmember"];
    }
    if (classCode.length) {
        [postDataDic setObject:classCode forKey:@"classCode"];
    }
    [postDataDic setObject:[self signStringForParams:postDataDic] forKey:@"sign"];
    
    NSString *url = [NSString stringWithFormat:@"%@?cmd=%@",kOnlineServiceServerHost, @"getB2CStatus"];
    
    HTTPMSG_RELEASE_SAFELY(getB2CStatusHttpMsg);
    getB2CStatusHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                     requestUrl:url
                                                    postDataDic:postDataDic
                                                        cmdCode:CC_OSGetB2CStatus];
//    getB2CStatusHttpMsg.requestMethod=RequestMethodGet;
    [self.httpMsgCtrl sendHttpMsg:getB2CStatusHttpMsg];
}

- (void)parseGetB2CStatusInfo:(NSDictionary *)items
{
    BOOL isSuccess = NO;
    if (items)
    {
        NSString *code = EncodeStringFromDic(items, @"code");
        NSString *companyId = EncodeStringFromDic(items, @"companyId");
        
        if (companyId.integerValue > 10000)
        {
            self.shopType = SNShopTypeB2CA;
        }
        else
        {
            self.shopType = SNShopTypeB2C;
        }
        
        if ([code isEqualToString:@"1"])
        {
            self.code = 1;
            isSuccess = YES;
        }
        else if ([code isEqualToString:@"0"])
        {
            self.code = 0;
            self.errorMsg = kOSChatServerErrorMsg;
            isSuccess = YES;
        }
        else if ([code isEqualToString:@"-1"])
        {
            self.code = -1;
            self.errorMsg = kOSChatServerErrorMsg;
            isSuccess = YES;
        }
        else
        {
            self.errorMsg = kOSChatServerErrorMsg;
        }
    }
    else
    {
        self.errorMsg = kOSChatServerErrorMsg;
    }
    [self getB2CStatusOk:isSuccess];
}

- (void)getB2CStatusOk:(BOOL)isSuccess
{
    if ([_delegate respondsToSelector:@selector(osService:getB2CStatusComplete:)])
    {
        [_delegate osService:self getB2CStatusComplete:isSuccess];
    }
}

#pragma mark ----------------------------- C店客服状态

- (void)requestGetCStatus:(NSString *)shopCode
{
    NSMutableDictionary *postDataDic = [NSMutableDictionary dictionary];
    [postDataDic setObject:POST_VALUE(shopCode) forKey:@"sc"];
    [postDataDic setObject:[self signStringForParams:postDataDic] forKey:@"sign"];
    
    NSString *url = [NSString stringWithFormat:@"%@?cmd=%@",kOnlineServiceServerHost, @"getCStatus"];
    
    HTTPMSG_RELEASE_SAFELY(getCStatusHttpMsg);
    getCStatusHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                   requestUrl:url
                                                  postDataDic:postDataDic
                                                      cmdCode:CC_OSGetCStatus];
//    getB2CStatusHttpMsg.requestMethod=RequestMethodGet;
    [self.httpMsgCtrl sendHttpMsg:getCStatusHttpMsg];
}

- (void)parseGetCStatusInfo:(NSDictionary *)items
{
    BOOL isSuccess = NO;
    if (items)
    {
        self.shopType = SNShopTypeC;
        NSString *code = EncodeStringFromDic(items, @"code");
        if ([code isEqualToString:@"1"])
        {
            self.code = 1;
            isSuccess = YES;
        }
        else if ([code isEqualToString:@"0"])
        {
            self.code = 0;
            self.errorMsg = kOSChatServerErrorMsg;
            isSuccess = YES;
        }
        else if ([code isEqualToString:@"-1"])
        {
            self.code = -1;
            self.errorMsg = kOSChatServerErrorMsg;
            isSuccess = YES;
        }
        else
        {
            self.errorMsg = kOSChatServerErrorMsg;
        }
    }
    else
    {
        self.errorMsg = kOSChatServerErrorMsg;
    }
    [self getCStatusOk:isSuccess];
    
}

- (void)getCStatusOk:(BOOL)isSuccess
{
    if ([_delegate respondsToSelector:@selector(osService:getCStatusComplete:)])
    {
        [_delegate osService:self getCStatusComplete:isSuccess];
    }
}

#pragma mark ----------------------------- 建立对话 B2C

- (void)requestCreateB2CChat:(NSString *)b2cGroupId GId:(NSString *)gId GroupMember:(NSString *)groupMember ClassCode:(NSString *)classCode UserId:(NSString *)userId CustNo:(NSString *)custNo NickName:(NSString *)nickName ProductName:(NSString *)productName ProductCode:(NSString *)productCode OrderNo:(NSString *)orderNo
{
    NSMutableDictionary *postDataDic = [NSMutableDictionary dictionary];
    if (b2cGroupId.length) {
        [postDataDic setObject:b2cGroupId forKey:@"b2cGroupId"];
    }
    if (gId.length) {
        [postDataDic setObject:gId forKey:@"gId"];
    }
    if (groupMember.length) {
        [postDataDic setObject:groupMember forKey:@"groupmember"];
    }
    if (classCode.length) {
        [postDataDic setObject:classCode forKey:@"classCode"];
    }
    if (userId.length) {
        [postDataDic setObject:userId forKey:@"usersId"];
    }
    if (custNo.length) {
        [postDataDic setObject:custNo forKey:@"custNo"];
    }
    if (nickName.length) {
        [postDataDic setObject:nickName forKey:@"nick"];
    }
    if (productName) {
        [postDataDic setObject:productName forKey:@"pn"];
    }
    if (productCode) {
        [postDataDic setObject:productCode forKey:@"pno"];
    }
    if (orderNo) {
        [postDataDic setObject:orderNo forKey:@"or"];
    }
    
    [postDataDic setObject:[self signStringForParams:postDataDic] forKey:@"sign"];
    
    NSString *url = [NSString stringWithFormat:@"%@?cmd=%@",kOnlineServiceServerHost, @"b2cChat"];
    
    HTTPMSG_RELEASE_SAFELY(createB2CChatHttpMsg);
    createB2CChatHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                      requestUrl:url
                                                     postDataDic:postDataDic
                                                         cmdCode:CC_OSCreateB2CChat];
//    createB2CChatHttpMsg.requestMethod=RequestMethodGet;
    [self.httpMsgCtrl sendHttpMsg:createB2CChatHttpMsg];
}

- (void)parseCreateB2CChatInfo:(NSDictionary *)items
{
    BOOL isSuccess = NO;
    if (items)
    {
        NSString *code = EncodeStringFromDic(items, @"code");
        NSString *companyId = EncodeStringFromDic(items, @"companyId");
        
        if (companyId.integerValue > 10000)
        {
            self.shopType = SNShopTypeB2CA;
        }
        else
        {
            self.shopType = SNShopTypeB2C;
        }
        
        if ([code isEqualToString:@"1"])
        {
            self.code = 1;
            isSuccess = YES;
            
            OSChatDTO *dto = [[OSChatDTO alloc] init];
            [dto encodeFromDictionary:items];
            self.chat = dto;
        }
        else if ([code isEqualToString:@"0"])
        {
            self.code = 0;
            self.errorMsg = kOSChatServerErrorMsg;
            isSuccess = NO;
        }
        else if ([code isEqualToString:@"-1"])
        {
            self.code = -1;
            self.errorMsg = kOSChatServerErrorMsg;
            isSuccess = NO;
        }
        else if ([code isEqualToString:@"2"])
        {
            self.code = 2;
            isSuccess = YES;
            
            OSChatDTO *dto = [[OSChatDTO alloc] init];
            [dto encodeFromDictionary:items];
            self.chat = dto;
        }
        else
        {
            self.errorMsg = kOSChatServerErrorMsg;
        }
    }
    else
    {
        self.errorMsg = kOSChatServerErrorMsg;
        isSuccess = NO;
    }
    [self createB2CChatOk:isSuccess];
}

- (void)createB2CChatOk:(BOOL)isSuccess
{
    if ([_delegate respondsToSelector:@selector(osService:createB2CChatComplete:)])
    {
        [_delegate osService:self createB2CChatComplete:isSuccess];
    }
}

#pragma mark ----------------------------- 建立对话C店

- (void)requestCreateCChat:(NSString *)shopCode UserId:(NSString *)userId CustNo:(NSString *)custNo NickName:(NSString *)nickName ProductName:(NSString *)productName ProductCode:(NSString *)productCode OrderNo:(NSString *)orderNo
{
    NSMutableDictionary *postDataDic = [NSMutableDictionary dictionary];
    [postDataDic setObject:POST_VALUE(shopCode) forKey:@"sc"];
    if (userId.length) {
        [postDataDic setObject:userId forKey:@"usersId"];
    }
    if (custNo.length) {
        [postDataDic setObject:custNo forKey:@"custNo"];
    }
    if (nickName.length) {
        [postDataDic setObject:nickName forKey:@"nick"];
    }
    if (productName) {
        [postDataDic setObject:POST_VALUE(productName) forKey:@"pn"];
    }
    if (productCode) {
        [postDataDic setObject:productCode forKey:@"pno"];
    }
    if (orderNo) {
        [postDataDic setObject:POST_VALUE(orderNo) forKey:@"or"];
    }
    
    [postDataDic setObject:[self signStringForParams:postDataDic] forKey:@"sign"];
    
    NSString *url = [NSString stringWithFormat:@"%@?cmd=%@",kOnlineServiceServerHost, @"cChat"];
    
    HTTPMSG_RELEASE_SAFELY(createCChatHttpMsg);
    createCChatHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                    requestUrl:url
                                                   postDataDic:postDataDic
                                                       cmdCode:CC_OSCreateCChat];
//    createCChatHttpMsg.requestMethod=RequestMethodGet;

    [self.httpMsgCtrl sendHttpMsg:createCChatHttpMsg];
}

- (void)parseCreateCChatInfo:(NSDictionary *)items
{
    BOOL isSuccess = NO;
    if (items)
    {
        NSString *code = EncodeStringFromDic(items, @"code");
        if ([code isEqualToString:@"1"])
        {
            self.code = 1;
            isSuccess = YES;
            OSChatDTO *dto = [[OSChatDTO alloc] init];
            [dto encodeFromDictionary:items];
            self.chat = dto;
        }
        else if ([code isEqualToString:@"0"])
        {
            self.code = 0;
            self.errorMsg = kOSChatServerErrorMsg;
        }
        else if ([code isEqualToString:@"-1"])
        {
            self.code = -1;
            self.errorMsg = kOSChatServerErrorMsg;
        }
        else if ([code isEqualToString:@"2"])
        {
            self.code = 2;
            isSuccess = YES;
            
            OSChatDTO *dto = [[OSChatDTO alloc] init];
            [dto encodeFromDictionary:items];
            self.chat = dto;
        }
        else
        {
            self.errorMsg = kOSChatServerErrorMsg;
        }
    }
    else
    {
        self.errorMsg = kOSChatServerErrorMsg;
    }
    [self createCChatOk:isSuccess];
}

- (void)createCChatOk:(BOOL)isSuccess
{
    if ([_delegate respondsToSelector:@selector(osService:createCChatComplete:)])
    {
        [_delegate osService:self createCChatComplete:isSuccess];
    }
}

#pragma mark ----------------------------- 访客排队

- (void)requestWaitQueue:(OSChatDTO *)waitingChat
{
    NSMutableDictionary *postDataDic = [NSMutableDictionary dictionary];
    [postDataDic setObject:POST_VALUE(waitingChat.companyId) forKey:@"companyId"];
    [postDataDic setObject:POST_VALUE(waitingChat.gId) forKey:@"gId"];
    [postDataDic setObject:POST_VALUE(waitingChat.vId) forKey:@"vId"];
    [postDataDic setObject:[self signStringForParams:postDataDic] forKey:@"sign"];
    
    self.chat = waitingChat;
    
    NSString *url = [NSString stringWithFormat:@"%@?cmd=%@",kOnlineServiceServerHost, @"waitQueue"];
    
    HTTPMSG_RELEASE_SAFELY(waitQueueHttpMsg);
    waitQueueHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                  requestUrl:url
                                                 postDataDic:postDataDic
                                                     cmdCode:CC_OSWaitQueue];
//    waitQueueHttpMsg.requestMethod=RequestMethodGet;

    [self.httpMsgCtrl sendHttpMsg:waitQueueHttpMsg];
}

- (void)parseWaitQueueInfo:(NSDictionary *)items
{
    BOOL isSuccess = NO;
    if (items)
    {
        NSString *code = EncodeStringFromDic(items, @"code");
        if ([code isEqualToString:@"1"])
        {
            self.code = 1;
            isSuccess = YES;
            
            self.chat.chatId = EncodeStringFromDic(items, @"chatId");
            self.chat.customerId = EncodeStringFromDic(items, @"customerId");
            self.chat.nickName = EncodeStringFromDic(items, @"nickName");
            self.chat.greeting = EncodeStringFromDic(items, @"greeting");
        }
        else if ([code isEqualToString:@"0"])
        {
            self.code = 0;
            NSString *waitQueueId = EncodeStringFromDic(items, @"waitQueueId");
            //实际从0开始
            self.chat.waitQueueId = STR_FROM_INT([waitQueueId integerValue]+1);
            isSuccess = YES;
        }
        else
        {
            self.errorMsg = kOSChatServerErrorMsg;
        }
    }
    else
    {
        self.errorMsg = kHttpResponseJSONValueFailError;
    }
    [self waitQueueOk:isSuccess];
}

- (void)waitQueueOk:(BOOL)isSuccess
{
    if ([_delegate respondsToSelector:@selector(osService:waitQueueComplete:)])
    {
        [_delegate osService:self waitQueueComplete:isSuccess];
    }
}

#pragma mark ----------------------------- 退出排队

- (void)requestQuitWaitQueue:(NSString *)companyId GId:(NSString *)gId VId:(NSString *)vId
{
    NSMutableDictionary *postDataDic = [NSMutableDictionary dictionary];
    [postDataDic setObject:POST_VALUE(companyId) forKey:@"companyId"];
    [postDataDic setObject:POST_VALUE(gId) forKey:@"gId"];
    [postDataDic setObject:POST_VALUE(vId) forKey:@"vId"];
    [postDataDic setObject:[self signStringForParams:postDataDic] forKey:@"sign"];
    
    NSString *url = [NSString stringWithFormat:@"%@?cmd=%@",kOnlineServiceServerHost, @"exitWaitQueue"];
    
    HTTPMSG_RELEASE_SAFELY(quitWaitQueueHttpMsg);
    quitWaitQueueHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                      requestUrl:url
                                                     postDataDic:postDataDic
                                                         cmdCode:CC_OSExitWaitQueue];
//    quitWaitQueueHttpMsg.requestMethod=RequestMethodGet;

    [self.httpMsgCtrl sendHttpMsg:quitWaitQueueHttpMsg];
}

- (void)parseQuitWaitQueueInfo:(NSDictionary *)items
{
    BOOL isSuccess = NO;
    if (items)
    {
        NSString *code = EncodeStringFromDic(items, @"code");
        if ([code isEqualToString:@"1"])
        {
            self.code = 1;
            isSuccess = YES;
        }
        else
        {
            self.errorMsg = L(@"OnlineService_ExitQueueFail");
        }
    }
    else
    {
        self.errorMsg = kHttpResponseJSONValueFailError;
    }
    [self quitWaitQueueOk:isSuccess];
}

- (void)quitWaitQueueOk:(BOOL)isSuccess
{
    if ([_delegate respondsToSelector:@selector(osService:quitWaitQueueComplete:)])
    {
        [_delegate osService:self quitWaitQueueComplete:isSuccess];
    }
}

#pragma mark ----------------------------- 发送消息

- (void)requestSendMsg:(OSMsgDTO *)message
            customerId:(NSString *)customerId
             CompanyId:(NSString *)companyId
                ChatId:(NSString *)chatId
                   VId:(NSString *)vId

{
    self.msgDTO = message;
    
    NSMutableDictionary *postDataDic = [NSMutableDictionary dictionary];
    [postDataDic setObject:POST_VALUE(customerId) forKey:@"customerId"];
    [postDataDic setObject:POST_VALUE(chatId) forKey:@"chatId"];
    [postDataDic setObject:POST_VALUE(companyId) forKey:@"companyId"];
    [postDataDic setObject:POST_VALUE(vId) forKey:@"vId"];
    [postDataDic setObject:POST_VALUE(message.msg) forKey:@"msg"];
    [postDataDic setObject:[self signStringForParams:postDataDic] forKey:@"sign"];
    
    NSString *url = [NSString stringWithFormat:@"%@?cmd=%@",kOnlineServiceServerHost, @"sendMsg"];
    
    HTTPMSG_RELEASE_SAFELY(sendMsgHttpMsg);
    sendMsgHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                      requestUrl:url
                                                     postDataDic:postDataDic
                                                         cmdCode:CC_OSSendMsg];
//    sendMsgHttpMsg.requestMethod=RequestMethodGet;

    [self.httpMsgCtrl sendHttpMsg:sendMsgHttpMsg];
}

- (void)parseSendMsgInfo:(NSDictionary *)items
{
    BOOL isSuccess = NO;
    if (items)
    {
        NSString *code = EncodeStringFromDic(items, @"code");
        if ([code isEqualToString:@"1"])
        {
            self.code = 1;
            isSuccess = YES;
        }
        else
        {
            self.errorMsg = L(@"OnlineService_SendFail");
        }
    }
    else
    {
        self.errorMsg = kHttpResponseJSONValueFailError;
    }
    [self sendMsgOk:isSuccess];
}

- (void)sendMsgOk:(BOOL)isSuccess
{
    if ([_delegate respondsToSelector:@selector(osService:sendMsgComplete:)])
    {
        [_delegate osService:self sendMsgComplete:isSuccess];
    }
}

#pragma mark ----------------------------- 接收消息及保活

- (void)requestGetMsg:(NSString *)companyId ChatId:(NSString *)chatId VId:(NSString *)vId
{
    //清空上次的返回
    self.messageArray = nil;
    
    NSMutableDictionary *postDataDic = [NSMutableDictionary dictionary];
    [postDataDic setObject:POST_VALUE(companyId) forKey:@"companyId"];
    [postDataDic setObject:POST_VALUE(chatId) forKey:@"chatId"];
    [postDataDic setObject:POST_VALUE(vId) forKey:@"vId"];
    [postDataDic setObject:[self signStringForParams:postDataDic] forKey:@"sign"];
    
    NSString *url = [NSString stringWithFormat:@"%@?cmd=%@",kOnlineServiceServerHostGetMessage, @"getMsg"];
    
    HTTPMSG_RELEASE_SAFELY(getMsgHttpMsg);
    getMsgHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                requestUrl:url
                                               postDataDic:postDataDic
                                                   cmdCode:CC_OSGetMessage];
//    getMsgHttpMsg.requestMethod = RequestMethodGet;
    [self.httpMsgCtrl sendHttpMsg:getMsgHttpMsg];
}

- (void)parseGetMsgInfo:(NSDictionary *)items
{
    BOOL isSuccess = NO;
    if (items)
    {
        self.code = 1;
        isSuccess = YES;
        
        self.messageArray = EncodeArrayFromDicUsingParseBlock(items, @"msgs", ^id(NSDictionary *innerDic) {
            
            OSMsgDTO *dto = [[OSMsgDTO alloc] init];
            [dto encodeFromDictionary:innerDic];
            return dto;
        });
    }
    else
    {
        self.errorMsg = kHttpResponseJSONValueFailError;
    }
    [self getMsgOk:isSuccess];

}

- (void)getMsgOk:(BOOL)isSuccess
{
    if ([_delegate respondsToSelector:@selector(osService:getMsgComplete:)])
    {
        [_delegate osService:self getMsgComplete:isSuccess];
    }
}

#pragma mark ----------------------------- 结束对话

- (void)requestEndChat:(NSString *)companyId ChatId:(NSString *)chatId VId:(NSString *)vId
{
    NSMutableDictionary *postDataDic = [NSMutableDictionary dictionary];
    [postDataDic setObject:POST_VALUE(companyId) forKey:@"companyId"];
    [postDataDic setObject:POST_VALUE(chatId) forKey:@"chatId"];
    [postDataDic setObject:POST_VALUE(vId) forKey:@"vId"];
    [postDataDic setObject:[self signStringForParams:postDataDic] forKey:@"sign"];
    
    NSString *url = [NSString stringWithFormat:@"%@?cmd=%@",kOnlineServiceServerHost, @"endChat"];
    
    HTTPMSG_RELEASE_SAFELY(endChatHttpMsg);
    endChatHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                               requestUrl:url
                                              postDataDic:postDataDic
                                                  cmdCode:CC_OSEndChat];
//    endChatHttpMsg.requestMethod = RequestMethodGet;

    [self.httpMsgCtrl sendHttpMsg:endChatHttpMsg];
}

- (void)parseEndChatInfo:(NSDictionary *)items
{
    BOOL isSuccess = NO;
    if (items)
    {
        NSString *code = EncodeStringFromDic(items, @"code");
        if ([code isEqualToString:@"1"])
        {
            self.code = 1;
            isSuccess = YES;
        }
        else
        {
            self.errorMsg = L(@"OnlineService_Fail");
        }
    }
    else
    {
        self.errorMsg = kHttpResponseJSONValueFailError;
    }
    [self endChatOk:isSuccess];
}

- (void)endChatOk:(BOOL)isSuccess
{
    if ([_delegate respondsToSelector:@selector(osService:endChatComplete:)])
    {
        [_delegate osService:self endChatComplete:isSuccess];
    }
}

#pragma mark ----------------------------- 评价

- (void)requestOpinion:(NSString *)opinion CompanyId:(NSString *)companyId ChatId:(NSString *)chatId VId:(NSString *)vId Desp:(NSString *)desp
{
    NSMutableDictionary *postDataDic = [NSMutableDictionary dictionary];
    [postDataDic setObject:POST_VALUE(companyId) forKey:@"companyId"];
    [postDataDic setObject:POST_VALUE(chatId) forKey:@"chatId"];
    [postDataDic setObject:POST_VALUE(vId) forKey:@"vId"];
    [postDataDic setObject:POST_VALUE(opinion) forKey:@"opinion"];
    [postDataDic setObject:POST_VALUE(desp) forKey:@"desp"];
    [postDataDic setObject:[self signStringForParams:postDataDic] forKey:@"sign"];
    
    NSString *url = [NSString stringWithFormat:@"%@?cmd=%@",kOnlineServiceServerHost, @"opinion"];
    
    HTTPMSG_RELEASE_SAFELY(opinionHttpMsg);
    opinionHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                requestUrl:url
                                               postDataDic:postDataDic
                                                   cmdCode:CC_OSOpinion];
//    opinionHttpMsg.requestMethod = RequestMethodGet;

    [self.httpMsgCtrl sendHttpMsg:opinionHttpMsg];
}

- (void)parseOpinionInfo:(NSDictionary *)items
{
    BOOL isSuccess = NO;
    if (items)
    {
        NSString *code = EncodeStringFromDic(items, @"code");
        if ([code isEqualToString:@"1"])
        {
            self.code = 1;
            isSuccess = YES;
        }
        else
        {
            self.errorMsg = L(@"OnlineService_EvaluateFail");
        }
    }
    else
    {
        self.errorMsg = kHttpResponseJSONValueFailError;
    }
    [self opinionOk:isSuccess];
}

- (void)opinionOk:(BOOL)isSuccess
{
    if ([_delegate respondsToSelector:@selector(osService:opinionComplete:)])
    {
        [_delegate osService:self opinionComplete:isSuccess];
    }
}

#pragma mark ----------------------------- 给商家留言

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
                    Contact:(NSString *)contact
{
    NSMutableDictionary *postDataDic = [NSMutableDictionary dictionary];
    if (shopCode.length) {
        [postDataDic setObject:shopCode forKey:@"sc"];
    }
    else
    {
        [postDataDic setObject:POST_VALUE(groupMember) forKey:@"groupmember"];
        [postDataDic setObject:POST_VALUE(classCode) forKey:@"classCode"];
    }
    [postDataDic setObject:POST_VALUE(userId) forKey:@"usersId"];
    [postDataDic setObject:POST_VALUE(custNo) forKey:@"custNo"];
    [postDataDic setObject:POST_VALUE(nickName) forKey:@"nick"];
    [postDataDic setObject:POST_VALUE(title) forKey:@"title"];
    [postDataDic setObject:POST_VALUE(context) forKey:@"context"];
    if (productCode.length) {
        [postDataDic setObject:productCode forKey:@"pno"];
    }
    if (orderNo.length) {
        [postDataDic setObject:orderNo forKey:@"or"];
    }
    if (contact.length) {
        [postDataDic setObject:contact forKey:@"contact"];
    }
    
    [postDataDic setObject:[self signStringForParams:postDataDic] forKey:@"sign"];
    
    NSString *url = [NSString stringWithFormat:@"%@?cmd=%@",kOnlineServiceServerHost, @"leaveMsg"];
    
    HTTPMSG_RELEASE_SAFELY(leaveMsgHttpMsg);
    leaveMsgHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                requestUrl:url
                                               postDataDic:postDataDic
                                                   cmdCode:CC_OSLeaveMessage];
//    leaveMsgHttpMsg.requestMethod =RequestMethodGet;
    [self.httpMsgCtrl sendHttpMsg:leaveMsgHttpMsg];
}

- (void)parseLeaveMsgInfo:(NSDictionary *)items
{
    BOOL isSuccess = NO;
    if (items)
    {
        NSString *code = EncodeStringFromDic(items, @"code");
        if ([code isEqualToString:@"1"])
        {
            self.code = 1;
            isSuccess = YES;
        }
        else if ([code isEqualToString:@"-1"])
        {
            self.code = -1;
            self.errorMsg = L(@"OnlineService_NotHaveThisMerchant");
        }
        else
        {
            self.errorMsg = L(@"OnlineService_LeaveMessageFail");
        }
    }
    else
    {
        self.errorMsg = kHttpResponseJSONValueFailError;
    }
    [self leaveMsgOk:isSuccess];
}

- (void)leaveMsgOk:(BOOL)isSuccess
{
    if ([_delegate respondsToSelector:@selector(osService:leaveMessageComplete:)])
    {
        [_delegate osService:self leaveMessageComplete:isSuccess];
    }
}

#pragma mark ----------------------------- 获取快速提问列表

- (void)requestQuickAskList
{
    //取缓存
    NSData *cacheData = [[SNFileCache defaultCache] dataForKey:kOSChatQuickAskCacheKey];
    if (cacheData) {
        NSArray *cacheList = [NSKeyedUnarchiver unarchiveObjectWithData:cacheData];
        if ([cacheList isKindOfClass:[NSArray class]] && [cacheList count] > 0)
        {
            self.quickAskList = cacheList;
            [self getQuickAskOk:YES];
            return;
        }
    }
    
    NSMutableDictionary *postDataDic = [NSMutableDictionary dictionary];
    [postDataDic setObject:[self signStringForParams:postDataDic] forKey:@"sign"];
    
    NSString *url = [NSString stringWithFormat:@"%@?cmd=%@",kOnlineServiceServerHost, @"quickAsk"];
    
    HTTPMSG_RELEASE_SAFELY(quickAskHttpMsg);
    quickAskHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                 requestUrl:url
                                                postDataDic:postDataDic
                                                    cmdCode:CC_OSQuickAsk];
//    quickAskHttpMsg.requestMethod =RequestMethodGet;
    [self.httpMsgCtrl sendHttpMsg:quickAskHttpMsg];
}

- (void)parseQuickAskInfo:(NSDictionary *)items
{
    BOOL isSuccess = NO;
    if (items)
    {
        isSuccess = YES;
        
        self.quickAskList = EncodeArrayFromDic(items, @"list");
        //存缓存
        if ([self.quickAskList count])
        {
            NSData *cacheData = [NSKeyedArchiver archivedDataWithRootObject:self.quickAskList];
            [[SNFileCache defaultCache] saveData:cacheData forKey:kOSChatQuickAskCacheKey];
        }
    }
    else
    {
        self.errorMsg = kHttpResponseJSONValueFailError;
    }
    [self getQuickAskOk:isSuccess];
}

- (void)getQuickAskOk:(BOOL)isSuccess
{
    if ([_delegate respondsToSelector:@selector(osService:getQuickAskListComplete:)])
    {
        [_delegate osService:self getQuickAskListComplete:isSuccess];
    }
}

@end
