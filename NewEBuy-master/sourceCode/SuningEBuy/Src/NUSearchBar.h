//
//  NUSearchBar.h
//  SuningEBuy
//
//  Created by 孔斌 on 13-8-20.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonView.h"
#import "ChooseSearchTypeView.h"
#import "VoiceSearchKeyboardView.h"
#import "VoiceSearchViewController.h"

@protocol NUSearchBarDelegate;

@interface NUSearchBar : CommonView<UITextFieldDelegate, VoiceSearchKeyboardViewDelegate>
{
    UIButton *cancelButton_;
    UIButton *readerButton_;
}

@property (nonatomic, weak) id<NUSearchBarDelegate> readerDelegate;
@property (nonatomic, strong) UIButton                  *readerButton;        //  读码器按钮
@property (nonatomic, strong) UITextField               *searchTextField;     //  搜索textField
@property (nonatomic, strong) UIImageView               *searchImgView;       //  搜索条图片
@property (nonatomic, strong) UIImageView               *wholeImageView;      //  背景图
@property (nonatomic, strong) UIButton                  *cancelButton;        //  取消按钮
@property (nonatomic, strong) UIImageView               *searchImgBtn;        //  搜索小图片
@property (nonatomic, strong) UIButton                  *searchTypeBtn;       //  切换商品，店铺搜索的按钮
@property (nonatomic, strong) VoiceSearchKeyboardView  *keyboardView;
- (NSString *)switchSearchwords;
- (void)showSearchBar;
-(void)hideSearchBar:(UIButton *)button;


@end


@protocol NUSearchBarDelegate <NSObject>

@optional
- (void)beginReaderZBar;

- (BOOL)searchFieldShouldBeginEditing:(UITextField *)textField;
- (void)searchBar:(UITextField *)searchField textDidChange:(NSString *)searchText;
- (BOOL)searchFieldShouldEndEditing:(UITextField *)textField;
- (void)searchFieldSearchButtonClicked:(UITextField *)searchField;

@end

