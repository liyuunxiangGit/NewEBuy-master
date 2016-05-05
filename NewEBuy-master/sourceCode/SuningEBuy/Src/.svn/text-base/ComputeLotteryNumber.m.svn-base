//
//  ComputeLotteryNumber.m
//  SuningEBuy
//
//  Created by david david on 12-6-29.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import "ComputeLotteryNumber.h"
#import "BallSelectConstant.h"

@implementation ComputeLotteryNumber


/*
 *  功能：根据彩票号码算出双色球购买注数
 *
 *  参数lottery形如 "01 02 12 14 23 11 | 12"
 */

+(CGFloat)computeLotterySSQNumber:(NSString *)lottery{
    
    CGFloat allArrangement = 0;
    
    CGFloat redArrangement = 0;
    
    CGFloat blueArrangement = 0;
    
    NSArray *arr = [lottery componentsSeparatedByString:@"|"];
    
    if (arr) {
        
        NSString *redString = [arr objectAtIndex:0];
        
        NSArray *redArr = [redString componentsSeparatedByString:@" "];
        
        if ([redArr count] > 0) {
            
            int count = [redArr count] - 1;    //红球的数量
            
            redArrangement= [ComputeLotteryNumber arrangement:count andSmallNo:6];
            
        }
        
        NSString *blueString = [arr objectAtIndex:1];
        
        NSArray *blueArr = [blueString componentsSeparatedByString:@" "];
        
        if ([blueArr count] > 0) {
            
            blueArrangement = [blueArr count]-1;
            
        }else{
            
            blueArrangement = 1;
        }
        
    }
    
    allArrangement = blueArrangement*redArrangement;
    
    return allArrangement;
}

/*
 *  功能：根据彩票号码算出七乐彩购买注数
 *
 *  参数lottery形如 "01 02 03 04 05 06 07"
 */

+(CGFloat)computeSevenLeNumber:(NSString *)lottery
{
    
    CGFloat allArrangement = 0;
    
    NSArray *Arr = [lottery componentsSeparatedByString:@" "];
    
    DLog("the Arr === %@",Arr);
    int count = [Arr count]-1;
    
    if (count > 0) {
        
        if (count == 7)
        {
            allArrangement = 1;
        }
        
        else if(count >7)
        {
            //球的数量
            
            int ArrangeNumber = 1;
            
            int  spareNubmer = 1;
            
            for (int i= (count-7); i>0; i--)
            {
                spareNubmer = i*spareNubmer;//所选多于7个球的排列种类
                //所选所有的球的排列种类
                ArrangeNumber = (count-i+1)*ArrangeNumber;
                
                
            }
            
            allArrangement= ArrangeNumber/spareNubmer ;//所选所有球的组合数即投注注数
            
            
        }
        
        else
        {
            allArrangement = 0;
            
        }
        
        
        
        
        
    }
    return allArrangement;
    
    
    
}

+(CGFloat)computeLotterySevenLeNumber:(NSInteger)count
{
    
    CGFloat allArrangement = 0;
    if (count > 0)
    {
        
        if (count == 7)
        {
            allArrangement = 1;
        }
        else if(count >7)
        {
            //球的数量
            
            int ArrangeNumber = 1;
            
            int  spareNubmer = 1;
            
            for (int i= (count-7); i>0; i--)
            {
                spareNubmer = i*spareNubmer;//所选多于7个球的排列种类
                //所选所有的球的排列种类
                ArrangeNumber = (count-i+1)*ArrangeNumber;
                
                
            }
            
            allArrangement= ArrangeNumber/spareNubmer ;//所选所有球的组合数即投注注数
            
            
        }
        else
        {
            allArrangement = 0;
            
        }
        
        
        
        
    }
    return allArrangement;
    
}



/*
 *  功能：根据彩票号码算出大乐透购买注数
 *
 *  参数lottery形如 "02 12 14 23 11 | 12 13"
 */

+(CGFloat)computeLotteryDLTNumber:(NSString *)lottery{
    
    CGFloat allArrangement = 0;
    
    CGFloat redArrangement = 0;
    
    CGFloat blueArrangement = 0;
    
    NSArray *arr = [lottery componentsSeparatedByString:@"|"];
    
    if (arr) {
        
        NSString *redString = [arr objectAtIndex:0];
        
        NSArray *redArr = [redString componentsSeparatedByString:@" "];
        
        if ([redArr count] > 0) {
            
            int count = [redArr count] - 1;    //红球的数量
            
            redArrangement= [ComputeLotteryNumber arrangement:count andSmallNo:5];
            
        }
        
        NSString *blueString = [arr objectAtIndex:1];
        
        NSArray *blueArr = [blueString componentsSeparatedByString:@" "];
        
        if ([blueArr count] > 2) {
            
            int count = [blueArr count]-1;      //蓝球的数量
            
            blueArrangement = [ComputeLotteryNumber arrangement:count andSmallNo:2];
            
        }else{
            
            blueArrangement = 0;
        }
        
    }
    
    allArrangement = blueArrangement*redArrangement;
    
    return allArrangement;
}


/*
 *  功能：算红球或者篮球的排列
 *
 *  从bigNo中选出smallNo的排列
 */

+(CGFloat)arrangement:(int)bigNo andSmallNo:(int)smallNo{
    
    CGFloat totalNo = 1;
    
    if (bigNo < smallNo) {
        
        return 0;
    }
    
    if (bigNo == smallNo) {
        
        return 1;
    }
    
    double denominator = 1;
    
    double numberrator = 1;
    
    for (int i = bigNo-smallNo+1; i<= bigNo; i++ ) {
        
        denominator = denominator*i;
    }
    
    for (int i = 1; i<= smallNo; i++ ) {
        
        numberrator = numberrator*i;
    }
    
    totalNo = denominator/numberrator;
    
    return totalNo;
    
}



/*
 *  功能：根据彩票号码算出购买注数
 *
 *  参数lottery形如 直选 "2 2|3 3|4 5" 其他"1 3 5"
 */

+(CGFloat)computeLotteryFC3DNumber:(NSString *)lottery ballType:(int)ballType{
    
    CGFloat allArrangement = 0;
    
    CGFloat bitsCount = 0;
    CGFloat tenCount  = 0;
    CGFloat hundCount = 0;
    switch (ballType) {
        case zhiXuan:
        {
            //          直选  分别从个十百中取值全排列
            NSArray *arr = [lottery componentsSeparatedByString:@"|"];
            if ([arr count] < 3) {
                return 0;
            }
            if (arr) {
                
                NSString *bitsString = [arr objectAtIndex:0];
                NSArray *bitsArr = [bitsString componentsSeparatedByString:@" "];
                
                if ([bitsArr count] > 0) {
                    bitsCount = [bitsArr count] - 2;    //个位的数量
                }
                
                NSString *tenString = [arr objectAtIndex:1];
                NSArray *tenArr = [tenString componentsSeparatedByString:@" "];
                
                if ([tenArr count] > 0) {
                    tenCount = [tenArr count] - 2;         //十位的数量
                }
                
                NSString *hundString = [arr objectAtIndex:2];
                NSArray *hundArr = [hundString componentsSeparatedByString:@" "];
                
                if ([hundArr count] > 0) {
                    hundCount = [hundArr count] - 1;       //百位的数量
                }
            }
            allArrangement = bitsCount * tenCount * hundCount;
        }
            break;
        case zhiXuanHeZhi:{
            //          直选和值    个十百位之后等于所选的值
            NSArray *arr = [lottery componentsSeparatedByString:@" "];
            int arrCount = [arr count];//在循环体判断条件中，减少函数调用，增加效率
            for (int i = 0; i < arrCount - 1; i ++) {
                
                int lotteryNum = [[arr objectAtIndex:i + 1] intValue];
                
                for (int j = 0; j < 10; j ++) {
                    for (int m = 0; m < 10; m++) {
                        for (int n = 0; n < 10; n++) {
                            if (j + m + n == lotteryNum) {
                                allArrangement ++;
                            }
                        }
                    }
                }
            }
        }
            break;
        case zuSan:{
            //          组三    去两个值  个十位相同或十百位相同     有大小顺序
            NSArray *arr = [lottery componentsSeparatedByString:@" "];
            
            bitsCount = [arr count] - 1;
            
            allArrangement = (bitsCount - 1) * bitsCount;
            
        }
            break;
        case zuSanHeZhi:{
            //           组三和值   个十百位值之和等于所选数   个十位相同或十百位相同     有大小顺序
            NSArray *arr = [lottery componentsSeparatedByString:@" "];
            int arrCount = [arr count];
            for (int i = 0; i < arrCount - 1; i ++) {
                
                int lotteryNum = [[arr objectAtIndex:i + 1] intValue];
                
                for (int j = 0; j < 10; j ++) {
                    for (int m = j; m < 10; m++) {
                        for (int n = m; n < 10; n++) {
                            if (j + m + n == lotteryNum &&(j == m || m == n) && !(j == m && m == n)) {
                                allArrangement ++;
                            }
                        }
                    }
                }
            }
            
        }
            break;
        case zuLiu:{
            //           组六    个十百位数    全排列    有大小顺序且各个位数的值不同
            NSArray *arr = [lottery componentsSeparatedByString:@" "];
            
            bitsCount = [arr count] - 1;
            
            allArrangement = (bitsCount - 2) * (bitsCount - 1) * bitsCount / 6;
            
        }
            break;
        case zuLiuHeZhi:{
            //           组六    个十百位数之和等于所选的值    有大小顺序且各个位数的值不同
            NSArray *arr = [lottery componentsSeparatedByString:@" "];
            int arrCount = [arr count];
            for (int i = 0; i < arrCount - 1; i ++) {
                
                int lotteryNum = [[arr objectAtIndex:i + 1] intValue];
                
                for (int j = 0; j < 10; j ++) {
                    for (int m = j; m < 10; m++) {
                        for (int n = m; n < 10; n++) {
                            if (j + m + n == lotteryNum && j != m && m != n && j != n) {
                                allArrangement ++;
                            }
                        }
                    }
                }
            }
            
        }
            break;
        default:
            break;
    }
    
    return allArrangement;
}

/*
 *  功能：根据七星彩号码算出购买注数
 *
 *  参数lottery形如 直选 "2 2 | 3 3 | 4 5 | 1 | 1 | 1 | 1" 其他"1 3 5"
 */
+(CGFloat)computeLotterySevenStarsNumber:(NSString *) lottery
{
    CGFloat totalcount = 0;
    
    if ([lottery isEqualToString:@""]||lottery == nil) {
        return totalcount;
    }
    
    NSArray *resultArray = [lottery componentsSeparatedByString:@" | "];
    
    if ([resultArray count] == 7) {
        totalcount = 2;
    }else
    {
        //此时为0
        return totalcount;
    }
    
    //注数
    CGFloat  count = 1;
    //统计注数
    for (NSString *temp in resultArray) {
        //同等级数数字
        NSArray *sameDegreeNumberArray = [temp componentsSeparatedByString:@" "];
        count = count * [sameDegreeNumberArray count];
        //算出费用
        totalcount = count;
    }
    return totalcount;
}

@end
