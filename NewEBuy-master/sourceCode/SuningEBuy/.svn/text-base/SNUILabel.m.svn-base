//
//  CommonLabel.m
//  SNFramework
//
//  Created by  liukun on 13-12-27.
//  Copyright (c) 2013年 liukun. All rights reserved.
//

#import "SNUILabel.h"

@implementation SNUILabel

- (void)setUp
{
    self.backgroundColor = [UIColor clearColor];
    self.textAlignment = UITextAlignmentLeft;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setUp];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}

//color font
-(id)initWithColor:(UIColor *)color font:(UIFont *)font{
    
    self = [super init];
    if (self) {
        [self setUp];
        
        self.textColor = color;
        self.font = font;
    }
    return self;
}

//橙红色#ff4800 //字号大小主要有30pt
+ (instancetype)PriceLab{
    
    SNUILabel *lab = [[SNUILabel alloc] initWithColor:[UIColor orange_Red_Color]
                                                 font:[UIFont systemFontOfSize:15]];
    
    return lab;
}


//橘色#fc7c26  大小 24pt
+ (instancetype)importantLab{
    
    SNUILabel *lab = [[SNUILabel alloc] initWithColor:[UIColor orange_Light_Color]
                                                 font:[UIFont systemFontOfSize:12]];
    
    return lab;
}



//分别是: 黑色#31313131(如商品名称),  42
+ (instancetype)cellMainLab{
    
    SNUILabel *lab = [[SNUILabel alloc] initWithColor:[UIColor light_Black_Color]
                                                 font:[UIFont systemFontOfSize:21]];
    
    return lab;
}

//深灰色#707070(如数量、打分),  24
+ (instancetype)cellDetailLab{
    
    SNUILabel *lab = [[SNUILabel alloc] initWithColor:[UIColor dark_Gray_Color]
                                                 font:[UIFont systemFontOfSize:12]];
    
    return lab;
}

@end
