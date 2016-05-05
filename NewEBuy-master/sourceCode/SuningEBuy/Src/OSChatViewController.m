//
//  OSChatViewController.m
//  SuningEBuy
//
//  Created by  liukun on 13-11-25.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "OSChatViewController.h"
#import "OSEmoticonView.h"
#import "EGOPhotoViewController.h"
#import "MyPhoto.h"
#import "MyPhotoSource.h"
#import "OSQuitChatCommand.h"
#import "OSOpinionView.h"
#import "SNUITextView.h"
#import "OSLeaveMessageViewController.h"
#import "ProductUtil.h"
#import "SNWebViewController.h"

#define OSChat_DEBUG            0
#define OS_TextView_Margin      7
#define OS_TextView_FixHeight   7
#define OS_TextView_Font        ([UIFont systemFontOfSize:15])
#define OS_TextView_LineHeight  (OS_TextView_Font.lineHeight)


@interface OSChatViewController () <UITextViewDelegate,OSEmoticonViewDelegate,OSOpinionViewDelegate>
{
    CGFloat _keyboardHeight;
    BOOL    _inSending;
    BOOL    _isShowEmoticonView;
    int     _textNumberOfLines;
    UIBackgroundTaskIdentifier _backgroundTask;
    
    int     _waitQueueCount;    //当前排队人数
    
    BOOL    _needOpinion;       //是否需要评价
}


@property (nonatomic, strong) UIView *bottomInputBar;
@property (nonatomic, strong) UIImageView *bottomInputBgImageView;
@property (nonatomic, strong) SNUITextView *inputTextView;
@property (nonatomic, strong) UIImageView *inputBgImageView;
@property (nonatomic, strong) UIButton *emoticonButton;
@property (nonatomic, strong) UIButton *moreButton;
@property (nonatomic, strong) OSEmoticonView *emoticonView;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSArray *quickAskList;
@property (nonatomic, strong) UIView *productHeaderView;

@end

@implementation OSChatViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    SERVICE_RELEASE_SAFELY(_service);
}

- (id)init
{
    self = [super init];
    if (self) {
        self.title = L(@"OnlineService_OnlineConsultant");
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillChangeFrameNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationDidBecomeActive:)
                                                     name:UIApplicationDidBecomeActiveNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationDidEnterBackground:)
                                                     name:UIApplicationDidEnterBackgroundNotification
                                                   object:nil];
        //初始化一个
        self.chatDTO = [[OSChatDTO alloc] init];
        
        //开始是1行
        _textNumberOfLines = 1;
        
        //制造测试数据
#if OSChat_DEBUG
        
        self.chatDTO = [[OSChatDTO alloc] init];
        NSDate *date = [NSDate date];
        {
            OSMsgDTO *msg = [[OSMsgDTO alloc] init];
            msg.msg = @"您好，请问有什么可以为你服务的?:)我了个去";
            msg.time = [date dateByAddingTimeInterval:1];
            [self addMsg:msg toChat:self.chatDTO];
        }
        {
            OSMsgDTO *msg = [[OSMsgDTO alloc] init];
            msg.msg = @"我买了xxx:'(";
            msg.isSelf = YES;
            msg.time = [date dateByAddingTimeInterval:60];
            [self addMsg:msg toChat:self.chatDTO];
        }
        {
            OSMsgDTO *msg = [[OSMsgDTO alloc] init];
            msg.msg = @"您好，请问有什么可以为你服务的?:):):):):):)嘎嘎";
            msg.time = [date dateByAddingTimeInterval:190];
            [self addMsg:msg toChat:self.chatDTO];
        }
        {
            OSMsgDTO *msg = [[OSMsgDTO alloc] init];
            msg.type = OSMsgScreenShot;
            msg.msg = @"http://sale.suning.com/images/advertise/001/tiqiangou/images/tqg201312012318_01.jpg";
            msg.time = [date dateByAddingTimeInterval:200];
            msg.sendType = OSMessageSending;
            [self addMsg:msg toChat:self.chatDTO];
        }
        {
            OSMsgDTO *msg = [[OSMsgDTO alloc] init];
            msg.msg = @"我的衣服怎么还没送到:'(，物流烂死了";
            msg.time = [date dateByAddingTimeInterval:210];
            msg.isSelf = YES;
            msg.sendType = OSMessageSendFail;
            [self addMsg:msg toChat:self.chatDTO];
        }
        {
            OSMsgDTO *msg = [[OSMsgDTO alloc] init];
            msg.msg = @"要求退货！！！！";
            msg.time = [date dateByAddingTimeInterval:220];
            msg.isSelf = YES;
            msg.sendType = OSMessageWaitForSend;
            [self addMsg:msg toChat:self.chatDTO];
        }
        {
            OSMsgDTO *msg = [[OSMsgDTO alloc] init];
            msg.msg = @"要求退货！！！！";
            msg.time = [date dateByAddingTimeInterval:230];
            msg.type = OSMsgOpinion;
            [self addMsg:msg toChat:self.chatDTO];
        }
        
#endif
        
        self.bSupportPanUI = NO;
    }
    return self;
}

//inits
- (id)initAsB2CShop:(NSString *)b2cGroupId productName:(NSString *)productName productCode:(NSString *)productCode //商家
{
    self = [self init];
    
    if (self)
    {
        self.chatType = OSChatTypeB2CShop;
        self.b2cGroupId = b2cGroupId;
        self.productName = productName;
        self.productCode = productCode;
    }
    
    return self;
}

- (id)initAsAShop:(NSString *)b2cGroupId GroupMember:(NSString *)groupMember ClassCode:(NSString *)classCode productName:(NSString *)productName productCode:(NSString *)productCode
{
    self = [self init];
    
    if (self)
    {
        self.chatType = OSChatTypeB2CShopA;
        self.groupMember = groupMember;
        self.classCode = classCode;
        self.b2cGroupId = b2cGroupId;
        self.productName = productName;
        self.productCode = productCode;
    }
    
    return self;
}

- (id)initAsB2COrderDetailWithOrderNo:(NSString *)orderNo //订单详情
{
    self = [self init];
    
    if (self)
    {
        self.chatType = OSChatTypeB2COrderDetail;
        self.gId = kOSGIDOrderCenter;
        self.orderNo = orderNo;
    }
    
    return self;
}

- (id)initAsB2CDeliveryInstallWithOrderNo:(NSString *)orderNo
{
    self = [self init];
    
    if (self)
    {
        self.chatType = OSChatTypeB2CDeliveryInstall;
        self.gId = kOSGIDDeliveryInstall;
        self.orderNo = orderNo;
    }
    
    return self;
}

- (id)initASB2CFeedBackWithOrderNo:(NSString *)orderNo
{
    self = [self init];
    
    if (self)
    {
        self.chatType = OSChatTypeB2CFeedBack;
        self.gId = kOSGIDFeedBack;
        self.orderNo = orderNo;
    }
    
    return self;
}


- (id)initAsB2CReturnOrderWithOrderNo:(NSString *)orderNo //退货
{
    self = [self init];
    
    if (self)
    {
        self.chatType = OSChatTypeB2CReturnGoods;
        self.gId = kOSGIDReturnGoods;
        self.orderNo = orderNo;
    }
    
    return self;
}

- (id)initAsCShop:(NSString *)shopCode ProductName:(NSString *)productName ProductCode:(NSString *)productCode OrderNo:(NSString *)orderNo
{
    self = [self init];
    
    if (self)
    {
        self.chatType = OSChatTypeCShop;
        self.shopCode = shopCode;
        self.productName = productName;
        self.productCode = productCode;
        self.orderNo = orderNo;
    }
    
    return self;
}

#pragma mark ----------------------------- view lify cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    SNBarButtonItem *item = [[SNBarButtonItem alloc]
                             initWithSNStyle:SNBarItemStyleLight
                             title:L(@"Evaluate")
                             target:self
                             selector:@selector(userChooseOpinion:withOption:)];
    
    self.navigationItem.rightBarButtonItem = item;
    item.enabled = NO;
    
    CGRect frame = [self visibleBoundsShowNav:YES showTabBar:NO];
    frame.size.height -= [self getBottomBarHeight];
    self.tableView.frame = frame;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    self.bottomInputBar.top = [self getBottomBarTop];
    [self.view addSubview:self.bottomInputBar];
    
    //展示商品链接
    
}

- (void)sendProductUrl:(id)sender
{
    NSString *url = [NSString stringWithFormat:@"%@/product/%@/%@.html",kEbuyWapHostURL, self.shopCode.length?self.shopCode:@"0000000000", self.productCode];
    [self sendMessage:url];
}

- (void)righBarClick
{
    [self userChooseOpinion:nil withOption:2];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.service setDelegate:self];//防止代理回调,重启_timer 对应
    
    //建立对话
    [self createChat];
    
    //获取快速询问列表
    [self requestQuickAskList];//12.获取快速提问

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.service setDelegate:nil];//防止代理回调,重启_timer
    
    TT_INVALIDATE_TIMER(_timer);
}

- (void)backForePage
{
    //如果需要评价
    if (_needOpinion && (self.chatDTO.chatState == OSChatStateOnChat || self.chatDTO.chatState == OSChatStateEnd))
    {
        [self userChooseOpinion:@{@"complete": [^{
            [self dismissViewControllerAnimated:YES completion:NULL];
        } copy]} withOption:1];
//        _needOpinion = NO;
        return;
    }
    
    //无论是在排队还是接收消息停止计时器
    TT_INVALIDATE_TIMER(_timer);
    
    //退出交谈
    OSQuitChatCommand *cmd = [[OSQuitChatCommand alloc] initWithChat:self.chatDTO];
    [CommandManage excuteCommand:cmd completeBlock:NULL];
    
    //dismiss
    [self dismissModalViewControllerAnimated:YES];
}

//结束后台线程
- (void)endBackgroundTask
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (_backgroundTask != UIBackgroundTaskInvalid) {
            [[UIApplication sharedApplication] endBackgroundTask:_backgroundTask];
            _backgroundTask = UIBackgroundTaskInvalid;
        }
    });
}

- (void)applicationDidBecomeActive:(NSNotification *)notification
{
    [self endBackgroundTask];
}

- (void)applicationDidEnterBackground:(NSNotification *)notification
{
    if (!_backgroundTask || _backgroundTask == UIBackgroundTaskInvalid)
    {
        [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (_backgroundTask != UIBackgroundTaskInvalid)
                {
                    [[UIApplication sharedApplication] endBackgroundTask:_backgroundTask];
                    _backgroundTask = UIBackgroundTaskInvalid;
                    TT_INVALIDATE_TIMER(_timer);
                    //如果在排队中或者是聊天中，则退出
                    [self quitChat];
                }
            });
        }];
    }
}

#pragma mark ----------------------------- controller

/**
 *  添加跳入离线留言的逻辑
 *  @author     liukun
 *  @date       2014/7/8
 *  @since      2.4.1
 */
- (void)goToLeaveMessageOrQuit
{
    if (self.chatType == OSChatTypeB2CShopA)
    {
        BBAlertView *alert = [[BBAlertView alloc]
                              initWithTitle:L(@"system-info")
                              message:L(@"OnlineService_CustomerServiceNotOn")
                              delegate:nil
                              cancelButtonTitle:L(@"Back")
                              otherButtonTitles:L(@"OnlineService_LeaveOneMessage")];
        [alert setConfirmBlock:^{
            
            UIViewController *presentingVC = self.presentingViewController;
            [self dismissViewControllerAnimated:NO completion:^{
                OSLeaveMessageViewController *vc = [[OSLeaveMessageViewController alloc] initWithAGroupMember:self.groupMember vendorName:self.vendorName classCode:self.classCode ProductCode:self.productCode ProductName:self.productName OrderId:nil];
                AuthManagerNavViewController *nav = [[AuthManagerNavViewController alloc] initWithRootViewController:vc];
                [presentingVC presentModalViewController:nav animated:YES];
            }];
        }];
        [alert setCancelBlock:^{
            [self dismissViewControllerAnimated:YES completion:NULL];
        }];
        [alert show];
    }
    else if (self.chatType == OSChatTypeCShop)
    {
        BBAlertView *alert = [[BBAlertView alloc]
                              initWithTitle:L(@"system-info")
                              message:L(@"OnlineService_CustomerServiceNotOn")
                              delegate:nil
                              cancelButtonTitle:L(@"Back")
                              otherButtonTitles:L(@"OnlineService_LeaveOneMessage")];
        [alert setConfirmBlock:^{
            
            UIViewController *presentingVC = self.presentingViewController;
            [self dismissViewControllerAnimated:NO completion:^{
                OSLeaveMessageViewController *vc = [[OSLeaveMessageViewController alloc] initWithShopCode:self.shopCode ShopName:self.vendorName ProductCode:self.productCode ProductName:self.productName OrderId:self.orderNo];
                AuthManagerNavViewController *nav = [[AuthManagerNavViewController alloc] initWithRootViewController:vc];
                [presentingVC presentModalViewController:nav animated:YES];
            }];
        }];
        [alert setCancelBlock:^{
            [self dismissViewControllerAnimated:YES completion:NULL];
        }];
        [alert show];
    }
    else
    {
        BBAlertView *alert = [[BBAlertView alloc]
                              initWithTitle:L(@"system-info")
                              message:kOSChatServerErrorMsg
                              delegate:nil
                              cancelButtonTitle:L(@"Ok")
                              otherButtonTitles:nil];
        [alert setCancelBlock:^{
            [self dismissViewControllerAnimated:YES completion:NULL];
        }];
        [alert show];
    }
}

- (void)addMsg:(OSMsgDTO *)message toChat:(OSChatDTO *)chat
{
    //如果是对话已结束，则不进行添加
    if (chat.chatState == OSChatStateEnd)
    {
        return;
    }
    
    //计算是否要显示时间
    OSMsgDTO *preMsg = [chat.sessionMsgs lastObject];
    if (preMsg)
    {
        NSTimeInterval last = [message.time timeIntervalSinceDate:preMsg.time];
        if (last > 120) //大于两分钟
        {
            message.shouldShowTime = YES;
        }
    }
    else
    {
        message.shouldShowTime = YES;
    }
    
    //将message分解为数组
    message.messageAttributedString = [OSMessageLabel generateAttributedString:message.msg];
    message.visibleSize = [OSMessageLabel sizeWithAttributedString:message.messageAttributedString
                                                          maxWidth:kOSBubbleMaxTextWidth];
    
    //预计算cell的高度 (必须放在分解为messageParts之后)
    message.layoutCellHeight = [OSMessageCell height:message];
    
    //设置时间
    if (!message.time)
    {
        message.time = [NSDate date];
    }
    [chat.sessionMsgs addObject:message];
    
    //如果还未建立对话，则加入代发队列
    if (message.isSelf)
    {
        message.sendType = OSMessageWaitForSend;
        [chat.waitSendMsgs addObject:message];
        
        [self sendingOperation];
    }
    else
    {
        //如果是收到了信息，需要刷新界面
        [self refreshChatView];
        [self scrollToBottom];
    }
    
    //如果是代表结束的消息，设置对话状态为已结束
    if (message.type == OSMsgCloseChat)
    {
        [self chatEnded];
    }
}

- (void)showEmoticonView:(id)sender
{
    if (!_isShowEmoticonView)
    {
        [self.emoticonView showEmoticonView];
        
        _isShowEmoticonView = YES;
        
        if ([self.inputTextView isFirstResponder])
        {
            [self.inputTextView resignFirstResponder];
        }
        else
        {
            [self adjustChatTableViewAnimated];
        }
    }
    else
    {
        if ([self.emoticonView isShowEmoticon])
        {
            _isShowEmoticonView = NO;
            [self.inputTextView becomeFirstResponder];
        }
        else
        {
            [self.emoticonView showEmoticonView];
            [self adjustChatTableViewAnimated];
        }
    }
}

- (void)showMore:(id)sender
{
    [self.emoticonView showQuickAskView];
    
    _isShowEmoticonView = YES;
    
    if ([self.inputTextView isFirstResponder])
    {
        [self.inputTextView resignFirstResponder];
    }
    else
    {
        [self adjustChatTableViewAnimated];
    }
}

- (void)showLocalNotification:(OSMsgDTO *)msg
{
    UILocalNotification *backgroudMsg = [[UILocalNotification alloc] init];
    backgroudMsg.alertBody = [NSString stringWithFormat:@"%@：%@",msg.from, msg.msg];
    backgroudMsg.soundName = UILocalNotificationDefaultSoundName;
    [[UIApplication sharedApplication] presentLocalNotificationNow:backgroudMsg];
}

//modefied by gyj 增加参数sorce区别是点击退出弹出评价还是点击评价
//source:1代表点击退出   2代表点击评价
- (void)userChooseOpinion:(id)sender withOption:(int)source
{
    if (!_needOpinion) {
        return;
    }
    if (self.chatDTO.chatId)
    {
        OSOpinionView *view = [[OSOpinionView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        view.delegate = self;
        UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
        if ([sender isKindOfClass:[NSDictionary class]]) {
            dispatch_block_t block = [sender objectForKey:@"complete"];
            if (block) {
                view.completeBlock = block;
            }
        }
        [view showInView:window withOption:source];
    }
    else
    {
        [self presentSheet:L(@"OnlineService_NoConversation")];
    }
}

#pragma mark ----------------------------- chat lifycycle

- (OSChatService *)service
{
    if (!_service) {
        _service = [[OSChatService alloc] init];
        _service.delegate = self;
    }
    return _service;
}

- (void)createChat
{
    if (self.chatDTO.chatState > OSChatStateOnWaitQueue)
    {
        return;
    }
    
    self.title = L(@"OnlineService_Linking");
    
    [self displayOverFlowActivityView:L(@"OnlineService_Linking")];
    
    if (self.chatType == OSChatTypeCShop)
    {
        [self.service requestCreateCChat:self.shopCode
                                  UserId:[UserCenter defaultCenter].userInfoDTO.userId
                                  CustNo:[UserCenter defaultCenter].userInfoDTO.custNum
                                NickName:[UserCenter defaultCenter].userInfoDTO.nickName
                             ProductName:self.productName
                             ProductCode:self.productCode
                                 OrderNo:self.orderNo];//3. 建立对话（商家）
    }
    else
    {
        [self.service requestCreateB2CChat:self.b2cGroupId
                                       GId:self.gId
                               GroupMember:self.groupMember
                                 ClassCode:self.classCode
                                    UserId:[UserCenter defaultCenter].userInfoDTO.userId
                                    CustNo:[UserCenter defaultCenter].userInfoDTO.custNum
                                  NickName:[UserCenter defaultCenter].userInfoDTO.nickName
                               ProductName:self.productName
                               ProductCode:self.productCode
                                   OrderNo:self.orderNo];//2. 建立对话（B2C客服或供应商客服）
    }
}

- (void)startWaitQueue
{
    if (self.chatDTO.chatState != OSChatStateOnWaitQueue)
    {
        return;
    }
    
    self.title = L(@"OnlineService_Queueing");
    
    TT_INVALIDATE_TIMER(_timer);
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0f
                                                  target:self
                                                selector:@selector(onWaitQueue)
                                                userInfo:nil
                                                 repeats:YES];
}

- (void)onWaitQueue
{
    if (self.chatDTO.chatState != OSChatStateOnWaitQueue)
    {
        return;
    }
    
    [self.service requestWaitQueue:self.chatDTO];//4. 访客排队
}

- (void)startReceiveMsgTimer
{
    TT_INVALIDATE_TIMER(_timer);
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0f
                                                  target:self
                                                selector:@selector(receiveMsg)
                                                userInfo:nil
                                                 repeats:YES];
}

//聊天成功建立
- (void)chatIsCreated
{
    //设置title
    NSString *title = self.vendorName;
    if (!title.length) {
        title = self.chatDTO.nickName;
    }
    if (title.length) {
        self.title = title;
    }
    
    //释放评价按钮
    _needOpinion = YES;
    self.navigationItem.rightBarButtonItem.enabled = YES;
    
    //停止排队
    TT_INVALIDATE_TIMER(_timer);
    
    self.chatDTO.chatState = OSChatStateOnChat;

    //发送未发送消息
    if ([self.chatDTO.waitSendMsgs count] > 0)
    {
        [self sendingOperation];
    }
    //    [self refreshChatView];
    [self receiveMsg];
    [self startReceiveMsgTimer];
}

- (void)receiveMsg
{
    if (self.chatDTO.chatState == OSChatStateOnChat && self.chatDTO.chatId.length)
    {
        [self.service requestGetMsg:self.chatDTO.companyId
                             ChatId:self.chatDTO.chatId
                                VId:self.chatDTO.vId];//7. 接收消息及保活
    }
}

- (void)sendMessage:(NSString *)message
{
    if (self.chatDTO.chatState == OSChatStateEnd)
    {
        [self presentSheet:L(@"OnlineService_ConversationEnd")];
        return;
    }
    
    if (!message.length)
    {
        return;
    }
    //创建OSMsgDTO
    OSMsgDTO *msg = [[OSMsgDTO alloc] init];
    msg.chatId = self.chatDTO.chatId;
    msg.isSelf = YES;
    msg.msg = message;
    [self addMsg:msg toChat:self.chatDTO];
    
    [self refreshChatView];
    
    [self scrollToBottom];
}

//发送消息的操作
- (void)sendingOperation
{
    if (self.chatDTO.chatState == OSChatStateEnd)
    {
        
    }
    else if (self.chatDTO.chatId.length)
    {
        if (!_inSending && [self.chatDTO.waitSendMsgs count] > 0)
        {
            _inSending = YES;
            
            OSMsgDTO *msg = [self.chatDTO.waitSendMsgs objectAtIndex:0];
            msg.sendType = OSMessageSending;
            [self refreshChatView];
            
            [self.chatDTO.waitSendMsgs removeObjectAtIndex:0];
            
            [self.service requestSendMsg:msg
                              customerId:self.chatDTO.customerId
                               CompanyId:self.chatDTO.companyId
                                  ChatId:self.chatDTO.chatId
                                     VId:self.chatDTO.vId];//6. 发送消息
        }
    }
}

//获取快速询问列表
- (void)requestQuickAskList
{
    [self.service requestQuickAskList];//12.获取快速提问

}

- (void)setChatDTO:(OSChatDTO *)chatDTO
{
    if (_chatDTO != chatDTO)
    {
        NSArray *sessionMsgs = _chatDTO.sessionMsgs;
        NSArray *waitSendMsgs = _chatDTO.waitSendMsgs;
        _chatDTO = chatDTO;
        
        //拷贝未发送列表
        if ([waitSendMsgs count])
        {
            [_chatDTO.waitSendMsgs insertObjects:waitSendMsgs atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [waitSendMsgs count])]];
        }
        
        //拷贝消息列表
        [_chatDTO.sessionMsgs addObjectsFromArray:sessionMsgs];
    }
    
    //创建欢迎语
    if (_chatDTO.greeting.length)
    {
        OSMsgDTO *msg = [[OSMsgDTO alloc] init];
        msg.msg = _chatDTO.greeting;
        [self addMsg:msg toChat:_chatDTO];
        _chatDTO.greeting = nil; //清除，防止重复出现
    }
}

//评价
- (void)opinionChatWithOpinion:(OSOpinionScore)score complete:(dispatch_block_t)completeBlock
{
    if (self.chatDTO.chatId.length)
    {
        [self displayOverFlowActivityView:L(@"OnlineService_Evaluating")];
        
        if (completeBlock) {
            self.service.context = completeBlock;
        }
        
        [self.service requestOpinion:[@(score) stringValue]
                           CompanyId:self.chatDTO.companyId
                              ChatId:self.chatDTO.chatId
                                 VId:self.chatDTO.vId
                                Desp:nil];//9. 评价
    }
}

//停止排队或交谈，在退出时调用
- (void)quitChat
{
    if (self.chatDTO.chatState == OSChatStateOnWaitQueue)
    {
        [self.service requestQuitWaitQueue:self.chatDTO.companyId
                                       GId:self.chatDTO.gId
                                       VId:self.chatDTO.vId];//5. 退出排队
    }
    else if (self.chatDTO.chatState == OSChatStateOnChat)
    {
        [self.service requestEndChat:self.chatDTO.companyId
                              ChatId:self.chatDTO.chatId
                                 VId:self.chatDTO.chatId];//8. 结束对话
    }
}

//对话已停止
- (void)chatEnded
{
    self.chatDTO.chatState = OSChatStateEnd;
    self.title = L(@"OnlineService_HuiHuaEnd");
    
    //进入评价子流程
    [self userChooseOpinion:nil withOption:1];
}

//提示排队人数
- (void)showWaitQueueRemainCount
{
    _waitQueueCount = [self.chatDTO.waitQueueId integerValue];
    OSMsgDTO *msg = [[OSMsgDTO alloc] init];
    msg.msg = [NSString stringWithFormat:@"%@%d%@",L(@"OnlineService_CustomerServiceBusy"), _waitQueueCount,L(@"OnlineService_HowManyPeopleInQueue")];
    [self addMsg:msg toChat:self.chatDTO];
}

#pragma mark ----------------------------- service call back

- (void)osService:(OSChatService *)service createB2CChatComplete:(BOOL)isSuccess
{
    [self removeOverFlowActivityView];
    
    //当厂送客服未找到，被转接到了自营，认为是自营客服，不能接入离线留言
    if (self.chatType == OSChatTypeB2CShopA && service.shopType == SNShopTypeB2C) {
        self.chatType = OSChatTypeB2CShop;
    }
    
    if (isSuccess)
    {
        self.chatDTO = service.chat;
        
        if (service.code == 2)
        {
            //排队
            [self startWaitQueue];
            
            //提示排队人数
            [self showWaitQueueRemainCount];
            
        }
        else
        {
            //收消息
            [self chatIsCreated];
        }
    }
    else
    {
        if (service.code == 0)
        {
            [self goToLeaveMessageOrQuit];
        }
        else
        {
            BBAlertView *alert = [[BBAlertView alloc]
                                  initWithTitle:L(@"system-info")
                                  message:service.errorMsg
                                  delegate:nil
                                  cancelButtonTitle:L(@"Ok")
                                  otherButtonTitles:nil];
            [alert setCancelBlock:^{
                [self dismissViewControllerAnimated:YES completion:NULL];
            }];
            [alert show];
        }
        
        self.title = L(@"OnlineService_LinkFailed");
    }
    
}

- (void)osService:(OSChatService *)service createCChatComplete:(BOOL)isSuccess
{
    [self removeOverFlowActivityView];
    
    if (isSuccess)
    {
        self.chatDTO = service.chat;
        
        if (service.code == 2)
        {
            //排队
            [self startWaitQueue];
            
            //提示排队人数
            [self showWaitQueueRemainCount];
        }
        else
        {
            //收消息
            [self chatIsCreated];
        }
    }
    else
    {
        if (service.code == 0)
        {
            [self goToLeaveMessageOrQuit];
        }
        else
        {
            BBAlertView *alert = [[BBAlertView alloc]
                                  initWithTitle:L(@"system-info")
                                  message:service.errorMsg
                                  delegate:nil
                                  cancelButtonTitle:L(@"Ok")
                                  otherButtonTitles:nil];
            [alert setCancelBlock:^{
                [self dismissViewControllerAnimated:YES completion:NULL];
            }];
            [alert show];
        }
        
        self.title = L(@"OnlineService_LinkFailed");
    }
}

- (void)osService:(OSChatService *)service waitQueueComplete:(BOOL)isSuccess
{
    [self removeOverFlowActivityView];
    
    if (isSuccess)
    {
        self.chatDTO = service.chat;
        if (service.code == 0)
        {
            //继续排队
            //提示排队人数
            NSInteger count = [self.chatDTO.waitQueueId integerValue];
            if (count != _waitQueueCount)
            {
                if (_waitQueueCount > 0 && count > 5)
                {
                    //如果排队人数还大于5人，不进行重复提示
                }
                else
                {
                     [self showWaitQueueRemainCount];
                }
            }
        }
        else
        {
            //停止排队并收消息
            [self chatIsCreated];
        }
    }
    else
    {
        //如果排队时发送异常，那么重新建立对话
        TT_INVALIDATE_TIMER(_timer);//先停止排队
        [self createChat];
        
//        [self presentSheet:service.errorMsg];
    }
    
}


- (void)osService:(OSChatService *)service quitWaitQueueComplete:(BOOL)isSuccess
{
    if (isSuccess)
    {
        //退出排队成功
        [self addMsg:[OSMsgDTO msgForEndChat] toChat:self.chatDTO];
    }
}

- (void)osService:(OSChatService *)service sendMsgComplete:(BOOL)isSuccess
{
    if (isSuccess)
    {
        //修改发送状态
        service.msgDTO.sendType = OSMessageSendSuccess;
        
        //可以再度评价
//        self.navigationItem.rightBarButtonItem.enabled = YES;
//        _needOpinion = YES;
    }
    else
    {
        //修改发送状态
        service.msgDTO.sendType = OSMessageSendFail;
    }
    
    //刷新界面
    [self refreshChatView];
    
    //发送下一条
    _inSending = NO;
    [self sendingOperation];
}

- (void)osService:(OSChatService *)service getMsgComplete:(BOOL)isSuccess
{
    if (isSuccess)
    {
        for (OSMsgDTO *msg in service.messageArray)
        {
            if (msg.type == OSMsgOpinion)   //邀请评价
            {
                if(_needOpinion) [self userChooseOpinion:nil withOption:2];
            }
            else
            {
                //如果是转移对话
                if (msg.type == OSMsgTranschat)
                {
                    self.chatDTO.chatId = msg.chatId;
                    //修改昵称
                    self.title = msg.from;
                }
                
                [self addMsg:msg toChat:self.chatDTO];
                
                if ([UIApplication sharedApplication].applicationState != UIApplicationStateActive)
                {
                    [self showLocalNotification:msg];
                }
                
                //可以再度评价
//                self.navigationItem.rightBarButtonItem.enabled = YES;
//                _needOpinion = YES;
            }
        }
        
        
    }
}

- (void)osService:(OSChatService *)service endChatComplete:(BOOL)isSuccess
{
    if (isSuccess)
    {
        //退出聊天成功
        [self addMsg:[OSMsgDTO msgForEndChat] toChat:self.chatDTO];
    }
}

- (void)osService:(OSChatService *)service opinionComplete:(BOOL)isSuccess
{
    [self removeOverFlowActivityView];
    
    if (isSuccess)
    {
        [self presentSheet:L(@"MyEBuy_EvaluateSuccess")];
    }
    else
    {
        [self presentSheet:service.errorMsg];
    }
    
    _needOpinion = NO;
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    dispatch_block_t completeBlock = service.context;
    if (completeBlock) {
        completeBlock();
    }
    service.context = nil;
}

- (void)osService:(OSChatService *)service getQuickAskListComplete:(BOOL)isSuccess
{
    if (isSuccess) {
        self.quickAskList = service.quickAskList;
        self.emoticonView.quickAskArray = self.quickAskList;
    }
}

#pragma mark ----------------------------- view refresh

- (void)refreshChatView
{
    if (self.productHeaderView) {
        
        if (self.chatDTO.chatState <= OSChatStateOnWaitQueue) {
            self.tableView.tableHeaderView = nil;
        } else {
            self.tableView.tableHeaderView = self.productHeaderView;
        }
    }
    
    [self.tableView reloadData];
}

#pragma mark ----------------------------- views

- (CGFloat)getBottomBarHeight
{
    return _textNumberOfLines*OS_TextView_LineHeight+2*OS_TextView_Margin+2*OS_TextView_FixHeight;
}

- (CGFloat)getBottomBarTop
{
    CGRect frame = [self visibleBoundsShowNav:YES showTabBar:NO];
    frame.size.height -= [self getBottomBarHeight];
    self.tableView.frame = frame;
    return self.tableView.bottom;
}

- (void)adjustInputView
{
    self.bottomInputBar.frame =
    CGRectMake(0, [self getBottomBarTop]-[self getKeyboardPlaceHeight], 320, [self getBottomBarHeight]+self.emoticonView.height);
    
    self.bottomInputBgImageView.frame = CGRectMake(0, 0, 320, _textNumberOfLines*OS_TextView_LineHeight+2*OS_TextView_Margin+2*OS_TextView_FixHeight);
    
    self.inputBgImageView.frame = CGRectMake(44, OS_TextView_Margin, 320-44*2, _textNumberOfLines*OS_TextView_LineHeight+2*OS_TextView_FixHeight);
    
    
    if (!IOS7_OR_LATER) {
        
        self.inputTextView.frame = CGRectMake(44, OS_TextView_Margin, 320-44*2, _textNumberOfLines*OS_TextView_LineHeight+2*OS_TextView_FixHeight);
    }
    
    
   // self.inputTextView.contentSize = self.inputTextView.frame.size;
    self.emoticonView.top = self.bottomInputBgImageView.bottom;
    
    [self adjustChatTableView];
}

- (UIView *)bottomInputBar
{
    if (!_bottomInputBar) {
        _bottomInputBar = [[UIView alloc] init];
        _bottomInputBar.backgroundColor = [UIColor clearColor];
        
        _bottomInputBar.frame = CGRectMake(0, 0, 320, 49+216);
        
        [_bottomInputBar addSubview:self.bottomInputBgImageView];
        [_bottomInputBar addSubview:self.inputBgImageView];
        [_bottomInputBar addSubview:self.inputTextView];
        [_bottomInputBar addSubview:self.emoticonButton];
        [_bottomInputBar addSubview:self.moreButton];
        [_bottomInputBar addSubview:self.emoticonView];
    }
    return _bottomInputBar;
}

- (UIImageView *)bottomInputBgImageView
{
    if (!_bottomInputBgImageView) {
        _bottomInputBgImageView = [[UIImageView alloc] init];
        _bottomInputBgImageView.frame = CGRectMake(0, 0, 320, 49);
        _bottomInputBgImageView.image = [UIImage streImageNamed:@"os_inputbox_bg.png"];
    }
    return _bottomInputBgImageView;
}

- (UIImageView *)inputBgImageView
{
    if (!_inputBgImageView) {
        _inputBgImageView = [[UIImageView alloc] init];
        _inputBgImageView.frame = CGRectMake(44, 8, 320-44*2, 32);
        _inputBgImageView.image = [UIImage streImageNamed:@"os_inputbox_input.png"];
    }
    return _inputBgImageView;
}

- (SNUITextView *)inputTextView
{
    if (!_inputTextView) {
        _inputTextView = [[SNUITextView alloc] initWithFrame:CGRectMake(44, 7, 320-44*2, 32)];
        _inputTextView.backgroundColor = [UIColor clearColor];
        _inputTextView.delegate = self;
        _inputTextView.returnKeyType = UIReturnKeySend;
        _inputTextView.font = OS_TextView_Font;
        _inputTextView.scrollEnabled = NO;
    }
    return _inputTextView;
}

- (UIButton *)emoticonButton
{
    if (!_emoticonButton) {
        _emoticonButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _emoticonButton.frame = CGRectMake(0, 0, 44, 49);
        [_emoticonButton setImage:[UIImage imageNamed:@"os_inputbox_btn_face.png"]
                         forState:UIControlStateNormal];
        [_emoticonButton addTarget:self action:@selector(showEmoticonView:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _emoticonButton;
}

- (UIButton *)moreButton
{
    if (!_moreButton) {
        _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _moreButton.frame = CGRectMake(320-44, 0, 44, 49);
        [_moreButton setImage:[UIImage imageNamed:@"os_inputbox_btn_more.png"]
                     forState:UIControlStateNormal];
        [_moreButton addTarget:self action:@selector(showMore:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreButton;
}

- (OSEmoticonView *)emoticonView
{
    if (!_emoticonView)
    {
        _emoticonView = [[OSEmoticonView alloc] init];
        _emoticonView.top = 49;
        _emoticonView.delegate = self;
    }
    return _emoticonView;
}

- (UIView *)productHeaderView
{
    if (!_productHeaderView) {
        if (self.productCode.length && self.productName.length) {
            
            UIView *productView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.width, 80)];
            productView.backgroundColor = [UIColor whiteColor];
            productView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            
            EGOImageView *iconImage = [[EGOImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
            iconImage.imageURL = [ProductUtil getImageUrlWithProductCode:self.productCode size:ProductImageSize120x120];
            [productView addSubview:iconImage];
            
            UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(iconImage.right + 10, 10, productView.width-iconImage.right - 20, 20)];
            nameLabel.font = [UIFont systemFontOfSize:16.0f];
            nameLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            nameLabel.text = self.productName;
            [productView addSubview:nameLabel];
            
            UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
            sendButton.frame = CGRectMake(iconImage.right + 20, nameLabel.bottom + 10, productView.width-iconImage.right-40, 30);
            sendButton.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            [sendButton setBackgroundImage:[UIImage imageNamed:@"button_orange_normal"].stretched
                                  forState:UIControlStateNormal];
            [sendButton setTitle:L(@"OnlineService_SendGoodsLink") forState:UIControlStateNormal];
            [sendButton addTarget:self action:@selector(sendProductUrl:) forControlEvents:UIControlEventTouchUpInside];
            [productView addSubview:sendButton];
            
            _productHeaderView = productView;
        }
    }
    return _productHeaderView;
}

#pragma mark ----------------------------- text view delegate

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        if (textView.text.trim.length) [self sendMessage:textView.text];
        self.inputTextView.text = @"";
        [self textViewDidChange:self.inputTextView];
        
        return NO;
    }
    else
    {
        return YES;
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    
    
    CGFloat lineHeight = textView.font.lineHeight;
    int numLines = textView.contentSize.height/lineHeight;
    
    if (IOS7_OR_LATER) {
        
        //UItextView 控件 ios7 下特别处理 原因不明

//        self.inputTextView.text = textView.text;
        
        CGFloat fixedWidth = textView.frame.size.width;
        CGSize newSize = [textView sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
        CGRect newFrame = textView.frame;
        newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
        
        numLines = newSize.height/lineHeight;
        
        if (numLines < 4) {
            
            textView.frame = newFrame;
        }
        else{
            
        self.inputTextView.frame = CGRectMake(44, OS_TextView_Margin, 320-44*2, 3*OS_TextView_LineHeight+2*OS_TextView_FixHeight);
        }
    }
    else{
        numLines = textView.contentSize.height/lineHeight;
    }
    
    if(numLines > _textNumberOfLines)//添加字符增加行数
    {
        if(numLines < 4)
        {
            self.inputTextView.scrollEnabled = NO;
        }
        else
        {
            numLines = 3;
            self.inputTextView.scrollEnabled = YES;
            [self.inputTextView setContentOffset:CGPointMake(0, self.inputTextView.contentSize.height - self.inputTextView.frame.size.height) animated:YES];
        }
    }
    else if(numLines < _textNumberOfLines)//删除字符，减少行数
    {
        if(numLines < 4)
        {
            self.inputTextView.scrollEnabled = NO;
        }
        else
        {
            self.inputTextView.scrollEnabled = YES;
        }
    }
    _textNumberOfLines = numLines;
    
    [self adjustInputView];
}

#pragma mark ----------------------------- tableView dataSource and delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.chatDTO.sessionMsgs count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OSMsgDTO *msg = [self.chatDTO.sessionMsgs objectAtIndex:indexPath.row];
    return msg.layoutCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OSMsgDTO *msg = [self.chatDTO.sessionMsgs objectAtIndex:indexPath.row];
    
    static NSString *cellIdentifier = @"messageCell";
    
    OSMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[OSMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.delegate = self;
    }
    
    [cell updateMessageCellWithMessage:msg];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if ([self.inputTextView isFirstResponder])
    {
        [self.inputTextView resignFirstResponder];
    }
    else if (_isShowEmoticonView)
    {
        _isShowEmoticonView = NO;
        
        [self adjustChatTableViewAnimated];
    }
}

#pragma mark ----------------------------- OSMessageCell delegate

- (void)messageCell:(OSMessageCell *)cell resendMsg:(OSMsgDTO *)message
{
    //重设时间，重新发送
    message.time = [NSDate date];
    [self sendMessage:message.msg];
}

- (void)messageCell:(OSMessageCell *)cell longPressBubbleWithMsg:(OSMsgDTO *)message
{
    [cell becomeFirstResponder];
    
    //忽略undeclaredSelector的leak警告
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    UIMenuItem   *copyItem = [[UIMenuItem alloc] initWithTitle:L(@"OnlineService_Copy") action:@selector(copyClicked:)];
#pragma clang diagnostic pop
    
    UIMenuController *menuControll  = [UIMenuController sharedMenuController];
    [menuControll setMenuItems:@[copyItem]];
    
    [menuControll setTargetRect:CGRectMake(cell.left+cell.bubbleView.left, cell.top+cell.bubbleView.top, cell.bubbleView.width, cell.bubbleView.height) inView:self.tableView];
    
    [menuControll update];
    [menuControll setMenuVisible:YES];
}

- (void)messageCell:(OSMessageCell *)cell didTouchImageWithImageUrl:(NSURL *)imgUrl
{
    MyPhoto *photo = [[MyPhoto alloc] initWithImageURL:imgUrl];
    MyPhotoSource *source = [[MyPhotoSource alloc] initWithPhotos:@[photo]];
    EGOPhotoViewController *photoController = [[EGOPhotoViewController alloc] initWithPhotoSource:source];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:photoController];
    
    navController.modalPresentationStyle = UIModalPresentationFullScreen;
    if (IOS5_OR_LATER)
    {
        [self presentViewController:navController animated:YES completion:^{
            
            photoController.scrollView.alpha = 1;
        }];
    }
    else
    {
        [self presentModalViewController:navController animated:YES];
        photoController.scrollView.alpha = 1;
    }
}

- (void)messageCell:(OSMessageCell *)cell didSelectLinkWithUrl:(NSURL *)url
{
    SNWebViewController *vc = [[SNWebViewController alloc] initWithRequest:[NSURLRequest requestWithURL:url]];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark ----------------------------- OSOpinionView delegate

- (void)opinionView:(OSOpinionView *)view didOpinion:(OSOpinionScore)score
{
    dispatch_block_t completeBlock = [view hide:NO];
    [self opinionChatWithOpinion:score complete:completeBlock];
}

#pragma mark ----------------------------- emoticon view delegate

- (void)emoticonView:(OSEmoticonView *)view didChooseEmoticon:(NSString *)emoticonStr
{
    /*
     NSString *text = self.inputTextView.text ? self.inputTextView.text : @"";
     text = [text stringByAppendingString:emoticonStr];
     self.inputTextView.text = text;
     [self textViewDidChange:self.inputTextView];
     */
    
    //改为单个发送
    if (emoticonStr.length)
    {
        [self sendMessage:emoticonStr];
    }
}

- (void)emoticonView:(OSEmoticonView *)view didChooseQuickAskWord:(NSString *)word
{
    if (word.trim.length)
    {
        [self sendMessage:word];
    }
}

- (void)emoticonViewSendButtonClicked:(OSEmoticonView *)view
{
    [self sendMessage:self.inputTextView.text];
    self.inputTextView.text = @"";
    [self textViewDidChange:self.inputTextView];
}

#pragma mark ----------------------------- keyboard 自适应

- (void)scrollToBottom
{
    CGFloat keyboardHeight = self.tableView.contentInset.bottom;
    //可显示区域高度
    CGFloat visibHeight = self.tableView.frame.size.height - keyboardHeight;
    //内容高度
    CGFloat contentHeight = self.tableView.contentSize.height;
    
    if (contentHeight > visibHeight)
    {
        [self.tableView setContentOffset:CGPointMake(0, contentHeight-visibHeight) animated:YES];
    }
}

- (void)keyboardWillShow:(NSNotification *)aNotification
{
    NSString *name = [aNotification name];
    CGFloat keyboardHeight
    = [[[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    NSDictionary *userInfo = [aNotification userInfo];
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:animationCurve
                     animations:^{
                         
                         if ([name isEqualToString:UIKeyboardWillShowNotification])
                         {
                             _isShowEmoticonView = NO;
                         }
                         
                         _keyboardHeight = keyboardHeight;
                         
                         [self adjustChatTableView];
                     }
                     completion:nil];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    NSDictionary *userInfo = [notification userInfo];
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:animationCurve
                     animations:^{
                         
                         _keyboardHeight = 0;
                         
                         [self adjustChatTableView];
                     }
                     completion:nil];
    
}

- (CGFloat)getKeyboardPlaceHeight
{
    if (_isShowEmoticonView)
    {
        return self.emoticonView.height;
    }
    else
    {
        return _keyboardHeight;
    }
}

- (void)adjustChatTableView
{
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, [self getKeyboardPlaceHeight], 0);
    
    self.bottomInputBar.top = [self getBottomBarTop] - [self getKeyboardPlaceHeight];
    
    if (self.tableView.contentSize.height <= self.tableView.contentOffset.y + self.tableView.height)
    {
        [self scrollToBottom];
    }
    
    if (_isShowEmoticonView && [self.emoticonView isShowEmoticon])
    {
        [_emoticonButton setImage:[UIImage imageNamed:@"os_inputbox_jianpan_btn.png"]
                         forState:UIControlStateNormal];
    }
    else
    {
        [_emoticonButton setImage:[UIImage imageNamed:@"os_inputbox_btn_face.png"]
                         forState:UIControlStateNormal];
    }
}

- (void)adjustChatTableViewAnimated
{
    [UIView animateWithDuration:0.25
                          delay:0
                        options:UIViewAnimationCurveEaseInOut
                     animations:^{
                         
                         [self adjustChatTableView];
                         
                     } completion:^(BOOL finished) {
                         
                         
                     }];
}

@end
