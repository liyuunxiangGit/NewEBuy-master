//
//  LotteryDealsDto.m
//  SuningLottery
//
//  Created by lyywhg on 13-4-17.
//  Copyright (c) 2013年 suning. All rights reserved.
//

#import "LotteryDealsDto.h"

@implementation LotteryDealsDto

@synthesize gid = _gid;
@synthesize buyDate = _buyDate;
@synthesize pid = _pid;
@synthesize bnum = _bnum;
@synthesize money = _money;
@synthesize cancel = _cancel;
@synthesize award = _award;
@synthesize isReturn = _isReturn;
@synthesize amoney = _amoney;
@synthesize rmoney = _rmoney;
@synthesize retdate = _retdate;
@synthesize pay = _pay;
@synthesize projid = _projid;
@synthesize icast = _icast;
@synthesize istate = _istate;

@synthesize localState = _localState;
- (void)dealloc {
    
    TT_RELEASE_SAFELY(_gid);
    TT_RELEASE_SAFELY(_buyDate);
    TT_RELEASE_SAFELY(_pid);
    TT_RELEASE_SAFELY(_bnum);
    TT_RELEASE_SAFELY(_money);
    TT_RELEASE_SAFELY(_cancel);
    TT_RELEASE_SAFELY(_award);
    TT_RELEASE_SAFELY(_isReturn);
    TT_RELEASE_SAFELY(_amoney);
    TT_RELEASE_SAFELY(_rmoney);
    TT_RELEASE_SAFELY(_retdate);
    TT_RELEASE_SAFELY(_pay);
    TT_RELEASE_SAFELY(_projid);
    TT_RELEASE_SAFELY(_icast);
    TT_RELEASE_SAFELY(_istate);
    TT_RELEASE_SAFELY(_localState);
    
}

-(void)encodeFromDictionary:(NSDictionary *)dic{
    
    if (dic == nil) {
        return;
    }
        
    self.gid     = [dic objectForKey:@"@gid"] == nil?@"":[dic objectForKey:@"@gid"];
    self.buyDate = [dic objectForKey:@"@buydate"] == nil?@"":[dic objectForKey:@"@buydate"];
    
    self.pid     = [dic objectForKey:@"@pid"] == nil?@"":[dic objectForKey:@"@pid"];
    
    self.bnum    = [dic objectForKey:@"@bnum"] == nil?@"":[dic objectForKey:@"@bnum"];
    self.money   = [dic objectForKey:@"@money"] == nil?@"":[dic objectForKey:@"@money"];
    self.cancel     = [dic objectForKey:@"@cancel"] == nil?@"":[dic objectForKey:@"@cancel"];
    
    self.isReturn    = [dic objectForKey:@"@return"] == nil?@"":[dic objectForKey:@"@return"];
    self.award   = [dic objectForKey:@"@award"] == nil?@"":[dic objectForKey:@"@award"];
    self.amoney     = [dic objectForKey:@"@amoney"] == nil?@"":[dic objectForKey:@"@amoney"];
    
    self.rmoney    = [dic objectForKey:@"@rmoney"] == nil?@"":[dic objectForKey:@"@rmoney"];
    self.retdate   = [dic objectForKey:@"@retdate"] == nil?@"":[dic objectForKey:@"@retdate"];
    self.pay     = [dic objectForKey:@"@pay"] == nil?@"":[dic objectForKey:@"@pay"];
    self.projid = [dic objectForKey:@"@projid"] == nil?@"":[dic objectForKey:@"@projid"];
    self.icast = [dic objectForKey:@"@icast"] == nil?@"":[dic objectForKey:@"@icast"];
    self.istate = [dic objectForKey:@"@istate"] == nil?@"":[dic objectForKey:@"@istate"];
    self.cendtime = [dic objectForKey:@"@cendtime"] == nil?@"":[dic objectForKey:@"@cendtime"];
    self.coupon = [dic objectForKey:@"@coupon"] == nil?@"":[dic objectForKey:@"@coupon"];
    self.buyid = [dic objectForKey:@"@buyid"] == nil?@"":[dic objectForKey:@"@buyid"];
    
    
    //    *pay;           //是否支付成功（－1支付失败 0未支付成功 1支付成功 2退款中 3已退款）coupon
    //      *icast;         //是否出票 0 未出票 1可以出票 2已拆票 3已出票
    //      *istate;        //状态 -1未支付 0禁止认购 1认购中 2已满员 3过期未满撤销 4主动撤销 5出票失败撤销
    //         *localState;   //0出票中 1出票失败 2 等待开奖 3 未中奖 4 已中奖
    //         *award;         //计奖标志（0未计奖 2已计奖）
    //        *isReturn;      //是否派奖（0未派奖 1派奖中 2已派奖）
    
    //本地状态判断  根据服务端js修改
    //    self.localState = [self.icast integerValue] == 3?([self.istate integerValue] > 2?@"出票失败":([self.award integerValue]== 2?([self.amoney integerValue] > 0?@"已中奖":@"未中奖"):@"待开奖")):([self.icast integerValue] ==  0 ?@"出票中":([self.icast integerValue] == 1?@"出票中":([self.istate integerValue] > 2?@"出票失败":@"出票中")));
    //    *cancel;        //是否撤销（0未撤销 1本人撤销 2系统撤销）
    //    DLog(@"pai")
    if ([self.istate integerValue]==-1) {
        
        if ( [self isExpiredWithDataString:self.cendtime]) {
            self.localState = L(@"OverTimeNotPayed");
        }
        else if ([self.award integerValue]==0 ) {
            self.localState = L(@"Waiting payment");
        }
        
    }else if([self.istate integerValue]==2)//是否支付
    {
        if([self.icast integerValue] == 3){//出票成功
            self.localState = L(@"BTIssueTicketSuccess");
            
        }
        
        if([self.icast integerValue] == 2 || [self.icast integerValue] == 1){//拆票
            self.localState = L(@"Ticketing");
            
        }
        
        if([self.icast integerValue] == 0){//未出票
            self.localState = L(@"LONoTicketing");
            
        }
        
    }
    
    if ([self.istate integerValue] > 2)
    {
        self.localState = L(@"TicketFail");
    }
    
    if ([self.istate integerValue] == 4)
    {
        self.localState = L(@"UserUndo");
    }
    
    self.isExpired = [self isExpiredWithDataString:self.cendtime];
    
}

//判断是否过期未支付
-(BOOL)isExpiredWithDataString:(NSString *)dataString
{
    [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    NSDate *datenow = [NSDate date];
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate* endDate = [inputFormatter dateFromString:dataString];
    
    long  endTimeZone =  (long)[endDate timeIntervalSince1970];
    long  nowTimeZone =  (long)[datenow timeIntervalSince1970];
    
    return ((nowTimeZone-endTimeZone)>0)?YES:NO;
}
@end
