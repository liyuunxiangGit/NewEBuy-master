//
//  LotteryOrderDetailService.m
//  SuningEBuy
//
//  Created by  zhang jian on 13-6-9.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "LotteryOrderDetailService.h"

@interface LotteryOrderDetailService()
{
    
}

- (void)lotteryOrderDetailServiceFinished:(BOOL)isSuccess;

@end


@implementation LotteryOrderDetailService

@synthesize tradeOrderDetailDto = _tradeOrderDetailDto;
@synthesize followPeroidArray  = _followPeroidArray;
@synthesize listDto = _listDto;
@synthesize errorCode = _errorCode;

- (void)dealloc
{
    HTTPMSG_RELEASE_SAFELY(lotteryOrderDetailMSG);
    
    TT_RELEASE_SAFELY(_tradeOrderDetailDto);
    TT_RELEASE_SAFELY(_followPeroidArray);
    TT_RELEASE_SAFELY(_listDto);
    TT_RELEASE_SAFELY(_errorCode);
    
}

- (void)sendRequestWithPostDic:(NSDictionary *)dic andCmdCode:(E_CMDCODE)cmdcode
{
    
    
    NSString *url = nil;
    if(cmdcode == CC_LotteryOrderDetail)
    {
        url = [NSString stringWithFormat:@"%@/%@",kHostLotteryTicketForHttp,KLotteryTicketOrderDetail];
    }else if(cmdcode == CC_FollowOrderProject){
        
        url = [NSString stringWithFormat:@"%@/%@",kHostLotteryTicketForHttp,KLotteryTicketFollowOrderProject];
    }else{
        url = [NSString stringWithFormat:@"%@/%@",kHostLotteryTicketForHttp,KLotteryTicketOrderFollowOrderDetail];
    }
    
    SERVICE_RELEASE_SAFELY(lotteryOrderDetailMSG);
    
    lotteryOrderDetailMSG = [[HttpMessage alloc] initWithDelegate:self requestUrl:url postDataDic:dic cmdCode:cmdcode];
    
    [self.httpMsgCtrl sendHttpMsg:lotteryOrderDetailMSG];
    
}

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    TT_RELEASE_SAFELY(_tradeOrderDetailDto);
    TT_RELEASE_SAFELY(_followPeroidArray);
    TT_RELEASE_SAFELY(_errorCode);
    
    [self lotteryOrderDetailServiceFinished:NO];
    
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{

    Background_Begin
    TT_RELEASE_SAFELY(_tradeOrderDetailDto);
    TT_RELEASE_SAFELY(_followPeroidArray);
    TT_RELEASE_SAFELY(_errorCode);
    
    NSDictionary *items = receiveMsg.jasonItems;
    
    self.errorMsg = [items objectForKey:@"@errorCode"];
    
    if([items objectForKey:@"xml"] != nil)
    {
        self.errorMsg = [[items objectForKey:@"xml"] objectForKey:@"@errorCode"];
    }
    
    if ([[items objectForKey:@"@code"]isEqualToString:@"0"])
    {
        
        if(receiveMsg.cmdCode == CC_LotteryOrderDetail)       //代购订单详情
        {
            NSDictionary *rowDic = [items objectForKey:@"row"];
            
            NSArray      *array = [items objectForKey:@"myjoins"];
            
            if (array && [array count]> 0)
            {
                
                NSDictionary *myjoinDic = [array objectAtIndex:0];
                
                if (myjoinDic && rowDic)
                {
                    _tradeOrderDetailDto = [[TradeOrderDetailDto alloc] init];
                    
                    [_tradeOrderDetailDto encodeWithJoinDic:myjoinDic andRowDic:rowDic];
                }
            }
            
        }else if(receiveMsg.cmdCode == CC_FollowOrderDetail)       //追号订单详情
        {
            NSArray *rows = [[items objectForKey:@"rows"] objectForKey:@"row"];
            
            _followPeroidArray = [[NSMutableArray alloc] init];
            
            for(int i = 0; i < [rows count]; i++)
            {
                FollowPerodDetailDto *dto = [[FollowPerodDetailDto alloc] init];
                
                [dto encodeWithRow:[rows objectAtIndex:i]];
                
                [_followPeroidArray addObject:dto];
                
            }
        }else if(receiveMsg.cmdCode == CC_FollowOrderProject)
        {
            LotteryDealsSerialNumberDto *tmpDto = (LotteryDealsSerialNumberDto *)_listDto;
            
            [tmpDto encodeFromDictionary:[items objectForKey:@"row"]];
        }
        
        [self lotteryOrderDetailServiceFinished:YES];
    }
    else
    {
        
        NSString *result = [items objectForKey:@"@desc"];
        
        if ([result isEqualToString:@""]||result == nil)
        {
            self.errorMsg = L(@"Request failed, please try again later");
        }else
        {
            if ([self.errorMsg isEqualToString:@"common.2.userNotLoggedIn"]) {
                
            }else{
                self.errorMsg = result;
            }
        }
        [self lotteryOrderDetailServiceFinished:NO];
    }
    Background_End
}

- (void)lotteryOrderDetailServiceFinished:(BOOL)isSuccess
{
    Foreground_Begin
    if (_delegate && [_delegate respondsToSelector:@selector(lotteryOrderDetailComplete:)])
    {
        [_delegate lotteryOrderDetailComplete:isSuccess];
    }
    Foreground_End
}

- (NSString *)getCcodes
{
    if(_tradeOrderDetailDto)
        return _tradeOrderDetailDto.ccodes;
    else if([_followPeroidArray count] > 0)
    {
        FollowPerodDetailDto *dto = [_followPeroidArray objectAtIndex:0];
        return dto.ccodes;
    }
    
    return nil;
}

- (NSString *)gid
{
    if([_listDto isKindOfClass:[LotteryDealsDto class]])
    {
        return [(LotteryDealsDto *)_listDto gid];
    }else{
        return [(LotteryDealsSerialNumberDto *)_listDto gid];
    }
}

- (NSString *)projid
{
    if([_listDto isKindOfClass:[LotteryDealsDto class]])
    {
        return [(LotteryDealsDto *)_listDto projid];
    }else{
        return [(LotteryDealsSerialNumberDto *)_listDto zhid];
    }
}

@end


@implementation TradeOrderDetailDto

@synthesize code;         //0 成功
@synthesize desc;         //失败返回错误信息
@synthesize buyid;        //购买编号
@synthesize nickid;       //认购人
@synthesize bnum;         //认购份数
@synthesize buydate;      //认购日期
@synthesize bmoney;       //认购金额
@synthesize cancel;       //是否撤销 (0 未撤销 1 本人撤销 2 系统撤销）
@synthesize canceldate;   //撤销日期
@synthesize award;        //记奖标志 0 未记奖 2 已计奖
@synthesize awarddate;    //计奖日期
@synthesize amoney;       //派奖金额
@synthesize ireturn;      //是否派奖 0 未派奖 1 派奖中 2 已派奖
@synthesize retdate;      //派奖时间
@synthesize rmoney;       //认购派奖金额
@synthesize source;       //投注来源 0 网站 1 客户端 2 手机 3 wap
@synthesize pay;          //是否支付成功（-1支付失败 0未支付成功 1支付成功 2退款中 3已退款）

@synthesize projid;       //方案编号
@synthesize cnickid;      //发起人
@synthesize gameid;       //游戏编号
@synthesize periodid;     //期次
@synthesize cname;        //合买名称
@synthesize cdesc;        //合买描述
@synthesize ccodes;       //投注号码
@synthesize mulity;       //倍数
@synthesize play;         //玩法 单式 复式
@synthesize itype;        //方案类型 0 代沟 1 合买
@synthesize ifile;        //是否文件投注 0 不是 1 是
@synthesize tmoney;       //总金额
@synthesize smoney;       //每份金额
@synthesize nums;         //总份数
@synthesize onum;         //发起人认购份数
@synthesize pnum;         //发起人保底份数
@synthesize Inum;         //剩余份数
@synthesize iopen;        //是否保密 （0 对所有人公开 1 截止后公开 2 对参与人员公开 3 截止后对参与人公开）
@synthesize wrate;        //发起人中奖提成率
@synthesize jindu;        //进度
@synthesize views;        //方案关注次数
@synthesize endtime;      //截止时间
@synthesize adddate;      //发起时间
@synthesize mydate;       //满员时间
@synthesize istate;       //状态(0 禁止认购 1 认购中,2 已满员 3过期未满撤销 4主动撤销 5已出票 6 已派奖)
@synthesize upload;       //是否上传 0 未穿  1 已传
@synthesize loaddate;     //上传时间
@synthesize iclear;       //是否清保 0 未清 1 正在清 2 已清
@synthesize cleardate;    //清保时间
@synthesize icast;        //出票标志（0 未出票 1 可以出票 2 已拆票 3 已出票）
@synthesize bingo;        //匹配标志（0 未匹配 1 正在匹配 2 已匹配)
@synthesize bgdate;       //匹配时间
@synthesize wininfo;      //中奖信息（中奖注数用逗号隔开）
@synthesize rowaward;     //计奖标志（0 未计奖 1 正在计奖 2 已计奖)
@synthesize rowawarddate; //计奖时间
@synthesize bonus;        //总奖金
@synthesize tax;          //税后奖金
@synthesize owins;        //发起人提成奖金
@synthesize oreturn;      //发起人提成是否派奖（0 未派 1 正在派 2 已派）
@synthesize oretdate;     //发起人提成派奖时间
@synthesize rowireturn;   //是否派奖
@synthesize rowretdate;   //派奖时间
@synthesize zhanji;       //战绩是否统计（0 未统计 1 正在统计 2 已统计)
@synthesize aunum;        //金星个数
@synthesize agnum;        //银星个数
@synthesize gaunum;       //获得金星个数
@synthesize gagnum;       //获得银星个数
@synthesize rowsource;    //投注来源( 0 网站 1 客户端 2 手机 3 WAP)
@synthesize awardcode;    //开奖号码

@synthesize localState;
@synthesize winState;

- (void)encodeWithJoinDic:(NSDictionary *)joinDic andRowDic:(NSDictionary *)rowDic
{
    
    self.projid = [rowDic objectForKey:@"@projid"];
    self.gameid = [rowDic objectForKey:@"@gameid"];
    self.periodid = [rowDic objectForKey:@"@periodid"];
    self.cdesc = [rowDic objectForKey:@"@cdesc"];
    self.mulity = [rowDic objectForKey:@"@mulity"];
    self.bonus = [rowDic objectForKey:@"@bonus"];
    self.ccodes = [rowDic objectForKey:@"@ccodes"];
    self.istate = [rowDic objectForKey:@"@istate"];
    self.icast = [rowDic objectForKey:@"@icast"];
    self.award = [rowDic objectForKey:@"@award"];
    self.awardcode = [rowDic objectForKey:@"@awardcode"];
    self.tax = [rowDic objectForKey:@"@tax"];

    self.amoney = [joinDic objectForKey:@"@amoney"];
    self.bmoney = [joinDic objectForKey:@"@bmoney"];
    self.buydate = [joinDic objectForKey:@"@buydate"];
    self.cancel = [joinDic objectForKey:@"@cancel"];
    self.ireturn = [joinDic objectForKey:@"@ireturn"];
    self.rmoney = [joinDic objectForKey:@"@rmoney"];
    self.pay = [joinDic objectForKey:@"@pay"];
    
    [self judgeOrderStatus];
}

//- (NSString *)localState
//{
//    return [self.icast integerValue] == 3?([self.istate integerValue] > 2?@"出票失败":([self.award integerValue]== 2?([self.bonus integerValue] > 0?@"已中奖":@"未中奖"):@"待开奖")):([self.icast integerValue] ==  0 ?@"出票中":([self.icast integerValue] == 1?@"出票中":([self.istate integerValue] > 2?@"出票失败":@"出票中")));
//    
//}

- (void)judgeOrderStatus
{
    /** 出票失败已开奖 */
    
    /** 出票失败未开奖 */
    
    /** 出票成功 已开奖 且中奖 */
    if ([self.icast integerValue] == 3 && [self.award integerValue] == 2 && [self.amoney integerValue]>0 && [self.bonus integerValue] > 0)
    {
        localState = L(@"TicketSuccess");
        winState = L(@"Hit the jackpot");
    }
    
    /** 出票成功 已开奖 未中奖 */
    if ([self.icast integerValue] == 3 && [self.award integerValue]== 2  && [self.amoney integerValue]==0)
    {
        localState = L(@"TicketSuccess");
        winState = L(@"Not hit the jackpot");
    }
    
    if ([self.icast integerValue] == 3 && [self.award integerValue]== 1  && [self.amoney integerValue]==0)
    {
        localState = L(@"TicketSuccess");
        winState = L(@"Not hit the jackpot");
    }//接口文档没有award=1的说明，这个是根据结果添加的一个判断
    
    /** icast -1 方案发起未支付  已开奖 未中奖 */
    if ([self.icast integerValue] == 0 && [self.award integerValue]== 2  && [self.istate integerValue]==-1)
    {
        localState = L(@"OverTimeNotPayed");
        winState = @"--";
    }
    
    
    /** icast -1 方案发起未支付  award 0等待开奖 未支付 */
    if ([self.icast integerValue] == 0 && [self.award integerValue]==0  && [self.istate integerValue]==-1)
    {
        localState = L(@"Waiting payment");
        winState =   L(@"WaitLottery");
    }
    
    /** 出票成功 未开奖 */
    if ([self.icast integerValue] == 3 && [self.award integerValue]==0  && [self.istate integerValue]==2)
    {
        localState = L(@"TicketSuccess");
        winState =    L(@"WaitLottery");
    }
    
    /** 除了以上情况外 istate>2 视为出票失败 */
    if ([self.istate integerValue] > 2)
    {
        localState = L(@"TicketFail");
        winState = @"--";
    }
    
    /** 除了以上情况外 istate>2 视为出票失败 */
    if ([self.istate integerValue] == 4)
    {
        localState = L(@"UserUndo");
        winState = @"--";
    }
    
    
    if([self.icast integerValue] == 2 || [self.icast integerValue] == 1){//拆票或可以出票
        localState = L(@"Ticketing");
        winState = L(@"WaitLottery");
        
    }
    /** 暂未出票 */
    
    /** 　出票中　 */
    
    /** 除了以上情况外 istate>2 视为出票失败 */
    
    /** 其他情况视为出票中 */
    //因状态太多，防止遗漏，调用以前的的状态设置
    if (!localState && !winState) {
        [self judgeOrderStatusBak];
        
    }
    
}

- (void)judgeOrderStatusBak
{
    /** 出票失败已开奖 */
    if ([self.icast integerValue] == 3 && [self.istate integerValue] > 2 && [self.award integerValue]== 2)
    {
        localState = L(@"TicketFail");
        winState = L(@"Lotteryed");
    }
    /** 出票失败未开奖 */
    else if ([self.icast integerValue] == 3 && [self.istate integerValue] > 2)
    {
        localState = L(@"TicketFail");
        winState = @"--";
    }
    /** 出票成功 已开奖 且中奖 */
    else if ([self.icast integerValue] == 3 && [self.award integerValue]== 2 && [self.bonus integerValue] > 0)
    {
        localState = L(@"TicketSuccess");
        winState = L(@"Hit the jackpot");
    }
    /** 出票成功 已开奖 未中奖 */
    else if ([self.icast integerValue] == 3 && [self.award integerValue]== 2)
    {
        localState = L(@"TicketSuccess");
        winState = L(@"Not hit the jackpot");
    }
    /** 出票成功 未开奖 */
    else if ([self.icast integerValue] == 3 &&  [self.award integerValue]== 0)
    {
        localState = L(@"TicketSuccess");
        winState = L(@"WaitsLottery");
    }
    /** 暂未出票 */
    else if ([self.icast integerValue] == 0)
    {
        localState = L(@"HavenotTicketing");
        winState = L(@"WaitsLottery");
    }
    /** 　出票中　 */
    else if ([self.icast integerValue] == 1)
    {
        localState = L(@"Ticketing");
        winState = L(@"WaitsLottery");
    }
    /** 除了以上情况外 istate>2 视为出票失败 */
    else if ([self.istate integerValue] > 2)
    {
        localState = L(@"TicketFail");
        winState = @"--";
    }
    /** 其他情况视为出票中 */
    else
    {
        localState = @"--";
        winState = @"--";
    }
}



@end

@implementation FollowPerodDetailDto

@synthesize code;         // 0 成功
@synthesize desc;         //错误描述
@synthesize idetailid;    //追号明细编号
@synthesize czhid;        //追号方案编号
@synthesize cperiodid;    //期次编码
@synthesize ccodes;       //投注方案
@synthesize icmoney;      //投注金额
@synthesize ccastdate;    //投注日期
@synthesize istate;       //状态 (-1 待支付 0 未投注 1正在处理 2 已投注 3 取消 )
@synthesize cadddate;     //追号购买时间
@synthesize cwinininfo;   //中奖信息
@synthesize cbgdate;      //中奖日期
@synthesize ibingo;       //中奖匹配 0 未处理 1 正在处理 2 处理完成
@synthesize imulity;      //倍数
@synthesize cawarddate;   //算奖时间
@synthesize iaward;       //是否算奖 0 未出来 1 正在处理 2 已算奖
@synthesize iamoney;      //中奖金额
@synthesize isreturn;     //是否派奖 0 未派奖 1 正在处理 2 已派奖
@synthesize creturndate;  //派奖时间
@synthesize irmoney;      //中奖金额
@synthesize itax;         //税后奖金
@synthesize cnickid;      //用户编号
@synthesize ijiesuan;     //结算标志（0 未结算 1 正在结算 2 已结算）
@synthesize cjsdate;      //结算时间
@synthesize iumoney;      //追号返点
@synthesize izhanji;      //战绩是否统计（0 未统计 1 正在统计 2 已统计)
@synthesize igaunum;      //获得金星个数
@synthesize igagnum;      //获得银星个数
@synthesize ipay;         //是否支付成功（0未支付成功 1支付成功 2退款中 3已退款）
@synthesize cusername;    //用户姓名
@synthesize cidcard;      //身份证号码
@synthesize cmobileno;    //绑定的手机号码
@synthesize cawardcode;   //中奖号码


- (void)encodeWithRow:(NSDictionary *)row
{
    self.idetailid = [row objectForKey:@"@idetailid"];
    self.czhid = [row objectForKey:@"@czhid"];
    self.cperiodid = [row objectForKey:@"@cperiodid"];
    self.ccodes = [row objectForKey:@"@ccodes"];
    self.icmoney = [row objectForKey:@"@icmoney"];
    self.ccastdate = [row objectForKey:@"@ccastdate"];
    self.istate = [row objectForKey:@"@istate"];
    self.cadddate = [row objectForKey:@"@cadddate"];
    self.cwinininfo = [row objectForKey:@"@cwinininfo"];
    self.cbgdate = [row  objectForKey:@"@cbgdate"];
    self.imulity = [row objectForKey:@"@imulity"];
    self.iaward = [row objectForKey:@"@iaward"];
    self.iamoney = [row objectForKey:@"@iamoney"];
    self.isreturn = [row objectForKey:@"@isreturn"];
    self.irmoney = [row objectForKey:@"@irmoney"];
    self.ipay = [row objectForKey:@"@ipay"];
    self.cawardcode = [row objectForKey:@"@cawardcode"];
}


@end


