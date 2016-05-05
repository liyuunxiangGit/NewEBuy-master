//
//  StarIcon.h
//  starChooseBar
//
//  Created by cjw on 14/11/6.
//  Copyright (c) 2014年 Test. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol StarIconDelegate;

@interface StarIcon : UIImageView

@property (nonatomic, assign) id <StarIconDelegate> delegate;

//初始化
- (id)initWithFrame:(CGRect)rect;

//设置imageView的默认图片、高亮图片以及点击手势
- (void)setImageView;

@end

@protocol StarIconDelegate <NSObject>

//imageView的点击事件，在代理中声明，使用的时候实现
- (void)handleSingleTap:(UITapGestureRecognizer *)sender;

@end