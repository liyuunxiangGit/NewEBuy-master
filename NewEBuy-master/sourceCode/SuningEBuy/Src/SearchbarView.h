//
//  SearchbarView.h
//  SuningEBuy
//
//  Created by 孔斌 on 13-8-2.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonView.h"
#import "ChooseSearchTypeView.h"
#import "VoiceSearchKeyboardView.h"
#import "VoiceSearchViewController.h"
@protocol SearchbarViewDelegate; 

@interface SearchbarView : CommonView <UITextFieldDelegate, VoiceSearchKeyboardViewDelegate>

@property (weak,nonatomic) id<SearchbarViewDelegate> delegate;

@property (nonatomic, strong) UITextField               *searchTextField;
@property (nonatomic, strong) UIImageView               *searchImgView;
@property (nonatomic, strong) UIImageView               *searchImgBtn;
@property (nonatomic, strong) UIImageView               *wholeImageView;

@property (nonatomic, strong) UIImageView               *lineView;

@property (nonatomic, strong) UIButton                 *searchTypeBtn;
@property (nonatomic, strong) VoiceSearchKeyboardView  *keyboardView;
@end

@protocol SearchbarViewDelegate <NSObject>

- (BOOL)searchFieldShouldBeginEditing:(UITextField *)textField;
- (void)searchBar:(UITextField *)searchField textDidChange:(NSString *)searchText;
- (BOOL)searchFieldShouldEndEditing:(UITextField *)textField;
- (void)searchFieldSearchButtonClicked:(UITextField *)searchField;

@end




