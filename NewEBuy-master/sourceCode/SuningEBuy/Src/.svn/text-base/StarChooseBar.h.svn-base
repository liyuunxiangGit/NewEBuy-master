//
//  starChooseBar.h
//  starChooseBar
//
//  Created by cjw on 14/10/28.
//  Copyright (c) 2014年 Test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarIcon.h"

@interface StarChooseBar : UIView <StarIconDelegate>
{
    int size;//每个星星的大小，由于星星设为正方形，故size即为星星的长或宽
    int interval;//相邻星星之间的间距
    float starNumber;//默认点亮的星星的个数(不是星星的总个数。。。)
}

//五颗星星
@property (nonatomic, retain) StarIcon *firstStarIcon;

@property (nonatomic, retain) StarIcon *secondStarIcon;

@property (nonatomic, retain) StarIcon *thirdStarIcon;

@property (nonatomic, retain) StarIcon *fourthStarIcon;

@property (nonatomic, retain) StarIcon *fifthStarIcon;

//整个控件的初始化设置，包括:每个星星大小、相邻星星的间距、默认点亮的星星的个数以及控件是否能点击
- (void)setStarBarWithSize:(int) sizeInput
                  Interval:(int) intervalInput
                    Number:(float) numberInput
             isInteraction:(BOOL) isInteractionInput;

- (void)showStarBar:(float)numberInput;

@end
