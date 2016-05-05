//
//  SearchSectionHeaderView.h
//  SuningEBuy
//
//  Created by 刘坤 on 12-8-30.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchSectionTouchDelegate <NSObject>

- (void)didTouchTheButtonOnSectionHeader:(NSString *)keyword;

@end

@interface SearchSectionHeaderView : UIView

@property (nonatomic, weak) id<SearchSectionTouchDelegate> delegate;
@property (nonatomic, copy) NSString *keyword;


- (void)setSearchKeyword:(NSString *)keyword resultNumber:(NSInteger)result;

@end
