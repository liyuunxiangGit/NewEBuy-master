//
//  SearchNavigationBar.m
//  SuningEBuy
//
//  Created by chupeng on 14-7-15.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "SearchNavigationBar.h"
#import "ChooseSearchTypeView.h"

@implementation SearchNavigationBar

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (IOS7_OR_LATER)
        {
            [self setBackgroundImage:[UIImage imageWithColor:RGBCOLOR(247, 247, 248) size:CGSizeMake(320, 44)] forBarMetrics:UIBarMetricsDefault];
            self.translucent = YES;
            
            self.shadowImage = [UIImage imageWithColor:[UIColor colorWithRGBHex:0xdcdcdc] size:CGSizeMake(320, 1)];
            
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
            view.clipsToBounds = NO;
            view.backgroundColor = [UIColor clearColor];
            [view addSubview:self.navLeftBtn];
            [view addSubview:self.searchTextField];
            [view addSubview:self.filterButton];
            [view addSubview:self.searchCancelButton];
            [view addSubview:self.zxingBtn];
            [self.searchCancelButton setHidden:YES];
            self.filterButton.hidden = YES;

            [self addSubview:view];
        }
        else
        {
            self.translucent = NO;
            
            UIImage *image = [UIImage imageWithColor:RGBCOLOR(247, 247, 248) size:CGSizeMake(320, 44)];
            
            if ([self respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
            {
                [self setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
            }
            else
            {
                self.layer.contents = (id)image.CGImage;
            }

            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
            view.backgroundColor = [UIColor clearColor];
            [view addSubview:self.navLeftBtn];
            [view addSubview:self.searchTextField];
            [view addSubview:self.filterButton];
            [view addSubview:self.searchCancelButton];
            [view addSubview:self.zxingBtn];
            [self.searchCancelButton setHidden:YES];
            self.filterButton.hidden = YES;
            
            [self addSubview:view];
        }
        
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

- (UIButton *)navLeftBtn
{
    if (!_navLeftBtn)
    {
        _navLeftBtn = [[UIButton alloc] init];
        if (IOS7_OR_LATER)
        {
            _navLeftBtn.frame = CGRectMake(0, 0, 41, 41);
        }
        else
        {
            _navLeftBtn.frame = CGRectMake(0, 0, 41, 41);
        }
        _navLeftBtn.tag = 100;
       
        [_navLeftBtn addTarget:self action:@selector(backForePage) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIButton *btnForeGround = [[UIButton alloc] init];
        btnForeGround.frame = CGRectMake(15, 10, 12, 20);
        [btnForeGround setImage:[UIImage imageNamed:@"nav_back_normal.png"] forState:UIControlStateNormal];
        [btnForeGround setImage:[UIImage imageNamed:@"nav_back_select.png"] forState:UIControlStateHighlighted];
        [btnForeGround addTarget:self action:@selector(backForePage) forControlEvents:UIControlEventTouchUpInside];
        
        [_navLeftBtn addSubview:btnForeGround];
        
    }
    return _navLeftBtn;
}

- (SearchTextField *)searchTextField
{
    if (!_searchTextField)
    {
        _searchTextField = [[SearchTextField alloc] init];
        _searchTextField.placeholder = L(@"Search_SearchGoodAndStore");
        _searchTextField.editingRect = CGRectMake(27, 0, 155 - 10, 30);
        _searchTextField.clearButtonRect = CGRectMake(177 - 10, 0, 20, 30);
        _searchTextField.borderRect = CGRectMake(0, 0, 212, 30);
        _searchTextField.leftViewRect = CGRectMake(5, 6, 22, 17);
        UIImageView *imgIconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
        imgIconView.image = [UIImage imageNamed:@"Search_ZoomInIcon"];
        imgIconView.contentMode = UIViewContentModeBottomLeft;
        _searchTextField.leftView = imgIconView;
        _searchTextField.leftViewMode = UITextFieldViewModeAlways;
        
        if (IOS7_OR_LATER)
        {
            _searchTextField.frame = CGRectMake(42, 7, 212, 30);
        }
        else
            _searchTextField.frame = CGRectMake(42, 7, 212, 30);
        
        _searchTextField.layer.borderWidth = 0.5;
        _searchTextField.layer.borderColor = [UIColor colorWithRGBHex:0xd8d8d8].CGColor;
        _searchTextField.layer.cornerRadius = 1;
        _searchTextField.layer.masksToBounds = YES;
        _searchTextField.backgroundColor = [UIColor whiteColor];
        _searchTextField.font = [UIFont systemFontOfSize:14.0];
        _searchTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _searchTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _searchTextField.returnKeyType = UIReturnKeySearch;
        _searchTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        _searchTextField.delegate = self;
        _searchTextField.textColor = RGBCOLOR(74, 74, 74);
        [_searchTextField addTarget:self action:@selector(beginSearch:) forControlEvents:UIControlEventEditingDidEndOnExit];
        [_searchTextField addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
        _searchTextField.tag = 101;
        
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
    [VoiceSearchViewController sharedVoiceSearchCtrl].from = From_ShopSearch;
    [[VoiceSearchViewController sharedVoiceSearchCtrl] showVoiceSearchView];
    
    [self.searchTextField resignFirstResponder];
}
- (UIButton *)filterButton
{
    if (!_filterButton)
    {
        if (IOS7_OR_LATER)
        {
            _filterButton = [[UIButton alloc] initWithFrame:CGRectMake(264, 7, 48, 30)];
        }
        else
        {
            _filterButton = [[UIButton alloc] initWithFrame:CGRectMake(264, 7, 48, 30)];
        }
        
        [_filterButton setTitle:L(@"Filter") forState:UIControlStateNormal];
        _filterButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_filterButton setTitleColor:[UIColor colorWithRGBHex:0x313131] forState:UIControlStateNormal];
        [_filterButton setTitleColor:[UIColor colorWithRGBHex:0xfc7c26] forState:UIControlStateHighlighted];
        _filterButton.backgroundColor = [UIColor clearColor];
        _filterButton.adjustsImageWhenHighlighted = YES;
        [_filterButton addTarget:self action:@selector(showFilterView:) forControlEvents:UIControlEventTouchUpInside];
        _filterButton.tag = 102;
    }
    return _filterButton;
}

- (UIButton*)searchCancelButton
{
    if (!_searchCancelButton)
    {
        if (IOS7_OR_LATER)
        {
            _searchCancelButton = [[UIButton alloc] initWithFrame:CGRectMake(264, 7, 48, 30)];
        }
        else
        {
            _searchCancelButton = [[UIButton alloc] initWithFrame:CGRectMake(264, 7, 48, 30)];
        }
        
        //        _searchCancelButton.layer.borderWidth = 1;
        //        _searchCancelButton.layer.borderColor = RGBCOLOR(120, 120, 120).CGColor;
        [_searchCancelButton setTitle:L(@"Cancel") forState:UIControlStateNormal];
        _searchCancelButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_searchCancelButton setTitleColor:[UIColor colorWithRGBHex:0x313131] forState:UIControlStateNormal];
        [_searchCancelButton setTitleColor:[UIColor btnTitleHotColor] forState:UIControlStateHighlighted];
        //[_searchCancelButton setBackgroundImage:[UIImage imageNamed:@"searchlist_filterBtnBack"] forState:UIControlStateNormal];
        _searchCancelButton.backgroundColor = [UIColor clearColor];
        [_searchCancelButton addTarget:self action:@selector(cancelSearch:) forControlEvents:UIControlEventTouchUpInside];
        _searchCancelButton.tag = 103;
    }
    return _searchCancelButton;
}

- (UIButton *)zxingBtn
{
    if (!_zxingBtn)
    {
        _zxingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _zxingBtn.frame = CGRectMake(264 , 7, 35, 35);
        
        //[readerButton_ setImage:[UIImage imageNamed:@"QR_code.png"] forState:UIControlStateNormal];
        
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(2.5, 2.5, 31, 28)];
        imgV.userInteractionEnabled = NO;
        imgV.image = [UIImage imageNamed:@"Newhome_QR_code.png"];
        
        [_zxingBtn addSubview:imgV];
        
        [_zxingBtn addTarget:self action:@selector(readerBegin) forControlEvents:UIControlEventTouchUpInside];
        
        _zxingBtn.hidden = YES;
    }
    return _zxingBtn;
}

- (UIButton *)searchTypeBtn
{
    if (!_searchTypeBtn)
    {
        if (!_searchTypeBtn)
        {
            _searchTypeBtn = [[UIButton alloc] init];
            _searchTypeBtn.frame = CGRectMake(6, 7, 60, 28);
            
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
            //            _searchTypeBtn.titleEdgeInsets = UIEdgeInsetsMake(1, 1, 0, 0);
            
            _searchTypeBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
            
            _searchTypeBtn.hidden = YES;
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



- (void)showButtons:(BUTTONSSTATE)state
{
    switch (state) {
        case SearchResultState:
        {
            self.navLeftBtn.hidden = NO;
            self.filterButton.hidden = YES;
            self.searchCancelButton.hidden = YES;
            self.zxingBtn.hidden = YES;
            self.searchTypeBtn.hidden = YES;
            
            self.searchTextField.left = 42;
            self.searchTextField.width = 262;
            break;
        }
        case SearchShowingSearchTypeState:
        {
            self.navLeftBtn.hidden = YES;
            self.filterButton.hidden = YES;
            self.searchCancelButton.hidden = NO;
            self.zxingBtn.hidden = YES;
            self.searchTypeBtn.hidden = NO;
            
            self.searchTextField.left = 70;
            self.searchTextField.width = 192;
            
            break;
        }
        case SearchNoResultState:
        {
            self.navLeftBtn.hidden = NO;
            self.filterButton.hidden = YES;
            self.searchCancelButton.hidden = YES;
            self.zxingBtn.hidden = NO;
            self.searchTypeBtn.hidden = YES;
            
            self.searchTextField.left = 42;
            self.searchTextField.width = 212;
            break;
        }
        default:
            break;
    }
}

#pragma mark -  Delegate Methods

- (void)backForePage
{
    if ([self.customSearchNavBarDelegate respondsToSelector:@selector(backForePage)])
    {
        [self.customSearchNavBarDelegate backForePage];
    }
}

- (void)showFilterView:(id)sender
{
    if ([self.customSearchNavBarDelegate respondsToSelector:@selector(showFilterView:)])
    {
        [self.customSearchNavBarDelegate showFilterView:nil];
    }
}

- (void)cancelSearch:(id)sender
{
    if ([self.customSearchNavBarDelegate respondsToSelector:@selector(cancelSearch:)])
    {
        [self.customSearchNavBarDelegate cancelSearch:nil];
    }
}

- (void)readerBegin
{
    if ([self.customSearchNavBarDelegate respondsToSelector:@selector(readerBegin)])
    {
        [self.customSearchNavBarDelegate readerBegin];
    }
}

#pragma mark - Search Textfiled Delegate Methods

- (void)beginSearch:(id)sender
{
    if ([self.customSearchNavBarDelegate respondsToSelector:@selector(beginSearch:)])
    {
        [self.customSearchNavBarDelegate beginSearch:self.searchTextField.text];
    }
}

- (void)textChanged:(id)sender
{
    if ([self.customSearchNavBarDelegate respondsToSelector:@selector(textChanged:)])
    {
        [self.customSearchNavBarDelegate textChanged:self.searchTextField.text];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.filterButton.hidden = YES;
    self.searchCancelButton.hidden = NO;
    self.zxingBtn.hidden = YES;
    self.searchTextField.leftView.hidden = YES;
    self.searchTextField.editingRect = CGRectMake(7, 0, 165, 30);
    
    if ([self.customSearchNavBarDelegate respondsToSelector:@selector(textFieldShouldBeginEditing:)])
    {
        return [self.customSearchNavBarDelegate textFieldShouldBeginEditing:self.searchTextField];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([self.customSearchNavBarDelegate respondsToSelector:@selector(textFieldDidBeginEditing:)])
    {
        [self.customSearchNavBarDelegate textFieldDidBeginEditing:self.searchTextField];
    }
    
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    self.filterButton.hidden = NO;
    self.searchCancelButton.hidden = YES;
    self.zxingBtn.hidden = YES;
    self.searchTextField.leftView.hidden = NO;
    self.searchTextField.editingRect = CGRectMake(27, 0, 155 - 10, 30);

    if ([self.customSearchNavBarDelegate respondsToSelector:@selector(textFieldShouldEndEditing:)])
    {
        return [self.customSearchNavBarDelegate textFieldShouldEndEditing:self.searchTextField];
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([self.customSearchNavBarDelegate respondsToSelector:@selector(textFieldDidEndEditing:)])
    {
        [self.customSearchNavBarDelegate textFieldDidEndEditing:self.searchTextField];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([self.customSearchNavBarDelegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)])
    {
        return [self.customSearchNavBarDelegate textField:self.searchTextField shouldChangeCharactersInRange:range replacementString:string];
    }
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    if ([self.customSearchNavBarDelegate respondsToSelector:@selector(textFieldShouldClear:)])
    {
        return [self.customSearchNavBarDelegate textFieldShouldClear:self.searchTextField];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([self.customSearchNavBarDelegate respondsToSelector:@selector(textFieldShouldReturn:)])
    {
        return [self.customSearchNavBarDelegate textFieldShouldReturn:self.searchTextField];
    }
    return YES;
}


@end
