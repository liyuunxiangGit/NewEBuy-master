//
//  SearchNavigationBar.h
//  SuningEBuy
//
//  Created by chupeng on 14-7-15.
//  Copyright (c) 2014年 Suning. All rights reserved.
//  店铺搜索结果页导航栏

#import <UIKit/UIKit.h>
#import "SearchTextField.h"
#import "VoiceSearchKeyboardView.h"
#import "VoiceSearchViewController.h"

@protocol SearchNavigationBarDelegate <NSObject, UITextFieldDelegate>
- (void)showFilterView:(id)sender;
- (void)cancelSearch:(id)sender;
- (void)readerBegin;
- (void)beginSearch:(id)sender;
- (void)textChanged:(id)sender;
- (void)backForePage;
@end

typedef enum
{
    SearchResultState,     //表示在搜索结果集页面展示哪些button
    SearchShowingSearchTypeState,  //表示在点击搜索输入框后展示哪些button
    SearchNoResultState   //表示无结果页面展示哪些button
} BUTTONSSTATE;

@interface SearchNavigationBar : UINavigationBar<SearchNavigationBarDelegate, VoiceSearchKeyboardViewDelegate>

//代理
@property (nonatomic, weak) id<SearchNavigationBarDelegate >customSearchNavBarDelegate;

//退出按钮
@property (nonatomic, strong) UIButton *navLeftBtn;

//输入关键字的textField
@property (nonatomic, strong) SearchTextField *searchTextField;

//筛选按钮
@property (nonatomic, strong) UIButton *filterButton;

//取消按钮
@property (nonatomic, strong) UIButton *searchCancelButton;

//扫一扫按钮
@property (nonatomic, strong) UIButton *zxingBtn;

//搜索类型切换按钮
@property (nonatomic, strong) UIButton *searchTypeBtn;

@property (nonatomic, strong) VoiceSearchKeyboardView  *keyboardView;

- (void)showButtons:(BUTTONSSTATE)state;
@end
