//
//  UIBarButtonItem+Additions.m
//  SuningEBuy
//
//  Created by  zhang jian on 13-7-16.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "UIBarButtonItem+Additions.h"

@implementation UIBarButtonItem (Additions)

+ (UIBarButtonItem *)initWithImage:(NSString *)imageName //wihtSel:(SEL)sel
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor clearColor];
    [btn setImage:[UIImage streImageNamed:imageName] forState:UIControlStateNormal];
//    [btn addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0, 44, 44);
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return item;
}

+ (UIBarButtonItem *)initWithImage:(NSString *)imageName withName:(NSString *)name //wihtSel:(SEL)sel
{
    CGSize size = [name sizeWithFont:[UIFont boldSystemFontOfSize:15.0]];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor clearColor];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 2.5, 0, 0)];
    [btn setTitleColor:[UIColor colorWithRGBHex:0x825201] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage streImageNamed:imageName] forState:UIControlStateNormal];
    [btn setTitle:name forState:UIControlStateNormal];
//    [btn addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 6, size.width + 20, 32);
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return item;    
}

+ (UIBarButtonItem *)initWithImage:(NSString *)imageName
                          withName:(NSString *)name
                         customSet:(void(^)(UIButton *btn))setBlock
{
    CGSize size = [name sizeWithFont:[UIFont boldSystemFontOfSize:15.0]];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor clearColor];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 2.5, 0, 0)];
    [btn setTitleColor:[UIColor colorWithRGBHex:0x825201] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage streImageNamed:imageName] forState:UIControlStateNormal];
    [btn setTitle:name forState:UIControlStateNormal];
    //    [btn addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 6, size.width + 20, 32);
    if (setBlock) {
        setBlock(btn);
    }
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return item;
}

+ (UIBarButtonItem *)itemWithImage:(NSString *)imageName withName:(NSString *)name target:(id)target action:(SEL)action
{
    CGSize size = [name sizeWithFont:[UIFont boldSystemFontOfSize:15.0]];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor clearColor];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 2.5, 0, 0)];
    [btn setTitleColor:[UIColor colorWithRGBHex:0x825201] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage streImageNamed:imageName] forState:UIControlStateNormal];
    [btn setTitle:name forState:UIControlStateNormal];
    //    [btn addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 6, size.width + 20, 32);
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return item;
}

@end
