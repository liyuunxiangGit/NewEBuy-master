//
//  NUSearchBar.m
//  SuningEBuy
//
//  Created by 孔斌 on 13-8-20.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "NUSearchBar.h"


#import "SNSwitch.h"
#import <QuartzCore/QuartzCore.h>
@interface NUSearchBar()
{
    NSString *searchStr;
}

@property (nonatomic, copy) NSString *searchStr;

@property (nonatomic, copy) NSString *lastestSearchStr;

@end

/*********************************************************************/


@implementation NUSearchBar

@synthesize readerButton = readerButton_;

@synthesize readerDelegate = _readerDelegate;

@synthesize searchStr;

@synthesize searchTextField = _searchTextField;
@synthesize searchImgView = _searchImgView;
@synthesize wholeImageView = _wholeImageView;
@synthesize cancelButton = _cancelButton;
@synthesize searchImgBtn = _searchImgBtn;

- (void)dealloc {
    
     [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    TT_RELEASE_SAFELY(readerButton_);
    TT_RELEASE_SAFELY(_cancelButton);
    
    
    TT_RELEASE_SAFELY(_searchImgView);
    TT_RELEASE_SAFELY(_searchTextField);
    TT_RELEASE_SAFELY(_wholeImageView);
    TT_RELEASE_SAFELY(_searchImgBtn);
    
}


- (id)init {
    self = [super initWithFrame:CGRectMake(0, 0, 320, 44)];
    if (self) {
        NSDictionary *switchMap = [GlobalDataCenter defaultCenter].activitySwitchMap;
        
        self.searchStr = [switchMap objectForKey:@"SearchTextField"];
        NSString *strPlaceHolder = [[DefaultKeyWordManager defaultManager] randomSearchPlaceholder];
        if (!strPlaceHolder)
        {
            self.searchTextField.placeholder = L(@"Search Product");
        }
        else
        {
            self.searchTextField.placeholder = strPlaceHolder;
        }
        
        
        _lastestSearchStr = @"";
        
        self.backgroundColor = RGBCOLOR(247, 247, 248);
        
        [self addSubview:self.wholeImageView];
        [self addSubview:self.searchImgView];
        [self addSubview:self.searchTextField];
        [self addSubview:self.searchImgBtn];
        
        [self addSubview:self.cancelButton];
        
        [self addSubview:self.readerButton];
        [self addSubview:self.searchTypeBtn];
        [self bringSubviewToFront:self.readerButton];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(searchTypeChanged) name:SEARCHTYPE_CHANGED object:nil];
    }
    return self;
}

- (void)searchTypeChanged
{
    NSNumber *number = [Config currentConfig].searchType;
    if (number.intValue == 0)
    {
        [self.searchTypeBtn setTitle:L(@"Search_Goods") forState:UIControlStateNormal];
    }
    else if (number.intValue == 1)
    {
        [self.searchTypeBtn setTitle:L(@"Search_Store") forState:UIControlStateNormal];
    }
    
    [self.searchTypeBtn setImage:[UIImage imageNamed:@"SearchSegment_downArrowGray.png"] forState:UIControlStateNormal];
}

- (NSString *)switchSearchwords
{
    return [[DefaultKeyWordManager defaultManager] randomSearchPlaceholder];
}

- (UITextField *)searchTextField{
    if (!_searchTextField) {
        _searchTextField = [[UITextField alloc] init];
        _searchTextField.frame = CGRectMake(45 + 60, 11, 210 - 30, 22);
        _searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _searchTextField.returnKeyType = UIReturnKeySearch;
        [_searchTextField addTarget:self action:@selector(textFieldDidChangeText:)
                   forControlEvents:UIControlEventEditingChanged];
        _searchTextField.delegate = self;
        _searchTextField.font = [UIFont systemFontOfSize:14.0];
        _searchTextField.textColor = RGBCOLOR(112, 112, 112);
        
        _searchTextField.inputAccessoryView = self.keyboardView;
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
    [VoiceSearchViewController sharedVoiceSearchCtrl].from = From_NewSearch;
    [[VoiceSearchViewController sharedVoiceSearchCtrl] showVoiceSearchView];

    [self.searchTextField resignFirstResponder];
}

- (UIImageView *)searchImgBtn{
    if (!_searchImgBtn) {
        _searchImgBtn = [[UIImageView alloc] init];
        _searchImgBtn.frame = CGRectMake(22 + 60, 13, 18, 18);
        _searchImgBtn.image = [UIImage imageNamed:@"Search_ZoomInIcon"];
    }
    return _searchImgBtn;
}

- (UIImageView *)searchImgView{
    if (!_searchImgView) {
        _searchImgView = [[UIImageView alloc] init];
        _searchImgView.frame = CGRectMake(15 + 60, 8, 235 - 50, 28);
        _searchImgView.image = [UIImage streImageNamed:@"Search_searchBorder"];
    }
    return _searchImgView;
}


- (UIButton *)searchTypeBtn
{
    if (!_searchTypeBtn)
    {
        if (!_searchTypeBtn)
        {
            _searchTypeBtn = [[UIButton alloc] init];
            _searchTypeBtn.frame = CGRectMake(10, 7, 60, 28);
            
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
            
            int searchType = [[Config currentConfig].searchType intValue];
            if (searchType == 0)
            {
                [_searchTypeBtn setTitle:L(@"Search_Goods") forState:UIControlStateNormal];
            }
            else if (searchType == 1)
            {
                [_searchTypeBtn setTitle:L(@"Search_Store") forState:UIControlStateNormal];
            }
            
            [_searchTypeBtn setImage:[UIImage imageNamed:@"SearchSegment_downArrowGray.png"] forState:UIControlStateNormal];
            
            _searchTypeBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 45, 0, 0);
            _searchTypeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
            
            _searchTypeBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
            
            _searchTypeBtn.tag = 3001;
            [_searchTypeBtn addTarget:self action:@selector(searchTypeBtnTapped) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:_searchTypeBtn];
        }
    }
    
    return _searchTypeBtn;
}

- (void)searchTypeBtnTapped
{
    [ChooseSearchTypeView showOnWindow];
    
    [_searchTypeBtn setImage:[UIImage imageNamed:@"SearchSegment_upArrowGray.png"] forState:UIControlStateNormal];
}


- (UIImageView *)wholeImageView{
    if (!_wholeImageView) {
        CGRect frame = CGRectMake(0, 0, 320, 44);
        _wholeImageView = [[UIImageView alloc] initWithFrame:frame];
//        _wholeImageView.image = [UIImage streImageNamed:kNavigationBarBackgroundImage];
        _wholeImageView.backgroundColor = RGBCOLOR(247, 247, 248);
        
        _wholeImageView.alpha = 0.0f;
        _wholeImageView.userInteractionEnabled = YES;
//        _wholeImageView.layer.shadowColor = [UIColor blackColor].CGColor;
//        _wholeImageView.layer.shadowOffset = CGSizeMake(0, 2);
//        _wholeImageView.layer.shadowOpacity = 0.1;
        
        UIView *vBottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, 43.5, 320, 0.5)];
        vBottomLine.backgroundColor = RGBACOLOR(216, 216, 216, 0.8);
        [_wholeImageView addSubview:vBottomLine];
    }
    return _wholeImageView;
}

- (UIButton *)readerButton
{
    if (!readerButton_)
    {
        readerButton_ = [UIButton buttonWithType:UIButtonTypeCustom];
        
        readerButton_.frame = CGRectMake(270 , 4.5, 35, 35);
        
        //[readerButton_ setImage:[UIImage imageNamed:@"QR_code.png"] forState:UIControlStateNormal];
        
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(2.5, 2.5, 31, 28)];
        imgV.userInteractionEnabled = NO;
        imgV.image = [UIImage imageNamed:@"Newhome_QR_code.png"];
        
        [readerButton_ addSubview:imgV];
        
        [readerButton_ addTarget:self action:@selector(readerBegin) forControlEvents:UIControlEventTouchUpInside];
        
        readerButton_.hidden = NO;
        
    }
    return readerButton_;
}

- (UIButton *)cancelButton{
    if (!_cancelButton) {
        _cancelButton = [[UIButton alloc] init];
        _cancelButton.frame = CGRectMake(265, 7, 50, 30);
//        [_cancelButton setBackgroundImage:[UIImage imageNamed:@"right_item_btn.png"] forState:UIControlStateNormal];
        _cancelButton.backgroundColor = [UIColor clearColor];

        [_cancelButton setTitleColor:[UIColor colorWithRGBHex:0x313131] forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor colorWithRGBHex:0xfc7c26] forState:UIControlStateHighlighted];
        
        [_cancelButton setTitle:L(@"Cancel") forState:UIControlStateNormal];
        _cancelButton.titleEdgeInsets = UIEdgeInsetsMake(1, 1, 0, 0);
        
        _cancelButton.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:16.0];
//        [_cancelButton setTitleColor:[UIColor colorWithRGBHex:0x825201] forState:UIControlStateNormal];
        _cancelButton.titleLabel.shadowOffset = CGSizeZero;
        _cancelButton.hidden = YES;
        
        _cancelButton.tag = 100;
        [_cancelButton addTarget:self action:@selector(hideSearchBar:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}


#pragma mark -
#pragma mark  method

- (void)readerBegin
{
    if (_readerDelegate && [_readerDelegate respondsToSelector:@selector(beginReaderZBar)]) {
        [_readerDelegate beginReaderZBar];
        [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",@"840102"], nil]];
    }
}


//显示搜索框
- (void)showSearchBar
{
    self.readerButton.alpha = 0.0f;
    
    self.searchImgBtn.hidden = YES;
    
    self.cancelButton.hidden = NO;
    
    self.wholeImageView.alpha = 1.0f;
 
    self.searchTextField.frame = CGRectMake(22 + 60, 11, 210 - 30, 22);
}

-(void)hideSearchBar:(UIButton *)button
{
   [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",@"840602"], nil]];
    self.cancelButton.hidden = YES;
    
    [self.searchTextField resignFirstResponder];
    
    self.searchTextField.text = @"";
    
    self.searchImgBtn.hidden = NO;

    self.readerButton.alpha = 1.0;
    
    self.searchTextField.frame = CGRectMake(45 + 60, 11, 210 - 30 - 18, 22);
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)resignFirstResponder
{
    //[self.searchTextField resignFirstResponder];
    return [super resignFirstResponder];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    textField.placeholder = [[DefaultKeyWordManager defaultManager] randomSearchPlaceholder];
    if ([_readerDelegate respondsToSelector:@selector(searchFieldShouldBeginEditing:)])
    {
        return [_readerDelegate searchFieldShouldBeginEditing:textField];
    }
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    NSLog(@"textFieldShouldEndEditing");
    if ([_readerDelegate respondsToSelector:@selector(searchFieldShouldEndEditing:)]) {
        return [_readerDelegate searchFieldShouldEndEditing:textField];
    }
    return YES;
}

- (void)textFieldDidChangeText:(UITextField *)textField
{
    NSLog(@"textField.text %@", textField.text);
    
//    if (![self.lastestSearchStr isEqualToString:textField.text] && textField.text && textField.text.length > 0)
//    {
//        self.lastestSearchStr = textField.text;
//        if ([_readerDelegate respondsToSelector:@selector(searchBar:textDidChange:)]) {
//            [_readerDelegate searchBar:textField textDidChange:self.lastestSearchStr];
//        }
//    }
    
    if (![self.lastestSearchStr isEqualToString:textField.text])
    {
        self.lastestSearchStr = textField.text;
        if ([_readerDelegate respondsToSelector:@selector(searchBar:textDidChange:)]) {
            [_readerDelegate searchBar:textField textDidChange:self.lastestSearchStr];
        }
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([textField.text isEqualToString:textField.placeholder]) {
        textField.text = @"";
//        textField.placeholder =  [SNSwitch randomSearchPlaceholder];
        textField.placeholder = [[DefaultKeyWordManager defaultManager] randomSearchPlaceholder];
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([_readerDelegate respondsToSelector:@selector(searchFieldSearchButtonClicked:)]) {
        searchTitle = @"ds";
        [_readerDelegate searchFieldSearchButtonClicked:textField];
    }
//    [textField resignFirstResponder];
    return YES;
    
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
//    textField.placeholder = [SNSwitch randomSearchPlaceholder];
    textField.placeholder = [[DefaultKeyWordManager defaultManager] randomSearchPlaceholder];
    return YES;
}

@end
