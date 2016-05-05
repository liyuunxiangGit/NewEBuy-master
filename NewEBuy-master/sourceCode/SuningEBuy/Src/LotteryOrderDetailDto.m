//
//  LotteryOrderDetailDto.m
//  SuningEBuy
//
//  Created by huangtf on 12-9-12.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "LotteryOrderDetailDto.h"

@interface LotteryOrderDetailDto()

-(BOOL)isNullOrEmpty:(NSString *)string;

@end

@implementation LotteryOrderDetailDto

@synthesize projid = _projid;
@synthesize gameName = _gameName;
@synthesize gameId = _gameId;
@synthesize pid = _pid;
@synthesize saleType = _saleType;
@synthesize buyDate = _buyDate;
@synthesize buyMoney = _buyMoney;
@synthesize winLottery = _winLottery;
@synthesize cancel = _cancel;
@synthesize ireturn = _ireturn;
@synthesize rmoney = _rmoney;
@synthesize pay = _pay;
@synthesize mulity = _mulity;
@synthesize ccodes = _ccodes;
@synthesize awardcode = _awardcode;


- (void)dealloc {
    
    TT_RELEASE_SAFELY(_projid);
    TT_RELEASE_SAFELY(_gameName);
    TT_RELEASE_SAFELY(_gameId);
    TT_RELEASE_SAFELY(_pid);
    TT_RELEASE_SAFELY(_saleType);
    TT_RELEASE_SAFELY(_buyDate);
    TT_RELEASE_SAFELY(_buyMoney);
    TT_RELEASE_SAFELY(_winLottery);
    TT_RELEASE_SAFELY(_cancel);
    TT_RELEASE_SAFELY(_ireturn);
    TT_RELEASE_SAFELY(_rmoney);
    TT_RELEASE_SAFELY(_pay);
    TT_RELEASE_SAFELY(_mulity);
    TT_RELEASE_SAFELY(_ccodes);
    TT_RELEASE_SAFELY(_awardcode);
}


-(void)encodeFromDictionary:(NSDictionary *)dic1 andAnotherDic:(NSDictionary *)dic2{
    
    if (dic1 == nil || dic2 == nil) {
        
        return;
    }
    
    if(NotNilAndNull([dic1 objectForKey:@"@projid"]) ){
        self.projid=[dic1 objectForKey:@"@projid"] ;
    }
    if(NotNilAndNull([dic1 objectForKey:@"@gameid"])){
        self.gameId=[dic1 objectForKey:@"@gameid"];
    }
    
//    self.projid = [dic1 objectForKey:@"@projid"] == nil?@"":[dic1 objectForKey:@"@projid"];
//    
//    self.gameId = [dic1 objectForKey:@"@gameid"] == nil?@"":[dic1 objectForKey:@"@gameid"];
    
    if ([self.gameId isEqualToString:@"01"]) {
        
        self.gameName = L(@"DoubleColor ball");
        
    }else if([self.gameId isEqualToString:@"50"]){
        
        self.gameName = L(@"BigLotto");
    }
    
    if(NotNilAndNull([dic1 objectForKey:@"@periodid"])){
        self.pid=[dic1 objectForKey:@"@periodid"];
    }
    
    if(NotNilAndNull([dic1 objectForKey:@"@cdesc"])){
        self.saleType=[dic1 objectForKey:@"@cdesc"];
    }
    if(NotNilAndNull([dic1 objectForKey:@"@mulity"] )){
        self.mulity=[dic1 objectForKey:@"@mulity"] ;
    }
    if(NotNilAndNull([dic1 objectForKey:@"@bonus"])){
        self.winLottery=[dic1 objectForKey:@"@bonus"];
    }
    if(NotNilAndNull([dic1 objectForKey:@"@ccodes"])){
        self.ccodes=[dic1 objectForKey:@"@ccodes"];
    }
//    self.pid = [dic1 objectForKey:@"@periodid"] == nil?@"":[dic1 objectForKey:@"@periodid"];
//    
//    self.saleType = [dic1 objectForKey:@"@cdesc"] == nil?@"":[dic1 objectForKey:@"@cdesc"];
//    
//    self.mulity = [dic1 objectForKey:@"@mulity"] == nil?@"":[dic1 objectForKey:@"@mulity"];
//    
//    self.winLottery = [dic1 objectForKey:@"@bonus"] == nil?@"":[dic1 objectForKey:@"@bonus"];
//    
//    self.ccodes = [dic1 objectForKey:@"@ccodes"] == nil?@"":[dic1 objectForKey:@"@ccodes"];
    
    NSString *tempString = [dic1 objectForKey:@"@awardcode"];
    
    if ([self isNullOrEmpty:tempString]) {
        
        self.awardcode = tempString;
        
    }else{
        
        self.awardcode = L(@"LONoLotteryInfo");;
        
    }
    if(NotNilAndNull([dic2 objectForKey:@"@bmoney"])){
        self.buyMoney=[dic2 objectForKey:@"@bmoney"];
    }
    if(NotNilAndNull([dic2 objectForKey:@"@buydate"])){
        self.buyDate=[dic2 objectForKey:@"@buydate"];
    }
    if(NotNilAndNull([dic2 objectForKey:@"@cancel"] )){
        self.cancel=[dic2 objectForKey:@"@cancel"] ;
    }
    if(NotNilAndNull([dic2 objectForKey:@"@ireturn"])){
        self.ireturn=[dic2 objectForKey:@"@ireturn"];
    }
    if(NotNilAndNull([dic2 objectForKey:@"@rmoney"])){
        self.rmoney=[dic2 objectForKey:@"@rmoney"];
    }
    if(NotNilAndNull([dic2 objectForKey:@"@pay"] )){
        self.pay=[dic2 objectForKey:@"@pay"] ;
    }
    
//    
//    self.buyMoney = [dic2 objectForKey:@"@bmoney"] == nil?@"":[dic2 objectForKey:@"@bmoney"];
//    
//    self.buyDate = [dic2 objectForKey:@"@buydate"] == nil?@"":[dic2 objectForKey:@"@buydate"];
//    
//    self.cancel = [dic2 objectForKey:@"@cancel"] == nil?@"":[dic2 objectForKey:@"@cancel"];
//    
//    self.ireturn = [dic2 objectForKey:@"@ireturn"] == nil?@"":[dic2 objectForKey:@"@ireturn"];
//    
//    self.rmoney = [dic2 objectForKey:@"@rmoney"] == nil?@"":[dic2 objectForKey:@"@rmoney"];
//    
//    self.pay = [dic2 objectForKey:@"@pay"] == nil?@"":[dic2 objectForKey:@"@pay"];
    
}


/*
 * YES:不为空
 * NO:为空或者为nil
 */
-(BOOL)isNullOrEmpty:(NSString *)string{
    
    if (!string) {
        
        return NO;
        
    }else if([string isEqualToString:@""]){
        
        return NO;
    }
    
    return YES;
}

@end
