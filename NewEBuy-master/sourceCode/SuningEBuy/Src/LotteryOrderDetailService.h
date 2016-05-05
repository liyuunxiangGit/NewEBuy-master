//
//  LotteryOrderDetailService.h
//  SuningEBuy
//
//  Created by  zhang jian on 13-6-9.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LotteryDealsDto.h"
#import "LotteryDealsSerialNumberDto.h"

@class TradeOrderDetailDto;
@class FollowPerodDetailDto;

#define kOrderDetailObservingKey    @"errorMsg"


@protocol LotteryOrderDetailServiceDelegate;


@interface LotteryOrderDetailService : DataService
{

    HttpMessage             *lotteryOrderDetailMSG;
    
    TradeOrderDetailDto     *_tradeOrderDetailDto;
    
    NSMutableArray           *_followPeroidArray;
    
    id                          _listDto;
    
    NSString                  *_errorCode;      //错误码
}
@property (nonatomic, weak) id<LotteryOrderDetailServiceDelegate> delegate;

@property (nonatomic, strong) TradeOrderDetailDto *tradeOrderDetailDto;
@property (nonatomic, strong) NSMutableArray      *followPeroidArray;
@property (nonatomic, strong) id listDto;
@property (nonatomic, copy) NSString *errorCode;

- (void)sendRequestWithPostDic:(NSDictionary *)dic andCmdCode:(E_CMDCODE)cmdcode;

- (NSString *)getCcodes;

- (NSString *)gid;

- (NSString *)projid;
@end

@protocol LotteryOrderDetailServiceDelegate <NSObject>

- (void)lotteryOrderDetailComplete:(BOOL)isSuccess;

@end

//代购订单详情
@interface TradeOrderDetailDto : NSObject

@property (nonatomic, copy) NSString *code;         //0 成功
@property (nonatomic, copy) NSString *desc;         //失败返回错误信息
@property (nonatomic, copy) NSString *buyid;        //购买编号
@property (nonatomic, copy) NSString *nickid;       //认购人
@property (nonatomic, copy) NSString *bnum;         //认购份数
@property (nonatomic, copy) NSString *buydate;      //认购日期
@property (nonatomic, copy) NSString *bmoney;       //认购金额
@property (nonatomic, copy) NSString *cancel;       //是否撤销 (0 未撤销 1 本人撤销 2 系统撤销）
@property (nonatomic, copy) NSString *canceldate;   //撤销日期
@property (nonatomic, copy) NSString *award;        //记奖标志 0 未记奖 2 已计奖
@property (nonatomic, copy) NSString *awarddate;    //计奖日期
@property (nonatomic, copy) NSString *amoney;       //派奖金额
@property (nonatomic, copy) NSString *ireturn;      //是否派奖 0 未派奖 1 派奖中 2 已派奖
@property (nonatomic, copy) NSString *retdate;      //派奖时间
@property (nonatomic, copy) NSString *rmoney;       //认购派奖金额
@property (nonatomic, copy) NSString *source;       //投注来源 0 网站 1 客户端 2 手机 3 wap
@property (nonatomic, copy) NSString *pay;          //是否支付成功（-1支付失败 0未支付成功 1支付成功 2退款中 3已退款）

@property (nonatomic, copy) NSString *projid;       //方案编号
@property (nonatomic, copy) NSString *cnickid;      //发起人
@property (nonatomic, copy) NSString *gameid;       //游戏编号
@property (nonatomic, copy) NSString *periodid;     //期次
@property (nonatomic, copy) NSString *cname;        //合买名称
@property (nonatomic, copy) NSString *cdesc;        //合买描述
@property (nonatomic, copy) NSString *ccodes;       //投注号码
@property (nonatomic, copy) NSString *mulity;       //倍数
@property (nonatomic, copy) NSString *play;         //玩法 单式 复式
@property (nonatomic, copy) NSString *itype;        //方案类型 0 代沟 1 合买
@property (nonatomic, copy) NSString *ifile;        //是否文件投注 0 不是 1 是
@property (nonatomic, copy) NSString *tmoney;       //总金额
@property (nonatomic, copy) NSString *smoney;       //每份金额
@property (nonatomic, copy) NSString *nums;         //总份数
@property (nonatomic, copy) NSString *onum;         //发起人认购份数
@property (nonatomic, copy) NSString *pnum;         //发起人保底份数
@property (nonatomic, copy) NSString *Inum;         //剩余份数
@property (nonatomic, copy) NSString *iopen;        //是否保密 （0 对所有人公开 1 截止后公开 2 对参与人员公开 3 截止后对参与人公开）
@property (nonatomic, copy) NSString *wrate;        //发起人中奖提成率
@property (nonatomic, copy) NSString *jindu;        //进度
@property (nonatomic, copy) NSString *views;        //方案关注次数
@property (nonatomic, copy) NSString *endtime;      //截止时间
@property (nonatomic, copy) NSString *adddate;      //发起时间
@property (nonatomic, copy) NSString *mydate;       //满员时间
@property (nonatomic, copy) NSString *istate;       //状态(0 禁止认购 1 认购中,2 已满员 3过期未满撤销 4主动撤销 5已出票 6 已派奖)
@property (nonatomic, copy) NSString *upload;       //是否上传 0 未穿  1 已传
@property (nonatomic, copy) NSString *loaddate;     //上传时间
@property (nonatomic, copy) NSString *iclear;       //是否清保 0 未清 1 正在清 2 已清
@property (nonatomic, copy) NSString *cleardate;    //清保时间
@property (nonatomic, copy) NSString *icast;        //出票标志（0 未出票 1 可以出票 2 已拆票 3 已出票）
@property (nonatomic, copy) NSString *bingo;        //匹配标志（0 未匹配 1 正在匹配 2 已匹配)
@property (nonatomic, copy) NSString *bgdate;       //匹配时间
@property (nonatomic, copy) NSString *wininfo;      //中奖信息（中奖注数用逗号隔开）
@property (nonatomic, copy) NSString *rowaward;     //计奖标志（0 未计奖 1 正在计奖 2 已计奖)
@property (nonatomic, copy) NSString *rowawarddate; //计奖时间
@property (nonatomic, copy) NSString *bonus;        //总奖金
@property (nonatomic, copy) NSString *tax;          //税后奖金
@property (nonatomic, copy) NSString *owins;        //发起人提成奖金
@property (nonatomic, copy) NSString *oreturn;      //发起人提成是否派奖（0 未派 1 正在派 2 已派）
@property (nonatomic, copy) NSString *oretdate;     //发起人提成派奖时间
@property (nonatomic, copy) NSString *rowireturn;   //是否派奖
@property (nonatomic, copy) NSString *rowretdate;   //派奖时间
@property (nonatomic, copy) NSString *zhanji;       //战绩是否统计（0 未统计 1 正在统计 2 已统计)
@property (nonatomic, copy) NSString *aunum;        //金星个数
@property (nonatomic, copy) NSString *agnum;        //银星个数
@property (nonatomic, copy) NSString *gaunum;       //获得金星个数
@property (nonatomic, copy) NSString *gagnum;       //获得银星个数
@property (nonatomic, copy) NSString *rowsource;    //投注来源( 0 网站 1 客户端 2 手机 3 WAP)
@property (nonatomic, copy) NSString *awardcode;    //开奖号码

@property(nonatomic,copy) NSString      *localState;   //0出票中 1出票失败 2 等待开奖 3 未中奖 4 已中奖
@property(nonatomic,copy) NSString      *winState;     //0出票中 1出票失败 2 等待开奖 3 未中奖 4 已中奖


- (void)encodeWithJoinDic:(NSDictionary *)joinDic andRowDic:(NSDictionary *)rowDic;

- (NSString *)localState;

@end

@interface FollowPerodDetailDto : NSObject

@property (nonatomic, copy) NSString *code;         // 0 成功
@property (nonatomic, copy) NSString *desc;         //错误描述
@property (nonatomic, copy) NSString *idetailid;    //追号明细编号
@property (nonatomic, copy) NSString *czhid;        //追号方案编号
@property (nonatomic, copy) NSString *cperiodid;    //期次编码
@property (nonatomic, copy) NSString *ccodes;       //投注方案
@property (nonatomic, copy) NSString *icmoney;      //投注金额
@property (nonatomic, copy) NSString *ccastdate;    //投注日期
@property (nonatomic, copy) NSString *istate;       //状态 (-1 待支付 0 未投注 1正在处理 2 已投注 3 取消 )
@property (nonatomic, copy) NSString *cadddate;     //追号购买时间
@property (nonatomic, copy) NSString *cwinininfo;   //中奖信息
@property (nonatomic, copy) NSString *cbgdate;      //中奖日期
@property (nonatomic, copy) NSString *ibingo;       //中奖匹配 0 未处理 1 正在处理 2 处理完成
@property (nonatomic, copy) NSString *imulity;      //倍数
@property (nonatomic, copy) NSString *cawarddate;   //算奖时间
@property (nonatomic, copy) NSString *iaward;       //是否算奖 0 未出来 1 正在处理 2 已算奖
@property (nonatomic, copy) NSString *iamoney;      //中奖金额
@property (nonatomic, copy) NSString *isreturn;     //是否派奖 0 未派奖 1 正在处理 2 已派奖
@property (nonatomic, copy) NSString *creturndate;  //派奖时间
@property (nonatomic, copy) NSString *irmoney;      //中奖金额
@property (nonatomic, copy) NSString *itax;         //税后奖金
@property (nonatomic, copy) NSString *cnickid;      //用户编号
@property (nonatomic, copy) NSString *ijiesuan;     //结算标志（0 未结算 1 正在结算 2 已结算）
@property (nonatomic, copy) NSString *cjsdate;      //结算时间
@property (nonatomic, copy) NSString *iumoney;      //追号返点
@property (nonatomic, copy) NSString *izhanji;      //战绩是否统计（0 未统计 1 正在统计 2 已统计)
@property (nonatomic, copy) NSString *igaunum;      //获得金星个数
@property (nonatomic, copy) NSString *igagnum;      //获得银星个数
@property (nonatomic, copy) NSString *ipay;         //是否支付成功（0未支付成功 1支付成功 2退款中 3已退款）
@property (nonatomic, copy) NSString *cusername;    //用户姓名
@property (nonatomic, copy) NSString *cidcard;      //身份证号码
@property (nonatomic, copy) NSString *cmobileno;    //绑定的手机号码
@property (nonatomic, copy) NSString *cawardcode;   //中奖号码

- (void)encodeWithRow:(NSDictionary *)row;

@end

