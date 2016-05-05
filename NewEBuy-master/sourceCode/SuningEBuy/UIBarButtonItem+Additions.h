//
//  UIBarButtonItem+Additions.h
//  SuningEBuy
//
//  Created by  zhang jian on 13-7-16.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Additions)

+ (UIBarButtonItem *)initWithImage:(NSString *)imageName;// wihtSel:(SEL)sel;

+ (UIBarButtonItem *)initWithImage:(NSString *)imageName withName:(NSString *)name;// wihtSel:(SEL)sel;

+ (UIBarButtonItem *)initWithImage:(NSString *)imageName
                          withName:(NSString *)name
                         customSet:(void(^)(UIButton *btn))setBlock;

+ (UIBarButtonItem *)itemWithImage:(NSString *)imageName
                          withName:(NSString *)name
                            target:(id)target
                            action:(SEL)action;

@end
