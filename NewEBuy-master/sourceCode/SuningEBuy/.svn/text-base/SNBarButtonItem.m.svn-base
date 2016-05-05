//
//  SNBarButtonItem.m
//  SuningEBuy
//
//  Created by  liukun on 13-12-24.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "SNBarButtonItem.h"

@implementation SNBarButtonItem

- (id)initWithSNStyle:(SNBarItemStyle)style title:(NSString *)title target:(id)target selector:(SEL)selector
{
    CGSize size = [title sizeWithFont:[UIFont boldSystemFontOfSize:15.0]];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor clearColor];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 2.5, 0, 0)];
    [btn setTitleColor:[UIColor orange_Light_Color] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orange_Red_Color] forState:UIControlStateHighlighted];
    [btn setTitleColor:[UIColor light_Gray_Color] forState:UIControlStateDisabled];
    if (style == SNBarItemStyleLight)
    {
//       // [btn setBackgroundImage:[UIImage streImageNamed:@"right_item_light_btn.png"]
//                       forState:UIControlStateNormal];
    }
    else if (style == SNBarItemStyleDone)
    {
//       // [btn setBackgroundImage:[UIImage streImageNamed:@"right_item_btn.png"]
//                       forState:UIControlStateNormal];
    }
    [btn setTitle:title forState:UIControlStateNormal];
    //    [btn addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 6, size.width + 20, 32);
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return [super initWithCustomView:btn];
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    
    UIButton *btn = (UIButton *)[self customView];
    if ([btn isKindOfClass:[UIButton class]])
    {
        btn.enabled = enabled;
    }
}

@end
