//
//  NBYUtils.m
//  SuningEBuy
//
//  Created by suning on 14-9-26.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "NBYUtils.h"

@implementation NBYUtils

+ (NSString *)dateFormartString:(NSString *)formartString {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [formatter dateFromString:formartString];
    
    // 秒数
    NSTimeInterval timeInteraval = [[NSDate date] timeIntervalSinceDate:date];
    unsigned long long interval = (unsigned long long)timeInteraval;
    if (interval < 60) {
        return L(@"JustTime");
    }else {
        // 分数
        unsigned long long seconds   = interval/60;
        
        if (seconds < 60) {// 5分钟前
            return [NSString stringWithFormat:@"%d%@",(int)seconds,L(@"MilutesAgo")];
        }else {
            unsigned long long hours     = seconds/60;
            if (hours < 24) { // 2
                return [NSString stringWithFormat:@"%d%@",(int)hours,L(@"HoursAgo")];
            }else {
                int days = (int)(hours/24);
                return [NSString stringWithFormat:@"%d%@",days,L(@"DaysAgo")];
            }
        }
    }
}

+ (CGSize)sizeForString:(NSString *)string
              limitSize:(CGSize)sz
                   font:(UIFont *)ft
          lineBreakMode:(NSLineBreakMode)lineBreakMode
              alignment:(NSTextAlignment)alignment {
    
    CGSize  boundSize = CGSizeMake(sz.width, sz.height);
    CGSize  size      = CGSizeZero; // 要返回得 文本尺寸
    
    if ([NSString instancesRespondToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.lineBreakMode = lineBreakMode;
        style.lineSpacing   = 0;
        style.alignment     = alignment;
        
        NSDictionary *attribute = @{NSFontAttributeName:ft,
                                    NSParagraphStyleAttributeName:style};
        CGRect rect = [string boundingRectWithSize:boundSize
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:attribute
                                           context:nil];
        size = CGSizeMake(ceil(rect.size.width), ceil(rect.size.height));
    }else {
        size = [string sizeWithFont:ft
                  constrainedToSize:boundSize
                      lineBreakMode:lineBreakMode];
    }
    
    size = CGSizeMake(MIN(sz.width,size.width),
                      size.height);
    return size;
}

+ (NSString *)convertDistance:(CGFloat)distance {
    
    if (distance < 100.0f) {
        return [NSString stringWithFormat:@"%.1fm",distance];
    }else {
        return [NSString stringWithFormat:@"%.1fkm",distance/1000.0f];
    }
}

@end
