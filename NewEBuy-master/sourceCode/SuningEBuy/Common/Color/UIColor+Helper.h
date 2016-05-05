//
//  UIColor+Helper.h
//  SuningEBuy
//
//  Created by song jun on 11/6/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIColor (UIColor_Helper)

+ (UIColor *)uiviewBackGroundColor;

+ (UIColor *)navTintColor;

+ (UIColor *)skyBlueColor;

+ (UIColor *)darkRedColor;

+ (UIColor *)darkBlueColor;

+ (UIColor *)darkGrownColor;

+ (UIColor *)flatTextColor;

+ (UIColor *)darkTextColor;

+ (UIColor *)lightTextColor;

+ (UIColor *)cellBackViewColor;


/*
 黑色 导航 商品名称  #313131
 */
+ (UIColor *)light_Black_Color;

/*
 橙红色 所有价格   #ff4800
 */
+ (UIColor *)orange_Red_Color;

/*
 橘色 促销文字、运费、重要信息备注、文字选中状态的颜色 #fc7c26
 */
+ (UIColor *)orange_Light_Color;

/*
 s深灰色   #707070
 */
+ (UIColor *)dark_Gray_Color;

/*
 浅灰色   #cbcaca
 */
+ (UIColor *)light_Gray_Color;

/*
 #ffffff
 */
+ (UIColor *)light_White_Color;

//button highlight状态下的字体颜色
+ (UIColor *)btnTitleHotColor;

+ (UIColor *)btnTitleNormalColor;
/*
 #f7f7f8
 */
+ (UIColor *)cell_Back_Color;

/*
 #f2f2f2
 */
+ (UIColor *)view_Back_Color;

@end
