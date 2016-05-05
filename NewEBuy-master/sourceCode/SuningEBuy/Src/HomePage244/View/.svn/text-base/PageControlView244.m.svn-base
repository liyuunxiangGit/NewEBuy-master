//
//  PageControlView244.m
//  SuningEBuy
//
//  Created by zhangbeibei on 14-9-16.
//  Copyright (c) 2014年 Suning. All rights reserved.
//


#define KImageSpaceWidth  5

#import "PageControlView244.h"

@implementation PageControlView244

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        totalCount = 0;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)updateViewWithCount:(int )count normalImageName:(NSString *)normalName hilightedImageName:(NSString *)hilightedName {
    //最小支持2张图片轮换
    if (count < 2) {
        return;
    }
    //移除旧的视图
    NSArray *viewArray = [self subviews];
    [viewArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    //设置新的UI元素
    totalCount = count;
    normalImage = [UIImage imageNamed:normalName ? normalName : @"home_page_control_white.png"];
    
    hilightedImage = [UIImage imageNamed:hilightedName ? normalName : @"home_page_control_orange.png"];
    
    for (int i = 0; i < count; i++) {
        float imageWidth = (self.frame.size.width - (count -1)* KImageSpaceWidth) / count;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((imageWidth + KImageSpaceWidth) * i, 0, imageWidth, self.frame.size.height)];
        imageView.tag = 10000+i;
        if (i == 0) {
            imageView.image = hilightedImage;
            currentSelectedIndex = 0;
        }
        else {
            imageView.image = normalImage;
        }

        [self addSubview:imageView];
        
    }
    
    
}

- (void)setSelectedImageIndex:(int )index {
    
    UIImageView *oldIamgeView = (UIImageView *)[self viewWithTag:10000+currentSelectedIndex];
    UIImageView *newImageView = (UIImageView *)[self viewWithTag:10000+index];
    if (oldIamgeView) {
        oldIamgeView.image = normalImage;
    }

    if (newImageView) {
        newImageView.image = hilightedImage;
    }

    currentSelectedIndex = index;
}

@end
