//
//  NUHotKeywordsView.h
//  SuningEBuy
//
//  Created by 刘坤 on 12-4-16.
//  Copyright (c) 2012年 Suning. All rights reserved.
//


//已废弃

#import <UIKit/UIKit.h>

@protocol NUHotKeywordsViewDelegate;

@interface NUHotKeywordsView : UIView
{
    @private
    NSMutableArray *colorArray_;
    
    NSMutableArray *fontArray_;
    
    NSMutableArray *frameArray_;
}

@property (nonatomic, strong) NSArray *keywordArray;
@property (nonatomic, weak) id<NUHotKeywordsViewDelegate> delegate;

- (id)initWithKeywords:(NSArray *)keywords;

- (void)beginDisplay;
@end

@protocol NUHotKeywordsViewDelegate <NSObject>

- (void)didSelectKeyword:(NSString *)keyword;

@end
