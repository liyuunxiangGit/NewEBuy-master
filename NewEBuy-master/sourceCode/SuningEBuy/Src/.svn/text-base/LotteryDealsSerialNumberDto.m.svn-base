//
//  LotteryDealsSerialNumberDto.m
//  SuningLottery
//
//  Created by lyywhg on 13-4-17.
//  Copyright (c) 2013年 suning. All rights reserved.
//

#import "LotteryDealsSerialNumberDto.h"

@implementation LotteryDealsSerialNumberDto

@synthesize zhid = _zhid;
@synthesize gid = _gid;
@synthesize pid = _pid;
@synthesize pnums = _pnums;
@synthesize zhflag = _zhflag;
@synthesize finish = _finish;
@synthesize success = _success;
@synthesize failure = _failure;
@synthesize adddate = _adddate;
@synthesize tmoney = _tmoney;
@synthesize reason = _reason;
@synthesize bonus = _bonus;
@synthesize casts = _casts;
@synthesize pay = _pay;

@synthesize localState = _localState;

- (void)dealloc {
    TT_RELEASE_SAFELY(_zhid);
    TT_RELEASE_SAFELY(_gid);
    TT_RELEASE_SAFELY(_pid);
    TT_RELEASE_SAFELY(_pnums);
    TT_RELEASE_SAFELY(_zhflag);
    TT_RELEASE_SAFELY(_finish);
    TT_RELEASE_SAFELY(_success);
    TT_RELEASE_SAFELY(_failure);
    TT_RELEASE_SAFELY(_adddate);
    TT_RELEASE_SAFELY(_tmoney)
    TT_RELEASE_SAFELY(_reason);
    TT_RELEASE_SAFELY(_bonus);
    TT_RELEASE_SAFELY(_casts);
    TT_RELEASE_SAFELY(_pay);
    
    TT_RELEASE_SAFELY(_localState);
}

-(void)encodeFromDictionary:(NSDictionary *)dic{
    
    if (dic == nil) {
        return;
    }
    
    self.zhid = [dic objectForKey:@"@zhid"] == nil?@"":[dic objectForKey:@"@zhid"];
    self.gid     = [dic objectForKey:@"@gameid"] == nil?@"":[dic objectForKey:@"@gameid"];
    self.pid     = [dic objectForKey:@"@pid"] == nil?@"":[dic objectForKey:@"@pid"];
     self.pnums    = [dic objectForKey:@"@pnums"] == nil?@"":[dic objectForKey:@"@pnums"];
    self.zhflag   =[dic objectForKey:@"@zhflag"] == nil?@"":[dic objectForKey:@"@zhflag"];
    self.finish   =[dic objectForKey:@"@finish"] == nil?@"":[dic objectForKey:@"@finish"];
    self.success  = [dic objectForKey:@"@success"] == nil?@"":[dic objectForKey:@"@success"];
    self.failure  = [dic objectForKey:@"@failure"] == nil?@"":[dic objectForKey:@"@failure"];
    self.adddate  = [dic objectForKey:@"@adddate"] == nil?@"":[dic objectForKey:@"@adddate"];
    self.tmoney   = [dic objectForKey:@"@tmoney"] == nil?@"":[dic objectForKey:@"@tmoney"];
    self.reason  = [dic objectForKey:@"@reason"] == nil?@"":[dic objectForKey:@"@reason"];
    self.bonus  = [dic objectForKey:@"@bonus"] == nil?@"":[dic objectForKey:@"@bonus"];
    self.casts  = [dic objectForKey:@"@casts"] == nil?@"":[dic objectForKey:@"@casts"];
    self.pay  = [dic objectForKey:@"@pay"]  == nil?@"":[dic objectForKey:@"@pay"];
    
    
    if ([self.finish integerValue] == 1) {
        self.localState = L(@"LOAdditioned");
    }else
    {
        self.localState = L(@"LOAdditioning");
    }
    
}

@end
