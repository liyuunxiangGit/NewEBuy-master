//
//  LotteryHallDto.m
//  SuningEBuy
//
//  Created by david david on 12-6-27.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import "LotteryHallDto.h"

@implementation LotteryHallDto


@synthesize date = _date;
@synthesize gid = _gid;
@synthesize pid = _pid;
@synthesize gname = _gname;
@synthesize code = _code;
@synthesize awardtime = _awardtime;
@synthesize ginfo = _ginfo;
@synthesize ninfo = _ninfo;
@synthesize etime = _etime;
@synthesize sales = _sales;
@synthesize pools = _pools;
@synthesize nowpid = _nowpid;
@synthesize nowendtime = _nowendtime;
@synthesize nowfendtime = _nowfendtime;

- (id)init {
    
    self = [super init];
    
    if (self) {
        
    }
    return self;
}


-(void)encodeFromDictionary:(NSDictionary *)dic andExDic:(NSDictionary *)dicEx{
    
    
	if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
	
    //parse data from dic
	self.gid                = [dic objectForKey:@"@gid"] == nil?@"":[dic objectForKey:@"@gid"];
	self.pid                = [dic objectForKey:@"@pid"] == nil?@"":[dic objectForKey:@"@pid"];
	self.gname              = [dic objectForKey:@"@gname"] == nil?@"":[dic objectForKey:@"@gname"];
	self.code               = [dic objectForKey:@"@code"] == nil?@"":[dic objectForKey:@"@code"];
	self.awardtime          = [dic objectForKey:@"@awardtime"] == nil?@"":[dic objectForKey:@"@awardtime"];
	self.ginfo              = [dic objectForKey:@"@ginfo"] == nil?@"":[dic objectForKey:@"@ginfo"];
	self.ninfo              = [dic objectForKey:@"@ninfo"] == nil?@"":[dic objectForKey:@"@ninfo"];
    self.etime              = [dic objectForKey:@"@etime"] == nil?@"":[dic objectForKey:@"@etime"];
    self.sales              = [dic objectForKey:@"@sales"] == nil?@"0":[dic objectForKey:@"@sales"];
    self.pools              = [dic objectForKey:@"@pools"] == nil?@"0":[dic objectForKey:@"@pools"];
    //parse data from dicEx
    self.nowpid             = [dicEx objectForKey:@"@nowpid"] == nil?@"":[dicEx objectForKey:@"@nowpid"];
    self.nowendtime         = [dicEx objectForKey:@"@nowendtime"] == nil?@"":[dicEx objectForKey:@"@nowendtime"];
    self.nowfendtime        = [dicEx objectForKey:@"@nowfendtime"] == nil?@"":[dicEx objectForKey:@"@nowfendtime"];
    self.isale              = [dicEx objectForKey:@"@isale"]   == nil?@"":[dicEx objectForKey:@"@isale"];
    
    
}


- (void)encodeWithCoder:(NSCoder *)coder
{
    
    [coder encodeObject:self.date forKey:@"date"];
    [coder encodeObject:self.gid forKey:@"gid"];
    [coder encodeObject:self.pid forKey:@"pid"];
    [coder encodeObject:self.gname forKey:@"gname"];
    [coder encodeObject:self.code forKey:@"code"];
    [coder encodeObject:self.awardtime forKey:@"awardtime"];
    
    
    [coder encodeObject:self.ginfo forKey:@"ginfo"];
    [coder encodeObject:self.ninfo forKey:@"ninfo"];
    [coder encodeObject:self.etime forKey:@"etime"];
    [coder encodeObject:self.sales forKey:@"sales"];
    [coder encodeObject:self.pools forKey:@"pools"];
    
    [coder encodeObject:self.nowpid forKey:@"nowpid"];
    [coder encodeObject:self.nowendtime forKey:@"nowendtime"];
    [coder encodeObject:self.nowfendtime forKey:@"nowfendtime"];
    [coder encodeObject:self.isale forKey:@"isale"];
    
}

- (id)initWithCoder:(NSCoder *)coder
{
    
    if (self = [super init])
    {
        self.date = [coder decodeObjectForKey:@"date"];
        self.gid = [coder decodeObjectForKey:@"gid"];
        self.pid = [coder decodeObjectForKey:@"pid"];
        self.gname = [coder decodeObjectForKey:@"gname"];
        self.code = [coder decodeObjectForKey:@"code"];
        self.awardtime = [coder decodeObjectForKey:@"awardtime"];
        
        self.ginfo = [coder decodeObjectForKey:@"ginfo"];
        self.ninfo = [coder decodeObjectForKey:@"ninfo"];
        self.etime = [coder decodeObjectForKey:@"etime"];
        self.sales = [coder decodeObjectForKey:@"sales"];
        self.pools = [coder decodeObjectForKey:@"pools"];
        
        self.nowpid = [coder decodeObjectForKey:@"nowpid"];
        self.nowendtime = [coder decodeObjectForKey:@"nowendtime"];
        self.nowfendtime = [coder decodeObjectForKey:@"nowfendtime"];
        self.isale = [coder decodeObjectForKey:@"isale"];
    }
    
    return self;
}



- (void)dealloc {
    
    TT_RELEASE_SAFELY(_date);
    TT_RELEASE_SAFELY(_gid);
    TT_RELEASE_SAFELY(_pid);
    TT_RELEASE_SAFELY(_gname);
    TT_RELEASE_SAFELY(_code);
    TT_RELEASE_SAFELY(_awardtime);
    TT_RELEASE_SAFELY(_ginfo);
    TT_RELEASE_SAFELY(_ninfo);
    TT_RELEASE_SAFELY(_etime);
    TT_RELEASE_SAFELY(_sales);
    TT_RELEASE_SAFELY(_pools);
    TT_RELEASE_SAFELY(_nowpid);
    TT_RELEASE_SAFELY(_nowendtime);
    TT_RELEASE_SAFELY(_nowfendtime);
    TT_RELEASE_SAFELY(_isale);
    
}

@end
