//
//  LotteryPayRequestModel.m
//  SuningLottery
//
//  Created by jian  zhang on 12-7-24.
//  Copyright (c) 2012年 suning. All rights reserved.
//

#import "LotteryPayRequestModel.h"

@interface LotteryPayRequestModel()
{
    
    HttpMessage *PaypageSendMsg;
    
}
@end

@implementation LotteryPayRequestModel

@synthesize delegate = _delegate;
@synthesize items = _items;
@synthesize isSuccess = _isSuccess;

- (void)dealloc {
    
    TT_RELEASE_SAFELY(_items);
    
}

- (void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(PaypageSendMsg);
}

- (void)beginFetchLotteryPayWithDto:(SubmitLotteryDto *)lotteryDto
                           PassWord:(NSString *)psw
{
    NSString *productTimes = lotteryDto.productTimes == nil ?@"":lotteryDto.productTimes;
    NSString *buyCodes = lotteryDto.buyCodes == nil ?@"":lotteryDto.buyCodes;
    NSString *multiNo = lotteryDto.multiNo == nil?@"":lotteryDto.multiNo;
    NSString *saleType = lotteryDto.saleType == nil?@"":lotteryDto.saleType;
    NSString *productMoney = lotteryDto.productMoney==nil?@"":lotteryDto.productMoney;
    NSString *password = psw == nil?@"":psw;
    NSString *gid = lotteryDto.gid == nil?@"":lotteryDto.gid;
    
    
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc]initWithCapacity:20];
    [postDataDic setObject:@"1"  forKey:@"json"];                          //是否返回json格式字符串,1:是，0否
    [postDataDic setObject:gid forKey:@"gid"];                           //游戏编号
    [postDataDic setObject:productTimes forKey:@"pid"];                    //期次编号
    [postDataDic setObject:@"1" forKey:@"play"];                           //玩法编号，默认为1
    [postDataDic setObject:buyCodes forKey:@"codes"];                      //投注号码 |分割红蓝 ;分割不同两组号
    [postDataDic setObject:multiNo forKey:@"muli"];                        //投注倍数
    [postDataDic setObject:@"0" forKey:@"fflag"];                          //是否文件，代购为0
    [postDataDic setObject:@"0" forKey:@"type"];                           //方案类型，代购为0
    [postDataDic setObject:saleType forKey:@"name"];                       //方案标题，默认为"代购"
    [postDataDic setObject:saleType forKey:@"desc"];                       //方案描述，默认为"代购"
    [postDataDic setObject:productMoney forKey:@"money"];                  //方案金额
    [postDataDic setObject:@"1" forKey:@"tnum"];                           //方案份数，代购为1
    [postDataDic setObject:@"1" forKey:@"bnum"];                           //购买份数，代购为1
    [postDataDic setObject:@"0" forKey:@"pnum"];                           //保底份数，代购为0
    [postDataDic setObject:@"0" forKey:@"oflag"];                          //公开标志，默认为0
    [postDataDic setObject:@"0" forKey:@"wrate"];                          //提成比率，默认为空
    [postDataDic setObject:@"" forKey:@"comeFrom"];                        //方案来源，默认为空
    [postDataDic setObject:@"2" forKey:@"source"];                         //投注来源（0:网站 1:客户端 2:手机 3:wap）
    [postDataDic setObject:@"" forKey:@"endTime"];                         //截至时间，默认为空
    [postDataDic setObject:password forKey:@"passWord"];                   //易付宝密码
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostLotteryTicketForHttp,KLotteryTicketPayment];//订单提交接口
    
    HTTPMSG_RELEASE_SAFELY(PaypageSendMsg);
    
    PaypageSendMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:url postDataDic:postDataDic cmdCode:CC_TicketPayment];
    
    PaypageSendMsg.timeout = 30;
    
    [self.httpMsgCtrl sendHttpMsg:PaypageSendMsg];
    
    
}


- (void)receiveDidFinished:(HttpMessage *)receiveMsg{
    
    self.isSuccess = YES;
    
    self.items = receiveMsg.jasonItems;
    
    if ([self.delegate conformsToProtocol:@protocol(LotteryPayRequestDelegate) ]) {
        if ([self.delegate respondsToSelector: @selector(lotteryPayRequestOK:)]) {
            [self.delegate lotteryPayRequestOK:self.items];
        }
    }
    
}


- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    self.isSuccess = NO;
    
    if ([self.delegate respondsToSelector: @selector(lotteryPayRequestOK:)]) {
        [self.delegate lotteryPayRequestOK:self.items];
    }
}


@end
