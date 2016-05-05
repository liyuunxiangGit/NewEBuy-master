//
//  NUHotKeywordsView.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-4-16.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "NUHotKeywordsView.h"
#include <vector>

#define kButtonBaseTagValue  23

@interface NUHotKeywordsView()

@property (nonatomic, strong) NSMutableArray *colorArray;
@property (nonatomic, strong) NSMutableArray *fontArray;
@property (nonatomic, strong) NSMutableArray *frameArray;

- (void)initArrays;

@end

/*********************************************************************/


@implementation NUHotKeywordsView

@synthesize colorArray = colorArray_;
@synthesize fontArray = fontArray_;
@synthesize frameArray = frameArray_;

@synthesize keywordArray = _keywordArray;
@synthesize delegate = _delegate;

- (void)dealloc {
    TT_RELEASE_SAFELY(colorArray_);
    TT_RELEASE_SAFELY(fontArray_);
    TT_RELEASE_SAFELY(frameArray_);
    TT_RELEASE_SAFELY(_keywordArray);
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
                
    }
    return self;
}

- (id)initWithKeywords:(NSArray *)keywords
{
    self = [super init];
    if (self) {
        self.keywordArray = keywords;
        [self initArrays];
    }
    return self;
}

- (void)initArrays
{
    self.colorArray = [[NSMutableArray alloc] initWithObjects:
                        [UIColor redColor],     
                        [UIColor blueColor],
                        [UIColor brownColor],
                        [UIColor orangeColor],
                        [UIColor skyBlueColor],
                        [UIColor navTintColor],
                        [UIColor darkRedColor],
                        [UIColor magentaColor],
                        [UIColor purpleColor],
                        RGBCOLOR(203, 4, 158),
                        RGBCOLOR(96, 0, 186),
                        RGBCOLOR(2, 191, 180),
                        RGBCOLOR(158, 2, 197),
                        RGBCOLOR(143, 194, 100),
                        RGBCOLOR(25, 168, 199),
                        RGBCOLOR(173, 117, 85),
                        nil];
    
    self.fontArray = [[NSMutableArray alloc] initWithObjects:
                       [UIFont boldSystemFontOfSize:18.0],
                       [UIFont boldSystemFontOfSize:19.0],
                       [UIFont boldSystemFontOfSize:20.0],
                       [UIFont boldSystemFontOfSize:21.0],
                      nil];
    
    
}

static void swap (int *pm, int *pn)
{
    int temp;
    temp = *pm;
    *pm = *pn;
    *pn = temp;
}

- (void)beginDisplay
{
    [self removeAllSubviews];
    if (self.keywordArray == nil || [self.keywordArray count] == 0) {
        return;
    }
    
    int maxCount = [self.keywordArray count];
    std::vector<int> random(maxCount, 0);    
    for (int i = 0; i < maxCount; i++) {
        random[i] = i;
    }
    for (int i = maxCount-1; i >= 0; i--) {
        swap(&random[i], &random[arc4random()%maxCount]);
    }
    
    for (int i = 0; i < [self.keywordArray count]; i++)
    {
        NSString *title = [self.keywordArray objectAtIndex:i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = RGBCOLOR(239, 242, 232);
        [button setTitle:title forState:UIControlStateNormal];
        UIFont *font = [self.fontArray objectAtIndex:arc4random()%[self.fontArray count]];
        button.titleLabel.font = font;
        UIColor *color = [self.colorArray objectAtIndex:random[i]%[self.colorArray count]];
        [button setTitleColor:color forState:UIControlStateNormal];
//        UIImage *image = [UIImage streImageNamed:@"transparent_button.png"];
//        [button setBackgroundImage:image forState:UIControlStateHighlighted];
        
        button.titleLabel.adjustsFontSizeToFitWidth = YES;
        button.tag = i+kButtonBaseTagValue;
        
        button.frame = CGRectMake(20+140*(i%2), 20+40*(i/2), 140, 30);
        [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        CGAffineTransform newTransform = CGAffineTransformMakeScale(0.1, 0.1);
        [button setTransform:newTransform];
        TT_RELEASE_SAFELY(button);
        
    }
    [UIView animateWithDuration:0.5
                     animations:^{
                         for (int i = 0; i < [self.keywordArray count]; i++) {
                             UIButton *button = (UIButton *)[self viewWithTag:kButtonBaseTagValue+i];
                             if (button && [button isKindOfClass:[UIButton class]]) {
                                 CGAffineTransform newTransform = CGAffineTransformMakeScale(1.0, 1.0);
                                 [button setTransform:newTransform];
                             }
                         }
                     }completion:^(BOOL finished){
                         
                     }];
    
}

- (void)buttonTapped:(id)sender
{
    UIButton *button = (UIButton *)sender;
    NSInteger index = button.tag - kButtonBaseTagValue;
    NSString *keywords = [self.keywordArray objectAtIndex:index];
    if (_delegate && [_delegate conformsToProtocol:@protocol(NUHotKeywordsViewDelegate)]) {
        if ([_delegate respondsToSelector:@selector(didSelectKeyword:)]) {
            [_delegate didSelectKeyword:[NSString stringWithString:keywords]];
        }
    }
}


@end
