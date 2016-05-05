//
//  LotteryDataModel.m
//  SuningEBuy
//
//  Created by shasha on 12-6-28.
//  Copyright (c) 2012年 warmshare_shasha@sina.com. All rights reserved.
//

#import "LotteryDataModel.h"

@implementation LotteryDataModel


void swap (int *pm, int *pn)
{
    int temp;
    temp = *pm;
    *pm = *pn;
    *pn = temp;
}


+ (void)sortFromLowToHigh:(NSMutableArray *)sourceArr{
    
    if (!sourceArr || (sourceArr.count == 0)) {
        
        return;
    }
    
    
    @autoreleasepool {
        
        NSMutableArray *resultList = [[NSMutableArray alloc] init];
        
        for (NSInteger index = 0;index < [sourceArr count];index ++ ) {
            
            NSNumber *value = [sourceArr objectAtIndex:index];
            
            if ([resultList count] == 0) {
                
                [resultList addObject:value];
                
            }else{
                
                int i = 0;
                
                for (NSNumber *otherValue in resultList) {
                    
                    NSComparisonResult compareResult = [value compare:otherValue];
                    
                    //gxt modfy
                    if(compareResult == NSOrderedDescending)
                    {
                        i++;
                        continue;
                    }
                    
                    break;
                }
                
                [resultList insertObject:value atIndex:i];
                
            }
        }
        
        [sourceArr removeAllObjects];
        
        [sourceArr addObjectsFromArray:resultList];
    }
    
}

//gxt add

+(void)sortFromHighToLow:(NSMutableArray *)sourceArr
{
    if (!sourceArr || (sourceArr.count == 0)) {
        
        return;
    }
    
    
    @autoreleasepool {
        
        NSMutableArray *resultList = [[NSMutableArray alloc] init];
        
        for (NSInteger index = 0;index < [sourceArr count];index ++ ) {
            
            NSNumber *value = [sourceArr objectAtIndex:index];
            
            if ([resultList count] == 0) {
                
                [resultList addObject:value];
                
            }else{
                
                int i = 0;
                
                for (NSNumber *otherValue in resultList) {
                    
                    NSComparisonResult compareResult = [value compare:otherValue];
                    
                    if(compareResult == NSOrderedAscending)
                    {
                        i++;
                        continue;
                    }
                    
                    break;
                }
                
                [resultList insertObject:value atIndex:i];
            }
        }
        
        [sourceArr removeAllObjects];
        
        [sourceArr addObjectsFromArray:resultList];
    }
}


+ (void)deleteFromArray:(NSMutableArray *)sourceArr deletedElement:(NSInteger)element{
    
    if (!sourceArr || (sourceArr.count == 0)) {
        
        return;
        
    }else{
        
        for (NSNumber *value in sourceArr) {
            
            if (element == [value intValue]) {
                
                [sourceArr removeObject:value];
                
                return;
            }
            
        }
        
    }
    
}

+ (void)getRandomArray:(NSMutableArray *)sourceArr randomNumCount:(NSInteger)count maxCount:(NSInteger)maxCount{
    
    if ([sourceArr count] > 0) {
        
        [sourceArr removeAllObjects];
        
    }
    
    int random[maxCount];
    
    for (int i = 0; i < maxCount; i++) {
        
        random[i] = i;
        
    }
    
    for (int i = maxCount-1; i >= 0; i--) {
        
        swap(&random[i], &random[arc4random()%maxCount]);
        
    }
    
    for (int i = 0; i < count; i++) {
        
        [sourceArr addObject:[NSNumber numberWithInt:random[i]]];
        
    }
    
}

+ (NSString *)lotteryNameWithType:(LotteryType)type
{
    switch (type) {
        case ArrangeThree:  //排列三
            return L(@"Arrange in Three");
            break;
        case ArrangeFive:   //排列五
            return L(@"Arrange in Five");
            break;
        case eBigLottery:   //大乐透
            return L(@"BigLotto");
            break;
        case eColorBall:    //双色球
            return L(@"DoubleColor ball");
            break;
        case sevenLe:       //七乐彩
            return L(@"Seven Le Lottery");
            break;
        case sevenStars:    //七星彩
            return L(@"SevenStars");
            break;
        case welfare3D:     //福彩3D
            return L(@"Welfare 3D");
            break;
        default:
            return nil;
            break;
    }
}

+ (NSString *)lotterygidWithType:(LotteryType)type
{
    switch (type) {
        case ArrangeThree:  //排列三
            return @"53";
            break;
        case ArrangeFive:   //排列五
            return @"52";
            break;
        case eBigLottery:   //大乐透
            return @"50";
            break;
        case eColorBall:    //双色球
            return @"01";
            break;
        case sevenLe:       //七乐彩
            return @"07";
            break;
        case sevenStars:    //七星彩
            return @"51";
            break;
        case welfare3D:     //福彩3D
            return @"03";
            break;
        default:
            return nil;
            break;
    }
}

//根据彩票gid获取彩票类型
+ (LotteryType)lotterTypeWithgid:(NSString *)gid
{
    if([gid isEqualToString:@"53"])
    {
        return ArrangeThree;
    }else if([gid isEqualToString:@"52"])
    {
        return ArrangeFive;
    }else if([gid isEqualToString:@"50"])
    {
        return eBigLottery;
    }else if([gid isEqualToString:@"01"])
    {
        return eColorBall;
    }else if([gid isEqualToString:@"07"])
    {
        return sevenLe;
    }else if([gid isEqualToString:@"51"])
    {
        return sevenStars;
    }else if([gid isEqualToString:@"03"])
    {
        return welfare3D;
    }else{
        return UnknownLottery;
    }
}
@end
