//
//  DWTagList.m
//  SuningEBuy
//
//  Created by 王家兴 on 13-5-22.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonView.h"

@protocol DWTagListDelegate <NSObject>

@required

- (void)selectedTag:(NSString*)tagName;

- (void)switchHotKeywords;

@end

@interface DWTagList : CommonView
{
    NSMutableArray *colorArray_;
    
    NSMutableArray *fontArray_;
    
    UIView *view;
    NSArray *textArray;
    CGSize sizeFit;
    UIColor *lblBackgroundColor;
    UIColor *highlightedBackgroundColor;
}
@property (nonatomic, strong) NSMutableArray *colorArray;
@property (nonatomic, strong) NSMutableArray *fontArray;

@property (nonatomic) BOOL viewOnly;
@property (nonatomic, strong) UIView *view;

@property (nonatomic, strong) NSArray *textArray;
@property (nonatomic, strong) NSArray *hotwordDtoList;

@property (nonatomic, weak) id<DWTagListDelegate> tagDelegate;
@property (nonatomic) BOOL automaticResize;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, assign) CGFloat labelMargin;
@property (nonatomic, assign) CGFloat bottomMargin;
@property (nonatomic, assign) CGFloat horizontalPadding;
@property (nonatomic, assign) CGFloat verticalPadding;
@property (nonatomic, assign) CGFloat minimumWidth;

@property (nonatomic, strong) UIView *switchHotKeyButtonView;//add by wangjiaxing 20130520

- (void)setTagBackgroundColor:(UIColor *)color;
- (void)setTagHighlightColor:(UIColor *)color;
- (void)setTags:(NSArray *)array;
- (void)display;
- (CGSize)fittedSize;
- (void)initArrays;
- (void)displayWithAnimation:(BOOL)animation;
@end

@interface DWTagView : UIView

@property (nonatomic, strong) UIButton      *button;
@property (nonatomic, strong) UILabel       *label;

- (void)updateWithString:(NSString*)text font:(UIFont*)font constrainedToWidth:(CGFloat)maxWidth padding:(CGSize)padding minimumWidth:(CGFloat)minimumWidth color:(UIColor *)color;
- (void)setLabelText:(NSString*)text;

@end
