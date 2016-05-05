//
//  EGOPlaceholder.m
//  SuningEBuy
//
//  Created by liukun on 14-5-5.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "EGOPlaceholder.h"
#import <SDWebImage/SDImageCache.h>

@implementation EGOPlaceholder

+ (UIImage *)adjustPlaceholderImage:(UIImage *)image size:(CGSize)aSize
{
    if (!image) {
        return nil;
    }
    
    //更换了placeholder图片之后，要改下key
    NSString *key = [[NSString stringWithFormat:@"EGOPlaceholder-238-%@", NSStringFromCGSize(aSize)] stringByReplacingOccurrencesOfString:@" " withString:@""];
    UIImage *cachedImg = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:key];
    if (cachedImg)
    {
        return cachedImg;
    }
    
    CGFloat maxWidth = image.size.width*2;
    
    CGFloat width = aSize.width*2;
    CGFloat height = aSize.height*2;
    
    CGSize size = CGSizeMake(width, height);
    UIGraphicsBeginImageContext(size);
    
    CGRect imageRect = CGRectZero;
    if (width > height) {
        CGFloat s = MIN(maxWidth, height);
        imageRect = CGRectMake((width-s)/2, (height-s)/2, s, s);
    }else{
        CGFloat s = MIN(maxWidth, width);
        imageRect = CGRectMake((width-s)/2, (height-s)/2, s, s);
    }
    
    //设置背景色，透明时注释掉
    //    CGRect bounds = CGRectMake(0, 0, width, height);
    //	CGContextRef context = UIGraphicsGetCurrentContext();
    //	CGContextSetFillColorWithColor(context, RGBCOLOR(250, 246, 237).CGColor);
    //	CGContextFillRect(context, bounds);
    
    [image drawInRect:imageRect blendMode:kCGBlendModeNormal alpha:1.0];
	
	UIImage *testImg =  UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
    
    if (testImg) {
        [[SDImageCache sharedImageCache] storeImage:testImg forKey:key];
    }
	
	return testImg;
}

@end
