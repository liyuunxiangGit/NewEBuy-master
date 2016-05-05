//
//  xingChengDanItemCell.m
//  SuningEBuy
//
//  Created by xy ma on 12-5-11.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import "xingChengDanItemCell.h"
#import "OrderSubmitRootViewController.h"

#define  leftPadding    15
#define  topPadding     40


@implementation xingChengDanItemCell

@synthesize xingchengdanLbl = _xingchengdanLbl;
@synthesize whiteBackView = _whiteBackView;
@synthesize nameLbl = _nameLbl;
@synthesize addressLbl = _addressLbl;
@synthesize phoneLbl = _phoneLbl;
@synthesize peiSongInfoLbl = _peiSongInfoLbl;

@synthesize changeAddressBtn =_changeAddressBtn;
@synthesize choosePickerView = _choosePickerView;
@synthesize pickerData = _pickerData;
@synthesize addressDto = _addressDto;
@synthesize controller = _controller;
@synthesize alertLbl = _alertLbl;
@synthesize chooseXCDButton = _chooseXCDButton;
@synthesize addressType = _addressType;

//初始化
- (id) initWithReuseIdentifier:(NSString *)reuseIdentifier{
	self = [super initWithReuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.backgroundView = nil;
        self.backgroundColor = [UIColor clearColor];
        
        //初始化pickerView的数据
        if (!_pickerData)
        {
            _pickerData = [[NSArray alloc] initWithObjects:
                           
                           [[NSDictionary alloc] initWithObjectsAndKeys:
                             L(@"BTDoNotNeedReimburseProof"), @"title",
                             L(@"BTFriendlyRemindOne"), @"message",
                             @"1", @"value", nil],
                           
                           [[NSDictionary alloc] initWithObjectsAndKeys:
                             L(@"BTTakeSelfForFree"), @"title",
                             L(@"BTFriendlyRemindTwo"), @"message",
                             @"2", @"value", nil],
                           
                           [[NSDictionary alloc] initWithObjectsAndKeys:
                             L(@"BTSuningDistributionForFree"), @"title",
                             L(@"BTMailTravelListForFree"), @"message",
                             @"3", @"value", nil],
                           
                           nil];
            
        }
        
        [self addObserver:self
               forKeyPath:@"addressType"
                  options:NSKeyValueObservingOptionNew
                  context:nil];
    }
    
	return self;
}


-(void)dealloc{
    
    [self removeObserver:self forKeyPath:@"addressType"];
    
    TT_RELEASE_SAFELY(_xingchengdanLbl);
    TT_RELEASE_SAFELY(_whiteBackView);
    TT_RELEASE_SAFELY(_nameLbl);
	
	TT_RELEASE_SAFELY(_addressLbl);
	
	TT_RELEASE_SAFELY(_phoneLbl);
    
    TT_RELEASE_SAFELY(_peiSongInfoLbl);
    
    TT_RELEASE_SAFELY(_changeAddressBtn);
    TT_RELEASE_SAFELY(_choosePickerView);
    TT_RELEASE_SAFELY(_pickerData);
    TT_RELEASE_SAFELY(_chooseXCDButton);
    
    TT_RELEASE_SAFELY(_addressDto);
        
    TT_RELEASE_SAFELY(_alertLbl);
    TT_RELEASE_SAFELY(_addressType);
    
    
}

+ (CGFloat)height:(NSString *)addressType
{
    int i = [addressType intValue];
    switch (i) {
        case 1:
        {
            return 120+topPadding;
            break;
        }
        case 2:
        {
            return 100+topPadding;
            break;
        }
        case 3:
        {
            return 240+topPadding;
            break;
        }
        default:
            break;
    }
    return 90;
}


- (void) setItem:(AddressInfoDTO *)addrDto
{
    if (addrDto != _addressDto) {
		
		
		_addressDto = addrDto;
        
        
        NSString *namel = [NSString stringWithFormat:@"%@ %@",L(@"BTName"),
                           _addressDto.recipient?_addressDto.recipient:@""];
		self.nameLbl.text = namel;
        
        
        NSString *addre = [NSString stringWithFormat:@"%@ %@%@%@%@",L(@"BTAddress"),
                            _addressDto.provinceContent?_addressDto.provinceContent:@"",_addressDto.cityContent?_addressDto.cityContent:@"",_addressDto.districtContent?_addressDto.districtContent:@"",_addressDto.addressContent?_addressDto.addressContent:@""];
        
		self.addressLbl.text = addre;
        
        NSString *phonel = [NSString stringWithFormat:@"%@ %@",L(@"tel"),
                           _addressDto.tel?_addressDto.tel:@""];
		self.phoneLbl.text = phonel;
        
		
	}
    
    [self setNeedsLayout];
}


-(void) layoutSubviews{
	
	[super layoutSubviews];
    
    self.xingchengdanLbl.frame = CGRectMake(leftPadding, 10, 200, 25);
    NSInteger type = [self.addressType intValue];
    if (type == 1) {
        self.whiteBackView.frame = CGRectMake(0, topPadding, 320, 120);
    }else if (type == 2){
        self.whiteBackView.frame = CGRectMake(0, topPadding, 320, 100);
    }else if (type == 3){
        self.whiteBackView.frame = CGRectMake(0, topPadding, 320, 240);
    }else{
        self.whiteBackView.frame = CGRectMake(0, topPadding, 320, 90);
    }
    
    CGSize detailMsgSize = CGSizeZero;
    
    detailMsgSize = [self.alertLbl.text heightWithFont:[UIFont boldSystemFontOfSize:14.0] 
                                                 width:280 
                                             linebreak:UILineBreakModeWordWrap];

    self.chooseXCDButton.frame = CGRectMake(leftPadding, 11+topPadding, (320-2*leftPadding), 30);

    self.alertLbl.frame = CGRectMake(leftPadding, 43+topPadding, 290, detailMsgSize.height);
    
    self.peiSongInfoLbl.frame = CGRectMake(leftPadding, 65+detailMsgSize.height+topPadding, 90, 40);
    self.changeAddressBtn.frame = CGRectMake(210, 65+detailMsgSize.height+topPadding, 100, 36);
	self.nameLbl.frame = CGRectMake(leftPadding, 115+detailMsgSize.height+topPadding, 300, 20);
	self.addressLbl.frame = CGRectMake(leftPadding, 145+detailMsgSize.height+topPadding, 300, 20);
    self.phoneLbl.frame = CGRectMake(leftPadding, 175+detailMsgSize.height+topPadding, 300, 20);
   
    [self.contentView sendSubviewToBack:self.whiteBackView];

}


#pragma mark  -
#pragma mark UIView

-(UILabel *)xingchengdanLbl{
    if (_xingchengdanLbl == nil) {
        _xingchengdanLbl = [[UILabel alloc]init];
        _xingchengdanLbl.backgroundColor = [UIColor clearColor];
        _xingchengdanLbl.font = [UIFont systemFontOfSize:14.0];
        _xingchengdanLbl.text = L(@"BTChooseTravelList");
        [self.contentView addSubview:_xingchengdanLbl];
    }
    return _xingchengdanLbl;
}

-(UIView *)whiteBackView{
    if (!_whiteBackView) {
        _whiteBackView  = [[UIView alloc]init];
        _whiteBackView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_whiteBackView];
    }
    return _whiteBackView;
}


-(UILabel *) nameLbl{
	
	if (!_nameLbl) {
		
		UIFont *font = [UIFont systemFontOfSize:14];
		
		CGSize size = [@"a" sizeWithFont:font];
		
		_nameLbl = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, 5, 60, size.height)];
		
		_nameLbl.backgroundColor = [UIColor clearColor];
		
		_nameLbl.font = font;
		
		_nameLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_nameLbl];
        
	}	
	return _nameLbl;
}

-(UILabel *) addressLbl{
	
	if (!_addressLbl) {
		
		UIFont *font = [UIFont systemFontOfSize:14];
		
		CGSize size = [@"a" sizeWithFont:font];
		
		_addressLbl = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, 5, 60, size.height)];
		
		_addressLbl.backgroundColor = [UIColor clearColor];
		
		_addressLbl.font = font;
		
		_addressLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_addressLbl];
	}
	return _addressLbl;
}

-(UILabel *) phoneLbl{
	
	if (!_phoneLbl) {
		
		UIFont *font = [UIFont systemFontOfSize:14];
		
		CGSize size = [@"a" sizeWithFont:font];
		
		_phoneLbl = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, 5, 60, size.height)];
		
		_phoneLbl.backgroundColor = [UIColor clearColor];
		
		_phoneLbl.font = font;
		
		_phoneLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_phoneLbl];
	}	
	return _phoneLbl;
}

-(UILabel *) peiSongInfoLbl{
	
	if (!_peiSongInfoLbl) {
		
		UIFont *font = [UIFont systemFontOfSize:18];
		
		CGSize size = [@"a" sizeWithFont:font];
		
		_peiSongInfoLbl = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, 5, 60, size.height)];		
		_peiSongInfoLbl.backgroundColor = [UIColor clearColor];
		
		_peiSongInfoLbl.font = font;
		_peiSongInfoLbl.text = L(@"BTDistributionInfo");
		_peiSongInfoLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_peiSongInfoLbl];
	}	
	return _peiSongInfoLbl;
}


- (UILabel *)alertLbl
{
	
	if (!_alertLbl) 
    {
		
		_alertLbl = [[UILabel alloc] init];
        
		_alertLbl.backgroundColor = [UIColor clearColor];
        
        _alertLbl.textColor = [UIColor grayColor];
		
        _alertLbl.numberOfLines = 0 ;
        _alertLbl.lineBreakMode = UILineBreakModeCharacterWrap;
		_alertLbl.font = [UIFont boldSystemFontOfSize:14];
        [self.contentView addSubview:_alertLbl];
        
    }
	
	return _alertLbl;
}



- (UIButton *)changeAddressBtn
{
    
    if (!_changeAddressBtn)
    {
        _changeAddressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_changeAddressBtn setTitle:L(@"BTChangeDistributionAddress") forState:UIControlStateNormal];
        
        [_changeAddressBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        _changeAddressBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        
        
        UIImage *buttonImageNormal = [UIImage imageNamed:@"orange_button.png"];
        UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:12 topCapHeight:0];
        [_changeAddressBtn setBackgroundImage:stretchableButtonImageNormal 
                                    forState:UIControlStateNormal];
        
        UIImage *buttonImagePressed = [UIImage imageNamed:@"orange_button_clicked.png"];
        UIImage *stretchableButtonImagePressed = [buttonImagePressed stretchableImageWithLeftCapWidth:12 topCapHeight:0];
        [_changeAddressBtn setBackgroundImage:stretchableButtonImagePressed forState:UIControlStateHighlighted];
        
        [_changeAddressBtn addTarget:self action:@selector(goToAddressList) forControlEvents:UIControlEventTouchUpInside];        
            
        
        [self.contentView addSubview:_changeAddressBtn];
        
    }
    return _changeAddressBtn;
}

- (void)goToAddressList
{    
    AddressInfoListViewController *_AddressInfoListViewController = [[AddressInfoListViewController alloc] init];
//    _AddressInfoListViewController.cellType = FromEbuy;
    _AddressInfoListViewController.cellType = FromShop;
    
    [self.controller.navigationController pushViewController:_AddressInfoListViewController animated:YES];
    
    TT_RELEASE_SAFELY(_AddressInfoListViewController);
}


#pragma mark -
#pragma mark Picker View and toolbar view

- (UIPickerView *)choosePickerView
{
    if (_choosePickerView == nil)
    {
        _choosePickerView = [[UIPickerView alloc] init];
        
        _choosePickerView.frame = CGRectMake(0, 40, 320, 240);
        
        _choosePickerView.delegate = self;
        
        _choosePickerView.dataSource = self;
        
        _choosePickerView.showsSelectionIndicator = YES;
        
        _choosePickerView.opaque = NO;
    }
    return _choosePickerView;
}


#pragma mark -
#pragma mark pickerView Delegate Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return [self.pickerData count];
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSDictionary *currDic = [self.pickerData objectAtIndex:row];
    
    return [currDic objectForKey:@"title"];
}

#pragma mark -
#pragma mark Actions

- (void)doneButtonClicked:(id)sender
{
    NSInteger amountRow = [self.choosePickerView selectedRowInComponent:0];
    
    NSDictionary *selectDic = [self.pickerData objectAtIndex:amountRow];
        
    NSString *value = [selectDic objectForKey:@"value"];
    
    self.addressType = value;
        
    [self.chooseXCDButton resignFirstResponder];
    
    [self.controller updateTable];

    return;
 
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"addressType"]) {
        
        self.controller.addressType = self.addressType;
        
        int addressTypeValue = [self.addressType intValue];
        
        if (addressTypeValue > 0 && addressTypeValue < 4) {
            
            NSDictionary *selectDic = [self.pickerData objectAtIndex:addressTypeValue-1];
            NSString *title = [selectDic objectForKey:@"title"];
            [self.chooseXCDButton setTitle:title forState:UIControlStateNormal];
            NSString *message = [selectDic objectForKey:@"message"];
            self.alertLbl.text = message;
            
            switch (addressTypeValue) {
                case 1:
                case 2:
                {
                    self.nameLbl.hidden = YES;
                    self.addressLbl.hidden = YES;
                    self.phoneLbl.hidden = YES;
                    self.peiSongInfoLbl.hidden = YES;
                    self.changeAddressBtn.hidden = YES;
                    break;
                }
                case 3:
                {
//                    [self.contentView addSubview:self.xingchengdanLbl];
//                    [self.contentView addSubview:self.whiteBackView];
//                    [self.contentView addSubview:self.chooseXCDButton];
//                    [self.contentView addSubview:self.alertLbl];
//                    [self.contentView addSubview:self.nameLbl];
//                    [self.contentView addSubview:self.addressLbl];
//                    [self.contentView addSubview:self.phoneLbl];
//                    [self.contentView addSubview:self.peiSongInfoLbl];
//                    [self.contentView addSubview:self.changeAddressBtn];
                    self.nameLbl.hidden = NO;
                    self.addressLbl.hidden = NO;
                    self.phoneLbl.hidden = NO;
                    self.peiSongInfoLbl.hidden = NO;
                    self.changeAddressBtn.hidden = NO;
                    break;
                }
                default:
                    break;
            }

        }
    
    }
}

- (void)cancelButtonClicked:(id)sender
{
    [self.chooseXCDButton resignFirstResponder];
    
    return;
}


- (ToolBarButton *)chooseXCDButton
{
    if (!_chooseXCDButton)
    {
        _chooseXCDButton = [[ToolBarButton alloc] initWithFrame:CGRectZero];
        
        _chooseXCDButton.delegate = self;
        
        _chooseXCDButton.backgroundColor = [UIColor clearColor];
        
        UIImage *image = [UIImage newImageFromResource:@"down_icon.png"];
        
        [_chooseXCDButton setBackgroundImage:image
                                    forState:UIControlStateNormal];
        
        [_chooseXCDButton setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 160)];
        
        _chooseXCDButton.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [_chooseXCDButton setTitleColor:[UIColor orange_Red_Color] forState:UIControlStateNormal];
        
        _chooseXCDButton.inputView = self.choosePickerView;
        
        [self.contentView addSubview:_chooseXCDButton];
        
    }
    return _chooseXCDButton;
}


@end
