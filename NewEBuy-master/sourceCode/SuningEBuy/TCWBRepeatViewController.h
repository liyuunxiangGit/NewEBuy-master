//
//  TCWBRepeatViewController.h
//  TCWeiBoSDKDemo
//
//  Created by zzz on 9/18/12.
//  Copyright (c) 2012 bysft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCWBEngine.h"
#import "WordsLeftView.h"

#define NavBarHeight                            44
#define IMAGETAG                                10
#define LOADINGVIWTAG                           11
#define NOTEVIEWTAG                             12

@interface TCWBRepeatViewController : UIViewController<UITextViewDelegate,UIScrollViewDelegate> {
    NSDictionary                *dictRepeat;
    TCWBEngine                  *wbEngine;
    UITextView                  *textView;
    WordsLeftView               *viewWordNum;
    NSInteger                   wordNum;
    UIScrollView *scroViewPic;
    UIPageControl *pageControl;
}
@property (nonatomic, strong)NSDictionary        *dictRepeat;
@property (nonatomic, strong)TCWBEngine          *wbEngine;

- (id)initWithEngine:(TCWBEngine *)engine parameter:(NSDictionary *)dict;
// 字数统计
- (int)calcStrWordCount:(NSString *)str;

@end
