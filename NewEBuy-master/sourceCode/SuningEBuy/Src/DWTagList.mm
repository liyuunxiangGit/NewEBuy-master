//
//  DWTagList.m
//  SuningEBuy
//
//  Created by 王家兴 on 13-5-22.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "DWTagList.h"
#import <QuartzCore/QuartzCore.h>
#include <vector>

#define CORNER_RADIUS 0.0f
#define LABEL_MARGIN_DEFAULT 10.0f
#define BOTTOM_MARGIN_DEFAULT 10.0f
#define FONT_SIZE_DEFAULT 16.0f
#define HORIZONTAL_PADDING_DEFAULT 7.0f
#define VERTICAL_PADDING_DEFAULT 5.0f
#define BACKGROUND_COLOR [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1.00]
#define TEXT_COLOR [UIColor blackColor]
#define TEXT_SHADOW_COLOR [UIColor whiteColor]
#define TEXT_SHADOW_OFFSET CGSizeMake(0.0f, 1.0f)
#define BORDER_COLOR [UIColor lightGrayColor].CGColor
#define BORDER_WIDTH 0.0f
#define HIGHLIGHTED_BACKGROUND_COLOR [UIColor colorWithRed:0.40 green:0.80 blue:1.00 alpha:0.5]
#define DEFAULT_AUTOMATIC_RESIZE NO

@interface DWTagList()

- (void)touchedTag:(id)sender;

@end

@implementation DWTagList

@synthesize view, textArray, automaticResize;
@synthesize tagDelegate = _tagDelegate;
@synthesize switchHotKeyButtonView=_switchHotKeyButtonView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:view];
        [self setClipsToBounds:YES];
        self.automaticResize = DEFAULT_AUTOMATIC_RESIZE;
        [self setTagHighlightColor:[UIColor clearColor]];
        self.font = [UIFont systemFontOfSize:FONT_SIZE_DEFAULT];
        self.labelMargin = LABEL_MARGIN_DEFAULT;
        self.bottomMargin = BOTTOM_MARGIN_DEFAULT;
        self.horizontalPadding = HORIZONTAL_PADDING_DEFAULT;
        self.verticalPadding = VERTICAL_PADDING_DEFAULT;
        self.owner = self.tagDelegate;
        self.clipsToBounds = NO;
        [self initArrays];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self addSubview:view];
        [self setClipsToBounds:YES];
        [self setTagHighlightColor:HIGHLIGHTED_BACKGROUND_COLOR];
        self.font = [UIFont systemFontOfSize:FONT_SIZE_DEFAULT];
        self.labelMargin = LABEL_MARGIN_DEFAULT;
        self.bottomMargin = BOTTOM_MARGIN_DEFAULT;
        self.horizontalPadding = HORIZONTAL_PADDING_DEFAULT;
        self.verticalPadding = VERTICAL_PADDING_DEFAULT;
        [self initArrays];
    }
    return self;
}

- (void)initArrays
{
//    self.colorArray = [[NSMutableArray alloc] initWithObjects:
//                        [UIColor redColor],
//                        [UIColor blueColor],
//                        [UIColor brownColor],
//                        [UIColor orangeColor],
//                        [UIColor skyBlueColor],
//                        [UIColor darkTextColor],
//                        [UIColor darkRedColor],
//                        [UIColor magentaColor],
//                        [UIColor purpleColor],
//                        RGBCOLOR(203, 4, 158),
//                        RGBCOLOR(96, 0, 186),
//                        RGBCOLOR(2, 191, 180),
//                        RGBCOLOR(158, 2, 197),
//                        RGBCOLOR(143, 194, 100),
//                        RGBCOLOR(25, 168, 199),
//                        RGBCOLOR(173, 117, 85),
//                        nil];
    
    self.colorArray = [[NSMutableArray alloc] initWithObjects:
                       [UIColor colorWithRGBHex:0x313131],
                       nil];
    
    self.fontArray = [[NSMutableArray alloc] initWithObjects:
                       [UIFont systemFontOfSize:13.0],
//                       [UIFont systemFontOfSize:14.0],
//                       [UIFont systemFontOfSize:15.0],
//                       [UIFont systemFontOfSize:16.0],
                       nil];
    
    
}

- (void)setTags:(NSArray *)array
{
    self.textArray = array;
    sizeFit = CGSizeZero;
    if (automaticResize) {
        [self display];
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, sizeFit.width, sizeFit.height);
    }
    else {
        [self setNeedsLayout];
    }
}

- (void)setTagBackgroundColor:(UIColor *)color
{
    if (color != lblBackgroundColor) {
        lblBackgroundColor = color;
        [self setNeedsDisplay];
    }
}

- (void)setTagHighlightColor:(UIColor *)color
{
    if (color != highlightedBackgroundColor) {
        highlightedBackgroundColor = color;
        [self setNeedsDisplay];
    }
}

- (void)setViewOnly:(BOOL)viewOnly
{
    if (_viewOnly != viewOnly) {
        _viewOnly = viewOnly;
        [self setNeedsLayout];
    }
}

- (void)touchedTag:(id)sender
{
    UITapGestureRecognizer *t = (UITapGestureRecognizer *)sender;
    DWTagView *tagView = (DWTagView *)t.view;
    if(tagView && self.tagDelegate && [self.tagDelegate respondsToSelector:@selector(selectedTag:)])
        [self.tagDelegate selectedTag:tagView.label.text];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    [self display];
}

static void swap (int *pm, int *pn)
{
    int temp;
    temp = *pm;
    *pm = *pn;
    *pn = temp;
}

- (void)display
{
    NSMutableArray *tagViews = [NSMutableArray array];
    for (UIView *subview in [self subviews]) {
        if ([subview isKindOfClass:[DWTagView class]]) {
            DWTagView *tagView = (DWTagView*)subview;
            for (UIGestureRecognizer *gesture in [subview gestureRecognizers]) {
                [subview removeGestureRecognizer:gesture];
            }
            
            [tagView.button removeTarget:nil action:nil forControlEvents:UIControlEventAllEvents];
            
            [tagViews addObject:subview];
        }
        [subview removeFromSuperview];
    }

    CGRect previousFrame = CGRectZero;
    BOOL gotPreviousFrame = YES;
    
    int maxCount = [textArray count];
    std::vector<int> random(maxCount, 0);
    for (int i = 0; i < maxCount; i++) {
        random[i] = i;
    }
    for (int i = maxCount-1; i >= 0; i--) {
        swap(&random[i], &random[arc4random()%maxCount]);
    }

    for (int i = 0; i < [textArray count]; i++)
    {
        NSString *text = [textArray objectAtIndex:i];
        DWTagView *tagView;
        if (tagViews.count > 0) {
            tagView = [tagViews lastObject];
            [tagViews removeLastObject];
        }
        else {
            tagView = [[DWTagView alloc] init];
        }
        
        UIColor *color = [self.colorArray objectAtIndex:random[i]%[self.colorArray count]];
        UIFont *font = [self.fontArray objectAtIndex:arc4random()%[self.fontArray count]];
        [tagView updateWithString:text
                             font:font
               constrainedToWidth:self.frame.size.width - (self.horizontalPadding * 2)
                          padding:CGSizeMake(self.horizontalPadding, self.verticalPadding)
                     minimumWidth:self.minimumWidth color:color
         ];
        
//        if (gotPreviousFrame) {
//            CGRect newRect = CGRectZero;
//            if (previousFrame.origin.x + previousFrame.size.width + tagView.frame.size.width + self.labelMargin > self.frame.size.width) {
//                newRect.origin = CGPointMake(0, previousFrame.origin.y + tagView.frame.size.height + self.bottomMargin);
//            } else {
//                newRect.origin = CGPointMake(previousFrame.origin.x + previousFrame.size.width + self.labelMargin, previousFrame.origin.y);
//            }
//            newRect.size = tagView.frame.size;
//            [tagView setFrame:newRect];
//        }
//        
//        previousFrame = tagView.frame;
//        gotPreviousFrame = YES;
        
        [tagView setBackgroundColor:[self getBackgroundColor]];
        
        UITapGestureRecognizer* gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchedTag:)];
        [tagView setUserInteractionEnabled:YES];
        [tagView addGestureRecognizer:gesture];
        TT_RELEASE_SAFELY(gesture);
        
        int value = arc4random() % 2;
        //int value = 0;

        switch (value) {
            case 0:
            {
                if (gotPreviousFrame) {
                    CGRect newRect = CGRectZero;
                    if (previousFrame.origin.x + previousFrame.size.width + tagView.frame.size.width + self.labelMargin > self.frame.size.width) {
                        newRect.origin = CGPointMake(0-tagView.size.width, previousFrame.origin.y + tagView.frame.size.height + self.bottomMargin);
                    } else {
                        newRect.origin = CGPointMake(0-tagView.size.width, previousFrame.origin.y);
                    }
                    newRect.size = tagView.frame.size;
                    [tagView setFrame:newRect];
                }
                [UIView animateWithDuration:2 animations:^{
                    if (gotPreviousFrame) {
                        CGRect newRect = CGRectZero;
                        if (previousFrame.origin.x + previousFrame.size.width + tagView.frame.size.width + self.labelMargin > self.frame.size.width) {
                            newRect.origin = CGPointMake(0, previousFrame.origin.y + tagView.frame.size.height + self.bottomMargin);
                        } else {
                            if (i==0) {
                                newRect.origin = CGPointMake(0, previousFrame.origin.y);
                            }
                            else
                            {
                                newRect.origin = CGPointMake(previousFrame.origin.x + previousFrame.size.width + self.labelMargin, previousFrame.origin.y);
                            }
                        }
                        newRect.size = tagView.frame.size;
                        [tagView setFrame:newRect];
                    }
                    if (tagView.origin.y < self.switchHotKeyButtonView.origin.y - tagView.size.height) {
                        [self addSubview:tagView];
                    }
                }];
                previousFrame = tagView.frame;
                break;
            }
            case 1:
            {
                if (gotPreviousFrame) {
                    CGRect newRect = CGRectZero;
                    if (previousFrame.origin.x + previousFrame.size.width + tagView.frame.size.width + self.labelMargin > self.frame.size.width) {
                        newRect.origin = CGPointMake(320+tagView.size.width, previousFrame.origin.y + tagView.frame.size.height + self.bottomMargin);
                    } else {
                        newRect.origin = CGPointMake(320+tagView.size.width, previousFrame.origin.y);
                    }
                    newRect.size = tagView.frame.size;
                    [tagView setFrame:newRect];
                }
                [UIView animateWithDuration:2 animations:^{
                    if (gotPreviousFrame) {
                        CGRect newRect = CGRectZero;
                        if (previousFrame.origin.x + previousFrame.size.width + tagView.frame.size.width + self.labelMargin > self.frame.size.width) {
                            newRect.origin = CGPointMake(0, previousFrame.origin.y + tagView.frame.size.height + self.bottomMargin);
                        } else {
                            if (i==0) {
                                newRect.origin = CGPointMake(0, previousFrame.origin.y);
                            }
                            else
                            {
                                newRect.origin = CGPointMake(previousFrame.origin.x + previousFrame.size.width + self.labelMargin, previousFrame.origin.y);
                            }
                        }
                        newRect.size = tagView.frame.size;
                        [tagView setFrame:newRect];
                    }
                    if (tagView.origin.y < self.switchHotKeyButtonView.origin.y - tagView.size.height) {
                        [self addSubview:tagView];
                    }
                }];
                previousFrame = tagView.frame;
                break;
            }
            default:
                break;
        }
        
        
        if (!_viewOnly) {
            [tagView.button addTarget:self action:@selector(touchDownInside:) forControlEvents:UIControlEventTouchDown];
            [tagView.button addTarget:self action:@selector(touchUpInside:) forControlEvents:UIControlEventTouchUpInside];
            [tagView.button addTarget:self action:@selector(touchDragExit:) forControlEvents:UIControlEventTouchDragExit];
            [tagView.button addTarget:self action:@selector(touchDragInside:) forControlEvents:UIControlEventTouchDragInside];
        }
    }

//    sizeFit = CGSizeMake(self.frame.size.width, previousFrame.origin.y + previousFrame.size.height + self.bottomMargin + 1.0f);
//    self.size = sizeFit;
    
    [self addSubview:self.switchHotKeyButtonView];
    [self bringSubviewToFront:self.switchHotKeyButtonView];
}

- (void)displayWithAnimation:(BOOL)animation
{
    NSMutableArray *tagViews = [NSMutableArray array];
    for (UIView *subview in [self subviews]) {
        if ([subview isKindOfClass:[DWTagView class]]) {
            DWTagView *tagView = (DWTagView*)subview;
            for (UIGestureRecognizer *gesture in [subview gestureRecognizers]) {
                [subview removeGestureRecognizer:gesture];
            }
            
            [tagView.button removeTarget:nil action:nil forControlEvents:UIControlEventAllEvents];
            [tagViews addObject:subview];
        }
        [subview removeFromSuperview];
    }
    
    CGRect previousFrame = CGRectZero;
    BOOL gotPreviousFrame = YES;
    
    int maxCount = [textArray count];
    std::vector<int> random(maxCount, 0);
    for (int i = 0; i < maxCount; i++) {
        random[i] = i;
    }
    for (int i = maxCount-1; i >= 0; i--) {
        swap(&random[i], &random[arc4random()%maxCount]);
    }
    
    for (int i = 0; i < [textArray count]; i++)
    {
        NSString *text = [textArray objectAtIndex:i];
        DWTagView *tagView;
        if (tagViews.count > 0) {
            tagView = [tagViews lastObject];
            [tagViews removeLastObject];
        }
        else {
            tagView = [[DWTagView alloc] init];
        }
        
        UIColor *color = [self.colorArray objectAtIndex:random[i]%[self.colorArray count]];
        UIFont *font = [self.fontArray objectAtIndex:arc4random()%[self.fontArray count]];
        [tagView updateWithString:text
                             font:font
               constrainedToWidth:self.frame.size.width - (self.horizontalPadding * 2)
                          padding:CGSizeMake(self.horizontalPadding, self.verticalPadding)
                     minimumWidth:self.minimumWidth color:color];
        
        [tagView setBackgroundColor:[self getBackgroundColor]];
        
        UITapGestureRecognizer* gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchedTag:)];
        [tagView setUserInteractionEnabled:YES];
        [tagView addGestureRecognizer:gesture];
        TT_RELEASE_SAFELY(gesture);
        
        if (animation) {
            int value = arc4random() % 2;
            switch (value) {
                case 0:
                {
                    if (gotPreviousFrame) {
                        CGRect newRect = CGRectZero;
                        if (previousFrame.origin.x + previousFrame.size.width + tagView.frame.size.width + self.labelMargin > self.frame.size.width) {
                            newRect.origin = CGPointMake(0-tagView.size.width, previousFrame.origin.y + tagView.frame.size.height + self.bottomMargin);
                        } else {
                            newRect.origin = CGPointMake(0-tagView.size.width, previousFrame.origin.y);
                        }
                        newRect.size = tagView.frame.size;
                        [tagView setFrame:newRect];
                    }
                    break;
                }
                case 1:
                {
                    if (gotPreviousFrame) {
                        CGRect newRect = CGRectZero;
                        if (previousFrame.origin.x + previousFrame.size.width + tagView.frame.size.width + self.labelMargin > self.frame.size.width) {
                            newRect.origin = CGPointMake(320+tagView.size.width, previousFrame.origin.y + tagView.frame.size.height + self.bottomMargin);
                        } else {
                            newRect.origin = CGPointMake(320+tagView.size.width, previousFrame.origin.y);
                        }
                        newRect.size = tagView.frame.size;
                        [tagView setFrame:newRect];
                    }
                    break;
                }
                default:
                    break;
            }
            [UIView animateWithDuration:2 animations:^{
                if (gotPreviousFrame) {
                    CGRect newRect = CGRectZero;
                    if (previousFrame.origin.x + previousFrame.size.width + tagView.frame.size.width + self.labelMargin > self.frame.size.width) {
                        newRect.origin = CGPointMake(0, previousFrame.origin.y + tagView.frame.size.height + self.bottomMargin);
                    } else {
                        if (i==0) {
                            newRect.origin = CGPointMake(0, previousFrame.origin.y);
                        }
                        else
                        {
                            newRect.origin = CGPointMake(previousFrame.origin.x + previousFrame.size.width + self.labelMargin, previousFrame.origin.y);
                        }
                    }
                    newRect.size = tagView.frame.size;
                    [tagView setFrame:newRect];
                }
                if (tagView.origin.y < self.size.height - tagView.size.height) {
                    [self addSubview:tagView];
                }
            }];
            previousFrame = tagView.frame;
        }else {
            if (gotPreviousFrame) {
                CGRect newRect = CGRectZero;
                if (previousFrame.origin.x + previousFrame.size.width + tagView.frame.size.width + self.labelMargin > self.frame.size.width) {
                    newRect.origin = CGPointMake(0, previousFrame.origin.y + tagView.frame.size.height + self.bottomMargin);
                } else {
                    if (i==0) {
                        newRect.origin = CGPointMake(0, previousFrame.origin.y);
                    }
                    else
                    {
                        newRect.origin = CGPointMake(previousFrame.origin.x + previousFrame.size.width + self.labelMargin, previousFrame.origin.y);
                    }
                }
                newRect.size = tagView.frame.size;
                [tagView setFrame:newRect];
            }
            if (tagView.origin.y < self.size.height - tagView.size.height) {
                [self addSubview:tagView];
            }
            previousFrame = tagView.frame;
        }
        
        if (!_viewOnly) {
            [tagView.button addTarget:self action:@selector(touchDownInside:) forControlEvents:UIControlEventTouchDown];
            [tagView.button addTarget:self action:@selector(touchUpInside:) forControlEvents:UIControlEventTouchUpInside];
            [tagView.button addTarget:self action:@selector(touchDragExit:) forControlEvents:UIControlEventTouchDragExit];
            [tagView.button addTarget:self action:@selector(touchDragInside:) forControlEvents:UIControlEventTouchDragInside];
        }
    }
    //    [self addSubview:self.switchHotKeyButtonView];
    //    [self bringSubviewToFront:self.switchHotKeyButtonView];
}

- (CGSize)fittedSize
{
    return sizeFit;
}

- (void)touchDownInside:(id)sender
{
    UIButton *button = (UIButton*)sender;
    [[button superview] setBackgroundColor:highlightedBackgroundColor];
}

- (void)touchUpInside:(id)sender
{
    UIButton *button = (UIButton*)sender;
    [[button superview] setBackgroundColor:[self getBackgroundColor]];
    if(button && self.tagDelegate && [self.tagDelegate respondsToSelector:@selector(selectedTag:)])
        [self.tagDelegate selectedTag:button.accessibilityLabel];
}

- (void)touchDragExit:(id)sender
{
    UIButton *button = (UIButton*)sender;
    [[button superview] setBackgroundColor:[self getBackgroundColor]];
}

- (void)touchDragInside:(id)sender
{
    UIButton *button = (UIButton*)sender;
    [[button superview] setBackgroundColor:[self getBackgroundColor]];
}
     
- (UIColor *)getBackgroundColor
{
    return [UIColor clearColor];
    
//     if (!lblBackgroundColor) {
//         return BACKGROUND_COLOR;
//     } else {
//         return lblBackgroundColor;
//     }
}

- (void)dealloc
{
    TT_RELEASE_SAFELY(lblBackgroundColor);
    TT_RELEASE_SAFELY(highlightedBackgroundColor);
    TT_RELEASE_SAFELY(view);
    TT_RELEASE_SAFELY(textArray);
    TT_RELEASE_SAFELY(_switchHotKeyButtonView);

}

- (void)switchHotKeys
{
    if ([self.tagDelegate respondsToSelector:@selector(switchHotKeywords)]) {
        [self.tagDelegate switchHotKeywords];
    }
}

- (UIView *)switchHotKeyButtonView
{
    if (!_switchHotKeyButtonView) {
        _switchHotKeyButtonView = [[UIView alloc] init];
        _switchHotKeyButtonView.backgroundColor = RGBCOLOR(242, 242, 242);
        if ([SystemInfo is_iPhone_5]) {
            _switchHotKeyButtonView.frame = CGRectMake(-20, 167, 320, 36);
        }
        else
        {
            _switchHotKeyButtonView.frame = CGRectMake(-20, 90, 320, 36);
        }
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(30, 0, 260, 36);
//        UIImage *image = [UIImage imageNamed:@"search_switch_button.png"];
//        UIImage *streImage = [image stretchableImageWithLeftCapWidth:60 topCapHeight:0];
//        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14.0];
//        [button setBackgroundImage:streImage forState:UIControlStateNormal];
//        [button setTitle:L(@"Switch Hot keywords") forState:UIControlStateNormal];
        [button setTitle:L(@"Switch Hot keywords") forState:UIControlStateNormal];
//        button.layer.borderWidth = 1;
//        button.layer.borderColor = RGBCOLOR(120, 120, 120).CGColor;
        [button setTitleColor:[UIColor colorWithRGBHex:0x313131] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRGBHex:0xfc7c26] forState:UIControlStateHighlighted];
        button.backgroundColor = [UIColor clearColor];
        
        [button addTarget:self action:@selector(switchHotKeys) forControlEvents:UIControlEventTouchUpInside];
        
        [_switchHotKeyButtonView addSubview:button];
        
    }
    return _switchHotKeyButtonView;
}
@end


@implementation DWTagView

- (id)init {
    self = [super init];
    if (self) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//        UIImage *image = [UIImage streImageNamed:@"transparent_button.png"];
//        [_button setBackgroundImage:image forState:UIControlStateNormal];
        _button.backgroundColor = [UIColor clearColor];
        [_button setFrame:self.frame];
        [self addSubview:_button];
        
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        [_label setTextColor:RGBCOLOR(49, 49, 49)];
        [_label setShadowColor:TEXT_SHADOW_COLOR];
        [_label setShadowOffset:TEXT_SHADOW_OFFSET];
        [_label setBackgroundColor:[UIColor clearColor]];
        [_label setTextAlignment:NSTextAlignmentCenter];
        [_button addSubview:_label];

        
        [self.layer setMasksToBounds:YES];
        [self.layer setCornerRadius:CORNER_RADIUS];
        [self.layer setBorderColor:BORDER_COLOR];
        [self.layer setBorderWidth: BORDER_WIDTH];
    }
    return self;
}

- (void)updateWithString:(NSString*)text font:(UIFont*)font constrainedToWidth:(CGFloat)maxWidth padding:(CGSize)padding minimumWidth:(CGFloat)minimumWidth color:(UIColor *)color
{
    CGSize textSize = [text sizeWithFont:font forWidth:maxWidth lineBreakMode:NSLineBreakByTruncatingTail];
    
    textSize.width = MAX(textSize.width, minimumWidth);
    textSize.height += padding.height*2;

    self.frame = CGRectMake(0, 0, textSize.width+padding.width*2, textSize.height);
    _label.frame = CGRectMake(padding.width, 0, MIN(textSize.width, self.frame.size.width), textSize.height);
    _label.font = font;
    _label.text = text;
    _label.textColor = color;
    _label.lineBreakMode = NSLineBreakByTruncatingTail;
    [_button setAccessibilityLabel:self.label.text];
}

- (void)setLabelText:(NSString*)text
{
    [_label setText:text];
}

- (void)dealloc
{
//    _label = nil;
//    _button = nil;
    TT_RELEASE_SAFELY(_label);
    TT_RELEASE_SAFELY(_button);
}

@end
