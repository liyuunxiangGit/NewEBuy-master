//
//  MoreView.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-8-28.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "MoreView.h"

@implementation MoreView

@synthesize soundSwith = _soundSwith;
@synthesize cityLabel = _cityLabel;
@synthesize versionLabel = _versionLabel;
@synthesize imageMemoryLabel=_imageMemoryLabel; 
@synthesize clearMemoryBtn=_clearMemoryBtn;
@synthesize addressPickerView = _addressPickerView;
@synthesize callWebView = _callWebView;


- (void)dealloc {
    TT_RELEASE_SAFELY(_soundSwith);
    TT_RELEASE_SAFELY(_cityLabel);
    TT_RELEASE_SAFELY(_versionLabel);
    TT_RELEASE_SAFELY(_imageMemoryLabel); 
    TT_RELEASE_SAFELY(_clearMemoryBtn);
    _addressPickerView.addressDelegate = nil;
    TT_RELEASE_SAFELY(_addressPickerView);
    TT_RELEASE_SAFELY(_callWebView);
}

- (id)initWithOwner:(id)owner
{
    self = [super initWithOwner:owner];
    if (self) {
        CGRect frame = [[UIScreen mainScreen] bounds];
        self.frame = frame;
        
        frame.size.height = frame.size.height-kUINavigationBarFrameHeight-kUITabBarFrameHeight-kStatusBarHeight;
        self.groupTableView.frame = frame;
        [self addSubview:self.groupTableView];
    }
    return self;
}

- (UISwitch *)soundSwith
{
    if (!_soundSwith) {
        _soundSwith = [[UISwitch alloc] init];
        _soundSwith.on = [[Config currentConfig].isSoundOn boolValue];
        [_soundSwith addTarget:self action:@selector(soundControl:) forControlEvents:UIControlEventValueChanged];
    }
    return _soundSwith;
}

- (UILabel *)cityLabel
{
    if (!_cityLabel) {
        _cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(125, 9, 150, 26)];
        _cityLabel.textAlignment = UITextAlignmentRight;
        _cityLabel.backgroundColor = [UIColor clearColor];
        _cityLabel.font = [UIFont boldSystemFontOfSize:15.0];
        _cityLabel.textColor = [UIColor dark_Gray_Color];
        
    }
    return _cityLabel;
}

//add by wangjiaxing 20120802
- (UILabel *)imageMemoryLabel
{
    if (!_imageMemoryLabel) {
        _imageMemoryLabel=[[UILabel alloc] initWithFrame:CGRectMake(140, 9, 135, 26)];
        _imageMemoryLabel.textAlignment = UITextAlignmentRight;
        _imageMemoryLabel.backgroundColor = [UIColor clearColor];
        _imageMemoryLabel.font = [UIFont boldSystemFontOfSize:15.0];
        _imageMemoryLabel.textColor = [UIColor dark_Gray_Color];
        
    }
    return _imageMemoryLabel;
}

- (UIButton *)clearMemoryBtn
{
    if (!_clearMemoryBtn) {
        _clearMemoryBtn=[[UIButton alloc] initWithFrame:CGRectMake(195, 9, 60, 30)];
        _clearMemoryBtn.backgroundColor=[UIColor clearColor];
        [_clearMemoryBtn setTitle:L(@"BTClear") forState:UIControlStateNormal];
        _clearMemoryBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
        [_clearMemoryBtn setTitleColor:[UIColor colorWithRGBHex:0x333333] forState:UIControlStateNormal];
        [_clearMemoryBtn setBackgroundImage:[UIImage imageNamed:@"right_item_light_btn.png"] forState:UIControlStateNormal];
        [_clearMemoryBtn addTarget:self action:@selector(clearImageMemory:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _clearMemoryBtn;
}

- (ToolBarButton *)addressBtn{
    if (!_addressBtn) {
        _addressBtn = [[ToolBarButton alloc] initWithFrame:CGRectMake(195, 9, 60, 30)];
        _addressBtn.backgroundColor = [UIColor clearColor];
        [_addressBtn setTitleColor:[UIColor colorWithRGBHex:0x333333] forState:UIControlStateNormal];
        _addressBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
        _addressBtn.delegate = self.owner;
        [_addressBtn setBackgroundImage:[UIImage imageNamed:@"right_item_light_btn.png"] forState:UIControlStateNormal];
    }
    return _addressBtn;
}

- (UILabel *)versionLabel
{
    if (!_versionLabel) {
        _versionLabel = [[UILabel alloc] initWithFrame:CGRectMake(125, 9, 150, 26)];
        _versionLabel.textAlignment = UITextAlignmentRight;
        _versionLabel.backgroundColor = [UIColor clearColor];
        _versionLabel.font = [UIFont boldSystemFontOfSize:15.0];
        _versionLabel.textColor = [UIColor darkGrayColor];
        _versionLabel.text = [NSString stringWithFormat:@"%@: %@",L(@"Version"),[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
    }
    return _versionLabel;
}

- (AddressInfoPickerView *)addressPickerView
{
    if (!_addressPickerView) {
        AddressInfoDTO *address = [[AddressInfoDTO alloc] init];
        address.province = [Config currentConfig].defaultProvince;
        address.city = [Config currentConfig].defaultCity;
        _addressPickerView = [[AddressInfoPickerView alloc] initWithBaseAddressInfo:address compentCount:AddressPickerViewCompentTwo];
        _addressPickerView.showsSelectionIndicator = YES;
        _addressPickerView.addressDelegate = self.owner;
    }
    return _addressPickerView;
}

- (UIWebView *)callWebView
{
    if (!_callWebView) {
        _callWebView = [[UIWebView alloc] init];
    }
    return _callWebView;
}

- (void)soundControl:(id)sender
{
    if ([self.owner respondsToSelector:@selector(soundControl:)]) {
        [self.owner soundControl:sender];
    }
}

- (void)clearImageMemory:(id)sender
{
    if ([self.owner respondsToSelector:@selector(clearImageMemory:)]) {
        [self.owner clearImageMemory:sender];
    }
}

@end
