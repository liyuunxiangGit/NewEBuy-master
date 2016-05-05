//
//  OSEmoticonView.h
//  SuningEBuy
//
//  Created by  liukun on 13-12-2.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyPageControl.h"

@class OSEmoticonView;
@protocol OSEmoticonViewDelegate <NSObject>

@optional
- (void)emoticonView:(OSEmoticonView *)view didChooseEmoticon:(NSString *)emoticonStr;
- (void)emoticonView:(OSEmoticonView *)view didChooseQuickAskWord:(NSString *)word;
- (void)emoticonViewSendButtonClicked:(OSEmoticonView *)view;


@end

@interface OSEmoticonView : UIView <UITableViewDataSource, UITableViewDelegate>
{
    BOOL _isShowEmoticon;
}

@property (nonatomic, weak) id<OSEmoticonViewDelegate> delegate;

@property (nonatomic, strong) UIScrollView *emoticonScrollView;
@property (nonatomic, strong) UITableView *quickAskView;
@property (nonatomic, strong) UIButton *sendButton;
@property (nonatomic, strong) MyPageControl *pageControl;

@property (nonatomic, strong) NSArray *quickAskArray;

- (void)showEmoticonView;
- (void)showQuickAskView;

- (BOOL)isShowEmoticon;

@end
