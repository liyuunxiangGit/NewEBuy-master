//
//  CommonLabel.h
//  SNFramework
//
//  Created by  liukun on 13-12-27.
//  Copyright (c) 2013年 liukun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SNUILabel : UILabel



//工厂方法


//橙色系字符颜色有2种,分别为: 橙红色#ff4800(所有价格颜色);
//橘色#fc7c26(促销文字、运费、重要信息备注);
//字号大小主要有30pt,24pt

//橙红色#ff4800 //字号大小主要有30pt
+ (instancetype)PriceLab;


//橘色#fc7c26  大小 24pt
+ (instancetype)importantLab;




//黑色系字体色值有4种,
//分别是: 黑色#31313131(如商品名称),  42
//深灰色#707070(如数量、打分),  24
//浅灰色#cbcaca(如输入框提示)

//分别是: 黑色#31313131(如商品名称),  42
+ (instancetype)cellMainLab;

//深灰色#707070(如数量、打分),  24
+ (instancetype)cellDetailLab;


//col font
-(id)initWithColor:(UIColor *)color font:(UIFont *)font;
@end
