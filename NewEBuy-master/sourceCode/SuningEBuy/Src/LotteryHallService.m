//
//  LotteryHallService.m
//  SuningEBuy
//
//  Created by 漫 王 on 12-8-30.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "LotteryHallService.h"

#import "LotteryHallDto.h"

@implementation LotteryHallService

@synthesize lotteryHallHttpMsg = _lotteryHallHttpMsg;

@synthesize lotteryCatArray = _lotteryCatArray;

@synthesize lotteryAllArray = _lotteryAllArray;

@synthesize delegate = _delegate;

- (void)dealloc {
    
    TT_RELEASE_SAFELY(_lotteryCatArray);
    
    TT_RELEASE_SAFELY(_lotteryAllArray);
    
}

- (id)init {
    self = [super init];
    
    if (self) {
        NSMutableArray *tempArray1 = [[NSMutableArray alloc]init];
        
        self.lotteryCatArray = tempArray1;
        
        TT_RELEASE_SAFELY(tempArray1);
        
        
        NSMutableArray *tempArray2 = [[NSMutableArray alloc]init];
        
        self.lotteryAllArray = tempArray2;
        
        TT_RELEASE_SAFELY(tempArray2);
    }
    
    return self;
}



- (void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(_lotteryHallHttpMsg);
}

-(void)sendLotteryHallInfoHttpRequest
{
    [self.lotteryCatArray removeAllObjects];
    
    [self.lotteryAllArray removeAllObjects];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostLotteryTicketForHttp,KLotteryTicketHall];
    
    NSMutableDictionary *posDataDic = [[NSMutableDictionary alloc]initWithCapacity:2];
    
    [posDataDic setObject:@"01" forKey:@"gid"];
    
    [posDataDic setObject:@"1" forKey:@"json"];
    
    HTTPMSG_RELEASE_SAFELY(_lotteryHallHttpMsg);
    
    _lotteryHallHttpMsg = [[HttpMessage alloc]initWithDelegate:self requestUrl:url postDataDic:posDataDic cmdCode:CC_LotteryHall];
    
    [self.httpMsgCtrl sendHttpMsg:_lotteryHallHttpMsg];
    
    TT_RELEASE_SAFELY(posDataDic);
    
}


#pragma mark -
#pragma mark httpMessage delegate

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    DLog("requestLotteryHallFail == \n%@", receiveMsg.errorCode);
    
    if (_delegate && [_delegate respondsToSelector:@selector(lotteryHallRequestCompletedWithResult:
                                                             andLotreryAllList:
                                                             isSuccess:
                                                             errorCode:)]) {
        [_delegate lotteryHallRequestCompletedWithResult:nil andLotreryAllList:nil isSuccess:NO errorCode:receiveMsg.errorCode];
    }
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    if (receiveMsg.cmdCode == CC_LotteryHall) {
        
        NSDictionary *items = receiveMsg.jasonItems;
        
        Background_Begin
        NSString *desc = nil;
        
        if ([[items objectForKey:@"@code"]intValue] != 0) {
            
            NSString *error= [items objectForKey:@"@desc"];
            
            if (error) {
                desc = error;
            }else{
                desc = L(@"Failed to get lottery hall");
            }
        }
        
        NSArray *rowList = [items objectForKey:@"row"];
        
        NSArray *rownowList = [items objectForKey:@"rownow"];
        
        NSString *sysTime = [items objectForKey:@"@date"];
        
        if (rowList && ([rowList count] > 0))
        {
            for (NSDictionary *dic1 in rowList)
            {
                NSString *rowGameId = [dic1 objectForKey:@"@gid"];
                
                if (rownowList && ([rownowList count] > 0))
                {
                    for (NSDictionary *dic2 in rownowList)
                    {
                        NSString *rowNowGameId = [dic2 objectForKey:@"@gid"];
                        DLog(@"rKey:@@gname ====%@------%@", [dic2 objectForKey:@"@gname"], rowNowGameId);
                        
                        if ([rowGameId isEqualToString:rowNowGameId])
                        {
                            LotteryHallDto *dto = [[LotteryHallDto alloc]init];
                            
                            [dto encodeFromDictionary:dic1 andExDic:dic2];
                            
                            dto.date = sysTime;
                            
                            if ([rowGameId isEqualToString:@"01"] || [rowGameId isEqualToString:@"50"] || [rowGameId isEqualToString:@"03"] || [rowGameId isEqualToString:@"07"] || [rowGameId isEqualToString:@"51"] || [rowGameId isEqualToString:@"52"]
                                || [rowGameId isEqualToString:@"53"])
                            {
                                [self.lotteryCatArray addObject:dto];
                                DLog(@"the count == %@", self.lotteryCatArray);
                            }
                            
                            if ([rowGameId isEqualToString:@"01"] || [rowGameId isEqualToString:@"50"]
                                || [rowGameId isEqualToString:@"51"] || [rowGameId isEqualToString:@"52"]
                                || [rowGameId isEqualToString:@"53"] || [rowGameId isEqualToString:@"03"]
                                || [rowGameId isEqualToString:@"07"]
                                )
                            {
                                [self.lotteryAllArray addObject:dto];
                            }
                            
                            TT_RELEASE_SAFELY(dto);
                        }
                    }
                }
            }
        }
        
        
        [self sortLotteryList];
        
        Foreground_Begin
        if (_delegate && [_delegate respondsToSelector:@selector(lotteryHallRequestCompletedWithResult:
                                                                 andLotreryAllList:
                                                                 isSuccess:
                                                                 errorCode:)]) {
            [_delegate lotteryHallRequestCompletedWithResult:_lotteryCatArray andLotreryAllList:_lotteryAllArray isSuccess:YES errorCode:desc];
        }
        Foreground_End
        
        Background_End
    }
}


- (void)sortLotteryList{
    
    //重新排列彩票大厅双色球和大乐透的位置
    if ([self.lotteryCatArray count] > 1) {
        
        LotteryHallDto *dto = [self.lotteryCatArray objectAtIndex:0];
        
        
        if ([dto.gid isEqualToString:@"50"]) {
            
            [self.lotteryCatArray removeObjectAtIndex:0];
            
            [self.lotteryCatArray addObject:dto];
        }
        
    }
    
    //重新排列彩票公告,顺序是：01双色球 -> 50大乐透 -> 03福彩3d -> 51七星彩 -> 53排列三 -> 52排列五 -> 07七乐彩
    NSMutableDictionary *sortDic = [[NSMutableDictionary alloc]init ];
    
    for (int i = 0;i < [self.lotteryAllArray count]; i++) {
        
        LotteryHallDto *dto = [self.lotteryAllArray objectAtIndex:i];
        
        if ([dto.gid isEqualToString:@"01"]) {
            
            [sortDic setObject:dto forKey:@"0"];
            
        }else if([dto.gid isEqualToString:@"50"]){
            
            [sortDic setObject:dto forKey:@"1"];
            
        }else if([dto.gid isEqualToString:@"03"]){
            
            [sortDic setObject:dto forKey:@"2"];
            
        }else if([dto.gid isEqualToString:@"51"]){
            
            [sortDic setObject:dto forKey:@"3"];
            
        }else if([dto.gid isEqualToString:@"53"]){
            
            [sortDic setObject:dto forKey:@"4"];
            
        }else if([dto.gid isEqualToString:@"52"]){
            
            [sortDic setObject:dto forKey:@"5"];
            
        }else{
            
            [sortDic setObject:dto forKey:@"6"];
            
        }
    }
    
    int count = [self.lotteryAllArray count];
    
    [self.lotteryAllArray removeAllObjects];
    
    for (int j = 0; j < count; j++) {
        
        NSString *key = [NSString stringWithFormat:@"%d",j];
        
        LotteryHallDto *dto = [sortDic objectForKey:key];
        
        if (dto) {
            
            [self.lotteryAllArray addObject:dto];
        }
    }
    
    [Config currentConfig].lotteryCatArray = self.lotteryCatArray;
    [Config currentConfig].allLotteryArray = self.lotteryAllArray;
    
}



@end
