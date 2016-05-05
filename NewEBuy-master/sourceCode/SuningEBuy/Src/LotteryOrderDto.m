//
//  LotteryOrderDto.m
//  SuningEBuy
//
//  Created by huangtf on 12-9-12.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "LotteryOrderDto.h"

@implementation LotteryOrderDto

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
    
}

-(void)encodeFromDictionary:(NSDictionary *)dic{
    
    if (dic == nil) {
        return;
    }
    
    if(NotNilAndNull([dic objectForKey:@"@gid"]))
    {
        self.gid = [dic objectForKey:@"@gid"];
    }
    if(NotNilAndNull([dic objectForKey:@"@buydate"])){
        self.buyDate = [dic objectForKey:@"@buydate"];
    }
    
//    self.gid     = [dic objectForKey:@"@gid"] == nil?@"":[dic objectForKey:@"@gid"];
//    self.buyDate = [dic objectForKey:@"@buydate"] == nil?@"":[dic objectForKey:@"@buydate"];
    
    if ([self.buyDate length]>10) {//只取年月日
        
        self.buyDate = [self.buyDate substringToIndex:10];
    }
    if(NotNilAndNull([dic objectForKey:@"@pid"] ))
    {
        self.pid = [dic objectForKey:@"@pid"];
    }
    if(NotNilAndNull([dic objectForKey:@"@bnum"])){
        self.bnum    = [dic objectForKey:@"@bnum"] ;
    }
    if(NotNilAndNull([dic objectForKey:@"@money"] )){
        self.money   = [dic objectForKey:@"@money"];
    }
    if(NotNilAndNull([dic objectForKey:@"@cancel"])){
        self.cancel     = [dic objectForKey:@"@cancel"];
    }
    if(NotNilAndNull([dic objectForKey:@"@return"])){
        self.isReturn=[dic objectForKey:@"@return"];
    }
    if(NotNilAndNull([dic objectForKey:@"@award"])){
        self.award=[dic objectForKey:@"@award"];
    }
    if(NotNilAndNull([dic objectForKey:@"@amoney"])){
        self.amoney=[dic objectForKey:@"@amoney"];
    }
    if(NotNilAndNull([dic objectForKey:@"@rmoney"])){
        self.rmoney=[dic objectForKey:@"@rmoney"];
    }
    if(NotNilAndNull([dic objectForKey:@"@retdate"])){
        self.retdate=[dic objectForKey:@"@retdate"];
    }
    if(NotNilAndNull([dic objectForKey:@"@pay"])){
        self.pay=[dic objectForKey:@"@pay"];
    }
    if(NotNilAndNull([dic objectForKey:@"@projid"])){
        self.projid=[dic objectForKey:@"@projid"];
    }
    
    
//    self.pid     = [dic objectForKey:@"@pid"] == nil?@"":[dic objectForKey:@"@pid"];
//    
//    self.bnum    = [dic objectForKey:@"@bnum"] == nil?@"":[dic objectForKey:@"@bnum"];
//    self.money   = [dic objectForKey:@"@money"] == nil?@"":[dic objectForKey:@"@money"];
//    self.cancel     = [dic objectForKey:@"@cancel"] == nil?@"":[dic objectForKey:@"@cancel"];
//    
//    self.isReturn    = [dic objectForKey:@"@return"] == nil?@"":[dic objectForKey:@"@return"];
//    self.award   = [dic objectForKey:@"@award"] == nil?@"":[dic objectForKey:@"@award"];
//    self.amoney     = [dic objectForKey:@"@amoney"] == nil?@"":[dic objectForKey:@"@amoney"];
//    
//    self.rmoney    = [dic objectForKey:@"@rmoney"] == nil?@"":[dic objectForKey:@"@rmoney"];
//    self.retdate   = [dic objectForKey:@"@retdate"] == nil?@"":[dic objectForKey:@"@retdate"];
//    self.pay     = [dic objectForKey:@"@pay"] == nil?@"":[dic objectForKey:@"@pay"];
//    self.projid = [dic objectForKey:@"@projid"] == nil?@"":[dic objectForKey:@"@projid"];
    
}

@end
