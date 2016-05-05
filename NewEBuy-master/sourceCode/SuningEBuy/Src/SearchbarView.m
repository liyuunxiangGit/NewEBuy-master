//
//  SearchbarView.m
//  SuningEBuy
//
//  Created by 孔斌 on 13-8-2.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "SearchbarView.h"
#import "SNSwitch.h"
#import <QuartzCore/QuartzCore.h>

#define ios7width           3

@interface SearchbarView()

@property (nonatomic, copy) NSString *lastestSearchStr;

@end

/*********************************************************************/

@implementation SearchbarView

@synthesize searchTextField = _searchTextField;
@synthesize searchImgView = _searchImgView;
@synthesize searchImgBtn = _searchImgBtn;
@synthesize wholeImageView = _wholeImageView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addSubview:self.wholeImageView];
        [self addSubview:self.searchImgView];
        [self addSubview:self.searchImgBtn];
        [self addSubview:self.searchTextField];
        //[self addSubview:self.lineView];
        //        [self.searchTextField insertSubview:self.searchImgBtn aboveSubview:self.searchImgView];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(searchTypeChanged) name:SEARCHTYPE_CHANGED object:nil];
    }
    return self;
}

- (void)searchTypeChanged
{
    NSNumber *number = [Config currentConfig].searchType;
    if (number.intValue == 0)
    {
        [self.searchTypeBtn setTitle:@"商品" forState:UIControlStateNormal];
    }
    else if (number.intValue == 1)
    {
        [self.searchTypeBtn setTitle:@"店铺" forState:UIControlStateNormal];
    }
    
    [self.searchTypeBtn setImage:[UIImage imageNamed:@"SearchSegment_downArrowGray.png"] forState:UIControlStateNormal];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    TT_RELEASE_SAFELY(_searchTextField);
    TT_RELEASE_SAFELY(_searchImgView);
    TT_RELEASE_SAFELY(_searchImgBtn);
    TT_RELEASE_SAFELY(_wholeImageView);
    
}

- (UITextField *)searchTextField{
    if (!_searchTextField) {
        _searchTextField = [[UITextField alloc] init];
        _searchTextField.placeholder = @"搜索商品";
        if (IOS7_OR_LATER) {
            _searchTextField.frame = CGRectMake(33, 10, 243 - 18 - 10, 22);
        }else{
            _searchTextField.frame = CGRectMake(33 + ios7width, 10, 243 - 18 - 10, 22);
        }
        _searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _searchTextField.returnKeyType = UIReturnKeySearch;
        _searchTextField.font = [UIFont boldSystemFontOfSize:14.0];
        _searchTextField.textColor = RGBCOLOR(112, 112, 112);
        _searchTextField.delegate = self;
        [_searchTextField addTarget:self action:@selector(textFieldDidChangeText:)
                   forControlEvents:UIControlEventEditingChanged];
        
        _searchTextField.inputAccessoryView = self.keyboardView;
        _searchTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
    }
    return _searchTextField;
}

- (VoiceSearchKeyboardView *)keyboardView
{
    if (!_keyboardView)
    {
        _keyboardView = [[VoiceSearchKeyboardView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        _keyboardView.delegate = self;
    }
    
    return _keyboardView;
}

#pragma mark - 语音按钮代理
- (void)btnSpeakerTapped
{
    [VoiceSearchViewController sharedVoiceSearchCtrl].from = From_NewHome;
    [[VoiceSearchViewController sharedVoiceSearchCtrl] showVoiceSearchView];

    [self.searchTextField resignFirstResponder];
}

- (UIImageView *)searchImgBtn{
    if (!_searchImgBtn) {
        _searchImgBtn = [[UIImageView alloc] init];
        if (IOS7_OR_LATER) {
            _searchImgBtn.frame = CGRectMake(9, 12+2, 13, 13);
        }else{
            _searchImgBtn.frame = CGRectMake(9 + ios7width, 12+2, 13, 13);
        }
        _searchImgBtn.image = [UIImage imageNamed:@"search244_25x25.png"];
    }
    return _searchImgBtn;
}

- (UIImageView *)searchImgView{
    if (!_searchImgView) {
        _searchImgView = [[UIImageView alloc] init];
        if (IOS7_OR_LATER) {
            _searchImgView.frame = CGRectMake(3, 6, 252, 28);
        }else{
            _searchImgView.frame = CGRectMake(3 + ios7width, 6, 252, 28);
        }
        _searchImgView.layer.cornerRadius = 1;
        _searchImgView.backgroundColor = [UIColor clearColor];
//        _searchImgView.layer.borderWidth = 0.5;
//        _searchImgView.layer.borderColor = RGBCOLOR(216, 216, 216).CGColor;
//        _searchImgView.layer.masksToBounds = YES;
    }
    return _searchImgView;
}

- (UIImageView *)wholeImageView{
    if (!_wholeImageView) {
        CGRect frame = CGRectMake(0, 0, 300, 44);
        _wholeImageView = [[UIImageView alloc] initWithFrame:frame];
//        _wholeImageView.backgroundColor = [UIColor cell_Back_Color];
//        _wholeImageView.alpha = 0.9f;
//        if (IOS7_OR_LATER)
//        {
//            _wholeImageView.backgroundColor = RGBCOLOR(247, 247, 248);
//        }
//        else
//        {
//            _wholeImageView.backgroundColor = RGBCOLOR(247, 247, 248);
//        }
//        _wholeImageView.image = [UIImage streImageNamed:kNavigationBarBackgroundImage];
        _wholeImageView.alpha = 0.0f;
        
        UIView *vBottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, 43.5, 320, 0.5)];
        vBottomLine.backgroundColor = RGBACOLOR(216, 216, 216, 0.8);
        [_wholeImageView addSubview:vBottomLine];
    }
    return _wholeImageView;
}

- (UIImageView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIImageView alloc] init];
        if (IOS7_OR_LATER) {
            _lineView.frame = CGRectMake(264, 7.5, 0.5, 27);;
        }else{
            _lineView.frame = CGRectMake(264 + ios7width, 7.5, 0.5, 27);
        }
        _lineView.image = [UIImage imageNamed:@"segment_vertical_line.png"];
    }
    return _lineView;
}

- (UIButton *)searchTypeBtn
{
    if (!_searchTypeBtn)
    {
        if (!_searchTypeBtn)
        {
            _searchTypeBtn = [[UIButton alloc] init];
            _searchTypeBtn.frame = CGRectMake(0, 7, 60, 28);
            
            if (IOS7_OR_LATER)
            {
                _searchTypeBtn.backgroundColor = [UIColor clearColor];
                [_searchTypeBtn setTitleColor:[UIColor colorWithRGBHex:0x313131] forState:UIControlStateNormal];
                [_searchTypeBtn setTitleColor:[UIColor colorWithRGBHex:0xfc7c26] forState:UIControlStateHighlighted];
            }
            else
            {
                _searchTypeBtn.backgroundColor = [UIColor clearColor];
                [_searchTypeBtn setTitleColor:[UIColor colorWithRGBHex:0x707070] forState:UIControlStateNormal];
                [_searchTypeBtn setTitleColor:[UIColor colorWithRGBHex:0xfc7c26] forState:UIControlStateHighlighted];
                
            }
            
            
            [_searchTypeBtn setTitle:@"商品" forState:UIControlStateNormal];

            [_searchTypeBtn setImage:[UIImage imageNamed:@"SearchSegment_downArrowGray.png"] forState:UIControlStateNormal];
            
            _searchTypeBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 45, 0, 0);
            _searchTypeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
            //            _searchTypeBtn.titleEdgeInsets = UIEdgeInsetsMake(1, 1, 0, 0);
          
            _searchTypeBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
          
            _searchTypeBtn.hidden = YES;
            _searchTypeBtn.tag = 3001;
            [_searchTypeBtn addTarget:self action:@selector(searchTypeBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:_searchTypeBtn];
        }
    }
    
    return _searchTypeBtn;
}

- (void)searchTypeBtnTapped:(id)sender
{
//    [[NSNotificationCenter defaultCenter] postNotificationName:SHOW_SELECT_SEARCHTYPEVIEW object:nil];
    
    [ChooseSearchTypeView showOnWindow];
    
    [_searchTypeBtn setImage:[UIImage imageNamed:@"SearchSegment_upArrowGray.png"] forState:UIControlStateNormal];
    
}
#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([_delegate respondsToSelector:@selector(searchFieldShouldBeginEditing:)])
    {
        return [_delegate searchFieldShouldBeginEditing:textField];
    }
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if ([_delegate respondsToSelector:@selector(searchFieldShouldEndEditing:)]) {
        return [_delegate searchFieldShouldEndEditing:textField];
    }
    return YES;
}

- (void)textFieldDidChangeText:(UITextField *)textField
{
    if (![self.lastestSearchStr isEqualToString:textField.text])
    {
        self.lastestSearchStr = textField.text;
        if ([_delegate respondsToSelector:@selector(searchBar:textDidChange:)]) {
            [_delegate searchBar:textField textDidChange:self.lastestSearchStr];
        }
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([textField.text isEqualToString:textField.placeholder]) {
        textField.text = @"";
//        textField.placeholder = [SNSwitch randomSearchPlaceholder];
        textField.placeholder = [[DefaultKeyWordManager defaultManager] randomSearchPlaceholder];
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([_delegate respondsToSelector:@selector(searchFieldSearchButtonClicked:)]) {
        [_delegate searchFieldSearchButtonClicked:textField];
    }
    return YES;
    
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
//    textField.placeholder = [SNSwitch randomSearchPlaceholder];
    textField.placeholder = [[DefaultKeyWordManager defaultManager] randomSearchPlaceholder];
    return YES;
}

@end
