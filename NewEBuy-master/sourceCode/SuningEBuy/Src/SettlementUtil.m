//
//  SettlementUtil.m
//  SuningEBuy
//
//  Created by huangtf on 12-9-12.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "SettlementUtil.h"

@implementation SettlementUtil

#pragma mark -
#pragma mark 金额类型转换
+ (CGFloat)convertStringMoneyToFloat:(NSString *)moneyValue
{
    CGFloat floatMoney = 0.0f;
    
    if ([[moneyValue substringToIndex:1] isEqualToString:@"￥"])
    {
        moneyValue = [moneyValue substringFromIndex:1]; // 删除价格前面的人民币符号        
    }
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    
    numberFormatter.numberStyle = kCFNumberFormatterDecimalStyle;
    
    floatMoney = [[numberFormatter numberFromString:moneyValue] floatValue];
    
    TT_RELEASE_SAFELY(numberFormatter);
    
    return floatMoney;
    
}

+ (NSString *)convertFloatMoneyToString:(CGFloat)moneyValue
{
    NSString *stringMoney = nil;
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    
    numberFormatter.numberStyle = kCFNumberFormatterDecimalStyle;
    
    stringMoney = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:moneyValue]];
    
    TT_RELEASE_SAFELY(numberFormatter);
    
    if (![stringMoney hasPrefix:@"￥"]) 
    {
        stringMoney = [NSString stringWithFormat:@"￥%@",stringMoney];   
    }
    
    NSRange dotRange = [stringMoney rangeOfString:@"."];
    
    int location = dotRange.location;
    
    if (location == NSNotFound) 
    {
        stringMoney = [stringMoney stringByAppendingString:@".00"];
    }
    
    return stringMoney;
}


#pragma mark -
#pragma mark 构造应付金额
/*
 应付金额 ＝ 实际价格 － 优惠 ＋ 运费
 favMoney 优惠价格
 feiMoney 运费
 */
+ (NSString *)generatePaytableMoney:(CGFloat)productPrice favorable:(CGFloat)favMoney feight:(CGFloat)feiMoney
{
    
    NSString *paytableMoneyInfo = nil;
    
    NSString *productPriceString = nil;     // 原始金额
    
    NSString *favorableMoneyString = nil;   // 优惠
    
    NSString *feightMoneyString = nil;      // 运费
    
    productPriceString = [SettlementUtil convertFloatMoneyToString:productPrice];
    
    favorableMoneyString = [SettlementUtil convertFloatMoneyToString:favMoney];
    
    feightMoneyString = [SettlementUtil convertFloatMoneyToString:feiMoney];
    
    paytableMoneyInfo = [NSString stringWithFormat:L(@"LOIssue8"),productPriceString,favorableMoneyString,feightMoneyString];
    
    return paytableMoneyInfo;
    
}

#pragma mark -
#pragma mark 显示/隐藏TabBar
+ (void)hideTabBar:(UITabBarController *)tabBarController
{
    
    for(UIView *view in tabBarController.view.subviews)
    {
        if([view isKindOfClass:[UITabBar class]])
        {
            [view setFrame:CGRectMake(view.frame.origin.x, 480, view.frame.size.width, view.frame.size.height)];
        } 
        else 
        {
            [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, 480)];
        }
        
    }
    
}

+ (void)showTabBar:(UITabBarController *)tabBarController
{
    
    for(UIView *view in tabBarController.view.subviews)
    {
        if([view isKindOfClass:[UITabBar class]])
        {
            [view setFrame:CGRectMake(view.frame.origin.x, 431, view.frame.size.width, view.frame.size.height)];
        } 
        else 
        {
            [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, 431)];
        }
        
    }
    
}


@end
